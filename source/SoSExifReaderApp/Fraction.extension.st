Extension {
	#name : 'Fraction'
}

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoS'] }
Fraction >> exifPrintString [

	^numerator printString , '/' , denominator printString


]
