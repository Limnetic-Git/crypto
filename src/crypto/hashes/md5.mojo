from ..helpers import _rotate_left, _to_hex

comptime _t: SIMD[DType.uint32, 64] = [
    0xD76AA478,
    0xE8C7B756,
    0x242070DB,
    0xC1BDCEEE,
    0xF57C0FAF,
    0x4787C62A,
    0xA8304613,
    0xFD469501,
    0x698098D8,
    0x8B44F7AF,
    0xFFFF5BB1,
    0x895CD7BE,
    0x6B901122,
    0xFD987193,
    0xA679438E,
    0x49B40821,
    0xF61E2562,
    0xC040B340,
    0x265E5A51,
    0xE9B6C7AA,
    0xD62F105D,
    0x2441453,
    0xD8A1E681,
    0xE7D3FBC8,
    0x21E1CDE6,
    0xC33707D6,
    0xF4D50D87,
    0x455A14ED,
    0xA9E3E905,
    0xFCEFA3F8,
    0x676F02D9,
    0x8D2A4C8A,
    0xFFFA3942,
    0x8771F681,
    0x6D9D6122,
    0xFDE5380C,
    0xA4BEEA44,
    0x4BDECFA9,
    0xF6BB4B60,
    0xBEBFBC70,
    0x289B7EC6,
    0xEAA127FA,
    0xD4EF3085,
    0x4881D05,
    0xD9D4D039,
    0xE6DB99E5,
    0x1FA27CF8,
    0xC4AC5665,
    0xF4292244,
    0x432AFF97,
    0xAB9423A7,
    0xFC93A039,
    0x655B59C3,
    0x8F0CCC92,
    0xFFEFF47D,
    0x85845DD1,
    0x6FA87E4F,
    0xFE2CE6E0,
    0xA3014314,
    0x4E0811A1,
    0xF7537E82,
    0xBD3AF235,
    0x2AD7D2BB,
    0xEB86D391,
]


@always_inline
def _f(x: UInt32, y: UInt32, z: UInt32) -> UInt32:
    return (x & y) | ((~x) & z)


@always_inline
def _g(x: UInt32, y: UInt32, z: UInt32) -> UInt32:
    return (x & z) | (y & (~z))


@always_inline
def _h(x: UInt32, y: UInt32, z: UInt32) -> UInt32:
    return x ^ y ^ z


@always_inline
def _i(x: UInt32, y: UInt32, z: UInt32) -> UInt32:
    return y ^ (x | (~z))


@always_inline
def _first_round(
    mut a: UInt32,
    b: UInt32,
    c: UInt32,
    d: UInt32,
    x: UInt32,
    s: UInt32,
    t: UInt32,
):
    a += _f(b, c, d) + x + t
    a = _rotate_left(a, s)
    a += b


@always_inline
def _second_round(
    mut a: UInt32,
    b: UInt32,
    c: UInt32,
    d: UInt32,
    x: UInt32,
    s: UInt32,
    t: UInt32,
):
    a += _g(b, c, d) + x + t
    a = _rotate_left(a, s)
    a += b


@always_inline
def _third_round(
    mut a: UInt32,
    b: UInt32,
    c: UInt32,
    d: UInt32,
    x: UInt32,
    s: UInt32,
    t: UInt32,
):
    a += _h(b, c, d) + x + t
    a = _rotate_left(a, s)
    a += b


@always_inline
def _fourth_round(
    mut a: UInt32,
    b: UInt32,
    c: UInt32,
    d: UInt32,
    x: UInt32,
    s: UInt32,
    t: UInt32,
):
    a += _i(b, c, d) + x + t
    a = _rotate_left(a, s)
    a += b


