.POSIX:

all: phone.pdf

manual:
	ps2pdf -DNOSAFER phone.ps 

p1:
	echo "Dallin Dahl" > p1
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
	phone-weather beaverton >> p7

p8:
	echo "Checkbook" > p8
	phone-checkbook ~/Ledg/journal.ledg >> p8

phone.pdf: phone.ps p1 p2 p3 p4 p5 p6 p7 p8
	ps2pdf -DNOSAFER $< 

print:
	lp -d Black_and_White phone.pdf

clean:
	rm phone.pdf

install:
	mkdir -p /usr/local/bin
	cp -f phone-scriptures phone-checkbook phone-weather phone-cal phone-todo /usr/local/bin/
	chmod 755 /usr/local/bin/weather
	chmod 755 /usr/local/bin/phone-cal
	chmod 755 /usr/local/bin/phone-todo
	chmod 755 /usr/local/bin/phone-checkbook
	chmod 755 /usr/local/bin/phone-scriptures

.PHONY: p1 p2 p3 p6 p7 p8 install manual clean
