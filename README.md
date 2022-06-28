
<p align="center">
<!---<img src="assets/logos/128x128.png">-->
 <h1 align="center">VAST Platform EXIF reader</h1>
  <p align="center">
    VAST Platform EXIF reader
    <!---
    <br>
    <a href="docs/"><strong>Explore the docs »</strong></a>
    <br>
    -->
    <br>
    <a href="https://github.com/instantiations/exif-reader/issues/new?labels=Type%3A+Defect">Report a defect</a>
    |
    <a href="https://github.com/instantiations/exif-reader/issues/new?labels=Type%3A+Feature">Request feature</a>
  </p>
</p>


A VAST Platform project to read and parse EXIF metadata from images.


## License
- The code is licensed under [MIT](LICENSE).
- The documentation is licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).


## Installation

1. Install [VA Smalltalk 10.0.0 or newer](https://www.instantiations.com/products/vasmalltalk/download.html).
2. Install Tonel support in your development image following [this guide](https://github.com/vasmalltalk/tonel-vast#installation).
3. Clone this repository.
4. The easiest and recommended approach is to install it via a script:

```smalltalk
| loader path |
path := (CfsPath named: '<insert path to root exif-reader local repo here>').
loader := TonelLoader readFromPath: path.
loader
	beUnattended; "do not prompt and use all defaults"
	useGitVersion.
loader loadAllMapsWithRequiredMaps.
```

Or you can load the Configuration Map `SoS` from the context menu of the Configuration Maps Browser: `"Import"` -> `"Load Configuration Maps from Tonel repository..."` -> select path to root `exif-reader` local repo. This will open a dialog and will use convenient defaults for the load. Refer to [its documentation](https://github.com/instantiations/tonel-vast#using-gui-menus) for more details.

## Supplied files:

- [exif-useage.pdf](assets/docs/exif-usage)  - PDF manual contains instructions for installing and running the code
- [tags.csv](assets/data/tags.csv) - must be in the root directory of the program and contains the list of all valid exif tags and their data
- [testimage.jpg](assets/test/testImage.jpg) - a valid JPEG file used from within the comments of the class methods used.


## Running the examples

- Ensure that the two files: [tags.csv](assets/data/tags.csv) and [testimage.jpg](assets/test/testImage.jpg) are in the root directory
- Go to the Application `SoSExifReaderApp` and select `SoSExifReader` in the Parts list and open it.
- Go to the Class method list and open `parseAFileCalled: aFileName`
- Highlight  `SoSExifReader parseAFileCalled: 'testimage.jpg'`  and inspect (Control-Q). You should have a list of the tags and their contents in the Transcript and an inspect on a dictionary containing each page in the image.
