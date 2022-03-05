const std = @import("std");
const fs = std.fs;
const io = std.io;
const mem = std.mem;
const testing = std.testing;
const debug = std.debug;
const zig = std.zig;

const StringHashMap = std.StringArrayHashMap;

pub const PrintFn = struct {
    print: fn(comptime fmt: []const u8, args: anytype) void
};

// If you need to allocate resorces, you will, pass the allocator around.
var alloc = testing.allocator;

/// Read the whole file into a buffer and return that buffer,
/// don't free whatever you have used to allocate the buffer until after you have used it.
///
/// Remember to close the file.
///
///                                   This means any error can be returned
pub fn readToString(path: []const u8) anyerror![]u8 {
    //_=path;
    // Do stuff...
    //const cac:[1]u8=[1]u8{0};
    const fl=try fs.cwd().openFile(path,.{.read=true});
    defer fl.close();
    var buf_reader=io.bufferedReader(fl.reader());
    const stream=buf_reader.reader();
    const stat_file=try fl.stat();
    const res=try stream.readAllAlloc(alloc,stat_file.size);
    debug.print("{s}",.{res});
    return res;

    //return alloc.dupe(u8,cac[0..]);
}

/// You must return the StringHashMap that contians all the words and counts.
///
/// Remember don't free any of the keys or values of this map, don't free the map either.
pub fn wc(lines: []const u8) anyerror!StringHashMap(usize) {
    _=lines;
    // Do stuff...
var count:usize=0;
    var map=StringHashMap(usize).init(alloc);
    var all_words=std.mem.tokenize(u8,lines," ");
    while(all_words.next()) |s| : (count+=1) {
    const result = try map.getOrPut(s);
if (!result.found_existing) {
    result.value_ptr.* = 1;
}
else
    result.value_ptr.*+=1;
}

    return StringHashMap(usize).init(alloc);
}

/// Each word must be printed like `print.print("{s}, {}\n", word, count)` and the total
/// `print.print("{s} {}\n", path, total)`.
pub fn printWordCount(
    word_map: *const StringHashMap(usize),
    path: []const u8,
    comptime print: PrintFn,
) void {
    // Do stuff...

    var it1=word_map.iterator();
    var count:usize=0; 

    while(it1.next()) |entry| : (count+=1) {
        print.print("{s} :{d}\n",.{entry.key_ptr.*,entry.value_ptr.*});

    }
    _=path;
}
