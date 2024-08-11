const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "main",
        .root_source_file = b.path("src/main.zig"),
        .target = b.host,
        .single_threaded = true,
        .strip = true,
        .optimize = std.builtin.OptimizeMode.ReleaseSmall,
    });

    build_exe_step(b, exe);
    run_exe_step(b, exe);
}

fn build_exe_step(b: *std.Build, exe: *std.Build.Step.Compile) void {
    b.installArtifact(exe);
}

fn run_exe_step(b: *std.Build, exe: *std.Build.Step.Compile) void {
    const run_exe = b.addRunArtifact(exe);

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);
}
