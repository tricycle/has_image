versionstring = `Magick-config --version`
abort "has_image needs ImageMagick, but it was not found in PATH. Is it installed? 
  (called from #{__FILE__})" if versionstring.blank?

# ImageMagick version that supports square thumbnails
# http://www.imagemagick.org/script/command-line-options.php#resize
minimum_version = [6,3,9]

def right_imagemagick_version?(required, found)
  actual = found.match(/^(\d)\.(\d)\.(\d)/).captures.collect(&:to_i)
  actual[0] > required[0] ||
    actual[0] == required[0] && actual[1] >= required[1] ||
    actual[0] == required[0] && actual[1] == required[1] && actual[2] >= required[2]
end

unless right_imagemagick_version?(minimum_version, versionstring)
  abort "has_image needs at least ImageMagick #{minimum_version.join('.')}. 
    You have #{versionstring} installed. (called from #{__FILE__})"
end

require 'has_image'
