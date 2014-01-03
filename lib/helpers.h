typedef struct section_info {
  int offset;
  int size;
}SectionInfo;

SectionInfo *get_section_info(char *targetpath, char *section_name);
char *get_current_path();