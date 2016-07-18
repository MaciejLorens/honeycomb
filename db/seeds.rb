require 'resource_downloader'

ResourceDownloader.download

r = Resource.first
r.update(title: 'sample_title')
r.update(year: 2013)
r.update(episode: 's01e02')
r.update(title: 'sample_title_2')
