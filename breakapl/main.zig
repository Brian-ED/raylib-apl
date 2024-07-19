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
    // Comments in Zig start with "//" and end at the next LF byte (end of line).
    // The line below is a comment and won't be executed.

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