Class {
	#name : 'SoSVisitorPrintClass',
	#superclass : 'SoSVisitorAbstractOutputClass',
	#instVars : [
		'result'
	],
	#category : 'SoSExifReaderApp'
}

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> makeResult [

	self result: Dictionary new.
	self outputList asSortedCollection do: [:each | result at: each tagName put: each]


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> output: aLine [

	self outputList add: aLine


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputATag: aTag ForValues: values andResults: results [


	aTag value do: [:each | | which |
		which := values indexOf: each.
		which = 0 ifTrue: [which := results size].
		self outputTag: aTag oneValueString: (results at: which)]


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputResultTo: target [

	self showOutput
		ifTrue: [
			target = 'Transcript'
				ifTrue: [
					Transcript
						cr;
						cr.
					self result keys asSortedCollection do: [:each | | one |
						one := self result at: each.
						Transcript
							show: one tagName , one separator , one output;
							cr]]
				ifFalse: [self outputStreamTo: target]]


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputStreamTo: target [


	| ss |

	self stripInternalTags.
	ss := ReadWriteStream on: target.
	self showOutput
		ifTrue: [
			ss nextPutAll: LineDelimiter , LineDelimiter.
			result keys asSortedCollection do: [:each |
				ss nextPutAll:
					(result at: each) fieldName , (result at: each) separator ,
						(result at: each) output , LineDelimiter]].

	^ss collection


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputTag: aTag oneValueString: value [

	self output: (
		ExifOutputTag
			with: aTag tagName
			with: aTag fieldName
			with: self separator
			with: value exifPrintString)


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputTag: aTag oneValueString: value prefix: prefix [

	self output: (
		ExifOutputTag
			with: aTag tagName
			with: aTag fieldName
			with: self separator
			with: prefix , value exifPrintString)


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputTag: aTag oneValueString: value suffix: suffix [

	self output: (
		ExifOutputTag
			with: aTag tagName
			with: aTag fieldName
			with: self separator
			with: value exifPrintString , ' ' , suffix)


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputTag: aTag oneValueString: value suffix: suffix using: aSymbol [

	self output: (
		ExifOutputTag
			with: aTag tagName
			with: aTag fieldName
			with: self separator
			with: (value perform: aSymbol) exifPrintString , ' ' , suffix)


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputTagAndOneValueString: aTag [

	aTag value do: [:each |
		self output: (
			ExifOutputTag
				with: aTag tagName
				with: aTag fieldName
				with: self separator
				with: each exifPrintString)]


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputTagAndValueString: aTag [

	^aTag value do: [:each |
		self output: (
			ExifOutputTag
				with: aTag tagName
				with: aTag fieldName
				with: self separator
				with: each exifPrintString)]


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputTagAndValueString: aTag prefix: aPrefix [

	aTag value do: [:each |
		self output: (
			ExifOutputTag
				with: aTag tagName
				with: aTag fieldName
				with: self separator
				with: aPrefix , each exifPrintString)]


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputTagAndValueString: aTag suffix: aSuffix [

	aTag value do: [:each |
		self output: (
			ExifOutputTag
				with: aTag tagName
				with: aTag fieldName
				with: self separator
				with: each exifPrintString , ' ' , aSuffix)]


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputTagAndValueString: aTag suffix: aSuffix using: aSymbol [

	aTag value do: [:each |
		self output: (
			ExifOutputTag
				with: aTag tagName
				with: aTag fieldName
				with: self separator
				with: (each perform: aSymbol) exifPrintString , ' ' , aSuffix)]


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputTagAndValueString: aTag suffix: aSuffix using: aSymbol with: anArgument [

	aTag value do: [:each |
		self output: (
			ExifOutputTag
				with: aTag tagName
				with: aTag fieldName
				with: self separator
				with: (each perform: aSymbol with: anArgument) exifPrintString , ' ' , aSuffix)]


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputTagAndValueStringAsFraction: aTag suffix: aSuffix [

	aTag value do: [:each |
		self output: (
			ExifOutputTag
				with: aTag tagName
				with: aTag fieldName
				with: self separator
				with: each exifPrintString , ' ' , aSuffix)]


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> outputTagAndValueStringAsFraction: aTag suffixList: aSuffixList [

	aTag value doWithIndex: [:each :i |
		self output: (
			ExifOutputTag
				with: aTag tagName
				with: aTag fieldName
				with: self separator
				with: each exifPrintString , ' ' , (aSuffixList at: i))]


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> result [

	"Return the value of result."

	^result


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> result: anObject [

	"Save the value of result."

	result := anObject


]

{ #category : 'Not categorized' }
SoSVisitorPrintClass >> stripInternalTags [

	self result
		removeKey: 'ExifIFDPointer' ifAbsent: [];
		removeKey: 'InteroperabilityIFDPointer' ifAbsent: []
]
