# Types
## <a href="#timestamp" name="timestamp"></a> `timestamp`: `u64`
Timestamp in nanoseconds.

Size: 8

Alignment: 8

## <a href="#clock" name="clock"></a> `clock`: `Handle`
A handle providing a clock source.

Size: 4

Alignment: 4

### Supertypes
# Modules
## <a href="#wasi_ephemeral_clock" name="wasi_ephemeral_clock"></a> wasi_ephemeral_clock
### Imports
#### Memory
### Functions

---

#### <a href="#posix" name="posix"></a> `posix() -> clock`
A clock providing [POSIX time].

TODO: Convert this from a `func` to an immutable global, pending
resolution of https://github.com/WebAssembly/WASI/issues/419

[POSIX time]: https://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xbd_chap04.html#tag_21_04_16

##### Params
##### Results
- <a href="#posix.clock" name="posix.clock"></a> `clock`: [`clock`](#clock)


---

#### <a href="#monotonic" name="monotonic"></a> `monotonic() -> clock`
A clock where each successive timestamp is guaranteed to be at least as
great as the previous.

This clock starts at a nondeterministic time.

This clock should reflect wall-clock elapsed time, except that it may
nondeterministically suspend when the program itself is is suspended.

TODO: Convert this from a `func` to an immutable global, pending
resolution of https://github.com/WebAssembly/WASI/issues/419

##### Params
##### Results
- <a href="#monotonic.clock" name="monotonic.clock"></a> `clock`: [`clock`](#clock)


---

#### <a href="#resolution" name="resolution"></a> `resolution(clock: clock) -> timestamp`
Return the resolution of a clock.

The resolution of a clock is a constant non-zero value which reflects the
difference between successive distinct timestamp values from the clock.

##### Params
- <a href="#resolution.clock" name="resolution.clock"></a> `clock`: [`clock`](#clock)
The clock for which to return the resolution.

##### Results
- <a href="#resolution.resolution" name="resolution.resolution"></a> `resolution`: [`timestamp`](#timestamp)
The resolution of the clock.


---

#### <a href="#time" name="time"></a> `time(clock: clock, precision: timestamp) -> timestamp`
Return the current time value of a clock.

##### Params
- <a href="#time.clock" name="time.clock"></a> `clock`: [`clock`](#clock)
The clock for which to return the time.

- <a href="#time.precision" name="time.precision"></a> `precision`: [`timestamp`](#timestamp)
The desired precision. A value of zero requests the greatest precision
available. A non-zero value indicates that the requested time may be
less precise as long as dividing it by that value produces the same
result as it would with the greatest-precision result.

##### Results
- <a href="#time.time" name="time.time"></a> `time`: [`timestamp`](#timestamp)
The time value of the clock.

