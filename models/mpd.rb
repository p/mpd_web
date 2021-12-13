# encoding: utf-8

class Mpd

  @@state = nil

  def state
    @@state
  end

  def toggle
    mpd_client.pause
    @@state = mpd_client.status.fetch('state') == 'play'
  end

  def play
    mpd_client.play
    @@state = :playing
  end

  def play_idx(idx)
    mpc "play #{idx}"
    @@state = :playing
  end

  def pause
    mpd_client.pause(1)
    @@state =  :paused
  end

  def prev
    mpd_client.previous
  end

  def next
    mpd_client.next
  end

  def add(path)
    mpc "add \"#{path}\""
  end

  def del(idx)
    mpc "del #{idx}"
  end

  def crop
    mpc "crop"
  end

  def volume=(vol)
    mpd_client.setvol(vol)
  end

  def volume
    mpd_client.getvol || '--'
  end

  def current
    mpd_client.currentsong
  end

  def track
    mpc '-f "%title%" current'
  end

  def artist
    mpc '-f "%artist%" current'
  end

  def album
    mpc '-f "%album%" current'
  end

  def launched?
    %x(mpc 2> /dev/null)
    $? == 0
  end

  def host
    ENV['MPD_HOST'] || super
  end

  def search(name)
    mpc "search any #{name}"
  end

  def listall
    list_songs :path, mpc("listall")
  end
  alias :database :listall

  def artists
    artists = mpc("list artist").encode("UTF-8", invalid: :replace, undef: :replace)
    artists = artists.split("\n").sort
    artists.map{ |artist| Artist.new artist }
  end

  def playlist
    mpd_client.playlistinfo.map do |song|
      Song.new :label, song
    end
  end

  def artist_songs(artist)
    mpc("list artist #{artist}").encode("UTF-8", invalid: :replace, undef: :replace)
  end

  private

  def mpc(command)
    %x(mpc #{command}).strip
  end

  def list_songs(type, string)
  end

  def mpd_client
    @mpd_client ||= MPD::Client.connect('musk')
  end
end
