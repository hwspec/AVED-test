set src_dir [file dirname [file normalize [info script]]]
set pca_rtl_dir "$src_dir/rtl/pca"

if { [file isdirectory $pca_rtl_dir] } {
  # Grab both .sv and .v files
  set pca_sv_files [glob -nocomplain -directory $pca_rtl_dir *.sv]
  set pca_v_files  [glob -nocomplain -directory $pca_rtl_dir *.v]
  set pca_files    [concat $pca_sv_files $pca_v_files]

  if { [llength $pca_files] > 0 } {
    import_files -fileset sources_1 -norecurse $pca_files
    update_compile_order -fileset sources_1
    puts "PCA: Added [llength $pca_files] files to sources_1"
    foreach f $pca_files { puts "  [file tail $f]" }
  } else {
    puts "PCA: No .sv/.v files found in $pca_rtl_dir"
  }
} else {
  puts "PCA: Directory $pca_rtl_dir not found"
}
