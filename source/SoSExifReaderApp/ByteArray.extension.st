Extension {
	#name : 'ByteArray'
}

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoS'] }
ByteArray >> alignedFor: bigEndian [

	bigEndian = false ifTrue: [^self reverse] ifFalse: [^self]
]

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoS'] }
ByteArray >> asInteger: bigEndian [

	| finish mult answer count step |

	mult := 0.
	finish := self size.
	bigEndian = false
		ifTrue: [
			count := self size.
			step := -1]
		ifFalse: [
			count := 1.
			step := 1].
	answer := 0.
	1 to: finish do: [:i |
		mult = 0
			ifTrue: [answer := answer + (self at: count)]
			ifFalse: [answer := answer + ((self at: count) * (256 * mult))].
		mult := mult + 1.
		count := count + step].
	^answer


]

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoS'] }
ByteArray >> asSmallInteger: bigEndian [

	bigEndian = false
		ifTrue: [^(self at: 2) + ((self at: 1) * 256)]
		ifFalse: [^(self at: 1) + ((self at: 2) * 256)]


]
