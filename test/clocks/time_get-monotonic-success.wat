(module
  (import "wasi_snapshot_preview1" "clock_time_get" (func $time_get (param i32 i64 i32) (result i32)))
  (memory 1)
  (export "memory" (memory 0))
  (func $_start
    i32.const 1
    i64.const 0
    i32.const 0
    call $time_get
    if
      unreachable
    end
  )
  (export "_start" (func $_start))
)
