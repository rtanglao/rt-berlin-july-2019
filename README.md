# rt-berlin-july-2019
make an infographic from my photos of berlin july 19-26, 2019
## November 25, 2019

```bash
./get-thumbnail-150-berlin-2019.rb 72157709917594396 2>/tmp/log.txt >berlin2019-url-150x150.txt
cd 150x150
cat ../berlin2019-url-150x150.txt  | ../backup150x150.rb
# 2100/150 = 14, 1800.150 = 12, 12* 14 = 168
find . -type f | shuf -n168 > rt-berlin-july2019-168files.txt 

```
