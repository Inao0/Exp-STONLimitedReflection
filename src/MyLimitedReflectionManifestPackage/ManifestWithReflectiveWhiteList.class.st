Class {
	#name : #ManifestWithReflectiveWhiteList,
	#superclass : #PackageManifest,
	#classInstVars : [
		'whiteList'
	],
	#category : #MyLimitedReflectionManifestPackage
}

{ #category : #deprecation }
ManifestWithReflectiveWhiteList class >> classCompiler [

	^ super classCompiler
		  addPlugin: (WhiteListPlugIn new whiteList: self requiredSelectors);
		  yourself
]

{ #category : #deprecation }
ManifestWithReflectiveWhiteList class >> classSideCompiler [

	^ super classSideCompiler 
		  addPlugin: (WhiteListPlugIn new whiteList: self requiredSelectors);
		  yourself
]

{ #category : #deprecation }
ManifestWithReflectiveWhiteList class >> compiler [

	^ super compiler
		  addPlugin: (WhiteListPlugIn new whiteList: self requiredSelectors);
		  yourself
]

{ #category : #deprecation }
ManifestWithReflectiveWhiteList class >> defaultWhiteList [
	
	^  {}
]

{ #category : #deprecation }
ManifestWithReflectiveWhiteList class >> forbiddenSelectors [

	^ (self package methods flatCollect: [ :each | each messages ]) asSet 
		  select: [ :each | each beginsWith: 'bad_' ]
]

{ #category : #deprecation }
ManifestWithReflectiveWhiteList class >> initialize [ 
	<script>
	self resetWhiteList.
]

{ #category : #deprecation }
ManifestWithReflectiveWhiteList class >> recompile [
<script>
	self package methods do: [ :each | each recompile ]
]

{ #category : #deprecation }
ManifestWithReflectiveWhiteList class >> requiredSelectors [
	
	^ whiteList
]

{ #category : #initialization }
ManifestWithReflectiveWhiteList class >> resetWhiteList [
	self whiteList: self defaultWhiteList 
]

{ #category : #'as yet unclassified' }
ManifestWithReflectiveWhiteList class >> usedBlackListedSelectors [
|list|
	list := (self package methods flatCollect: [ :each | each messages ])
		        asSet intersection: WhiteListPlugIn selectorBlackList.
	list addAll:
		(self forbiddenSelectors collect: [ :each |
			 each withoutPrefix: #bad_ ]).
	^ list
]

{ #category : #accessing }
ManifestWithReflectiveWhiteList class >> whiteList: aCollection [ 
	whiteList := aCollection.
	self recompile. 
]
