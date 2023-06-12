Class {
	#name : #MySTONWriteAsciiOnlyReadTest,
	#superclass : #MySTONWriteReadTest,
	#category : #'MySTONWithLimitedReflection-Tests'
}

{ #category : #private }
MySTONWriteAsciiOnlyReadTest >> serialize: anObject [
	^ String streamContents: [ :stream |
		MySTON writer
			on: stream;
			asciiOnly: true;
			nextPut: anObject ]
]

{ #category : #private }
MySTONWriteAsciiOnlyReadTest >> serializeJson: anObject [
	^ String streamContents: [ :stream |
		MySTON jsonWriter
			on: stream;
			asciiOnly: true;
			nextPut: anObject ]
]
