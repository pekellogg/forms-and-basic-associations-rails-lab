class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def note_contents=(contents_arr)
    contents_arr.each do |content|
      new_note = Note.create(content: content) unless content == ""
      self.notes << new_note unless new_note.nil?
    end
  end

  def note_contents
    self.notes.map(&:content)
  end
end