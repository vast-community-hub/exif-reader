Class {
	#name : 'ExifBasicTag',
	#superclass : 'Object',
	#instVars : [
		'tagName',
		'fieldName'
	],
	#category : 'SoSExifReaderApp'
}

{ #category : 'Exif' }
ExifBasicTag >> fieldName [

	"Return the value of fieldName."

	^fieldName


]

{ #category : 'Exif' }
ExifBasicTag >> fieldName: anObject [

	"Save the value of fieldName."

	fieldName := anObject.
	self signalEvent: #fieldName with: anObject


]

{ #category : 'Exif' }
ExifBasicTag >> tagName [

	"Return the value of tagName."

	^tagName


]

{ #category : 'Exif' }
ExifBasicTag >> tagName: anObject [

	"Save the value of tagName."

	tagName := anObject.
	self signalEvent: #tagName with: anObject


]
