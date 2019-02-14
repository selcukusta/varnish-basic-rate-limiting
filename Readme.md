# Add Basic Rate Limiting Functionality to Varnish

*[Dictionary lookup for Varnish Cache](http://git.gnu.org.ua/cgit/vmod-dict.git/) and [Token Bucket Filtering for Varnish Cache](http://git.gnu.org.ua/cgit/vmod-tbf.git/) VMODs are used.*

Default rate limit is; `1req/5sec`. You can configure it in `configurations/ip-list.dict` file.

Run it;

```bash
vagrant up
```
