Extension {
	#name : 'Character'
}

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoS'] }
Character >> isPrintable [

	^self isLetter | self isDigit | self isPunctuation | self isSeparator


]
