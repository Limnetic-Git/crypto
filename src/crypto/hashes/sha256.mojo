comptime SHA256_K0: UInt32 = 0x428a2f98
comptime SHA256_K1: UInt32 = 0x71374491
comptime SHA256_K2: UInt32 = 0xb5c0fbcf
comptime SHA256_K3: UInt32 = 0xe9b5dba5
comptime SHA256_K4: UInt32 = 0x3956c25b
comptime SHA256_K5: UInt32 = 0x59f111f1
comptime SHA256_K6: UInt32 = 0x923f82a4
comptime SHA256_K7: UInt32 = 0xab1c5ed5
comptime SHA256_K8: UInt32 = 0xd807aa98
comptime SHA256_K9: UInt32 = 0x12835b01
comptime SHA256_K10: UInt32 = 0x243185be
comptime SHA256_K11: UInt32 = 0x550c7dc3
comptime SHA256_K12: UInt32 = 0x72be5d74
comptime SHA256_K13: UInt32 = 0x80deb1fe
comptime SHA256_K14: UInt32 = 0x9bdc06a7
comptime SHA256_K15: UInt32 = 0xc19bf174
comptime SHA256_K16: UInt32 = 0xe49b69c1
comptime SHA256_K17: UInt32 = 0xefbe4786
comptime SHA256_K18: UInt32 = 0x0fc19dc6
comptime SHA256_K19: UInt32 = 0x240ca1cc
comptime SHA256_K20: UInt32 = 0x2de92c6f
comptime SHA256_K21: UInt32 = 0x4a7484aa
comptime SHA256_K22: UInt32 = 0x5cb0a9dc
comptime SHA256_K23: UInt32 = 0x76f988da
comptime SHA256_K24: UInt32 = 0x983e5152
comptime SHA256_K25: UInt32 = 0xa831c66d
comptime SHA256_K26: UInt32 = 0xb00327c8
comptime SHA256_K27: UInt32 = 0xbf597fc7
comptime SHA256_K28: UInt32 = 0xc6e00bf3
comptime SHA256_K29: UInt32 = 0xd5a79147
comptime SHA256_K30: UInt32 = 0x06ca6351
comptime SHA256_K31: UInt32 = 0x14292967
comptime SHA256_K32: UInt32 = 0x27b70a85
comptime SHA256_K33: UInt32 = 0x2e1b2138
comptime SHA256_K34: UInt32 = 0x4d2c6dfc
comptime SHA256_K35: UInt32 = 0x53380d13
comptime SHA256_K36: UInt32 = 0x650a7354
comptime SHA256_K37: UInt32 = 0x766a0abb
comptime SHA256_K38: UInt32 = 0x81c2c92e
comptime SHA256_K39: UInt32 = 0x92722c85
comptime SHA256_K40: UInt32 = 0xa2bfe8a1
comptime SHA256_K41: UInt32 = 0xa81a664b
comptime SHA256_K42: UInt32 = 0xc24b8b70
comptime SHA256_K43: UInt32 = 0xc76c51a3
comptime SHA256_K44: UInt32 = 0xd192e819
comptime SHA256_K45: UInt32 = 0xd6990624
comptime SHA256_K46: UInt32 = 0xf40e3585
comptime SHA256_K47: UInt32 = 0x106aa070
comptime SHA256_K48: UInt32 = 0x19a4c116
comptime SHA256_K49: UInt32 = 0x1e376c08
comptime SHA256_K50: UInt32 = 0x2748774c
comptime SHA256_K51: UInt32 = 0x34b0bcb5
comptime SHA256_K52: UInt32 = 0x391c0cb3
comptime SHA256_K53: UInt32 = 0x4ed8aa4a
comptime SHA256_K54: UInt32 = 0x5b9cca4f
comptime SHA256_K55: UInt32 = 0x682e6ff3
comptime SHA256_K56: UInt32 = 0x748f82ee
comptime SHA256_K57: UInt32 = 0x78a5636f
comptime SHA256_K58: UInt32 = 0x84c87814
comptime SHA256_K59: UInt32 = 0x8cc70208
comptime SHA256_K60: UInt32 = 0x90befffa
comptime SHA256_K61: UInt32 = 0xa4506ceb
comptime SHA256_K62: UInt32 = 0xbef9a3f7
comptime SHA256_K63: UInt32 = 0xc67178f2

@always_inline
def _sha256_rotate_right(value: UInt32, shift: Int) -> UInt32:
    return (value >> UInt32(shift)) | (value << UInt32(32 - shift))

