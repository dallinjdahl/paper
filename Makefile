.POSIX:

sinclude config.mk

all: phone.pdf

manual:
	ps2pdf -DNOSAFER phone.ps 

p1:
	echo "$(title)" > p1
	date '+%B %e' >> p1

p2:
	echo "Calendar" > p2
	phone-cal >> p2

p3:
	echo "Tasks" > p3
	phone-todo >> p3

p6:
	phone-scriptures bom > p6

p7:
	echo "Weather" > p7
	phone-weather $(city) >> p7

p8:
	echo "Checkbook" > p8
	phone-checkbook $(ledg) >> p8

phone.pdf: phone.ps p1 p2 p3 p4 p5 p6 p7 p8 config.mk
	ps2pdf -DNOSAFER $< 

config.mk: config.def.mk
	cp $< $@

print: phone.pdf
	lp -d $(printer) $<

clean:
	rm phone.pdf

install:
	mkdir -p $(PREFIX)/bin
	cp -f phone-scriptures phone-checkbook phone-weather phone-cal phone-todo $(PREFIX)/bin/
	chmod 755 $(PREFIX)/bin/{phone-weather,phone-cal,phone-todo,phone-checkbook,phone-scriptures}

uninstall:
	rm -f $(PREFIX)/bin/{phone-weather,phone-cal,phone-todo,phone-checkbook,phone-scriptures}

.PHONY: p1 p2 p3 p6 p7 p8 install manual clean print
