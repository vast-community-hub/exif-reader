Class {
	#name : 'ExifJPEGMaker',
	#superclass : 'Object',
	#instVars : [
		'jpegArray',
		'dib'
	],
	#pools : [
		'NlsCatCGa'
	],
	#category : 'SoSExifReaderApp'
}

{ #category : 'Not categorized',
  #vaVisibility : 'private' }
ExifJPEGMaker class >> _PRAGMA_IS_ [

	"%%PRAGMA DECLARE
	(name: IS_ExifJPEGMaker isPool: true isConstant: false)
	(pool: IS_ExifJPEGMaker declarations: (
		(name: IS_jpegArray isConstant: false)
		(name: IS_dib isConstant: false)
		(name: IS_instanceInterfaceSpec isConstant: false)
	))"


]

{ #category : 'Not categorized' }
ExifJPEGMaker class >> newFor: aByteArray [

	| o |

	o := self new.
	o
		jpegArray: aByteArray;
		makeJPEG.
	^o
]

{ #category : 'Exif' }
ExifJPEGMaker >> dib [
	"Return the value of dib."

	^dib
]

{ #category : 'Exif' }
ExifJPEGMaker >> dib: anObject [
	"Save the value of dib."

	dib := anObject.
	self signalEvent: #dib with: anObject
]

{ #category : 'Exif' }
ExifJPEGMaker >> jpegArray [
	"Return the value of jpegArray."

	^jpegArray
]

{ #category : 'Exif' }
ExifJPEGMaker >> jpegArray: anObject [
	"Save the value of jpegArray."

	jpegArray := anObject.
	self signalEvent: #jpegArray with: anObject
]

{ #category : 'Exif' }
ExifJPEGMaker >> makeJPEG [

	| st |



	"( CgJPEGFileFormat formatMatchesByteObjects: (Array with: self jpegArray) 
	offsetsIntoByteObjects: #(0)) ifFalse:[ ^ false].."

	st := (CgByteArrayByteStream on: (Array with: self jpegArray) offsets: #(0)).
	[self dib: (CgJPEGFileFormat new loadFromByteStream: st)]
		when: ExError
		do: [:signal | signal exitWith: 'Exception: ' , signal argument , 'format error'].
	self jpegArray: nil
]

{ #category : 'Exif' }
ExifJPEGMaker >> writeJPEGTo: aFilePath [



	CgJPEGFileFormat new unload: self dib intoFile: aFilePath
]
