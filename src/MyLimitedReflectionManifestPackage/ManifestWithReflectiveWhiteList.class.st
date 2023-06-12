Class {
	#name : #ManifestWithReflectiveWhiteList,
	#superclass : #PackageManifest,
	#category : #MyLimitedReflectionManifestPackage
}

{ #category : #deprecation }
ManifestWithReflectiveWhiteList class >> compiler [

	^ super compiler
		  addPlugin: (WhiteListPlugIn new whiteList: self requiredSelectors);
		  yourself
]

{ #category : #deprecation }
ManifestWithReflectiveWhiteList class >> forbiddenSelectors [

	^ (self package methods flatCollect: [ :each | each messages ]) asSet 
		  select: [ :each | each beginsWith: 'bad_' ]
]

{ #category : #deprecation }
ManifestWithReflectiveWhiteList class >> recompile [
<script>
	self package methods do: [ :each | each recompile ]
]

{ #category : #deprecation }
ManifestWithReflectiveWhiteList class >> requiredSelectors [
	
	^  {}
]
