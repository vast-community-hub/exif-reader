Class {
	#name : 'SoSExifReader',
	#superclass : 'Object',
	#instVars : [
		'visitor',
		'bigEndian',
		'filePath',
		'fileStream',
		'thumbnailDIB',
		'headerOffset',
		'jpegOffset',
		'endOffset',
		'thumbnailLength',
		'tags',
		'startMarker',
		'showOutput',
		'currentTags',
		'fileName',
		'debug',
		'thumbnailData',
		'fileSize',
		'result',
		'startOffset',
		'validExif',
		'file',
		'thumbnailOffset'
	],
	#classVars : [
		'TagDictionary'
	],
	#pools : [
		'CldtConstants',
		'CfsConstants'
	],
	#category : 'SoSExifReaderApp'
}

{ #category : 'Exif' }
SoSExifReader class >> createCompleteTagListForFile: aFilePath [

	"Creates and answers complete tag list with data for the chosen image
 No path is required for images in the Smalltalk root directory - normally CfsDirectoryDescriptor startUpDirectoryPath
 
 SoSExifReader createCompleteTagListForFile: 'testimage.jpg' 
 "

	| tags tagDict |

	tagDict := Dictionary new.
	tags := self decodeAFileCalled: aFilePath.
	tags := tags currentTags reject: [:each | each isTagError].
	tags do: [:each | tagDict at: each tagName put: each].
	^tagDict
]

{ #category : 'Exif' }
SoSExifReader class >> createTagListForFile: aFilePath usIng: aTagList [

	"Computes the  complete tag list with data for the chosen image and returns only the tags in aTagList
	 Data returned is the actual data for each entry in the dictionary
 No path is required for images in the Smalltalk root dirtectory - normally CfsDirectoryDescriptor startUpDirectoryPath
 
 SoSExifReader createTagListForFile: 'testimage.jpg' usIng: #( 'FNumber'  'PixelXDimension'  'DateTimeOriginal'  'ISOSpeedRatings' 'ExposureTime' 'FocalLength')
 "

	| tags tagSO |

	tagSO := SortedCollection sortBlock: [:a :b | a fieldName <= b fieldName].
	tags := self decodeAFileCalled: aFilePath.
	tags := tags currentTags reject: [:each | each isTagError].
	tagSO addAll: tags.
	^self selectWantedTagsFrom: tagSO using: aTagList
]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
SoSExifReader class >> newFor: aFileName [

	| o |

	TagDictionary := SoSExifTag tagsFromCSV.
	o := self new.
	o currentTags: Dictionary new.
	o := o loadUpFrom: aFileName.
	^o
]

{ #category : 'Exif' }
SoSExifReader class >> parseAFileCalled: aFileName [

	"

 Execute will answer all tags for the current image to the Transcript. Inspect will answer this list and  will also answer an inspector on the Dictionary list of the EXIF tags with their constituent data.
 SoSExifReader parseAFileCalled: 'testimage.jpg' 
 "

	| sos |

	sos := self newFor: aFileName.
	TagDictionary := SoSExifTag tagsFromCSV.
	sos
		resolveTags;
		completeTags;
		activateVisitor;
		showDebug.

	^sos result
]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
SoSExifReader class >> presentTagsFrom: tagList [

	| wantedDictionary |

	wantedDictionary := Dictionary new.
	tagList isEmpty ifTrue: [^wantedDictionary].
	tagList do: [:aTag | | tagValue |
		tagValue := aTag value.
		wantedDictionary at: aTag tagName put: tagValue].
	^wantedDictionary
]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
SoSExifReader class >> selectWantedTagsFrom: tagList [

	| wantedNames wantedList |

	wantedList := #('FNumber' 'PixelXDimension' 'PixelYDimension' 'DateTimeOriginal'
	'ISOSpeedRatings' 'ExposureTime' 'FocalLength').
	wantedNames := Dictionary new.
	tagList isEmpty ifTrue: [^wantedNames].
	wantedList do: [:each | | tagValue oneTag |
		oneTag := tagList select: [:one | one fieldName = each].
		oneTag isEmpty
			ifFalse: [
				tagValue := oneTag first value first.
				wantedNames at: each put: tagValue]]. "
aName := 'FNumber'. wantedNames at: aName put: (tagList select:[ : each | each fieldName = aName]) first value first.
aName := 'PixelXDimension'. wantedNames at: aName put: (tagList select:[ : each | each fieldName = aName]) first value first.
aName := 'PixelYDimension'. wantedNames at: aName put: (tagList select:[ : each | each fieldName = aName]) first  value first.
aName := 'DateTimeOriginal'. wantedNames at: aName put: (tagList select:[ : each | each fieldName = aName]) first  value first.
aName := 'ISOSpeedRatings'. wantedNames at: aName put: (tagList select:[ : each | each fieldName = aName]) first  value first.
aName := 'ExposureTime'. wantedNames at: aName put: (tagList select:[ : each | each fieldName = aName]) first value first.
aName := 'FocalLength'. wantedNames at: aName put: (tagList select:[ : each | each fieldName = aName]) first value first."
	^wantedNames
]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
SoSExifReader class >> selectWantedTagsFrom: tagList using: aTagArray [

	| wantedNames |

	wantedNames := Dictionary new.
	aTagArray do: [:one | | aTag |
		aTag := (tagList select: [:each | each fieldName = one]).
		aTag isEmpty
			ifFalse: [
				wantedNames
					at: one
					put: (tagList select: [:each | each fieldName = one]) first value first]].
	aTagArray do: [:each | (wantedNames keys includes: each) ifFalse: [wantedNames at: each put: '']].

	^wantedNames
]

{ #category : 'Exif' }
SoSExifReader class >> showTagDefinitions [

	"

Answers a list of all EXIF tags with their constituent data.
 SoSExifReader showTagDefinitions
 "

	| tagDict |

	tagDict := Dictionary new.
	TagDictionary := SoSExifTag tagsFromCSV.
	TagDictionary do: [:each | tagDict at: each fieldName put: each].
	^tagDict
]

{ #category : 'Exif' }
SoSExifReader class >> showTagListFor: aJPEGFile [

	"
Inspect  answers an inspector list of all tag names in the the chosen image
 No path is required for images in the Smalltalk root directory - normally CfsDirectoryDescriptor startUpDirectoryPath
 
 SoSExifReader showTagListFor: 'testimage.jpg'
 "

	| tags tagSO |

	tagSO := SortedCollection sortBlock: [:a :b | a fieldName <= b fieldName].
	tags := SoSExifReader decodeAFileCalled: CfsDirectoryDescriptor startUpDirectoryPath , aJPEGFile.
	tags := tags currentTags reject: [:each | each isTagError].
	tagSO addAll: tags.
	^tagSO collect: [:each | each fieldName]
]

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
SoSExifReader class >> TagDictionary [

	^TagDictionary
]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> activateVisitor [


	SoSVisitorPrintClass bigEndian: self bigEndian.
	self visitor: SoSVisitorPrintClass new.
	self visitor
		visit: self currentTags with: nil;
		showOutput: self showOutput;
		outputResultTo: 'Transcript'.
	self makeResult: self visitor outputList.
	^result
]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> bigEndian [

	"Return the value of bigEndian."

	^bigEndian


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> bigEndian: anObject [

	"Save the value of bigEndian."

	bigEndian := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> buildRecordFor: aPosition [

	^self fileStream copyFrom: aPosition to: (aPosition + 11)


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> completeTags [

	SoSTagFiller
		newFor: self fileStream
		tags: self currentTags
		offset: self headerOffset
		bigEndian: self bigEndian
		headerOffset: self headerOffset


]

{ #category : 'Exif' }
SoSExifReader >> createTagListForFile: aFilePath [

	| tagsO |

	tagsO := SortedCollection sortBlock: [:a :b | a fieldName <= b fieldName].
	self tags: (self decodeAFileCalled: aFilePath).
	self tags: (self tags current tags reject: [:each | each isTagError]).
	tagsO addAll: self tags.
	^self presentTagsFrom: tagsO
]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> currentTags [

	"Return the value of currentTags."

	^currentTags


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> currentTags: anObject [

	"Save the value of currentTags."

	currentTags := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> debug [

	"Return the value of debug."

	debug isNil ifTrue: [debug := false].
	^debug


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> debug: anObject [

	"Save the value of debug."

	debug := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> debugShowTags [

	Transcript
		cr;
		show: 'Tags';
		cr.
	self currentTags asSortedCollection do: [:each |
		Transcript
			show: each printString;
			cr]


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> decodeAFileCalled: aFileName [

	self fileName: aFileName.
	TagDictionary := SoSExifTag tagsFromCSV.
	self
		resolveTags;
		completeTags.

	^self
]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> endOffset [

	"Return the value of endOffset."

	^endOffset


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> endOffset: anObject [

	"Save the value of endOffset."

	endOffset := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> exifIDValue [

	| mem |

	mem :=
		((self tags at: SoSExifTag exifIDFTagNo ifAbsent: [^false]) copyFrom: 9 to: 12) asByteArray
			asInteger: self bigEndian.
	^mem + self headerOffset + 1


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> exifIFDTag [

	^34665


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> file [

	"Return the value of file."

	^file


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> file: anObject [

	"Save the value of file."

	file := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> fileName [

	"Return the value of fileName."

	^fileName


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> fileName: anObject [

	"Save the value of fileName."

	fileName := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> filePath [

	"Return the value of filePath."

	^filePath


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> filePath: anObject [

	"Save the value of filePath."

	filePath := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> fileSize [

	"Return the value of fileSize."

	^fileSize


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> fileSize: anObject [

	"Save the value of fileSize."

	fileSize := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> fileStream [

	"Return the value of fileStream."

	^fileStream


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> fileStream: anObject [

	"Save the value of fileStream."

	fileStream := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> findAMarker: aMarker [

	"The marker is in decimal so it needs to be made into a byte array"

	| ba |

	ba := aMarker asByteArray: self bigEndian.
	^self getStreamMarkersFor: ba count: 2 on: self fileStream


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> findASingleMarker: aMarker [

	"The marker is in decimal so it needs to be made into a byte array"

	| ba |

	ba := aMarker asByteArray: self bigEndian.
	^self getStreamMarkersFor: ba count: 1 on: self fileStream


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> findEndianMarker [

	| a |

	a := self findASingleMarker: 18761.
	(a = false or: [a isEmpty]) ifFalse: [(a at: 1) < self endOffset ifTrue: [^a at: 1]].
	a := self findASingleMarker: 19789.
	(a = false or: [a isEmpty]) ifFalse: [(a at: 1) < self endOffset ifTrue: [^a at: 1]].
	^0


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> getAllData [

	| exifIDValue |

	self headerOffset = 0
		ifFalse: [
			self validExif: (
				self
					makeAllTags: (self headerOffset + 9)
					count: (self interopCount: (self headerOffset + 8))).
			self validExif = false
				ifFalse: [
					exifIDValue := self exifIDValue.
					exifIDValue = false
						ifFalse: [
							self
								makeAllTags: self exifIDValue
								count: (self interopCount: (self exifIDValue - 1)).
							self makeThumbnail.
							self validExif: true]
						ifTrue: [self validExif: false]]]
		ifTrue: [self validExif: false]



]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> getStreamMarkersFor: aMarker count: aCount [

	^self getStreamMarkersFor: aMarker count: aCount on: self fileStream


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> getStreamMarkersFor: aMarker count: aCount on: aStream [

	| r1 rOC |

	r1 := 0.
	rOC := OrderedCollection new.
	aStream doWithIndex: [:each :i |
		i < aStream size
			ifTrue: [
				(Array with: (aStream at: i) with: (aStream at: (i + 1))) asByteArray = aMarker
					ifTrue: [
						rOC add: i.
						r1 := r1 + 1.
						r1 = aCount ifTrue: [^rOC]]]].
	[rOC size < aCount] whileTrue: [rOC add: 0].
	(rOC at: 1) = 0 ifTrue: [^false].
	(rOC at: 1) = 2 ifTrue: [^false].
	(rOC at: 2) > 1000 ifTrue: [^false].
	^rOC


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> headerOffset [

	"Return the value of headerOffset."

	^headerOffset


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> headerOffset: anObject [

	"Save the value of headerOffset."

	headerOffset := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> interopCount [

	^(self fileStream copyFrom: 21 to: 22) asSmallInteger: self bigEndian


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> interopCount: start [

	^(self fileStream copyFrom: start to: (start + 1)) asSmallInteger: self bigEndian


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> jpegOffset [

	"Return the value of jpegOffset."

	^jpegOffset


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> jpegOffset: anObject [

	"Save the value of jpegOffset."

	jpegOffset := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> loadUpFrom: aFilePath [

	self
		filePath: aFilePath;
		fileName: aFilePath justLastEntry;
		tags: Dictionary new;
		setFileSize.
	self parseExif = false
		ifFalse: [
			self
				resolveEndian;
				makeHeaderOffset;
				getAllData.
			^self]
		ifTrue: [^self]


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> makeAllTags: startValue count: count [

	| increment st currentBlock byteNumber |


	((count = 0) or: [count > 50]) ifTrue: [^false].
	st := ReadWriteStream on: self fileStream.
	st position: startValue.
	increment := 12.
	byteNumber := 12.
	currentBlock := ExifValueArray new: 12 bigEndian: self bigEndian.
	1 to: count do: [:i |
		(st position + byteNumber) > st readLimit ifTrue: [^false].
		st next: byteNumber into: currentBlock startingAt: 1.
		st position: (st position + (increment - byteNumber)).
		self makeATagEntry: currentBlock].
	^true


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> makeATagEntry: aBlock [

	| tag |

	tag := (aBlock copyFrom: 1 to: 2) asByteArray asSmallInteger: self bigEndian.
	self tags at: tag put: aBlock copy.
	(tag = SoSExifTag exifIDFTagNo or: [tag = 0]) ifTrue: [^#end].
	^true


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> makeHeaderOffset [

	self headerOffset: self findEndianMarker


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> makeResult: aList [

	self result: Dictionary new.
	aList do: [:each | result at: each tagName put: each]


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> makeThumbnail [

	self
		thumbnailLength: self jpegOffset - self thumbnailOffset;
		thumbnailData: (self fileStream copyFrom: self thumbnailOffset to: (self jpegOffset - 1));
		thumbnailDIB: (ExifJPEGMaker newFor: self thumbnailData)


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> openFile [

	| f |

	f := CfsReadFileStream open: self filePath.
	f isCfsError ifTrue: [^false].
	self fileStream: f contents asByteArray.
	f close.
	^true


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> parseAFileCalled: aFileName [


	self
		resolveTags;
		completeTags;
		activateVisitor;
		showDebug


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> parseExif [

	self openFile ifFalse: [^false].
	^self setOffsetValues


]

{ #category : 'Exif' }
SoSExifReader >> presentTagsFrom: tagList [

	| wantedDictionary |

	wantedDictionary := Dictionary new.
	tagList isEmpty ifTrue: [^wantedDictionary].
	tagList do: [:aTag | | tagValue |
		tagValue := aTag value.
		wantedDictionary at: aTag tagName put: tagValue].
	^wantedDictionary
]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> resolveEndian [

	| a |

	a := self findASingleMarker: 18761.
	(a = false or: [a isEmpty]) ifFalse: [(a at: 1) < self endOffset ifTrue: [^self bigEndian: true]].
	a := self findASingleMarker: 19789.
	(a = false or: [a isEmpty]) ifFalse: [(a at: 1) < self endOffset ifTrue: [self bigEndian: false]].
	^false


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> resolveTags [



	tags keys do: [:each | | one |
		one := (self class TagDictionary at: each ifAbsent: [SoSExifTagError newFor: each]).
		one bytes: (tags at: each).
		self currentTags at: each put: one]


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> result [

	"Return the value of result."

	^result


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> result: anObject [

	"Save the value of result."

	result := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> reverseResults [

	| fields |

	fields := Dictionary new.
	self result do: [:each | fields at: each fieldName put: each].
	^fields
]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> setFileSize [

	"Answer a collection containing directory entries for wanted file and return file size in bytes'"

	| collection dd de dirPath |

	collection := OrderedCollection new.
	dirPath := self filePath stripLastEntry.
	dirPath = '\' ifTrue: [dirPath := CfsDirectoryDescriptor startUpDirectoryPath].
	(dd := CfsDirectoryDescriptor opendir: dirPath pattern: self fileName mode: FREG | FDIR)
		isCfsError
			ifTrue: [self error: dd message].
	[(de := dd readdir) notNil] whileTrue: [collection add: de].
	dd closedir.
	self fileSize: (collection at: 1) stSize


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> setOffsetValues [

	| tempOC |

	tempOC := self getStreamMarkersFor: self startMarker count: 3.
	(tempOC = false or: [tempOC size < 3]) ifTrue: [^false].
	self
		startOffset: (tempOC at: 1);
		endOffset: (tempOC at: 2);
		thumbnailOffset: ((tempOC at: 2) - 1);
		jpegOffset: (tempOC at: 3);
		thumbnailLength: self jpegOffset - self thumbnailOffset.
	self thumbnailLength < 2 ifTrue: [self thumbnailLength: 0].
	^true


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> showAnyForCount [

	currentTags do: [:each |
		Transcript
			show: each tagDec printString , ' : ' , each count printString;
			cr]


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> showDebug [

	self debug ifTrue: [self debugShowTags]


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> showOutput [
	"Return the value of showOutput."

	showOutput isNil ifTrue: [^true].
	^showOutput
]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> showOutput: anObject [
	"Save the value of showOutput."

	showOutput := anObject
]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> startMarker [

	"Return the value of startMarker."

	^CgJPEGStartOfImage signature asByteArray: self bigEndian


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> startMarker: anObject [

	"Save the value of startMarker."

	startMarker := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> startOffset [

	"Return the value of startOffset."

	^startOffset


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> startOffset: anObject [

	"Save the value of startOffset."

	startOffset := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> tagEnd [

	^#end


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> tags [

	"Return the value of tags."

	^tags


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> tags: anObject [

	"Save the value of tags."

	tags := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> thumbnailData [

	"Return the value of thumbnailData."

	^thumbnailData


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> thumbnailData: anObject [

	"Save the value of thumbnailData."

	thumbnailData := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> thumbnailDIB [
	"Return the value of thumbnailDIB."

	^thumbnailDIB
]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> thumbnailDIB: anObject [
	"Save the value of thumbnailDIB."

	thumbnailDIB := anObject
]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> thumbnailLength [

	"Return the value of thumbnailLength."

	^thumbnailLength


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> thumbnailLength: anObject [

	"Save the value of thumbnailLength."

	thumbnailLength := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> thumbnailOffset [

	"Return the value of thumbnailOffset."

	^thumbnailOffset


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> thumbnailOffset: anObject [

	"Save the value of thumbnailOffset."

	thumbnailOffset := anObject


]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> validExif [
	"Return the value of validExif."

	validExif isNil ifTrue: [^false].
	^validExif
]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> validExif: anObject [
	"Save the value of validExif."

	validExif := anObject
]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> visitor [
	"Return the value of visitor."

	^visitor
]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> visitor: anObject [
	"Save the value of visitor."

	visitor := anObject
]

{ #category : 'Exif',
  #vaVisibility : 'private' }
SoSExifReader >> writeThumbnail: aPath [

	self thumbnailDIB writeJPEGTo: aPath


]
