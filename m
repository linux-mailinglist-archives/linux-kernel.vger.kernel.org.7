Return-Path: <linux-kernel+bounces-782141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C40B31BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CE51D077F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C329343D82;
	Fri, 22 Aug 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oU65SJP/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB03126B3;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=rnvaPTWD+/BuwC3CSM/EbEa7HT2vPI15bCatnQ/v013wzq1ZfNXzYJKTzvGJkGzlVrzGRFTnMKrG80axbcDyVaV1abp3FDuhdC1iQBsN8nte6hThjo+cQIgxnsTKsMAP2y4c3zyCCZl7pomE7juty8pNY0UFwpI3PMXjQcfZK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=IkR2tDIMqOGFWIt+/VpJUQvrkHkeqcw1eRxVumPctes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+cVsIxFV34BQE0+Rxrt2sRPXtEGzhbhIYxdQhlVP20an4xne0zC/zoAG1nx7Xvpr3Xjvm0qbVAG+kIkFSbKYyJWwUGLDqXWNm4fN0SbcVWeqYRVtYU1LoXg3zkpzZ97cFGATZF1lnh+j9mCEEjKI1pHaAe6Vng+1e4wwoiaV+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oU65SJP/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E97C116D0;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=IkR2tDIMqOGFWIt+/VpJUQvrkHkeqcw1eRxVumPctes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oU65SJP/+jTEHTdqTyCfM+UFLSFdFufzlQG6yrIQibvMjeyaPCDZMHGhNUprTFotx
	 hHNAGLEW3JhEzU/91ob0zp9BVM4ppQav7TMPy5ktxJZLEvz2xePoGeFyx7rhlehf3A
	 SZq4/NQm4sFnCj3zJH64K8BkFWdv0n9f2W6bwlI5InXEjLNyQAKsrpBNreIK8RAvPZ
	 SnxY8VlJDnE7fIAR29afATlqu9Nw1H30hSznzWEzYg/mhdgtE5QF7MAZrl3Ax4EAMV
	 CkUSYjfgJFkiOaVq+UZQCKOIIyUfSErtMC9ENCE5fzHd3TzH3Ht4YawQbDAkcrTlyq
	 rA5pK9xaIXJVQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCqz-0fiZ;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/24] docs: parse-headers.py: convert parse-headers.pl
Date: Fri, 22 Aug 2025 16:19:14 +0200
Message-ID: <ae5cfa8dff37e280cc9493fc95a51cd0cc0ba127.1755872208.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755872208.git.mchehab+huawei@kernel.org>
References: <cover.1755872208.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

When the Kernel started to use Sphinx, we had to come up with
a solution to parse media headers. On that time, we didn't have
much experience with Sphinx extensions. So, we came up with our
own script-based solution that were basically implementing a
set of rules we used to have at the Makefile.

Convert it to Python, keeping it bug-compatible with the
original script.

While here, try to better document it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parse-headers.py | 429 ++++++++++++++++++++++++++
 1 file changed, 429 insertions(+)
 create mode 100755 Documentation/sphinx/parse-headers.py

