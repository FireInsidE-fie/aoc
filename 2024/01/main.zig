const std = @import("std");
const expect = std.testing.expect;

fn print_slice(slice: []const i32) void {
    std.debug.print("[!] - Printing a slice...\n", .{});
    for (slice) |item| {
        std.debug.print("{}\n", .{item});
    }
}

fn sum(array: []i32) i128 {
    var result: i128 = 0;

    for (array) |item| {
        result += item;
    }
    return result;
}

fn parse(path: []const u8) !void {
    const allocator = std.heap.page_allocator;

    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();
    const file_size = try file.getEndPos();

    const buffer = try allocator.alloc(u8, file_size);
    defer allocator.free(buffer);

    _ = try file.readAll(buffer);

    var slices = std.mem.splitAny(u8, buffer, "\n");
    var slice = slices.next();
    while (slice != null) : (slice = slices.next()) {
        std.debug.print("{s}\n", .{slice.?});
    }
}

fn sorted_distance(list1: []i32, list2: []i32) !u128 {

    return @abs(sum(list1) - sum(list2));
}

test "example" {
    var list1 = [_]i32{ 3, 4, 2, 1, 3, 3 };
    var list2 = [_]i32{ 4, 3, 5, 3, 9, 3 };
    try expect(try sorted_distance(list1[0..], list2[0..]) == 11);
}

test "input" {
    // const list = parse("input.txt");
    try parse("input.txt");

}
