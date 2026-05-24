@always_inline
def _rotate_left(x: UInt32, n: UInt32) -> UInt32:
    return (x << n) | (x >> (32 - n))
