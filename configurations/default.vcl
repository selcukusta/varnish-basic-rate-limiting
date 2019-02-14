vcl 4.0;
import tbf;
import dict;

backend
default {
  .host = "127.0.0.1";
  .port = "8080";
}

sub vcl_init {
  dict.load("/var/lib/cache/ip-list.dict");
}

sub vcl_recv {
  if (dict.lookup(client.ip)) {
    if (!tbf.check(client.ip, dict.lookup(client.ip))) {
      return (synth(429, "API Request rate exceeded."));
    } else {
      return (synth(750));
    }
  }
  return (synth(405, "Don't have permission to access this resource."));
}

sub vcl_synth {
  if (resp.status == 750) {
    set resp.status = 200;
    synthetic("Hello citizen!");
    return (deliver);
  }
}