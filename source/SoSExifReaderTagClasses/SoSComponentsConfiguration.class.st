Class {
	#name : 'SoSComponentsConfiguration',
	#superclass : 'SoSExifTag',
	#category : 'SoSExifReaderTagClasses'
}

{ #category : 'Not categorized' }
SoSComponentsConfiguration >> getResultFromValue [

	| num answer result offset |

	result := OrderedCollection new.
	offset := 9.
	answer := ''.
	num := self count asNumber.
	(self bytes copyFrom: offset to: (offset + num - 1))
		do: [:each | answer := answer , each asString].
	result add: answer.
	self value: result


]