diff --git a/Documentation/sphinx/parse-headers.py b/Documentation/sphinx/parse-headers.py
new file mode 100755
index 000000000000..b39284d21090
--- /dev/null
+++ b/Documentation/sphinx/parse-headers.py
@@ -0,0 +1,429 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2016 by Mauro Carvalho Chehab <mchehab@kernel.org>.
+# pylint: disable=C0103,R0902,R0912,R0914,R0915
+
+"""
+Convert a C header or source file (C_FILE), into a ReStructured Text
+included via ..parsed-literal block with cross-references for the
+documentation files that describe the API. It accepts an optional
+EXCEPTIONS_FILE with describes what elements will be either ignored or
+be pointed to a non-default reference.
+
+The output is written at the (OUT_FILE).
+
+It is capable of identifying defines, functions, structs, typedefs,
+enums and enum symbols and create cross-references for all of them.
+It is also capable of distinguish #define used for specifying a Linux
+ioctl.
+
+The EXCEPTIONS_FILE contains a set of rules like:
+
+    ignore ioctl VIDIOC_ENUM_FMT
+    replace ioctl VIDIOC_DQBUF vidioc_qbuf
+    replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
+"""
+
+import argparse
+import os
+import re
+import sys
+
+
+class ParseHeader:
+    """
+    Creates an enriched version of a Kernel header file with cross-links
+    to each C data structure type.
+
+    It is meant to allow having a more comprehensive documentation, where
+    uAPI headers will create cross-reference links to the code.
+
+    It is capable of identifying defines, functions, structs, typedefs,
+    enums and enum symbols and create cross-references for all of them.
+    It is also capable of distinguish #define used for specifying a Linux
+    ioctl.
+
+    By default, it create rules for all symbols and defines, but it also
+    allows parsing an exception file. Such file contains a set of rules
+    using the syntax below:
+
+    1. Ignore rules:
+
+        ignore <type> <symbol>`
+
+    Removes the symbol from reference generation.
+
+    2. Replace rules:
+
+        replace <type> <old_symbol> <new_reference>
+
+    Replaces how old_symbol with a new reference. The new_reference can be:
+        - A simple symbol name;
+        - A full Sphinx reference.
+
+    On both cases, <type> can be:
+        - ioctl: for defines that end with _IO*, e.g. ioctl definitions
+        - define: for other defines
+        - symbol: for symbols defined within enums;
+        - typedef: for typedefs;
+        - enum: for the name of a non-anonymous enum;
+        - struct: for structs.
+
+    Examples:
+
+        ignore define __LINUX_MEDIA_H
+        ignore ioctl VIDIOC_ENUM_FMT
+        replace ioctl VIDIOC_DQBUF vidioc_qbuf
+        replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
+    """
+
+    # Parser regexes with multiple ways to capture enums and structs
+    RE_ENUMS = [
+        re.compile(r"^\s*enum\s+([\w_]+)\s*\{"),
+        re.compile(r"^\s*enum\s+([\w_]+)\s*$"),
+        re.compile(r"^\s*typedef\s*enum\s+([\w_]+)\s*\{"),
+        re.compile(r"^\s*typedef\s*enum\s+([\w_]+)\s*$"),
+    ]
+    RE_STRUCTS = [
+        re.compile(r"^\s*struct\s+([_\w][\w\d_]+)\s*\{"),
+        re.compile(r"^\s*struct\s+([_\w][\w\d_]+)$"),
+        re.compile(r"^\s*typedef\s*struct\s+([_\w][\w\d_]+)\s*\{"),
+        re.compile(r"^\s*typedef\s*struct\s+([_\w][\w\d_]+)$"),
+    ]
+
+    # FIXME: the original code was written a long time before Sphinx C
+    # domain to have multiple namespaces. To avoid to much turn at the
+    # existing hyperlinks, the code kept using "c:type" instead of the
+    # right types. To change that, we need to change the types not only
+    # here, but also at the uAPI media documentation.
+    DEF_SYMBOL_TYPES = {
+        "ioctl": {
+            "prefix": "\\ ",
+            "suffix": "\\ ",
+            "ref_type": ":ref",
+        },
+        "define": {
+            "prefix": "\\ ",
+            "suffix": "\\ ",
+            "ref_type": ":ref",
+        },
+        # We're calling each definition inside an enum as "symbol"
+        "symbol": {
+            "prefix": "\\ ",
+            "suffix": "\\ ",
+            "ref_type": ":ref",
+        },
+        "typedef": {
+            "prefix": "\\ ",
+            "suffix": "\\ ",
+            "ref_type": ":c:type",
+        },
+        # This is the name of the enum itself
+        "enum": {
+            "prefix": "",
+            "suffix": "\\ ",
+            "ref_type": ":c:type",
+        },
+        "struct": {
+            "prefix": "",
+            "suffix": "\\ ",
+            "ref_type": ":c:type",
+        },
+    }
+
+    def __init__(self, debug: bool = False):
+        """Initialize internal vars"""
+        self.debug = debug
+        self.data = ""
+
+        self.symbols = {}
+
+        for symbol_type in self.DEF_SYMBOL_TYPES:
+            self.symbols[symbol_type] = {}
+
+    def store_type(self, symbol_type: str, symbol: str,
+                   ref_name: str = None, replace_underscores: bool = True):
+        """
+        Stores a new symbol at self.symbols under symbol_type.
+
+        By default, underscores are replaced by "-"
+        """
+        defs = self.DEF_SYMBOL_TYPES[symbol_type]
+
+        prefix = defs.get("prefix", "")
+        suffix = defs.get("suffix", "")
+        ref_type = defs.get("ref_type")
+
+        # Determine ref_link based on symbol type
+        if ref_type:
+            if symbol_type == "enum":
+                ref_link = f"{ref_type}:`{symbol}`"
+            else:
+                if not ref_name:
+                    ref_name = symbol.lower()
+
+                if replace_underscores:
+                    ref_name = ref_name.replace("_", "-")
+
+                ref_link = f"{ref_type}:`{symbol} <{ref_name}>`"
+        else:
+            ref_link = symbol
+
+        self.symbols[symbol_type][symbol] = f"{prefix}{ref_link}{suffix}"
+
+    def store_line(self, line):
+        """Stores a line at self.data, properly indented"""
+        line = "    " + line.expandtabs()
+        self.data += line.rstrip(" ")
+
+    def parse_file(self, file_in: str):
+        """Reads a C source file and get identifiers"""
+        self.data = ""
+        is_enum = False
+        is_comment = False
+        multiline = ""
+
+        with open(file_in, "r",
+                  encoding="utf-8", errors="backslashreplace") as f:
+            for line_no, line in enumerate(f):
+                self.store_line(line)
+                line = line.strip("\n")
+
+                # Handle continuation lines
+                if line.endswith(r"\\"):
+                    multiline += line[-1]
+                    continue
+
+                if multiline:
+                    line = multiline + line
+                    multiline = ""
+
+                # Handle comments. They can be multilined
+                if not is_comment:
+                    if re.search(r"/\*.*", line):
+                        is_comment = True
+                    else:
+                        # Strip C99-style comments
+                        line = re.sub(r"(//.*)", "", line)
+
+                if is_comment:
+                    if re.search(r".*\*/", line):
+                        is_comment = False
+                    else:
+                        multiline = line
+                        continue
+
+                # At this point, line variable may be a multilined statement,
+                # if lines end with \ or if they have multi-line comments
+                # With that, it can safely remove the entire comments,
+                # and there's no need to use re.DOTALL for the logic below
+
+                line = re.sub(r"(/\*.*\*/)", "", line)
+                if not line.strip():
+                    continue
+
+                # It can be useful for debug purposes to print the file after
+                # having comments stripped and multi-lines grouped.
+                if self.debug > 1:
+                    print(f"line {line_no + 1}: {line}")
+
+                # Now the fun begins: parse each type and store it.
+
+                # We opted for a two parsing logic here due to:
+                # 1. it makes easier to debug issues not-parsed symbols;
+                # 2. we want symbol replacement at the entire content, not
+                #    just when the symbol is detected.
+
+                if is_enum:
+                    match = re.match(r"^\s*([_\w][\w\d_]+)\s*[\,=]?", line)
+                    if match:
+                        self.store_type("symbol", match.group(1))
+                    if "}" in line:
+                        is_enum = False
+                    continue
+
+                match = re.match(r"^\s*#\s*define\s+([\w_]+)\s+_IO", line)
+                if match:
+                    self.store_type("ioctl", match.group(1),
+                                    replace_underscores=False)
+                    continue
+
+                match = re.match(r"^\s*#\s*define\s+([\w_]+)(\s+|$)", line)
+                if match:
+                    self.store_type("define", match.group(1))
+                    continue
+
+                match = re.match(r"^\s*typedef\s+([_\w][\w\d_]+)\s+(.*)\s+([_\w][\w\d_]+);",
+                                 line)
+                if match:
+                    name = match.group(2).strip()
+                    symbol = match.group(3)
+                    self.store_type("typedef", symbol, ref_name=name,
+                                    replace_underscores=False)
+                    continue
+
+                for re_enum in self.RE_ENUMS:
+                    match = re_enum.match(line)
+                    if match:
+                        self.store_type("enum", match.group(1))
+                        is_enum = True
+                        break
+
+                for re_struct in self.RE_STRUCTS:
+                    match = re_struct.match(line)
+                    if match:
+                        self.store_type("struct", match.group(1),
+                                        replace_underscores=False)
+                        break
+
+    def process_exceptions(self, fname: str):
+        """
+        Process exceptions file with rules to ignore or replace references.
+        """
+        if not fname:
+            return
+
+        name = os.path.basename(fname)
+
+        with open(fname, "r", encoding="utf-8", errors="backslashreplace") as f:
+            for ln, line in enumerate(f):
+                ln += 1
+                line = line.strip()
+                if not line or line.startswith("#"):
+                    continue
+
+                # Handle ignore rules
+                match = re.match(r"^ignore\s+(\w+)\s+(\S+)", line)
+                if match:
+                    c_type = match.group(1)
+                    symbol = match.group(2)
+
+                    if c_type not in self.DEF_SYMBOL_TYPES:
+                        sys.exit(f"{name}:{ln}: {c_type} is invalid")
+
+                    d = self.symbols[c_type]
+                    if symbol in d:
+                        del d[symbol]
+
+                    continue
+
+                # Handle replace rules
+                match = re.match(r"^replace\s+(\S+)\s+(\S+)\s+(\S+)", line)
+                if not match:
+                    sys.exit(f"{name}:{ln}: invalid line: {line}")
+
+                c_type, old, new = match.groups()
+
+                if c_type not in self.DEF_SYMBOL_TYPES:
+                    sys.exit(f"{name}:{ln}: {c_type} is invalid")
+
+                reftype = None
+
+                # Parse reference type when the type is specified
+
+                match = re.match(r"^\:c\:(data|func|macro|type)\:\`(.+)\`", new)
+                if match:
+                    reftype = f":c:{match.group(1)}"
+                    new = match.group(2)
+                else:
+                    match = re.search(r"(\:ref)\:\`(.+)\`", new)
+                    if match:
+                        reftype = match.group(1)
+                        new = match.group(2)
+
+                # If the replacement rule doesn't have a type, get default
+                if not reftype:
+                    reftype = self.DEF_SYMBOL_TYPES[c_type].get("ref_type")
+                    if not reftype:
+                        reftype = self.DEF_SYMBOL_TYPES[c_type].get("real_type")
+
+                new_ref = f"{reftype}:`{old} <{new}>`"
+
+                # Change self.symbols to use the replacement rule
+                if old in self.symbols[c_type]:
+                    self.symbols[c_type][old] = new_ref
+                else:
+                    print(f"{name}:{ln}: Warning: can't find {old} {c_type}")
+
+    def debug_print(self):
+        """
+        Print debug information containing the replacement rules per symbol.
+        To make easier to check, group them per type.
+        """
+        if not self.debug:
+            return
+
+        for c_type, refs in self.symbols.items():
+            if not refs:  # Skip empty dictionaries
+                continue
+
+            print(f"{c_type}:")
+
+            for symbol, ref in sorted(refs.items()):
+                print(f"  {symbol} -> {ref}")
+
+            print()
+
+    def write_output(self, file_in: str, file_out: str):
+        """Write the formatted output to a file."""
+
+        # Avoid extra blank lines
+        text = re.sub(r"\s+$", "", self.data) + "\n"
+        text = re.sub(r"\n\s+\n", "\n\n", text)
+
+        # Escape Sphinx special characters
+        text = re.sub(r"([\_\`\*\<\>\&\\\\:\/\|\%\$\#\{\}\~\^])", r"\\\1", text)
+
+        # Source uAPI files may have special notes. Use bold font for them
+        text = re.sub(r"DEPRECATED", "**DEPRECATED**", text)
+
+        # Delimiters to catch the entire symbol after escaped
+        start_delim = r"([ \n\t\(=\*\@])"
+        end_delim = r"(\s|,|\\=|\\:|\;|\)|\}|\{)"
+
+        # Process all reference types
+        for ref_dict in self.symbols.values():
+            for symbol, replacement in ref_dict.items():
+                symbol = re.escape(re.sub(r"([\_\`\*\<\>\&\\\\:\/])", r"\\\1", symbol))
+                text = re.sub(fr'{start_delim}{symbol}{end_delim}',
+                              fr'\1{replacement}\2', text)
+
+        # Remove "\ " where not needed: before spaces and at the end of lines
+        text = re.sub(r"\\ ([\n ])", r"\1", text)
+
+        title = os.path.basename(file_in)
+
+        with open(file_out, "w", encoding="utf-8", errors="backslashreplace") as f:
+            f.write(".. -*- coding: utf-8; mode: rst -*-\n\n")
+            f.write(f"{title}\n")
+            f.write("=" * len(title))
+            f.write("\n\n.. parsed-literal::\n\n")
+            f.write(text)
+
+
+def main():
+    """Main function"""
+    parser = argparse.ArgumentParser(description=__doc__,
+                                     formatter_class=argparse.RawDescriptionHelpFormatter)
+
+    parser.add_argument("-d", "--debug", action="count", default=0,
+                        help="Increase debug level. Can be used multiple times")
+    parser.add_argument("file_in", help="Input C file")
+    parser.add_argument("file_out", help="Output RST file")
+    parser.add_argument("file_exceptions", nargs="?",
+                        help="Exceptions file (optional)")
+
+    args = parser.parse_args()
+
+    parser = ParseHeader(debug=args.debug)
+    parser.parse_file(args.file_in)
+
+    if args.file_exceptions:
+        parser.process_exceptions(args.file_exceptions)
+
+    parser.debug_print()
+    parser.write_output(args.file_in, args.file_out)
+
+
+if __name__ == "__main__":
+    main()
-- 
2.50.1


