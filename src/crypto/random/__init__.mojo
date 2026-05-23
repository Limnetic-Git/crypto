"""
Cryptographically secure random number generation.

This module provides functions for generating cryptographically secure random
integers of various sizes using system entropy sources.

Available functions:
- generate_secure_u8: Generate a random UInt8
- generate_secure_u16: Generate a random UInt16
- generate_secure_u32: Generate a random UInt32
- generate_secure_u64: Generate a random UInt64
- generate_secure_u128: Generate a random UInt128

These functions are suitable for cryptographic use cases such as key generation,
initialization vectors, and nonce production.
"""

from .libc import (
    generate_secure_u8,
    generate_secure_u16,
    generate_secure_u32,
    generate_secure_u64,
    generate_secure_u128,
)
