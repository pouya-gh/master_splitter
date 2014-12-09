module MasterSplitter
  def custom_joiner(slice_names, options={})
    output_dir = options[:output_dir]
    output_file_name = options[:output_file_name]
    slice_names.each do |slice_name|
      unless File.exists? slice_name
        raise Exception, "file '#{slice_name}' does not exist."
      end
    end

    output_file_name ||= slice_name[0]
    output_dir ||= ""
    join(File.join(output_dir, output_file_name), slice_names)
  end

  def standard_joiner(first_slice_name, options={})
    output_dir = options[:output_dir]
    output_file_name = options[:output_file_name]
    slice_names = []
    match_result = STANDARD_SLICE_NAMING_FORMAT.
      match(first_slice_name)

    if match_result
      output_file_name ||= match_result[1]
      slice_number = match_result[2].to_i
      while true
        temp = ("%3d"%[slice_number]).gsub(" ", "0")
        slice_name = [match_result[1], temp].join('.')
        if File.exists?(slice_name)
          slice_names << slice_name
          slice_number += 1
        else
          break
        end
      end #end of while

      output_dir ||= ""
      join(File.join(output_dir, output_file_name), slice_names)
    else
      raise Exception, %q{Wrong naming format for the first slice!}
    end
  end #end of standard_joiner

  def join(output_file_name, slice_names)
    output_file = File.open(source_file_name, 'wb')

    slice_names.each do |slice_name|
      slice = File.open(slice_name, 'rb')
      bytes_to_read = slice.size

      while bytes_to_read > 0
        chunk = MAX_CHUNK_SIZE
        chunk = bytes_to_read if (bytes_to_read < MAX_CHUNK_SIZE)
        output_file.write(slice.read(chunk))
        bytes_to_read -= chunk
      end #end of while
      slice.close
    end #end of each

    output_file.close
  end #end of join
end #end of module