@always_inline
def _sha256_ch(x: UInt32, y: UInt32, z: UInt32) -> UInt32:
    return (x & y) ^ (~x & z)

@always_inline
def _sha256_maj(x: UInt32, y: UInt32, z: UInt32) -> UInt32:
    return (x & y) ^ (x & z) ^ (y & z)

@always_inline
def _sha256_sigma0(x: UInt32) -> UInt32:
    return _sha256_rotate_right(x, 2) ^ _sha256_rotate_right(x, 13) ^ _sha256_rotate_right(x, 22)

@always_inline
def _sha256_sigma1(x: UInt32) -> UInt32:
    return _sha256_rotate_right(x, 6) ^ _sha256_rotate_right(x, 11) ^ _sha256_rotate_right(x, 25)

@always_inline
def _sha256_gamma0(x: UInt32) -> UInt32:
    return _sha256_rotate_right(x, 7) ^ _sha256_rotate_right(x, 18) ^ (x >> 3)

@always_inline
def _sha256_gamma1(x: UInt32) -> UInt32:
    return _sha256_rotate_right(x, 17) ^ _sha256_rotate_right(x, 19) ^ (x >> 10)

@always_inline
def _sha256_get_k(t: Int) -> UInt32:
    if t == 0: return SHA256_K0
    elif t == 1: return SHA256_K1
    elif t == 2: return SHA256_K2
    elif t == 3: return SHA256_K3
    elif t == 4: return SHA256_K4
    elif t == 5: return SHA256_K5
    elif t == 6: return SHA256_K6
    elif t == 7: return SHA256_K7
    elif t == 8: return SHA256_K8
    elif t == 9: return SHA256_K9
    elif t == 10: return SHA256_K10
    elif t == 11: return SHA256_K11
    elif t == 12: return SHA256_K12
    elif t == 13: return SHA256_K13
    elif t == 14: return SHA256_K14
    elif t == 15: return SHA256_K15
    elif t == 16: return SHA256_K16
    elif t == 17: return SHA256_K17
    elif t == 18: return SHA256_K18
    elif t == 19: return SHA256_K19
    elif t == 20: return SHA256_K20
    elif t == 21: return SHA256_K21
    elif t == 22: return SHA256_K22
    elif t == 23: return SHA256_K23
    elif t == 24: return SHA256_K24
    elif t == 25: return SHA256_K25
    elif t == 26: return SHA256_K26
    elif t == 27: return SHA256_K27
    elif t == 28: return SHA256_K28
    elif t == 29: return SHA256_K29
    elif t == 30: return SHA256_K30
    elif t == 31: return SHA256_K31
    elif t == 32: return SHA256_K32
    elif t == 33: return SHA256_K33
    elif t == 34: return SHA256_K34
    elif t == 35: return SHA256_K35
    elif t == 36: return SHA256_K36
    elif t == 37: return SHA256_K37
    elif t == 38: return SHA256_K38
    elif t == 39: return SHA256_K39
    elif t == 40: return SHA256_K40
    elif t == 41: return SHA256_K41
    elif t == 42: return SHA256_K42
    elif t == 43: return SHA256_K43
    elif t == 44: return SHA256_K44
    elif t == 45: return SHA256_K45
    elif t == 46: return SHA256_K46
    elif t == 47: return SHA256_K47
    elif t == 48: return SHA256_K48
    elif t == 49: return SHA256_K49
    elif t == 50: return SHA256_K50
    elif t == 51: return SHA256_K51
    elif t == 52: return SHA256_K52
    elif t == 53: return SHA256_K53
    elif t == 54: return SHA256_K54
    elif t == 55: return SHA256_K55
    elif t == 56: return SHA256_K56
    elif t == 57: return SHA256_K57
    elif t == 58: return SHA256_K58
    elif t == 59: return SHA256_K59
    elif t == 60: return SHA256_K60
    elif t == 61: return SHA256_K61
    elif t == 62: return SHA256_K62
    else: return SHA256_K63

