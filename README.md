# eugenberend_microservices

eugenberend microservices repository

Done:

- [X] Set up EFK stack
- [X] Configured fluentd with custom grok_pattern to effectively parse logs:

```conf
grok_pattern service=%{WORD:service} \| event=%{WORD:event} \| path=%{UNIXPATH:path} \| request_id=%{UUID:request_id} \| remote_addr=%{IPV4:remote_addr} \| method=%{DATA:method} \| response_status=%{INT:response_status}
```

- [X] Set up Zipkin
- [X] Troubleshot an issue with a long time of /post response

There is the broken code:

```python
# Retrieve information about a post
@zipkin_span(service_name='post', span_name='db_find_single_post')
def find_post(id):
    start_time = time.time()
    try:
        post = app.db.find_one({'_id': ObjectId(id)})
    except Exception as e:
        log_event('error', 'post_find',
                  "Failed to find the post. Reason: {}".format(str(e)),
                  request.values)
        abort(500)
    else:
        stop_time = time.time()  # + 0.3
        resp_time = stop_time - start_time
        app.post_read_db_seconds.observe(resp_time)
#        time.sleep(3)  # WTF?!
        log_event('info', 'post_find',
                  'Successfully found the post information',
                  {'post_id': id})
        return dumps(post)
```

`time.sleep(3)` needs to be commented or removed because it adds unexpected delay and makes influence to an UX.

How to run:

- Run `make`
- Then, `cd docker && docker-compose -f docker-compose.yml -f docker-compose-logging.yml up -d`
