# Experiment : STON - Limited Reflection through compilation

This experiment focuses on limiting reflection using compilation and a blackList / whiteList of allowed selectors.

## Creating a hook inside the compilation to get the compiler from the manifest of the package of the class
The two following methods need to be modified / added for the experiment to work

```Smalltalk
Behavior>>compiler

	"Answer a compiler appropriate for source methods of this class."

	| compiler |
	self package packageManifestOrNil
		ifNil: [ compiler := self compilerClass new ]
		ifNotNil: [ :manifest | compiler := manifest compiler ].
	^ compiler
		  environment: self environment;
		  class: self
```

```Smalltalk
PackageManifest class>>compiler

	^ self compilerClass new
```
Now, using the manifest and new subclasses of PackageManifest, each package can specify its compiler, and in particular plug-ins.
