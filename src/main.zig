const std = @import("std");
const windows = std.os.windows;

const HANDLE = windows.HANDLE;

const message = "Hello World!";

extern "ntdll" fn NtWriteFile(
    in_hFile: HANDLE,
    in_hEvent: ?HANDLE,
    in_ApcRoutine: ?*windows.IO_APC_ROUTINE,
    in_ApcContext: ?[*]const u8,
    out_IoStatusBlock: *windows.IO_STATUS_BLOCK,
    in_Buffer: [*]const u8,
    in_Length: usize,
    in_ByteOffset: ?*windows.LARGE_INTEGER,
    in_Key: ?*usize,
) void;

pub fn main() void {
    var io_status: windows.IO_STATUS_BLOCK = undefined;
    const stdout = windows.peb().ProcessParameters.hStdOutput;
    NtWriteFile(
        stdout,
        null,
        null,
        null,
        &io_status,
        message,
        message.len,
        null,
        null,
    );
}
