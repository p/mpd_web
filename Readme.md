# MpdWeb
## Control mpd via web GUI


### installation

    git clone https://github.com/makevoid/mpd_web.git
	cd mpd_web
    bundle install
	
	
### launching

    bundle exec thin start
	
go to http://localhost:9292
	
	
### installing mpd

ubuntu:

    apt-get install mpd

osx:
	
	brew install mpd
	
### configuring mpd

	mpd --no-daemon -v config/mpd.conf
	mpc update


### useful links

mpd configs

https://mpd.readthedocs.io/en/latest/protocol.html
http://ubuntuforums.org/archive/index.php/t-71949.html
http://mpd.wikia.com/wiki/Configuration

man pages

http://linux.die.net/man/1/mpc

### other software

Ruby:
- https://github.com/mamantoha/mpd_client
- https://github.com/Nondv/ruby-mpd-client

- https://github.com/werkshy/pickup
- https://github.com/ambientsound/pms
- https://mpd.fandom.com/wiki/Clients
