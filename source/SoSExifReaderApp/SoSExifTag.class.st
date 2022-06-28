Class {
	#name : 'SoSExifTag',
	#superclass : 'ExifBasicTag',
	#instVars : [
		'count',
		'tagDec',
		'type',
		'tagHex',
		'bytes',
		'value',
		'defaultValue'
	],
	#classVars : [
		'Tags',
		'Headers'
	],
	#pools : [
		'CldtConstants'
	],
	#category : 'SoSExifReaderApp'
}

{ #category : 'Not categorized' }
SoSExifTag class >> exifIDFTagNo [

	^34665
]

{ #category : 'Not categorized' }
SoSExifTag class >> getRealClassFor: aList [

	| which className c |

	which := Headers indexOf: #fieldName:.
	className := (aList at: which) asString.
	className := 'SoS' , className.
	c := className asSymbol.
	c := c asClass.
	c isNil ifTrue: [self halt].
	^c new
]

{ #category : 'Not categorized' }
SoSExifTag class >> loadFromFile: aFileName [

	| f contents |

	f := CfsReadFileStream open: aFileName.
	f isCfsError
		ifFalse: [
			contents := f contents.
			f close].
	^contents
]

{ #category : 'Not categorized' }
SoSExifTag class >> makeATagFromString: aLine [

	| tagList aTag |

	tagList := aLine subStrings: $,.
	aTag := self getRealClassFor: tagList.
	Headers doWithIndex: [:each :i | aTag perform: each with: (tagList at: i)].
	Tags at: aTag tagDec put: aTag.
	^aTag
]

{ #category : 'Not categorized' }
SoSExifTag class >> tagFileName [

	^CfsDirectoryDescriptor startUpDirectoryPath , 'tags.csv'
]

{ #category : 'Not categorized' }
SoSExifTag class >> tagsFromCSV [

	self tagsFromTagList: (self loadFromFile: self tagFileName).
	^Tags
]

{ #category : 'Not categorized' }
SoSExifTag class >> tagsFromTagList: aList [

	| body |


	Tags := Dictionary new.
	Headers := OrderedCollection new.
	body := aList sosArrayOfSubStringsUsingString: LineDelimiter.
	((body at: 1) subStrings: $,) do: [:each | Headers add: (each , ':') asSymbol].
	body := body copyFrom: 2 to: body size.
	body do: [:each | self makeATagFromString: each]
]

{ #category : 'Not categorized' }
SoSExifTag >> <= aTag [

	^self tagDecNumber <= aTag tagDecNumber


]

{ #category : 'Not categorized' }
SoSExifTag >> actualType [

	^self bytes type


]

{ #category : 'Not categorized' }
SoSExifTag >> bytes [

	"Return the value of bytes."

	^bytes


]

{ #category : 'Not categorized' }
SoSExifTag >> bytes: anObject [

	"Save the value of bytes."

	bytes := anObject


]

{ #category : 'Not categorized' }
SoSExifTag >> checkDefaultValue [

	^self defaultValue isNil not


]

{ #category : 'Not categorized' }
SoSExifTag >> convertFraction [

	^false


]

{ #category : 'Not categorized' }
SoSExifTag >> count [

	"Return the value of count."

	^count


]

{ #category : 'Not categorized' }
SoSExifTag >> count: anObject [

	"Save the value of count."

	count := anObject


]

{ #category : 'Not categorized' }
SoSExifTag >> defaultValue [

	"Return the value of defaultValue."

	^defaultValue


]

{ #category : 'Not categorized' }
SoSExifTag >> defaultValue: anObject [

	"Save the value of defaultValue."

	defaultValue := anObject


]

{ #category : 'Not categorized' }
SoSExifTag >> getResultFromValue [

	| num answer result offset |

	result := OrderedCollection new.
	offset := 9.
	answer := ''.
	num := self count asNumber.
	(self bytes copyFrom: offset to: (offset + num - 1))
		do: [:each | answer := answer , (Character value: each) asString].
	result add: answer.
	self value: result


]

{ #category : 'Not categorized' }
SoSExifTag >> isTagError [

	^false


]

{ #category : 'Not categorized' }
SoSExifTag >> printString [

	^self tagDec printString , ' : ' , self tagName , ' : ' , self fieldName , ' : ' , self tagHex ,
		' : ' , self count printString , ' : ' , self type printString , ' : ' ,
		self bytes printString , ' : ' , self value printString


]

{ #category : 'Not categorized' }
SoSExifTag >> setDefaultValue [

	self value: (OrderedCollection with: self actualDefaultValue)


]

{ #category : 'Not categorized' }
SoSExifTag >> tagDec [

	"Return the value of tagDec."

	^tagDec asNumber


]

{ #category : 'Not categorized' }
SoSExifTag >> tagDec: anObject [

	"Save the value of tagDec."

	tagDec := anObject


]

{ #category : 'Not categorized' }
SoSExifTag >> tagDecNumber [

	^self tagDec asInteger


]

{ #category : 'Not categorized' }
SoSExifTag >> tagHex [

	"Return the value of tagHex."

	^tagHex


]

{ #category : 'Not categorized' }
SoSExifTag >> tagHex: anObject [

	"Save the value of tagHex."

	tagHex := anObject


]

{ #category : 'Not categorized' }
SoSExifTag >> type [

	"Return the value of type."

	^type


]

{ #category : 'Not categorized' }
SoSExifTag >> type: anObject [

	"Save the value of type."

	type := ExifTagType newFor: anObject


]

{ #category : 'Not categorized' }
SoSExifTag >> typeCalculationUsing: bigEndian for: currentType [

	"Return the value of type."

	^self type typeNames at: (self type typeNumbers indexOf: currentType)


]

{ #category : 'Not categorized' }
SoSExifTag >> value [

	"Return the value of value."

	^value


]

{ #category : 'Not categorized' }
SoSExifTag >> value: anObject [

	"Save the value of value."

	value := anObject


]

{ #category : 'Not categorized' }
SoSExifTag >> valueAsFloat [

	1 to: self value size do: [:i | self value at: i put: (self value at: 1) asFloat]


]

{ #category : 'Not categorized' }
SoSExifTag >> visit: visitorObject with: anExtraObject [

	^visitorObject perform: self visitClass withArguments: (Array with: self with: anExtraObject)


]

{ #category : 'Not categorized' }
SoSExifTag >> visitClass [

	| t |

	t := self class asString. "
	t := t copyFrom: 4 to: t size.
	(t copyFrom: 1 to: 4) = 'Exif' ifFalse:[ t := 'Exif', t]."
	^('visited' , t , ':' , 'with:') asSymbol


]
