Class {
	#name : #MySTONWriteReadTest,
	#superclass : #TestCase,
	#category : #'MySTONWithLimitedReflection-Tests'
}

{ #category : #private }
MySTONWriteReadTest >> environment [
	^ Smalltalk globals
]

{ #category : #private }
MySTONWriteReadTest >> materialize: string [
	^ MySTON reader
		on: string readStream;
		next
]

{ #category : #options }
MySTONWriteReadTest >> reader: string [
	^ MySTON reader on: string readStream
]

{ #category : #private }
MySTONWriteReadTest >> serialize: anObject [
	^ String streamContents: [ :stream |
		MySTON writer
			on: stream;
			nextPut: anObject ]
]

{ #category : #private }
MySTONWriteReadTest >> serializeAndMaterialize: object [
	| serialization materialization |
	serialization := self serialize: object.
	materialization := self materialize: serialization.
	self assert: object equals: materialization
]

{ #category : #private }
MySTONWriteReadTest >> serializeAndMaterializeJsonMode: object [
	| serialization materialization |
	serialization := self serializeJson: object.
	materialization := self materialize: serialization.
	self assert: object equals: materialization
]

{ #category : #private }
MySTONWriteReadTest >> serializeJson: anObject [
	^ String streamContents: [ :stream |
		MySTON jsonWriter
			on: stream;
			nextPut: anObject ]
]

{ #category : #tests }
MySTONWriteReadTest >> testAlternativeRepresentation [
	| testObject resultObject |
	testObject := STONAlternativeRepresentationTestObject example.
	"See the class comment of STONAlternativeRepresentationTestObject
	for a description of how the internal and external representation differ.
	See also STONAlternativeRepresentationTestObject>>#stonOn:
	and STONAlternativeRepresentationTestObject>>#fromSton:"
	resultObject := self materialize: (self serialize: testObject).
	self assert: resultObject id equals: testObject id.
	self assert: resultObject time equals: testObject time.
	self assert: (resultObject gridReference x closeTo: testObject gridReference x).
	self assert: (resultObject gridReference y closeTo: testObject gridReference y)
]

{ #category : #tests }
MySTONWriteReadTest >> testAssociations [
	| associations |
	associations := OrderedCollection new.
	1 to: 10 do: [ :each |
		associations add: each -> each printString ].
	self serializeAndMaterialize: associations
]

{ #category : #tests }
MySTONWriteReadTest >> testCharacters [
	| characters |
	characters := MySTON listClass withAll: ($a to: $z), ($A to: $Z).
	self serializeAndMaterialize: characters
]

{ #category : #tests }
MySTONWriteReadTest >> testClasses [
	| classes |
	classes := MySTON listClass withAll: { Point. Integer. Object }.
	self serializeAndMaterialize: classes.
	classes := MySTON listClass withAll: { Point class. Integer class. Object class }.
	self serializeAndMaterialize: classes.
	classes := MySTON listClass withAll: { Class. Metaclass. Class class. Point class class }.
	self serializeAndMaterialize: classes
]

{ #category : #tests }
MySTONWriteReadTest >> testCollections [
	| collections |
	collections := MySTON listClass withAll: {
		#(1 2 3).
		OrderedCollection withAll: #(1 2 3).
		Set withAll: #(1 2 3).
		Bag withAll: #(1 2 2 3).
		Dictionary new at: 1 put: 1; at: 2 put: 2; yourself.
		#[1 2 3].
		#(1 2 3) asIntegerArray.
		#(1 2 3) asFloatArray }.
	self serializeAndMaterialize: collections
]

{ #category : #tests }
MySTONWriteReadTest >> testCollectionsStructured [
	| collections one two |
	one := 1@2.
	two := 2@3.
	collections := MySTON listClass withAll: {
	 	Bag withAll: { one. two. one. two. one }.
	 	Set withAll: { one. two. one. two. one }.
	 	OrderedCollection withAll: { one. two. one. two. one }.
	}.
	self serializeAndMaterialize: collections
]

{ #category : #tests }
MySTONWriteReadTest >> testColors [
	| colors |
	colors := MySTON listClass withAll: {
		Color red.
		Color red copy setAlpha: 0.4.
		Color red lighter lighter }.
	self serializeAndMaterialize: colors
]

{ #category : #tests }
MySTONWriteReadTest >> testCustomAssociations [
	| associations |
	associations := OrderedCollection new.
	associations add: #foo->100.
	associations add: (STONTestAssociation key: #foo value:100).
	self serializeAndMaterialize: associations
]

{ #category : #tests }
MySTONWriteReadTest >> testDatesAndTimes [
	| datesAndTimes |
	datesAndTimes := MySTON listClass withAll: {
		Time now.
		Date today.
		DateAndTime now }.
	self serializeAndMaterialize: datesAndTimes
]

{ #category : #tests }
MySTONWriteReadTest >> testDiskFiles [
	| diskFiles |
	diskFiles := MySTON listClass withAll: {
		FileLocator image asFileReference.
		FileLocator workingDirectory asAbsolute.
		'foo/bar/readme.txt' asFileReference.
		'./readme.txt' asFileReference.
		(FileLocator home / 'foo.txt') asFileReference }.
	self serializeAndMaterialize: diskFiles
]

{ #category : #tests }
MySTONWriteReadTest >> testDomainObject [
	| object objects |
	object := STONTestDomainObject dummy.
	self serializeAndMaterialize: object.
	objects := MySTON listClass streamContents: [ :stream |
		10 timesRepeat: [ stream nextPut: STONTestDomainObject dummy ] ].
	self serializeAndMaterialize: objects.
	objects := MySTON mapClass new.
	10 timesRepeat: [ | newObject |
		newObject := STONTestDomainObject dummy.
		objects at: newObject integer put: newObject ].
	self serializeAndMaterialize: objects
]

{ #category : #tests }
MySTONWriteReadTest >> testEmpty [
	| empty |
	empty := MySTON listClass new.
	self serializeAndMaterialize: empty.
	empty := MySTON mapClass new.
	self serializeAndMaterialize: empty
]

{ #category : #tests }
MySTONWriteReadTest >> testFileSystemSupport [
	| fileReferences fileLocators |
	fileReferences := MySTON listClass withAll: {
		FileLocator image asFileReference.
		FileLocator workingDirectory asFileReference.
		(FileLocator home / 'foo.txt') asFileReference }.
	self serializeAndMaterialize: fileReferences.
	fileLocators := MySTON listClass withAll: {
		FileLocator image.
		FileLocator workingDirectory.
		FileLocator home / 'foo.txt' }.
	self serializeAndMaterialize: fileLocators
]

{ #category : #tests }
MySTONWriteReadTest >> testFloats [
	| check |

	check := [ :numbers | | floats serialization materialization |
		floats := MySTON listClass withAll: numbers.
		serialization := self serialize: floats.
		materialization := self materialize: serialization.
		self assert: floats size equals: materialization size.
		floats with: materialization do: [ :float :materializedFloat |
			self assert: float equals: materializedFloat ] ].

	check value: ((-10 to: 10) collect: [ :each | each * Float pi ]).

	check value: {
		0.022999999999999854 . 4.999999999999996 . -4.999999999999996 . 0.333333333333 .
		Float zero . Float negativeZero .
		Float fmin . Float fmax .
		Float pi . Float e . 0.00001.
		Float infinity . Float negativeInfinity }.

	self assert: (MySTON fromString: (MySTON toString: Float nan)) isNaN
]

{ #category : #tests }
MySTONWriteReadTest >> testFractions [
	| fractions |
	fractions := MySTON listClass withAll: (-2/3 to: 2/3 by: 1/3).
	self serializeAndMaterialize: fractions
]

{ #category : #tests }
MySTONWriteReadTest >> testIdentityCollections [
	| collections |
	collections := MySTON listClass withAll: {
		IdentitySet withAll: #(1 2 3).
		IdentityDictionary new at: 1 put: 1; at: 2 put: 2; yourself.
		IdentityBag withAll: { #A. #B. #A. #B. #A } }.
	self serializeAndMaterialize: collections
]

{ #category : #tests }
MySTONWriteReadTest >> testIntervals [
	| intervals |
	intervals := MySTON listClass withAll: {
		1 to: 10.
		1 to: 10 by: 2.
		100 to: 50 by: -5 }.
	self serializeAndMaterialize: intervals
]

{ #category : #tests }
MySTONWriteReadTest >> testJsonMode [
	| object |
	object := MySTON listClass withAll: {
		Float pi.
		'Hello World'.
		true.
		nil.
		MySTON listClass withAll: #( 1 2 3) asByteArray.
		MySTON mapClass new
			at: 'x' put: 1;
			at: 'y' put: 2;
			yourself
	}.
	self serializeAndMaterializeJsonMode: object
]

{ #category : #tests }
MySTONWriteReadTest >> testKnownObjects [
	| knownObject ston object |
	knownObject := STONTestKnownObject new.
	"make sure the system of remembering instances works"
	self assert: (STONTestKnownObject fromId: knownObject id asString) equals: knownObject.
	self assert: (STONTestKnownObject fromId: knownObject id asString) identicalTo: knownObject.
	"only the id string is serialized"
	ston := self serialize: knownObject.
	"upon serialization, objects with known id strings come from the remembered instances"
	object := self materialize: ston.
	self assert: object equals: knownObject.
	self assert: object identicalTo: knownObject.
	"not just the id is equal, but the rest of the object too"
	self assert: object description equals: knownObject description.

	STONTestKnownObject resetKnownObjects
]

{ #category : #tests }
MySTONWriteReadTest >> testMemoryFileReferences [
	| root dir1 file1 references ston result |
	root := FileSystem memory root.
	dir1 := (root / 'dir1') ensureCreateDirectory.
	file1 := (dir1 / 'file1') ensureCreateFile.
	file1 writeStreamDo: [ :out | out nextPutAll: 'ABC' ].
	references := MySTON listClass withAll: { dir1 . file1 }.
	ston := self serialize: references.
	result := self materialize: ston.
	self assert: result first exists.
	self assert: result second exists.
	self assert: result first fileSystem equals: result second fileSystem.
	self assert: result first fileSystem identicalTo: result second fileSystem.
	self assert: result first fileSystem isMemoryFileSystem.
	self assert: result second contents equals: 'ABC'
]

{ #category : #tests }
MySTONWriteReadTest >> testMimeTypes [
	| mimeTypes |
	mimeTypes := MySTON listClass withAll: {
		ZnMimeType applicationJson.
		ZnMimeType textPlain }.
	self serializeAndMaterialize: mimeTypes
]

{ #category : #tests }
MySTONWriteReadTest >> testOrderedDictionary [
	"OrderedDictionary is special because it does not inherit from Dictionary.
	It might also not exist in some dialects, where this test could be skipped."

	| dictionaries orderedDictionaryClass orderedIdentityDictionaryClass |
	orderedDictionaryClass := self environment at: #OrderedDictionary ifAbsent: [ Dictionary ].
	orderedIdentityDictionaryClass := self environment at: #OrderedIdentityDictionary ifAbsent: [ IdentityDictionary ].
	dictionaries := MySTON listClass withAll: {
		orderedDictionaryClass new at: 1 put: 1; at: 2 put: 2; yourself.
		orderedDictionaryClass new at: #a put: 1; at: #b put: -2; at: #c put: 0; yourself.
		orderedDictionaryClass new.
		orderedIdentityDictionaryClass new at: 1 put: 1; at: 2 put: 2; yourself.
		orderedIdentityDictionaryClass new at: #a put: 1; at: #b put: -2; at: #c put: 0; yourself.
		orderedIdentityDictionaryClass new }.
	self serializeAndMaterialize: dictionaries
]

{ #category : #tests }
MySTONWriteReadTest >> testPrimitives [
	| primitives |
	primitives := MySTON listClass withAll: { true. false. nil }.
	self serializeAndMaterialize: primitives
]

{ #category : #tests }
MySTONWriteReadTest >> testScaledDecimals [
	| fractions |
	fractions := MySTON listClass withAll: (-2/3s2 to: 2/3s2 by: 1/3s2).
	self serializeAndMaterialize: fractions
]

{ #category : #tests }
MySTONWriteReadTest >> testSharedColors [
	| color1 color2 colors |
	color1 := Color r: 0.25 g: 0.5 b: 0.75 alpha: 0.4.
	color2 := Color red.
	colors := MySTON listClass withAll: { color1. color2. color2 }.
	self serializeAndMaterialize: colors
]

{ #category : #tests }
MySTONWriteReadTest >> testSmallDictionary [
	"SmallDictionary is special because it does not inherit from Dictionary.
	It might also not exist in some dialects, where this test could be skipped."

	| dictionaries smallDictionaryClass |
	smallDictionaryClass := self environment at: #SmallDictionary ifAbsent: [ Dictionary ].
	dictionaries := MySTON listClass withAll: {
		smallDictionaryClass new at: 1 put: 1; at: 2 put: 2; yourself.
		smallDictionaryClass new at: 1 put: 1; at: 2 put: 2; yourself.
		smallDictionaryClass new }.
	self serializeAndMaterialize: dictionaries
]

{ #category : #tests }
MySTONWriteReadTest >> testSmallIntegers [
	| integers |
	integers := MySTON listClass withAll: (-10 to: 10).
	self serializeAndMaterialize: integers
]

{ #category : #tests }
MySTONWriteReadTest >> testSortedCollections [
	| collections |
	collections := MySTON listClass withAll: {
		SortedCollection new.
		SortedCollection new: 0.
		#(5 3 7 2 1 4 10 9 8 6) asSortedCollection.
		#(5 3 7 2 1 4 10 9 8 6) asSortedCollection: #yourself ascending.
		#(5 3 7 2 1 4 10 9 8 6) asSortedCollection: #yourself descending.
		#('****' '*' '*****' '**' '***') asSortedCollection: #size ascending.
		#('****' '*' '*****' '**' '***') asSortedCollection: #size descending.
		#(5 3 7 2 1 4 10 nil 9 8 6) asSortedCollection: #yourself ascending undefinedFirst.
		#(5 3 7 2 1 4 10 nil 9 8 6) asSortedCollection: #yourself ascending reversed undefinedLast }.
	self serializeAndMaterialize: collections
]

{ #category : #tests }
MySTONWriteReadTest >> testSpecialCharacters [
	| primitives |
	primitives := MySTON listClass withAll: {
		String withAll: { Character tab. Character lf. Character cr }.
		String withAll: { $'. $". $\. $/ }.
		'élèves français'.
		'Düsseldorf Königsallee'.
		#(1 10 20 30 127 140 150 160 200 255) collect: #asCharacter as: String }.
	self serializeAndMaterialize: primitives
]

{ #category : #tests }
MySTONWriteReadTest >> testSpecialClassNames [
	| specialClass key specialInstance ston reader object |
	specialClass := LookupKey newAnonymousSubclass.
	specialClass setName: #'STONTest_Lärm'.
	key := 999 atRandom asString asSymbol.
	specialInstance := specialClass key: key.
	ston := self serialize: specialInstance.
	reader := self reader: ston.
	(reader instVarNamed: #classes)
		at: specialClass name
		put: specialClass.
	object := reader next.
	self assert: object equals: specialInstance.
	self assert: object class equals: specialClass.
	self assert: object key equals: key
]

{ #category : #tests }
MySTONWriteReadTest >> testStrings [
	| strings |
	strings := Collection allSubclasses
		collect: [ :each | each name asString ].
	self serializeAndMaterialize: strings.
	strings := {
		'foo'. 'Foo BAR'. ''. '	\\'''.
		'élève en Français'.
		String with: (Character codePoint: 12354) "HIRAGANA LETTER A" }.
	self serializeAndMaterialize: strings
]

{ #category : #tests }
MySTONWriteReadTest >> testSymbols [
	| symbols |
	symbols := #( #bytes #'' #Bytes123 ).
	self serializeAndMaterialize: symbols.
	symbols := Collection allSubclasses collect: [ :each | each name ].
	self serializeAndMaterialize: symbols.
	"simple symbols"
	symbols := #( #foo123 #'123foo' #'punctuation-_./' #'_Foo' #'/root' #'---' #'.st' ).
	self serializeAndMaterialize: symbols.
	"non-simple symbols"
	symbols := #( #'les-élèves-français' #'euro-€' #'ångström' ).
	self serializeAndMaterialize: symbols
]

{ #category : #tests }
MySTONWriteReadTest >> testTextAndRunArray [
	| texts |
	texts := {
		'Text!' asText.
		(Text string: 'I am bold' attribute: TextEmphasis bold), ' and I am normal text'.
		Text new }.
	self serializeAndMaterialize: texts
]

{ #category : #tests }
MySTONWriteReadTest >> testURLs [
	| urls |
	urls := MySTON listClass withAll: {
		'https://pharo.org/files/pharo.png' asUrl.
		'mailto:sven@stfx.eu' asUrl.
		'file:///var/log/system.log' asUrl.
		'scheme://user:password@host:123/var/log/system.log?foo=1&bar#frag' asUrl }.
	self serializeAndMaterialize: urls
]

{ #category : #tests }
MySTONWriteReadTest >> testUUIDs [
	| uuids |
	uuids := MySTON listClass withAll: {
		UUID new.
		UUID new.
		UUID nilUUID }.
	self serializeAndMaterialize: uuids
]

{ #category : #tests }
MySTONWriteReadTest >> testUser [
	| user users |
	user := STONTestUser dummy.
	self serializeAndMaterialize: user.
	users := MySTON listClass streamContents: [ :stream |
		10 timesRepeat: [ stream nextPut: STONTestUser dummy ] ].
	self serializeAndMaterialize: users.
	users := MySTON mapClass new.
	10 timesRepeat: [ | newUser |
		newUser := STONTestUser dummy.
		users at: newUser username put: newUser ].
	self serializeAndMaterialize: users
]

{ #category : #tests }
MySTONWriteReadTest >> testUser2 [
	| user users |
	user := STONTestUser2 dummy.
	self serializeAndMaterialize: user.
	users := MySTON listClass streamContents: [ :stream |
		10 timesRepeat: [ stream nextPut: STONTestUser2 dummy ] ].
	self serializeAndMaterialize: users.
	users := MySTON mapClass new.
	10 timesRepeat: [ | newUser |
		newUser := STONTestUser2 dummy.
		users at: newUser username put: newUser ].
	self serializeAndMaterialize: users
]
