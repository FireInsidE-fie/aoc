const std = @import("std");
const expect = std.testing.expect;

fn print_slice(slice: []const u32) void {
    std.debug.print("[!] - Printing a slice...\n", .{});
    for (slice) |item| {
        std.debug.print("{}\n", .{item});
    }
}

fn sorted_distance(list1: []const u32, list2: []const u32) u32 {
    print_slice(list1);
    print_slice(list2);
    return 0;
}

test "example" {
    const list1 = [_]u32{3, 4, 2, 1, 3, 3};
    const list2 = [_]u32{4, 3, 5, 3, 9, 4};

    try expect(sorted_distance(&list1, &list2) == 11);
}
