User Story: "Include Sub-Folders" Filter Not Working
Title:
"Include Sub-Folders" filter is not being applied correctly during file processing

As a
Data Engineer / ETL pipeline user,

I want
the "include-sub-folders" parameter to control whether sub-directories are scanned for files during processing,

So that
the pipeline behaves as expected based on the user's configuration and only includes files from appropriate folder levels.

Context / Background:
In the current pipeline setup, users can define the following parameters:

start-date

end-date

include-sub-folders (values: Y or N)

The "include-sub-folders" flag is intended to determine whether files inside subdirectories of the source bucket/directory should be processed.

Problem:
When "include-sub-folders" is set to "N", the expectation is that:

Only files from the root level of the source directory are processed.

Sub-directories are ignored completely.

However, testing shows that:

Files inside sub-folders are still being picked up and processed, regardless of the value set in "include-sub-folders".

Expected Behavior:
Parameter	Expected Outcome
"include-sub-folders": "N"	Only files at the root of the source path are scanned
"include-sub-folders": "Y"	All files, including those in nested folders, are recursively scanned and processed
Steps to Reproduce:
Set include-sub-folders to "N"

Place test files:

One in the root directory

One in a sub-directory (e.g. /source/data/sub-folder/file.json)

Run the process

Observe: both files are processed, even though the sub-folder one should not be.

Technical Suggestion:
Ensure that when include-sub-folders is "N", the file walking logic uses a non-recursive listing.

Example Python logic:

python
Copy
Edit
import os

if include_sub_folders == "Y":
    for root, dirs, files in os.walk(source_dir):  # Recursive
        ...
else:
    files = os.listdir(source_dir)  # Non-recursive
    ...
Acceptance Criteria:
✅ Files inside sub-folders are excluded when include-sub-folders is "N"

✅ Full recursive scan happens when include-sub-folders is "Y"

✅ Unit/integration test cases cover both scenarios
