# Create the webvid.db database with a single table
sqlite-utils create-table webvid.db videos \
  id integer \
  filename text \
  text text \
  --pk id

# Populate that database from webvid-full.db
sqlite-utils webvid.db \
  --attach webvidfull webvid-full.db \
  'with deduped as (
  select videoId, contentUrl, name, max(length(name)) as name_length
  from webvidfull.videos
  where videoId in (1027554365, 1029758273, 1052157394, 1052848322, 1053483260, 1055934521, 1058060785, 1058262253, 1059086294, 1059150260, 1059155453, 1062722287, 1064336623, 1065521032, 1065867481, 1066032061, 1066665631, 1066676881, 1066678225, 1066681330, 1066696999, 1066697260, 2974183, 583333, 7781875)
  group by videoId
)
insert into videos (id, filename, text)
select videoId, filename(contentUrl), name from deduped
union
select videoid, filename(contentUrl), name from webvidfull.videos
where videoid not in (
  1027554365, 1029758273, 1052157394, 1052848322, 1053483260, 1055934521, 1058060785, 1058262253, 1059086294, 1059150260, 1059155453, 1062722287, 1064336623, 1065521032, 1065867481, 1066032061, 1066665631, 1066676881, 1066678225, 1066681330, 1066696999, 1066697260, 2974183, 583333, 7781875
)
' --functions '
def filename(url):
    return url.split("/")[-1]
'

# Enable search
sqlite-utils enable-fts webvid.db videos name
