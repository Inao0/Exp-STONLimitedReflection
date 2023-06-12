Class {
	#name : #MySTONTestKnownObject,
	#superclass : #Object,
	#instVars : [
		'id',
		'description'
	],
	#classVars : [
		'KnownObjects'
	],
	#category : #'MySTONWithLimitedReflection-Tests'
}

{ #category : #accessing }
MySTONTestKnownObject class >> addKnownObject: object [
	^ self knownObjects addIfNotPresent: object
]

{ #category : #'instance creation' }
MySTONTestKnownObject class >> fromId: idString [
	"Given id, return a matching instance of me, either by returning an existing known instance or by creating a new one (that is automatically added to the known instances)"

	| uuid |
	uuid := UUID fromString: idString.
	^ self knownObjects
		detect: [ :each | each id = uuid ]
		ifNone: [ self new id: uuid ]
]

{ #category : #'ston-core' }
MySTONTestKnownObject class >> fromSton: stonReader [
	^ self fromId: stonReader parseListSingleton
]

{ #category : #accessing }
MySTONTestKnownObject class >> knownObjects [
	^ KnownObjects ifNil: [ KnownObjects := OrderedCollection new ]
]

{ #category : #accessing }
MySTONTestKnownObject class >> resetKnownObjects [
	KnownObjects ifNotNil: [ :collection | collection removeAll ]
]

{ #category : #comparing }
MySTONTestKnownObject >> = object [
	self class == object class ifFalse: [ ^ false ].
	^ self id = object id
]

{ #category : #accessing }
MySTONTestKnownObject >> description [
	^ description
]

{ #category : #initialization }
MySTONTestKnownObject >> description: string [
	description := string
]

{ #category : #comparing }
MySTONTestKnownObject >> hash [
	^ self id hash
]

{ #category : #accessing }
MySTONTestKnownObject >> id [
	^ id
]

{ #category : #initialization }
MySTONTestKnownObject >> id: uuid [
	id := uuid.
	self description: 'I am a complex object known under the ID ', id asString, ' - I was created @ ', DateAndTime now asString
]

{ #category : #initialization }
MySTONTestKnownObject >> initialize [
	super initialize.
	self id: UUID new.
	self class addKnownObject: self
]

{ #category : #printing }
MySTONTestKnownObject >> printOn: stream [
	super printOn: stream.
	stream nextPut: $(; print: id; nextPut: $)
]

{ #category : #'ston-core' }
MySTONTestKnownObject >> stonOn: stonWriter [
	"We only write out our id"

	stonWriter writeObject: self listSingleton: self id asString
]
