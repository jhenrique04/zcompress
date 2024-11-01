const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "zcompress",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe);

    const unit_tests_rle = b.addTest(.{
        .root_source_file = b.path("src/rle.zig"),
        .target = target,
        .optimize = optimize,
    });

    const test_step = b.step("test", "Run unit tests for Run-Length Encoding");
    const run_unit_tests = b.addRunArtifact(unit_tests_rle);
    test_step.dependOn(&run_unit_tests.step);
}
