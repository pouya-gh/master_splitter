module MasterSplitter
  
  ##
  # With this method you can split a file to slices which
  # you can specify size of each slice.
  # Sum of all slice sizes must be equal to the size of the
  # orginal fille.
  # Needless to say, sizes must be in bytes.
  # Example: 
  #   >> custom_splitter("file.pdf", 
  #                      [1232, 5432], output_dir: "Desktop/")
  # Arguments:
  #     source_file_name: (String)
  #     slice_sizes:      (Array)
  #     options:          (Hash) 
  # 
  def custom_splitter(source_file_name, slice_sizes, options={})
    slice_names = []
    output_dir = options[:output_dir]
    sum_of_sizes = slice_sizes.each(&:+)
    source = File.open(source_file_name, 'rb')
    if sum_of_sizes != source.size
      source.close
      raise Exception, "sum of slice sizes does not equal size of source file."
    end
    source.close
    slice_sizes.count.times do |i|
      temp = ("%3d"%[i + 1]).gsub(" ", "0")

      if output_dir
        slice_name = source_file_name
        if source_file_name.include?("/")
          slice_name = FILE_NAME_FINDER.match(source_file_name)[1]
        end
        slice_names << File.join(output_dir, [slice_name, temp].join('.'))
      else
        slice_names << [source_file_name, temp].join('.')
      end
    end #end of iteration
    split(source_file_name, slice_names, slice_sizes)
  end #end of custom_splitter

  ##
  # This method splits a given file to a specified 
  # number of slices, equally.
  # Example: 
  #   >> standard_splitter("file.pdf", 
  #                         5, 
  #                         output_dir: "Desktop/")
  # Arguments:
  #     source_file_name: (String)
  #     number_of_slices: (Fixnum)
  #     options:          (Hash) 
  #
  def standard_splitter(source_file_name, number_of_slices, options={})
    slice_sizes = []
    slice_names = []
    output_dir = options[:output_dir]
    source = File.open(source_file_name, 'rb')
    source_size = source.size
    slice_size = source_size / number_of_slices
    slice_name = source_file_name
    if source_file_name.include?('/')
      slice_name = FILE_NAME_FINDER.match(source_file_name)[1]
    end

    number_of_slices.times do |n|
      slice_sizes << slice_size
      temp = ("%3d"%[n + 1]).gsub(" ", "0")
      if output_dir
        slice_names << File.join(output_dir, [slice_name, temp].join('.'))
      else
        slice_names << [source_file_name, temp].join('.')
      end
    end
    remain_bytes = source_size - (slice_size * number_of_slices)
    slice_sizes[-1] +=  remain_bytes

    source.close
    split(source_file_name, slice_names, slice_sizes)
  end #end of standard_splitter

  ##
  # This method does the actual splitting of file.
  # It gets the name of the source file and two arrays.
  # One contains names of the slices and the other their sizes.
  # Example: 
  #   >> split("book.pdf", ["book.pdf.001", "book.pdf.002"], [6456, 6456])
  # Arguments:
  #     source_file_name: (String)
  #     slice_names:      (Array) 
  #     slice_sizes:      (Array)
  # 
  def split(source_file_name, slice_names, slice_sizes)
    source = File.open(source_file_name, 'rb')

    slice_names.size.times do |i|
      slice = File.open(slice_names[i], 'wb')
      bytes_to_write = slice_sizes[i]

      while bytes_to_write > 0
        chunk = MAX_CHUNK_SIZE
        chunk = bytes_to_write if(bytes_to_write < MAX_CHUNK_SIZE)
        slice.write(source.read(chunk))
        bytes_to_write -= chunk
      end #end of while
      slice.close
    end #end of iteration

    source.close
  end #end of split
end #end of module