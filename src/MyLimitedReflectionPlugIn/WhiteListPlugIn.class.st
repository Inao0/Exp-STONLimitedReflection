Class {
	#name : #WhiteListPlugIn,
	#superclass : #OCStaticASTCompilerPlugin,
	#instVars : [
		'whiteList'
	],
	#category : #MyLimitedReflectionPlugIn
}

{ #category : #accessing }
WhiteListPlugIn >> selectorBlackList [

	^ { #className. #classSide. #instanceSide. #isClassSide. #isInstanceSide.
	  #isMetaclassOfClassOrNil. #hasClassSide. #isClass. #isMeta. #subclasses.
	  #obsoleteSubclasses. #hasSubclasses. #subclassesDo:. #superclass.
	  #allSubclasses. #allSuperclasses. #allSuperclassesIncluding:.
	  #allSuperclasses. #allSubclassesWithLevelDo:startingLevel:.
	  #allSubclassesDo:. #allSuperclassesDo:. #withAllSubclasses.
	  #withAllSubclassesDo:. #withAllSuperclasses. #withAllSuperclassesDo:.
	  #withAllSuperAndSubclasses. #withAllSubAndSuperclassesDo:.
	  #isKindOf:. #isMemberOf:. #kindOfSubclass. #commonSuperclassWith:.
	  #whichSuperclassSatisfies:. #inheritsFrom:. #includesBehavior:.
	  #isRootInEnvironment. #selectSuperclasses:. #selectSubclasses:.
	  #instVarNames. #instanceVariableNamesDo:. #allInstVarNames.
	  #hasInstVarNamed:. #definedVariables. #allInstVarNamesEverywhere.
	  #classThatDefinesInstVarNamed:. #whichClassDefinesInstVar:.
	  #instSize. #basicSize. #instVarIndexFor:. #instVarIndexFor:ifAbsent:.
	  #classVariables. #classVarNames. #allClassVarNames.
	  #hasClassVarNamed:. #classVariableNamed:ifAbsent:.
	  #hasClassVariable:. #definesClassVariableNamed:.
	  #definesClassVariable:. #readClassVariableNamed:.
	  #classThatDefinesClassVariable:. #whichClassDefinesClassVar:.
	  #usesClassVarNamed:. #sharedPools. #sharedPoolNames.
	  #allSharedPools. #hasSharedPools. #sharedPoolOfVarNamed:.
	  #sharedPoolsDo:. #classPool. #usesLocalPoolVarNamed:.
	  #usesPoolVarNamed:. #includesSharedPoolNamed:.
	  #instanceVariables. #slots. #localSlots. #allSlots. #slotNames.
	  #hasSlotNamed:. #slotNamed:. #slotNamed:ifFound:.
	  #slotNamed:ifFound:ifNone:. #readSlot:. #readSlotNamed:.
	  #definesSlot:. #definesSlotNamed:. #classBindingOf:.
	  #bindingOf:. #lookupVar:. #lookupVar:declare:. #lookupVarForDeclaration:.
	  #hasMethods. #hasAbstractMethods. #respondsTo:. #classesThatImplementAllOf:.
	  #allInstances. #allInstancesOrNil. #allInstancesDo:.
	  #allSubInstancesDo:. #allSubInstances. #pragmasDo:. #pragmas.
	  #isAnonymous. #isClassOrTrait. #isUsed. #isObsolete. #includesSelector:.
	  #includesLocalSelector:. #isDisabledSelector:. #isLocalSelector.
	  #selectors. #selectorsDo:. #selectorsWithArgs:. #methods. #methodNamed:.
	  #includesMethod:. #methodsDo:. #selectorsAndMethodsDo:.
	  #subclasses:. #superclass:. #basicSuperclass:. #addSubclass:.
	  #removeSubclass:. #addObsoleteSubclass:. #removeAllObsoleteSubclasses.
	  #addInstVarNamed:. #removeInstVarNamed:. #addClassVariable:.
	  #addClassVarNamed:. #removeClassVariable:. #removeClassVarNamed:.
	  #removeClassVarNamed:interactive:. #sharedPools:. #addSharedPool:.
	  #addSharedPoolNamed:. #removeSharedPool:. #classPool:. #addSlot:.
	  #removeSlot:. #addClassSlot:. #removeClassSlot:. #removeSelector:.
	  #removeSelectorSilently:. #addSelectorSilently:withMethod:.
	  #addSelector:withMethod:. #addSelector:withRecompiledMethod:.
	  #whichClassIncludesSelector:. #classesThatImplementAllOf:.
	  #classBuilder. #classInstaller. #newSubclass. #newAnonymousSubclass.
	  #subclass:. #writeClassVariableNamed:value:.
	  #writeSlot:value:. #writeSlotNamed:value:. #objectClass:.
	  #objectSize:. #instVarAt:. #instVarNamed:. #instVarNames.
	  #instVarsInclude:. #instanceVariables. #object:basicAt:.
	  #object:eqeq:. #object:instVarAt:. #instVarAt:put:. #instVarNamed:put:.
	  #object:basicAt:put:. #object:instVarAt:put:. #adoptInstance:.
	  #adoptInstance:from:. #instVarMappingFrom:. #primitiveChangeClassTo:.
	  #perform:. #perform:orSendTo:. #perform:with:. #perform:with:with:.
	  #perform:with:with:with:. #perform:with:with:with:with:.
	  #perform:withArguments:. #perform:withArguments:inSuperclass:.
	  #perform:withEnoughArguments:. #object:perform:withArguments:inClass:.
	  #withArgs:executeMethod:. #tryPrimitive:withArgs:.
	  #valueWithReceiver:arguments:. #executeMethod:. #receiver:withArguments:executeMethod:.
	  #pointersTo. #pointersToAmong:. #pointersToExcept:.
	  #pointersToExcept:among:. #pointsOnlyWeaklyTo:. #pointsTo:.
	  #become:. #becomeForward:. #becomeForward:copyHash:.
	  #someInstance. #someObject. #nextInstance. #nextObject. #setFormat:.
	  #format. #basicIdentityHash. #identityHash. #becomeForward:copyHash:.
	  #allMethodsAccessingSlot:. #allMethodsReadingSlot:.
	  #allMethodsWritingSlot:. #methodsAccessingSlot:.
	  #methodsReadingSlot:. #methodsWritingSlot:. #hasMethodAccessingVariable:.
	  #usingMethods. #whichMethodsReferTo:. #whichSelectorsReferTo:.
	  #thoroughHasSelectorReferringTo:. #thoroughWhichMethodsReferTo:.
	  #thoroughWhichMethodsReferTo:specialIndex:.
	  #thoroughWhichSelectorsReferTo:. #usingMethods. #hasSelectorReferringTo:.
	  #usingMethods. #lookupSelector:. #canPerform:. #canUnderstand:.
	  #cannotInterpret:. #doesNotUnderstand:. #compile:classified:.
	  #compile:classified:notifying:. #compile:classified:withStamp:notifying:.
	  #compile:classified:withStamp:notifying:logSource:.
	  #compile:notifying:. #compileAll. #compileAllFrom:. #compileSilently:.
	  #compileSilently:classified:. #compileSilently:classified:notifying:.
	  #compiledMethodAt:. #compiledMethodAt:ifAbsent:.
	  #compiledMethodAt:ifPresent:. #compiledMethodAt:ifPresent:ifAbsent:.
	  #compiler. #compilerClass. #selector. #sender. #activeOuterContext.
	  #arguments. #method. #methodNode. #outerContext. #outerMostContext.
	  #receiver. #tempAt:. #tempAt:put:. #top. #stepUntilSomethingOnStack.
	  #runUntilErrorOrReturnFrom:. #resume:through:. #activateMethod:withArgs:receiver:class:.
	  #terminate. #send:to:with:lookupIn:. #resumeEvaluating:.
	  #jump. #terminateTo:. #send:to:with:super:. #return. #pop. #shortDebugStack.
	  #return:. #push:. #step. #return:from:. #resume. #stepToCallee.
	  #return:through:. #resume:. #isValid. #arguments. #numArgs. #collectArguments:.
	  #receiver. #selector. #message. #arguments:. #receiver:. #selector:.
	  #argument. #arguments. #hasArguments. #numArgs. #selector. #lookupClass.
	  #argument:. #lookupClass:. #setSelector:. #setSelector:arguments:.
	  #asSendTo:. #sends:. #sentTo:. #sendTo:. #thisContext } asSet
]

{ #category : #'private - transforming' }
WhiteListPlugIn >> transform [
	"Subclasses override this method to actually provide the AST transformation.
	 IMPORTANT: If you modify the AST, make sure to copy it before using #copyAST!"

	| badNodes |
	
	badNodes := ast sendNodes select: [ :each |
		            ( self selectorBlackList difference: self whiteList ) includes: each selector ].
	badNodes do: [ :each | each selector: #bad_ , each selector ]
]

{ #category : #accessing }
WhiteListPlugIn >> whiteList [

	^ whiteList
]

{ #category : #accessing }
WhiteListPlugIn >> whiteList: anObject [

	whiteList := anObject
]
