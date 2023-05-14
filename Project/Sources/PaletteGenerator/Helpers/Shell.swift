import Foundation

struct Shell {

    struct Result {
        var stderr: Data?
        var stdout: Data?

        var data: Data? {
            stdout ?? stderr
        }
    }

    @discardableResult
    static func run(_ command: String) throws -> String? {
        let result = try perform(command)

        if let data = result.data {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }

    static func perform(_ command: String) throws -> Result {
        let task = Process()
        let stderr = Pipe()
        let stdout = Pipe()

        task.standardOutput = stdout
        task.standardError = stderr
        task.arguments = ["-c", command]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")
        task.standardInput = nil
        try task.run()

        let stderrorData = try stderr.fileHandleForReading.readToEnd()
        let stdoutData = try stdout.fileHandleForReading.readToEnd()
        return Result(stderr: stderrorData, stdout: stdoutData)
    }
}
