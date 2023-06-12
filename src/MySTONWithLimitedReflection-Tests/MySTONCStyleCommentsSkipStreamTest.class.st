Class {
	#name : #MySTONCStyleCommentsSkipStreamTest,
	#superclass : #TestCase,
	#category : #'MySTONWithLimitedReflection-Tests'
}

{ #category : #testing }
MySTONCStyleCommentsSkipStreamTest >> testBlockReading [
	| input buffer |
	input := STONCStyleCommentsSkipStream on: 'abc/*comment*/def' readStream.
	buffer := String new: 6.
	self assert: (input readInto: buffer startingAt: 1 count: 4) equals: 4.
	self assert: (buffer copyFrom: 1 to: 4) equals: 'abcd'.
	self assert: (input readInto: buffer startingAt: 5 count: 4) equals: 2.
	self assert: buffer equals: 'abcdef'.
	input := STONCStyleCommentsSkipStream on: 'abc//comment\def' withCRs readStream.
	buffer := String new: 6.
	self assert: (input readInto: buffer startingAt: 1 count: 6) equals: 6.
	self assert: buffer equals: 'abcdef'.
	self assert: input atEnd
]

{ #category : #testing }
MySTONCStyleCommentsSkipStreamTest >> testCommentInString [
	self
		assert: (STONCStyleCommentsSkipStream on: '''/*comment*/''' readStream) upToEnd
		equals: '''/*comment*/'''.
	self
		assert: (STONCStyleCommentsSkipStream on: '{''foo'':''/*comment*/bar''}' readStream) upToEnd
		equals: '{''foo'':''/*comment*/bar''}'.
	self
		assert: (STONCStyleCommentsSkipStream on: '{''foo'':''//comment\''bar''}' readStream) upToEnd
		equals: '{''foo'':''//comment\''bar''}'.
	self
		assert: (STONCStyleCommentsSkipStream on: '{"foo":"/*comment*/bar"}' readStream) upToEnd
		equals: '{"foo":"/*comment*/bar"}'.
	self
		assert: (STONCStyleCommentsSkipStream on: '{"foo":"//comment\"bar"}' readStream) upToEnd
		equals: '{"foo":"//comment\"bar"}'
]

{ #category : #testing }
MySTONCStyleCommentsSkipStreamTest >> testMultiLineComment [
	self
		assert: (STONCStyleCommentsSkipStream on: 'foo\//comment\bar' withCRs readStream) upToEnd
		equals: 'foo\bar' withCRs.
	self
		assert: (STONCStyleCommentsSkipStream on: 'foo\//comment\bar' withCRs readStream) nextLine
		equals: 'foo'.
	self
		assert: ((STONCStyleCommentsSkipStream on: 'foo\//comment\bar' withCRs readStream) nextLine; nextLine)
		equals: 'bar'.
	self assert: (STONCStyleCommentsSkipStream on: '//comment' readStream) atEnd
]

{ #category : #testing }
MySTONCStyleCommentsSkipStreamTest >> testNonComment [
	self assert: (STONCStyleCommentsSkipStream on: 'foo' readStream) upToEnd equals: 'foo'.
	self assert: (STONCStyleCommentsSkipStream on: 'foo' readStream) nextLine equals: 'foo'.
	self deny: (STONCStyleCommentsSkipStream on: 'foo' readStream) atEnd.
	self assert: (STONCStyleCommentsSkipStream on: '' readStream) atEnd
]

{ #category : #testing }
MySTONCStyleCommentsSkipStreamTest >> testSTON [
	"Comments are processed first and totally removed.
	They are not even whitespace (not that whitespace is relevant in STON)."

	self
		assert: (MySTON fromStream: (STONCStyleCommentsSkipStream on: '123/*comment*/456' readStream))
		equals: 123456.
	self
		assert: (MySTON fromStream: (STONCStyleCommentsSkipStream on: '/*comment*/''abcd''' readStream))
		equals: 'abcd'.
	self
		assert: (MySTON fromStream: (STONCStyleCommentsSkipStream on: '123//456' readStream))
		equals: 123.
	self
		should: [ MySTON fromStream: (STONCStyleCommentsSkipStream on: '//456' readStream) ]
		raise: STONReaderError
]

{ #category : #testing }
MySTONCStyleCommentsSkipStreamTest >> testSingleLineComment [
	self assert: (STONCStyleCommentsSkipStream on: 'foo/*comment*/bar' readStream) upToEnd equals: 'foobar'.
	self assert: (STONCStyleCommentsSkipStream on: 'foo/*comment*/bar' readStream) nextLine equals: 'foobar'.
	self deny: (STONCStyleCommentsSkipStream on: 'foo/*comment*/bar' readStream) atEnd.
	self assert: (STONCStyleCommentsSkipStream on: '/*comment*/' readStream) atEnd
]
