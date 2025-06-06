---
title: File formats
---

Some notes on file formats.

UTF-8 text is mostly straightforward to deal with, except that visual characters can be nearly arbitrarily many bytes long.

## Structured documents

A CSV-type format is good for tables. It's easy to process using common tools.
TSV is typically better than CSV, because it defaults to slash escaping. This means that a literal tab or a literal newline always are an actual tab or newline.
Try to always include a header in the data.

[Recfiles](https://en.wikipedia.org/wiki/Recfiles) allow duplicate keys instead of requiring an array. They are easy to read, but the tooling for them is minimal.

INI style files are good for simple key value storage. TOML is a more standardized version.

JSON is nice for very structured data that doesn't have a fixed field count. It doesn't have comments, which in turn makes it straightforward to manipulate with a computer.

XML has warts, but if you need to markup a text document it works well. For example, marking some text as bold is easy with XML, hard with JSON, because XML is inline.

YAML gets a bad rap; to avoid?

## Magic numbers, metadata and other design principles

Files work best when they are self contained.

A magic number helps other programs to quickly and reliably identifying the file type.
See also: https://fadden.com/tech/file-formats.html

At some point someone will want to embed metadata. Consider using some kind of container structure from the start.

Include a way to detect corruption, for example truncation. A trailing CRC and end of file marker would suffice.

Supporting macros or other kinds of progammability risks creating security problems. Prefer declarative content where possible.

Supporting schemas in generic formats allows editors to provide smart autocompletion.
Schemas as URLs opens up privacy concerns; consider alternatives.

Unix has good support for handling newline-delimited record orientated data. Consider leveraging that.

The standard for escaping text is slash-escaping. Specify what happens with unrecognized sequences.

For escaping delimiters in binary content, consider using [COBS](https://en.wikipedia.org/wiki/Consistent_Overhead_Byte_Stuffing). It has a predicatable overhead unlike slash-escaping which can double the payload size.

If using binary data, consider using an [IDL](https://en.wikipedia.org/wiki/Interface_description_language) such as ASN.1 or Protobuf. This allows generating the parsing code.

