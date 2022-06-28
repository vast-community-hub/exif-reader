Class {
	#name : 'SoSShutterSpeedValue',
	#superclass : 'SoSExifTag',
	#category : 'SoSExifReaderTagClasses'
}

{ #category : 'Not categorized' }
SoSShutterSpeedValue >> getResultFromValue [

	super getResultFromValue.
	self value: (1 / (2 raisedTo: self value))


]
