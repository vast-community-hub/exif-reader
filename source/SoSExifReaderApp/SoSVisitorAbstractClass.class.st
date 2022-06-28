Class {
	#name : 'SoSVisitorAbstractClass',
	#superclass : 'Object',
	#category : 'SoSExifReaderApp'
}

{ #category : 'Not categorized' }
SoSVisitorAbstractClass >> visit: aList with: extraObject [

	aList do: [:each | each isTagError ifFalse: [each visit: self with: extraObject]].
	self makeResult


]

{ #category : 'Not categorized' }
SoSVisitorAbstractClass >> visited: target with: anExtraObject [




]
