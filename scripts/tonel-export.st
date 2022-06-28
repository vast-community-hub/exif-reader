| writer path |
path := (CfsPath named: '<insert path to root exif-reader local repo here>').
writer := TonelWriter new.
writer
	addLatestConfigurationMapNamed: 'SoS';
	addApplicationsFromConfigurationMaps.
writer writeProjectInto: path.
