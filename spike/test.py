# https://data.qld.gov.au/dataset/translink-real-time-data/resource/bbb1af09-e85b-414c-bac5-85005767361e

# https://gtfsrt.api.translink.com.au/feed/seq

# https://opendata.transport.nsw.gov.au/dataset/public-transport-realtime-trip-update

# http://www.transperth.wa.gov.au/About/Spatial-Data-Access

# https://www.adelaidemetro.com.au/Developer-Information
# https://developers.google.com/protocol-buffers/

# https://github.com/google/gtfs-realtime-bindings
# https://developers.google.com/transit/gtfs-realtime/gtfs-realtime-proto
# https://github.com/google/transit/blob/master/gtfs-realtime/spec/en/reference.md
# https://github.com/google/protobuf/blob/master/python/google/protobuf/json_format.py

# https://thenounproject.com/term/ground-transportation/59/

# https://developers.google.com/transit/gtfs/reference/


from google.transit import gtfs_realtime_pb2
import requests
import json
from google.protobuf import json_format


feed = gtfs_realtime_pb2.FeedMessage()
response = requests.get('https://gtfsrt.api.translink.com.au/feed/seq')
feed.ParseFromString(response.content)


# print(feed.header)
# print
# print
# print
# print

entity = feed.entity[0]
print entity
j = json_format.MessageToJson(entity)

# print(j)
# json_t = json.loads(j)
# print(json.dumps(j))
# print(json.dumps(json_t))


# print
# print
# print
# print
# print json.dumps(entity.trip_update.trip)
# print json.dumps(entity.trip_update.vehicle)
# print json.dumps(entity.trip_update)

# print entity
# print feed

# for entity in feed.entity:
# for entity in feed.entity[0]:
# # for entity in next(feed.entity or []), None):
   # if entity.HasField('trip_update'):
      # print entity.trip_update
#    # if entity.HasField('vehicle'):
#       # print entity.vehicle
#       # print json.dumps(entity)
#       print (entity)

   # if entity.HasField('alert'):
   #    print entity