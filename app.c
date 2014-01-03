#include <stdio.h>
#include "helpers.h"

SectionInfo *self_get_second_info(char *section_name) {
  /* Fetch section position/size info from current
  executable. This relies on /proc to reference our
  runtime. You can use get_section_info() on a path
  directly if you want to extract from a different
  binary */


  /* Uses /proc to find current path, this will not
  work if proc isn't available. There are other
  ways to get current runtime if required, but I have
  not implemented it here */
  char *current_path = get_current_path();
  if (!current_path) {
    return NULL;
  }

  /* find image offset */
  SectionInfo *sinfo = get_section_info(current_path, section_name);

  return sinfo;
}

void example_usage() {
  /* name to extract */
  char *section_name = "embeddedimage";
  
  SectionInfo *sinfo = self_get_second_info(section_name);

  if (sinfo) {
    printf("[x] embedded image found at offset %d, size %d\n", sinfo->offset, sinfo->size);
  } else {
    printf("[x] no embedded image found\n");
  }
}

main(int argc, char** argv)
{
  example_usage();
  return 0;
}

