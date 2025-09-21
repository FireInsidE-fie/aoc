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

fn sorted_distance(list1: []i32, list2: []i32) u128 {
    // print_slice(list1);
    // print_slice(list2);

    // std.sort.insertion(i32, list1, {}, std.sort.asc(i32));
    // std.sort.insertion(i32, list2, {}, std.sort.asc(i32));

    // print_slice(list1);
    // print_slice(list2);

    // var sum: u32 = 0;
    // for (list1, list2) |item1, item2| {
    //     sum = sum + @abs(item1 - item2);
    //     std.debug.print("[!] - Sum currently at {}\n", .{sum});
    // }

    // return sum;

    return @abs(sum(list1) - sum(list2));
}

test "example" {
    var list1 = [_]i32{ 3, 4, 2, 1, 3, 3 };
    var list2 = [_]i32{ 4, 3, 5, 3, 9, 3 };
    try expect(sorted_distance(list1[0..], list2[0..]) == 11);
}
