Extension {
	#name : 'String'
}

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoSBinary'] }
String >> addDecimalToBinary: aNumber size: aSize [

	| temp |

	temp := self fromBinary + aNumber.
	^temp toBinaryWithSize: aSize


]

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoSBinary'] }
String >> binaryInvert [

	| result |

	result := ''.
	self do: [:each | | temp |
		each = $0 ifTrue: [temp := $1] ifFalse: [temp := $0].
		result := result , temp asString].
	^result


]

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoS'] }
String >> exifPrintString [

	^self


]

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoSBinary'] }
String >> fromBinary [

	| result reverse mult |

	mult := 2.
	reverse := self reverse.
	result := (reverse at: 1) asString asNumber.
	(reverse copyFrom: 2 to: reverse size) doWithIndex: [:each :i |
		result := result + (each asString asNumber * mult).
		mult := mult * 2].
	^result


]

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoSBinary'] }
String >> fromSignedBinary: aSize [

	| temp sign |

	(self at: 1) = $1 ifTrue: [sign := -1] ifFalse: [sign := 1].
	sign = 1
		ifFalse: [
			temp := self copyFrom: 2 to: self size.
			temp := (temp subtractDecimalToBinary: 1 size: (aSize - 1)) binaryInvert.
			^temp fromBinary * sign].
	^self fromBinary


]

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoS'] }
String >> justLastEntry [


	^(self subStrings: $\) last


]

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoS'] }
String >> sosArrayOfSubStringsUsingString: aString [

	| start result pointer remainder |

	self isEmpty ifTrue: [^self].
	start := 1.
	result := OrderedCollection new.
	pointer := 1.
	(self copyFrom: (self size - 1) to: self size) = aString
		ifTrue: [remainder := self copyFrom: 1 to: (self size - 2)]
		ifFalse: [remainder := self copy].
	[start = 0] whileFalse: [
		start := remainder indexOfSubCollection: aString startingAt: 1 ifAbsent: [0].
		start = 0
			ifFalse: [
				result add: (remainder copyFrom: 1 to: (start - 1)).
				pointer := (start + aString size).
				pointer > remainder size
					ifTrue: [
						start := 0.
						result add: remainder]
					ifFalse: [remainder := remainder copyFrom: pointer to: remainder size]]
			ifTrue: [remainder isEmpty ifFalse: [result add: remainder]]].
	^result reject: [:each | each isEmpty]


]

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoS'] }
String >> stripLastEntry [

	| a result |

	result := ''.
	a := self subStrings: $\.
	1 to: (a size - 1) do: [:i | result := result , '\' , (a at: i)].
	result := result copyFrom: 2 to: result size.
	^result , '\'


]

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoSBinary'] }
String >> subtractDecimalToBinary: aNumber size: aSize [

	| temp |

	temp := self fromBinary - aNumber.
	^temp toBinaryWithSize: aSize


]
