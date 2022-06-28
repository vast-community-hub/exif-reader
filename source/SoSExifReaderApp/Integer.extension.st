Extension {
	#name : 'Integer'
}

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoS'] }
Integer >> fromUnsignedToSigned: aSize [

	^(self toBinaryWithSize: aSize) fromSignedBinary: aSize


]

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoS'] }
Integer >> toBinaryWithSize: aSize [

	| remainder carry binary |

	carry := self number.
	binary := ''.
	[carry > 1] whileTrue: [
		remainder := carry rem: 2.
		carry := carry // 2.
		binary := remainder asString , binary].
	carry = 1 ifTrue: [binary := '1' , binary] ifFalse: [binary := '0' , binary].
	[binary size < aSize] whileTrue: [binary := '0' , binary].
	^binary


]

{ #category : '*SoSExifReaderApp',
 #vaCategories : ['SoS'] }
Integer >> twosComplementBinary: aSize [

	| result |

	self < 0
		ifTrue: [
			result := self abs toBinaryWithSize: aSize.
			result := result binaryInvert.
			result := result addDecimalToBinary: 1 size: aSize.
			^result].
	^self toBinaryWithSize: aSize


]
