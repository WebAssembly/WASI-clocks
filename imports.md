<h1><a name="imports">World imports</a></h1>
<ul>
<li>Imports:
<ul>
<li>interface <a href="#wasi_io_poll_0_2_0"><code>wasi:io/poll@0.2.0</code></a></li>
<li>interface <a href="#wasi_clocks_monotonic_clock_0_2_0"><code>wasi:clocks/monotonic-clock@0.2.0</code></a></li>
<li>interface <a href="#wasi_clocks_system_clock_0_2_0"><code>wasi:clocks/system-clock@0.2.0</code></a></li>
<li>interface <a href="#wasi_clocks_timezone_0_2_0"><code>wasi:clocks/timezone@0.2.0</code></a></li>
</ul>
</li>
</ul>
<h2><a name="wasi_io_poll_0_2_0"></a>Import interface wasi:io/poll@0.2.0</h2>
<p>A poll API intended to let users wait for I/O events on multiple handles
at once.</p>
<hr />
<h3>Types</h3>
<h4><a name="pollable"></a><code>resource pollable</code></h4>
<h2><a href="#pollable"><code>pollable</code></a> represents a single I/O event which may be ready, or not.</h2>
<h3>Functions</h3>
<h4><a name="method_pollable_ready"></a><code>[method]pollable.ready: func</code></h4>
<p>Return the readiness of a pollable. This function never blocks.</p>
<p>Returns <code>true</code> when the pollable is ready, and <code>false</code> otherwise.</p>
<h5>Params</h5>
<ul>
<li><a name="method_pollable_ready.self"></a><code>self</code>: borrow&lt;<a href="#pollable"><a href="#pollable"><code>pollable</code></a></a>&gt;</li>
</ul>
<h5>Return values</h5>
<ul>
<li><a name="method_pollable_ready.0"></a> <code>bool</code></li>
</ul>
<h4><a name="method_pollable_block"></a><code>[method]pollable.block: func</code></h4>
<p><code>block</code> returns immediately if the pollable is ready, and otherwise
blocks until ready.</p>
<p>This function is equivalent to calling <code>poll.poll</code> on a list
containing only this pollable.</p>
<h5>Params</h5>
<ul>
<li><a name="method_pollable_block.self"></a><code>self</code>: borrow&lt;<a href="#pollable"><a href="#pollable"><code>pollable</code></a></a>&gt;</li>
</ul>
<h4><a name="poll"></a><code>poll: func</code></h4>
<p>Poll for completion on a set of pollables.</p>
<p>This function takes a list of pollables, which identify I/O sources of
interest, and waits until one or more of the events is ready for I/O.</p>
<p>The result <code>list&lt;u32&gt;</code> contains one or more indices of handles in the
argument list that is ready for I/O.</p>
<p>If the list contains more elements than can be indexed with a <code>u32</code>
value, this function traps.</p>
<p>A timeout can be implemented by adding a pollable from the
wasi-clocks API to the list.</p>
<p>This function does not return a <code>result</code>; polling in itself does not
do any I/O so it doesn't fail. If any of the I/O sources identified by
the pollables has an error, it is indicated by marking the source as
being reaedy for I/O.</p>
<h5>Params</h5>
<ul>
<li><a name="poll.in"></a><code>in</code>: list&lt;borrow&lt;<a href="#pollable"><a href="#pollable"><code>pollable</code></a></a>&gt;&gt;</li>
</ul>
<h5>Return values</h5>
<ul>
<li><a name="poll.0"></a> list&lt;<code>u32</code>&gt;</li>
</ul>
<h2><a name="wasi_clocks_monotonic_clock_0_2_0"></a>Import interface wasi:clocks/monotonic-clock@0.2.0</h2>
<p>WASI Monotonic Clock is a clock API intended to let users measure elapsed
time.</p>
<p>It is intended to be portable at least between Unix-family platforms and
Windows.</p>
<p>A monotonic clock is a clock which has an unspecified initial value, and
successive reads of the clock will produce non-decreasing values.</p>
<hr />
<h3>Types</h3>
<h4><a name="pollable"></a><code>type pollable</code></h4>
<p><a href="#pollable"><a href="#pollable"><code>pollable</code></a></a></p>
<p>
#### <a name="monotonic_clock_point"></a>`type monotonic-clock-point`
`u64`
<p>A monotonic clock point in nanoseconds. A clock point is relative to an
unspecified initial value, and can only be compared to instances from
the same monotonic-clock.
<h4><a name="duration"></a><code>type duration</code></h4>
<p><code>u64</code></p>
<p>A duration of time, in nanoseconds.
<hr />
<h3>Functions</h3>
<h4><a name="now"></a><code>now: func</code></h4>
<p>Read the current value of the clock.</p>
<p>The clock is monotonic, therefore calling this function repeatedly will
produce a sequence of non-decreasing values.</p>
<h5>Return values</h5>
<ul>
<li><a name="now.0"></a> <a href="#monotonic_clock_point"><a href="#monotonic_clock_point"><code>monotonic-clock-point</code></a></a></li>
</ul>
<h4><a name="resolution"></a><code>resolution: func</code></h4>
<p>Query the resolution of the clock. Returns the duration of time
corresponding to a clock tick.</p>
<h5>Return values</h5>
<ul>
<li><a name="resolution.0"></a> <a href="#duration"><a href="#duration"><code>duration</code></a></a></li>
</ul>
<h4><a name="subscribe_clock_point"></a><code>subscribe-clock-point: func</code></h4>
<p>Create a <a href="#pollable"><code>pollable</code></a> which will resolve once the specified clock point
has occured.</p>
<h5>Params</h5>
<ul>
<li><a name="subscribe_clock_point.when"></a><code>when</code>: <a href="#monotonic_clock_point"><a href="#monotonic_clock_point"><code>monotonic-clock-point</code></a></a></li>
</ul>
<h5>Return values</h5>
<ul>
<li><a name="subscribe_clock_point.0"></a> own&lt;<a href="#pollable"><a href="#pollable"><code>pollable</code></a></a>&gt;</li>
</ul>
<h4><a name="subscribe_duration"></a><code>subscribe-duration: func</code></h4>
<p>Create a <a href="#pollable"><code>pollable</code></a> that will resolve after the specified duration has
elapsed from the time this function is invoked.</p>
<h5>Params</h5>
<ul>
<li><a name="subscribe_duration.when"></a><code>when</code>: <a href="#duration"><a href="#duration"><code>duration</code></a></a></li>
</ul>
<h5>Return values</h5>
<ul>
<li><a name="subscribe_duration.0"></a> own&lt;<a href="#pollable"><a href="#pollable"><code>pollable</code></a></a>&gt;</li>
</ul>
<h2><a name="wasi_clocks_system_clock_0_2_0"></a>Import interface wasi:clocks/system-clock@0.2.0</h2>
<p>WASI System Clock is a clock API intended to let users query the current
time. The clock is not necessarily monotonic as it may be reset.</p>
<p>It is intended to be portable at least between Unix-family platforms and
Windows.</p>
<p>An &quot;instant&quot;, or &quot;exact time&quot;, is a point in time without regard to any time
zone: just the time since a particular external reference point, often
called an &quot;epoch&quot;.</p>
<p>External references may be reset, so this clock is not necessarily
monotonic, making it unsuitable for measuring elapsed time.</p>
<p>It is intended for reporting the current date and time for humans.</p>
<hr />
<h3>Types</h3>
<h4><a name="instant"></a><code>record instant</code></h4>
<p>An exact time in seconds plus nanoseconds.</p>
<h5>Record Fields</h5>
<ul>
<li><a name="instant.seconds"></a><code>seconds</code>: <code>u64</code></li>
<li><a name="instant.nanoseconds"></a><code>nanoseconds</code>: <code>u32</code></li>
</ul>
<hr />
<h3>Functions</h3>
<h4><a name="now"></a><code>now: func</code></h4>
<p>Read the current value of the clock.</p>
<p>This clock is not monotonic, therefore calling this function repeatedly
will not necessarily produce a sequence of non-decreasing values.</p>
<p>The returned timestamps represent the number of seconds since
1970-01-01T00:00:00Z, also known as <a href="https://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xbd_chap04.html#tag_21_04_16">POSIX's Seconds Since the Epoch</a>,
also known as <a href="https://en.wikipedia.org/wiki/Unix_time">Unix Time</a>.</p>
<p>The nanoseconds field of the output is always less than 1000000000.</p>
<h5>Return values</h5>
<ul>
<li><a name="now.0"></a> <a href="#instant"><a href="#instant"><code>instant</code></a></a></li>
</ul>
<h4><a name="resolution"></a><code>resolution: func</code></h4>
<p>Query the resolution of the clock.</p>
<p>The nanoseconds field of the output is always less than 1000000000.</p>
<h5>Return values</h5>
<ul>
<li><a name="resolution.0"></a> <a href="#instant"><a href="#instant"><code>instant</code></a></a></li>
</ul>
<h2><a name="wasi_clocks_timezone_0_2_0"></a>Import interface wasi:clocks/timezone@0.2.0</h2>
<hr />
<h3>Types</h3>
<h4><a name="instant"></a><code>type instant</code></h4>
<p><a href="#instant"><a href="#instant"><code>instant</code></a></a></p>
<p>
#### <a name="timezone_display"></a>`record timezone-display`
<p>Information useful for displaying a specific <a href="#instant"><code>instant</code></a> in the currently
configured time zone.</p>
<h5>Record Fields</h5>
<ul>
<li>
<p><a name="timezone_display.utc_offset"></a><a href="#utc_offset"><code>utc-offset</code></a>: <code>s64</code></p>
<p>The number of nanoseconds difference between UTC time and the local
time of the timezone.
<p>The returned value will always be less than 86,400,000,000,000 which
is the number of nanoseconds in a day (24<em>60</em>60*1e9).</p>
<p>In implementations that do not expose an actual time zone, this
should return 0.</p>
</li>
<li>
<p><a name="timezone_display.id"></a><code>id</code>: <code>string</code></p>
<p>The IANA identifier of the timezone. The id `UTC` indicates
Coordinated Universal Time. Otherwise, this should be an identifier
from the IANA Time Zone Database.
<p>For displaying to a user, the identifier should be converted into a
localized name by means of an internationalization API.</p>
<p>In implementations that do not expose an actual time zone, this
should be the string <code>UTC</code>.</p>
<p>In time zones that do not have an applicable name, a formatted
representation of the UTC offset may be returned, such as <code>-04:00</code>.</p>
</li>
</ul>
<hr />
<h3>Functions</h3>
<h4><a name="display"></a><code>display: func</code></h4>
<p>Return information needed to display the given <a href="#instant"><code>instant</code></a> in the
currently configured time zone. This includes the UTC offset and the
time zone name.</p>
<p>If the currently configured timezone cannot be determined, return a
<a href="#timezone_display"><code>timezone-display</code></a> for <code>UTC</code> with a <a href="#utc_offset"><code>utc-offset</code></a> of 0.</p>
<h5>Params</h5>
<ul>
<li><a name="display.when"></a><code>when</code>: <a href="#instant"><a href="#instant"><code>instant</code></a></a></li>
</ul>
<h5>Return values</h5>
<ul>
<li><a name="display.0"></a> <a href="#timezone_display"><a href="#timezone_display"><code>timezone-display</code></a></a></li>
</ul>
<h4><a name="utc_offset"></a><code>utc-offset: func</code></h4>
<p>The same as <a href="#display"><code>display</code></a>, but only return the UTC offset.</p>
<h5>Params</h5>
<ul>
<li><a name="utc_offset.when"></a><code>when</code>: <a href="#instant"><a href="#instant"><code>instant</code></a></a></li>
</ul>
<h5>Return values</h5>
<ul>
<li><a name="utc_offset.0"></a> <code>s64</code></li>
</ul>
