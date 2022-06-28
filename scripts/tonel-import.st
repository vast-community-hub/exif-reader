| loader path |
path := (CfsPath named: '<insert path to root exif-reader local repo here>').
loader := TonelLoader readFromPath: path.
loader
	beUnattended;
	useGitVersion.
loader loadAllMapsWithRequiredMaps.
