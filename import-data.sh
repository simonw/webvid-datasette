# Assumes you have first downloaded the CSV:
# wget http://www.robots.ox.ac.uk/~maxbain/webvid/results_10M_train.csv
sqlite3 webvid-full.db <<EOS
.mode csv
.import results_10M_train.csv videos
EOS
