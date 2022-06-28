Class {
	#name : 'ExifValueArray',
	#superclass : 'Array',
	#instVars : [
		'valueOffset',
		'value',
		'bigEndian',
		'count',
		'tag',
		'type'
	],
	#type : 'variable',
	#category : 'SoSExifReaderApp'
}

{ #category : 'SoS' }
ExifValueArray class >> new: aSize bigEndian: bigEndian [

	| o |

	o := self new: aSize.
	o bigEndian: bigEndian.
	^o
]

{ #category : 'Not categorized' }
ExifValueArray >> bigEndian [

	"Return the value of bigEndian."

	^bigEndian


]

{ #category : 'Not categorized' }
ExifValueArray >> bigEndian: anObject [

	"Save the value of bigEndian."

	bigEndian := anObject.
	self signalEvent: #bigEndian with: anObject


]

{ #category : 'Not categorized' }
ExifValueArray >> byte [

	^self at: 9


]

{ #category : 'Not categorized' }
ExifValueArray >> count [

	"Return the value of count."

	^self copyFrom: 5 to: 8


]

{ #category : 'Not categorized' }
ExifValueArray >> long [

	^(self copyFrom: 9 to: 12) asByteArray asInteger: bigEndian


]

{ #category : 'Not categorized' }
ExifValueArray >> short [

	^(self copyFrom: 9 to: 10) asByteArray asInteger: self bigEndian


]

{ #category : 'Not categorized' }
ExifValueArray >> slong [

	^(self copyFrom: 9 to: 12) asByteArray


]

{ #category : 'Not categorized' }
ExifValueArray >> tag [

	"Return the value of tag."

	^self copyFrom: 1 to: 2


]

{ #category : 'Not categorized' }
ExifValueArray >> type [

	"Return the value of type."

	^(self copyFrom: 3 to: 4) asByteArray


]

{ #category : 'Not categorized' }
ExifValueArray >> value [

	"Return the value of valueOffset."

	^self copyFrom: 9 to: 12


]

{ #category : 'Not categorized' }
ExifValueArray >> valueOffset [

	"Return the value of valueOffset."

	^self copyFrom: 9 to: 12


]
