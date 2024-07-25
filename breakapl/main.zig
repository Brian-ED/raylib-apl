const std = @import("std");
const print = @import("std").debug.print;

const color = packed struct {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
};

export fn sayFloat(int1: i32, int2: i32, float1: f32, float2: f32, color1: color, int3:i64) void {
    // Comments in Zig start with "//" and end at the next LF byte (end of line).
    // The line below is a comment and won't be executed.

    if (std.fs.cwd().createFile(
        "junk_file.txt",
        .{},
    )) |file| {
        const fmtArgs = .{ int1, int2, int3, @as(u32, @bitCast(float1)), float1, @as(u32, @bitCast(float2)), float2, color1 };
        const fmtStr = "int1: {} int2: {} int3: {}\nfloat1: {}, {} float2: {}, {}\ncolor1: {} end\n";
        const out = std.fmt.format(file.writer(), fmtStr, fmtArgs);
        if (out) {} else |err| {
            print("{}", .{err});
        }
        file.close();
    } else |err| {
        print("{}", .{err});
    }
}

// zig build
// -rdynamic
// -dynamic


const someone = extern struct {
    a: u64,
    b:extern struct {a:u64, b:u32},
    c:u8
};

export fn sayI8(int1: i8, int2: i8, int3:i8, int4:i8, int5:i8, s:someone) void {
    // Comments in Zig start with "//" and end at the next LF byte (end of line).
    // The line below is a comment and won't be executed.

    if (std.fs.cwd().createFile(
        "junk_file.txt",
        .{},
    )) |file| {
        const fmtArgs = .{ int1, int2, int3, int4, int5, s};
        const fmtStr = "int1: {} int2: {} int3: {} int4: {} int5: {}\ns: {} end\n";
        const out = std.fmt.format(file.writer(), fmtStr, fmtArgs);
        if (out) {} else |err| {
            print("{}", .{err});
        }
        file.close();
    } else |err| {
        print("{}", .{err});
    }
}


const padded = extern struct {
    a: u8,
    b: u64,
};

export fn pad(s:padded) void {
    if (std.fs.cwd().createFile(
        "junk_file.txt",
        .{},
    )) |file| {
        const fmtArgs = .{s};
        const fmtStr = "s: {} end\n";
        const out = std.fmt.format(file.writer(), fmtStr, fmtArgs);
        if (out) {} else |err| {
            print("{}", .{err});
        }
        file.close();
    } else |err| {
        print("{}", .{err});
    }
}


const retStruct = extern struct {
    a: u8,
    b: u64,
};

export fn ret() retStruct {
    return .{.a=1, .b=2};
}


export fn strs(s:*u8) *u8 {
    return s;
}

export fn indexStr(arr:[*]u8, i:u32) u64 {
    return arr[i];
}

fn toFile(comptime fmtStr: []const u8, fmtArgs: anytype) void {
    if (std.fs.cwd().createFile(
        "junk_file.txt",
        .{},
    )) |file| {
        const out = std.fmt.format(file.writer(), fmtStr, fmtArgs);
        if (out) {} else |err| {
            print("{}", .{err});
        }
        file.close();
    } else |err| {
        print("{}", .{err});
    }
}


const max_align = 8;
const pad_amount = std.mem.alignForward(usize, @sizeOf(usize), max_align);

/// which allocator stb_image functions will use. defaults to the C allocator.
/// if you set this, only do so once and before you call any stb_image functions.
pub var allocator = std.heap.page_allocator;

export fn alloc(size: usize) ?[*]align(max_align) u8 {
    const slice = allocator.alignedAlloc(u8, max_align, pad_amount + size) catch return null;
    // store the size before the data
    @as(*usize, @ptrCast(slice.ptr)).* = size;
    return slice.ptr + pad_amount;
}

export fn free(maybe_ptr: ?[*]align(max_align) u8) void {
    // free(NULL) should work and do nothing
    if (maybe_ptr) |ptr| {
        const orig_ptr = ptr - pad_amount;
        const orig_size = @as(*const usize, @ptrCast(orig_ptr)).*;
        const orig_slice = orig_ptr[0..(pad_amount + orig_size)];
        allocator.free(orig_slice);
    }
}

///////////////////////////
// ERROR REPORTS SECTION //
///////////////////////////

const structFunc2 = extern struct {
    a:f64,
    b:u8,
};

export fn func2(s:structFunc2) void {
    toFile("s: {} end\n", .{s});
}

export fn setFirstChar(s:[*]u8) void {
    s[0] = 97;
}
export fn setIndex(s:[*]u8, index:u32, val:u8) void {
    s[index] = val;
}
export fn seeIndex(s:[*]u8, index:u32) u8 {
    return s[index];
}
export fn setFirstCharPtr(s:[*][*]u8) void {
    s[0][0] = 97;
}

export fn structTestWindows(s:color) void {
    toFile("{}", .{s});
}