def sha256(data: Span[UInt8, ...]) -> SHA256Digest:
    """
    Compute the SHA-256 digest of the given data.

    SHA-256 is a cryptographic hash function that produces a 256-bit (32-byte)
    hash value. It is part of the SHA-2 family and is widely used for
    cryptographic applications including digital signatures, message authentication,
    and data integrity verification.

    Args:
        data: Input bytes to hash.

    Returns:
        SHA256Digest: A 256-bit (32-byte) digest object with methods to access
        the result as raw bytes or a hex string.
    """

    var zero_bytes_padding = (56 - (len(data) + 1)) % 64

    var message = List[UInt8]()
    for i in range(len(data)):
        message.append(data[i])

    message.append(0x80)
    for _ in range(zero_bytes_padding):
        message.append(0x00)

    var original_message_bit_length = UInt64(len(data)) * 8
    message.append((UInt8(original_message_bit_length >> 56) & 0xFF))
    message.append((UInt8(original_message_bit_length >> 48) & 0xFF))
    message.append((UInt8(original_message_bit_length >> 40) & 0xFF))
    message.append((UInt8(original_message_bit_length >> 32) & 0xFF))
    message.append((UInt8(original_message_bit_length >> 24) & 0xFF))
    message.append((UInt8(original_message_bit_length >> 16) & 0xFF))
    message.append((UInt8(original_message_bit_length >> 8) & 0xFF))
    message.append(UInt8(original_message_bit_length & 0xFF))

    var h0: UInt32 = 0x6a09e667
    var h1: UInt32 = 0xbb67ae85
    var h2: UInt32 = 0x3c6ef372
    var h3: UInt32 = 0xa54ff53a
    var h4: UInt32 = 0x510e527f
    var h5: UInt32 = 0x9b05688c
    var h6: UInt32 = 0x1f83d9ab
    var h7: UInt32 = 0x5be0cd19

    var n = 0
    while n < len(message):
        var w = List[UInt32]()
        for j in range(16):
            var base = n + (j * 4)
            var word = UInt32(message[base]) << 24
            word |= UInt32(message[base + 1]) << 16
            word |= UInt32(message[base + 2]) << 8
            word |= UInt32(message[base + 3])
            w.append(word)

        for t in range(16, 64):
            var x = _sha256_gamma1(w[t - 2]) + w[t - 7] + _sha256_gamma0(w[t - 15]) + w[t - 16]
            w.append(x)

        var a = h0
        var b = h1
        var c = h2
        var d = h3
        var e = h4
        var f = h5
        var g = h6
        var h = h7

        for t in range(64):
            var S1 = _sha256_sigma1(e)
            var ch = _sha256_ch(e, f, g)
            var temp1 = h + S1 + ch + _sha256_get_k(t) + w[t]
            var S0 = _sha256_sigma0(a)
            var maj = _sha256_maj(a, b, c)
            var temp2 = S0 + maj

            h = g
            g = f
            f = e
            e = d + temp1
            d = c
            c = b
            b = a
            a = temp1 + temp2

        h0 += a
        h1 += b
        h2 += c
        h3 += d
        h4 += e
        h5 += f
        h6 += g
        h7 += h

        n += 64

    return SHA256Digest(h0, h1, h2, h3, h4, h5, h6, h7)

@fieldwise_init
struct SHA256Digest:
    """
    SHA-256 hash digest.

    Represents a 256-bit SHA-256 digest, stored internally as eight 32-bit state
    words. Use `to_bytes()` to export the digest as a 32-byte big-endian list
    or `to_hex()` to get a 64-character lowercase hexadecimal string.
    """

    var h0: UInt32
    var h1: UInt32
    var h2: UInt32
    var h3: UInt32
    var h4: UInt32
    var h5: UInt32
    var h6: UInt32
    var h7: UInt32

    def to_bytes(self) -> List[UInt8]:
        """
        Export the digest as a list of 32 bytes.

        Returns:
            List[UInt8]: The 32-byte SHA-256 digest in big-endian byte order
            (standard SHA-256 output format).
        """
        var out = List[UInt8](capacity=32)

        for h in [self.h0, self.h1, self.h2, self.h3, self.h4, self.h5, self.h6, self.h7]:
            out.append(UInt8((h >> 24) & 0xFF))
            out.append(UInt8((h >> 16) & 0xFF))
            out.append(UInt8((h >> 8) & 0xFF))
            out.append(UInt8(h & 0xFF))
        return out^

    def to_hex(self) -> String:
        """
        Export the digest as a lowercase hexadecimal string.

        Returns:
            String: A 64-character lowercase hex string representation of the digest.
        """
        var bytes = self.to_bytes()
        var result = String()
        var hex_chars = "0123456789abcdef"

        for byte in bytes:
            result += hex_chars[byte=Int((byte >> 4) & 0xF)]
            result += hex_chars[byte=Int(byte & 0xF)]
        return result
