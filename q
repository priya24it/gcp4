I wanted to get your thoughts on something I’ve observed in our current setup. As soon as a file is dropped, a corresponding Cloud Run Job is triggered, and each one generates a unique Invocation ID. From what I understand, this likely means that a new container (and possibly a new VM) is being spun up for each file to process it.

Would this approach place additional load on the system, especially if multiple files are dropped in a short span of time?
