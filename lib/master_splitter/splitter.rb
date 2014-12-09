module MasterSplitter

  def split(source_file_name, slice_names, slices_sizes)
    source = File.open(source_file_name, 'rb')

    slice_names.size.times do |i|
      slice = File.open(slice_names[i], 'wb')
      bytes_to_write = slices_sizes[i]

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