#!/usr/bin/env ruby
#    Rubyripper - A secure ripper for Linux/BSD/OSX
#    Copyright (C) 2007 - 2011 Bouke Woudstra (boukewoudstra@gmail.com)
#
#    This file is part of Rubyripper. Rubyripper is free software: you can
#    redistribute it and/or modify it under the terms of the GNU General
#    Public License as published by the Free Software Foundation, either
#    version 3 of the License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>

require 'rubyripper/metadata/data.rb'

# This class is a 'fake' provider (used when all other providers have failed).
# It simply fills the  metadata's tracklist with default track names.
class NoProvider
  attr_reader :status

  def initialize(disc)
    @disc = disc
    @md = Metadata::Data.new()
  end

  # get metadata for the disca
  def get()
    # generate default track list (using default track names)
    (1..@disc.audiotracks).each do |track|
      @md.setTrackname(track, @md.trackname(track))
    end
    @status = 'ok'
  end

  private
  
  # if the method is not found try to look it up in the data object
  def method_missing(name, *args)
    @md.send(name, *args)
  end
end
