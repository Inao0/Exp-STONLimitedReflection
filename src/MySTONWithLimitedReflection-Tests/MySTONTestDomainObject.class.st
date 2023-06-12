Class {
	#name : #MySTONTestDomainObject,
	#superclass : #Object,
	#instVars : [
		'created',
		'modified',
		'integer',
		'float',
		'description',
		'color',
		'tags',
		'bytes',
		'boolean'
	],
	#category : #'MySTONWithLimitedReflection-Tests'
}

{ #category : #'instance creation' }
MySTONTestDomainObject class >> dummy [
	^ self new
		integer: 999999 atRandom;
		float: 999 atRandom / Float pi;
		boolean: #(true false) atRandom;
		bytes: (ByteArray streamContents: [ :out | 32 timesRepeat: [ out nextPut: 255 atRandom ] ]);
		description: (String streamContents: [ :out | 16 atRandom timesRepeat: [ out nextPutAll: 'Blah' ] ]);
		color: #(#red #green #blue) atRandom;
		tags: (Array
			with: #(#one #two #three) atRandom
 			with: #(#alpha #beta #gamma) atRandom
			with: #(#low #medium #high) atRandom);
		yourself
]

{ #category : #'ston-core' }
MySTONTestDomainObject class >> stonName [
	^ #TestDomainObject
]

{ #category : #comparing }
MySTONTestDomainObject >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ color = anObject color
		and: [
			modified = anObject modified
				and: [
					created = anObject created
						and: [
							description = anObject description
								and: [
									boolean = anObject boolean
										and: [
											(float closeTo: anObject float) 		"Use #closeTo: instead of #= to increase portability"
												and: [
													bytes = anObject bytes
														and: [
															integer = anObject integer
																and: [ tags = anObject tags ] ] ] ] ] ] ] ]
]

{ #category : #accessing }
MySTONTestDomainObject >> boolean [
	^ boolean
]

{ #category : #accessing }
MySTONTestDomainObject >> boolean: anObject [
	boolean := anObject
]

{ #category : #accessing }
MySTONTestDomainObject >> bytes [
	^ bytes
]

{ #category : #accessing }
MySTONTestDomainObject >> bytes: anObject [
	bytes := anObject
]

{ #category : #accessing }
MySTONTestDomainObject >> color [
	^ color
]

{ #category : #accessing }
MySTONTestDomainObject >> color: anObject [
	color := anObject
]

{ #category : #accessing }
MySTONTestDomainObject >> created [
	^ created
]

{ #category : #accessing }
MySTONTestDomainObject >> created: anObject [
	created := anObject
]

{ #category : #accessing }
MySTONTestDomainObject >> description [
	^ description
]

{ #category : #accessing }
MySTONTestDomainObject >> description: anObject [
	description := anObject
]

{ #category : #accessing }
MySTONTestDomainObject >> float [
	^ float
]

{ #category : #accessing }
MySTONTestDomainObject >> float: anObject [
	float := anObject
]

{ #category : #comparing }
MySTONTestDomainObject >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ color hash
		bitXor:
			(modified hash
				bitXor:
					(created hash
						bitXor:
							(description hash
								bitXor: (boolean hash bitXor: (float hash bitXor: (bytes hash bitXor: (integer hash bitXor: tags hash)))))))
]

{ #category : #initialization }
MySTONTestDomainObject >> initialize [
	created := modified := DateAndTime now
]

{ #category : #accessing }
MySTONTestDomainObject >> integer [
	^ integer
]

{ #category : #accessing }
MySTONTestDomainObject >> integer: anObject [
	integer := anObject
]

{ #category : #accessing }
MySTONTestDomainObject >> modified [
	^ modified
]

{ #category : #accessing }
MySTONTestDomainObject >> modified: anObject [
	modified := anObject
]

{ #category : #accessing }
MySTONTestDomainObject >> tags [
	^ tags
]

{ #category : #accessing }
MySTONTestDomainObject >> tags: anObject [
	tags := anObject
]
