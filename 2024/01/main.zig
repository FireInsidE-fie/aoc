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

fn parse_line(line: []const u8) struct {u32, u32} {
    _ = line;
    return .{0, 0};
}

fn parse(path: []const u8) !struct { []u32, []u32 } {
    const allocator = std.heap.page_allocator;

    const file = try std.fs.cwd().openFile(path, .{});
    defer file.close();
    const file_size = try file.getEndPos();

    std.debug.print("{}\n", .{file_size});

    const buffer = try allocator.alloc(u8, file_size);
    defer allocator.free(buffer);

    _ = try file.readAll(buffer);

    const list1 = try allocator.alloc(u32, 1001);
    var i: usize = 0;
    const list2 = try allocator.alloc(u32, 1001);
    var j: usize = 0;

    var iter = std.mem.splitAny(u8, buffer, "\n");
    var line = iter.next();
    while (line != null) : (line = iter.next()) {
        std.debug.print("{s}\n", .{line.?});

        const n1, const n2 = parse_line(line.?);
        list1[i] = n1;
        list2[j] = n2;
        i = i + 1;
        j = j + 1;
    }

    return .{list1, list2};
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
    const list1, const list2 = try parse("input.txt");

    _ = list1;
    _ = list2;
}
