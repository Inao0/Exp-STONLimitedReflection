Class {
	#name : #MySTONTestMap,
	#superclass : #Dictionary,
	#category : #'MySTONWithLimitedReflection-Tests'
}

{ #category : #'instance creation' }
MySTONTestMap class >> classTree [
	^ self classTree: Object
]

{ #category : #'instance creation' }
MySTONTestMap class >> classTree: topClass [
	| map |
	map := IdentityDictionary new.
	topClass withAllSubclasses do: [ :eachClass | | info |
		(info := self new)
			at: #name put: eachClass name asString;
			at: #comment put: eachClass comment;
			at: #isMeta put: eachClass isMeta;
			at: #methods put: eachClass selectors.
		map at: eachClass put: info ].
	map keysAndValuesDo: [ :eachClass :eachInfo |
		eachClass == topClass
			ifFalse: [ eachInfo at: #superclass put: (map at: eachClass superclass) ].
		eachInfo at: #subclasses put: (eachClass subclasses collect: [ :subClass | map at: subClass ]) ].
	^ map at: topClass
]

{ #category : #'instance creation' }
MySTONTestMap class >> classTreeExtended [
	^ self classTreeExtended: Object
]

{ #category : #'instance creation' }
MySTONTestMap class >> classTreeExtended: topClass [
	| map |
	map := IdentityDictionary new.
	topClass withAllSubclasses do: [ :eachClass | | info methodsInfo |
		(info := self new)
			at: #name put: eachClass name asString;
			at: #comment put: eachClass comment;
			at: #isMeta put: eachClass isMeta;
			at: #methods put: (methodsInfo := self new).
		eachClass methods do: [ :eachMethod | | methodInfo |
			(methodInfo := self new)
				at: #name put: eachMethod selector;
				at: #numArgs put: eachMethod numArgs;
				at: #class put: info.
			methodsInfo at: eachMethod selector put: methodInfo ].
		map at: eachClass put: info ].
	map keysAndValuesDo: [ :eachClass :eachInfo |
		eachClass == topClass
			ifFalse: [ eachInfo at: #superclass put: (map at: eachClass superclass) ].
		eachInfo at: #subclasses put: (eachClass subclasses collect: [ :subClass | map at: subClass ]) ].
	^ map at: topClass
]

{ #category : #'ston-core' }
MySTONTestMap class >> stonName [
	^ #TestMap
]

{ #category : #printing }
MySTONTestMap >> printElementsOn: stream [
	stream
		nextPut: $(;
		nextPut: $#;
		print: self size;
		nextPut: $)
]
