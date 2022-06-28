Class {
	#name : 'SoSExifTagError',
	#superclass : 'SoSExifTag',
	#category : 'SoSExifReaderApp'
}

{ #category : 'Not categorized' }
SoSExifTagError class >> newFor: aTag [

	| o |

	o := self new.
	o tagDec: aTag printString.
	^o
]

{ #category : 'Not categorized' }
SoSExifTagError >> <= aTag [

	^false


]

{ #category : 'Not categorized' }
SoSExifTagError >> count [

	^0


]

{ #category : 'Not categorized' }
SoSExifTagError >> fieldName [

	"Return the value of fieldName."

	^'Tag not defined'


]

{ #category : 'Not categorized' }
SoSExifTagError >> isTagError [

	"Return the value of isTagError."

	^true


]

{ #category : 'Not categorized' }
SoSExifTagError >> printString [

	^self tagDec printString , ' : ' , self tagName


]

{ #category : 'Not categorized' }
SoSExifTagError >> tagDecNumber [

	"Return the value of tagDec."

	^999999


]

{ #category : 'Not categorized' }
SoSExifTagError >> tagName [

	"Return the value of tagName."

	^'Tag not defined'


]

{ #category : 'Not categorized' }
SoSExifTagError >> typeCalculationUsing: bigEndian [




]
