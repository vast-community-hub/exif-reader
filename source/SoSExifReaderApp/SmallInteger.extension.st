Extension {
	#name : 'SmallInteger'
}

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoS'] }
SmallInteger >> asByteArray [

	^(Array with: (self // 256) with: (self - ((self // 256) * 256))) asByteArray


]

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoS'] }
SmallInteger >> asByteArray: bigEndian [

	bigEndian = true
		ifTrue: [^(Array with: (self // 256) with: (self - ((self // 256) * 256))) asByteArray]
		ifFalse: [^(Array with: (self - ((self // 256) * 256)) with: (self // 256)) asByteArray]


]
