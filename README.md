# paper
Inspired by Google's [Paper Phone](https://experiments.withgoogle.com/paper-phone).  A simple postscript template with helper scripts to generate content.  Orchestrated by a Makefile.

## Dependencies
With the current configuration, the dependencies include:
+ BSD finger -- used to get weather report ([linux](http://ftp.linux.org.uk/pub/linux/Networking/netkit/))
+ [ledger](https://www.ledger-cli.org/) -- for checkbook management
+ [calcurse](https://calcurse.org/) -- for calendar and todo list
+ [ghostscript](https://www.ghostscript.com/) to generate the pdf
+ some way to print from the command line.  `lp` usually works if cups is configured. Alternatively, `make` generates a pdf, which you can print however you like.

## Install
`sudo make install`

## Usage
`make print`

This will generate some files from p1-p8.  Those files that are not generated can be created by hand (ie. a contacts page -- p5)  Those panels you want empty on the final product should be `touch`ed, and if necessary commented out of the Makefile.  This is fine tuned for US letter paper, and phone.ps will need to be reworked for other page sizes.

The file format is simple, with the first line as the title for the panel, and the rest as the body.  Only the first 16 characters of the title will be included, and only 21 lines of 28 characters for the body.  These are experimentally determined constants to fill the space.  For including free-form text, `fmt -w28` is extremely useful.  For example, a contact page:

```
Contacts
Me
111.222.3344
myemail@email.zip

Spouse
999.888.7766
theiremail@email.zip
```

Note that the weather script will stop working if used too many times in a short period, so to regenerate phone.pdf without generating new content for p{1..8}, just run `make manual`

## Customization
paper is customized by editing `config.mk` which is copied from `config.def.mk`.  If further modifications are desired, edits can be made to the helper scripts, `Makefile` and p{1..8} themselves.  Keep in mind that the Makefile declares some p# as phony targets that it generates on every run, so if you want to manually generate content, remove the rules that generate that page, and remove the target from the phony list.

## phone-scriptures
This script will use the week number (0-53) to pick a scripture passage from the scripture folder, with a subdirectory determined by `$1`.  ie, `phone-scriptures nt` on week 8 would output the contents of `scriptures/nt/8`.

## phone-weather
This script outputs the low and the high (low/high) and a description of the weather in the city at $1.  So `phone-weather NewYork` would output the low and high in New York.  This is implemented using [graph.no](https://graph.no/finger/), for more information see (https://0p.no/2016/05/31/weather_via_finger_an_update.html), or run `finger @graph.no`.

## phone-checkbook
This script outputs the current USD balance from ledger (see above). `$1` holds the location of the ledger journal file.

## Uninstall
Just `sudo make uninstall`
