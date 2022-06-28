Class {
	#name : 'ExifOutputTag',
	#superclass : 'ExifBasicTag',
	#instVars : [
		'output',
		'separator'
	],
	#category : 'SoSExifReaderApp'
}

{ #category : 'Not categorized' }
ExifOutputTag class >> newEmpty [

	^self with: '' with: '' with: '' with: 'Not available'
]

{ #category : 'Not categorized' }
ExifOutputTag class >> newEmptyFor: aName [

	^self with: aName with: '' with: '' with: 'Not available'
]

{ #category : 'Not categorized' }
ExifOutputTag class >> with: aTagName with: aFieldName with: separator with: output [

	| o |

	o := self new.
	o
		tagName: aTagName;
		fieldName: aFieldName;
		separator: separator;
		output: output.

	^o
]

{ #category : 'Not categorized' }
ExifOutputTag >> <= aTag [

	^self fieldName <= aTag fieldName


]

{ #category : 'Not categorized' }
ExifOutputTag >> isEmpty [

	^false
]

{ #category : 'Not categorized' }
ExifOutputTag >> output [

	"Return the value of output."

	^output


]

{ #category : 'Not categorized' }
ExifOutputTag >> output: anObject [

	"Save the value of output."

	output := anObject.
	self signalEvent: #output with: anObject


]

{ #category : 'Not categorized' }
ExifOutputTag >> separator [

	"Return the value of separator."

	^separator


]

{ #category : 'Not categorized' }
ExifOutputTag >> separator: anObject [

	"Save the value of separator."

	separator := anObject.
	self signalEvent: #separator with: anObject


]
