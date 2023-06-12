Class {
	#name : #ManifestMySTONPackage,
	#superclass : #ManifestWithReflectiveWhiteList,
	#category : #'MySTONWithLimitedReflection-Manifest'
}

{ #category : #deprecation }
ManifestMySTONPackage class >> requiredSelectors [
	^  {#instVarNamed: . #lookupClass:}
]
