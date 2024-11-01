const std = @import("std");

pub fn runLengthEncode(input: []const u8) ![]const u8 {
    var buffer = try std.ArrayList(u8).initCapacity(std.heap.page_allocator, input.len * 2);
    defer buffer.deinit();

    var index: usize = 0;

    while (index < input.len) {
        const current_char = input[index];
        var count: usize = 1;

        while (index + 1 < input.len and input[index + 1] == current_char) {
            count += 1;
            index += 1;
        }

        try buffer.append(current_char);

        var count_str: [10]u8 = undefined;
        const written_count = try std.fmt.bufPrint(&count_str, "{d}", .{count});
        try buffer.appendSlice(count_str[0..written_count.len]);

        index += 1;
    }

    return buffer.toOwnedSlice();
}

pub fn runLengthDecode(input: []const u8) ![]const u8 {
    var buffer = try std.ArrayList(u8).initCapacity(std.heap.page_allocator, input.len);
    defer buffer.deinit();
    var index: usize = 0;
    while (index < input.len) {
        const current_char = input[index];
        index += 1;
        var count: usize = 0;
        while (index < input.len and input[index] >= '0' and input[index] <= '9') {
            count = count * 10 + (input[index] - '0');
            index += 1;
        }
        for (count) |_| {
            try buffer.append(current_char);
        }
    }
    return buffer.toOwnedSlice();
}

test "Run-Length Encoding Test - Valid Input" {
    const input = "aaaabbbcc";
    const expected = "a4b3c2";

    const compressed = try runLengthEncode(input);

    try std.testing.expectEqualStrings(expected, compressed);
}

test "Run-Length Encoding Test - Empty Input" {
    const input = "";
    const expected = "";
    const compressed = try runLengthEncode(input);
    try std.testing.expectEqualStrings(expected, compressed);
}

test "Run-Length Encoding Test - No Repeats" {
    const input = "abcdef";
    const expected = "a1b1c1d1e1f1";
    const compressed = try runLengthEncode(input);
    try std.testing.expectEqualStrings(expected, compressed);
}

test "Run-Length Decoding Test" {
    const input = "a4b3c2";
    const expected = "aaaabbbcc";
    const decompressed = try runLengthDecode(input);
    try std.testing.expectEqualStrings(expected, decompressed);
}
