from std.ffi import external_call
from std.sys.info import CompilationTarget


def generate_secure_u8() raises -> UInt8:
    """
    Return a secure random 8-bit value.

    The implementation uses the platform-appropriate entropy source and
    raises if secure random bytes cannot be obtained.

    Returns:
        `UInt8`: A securely generated random 8-bit integer.

    Raises:
        `Error`: If the underlying system call fails to provide secure random bytes.
    """
    comptime compilation_target = CompilationTarget()
    comptime if compilation_target.is_linux():
        var buf = UInt8(0)
        # Definition: ssize_t getrandom(void *buf, size_t buflen, unsigned int flags);
        # Flags (0): Standard blocking behavior, waits for entropy pool initialization.
        var bytes_read = external_call["getrandom", Int](Pointer(to=buf), 1, 0)
        if bytes_read < 1:
            raise Error("Linux getrandom failed to provide 2 bytes of entropy")
        return buf

    elif compilation_target.is_macos():
        # Definition: uint32_t arc4random(void);
        # Returns: A random 32-bit integer.
        var result = external_call["arc4random", UInt32]()
        return UInt8(result)

    else:
        compilation_target.unsupported_target_error[
            note="Unsupported OS: Secure random not implemented"
        ]()


def generate_secure_u16() raises -> UInt16:
    """
    Return a secure random 16-bit value.

    The implementation uses the platform-appropriate entropy source and
    raises if secure random bytes cannot be obtained.

    Returns:
        `UInt16`: A securely generated random 16-bit integer.

    Raises:
        `Error`: If the underlying system call fails to provide secure random bytes.
    """
    comptime compilation_target = CompilationTarget()
    comptime if compilation_target.is_linux():
        var buf = UInt16(0)
        # Definition: ssize_t getrandom(void *buf, size_t buflen, unsigned int flags);
        # Flags (0): Standard blocking behavior, waits for entropy pool initialization.
        var bytes_read = external_call["getrandom", Int](Pointer(to=buf), 2, 0)
        if bytes_read < 2:
            raise Error("Linux getrandom failed to provide 2 bytes of entropy")
        return buf

    elif compilation_target.is_macos():
        # Definition: uint32_t arc4random(void);
        # Returns: A random 32-bit integer.
        var result = external_call["arc4random", UInt32]()
        return UInt16(result)

    else:
        compilation_target.unsupported_target_error[
            note="Unsupported OS: Secure random not implemented"
        ]()


def generate_secure_u32() raises -> UInt32:
    """
    Return a secure random 32-bit value.

    The implementation uses the platform-appropriate entropy source and
    raises if secure random bytes cannot be obtained.

    Returns:
        `UInt32`: A securely generated random 32-bit integer.

    Raises:
        `Error`: If the underlying system call fails to provide secure random bytes.
    """
    comptime compilation_target = CompilationTarget()
    comptime if compilation_target.is_linux():
        var buf = UInt32(0)
        # Definition: ssize_t getrandom(void *buf, size_t buflen, unsigned int flags);
        # Flags (0): Standard blocking behavior, waits for entropy pool initialization.
        var bytes_read = external_call["getrandom", Int](Pointer(to=buf), 4, 0)
        if bytes_read < 4:
            raise Error("Linux getrandom failed to provide 2 bytes of entropy")
        return buf

    elif compilation_target.is_macos():
        # Definition: uint32_t arc4random(void);
        # Returns: A random 32-bit integer.
        var result = external_call["arc4random", UInt32]()
        return UInt32(result)

    else:
        compilation_target.unsupported_target_error[
            note="Unsupported OS: Secure random not implemented"
        ]()


def generate_secure_u64() raises -> UInt64:
    """
    Return a secure random 64-bit value.

    The implementation uses the platform-appropriate entropy source and
    raises if secure random bytes cannot be obtained.

    Returns:
        `UInt64`: A securely generated random 64-bit integer.

    Raises:
        `Error`: If the underlying system call fails to provide secure random bytes.
    """
    comptime compilation_target = CompilationTarget()
    comptime if compilation_target.is_linux():
        var buf = UInt64(0)
        # Definition: ssize_t getrandom(void *buf, size_t buflen, unsigned int flags);
        # Flags (0): Standard blocking behavior, waits for entropy pool initialization.
        var bytes_read = external_call["getrandom", Int](Pointer(to=buf), 8, 0)
        if bytes_read < 8:
            raise Error("Linux getrandom failed to provide 8 bytes of entropy")
        return buf

    elif compilation_target.is_macos():
        # Definition: uint32_t arc4random(void);
        # Returns: A random 32-bit integer.
        var hi = UInt64(external_call["arc4random", UInt32]())
        var lo = UInt64(external_call["arc4random", UInt32]())
        return (hi << 32) | lo

    else:
        compilation_target.unsupported_target_error[
            note="Unsupported OS: Secure random not implemented"
        ]()


def generate_secure_u128() raises -> UInt128:
    """
    Return a secure random 128-bit value.

    The implementation uses the platform-appropriate entropy source and
    raises if secure random bytes cannot be obtained.

    Returns:
        `UInt128`: A securely generated random 128-bit integer.

    Raises:
        `Error`: If the underlying system call fails to provide secure random bytes.
    """
    comptime compilation_target = CompilationTarget()
    comptime if compilation_target.is_linux():
        var buf = UInt128(0)
        # Definition: ssize_t getrandom(void *buf, size_t buflen, unsigned int flags);
        # Flags (0): Standard blocking behavior, waits for entropy pool initialization.
        var bytes_read = external_call["getrandom", Int](Pointer(to=buf), 16, 0)
        if bytes_read < 16:
            raise Error("Linux getrandom failed to provide 8 bytes of entropy")
        return buf

    elif compilation_target.is_macos():
        # Definition: uint32_t arc4random(void);
        # Returns: A random 32-bit integer.
        var hi = UInt128(external_call["arc4random", UInt32]())
        var mid_1 = UInt128(external_call["arc4random", UInt32]())
        var mid_2 = UInt128(external_call["arc4random", UInt32]())
        var lo = UInt128(external_call["arc4random", UInt32]())
        return (hi << 96) | (mid_1 << 64) | (mid_2 << 32) | lo

    else:
        compilation_target.unsupported_target_error[
            note="Unsupported OS: Secure random not implemented"
        ]()
