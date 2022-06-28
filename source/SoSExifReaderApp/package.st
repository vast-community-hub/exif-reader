Package {
	#name : 'SoSExifReaderApp',
	#vaPrerequisites : ['AbtViewApplication'],
	#vaSubApplications : [
	{
		#condition : 'true',
		#subapps : [
			'SoSExifReaderTagClasses'
		]
	}
]
}
