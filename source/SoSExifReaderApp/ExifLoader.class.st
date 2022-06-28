Class {
	#name : 'ExifLoader',
	#superclass : 'Object',
	#instVars : [
		'fileName',
		'tags',
		'filePath',
		'dib',
		'fields',
		'reader'
	],
	#category : 'SoSExifReaderApp'
}

{ #category : 'Not categorized' }
ExifLoader class >> newFor: aFilePath [

	| o |

	o := self new.
	o filePath: aFilePath.
	^o
]

{ #category : 'Not categorized' }
ExifLoader >> createExif [

	self reader: (SoSExifReader newFor: self filePath).
	self reader validExif
		ifTrue: [
			self reader "showOutput: false;
			debug: false;" parseAFileCalled:
				self filePath.
			self
				tags: self reader result;
				fields: self reader reverseResults;
				fileName: self reader fileName;
				filePath: self filePath stripLastEntry.
			(self reader thumbnailLength = 0 or: [self reader thumbnailLength isNil])
				ifFalse: [self dib: self reader thumbnailDIB dib].
			"self dib isNil ifTrue:[self loadJPEG: self reader fileSize]."
			^self]
		ifFalse: [^self reader validExif]
]

{ #category : 'Not categorized' }
ExifLoader >> createExif: showOutput [

	self reader: (SoSExifReader newFor: self filePath).
	self reader validExif
		ifTrue: [
			self reader
				showOutput: showOutput;
				debug: false;
				parseAFileCalled: self filePath.
			self
				tags: self reader result;
				fields: self reader reverseResults;
				fileName: self reader fileName;
				filePath: self filePath stripLastEntry.
			(self reader thumbnailLength = 0 or: [self reader thumbnailLength isNil])
				ifFalse: [self dib: self reader thumbnailDIB dib].
			"self dib isNil ifTrue:[self loadJPEG: self reader fileSize]."
			^self]
		ifFalse: [^self reader validExif]
]

{ #category : 'Not categorized' }
ExifLoader >> dib [
	"Return the value of dib."

	^dib
]

{ #category : 'Not categorized' }
ExifLoader >> dib: anObject [
	"Save the value of dib."

	dib := anObject
]

{ #category : 'Not categorized' }
ExifLoader >> fields [
	"Return the value of fields."

	^fields
]

{ #category : 'Not categorized' }
ExifLoader >> fields: anObject [
	"Save the value of fields."

	fields := anObject
]

{ #category : 'Not categorized' }
ExifLoader >> fileName [
	"Return the value of fileName."

	^fileName
]

{ #category : 'Not categorized' }
ExifLoader >> fileName: anObject [
	"Save the value of fileName."

	fileName := anObject
]

{ #category : 'Not categorized' }
ExifLoader >> filePath [
	"Return the value of filePath."

	^filePath
]

{ #category : 'Not categorized' }
ExifLoader >> filePath: anObject [
	"Save the value of filePath."

	filePath := anObject
]

{ #category : 'Not categorized' }
ExifLoader >> loadJPEG: fileSize [


	self dib: (CgJPEGFileFormat new loadFromFile: self filePath , self fileName).
	self resizeDIB
]

{ #category : 'Accessors' }
ExifLoader >> reader [
	"Return the value of reader."

	^reader
]

{ #category : 'Accessors' }
ExifLoader >> reader: anObject [
	"Save the value of reader."

	reader := anObject
]

{ #category : 'Not categorized' }
ExifLoader >> resizeDIB [

	| h w scale |

	h := self dib height.
	w := self dib width.
	h < w ifTrue: [scale := h / 120] ifFalse: [scale := w / 120].
	h := (h / scale) asInteger.
	w := (w / scale) asInteger.
	self dib: (self dib scaledTo: w @ h)
]

{ #category : 'Not categorized' }
ExifLoader >> tags [
	"Return the value of tags."

	^tags
]

{ #category : 'Not categorized' }
ExifLoader >> tags: anObject [
	"Save the value of tags."

	tags := anObject
]
