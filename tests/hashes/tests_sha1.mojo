from crypto.hashes import sha1
from std.testing import (
    assert_true,
    assert_equal,
    TestSuite,
)

comptime sha1_empty: List[UInt8] = [
    0xDA,
    0x39,
    0xA3,
    0xEE,
    0x5E,
    0x6B,
    0x4B,
    0x0D,
    0x32,
    0x55,
    0xBF,
    0xEF,
    0x95,
    0x60,
    0x18,
    0x90,
    0xAF,
    0xD8,
    0x07,
    0x09,
]

comptime sha1_abc: List[UInt8] = [
    0xA9,
    0x99,
    0x3E,
    0x36,
    0x47,
    0x06,
    0x81,
    0x6A,
    0xBA,
    0x3E,
    0x25,
    0x71,
    0x78,
    0x50,
    0xC2,
    0x6C,
    0x9C,
    0xD0,
    0xD8,
    0x9D,
]

comptime sha1_quick_brown_fox: List[UInt8] = [
    0x2F,
    0xD4,
    0xE1,
    0xC6,
    0x7A,
    0x2D,
    0x28,
    0xFC,
    0xED,
    0x84,
    0x9E,
    0xE1,
    0xBB,
    0x76,
    0xE7,
    0x39,
    0x1B,
    0x93,
    0xEB,
    0x12,
]

comptime sha1_long_message: List[UInt8] = [
    0x7F,
    0x90,
    0x00,
    0x25,
    0x7A,
    0x49,
    0x18,
    0xD7,
    0x07,
    0x26,
    0x55,
    0xEA,
    0x46,
    0x85,
    0x40,
    0xCD,
    0xCB,
    0xD4,
    0x2E,
    0x0C,
]

comptime sha1_a_55: List[UInt8] = [
    0xC1,
    0xC8,
    0xBB,
    0xDC,
    0x22,
    0x79,
    0x6E,
    0x28,
    0xC0,
    0xE1,
    0x51,
    0x63,
    0xD2,
    0x08,
    0x99,
    0xB6,
    0x56,
    0x21,
    0xD6,
    0x5A,
]

comptime sha1_a_56: List[UInt8] = [
    0xC2,
    0xDB,
    0x33,
    0x0F,
    0x60,
    0x83,
    0x85,
    0x4C,
    0x99,
    0xD4,
    0xB5,
    0xBF,
    0xB6,
    0xE8,
    0xF2,
    0x9F,
    0x20,
    0x1B,
    0xE6,
    0x99,
]

comptime sha1_a_57: List[UInt8] = [
    0xF0,
    0x8F,
    0x24,
    0x90,
    0x8D,
    0x68,
    0x25,
    0x55,
    0x11,
    0x1B,
    0xE7,
    0xFF,
    0x6F,
    0x00,
    0x4E,
    0x78,
    0x28,
    0x3D,
    0x98,
    0x9A,
]

comptime sha1_a_64: List[UInt8] = [
    0x00,
    0x98,
    0xBA,
    0x82,
    0x4B,
    0x5C,
    0x16,
    0x42,
    0x7B,
    0xD7,
    0xA1,
    0x12,
    0x2A,
    0x5A,
    0x44,
    0x2A,
    0x25,
    0xEC,
    0x64,
    0x4D,
]

comptime sha1_a_65: List[UInt8] = [
    0x11,
    0x65,
    0x53,
    0x26,
    0xC7,
    0x08,
    0xD7,
    0x03,
    0x19,
    0xBE,
    0x26,
    0x10,
    0xE8,
    0xA5,
    0x7D,
    0x9A,
    0x5B,
    0x95,
    0x9D,
    0x3B,
]

comptime sha1_zero_bytes_16: List[UInt8] = [
    0xE1,
    0x29,
    0xF2,
    0x7C,
    0x51,
    0x03,
    0xBC,
    0x5C,
    0xC4,
    0x4B,
    0xCD,
    0xF0,
    0xA1,
    0x5E,
    0x16,
    0x0D,
    0x44,
    0x50,
    0x66,
    0xFF,
]

comptime sha1_all_bytes_16: List[UInt8] = [
    0x56,
    0x17,
    0x8B,
    0x86,
    0xA5,
    0x7F,
    0xAC,
    0x22,
    0x89,
    0x9A,
    0x99,
    0x64,
    0x18,
    0x5C,
    0x2C,
    0xC9,
    0x6E,
    0x7D,
    0xA5,
    0x89,
]


def test_compute_sha1_empty_string() raises:
    var result = sha1("".as_bytes())
    assert_equal(result.to_bytes(), materialize[sha1_empty]())


def test_compute_sha1_abc() raises:
    var result = sha1("abc".as_bytes())
    assert_equal(result.to_bytes(), materialize[sha1_abc]())


def test_compute_sha1_quick_brown_fox() raises:
    var result = sha1(
        "The quick brown fox jumps over the lazy dog".as_bytes()
    )
    assert_equal(result.to_bytes(), materialize[sha1_quick_brown_fox]())


def test_compute_sha1_is_deterministic() raises:
    var first = sha1("hello world".as_bytes())
    var second = sha1("hello world".as_bytes())
    assert_equal(first.to_bytes(), second.to_bytes())


def test_compute_sha1_changes_for_different_inputs() raises:
    var first = sha1("hello".as_bytes())
    var second = sha1("world".as_bytes())
    assert_true(first.to_bytes() != second.to_bytes())


def test_compute_sha1_long_input_spans_multiple_blocks() raises:
    var result = sha1(("a" * 100).as_bytes())
    assert_equal(result.to_bytes(), materialize[sha1_long_message]())


def test_compute_sha1_padding_boundary_55_bytes() raises:
    var result = sha1(("a" * 55).as_bytes())
    assert_equal(result.to_bytes(), materialize[sha1_a_55]())


def test_compute_sha1_padding_boundary_56_bytes() raises:
    var result = sha1(("a" * 56).as_bytes())
    assert_equal(result.to_bytes(), materialize[sha1_a_56]())


def test_compute_sha1_padding_boundary_57_bytes() raises:
    var result = sha1(("a" * 57).as_bytes())
    assert_equal(result.to_bytes(), materialize[sha1_a_57]())


def test_compute_sha1_padding_boundary_64_bytes() raises:
    var result = sha1(("a" * 64).as_bytes())
    assert_equal(result.to_bytes(), materialize[sha1_a_64]())


def test_compute_sha1_padding_boundary_65_bytes() raises:
    var result = sha1(("a" * 65).as_bytes())
    assert_equal(result.to_bytes(), materialize[sha1_a_65]())


def test_compute_sha1_to_hex() raises:
    var result = sha1("abc".as_bytes())
    assert_equal(result.to_hex(), "a9993e364706816aba3e25717850c26c9cd0d89d")


def test_compute_sha1_zero_bytes_input() raises:
    var data = List[UInt8]()
    for _ in range(16):
        data.append(0x00)

    var result = sha1(data)
    assert_equal(result.to_bytes(), materialize[sha1_zero_bytes_16]())


def test_compute_sha1_all_byte_values_input() raises:
    var data = List[UInt8]()
    for i in range(16):
        data.append(UInt8(i))

    var result = sha1(data)
    assert_equal(result.to_bytes(), materialize[sha1_all_bytes_16]())


def main() raises:
    TestSuite.discover_tests[__functions_in_module()]().run()