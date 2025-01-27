;; City Integration Contract

(define-map traffic-data
  { location: (tuple (lat int) (lng int)) }
  {
    congestion-level: uint,
    average-speed: uint,
    last-updated: uint
  }
)

(define-constant CITY_AUTHORITY 'SP2J6ZY48GV1EZ5V2V5RB9MP66SW86PYKKNRV9EJ7)

(define-public (update-traffic-data
  (lat int)
  (lng int)
  (congestion-level uint)
  (average-speed uint))
  (begin
    (asserts! (is-eq tx-sender CITY_AUTHORITY) (err u403))
    (map-set traffic-data
      { location: (tuple (lat lat) (lng lng)) }
      {
        congestion-level: congestion-level,
        average-speed: average-speed,
        last-updated: block-height
      }
    )
    (ok true)
  )
)

(define-read-only (get-traffic-data (lat int) (lng int))
  (map-get? traffic-data { location: (tuple (lat lat) (lng lng)) })
)

