module Idb
  class LocalOperations
    def file?(path)
      File.file? path
    end

    def download(a, b)
      FileUtils.copy_file(a, b)
      true
    end

    def directory?(path)
      File.directory? path
    end

    def mtime(path)
      File.mtime path
    end

    def open(path)
      Launchy.open path
      return true
    rescue StandardError => e
      $log.error "Could not open file #{path}: #{e.message}"
      $log.error e.backtrace
      return false
    end

    def list_dir(path)
      Dir.entries path
    end

    def list_dir_full(path)
      Dir.entries path
    end

    def dir_glob(path, pattern)
      full_path = "#{path}/#{pattern}"
      Dir.glob(full_path)
    end

    def file_exists?(file)
      File.exist? file
    end

    def execute(cmd)
      `#{cmd}`
    end

    def execute_fork(cmd)
      (pid = fork) ? Process.detach(pid) : exec(cmd)
    end

    def launch_app(command, app)
      $log.info "Executing #{command} #{app}"
      execute_fork("#{command} \"#{app}\"")
    end
  end
end
