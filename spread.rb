#
# spread.rb -- Charlotte Koch <dressupgeekout@gmail.com>
#
# To effectively use this file, invoke Ruby like this:
#
#     $ ruby -an -r ./spread script.rb spreadsheet.spread
#
# Your Ruby script should have the following line somewhere:
#
#     next if blank?
#

require 'English'

$FS = /\t+/
$RS = "\n"
$OFS = " "
$ORS = "\n"

def blank?
  return ($_ =~ /^\s+$/ or $_ =~ /^\#/)
end
