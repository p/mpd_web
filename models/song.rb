require 'pathname'

class Song

  attr_reader :name, :artist, :type, :album, :path, :album_path

  def initialize(type, info)
    case type
    when :label
      @file = info['file']
      @last_modified = info['last-modified']
      @format = info['format']
      @name = @title = info['title']
      @artist = info['artist']
      @album = info['album']
      @track = info['track']
      @date = info['date']
      @genre = info['genre']
      @duration = info['duration']
      @pos = info.fetch('pos')
      @id = info.fetch('id')
      @type = :playlist
    when :path
      database_infos string
      @type = :database
    else
      raise "Type '#{type}' not set in Song#initialize"
    end
  end

  def database_infos(path)
    @path = Pathname.new(path)
    @dir = @path.dirname
    split = @dir.to_s.split("/")
    if split
      @artist = split[0]
      @album  = split[1] if split.size >= 2
    end
    @name = @path.basename(".*")
  end

  def attributes
    { name: name, artist: artist, type: type, album: album,  path: path }
  end

  def album_path
    "#{@artist}/#{@album}"
  end

end
