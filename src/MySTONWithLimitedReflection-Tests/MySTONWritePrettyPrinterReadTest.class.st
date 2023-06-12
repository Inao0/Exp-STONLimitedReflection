Class {
	#name : #MySTONWritePrettyPrinterReadTest,
	#superclass : #MySTONWriteReadTest,
	#category : #'MySTONWithLimitedReflection-Tests'
}

{ #category : #private }
MySTONWritePrettyPrinterReadTest >> serialize: anObject [
	^ String streamContents: [ :stream |
		MySTON writer
			on: stream;
			prettyPrint: true;
			nextPut: anObject ]
]

{ #category : #private }
MySTONWritePrettyPrinterReadTest >> serializeJson: anObject [
	^ String streamContents: [ :stream |
		MySTON jsonWriter
			on: stream;
			prettyPrint: true;
			nextPut: anObject ]
]
