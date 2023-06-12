Class {
	#name : #MySTONAlternativeRepresentationTestObject,
	#superclass : #Object,
	#instVars : [
		'id',
		'time',
		'gridReference'
	],
	#classVars : [
		'KnownObjects'
	],
	#category : #'MySTONWithLimitedReflection-Tests'
}

{ #category : #example }
MySTONAlternativeRepresentationTestObject class >> example [
	^ self new
		id: 1e9 atRandom;
		time: DateAndTime now;
		gridReference: 150.75@250.25;
		yourself
]

{ #category : #'ston persistence' }
MySTONAlternativeRepresentationTestObject >> fromSton: stonReader [
	stonReader parseMapDo: [ :key :value |
		key = #id ifTrue: [ self id: value ].
		key = #time ifTrue: [ self timeUTC: value ].
		key = #grid_reference ifTrue: [ self gridReferenceImperial: value ] ]
]

{ #category : #accessing }
MySTONAlternativeRepresentationTestObject >> gridReference [
	^ gridReference
]

{ #category : #accessing }
MySTONAlternativeRepresentationTestObject >> gridReference: value [
	gridReference := value
]

{ #category : #accessing }
MySTONAlternativeRepresentationTestObject >> gridReferenceImperial [
	^ gridReference / 1.609344
]

{ #category : #accessing }
MySTONAlternativeRepresentationTestObject >> gridReferenceImperial: value [
	gridReference := value * 1.609344
]

{ #category : #accessing }
MySTONAlternativeRepresentationTestObject >> id [
	^ id
]

{ #category : #accessing }
MySTONAlternativeRepresentationTestObject >> id: anObject [
	id := anObject
]

{ #category : #'ston persistence' }
MySTONAlternativeRepresentationTestObject >> stonOn: stonWriter [
	stonWriter writeObject: self streamMap: [ :dictionary |
		dictionary
			at: #id put: self id;
			at: #time put: self timeUTC;
			at: #grid_reference put: self gridReferenceImperial ]
]

{ #category : #accessing }
MySTONAlternativeRepresentationTestObject >> time [
	^ time
]

{ #category : #accessing }
MySTONAlternativeRepresentationTestObject >> time: anObject [
	time := anObject
]

{ #category : #accessing }
MySTONAlternativeRepresentationTestObject >> timeUTC [
	^ time asUTC
]

{ #category : #accessing }
MySTONAlternativeRepresentationTestObject >> timeUTC: value [
	time := value offset: TimeZone local offset
]
