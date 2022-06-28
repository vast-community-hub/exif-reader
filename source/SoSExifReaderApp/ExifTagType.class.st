Class {
	#name : 'ExifTagType',
	#superclass : 'Object',
	#instVars : [
		'typeNumbers',
		'storeLocal',
		'originalNames',
		'typeNames'
	],
	#category : 'SoSExifReaderApp'
}

{ #category : 'Not categorized' }
ExifTagType class >> newFor: typeNames [

	| o |

	o := self new.
	o
		makeOriginalNamesFor: typeNames;
		makeTypeNames;
		makeTypeNumber;
		makeStoreLocal.
	^o
]

{ #category : 'Not categorized' }
ExifTagType >> makeOriginalNamesFor: names [

	| wanted |

	wanted := names subStrings: $ .
	wanted := wanted reject: [:each | each size < 4].
	self originalNames: wanted


]

{ #category : 'Not categorized' }
ExifTagType >> makeStoreLocal [

	| result |

	result := Array new: self typeSize.
	self originalNames
		doWithIndex: [:each :i | result at: i put: (self storeLocalFor: (self numberFor: each))].
	self storeLocal: result


]

{ #category : 'Not categorized' }
ExifTagType >> makeTypeNames [

	| result |

	result := Array new: self typeSize.
	self originalNames
		doWithIndex: [:each :i | result at: i put: (self performList at: (self numberFor: each))].
	self typeNames: result


]

{ #category : 'Not categorized' }
ExifTagType >> makeTypeNumber [

	| result |

	result := Array new: self typeSize.
	self originalNames doWithIndex: [:each :i | result at: i put: (self numberFor: each)].
	self typeNumbers: result


]

{ #category : 'Not categorized' }
ExifTagType >> numberFor: aString [

	^#('BYTE' 'ASCII' 'SHORT' 'LONG' 'RATIONAL' '' 'UNDEFINED' '' 'SLONG' 'SRATIONAL')
		indexOf: aString


]

{ #category : 'Not categorized' }
ExifTagType >> originalNames [

	"Return the value of originalNames."

	^originalNames


]

{ #category : 'Not categorized' }
ExifTagType >> originalNames: anObject [

	"Save the value of originalNames."

	originalNames := anObject.
	self signalEvent: #originalNames with: anObject


]

{ #category : 'Not categorized' }
ExifTagType >> performList [

	^#(byte: ascii: short: long: rational: noAction undefined: noAction slong: srational:)


]

{ #category : 'Not categorized' }
ExifTagType >> printString [

	^self originalNames printString , ' : ' , self typeNames printString , ' : ' ,
		self typeNumbers printString , ' : '


]

{ #category : 'Not categorized' }
ExifTagType >> storeLocal [

	"Return the value of storeLocal."

	^storeLocal


]

{ #category : 'Not categorized' }
ExifTagType >> storeLocal: anObject [

	"Save the value of storeLocal."

	storeLocal := anObject.
	self signalEvent: #storeLocal with: anObject


]

{ #category : 'Not categorized' }
ExifTagType >> storeLocalFor: aNumber [

	^#(true false true true false nil true nil false false) at: aNumber


]

{ #category : 'Not categorized' }
ExifTagType >> typeNames [

	"Return the value of typeNames."

	^typeNames


]

{ #category : 'Not categorized' }
ExifTagType >> typeNames: anObject [

	"Save the value of typeNames."

	typeNames := anObject.
	self signalEvent: #typeNames with: anObject


]

{ #category : 'Not categorized' }
ExifTagType >> typeNamesFor: names [

	| wanted result |

	wanted := names subStrings: $ .
	wanted := wanted reject: [:each | each size < 4].
	self originalNames: wanted.
	result := Array new: wanted size.
	wanted doWithIndex: [:each :i | result at: i put: (self performList at: (self numberFor: each))].
	^result


]

{ #category : 'Not categorized' }
ExifTagType >> typeNumbers [

	"Return the value of typeNumbers."

	^typeNumbers


]

{ #category : 'Not categorized' }
ExifTagType >> typeNumbers: anObject [

	"Save the value of typeNumbers."

	typeNumbers := anObject.
	self signalEvent: #typeNumbers with: anObject


]

{ #category : 'Not categorized' }
ExifTagType >> typeSize [

	^self originalNames size


]
