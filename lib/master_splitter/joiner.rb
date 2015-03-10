module MasterSplitter
  ##
  # With this method you can join a couple of file
  # which their names does not follow the standard format.
  # You can pass it a name for the output file and a directory
  # to store it.
  # Example: 
  #   >> custom_joiner(["first.pdf", "second.pdf"], 
  #                     output_file_name: "book.pdf", output_dir: "Desktop/")
  # Arguments:
  #     slice_names: (Array)
  #     options:     (Hash) 
  # 
  def custom_joiner(slice_names, options={})
    output_dir = options[:output_dir]
    output_file_name = options[:output_file_name]
    slice_names.each do |slice_name|
      unless File.exists? slice_name
        raise Exception, "file '#{slice_name}' does not exist."
      end
    end

    output_file_name ||= slice_names[0]
    if output_dir
        output_file_name = File.join(output_dir, output_file_name)
    end
    join(output_file_name, slice_names)
  end

  ##
  # This method joins slices of a splitted file which
  # their names follow the standard format.
  # You just have to pass it the name of the first slice.
  # Remember that all slices must be in the same directory.
  # Example: 
  #   >> standard_joiner("path/to/first_slice.pdf.001", 
  #                     output_file_name: "book.pdf", output_dir: "Desktop/")
  # Arguments:
  #     first_slice_name: (String)
  #     options:          (Hash) 
  # 
  def standard_joiner(first_slice_name, options={})
    output_dir = options[:output_dir]
    output_file_name = options[:output_file_name]
    slice_names = []
    match_result = STANDARD_SLICE_NAMING_FORMAT.
      match(first_slice_name)

    if match_result
      if match_result[1].include?("/") && output_dir
        output_file_name ||= FILE_NAME_FINDER.match(match_result[1])[1]
      else
        output_file_name ||= match_result[1]
      end
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

      if output_dir
        output_file_name = File.join(output_dir, output_file_name)
      end
      join(output_file_name, slice_names)
    else
      raise Exception, %q{Wrong naming format for the first slice!}
    end
  end #end of standard_joiner

  ##
  # This method does the actual joining of slices.
  # It gets an Array of slice names and name of the 
  # output file.
  #
  # Example: 
  #   >> join("book.pdf", ["book.pdf.001", "book.pdf.002"])
  # Arguments:
  #     output_file_name: (String)
  #     slice_names:      (Array) 
  # 
  def join(output_file_name, slice_names)
    output_file = File.open(output_file_name, 'wb')

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