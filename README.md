# rt-berlin-july-2019
make an infographic from my photos of berlin july 19-26, 2019

## November 26, 2019

```bash
mkdir 75x75
cd 75x75
# set id is: 72157709917594396 which comes from the album url:
# https://www.flickr.com/photos/roland/albums/72157709917594396
./get-thumbnail-75-berlin-2019.rb 72157709917594396 2>/tmp/log.txt >berlin2019-url-75x75.txt
cat ../berlin2019-url-75x75.txt  | ../backup75x75.rb
# 2100/75 = 28, 1800/75 = 24, 24 * 28 = 672
find . -type f | shuf -n672 > rt-berlin-july2019-672files.txt 
mkdir CIRCULAR
cat rt-berlin-july2019-672files.txt | parallel magick '{}' -vignette 0x0+0+0 'CIRCULAR/{}'
cd CIRCULAR
ls -1 *.jpg > 672jpgs.txt
montage -verbose -adjoin -tile 24x28 +frame +shadow +label -adjoin -geometry '75x75+0+0<' @672jpgs.txt rt-berlin-12-14-75x75.jpg
```
## November 25, 2019

```bash
mkdir 150x150
cd 150x150
# set id is: 72157709917594396 which comes from the album url:
# https://www.flickr.com/photos/roland/albums/72157709917594396
./get-thumbnail-150-berlin-2019.rb 72157709917594396 2>/tmp/log.txt >berlin2019-url-150x150.txt
cat ../berlin2019-url-150x150.txt  | ../backup150x150.rb
# 2100/150 = 14, 1800.150 = 12, 12* 14 = 168
find . -type f | shuf -n168 > rt-berlin-july2019-168files.txt 
mkdir CIRCULAR
cat rt-berlin-july2019-168files.txt | parallel magick '{}' -vignette 0x0+0+0 'CIRCULAR/{}'
cd CIRCULAR
ls -1 *.jpg > 168jpgs.txt
montage -verbose -adjoin -tile 12x14 +frame +shadow +label -adjoin -geometry '150x150+0+0<' @168jpgs.txt rt-berlin-12-14-150x150.jpg
```
