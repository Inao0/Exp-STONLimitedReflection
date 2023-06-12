Class {
	#name : #MySTONTest,
	#superclass : #TestCase,
	#category : #'MySTONWithLimitedReflection-Tests'
}

{ #category : #utilities }
MySTONTest class >> fastReadFromFileNamed: path [
	^ path asFileReference
		readStreamDo: [ :stream |
			MySTON reader
				on: (ZnBufferedReadStream on: stream);
				optimizeForLargeStructures;
				next ]
]

{ #category : #utilities }
MySTONTest class >> fastWrite: object toFileNamed: path [
	^ path asFileReference
		writeStreamDo: [ :fileStream |
			ZnBufferedWriteStream
				on: fileStream
				do: [ :stream |
					MySTON writer
						on: stream;
						optimizeForLargeStructures;
						nextPut: object ] ]
]

{ #category : #utilities }
MySTONTest class >> readFromFileNamed: path [
	^ path asFileReference
		readStreamDo: [ :stream |
			MySTON reader
				on: stream;
				next ]
]

{ #category : #utilities }
MySTONTest class >> write: object toFileNamed: path [
	^ path asFileReference
		writeStreamDo: [ :stream |
			MySTON writer
				on: stream;
				nextPut: object ]
]

{ #category : #tests }
MySTONTest >> testAssociationClass [
	self assert: (MySTON fromString: '#foo : 100') class equals: MySTON associationClass
]

{ #category : #tests }
MySTONTest >> testClassNameKey [
	self
		assert: ((MySTON reader
							acceptUnknownClasses: true;
							on: 'FooBarBaz { #foo : 100 }' readStream;
							next) at: MySTON classNameKey)
		equals: #FooBarBaz
]

{ #category : #tests }
MySTONTest >> testFromString [
	| object |
	object := MySTON listClass withAll: {1 . 0 . -1 . true . false . nil}.
	self assert: (MySTON fromString: '[1,0,-1,true,false,nil]') equals: object
]

{ #category : #tests }
MySTONTest >> testFromStringWithComments [
	| object |
	object := MySTON listClass withAll: { 1. 0. -1. true. false. nil }.
	self
		assert: (MySTON fromStringWithComments: '// comment\[1, /* comment */ 0, -1, true, false, nil] // comment' withCRs)
		equals: object
]

{ #category : #tests }
MySTONTest >> testListClass [
	self assert: (MySTON fromString: '[1 , 2 , 3]') class equals: MySTON listClass
]

{ #category : #tests }
MySTONTest >> testMapClass [
	self assert: (MySTON fromString: '{ #foo : 1 , #bar : 2 }') class equals: MySTON mapClass
]

{ #category : #tests }
MySTONTest >> testPrettyPrinting [
	| object |
	object := STONTestUser dummy.
	self assert: (MySTON fromString: (MySTON toStringPretty: object)) equals: object.
	object := STONTestDomainObject dummy.
	self assert: (MySTON fromString: (MySTON toStringPretty: object)) equals: object
]

{ #category : #tests }
MySTONTest >> testRoomExitCycles [
	| model room1 room2 exit1 exit2 ston object |
	(room1 := STONTestMap new) at: #name put: 'Room 1'.
	(room2 := STONTestMap new) at: #name put: 'Room 2'.
	(exit1 := STONTestMap new)
		at: #name put: 'Exit 1';
		at: #origin put: room1;
		at: #destination put: room2.
	(exit2 := STONTestMap new)
		at: #name put: 'Exit 2';
		at: #origin put: room2;
		at: #destination put: room1.
	room1 at: #exit put: exit1.
	room2 at: #exit put: exit2.
	model := Array with: room1 with: room2.
	ston := MySTON toString: model.
	object := MySTON fromString: ston.
	"We can't just compare because this is a recursive datastructure"
	self assert: (object first at: #name) equals: 'Room 1'.
	self assert: (object second at: #name) equals: 'Room 2'.
	self assert: ((object first at: #exit) at: #name) equals: 'Exit 1'.
	self assert: ((object second at: #exit) at: #name) equals: 'Exit 2'.
	self assert: ((object first at: #exit) at: #origin) identicalTo: object first.
	self assert: ((object first at: #exit) at: #destination) identicalTo: object second.
	self assert: ((object second at: #exit) at: #origin) identicalTo: object second.
	self assert: ((object second at: #exit) at: #destination) identicalTo: object first.
	"Try writing again the parse model"
	self assert: (MySTON toString: object) equals: ston
]

{ #category : #tests }
MySTONTest >> testToString [
	| object |
	object := MySTON listClass withAll: {1 . 0 . -1 . true . false . nil}.
	self assert: (MySTON toString: object) equals: '[1,0,-1,true,false,nil]'
]
