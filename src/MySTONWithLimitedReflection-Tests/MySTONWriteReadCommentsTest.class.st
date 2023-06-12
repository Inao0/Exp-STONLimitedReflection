Class {
	#name : #MySTONWriteReadCommentsTest,
	#superclass : #MySTONWriteReadTest,
	#category : #'MySTONWithLimitedReflection-Tests'
}

{ #category : #private }
MySTONWriteReadCommentsTest >> materialize: string [
	^ MySTON reader
		on: (STONCStyleCommentsSkipStream on: string readStream);
		optimizeForLargeStructures;
		next
]

{ #category : #private }
MySTONWriteReadCommentsTest >> reader: string [
	^ MySTON reader
		on: (STONCStyleCommentsSkipStream on: string readStream);
		yourself
]

{ #category : #private }
MySTONWriteReadCommentsTest >> serialize: anObject [
	^ String streamContents: [ :stream |
		stream << '/* initial comment */'.
		MySTON writer
			on: stream;
			nextPut: anObject.
		stream << '/* final comment */' ]
]
