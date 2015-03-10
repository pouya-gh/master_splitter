module MasterSplitter
  # Max size of each read/write from/to files.
  MAX_CHUNK_SIZE = 1024 * 1024
  # Naming format of a sliced file.
  STANDARD_SLICE_NAMING_FORMAT = /^(.*)\.(\d{3,})$/i
  # For capturing only name of a file.
  FILE_NAME_FINDER = /^.*\/(.*)$/i
end