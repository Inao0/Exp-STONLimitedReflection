Class {
	#name : #ManifestMySTONPackage,
	#superclass : #ManifestWithReflectiveWhiteList,
	#category : #MySTONWithLimitedReflection
}

{ #category : #deprecation }
ManifestMySTONPackage class >> defaultWhiteList [ 
	^  {#instVarNamed: . #lookupClass:}
]
