from crypto.hashes import md5
from std.testing import (
    assert_true,
    assert_equal,
    TestSuite,
)

comptime md5_empty: List[UInt8] = [
    0xD4,
    0x1D,
    0x8C,
    0xD9,
    0x8F,
    0x00,
    0xB2,
    0x04,
    0xE9,
    0x80,
    0x09,
    0x98,
    0xEC,
    0xF8,
    0x42,
    0x7E,
]

comptime md5_abc: List[UInt8] = [
    0x90,
    0x01,
    0x50,
    0x98,
    0x3C,
    0xD2,
    0x4F,
    0xB0,
    0xD6,
    0x96,
    0x3F,
    0x7D,
    0x28,
    0xE1,
    0x7F,
    0x72,
]

comptime md5_quick_brown_fox: List[UInt8] = [
    0x9E,
    0x10,
    0x7D,
    0x9D,
    0x37,
    0x2B,
    0xB6,
    0x82,
    0x6B,
    0xD8,
    0x1D,
    0x35,
    0x42,
    0xA4,
    0x19,
    0xD6,
]

comptime md5_long_message: List[UInt8] = [
    0x36,
    0xA9,
    0x2C,
    0xC9,
    0x4A,
    0x9E,
    0x0F,
    0xA2,
    0x1F,
    0x62,
    0x5F,
    0x8B,
    0xFB,
    0x00,
    0x7A,
    0xDF,
]

comptime md5_a_55: List[UInt8] = [
    0xEF,
    0x17,
    0x72,
    0xB6,
    0xDF,
    0xF9,
    0xA1,
    0x22,
    0x35,
    0x85,
    0x52,
    0x95,
    0x4A,
    0xD0,
    0xDF,
    0x65,
]

comptime md5_a_56: List[UInt8] = [
    0x3B,
    0x0C,
    0x8A,
    0xC7,
    0x03,
    0xF8,
    0x28,
    0xB0,
    0x4C,
    0x6C,
    0x19,
    0x70,
    0x06,
    0xD1,
    0x72,
    0x18,
]

comptime md5_a_57: List[UInt8] = [
    0x65,
    0x2B,
    0x90,
    0x6D,
    0x60,
    0xAF,
    0x96,
    0x84,
    0x4E,
    0xBD,
    0x21,
    0xB6,
    0x74,
    0xF3,
    0x5E,
    0x93,
]

comptime md5_a_64: List[UInt8] = [
    0x01,
    0x48,
    0x42,
    0xD4,
    0x80,
    0xB5,
    0x71,
    0x49,
    0x5A,
    0x4A,
    0x03,
    0x63,
    0x79,
    0x3F,
    0x73,
    0x67,
]

comptime md5_a_65: List[UInt8] = [
    0xC7,
    0x43,
    0xA4,
    0x5E,
    0x0D,
    0x2E,
    0x6A,
    0x95,
    0xCB,
    0x85,
    0x9A,
    0xDA,
    0xE0,
    0x24,
    0x84,
    0x35,
]

comptime md5_zero_bytes_16: List[UInt8] = [
    0x4A,
    0xE7,
    0x13,
    0x36,
    0xE4,
    0x4B,
    0xF9,
    0xBF,
    0x79,
    0xD2,
    0x75,
    0x2E,
    0x23,
    0x48,
    0x18,
    0xA5,
]

comptime md5_all_bytes_16: List[UInt8] = [
    0x1A,
    0xC1,
    0xEF,
    0x01,
    0xE9,
    0x6C,
    0xAF,
    0x1B,
    0xE0,
    0xD3,
    0x29,
    0x33,
    0x1A,
    0x4F,
    0xC2,
    0xA8,
]


def test_compute_md5_empty_string() raises:
    var result = md5("".as_bytes())
    assert_equal(result.to_bytes(), materialize[md5_empty]())


def test_compute_md5_abc() raises:
    var result = md5("abc".as_bytes())
    assert_equal(result.to_bytes(), materialize[md5_abc]())


def test_compute_md5_quick_brown_fox() raises:
    var result = md5("The quick brown fox jumps over the lazy dog".as_bytes())
    assert_equal(result.to_bytes(), materialize[md5_quick_brown_fox]())


def test_compute_md5_is_deterministic() raises:
    var first = md5("hello world".as_bytes())
    var second = md5("hello world".as_bytes())
    assert_equal(first.to_bytes(), second.to_bytes())


def test_compute_md5_changes_for_different_inputs() raises:
    var first = md5("hello".as_bytes())
    var second = md5("world".as_bytes())
    assert_true(first.to_bytes() != second.to_bytes())


def test_compute_md5_long_input_spans_multiple_blocks() raises:
    var result = md5(("a" * 100).as_bytes())
    assert_equal(result.to_bytes(), materialize[md5_long_message]())


def test_compute_md5_padding_boundary_55_bytes() raises:
    var result = md5(("a" * 55).as_bytes())
    assert_equal(result.to_bytes(), materialize[md5_a_55]())


def test_compute_md5_padding_boundary_56_bytes() raises:
    var result = md5(("a" * 56).as_bytes())
    assert_equal(result.to_bytes(), materialize[md5_a_56]())


def test_compute_md5_padding_boundary_57_bytes() raises:
    var result = md5(("a" * 57).as_bytes())
    assert_equal(result.to_bytes(), materialize[md5_a_57]())


def test_compute_md5_padding_boundary_64_bytes() raises:
    var result = md5(("a" * 64).as_bytes())
    assert_equal(result.to_bytes(), materialize[md5_a_64]())


def test_compute_md5_padding_boundary_65_bytes() raises:
    var result = md5(("a" * 65).as_bytes())
    assert_equal(result.to_bytes(), materialize[md5_a_65]())


def test_compute_md5_to_hex() raises:
    var result = md5("abc".as_bytes())
    assert_equal(result.to_hex(), "900150983cd24fb0d6963f7d28e17f72")


def test_compute_md5_zero_bytes_input() raises:
    var data = List[UInt8]()
    for _ in range(16):
        data.append(0x00)

    var result = md5(data)
    assert_equal(result.to_bytes(), materialize[md5_zero_bytes_16]())


def test_compute_md5_all_byte_values_input() raises:
    var data = List[UInt8]()
    for i in range(16):
        data.append(UInt8(i))

    var result = md5(data)
    assert_equal(result.to_bytes(), materialize[md5_all_bytes_16]())


def main() raises:
    TestSuite.discover_tests[__functions_in_module()]().run()