def md5(data: Span[UInt8, ...]) -> MD5Digest:
    """
    Compute the MD5 digest of the given data.

    MD5 is a cryptographically broken hash function and should not be used for
    new applications or security-critical purposes. Use SHA-256 or SHA-3 instead.
    This function is provided for legacy compatibility and non-cryptographic uses
    (e.g., checksums, compatibility with legacy protocols).

    Args:
        data: Input bytes to hash.

    Returns:
        MD5Digest: A 128-bit (16-byte) digest object with methods to access
        the result as raw bytes or hex string.
    """
    var a = UInt32(0x67452301)
    var b = UInt32(0xEFCDAB89)
    var c = UInt32(0x98BADCFE)
    var d = UInt32(0x10325476)

    var zero_bytes_padding = (56 - (len(data) + 1)) % 64

    # Pad input data with 1 and 0s
    var message = List[UInt8]()
    message.extend(data)
    message.append(0x80)
    for _ in range(zero_bytes_padding):
        message.append(0x00)

    # Write original data length to last 8 bytes
    var original_message_bit_length = UInt64(len(data)) * 8
    message.append(UInt8(original_message_bit_length & 0xFF))
    message.append((UInt8(original_message_bit_length >> 8) & 0xFF))
    message.append((UInt8(original_message_bit_length >> 16) & 0xFF))
    message.append((UInt8(original_message_bit_length >> 24) & 0xFF))
    message.append((UInt8(original_message_bit_length >> 32) & 0xFF))
    message.append((UInt8(original_message_bit_length >> 40) & 0xFF))
    message.append((UInt8(original_message_bit_length >> 48) & 0xFF))
    message.append((UInt8(original_message_bit_length >> 56) & 0xFF))

    var i = 0
    while i < len(message):
        var x = List[UInt32]()
        for j in range(16):
            var base = i + (j * 4)
            var word = UInt32(message[base])
            word |= UInt32(message[base + 1]) << 8
            word |= UInt32(message[base + 2]) << 16
            word |= UInt32(message[base + 3]) << 24
            x.append(word)

        var aa = a
        var bb = b
        var cc = c
        var dd = d

        _first_round(a, b, c, d, x[0], 7, _t[0])
        _first_round(d, a, b, c, x[1], 12, _t[1])
        _first_round(c, d, a, b, x[2], 17, _t[2])
        _first_round(b, c, d, a, x[3], 22, _t[3])

        _first_round(a, b, c, d, x[4], 7, _t[4])
        _first_round(d, a, b, c, x[5], 12, _t[5])
        _first_round(c, d, a, b, x[6], 17, _t[6])
        _first_round(b, c, d, a, x[7], 22, _t[7])

        _first_round(a, b, c, d, x[8], 7, _t[8])
        _first_round(d, a, b, c, x[9], 12, _t[9])
        _first_round(c, d, a, b, x[10], 17, _t[10])
        _first_round(b, c, d, a, x[11], 22, _t[11])

        _first_round(a, b, c, d, x[12], 7, _t[12])
        _first_round(d, a, b, c, x[13], 12, _t[13])
        _first_round(c, d, a, b, x[14], 17, _t[14])
        _first_round(b, c, d, a, x[15], 22, _t[15])

        _second_round(a, b, c, d, x[1], 5, _t[16])
        _second_round(d, a, b, c, x[6], 9, _t[17])
        _second_round(c, d, a, b, x[11], 14, _t[18])
        _second_round(b, c, d, a, x[0], 20, _t[19])

        _second_round(a, b, c, d, x[5], 5, _t[20])
        _second_round(d, a, b, c, x[10], 9, _t[21])
        _second_round(c, d, a, b, x[15], 14, _t[22])
        _second_round(b, c, d, a, x[4], 20, _t[23])

        _second_round(a, b, c, d, x[9], 5, _t[24])
        _second_round(d, a, b, c, x[14], 9, _t[25])
        _second_round(c, d, a, b, x[3], 14, _t[26])
        _second_round(b, c, d, a, x[8], 20, _t[27])

        _second_round(a, b, c, d, x[13], 5, _t[28])
        _second_round(d, a, b, c, x[2], 9, _t[29])
        _second_round(c, d, a, b, x[7], 14, _t[30])
        _second_round(b, c, d, a, x[12], 20, _t[31])

        _third_round(a, b, c, d, x[5], 4, _t[32])
        _third_round(d, a, b, c, x[8], 11, _t[33])
        _third_round(c, d, a, b, x[11], 16, _t[34])
        _third_round(b, c, d, a, x[14], 23, _t[35])

        _third_round(a, b, c, d, x[1], 4, _t[36])
        _third_round(d, a, b, c, x[4], 11, _t[37])
        _third_round(c, d, a, b, x[7], 16, _t[38])
        _third_round(b, c, d, a, x[10], 23, _t[39])

        _third_round(a, b, c, d, x[13], 4, _t[40])
        _third_round(d, a, b, c, x[0], 11, _t[41])
        _third_round(c, d, a, b, x[3], 16, _t[42])
        _third_round(b, c, d, a, x[6], 23, _t[43])

        _third_round(a, b, c, d, x[9], 4, _t[44])
        _third_round(d, a, b, c, x[12], 11, _t[45])
        _third_round(c, d, a, b, x[15], 16, _t[46])
        _third_round(b, c, d, a, x[2], 23, _t[47])

        _fourth_round(a, b, c, d, x[0], 6, _t[48])
        _fourth_round(d, a, b, c, x[7], 10, _t[49])
        _fourth_round(c, d, a, b, x[14], 15, _t[50])
        _fourth_round(b, c, d, a, x[5], 21, _t[51])

        _fourth_round(a, b, c, d, x[12], 6, _t[52])
        _fourth_round(d, a, b, c, x[3], 10, _t[53])
        _fourth_round(c, d, a, b, x[10], 15, _t[54])
        _fourth_round(b, c, d, a, x[1], 21, _t[55])

        _fourth_round(a, b, c, d, x[8], 6, _t[56])
        _fourth_round(d, a, b, c, x[15], 10, _t[57])
        _fourth_round(c, d, a, b, x[6], 15, _t[58])
        _fourth_round(b, c, d, a, x[13], 21, _t[59])

        _fourth_round(a, b, c, d, x[4], 6, _t[60])
        _fourth_round(d, a, b, c, x[11], 10, _t[61])
        _fourth_round(c, d, a, b, x[2], 15, _t[62])
        _fourth_round(b, c, d, a, x[9], 21, _t[63])

        a += aa
        b += bb
        c += cc
        d += dd

        i += 64

    return MD5Digest(a, b, c, d)


@fieldwise_init
struct MD5Digest:
    """
    MD5 hash digest.

    Represents a 128-bit MD5 digest, stored internally as four 32-bit state words.
    Provides methods to export the digest as raw bytes or hexadecimal string.
    """

    var a: UInt32
    var b: UInt32
    var c: UInt32
    var d: UInt32

    def to_bytes(self) -> List[UInt8]:
        """
        Export the digest as a list of 16 bytes.

        Returns:
            List[UInt8]: The 16-byte MD5 digest in little-endian byte order
            (standard MD5 output format).
        """
        var out = List[UInt8](capacity=16)

        for l in [self.a, self.b, self.c, self.d]:
            out.append(UInt8(l & 0xFF))
            out.append(UInt8((l >> 8) & 0xFF))
            out.append(UInt8((l >> 16) & 0xFF))
            out.append(UInt8((l >> 24) & 0xFF))

        return out^

    def to_hex(self) -> String:
        """
        Export the digest as a lowercase hexadecimal string.

        Returns:
            String: A 32-character lowercase hex string representation of the digest.
        """
        var bytes = self.to_bytes()
        return _to_hex(bytes)
