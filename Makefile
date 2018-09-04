

python-%.deb: 
	@(\
		echo $* && \
		fpm -f -s python -t deb "$*" && \
		dpkg -I python-$*_*.deb  | grep Depends | cut -f2 -d":" | tr -d "," && \
		dpkg -I python-$*_*.deb  | grep Depends | cut -f2 -d":" | tr -d "," | \
				sed 's/([=>0-9. ]*)//g'| tr " " "\n" |sed 's/python-\(.*\)/python-\1.deb/' |  \
				xargs -r -n1 $(MAKE); \
	)
