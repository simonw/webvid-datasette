from datasette import hookimpl
from markupsafe import Markup, escape

TEMPLATE = """
<video controls width="400" preload="none" poster="{poster}">
  <source src="{url}" type="video/mp4">
</video>
<p>{filename}<br>On <a href="https://www.shutterstock.com/video/clip-{id}">Shutterstock</a></p>
""".strip()
VIDEO_URL = "https://ak.picdn.net/shutterstock/videos/{id}/preview/{filename}"
POSTER_URL = "https://ak.picdn.net/shutterstock/videos/{id}/thumb/1.jpg?ip=x480"


@hookimpl
def render_cell(row, column, value):
    if column != "filename":
        return
    id = row["id"]
    url = VIDEO_URL.format(id=id, filename=escape(value))
    poster = POSTER_URL.format(id=id)
    return Markup(TEMPLATE.format(url=url, poster=poster, filename=escape(value), id=id))
