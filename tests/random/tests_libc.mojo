from crypto.random import (
    generate_secure_u8,
    generate_secure_u16,
    generate_secure_u32,
    generate_secure_u64,
    generate_secure_u128,
)
from std.collections import Set
from std.testing import (
    assert_true,
    TestSuite,
)


def test_generate_secure_u8_returns_a_value_in_range() raises:
    var result = generate_secure_u8()
    assert_true(result <= UInt8(255))


def test_generate_secure_u8_diversity() raises:
    var seen = Set[UInt8]()
    for _ in range(256):
        seen.add(generate_secure_u8())
    assert_true(len(seen) >= 150)


def test_generate_secure_u16_returns_a_value_in_range() raises:
    var result = generate_secure_u16()
    assert_true(result <= UInt16(65_535))


def test_generate_random_u16_diversity() raises:
    var seen = Set[UInt16]()
    for _ in range(256):
        seen.add(generate_secure_u16())
    assert_true(len(seen) >= 200)


def test_generate_secure_u32_returns_a_value_in_range() raises:
    var result = generate_secure_u32()
    assert_true(result <= UInt32(4_294_967_295))


def test_generate_secure_u32_diversity() raises:
    var seen = Set[UInt32]()
    for _ in range(256):
        seen.add(generate_secure_u32())
    assert_true(len(seen) >= 250)


def test_generate_secure_u64_returns_a_value_in_range() raises:
    var result = generate_secure_u64()
    assert_true(result <= UInt64(18_446_744_073_709_551_615))


def test_generate_secure_u64_diversity() raises:
    var seen = Set[UInt64]()
    for _ in range(256):
        seen.add(generate_secure_u64())
    assert_true(len(seen) >= 250)


def test_generate_secure_u128_returns_a_value_in_range() raises:
    var result = generate_secure_u128()
    assert_true(
        result <= UInt128(340_282_366_920_938_463_463_374_607_431_768_211_455)
    )


def test_generate_secure_u128_diversity() raises:
    var seen = Set[UInt128]()
    for _ in range(256):
        seen.add(generate_secure_u128())
    assert_true(len(seen) >= 250)


def test_generate_secure_random_generators_do_not_raise_over_many_calls() raises:
    for _ in range(1000):
        var _ = generate_secure_u8()
        var _ = generate_secure_u16()
        var _ = generate_secure_u32()
        var _ = generate_secure_u64()
        var _ = generate_secure_u128()


def main() raises:
    TestSuite.discover_tests[__functions_in_module()]().run()
