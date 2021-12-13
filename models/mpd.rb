# encoding: utf-8

class Mpd

  @@state = nil

  def state
    @@state
  end

  def toggle
    mpc 'toggle'
    @@state = @@state == :playing ? :paused : :playing
  end

  def play
    mpc 'play'
    @@state = :playing
  end

  def play_idx(idx)
    mpc "play #{idx}"
    @@state = :playing
  end

  def pause
    mpc 'pause'
    @@state =  :paused
  end

  def prev
    mpc 'prev'
  end

  def next
    mpc 'next'
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
    mpc "volume #{vol}"
  end

  def volume
    mpd_client.status['volume'] || '--'
  end

  def current
    list_songs(:label, mpc("current")).first
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
