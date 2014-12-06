module MasterSplitter
  
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