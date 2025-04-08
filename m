Return-Path: <linux-kernel+bounces-593625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB42A7FB8D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 12:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F76421776
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949C326B959;
	Tue,  8 Apr 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjzjZe8j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E79267B8C;
	Tue,  8 Apr 2025 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106998; cv=none; b=jL9bJThqiHcC6dNW5ZGjveFSaFrK9G3yJndVwtL9a+P7LHT+Ds0+9II45BSK47u6HbwmOeRUNwd4KCVdZkPkGE5bq+QQBhukItmnQOSp+quDNZrwhT89YKZueBsUqJ2uRnMrotzmj/qw1jjte8rMvvGA+UKAtoOYE53Rc8O/fhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106998; c=relaxed/simple;
	bh=MjPkjAVjtvK/jz1L+9NY2p6Gy9QUudbHBhmVAWY0J3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNdZTY/tabKVLscYQhumQDN9gdxE8ygHS9FLOd7PiFZlJ1iFZgu+qF3T5dG47Hf/UriWkwCOhfGaY0LJQDYcIi7uhKvv/r/LstA1vo9/MBG3pHdAnQqXqJAUDBnZSyvFknniHZb7EJfvtVDnKikGI/mcNXFfj4t4y2LB09I98Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjzjZe8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F43C4CEEE;
	Tue,  8 Apr 2025 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744106998;
	bh=MjPkjAVjtvK/jz1L+9NY2p6Gy9QUudbHBhmVAWY0J3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NjzjZe8joKS50tfTuN3j0IM+I7J9xbKMnQN3jxObABNcYrAhHNgccxLzx8MdYaCV9
	 fzVc5LtwO0Y2XOh9L26H1RlPICoERDymYUFmcYtU8bN9T5D4BC9KvpYritYzucbgNW
	 W3/PbV/gBMeocMyZgaT6+jhJLrxZpLeHWaCrQjvgZGWrE/VA6mUFM3ynCXZZ9jeGI6
	 rXiTBxh0ypHHQt0H25dINPzx9LwseDy6ZTTBWTk4JNF1meK0UNBWtfVURE2r3jnR44
	 EbrBH29oxik9cfxKu8ki0ayjim08KCuQosUUSnH4c9F3qVK69KAsC52VqhJSoAGV/C
	 BnT6+/8gvZf+A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1u25ts-00000008RVO-4AyL;
	Tue, 08 Apr 2025 18:09:48 +0800
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/33] scripts/kernel-doc.py: add a Python parser
Date: Tue,  8 Apr 2025 18:09:06 +0800
Message-ID: <2fa671a9fb08d03a376a42d46cc0b1d3aab4ae3f.1744106241.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744106241.git.mchehab+huawei@kernel.org>
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Maintaining kernel-doc has been a challenge, as there aren't many
perl developers among maintainers. Also, the logic there is too
complex. Having lots of global variables and using pure functions
doesn't help.

Rewrite the script in Python, placing most global variables
inside classes. This should help maintaining the script in long
term.

It also allows a better integration with kernel-doc Sphinx
extension in the future.

I opted to keep this version as close as possible to what we
have already in Perl. There are some differences though:

1. There is one regular expression that required a rewrite:

	/\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;/

   As this one uses two features that aren't available by the native
   Python regular expression module (re):

	- recursive patterns: ?1
	- atomic grouping (?>...)

   Rewrite it to use a much simpler regular expression:

	/\bSTRUCT_GROUP\(([^\)]+)\)[^;]*;/

   Extra care should be taken when validating this script, as such
   replacement might cause some regressions.

2. The filters are now applied only during output generation.
   In particular, "nosymbol" argument is only handled there.

   It means that, if the same file is processed twice for
   different symbols, the warnings will be duplicated.

   I opted to use this behavior as it allows the Sphinx extension
   to read the file(s) only once, and apply the filtering only
   when producing the ReST output. This hopefully will help
   to speed up doc generation

3. This version can handle multiple files and multiple directories.

   So, if one just wants to produce a big output with everything
   inside a file, this could be done with

   $ time ./scripts/kernel-doc.py -man . 2>/dev/null >new
   real    0m54.592s
   user    0m53.345s
   sys     0m0.997s

4. I tried to replicate as much as possible the same arguments
   from kernel-doc, with about the same behavior, for the
   command line parameters starting with a single dash (-parameter).

   I also added one letter aliases for each parameter, and a
   --parameter (sometimes with a better name).

5. There are some sutile nuances between how Perl handles
   certain regular expressions. In special, the qr operatior,
   which compiles a regular expression also works as a
   non-capturing group. It means that some regexes like
   this one:

	my $type1 = qr{[\w\s]+};

   needs to be mapped as:

	type1 = r'(?:[\w\s]+)?'

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

---

TODO:
- on this RFC, the man output doesn't match yet the same output of
  kernel-doc. The ReST output matches, except for some whitespaces
  and suppressed empty sectionsl
- this version lacks support for -W<filter> parameters: it will just
  output all warnings.
- all classes are at the same file. I want to split the classes on
  multiple files for the final version, but, during development time,
  it is easier to have everything on a single file, but I plan to split
  classes on different files to help maintaining the script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kernel-doc.py | 2832 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 2832 insertions(+)
 create mode 100755 scripts/kernel-doc.py

diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
new file mode 100755
index 000000000000..114f3699bf7c
--- /dev/null
+++ b/scripts/kernel-doc.py
@@ -0,0 +1,2832 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+#
+# pylint: disable=R0902,R0903,R0904,R0911,R0912,R0913,R0914,R0915,R0917,R1702
+# pylint: disable=C0302,C0103,C0301
+# pylint: disable=C0116,C0115,W0511,W0613
+#
+# Converted from the kernel-doc script originally written in Perl
+# under GPLv2, copyrighted since 1998 by the following authors:
+#
+#    Aditya Srivastava <yashsri421@gmail.com>
+#    Akira Yokosawa <akiyks@gmail.com>
+#    Alexander A. Klimov <grandmaster@al2klimov.de>
+#    Alexander Lobakin <aleksander.lobakin@intel.com>
+#    André Almeida <andrealmeid@igalia.com>
+#    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+#    Anna-Maria Behnsen <anna-maria@linutronix.de>
+#    Armin Kuster <akuster@mvista.com>
+#    Bart Van Assche <bart.vanassche@sandisk.com>
+#    Ben Hutchings <ben@decadent.org.uk>
+#    Borislav Petkov <bbpetkov@yahoo.de>
+#    Chen-Yu Tsai <wenst@chromium.org>
+#    Coco Li <lixiaoyan@google.com>
+#    Conchúr Navid <conchur@web.de>
+#    Daniel Santos <daniel.santos@pobox.com>
+#    Danilo Cesar Lemes de Paula <danilo.cesar@collabora.co.uk>
+#    Dan Luedtke <mail@danrl.de>
+#    Donald Hunter <donald.hunter@gmail.com>
+#    Gabriel Krisman Bertazi <krisman@collabora.co.uk>
+#    Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+#    Harvey Harrison <harvey.harrison@gmail.com>
+#    Horia Geanta <horia.geanta@freescale.com>
+#    Ilya Dryomov <idryomov@gmail.com>
+#    Jakub Kicinski <kuba@kernel.org>
+#    Jani Nikula <jani.nikula@intel.com>
+#    Jason Baron <jbaron@redhat.com>
+#    Jason Gunthorpe <jgg@nvidia.com>
+#    Jérémy Bobbio <lunar@debian.org>
+#    Johannes Berg <johannes.berg@intel.com>
+#    Johannes Weiner <hannes@cmpxchg.org>
+#    Jonathan Cameron <Jonathan.Cameron@huawei.com>
+#    Jonathan Corbet <corbet@lwn.net>
+#    Jonathan Neuschäfer <j.neuschaefer@gmx.net>
+#    Kamil Rytarowski <n54@gmx.com>
+#    Kees Cook <kees@kernel.org>
+#    Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+#    Levin, Alexander (Sasha Levin) <alexander.levin@verizon.com>
+#    Linus Torvalds <torvalds@linux-foundation.org>
+#    Lucas De Marchi <lucas.demarchi@profusion.mobi>
+#    Mark Rutland <mark.rutland@arm.com>
+#    Markus Heiser <markus.heiser@darmarit.de>
+#    Martin Waitz <tali@admingilde.org>
+#    Masahiro Yamada <masahiroy@kernel.org>
+#    Matthew Wilcox <willy@infradead.org>
+#    Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+#    Michal Wajdeczko <michal.wajdeczko@intel.com>
+#    Michael Zucchi
+#    Mike Rapoport <rppt@linux.ibm.com>
+#    Niklas Söderlund <niklas.soderlund@corigine.com>
+#    Nishanth Menon <nm@ti.com>
+#    Paolo Bonzini <pbonzini@redhat.com>
+#    Pavan Kumar Linga <pavan.kumar.linga@intel.com>
+#    Pavel Pisa <pisa@cmp.felk.cvut.cz>
+#    Peter Maydell <peter.maydell@linaro.org>
+#    Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+#    Randy Dunlap <rdunlap@infradead.org>
+#    Richard Kennedy <richard@rsk.demon.co.uk>
+#    Rich Walker <rw@shadow.org.uk>
+#    Rolf Eike Beer <eike-kernel@sf-tec.de>
+#    Sakari Ailus <sakari.ailus@linux.intel.com>
+#    Silvio Fricke <silvio.fricke@gmail.com>
+#    Simon Huggins
+#    Tim Waugh <twaugh@redhat.com>
+#    Tomasz Warniełło <tomasz.warniello@gmail.com>
+#    Utkarsh Tripathi <utripathi2002@gmail.com>
+#    valdis.kletnieks@vt.edu <valdis.kletnieks@vt.edu>
+#    Vegard Nossum <vegard.nossum@oracle.com>
+#    Will Deacon <will.deacon@arm.com>
+#    Yacine Belkadi <yacine.belkadi.1@gmail.com>
+#    Yujie Liu <yujie.liu@intel.com>
+
+# TODO: implement warning filtering
+
+"""
+kernel_doc
+==========
+
+Print formatted kernel documentation to stdout
+
+Read C language source or header FILEs, extract embedded
+documentation comments, and print formatted documentation
+to standard output.
+
+The documentation comments are identified by the "/**"
+opening comment mark.
+
+See Documentation/doc-guide/kernel-doc.rst for the
+documentation comment syntax.
+"""
+
+import argparse
+import logging
+import os
+import re
+import sys
+
+from datetime import datetime
+from pprint import pformat
+
+from dateutil import tz
+
+# Local cache for regular expressions
+re_cache = {}
+
+
+class Re:
+    """
+    Helper class to simplify regex declaration and usage,
+
+    It calls re.compile for a given pattern. It also allows adding
+    regular expressions and define sub at class init time.
+
+    Regular expressions can be cached via an argument, helping to speedup
+    searches.
+    """
+
+    def _add_regex(self, string, flags):
+        if string in re_cache:
+            self.regex = re_cache[string]
+        else:
+            self.regex = re.compile(string, flags=flags)
+
+            if self.cache:
+                re_cache[string] = self.regex
+
+    def __init__(self, string, cache=True, flags=0):
+        self.cache = cache
+        self.last_match = None
+
+        self._add_regex(string, flags)
+
+    def __str__(self):
+        return self.regex.pattern
+
+    def __add__(self, other):
+        return Re(str(self) + str(other), cache=self.cache or other.cache,
+                  flags=self.regex.flags | other.regex.flags)
+
+    def match(self, string):
+        self.last_match = self.regex.match(string)
+        return self.last_match
+
+    def search(self, string):
+        self.last_match = self.regex.search(string)
+        return self.last_match
+
+    def findall(self, string):
+        return self.regex.findall(string)
+
+    def split(self, string):
+        return self.regex.split(string)
+
+    def sub(self, sub, string, count=0):
+        return self.regex.sub(sub, string, count=count)
+
+    def group(self, num):
+        return self.last_match.group(num)
+
+#
+# Regular expressions used to parse kernel-doc markups at KernelDoc class.
+#
+# Let's declare them in lowercase outside any class to make easier to
+# convert from the python script.
+#
+# As those are evaluated at the beginning, no need to cache them
+#
+
+
+# Allow whitespace at end of comment start.
+doc_start = Re(r'^/\*\*\s*$', cache=False)
+
+doc_end = Re(r'\*/', cache=False)
+doc_com = Re(r'\s*\*\s*', cache=False)
+doc_com_body = Re(r'\s*\* ?', cache=False)
+doc_decl = doc_com + Re(r'(\w+)', cache=False)
+
+# @params and a strictly limited set of supported section names
+# Specifically:
+#   Match @word:
+#         @...:
+#         @{section-name}:
+# while trying to not match literal block starts like "example::"
+#
+doc_sect = doc_com + \
+            Re(r'\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:([^:].*)?$',
+                flags=re.I, cache=False)
+
+doc_content = doc_com_body + Re(r'(.*)', cache=False)
+doc_block = doc_com + Re(r'DOC:\s*(.*)?', cache=False)
+doc_inline_start = Re(r'^\s*/\*\*\s*$', cache=False)
+doc_inline_sect = Re(r'\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)', cache=False)
+doc_inline_end = Re(r'^\s*\*/\s*$', cache=False)
+doc_inline_oneline = Re(r'^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$', cache=False)
+function_pointer = Re(r"([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)", cache=False)
+attribute = Re(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)",
+               flags=re.I | re.S, cache=False)
+
+# match expressions used to find embedded type information
+type_constant = Re(r"\b``([^\`]+)``\b", cache=False)
+type_constant2 = Re(r"\%([-_*\w]+)", cache=False)
+type_func = Re(r"(\w+)\(\)", cache=False)
+type_param = Re(r"\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
+type_param_ref = Re(r"([\!~\*]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
+
+# Special RST handling for func ptr params
+type_fp_param = Re(r"\@(\w+)\(\)", cache=False)
+
+# Special RST handling for structs with func ptr params
+type_fp_param2 = Re(r"\@(\w+->\S+)\(\)", cache=False)
+
+type_env = Re(r"(\$\w+)", cache=False)
+type_enum = Re(r"\&(enum\s*([_\w]+))", cache=False)
+type_struct = Re(r"\&(struct\s*([_\w]+))", cache=False)
+type_typedef = Re(r"\&(typedef\s*([_\w]+))", cache=False)
+type_union = Re(r"\&(union\s*([_\w]+))", cache=False)
+type_member = Re(r"\&([_\w]+)(\.|->)([_\w]+)", cache=False)
+type_fallback = Re(r"\&([_\w]+)", cache=False)
+type_member_func = type_member + Re(r"\(\)", cache=False)
+
+export_symbol = Re(r'^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*', cache=False)
+export_symbol_ns = Re(r'^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*"\S+"\)\s*', cache=False)
+
+class KernelDoc:
+    # Parser states
+    STATE_NORMAL        = 0        # normal code
+    STATE_NAME          = 1        # looking for function name
+    STATE_BODY_MAYBE    = 2        # body - or maybe more description
+    STATE_BODY          = 3        # the body of the comment
+    STATE_BODY_WITH_BLANK_LINE = 4 # the body which has a blank line
+    STATE_PROTO         = 5        # scanning prototype
+    STATE_DOCBLOCK      = 6        # documentation block
+    STATE_INLINE        = 7        # gathering doc outside main block
+
+    st_name = [
+        "NORMAL",
+        "NAME",
+        "BODY_MAYBE",
+        "BODY",
+        "BODY_WITH_BLANK_LINE",
+        "PROTO",
+        "DOCBLOCK",
+        "INLINE",
+    ]
+
+    # Inline documentation state
+    STATE_INLINE_NA     = 0 # not applicable ($state != STATE_INLINE)
+    STATE_INLINE_NAME   = 1 # looking for member name (@foo:)
+    STATE_INLINE_TEXT   = 2 # looking for member documentation
+    STATE_INLINE_END    = 3 # done
+    STATE_INLINE_ERROR  = 4 # error - Comment without header was found.
+                            # Spit a warning as it's not
+                            # proper kernel-doc and ignore the rest.
+
+    st_inline_name = [
+        "",
+        "_NAME",
+        "_TEXT",
+        "_END",
+        "_ERROR",
+    ]
+
+    # Section names
+
+    section_default = "Description"  # default section
+    section_intro = "Introduction"
+    section_context = "Context"
+    section_return = "Return"
+
+    undescribed = "-- undescribed --"
+
+    def __init__(self, config, fname):
+        """Initialize internal variables"""
+
+        self.fname = fname
+        self.config = config
+
+        # Initial state for the state machines
+        self.state = self.STATE_NORMAL
+        self.inline_doc_state = self.STATE_INLINE_NA
+
+        # Store entry currently being processed
+        self.entry = None
+
+        # Place all potential outputs into an array
+        self.entries = []
+
+    def show_warnings(self, dtype, declaration_name):
+        # TODO: implement it
+
+        return True
+
+    # TODO: rename to emit_message
+    def emit_warning(self, ln, msg, warning=True):
+        """Emit a message"""
+
+        if warning:
+            self.config.log.warning("%s:%d %s", self.fname, ln, msg)
+        else:
+            self.config.log.info("%s:%d %s", self.fname, ln, msg)
+
+    def dump_section(self, start_new=True):
+        """
+        Dumps section contents to arrays/hashes intended for that purpose.
+        """
+
+        name = self.entry.section
+        contents = self.entry.contents
+
+        if type_param.match(name):
+            name = type_param.group(1)
+
+            self.entry.parameterdescs[name] = contents
+            self.entry.parameterdesc_start_lines[name] = self.entry.new_start_line
+
+            self.entry.sectcheck += name + " "
+            self.entry.new_start_line = 0
+
+        elif name == "@...":
+            name = "..."
+            self.entry.parameterdescs[name] = contents
+            self.entry.sectcheck += name + " "
+            self.entry.parameterdesc_start_lines[name] = self.entry.new_start_line
+            self.entry.new_start_line = 0
+
+        else:
+            if name in self.entry.sections and self.entry.sections[name] != "":
+                # Only warn on user-specified duplicate section names
+                if name != self.section_default:
+                    self.emit_warning(self.entry.new_start_line,
+                                      f"duplicate section name '{name}'\n")
+                self.entry.sections[name] += contents
+            else:
+                self.entry.sections[name] = contents
+                self.entry.sectionlist.append(name)
+                self.entry.section_start_lines[name] = self.entry.new_start_line
+                self.entry.new_start_line = 0
+
+#        self.config.log.debug("Section: %s : %s", name, pformat(vars(self.entry)))
+
+        if start_new:
+            self.entry.section = self.section_default
+            self.entry.contents = ""
+
+    # TODO: rename it to store_declaration
+    def output_declaration(self, dtype, name, **args):
+        """
+        Stores the entry into an entry array.
+
+        The actual output and output filters will be handled elsewhere
+        """
+
+        # The implementation here is different than the original kernel-doc:
+        # instead of checking for output filters or actually output anything,
+        # it just stores the declaration content at self.entries, as the
+        # output will happen on a separate class.
+        #
+        # For now, we're keeping the same name of the function just to make
+        # easier to compare the source code of both scripts
+
+        if "declaration_start_line" not in args:
+            args["declaration_start_line"] = self.entry.declaration_start_line
+
+        args["type"] = dtype
+
+        self.entries.append((name, args))
+
+        self.config.log.debug("Output: %s:%s = %s", dtype, name, pformat(args))
+
+    def reset_state(self, ln):
+        """
+        Ancillary routine to create a new entry. It initializes all
+        variables used by the state machine.
+        """
+
+        self.entry = argparse.Namespace
+
+        self.entry.contents = ""
+        self.entry.function = ""
+        self.entry.sectcheck = ""
+        self.entry.struct_actual = ""
+        self.entry.prototype = ""
+
+        self.entry.parameterlist = []
+        self.entry.parameterdescs = {}
+        self.entry.parametertypes = {}
+        self.entry.parameterdesc_start_lines = {}
+
+        self.entry.section_start_lines = {}
+        self.entry.sectionlist = []
+        self.entry.sections = {}
+
+        self.entry.anon_struct_union = False
+
+        self.entry.leading_space = None
+
+        # State flags
+        self.state = self.STATE_NORMAL
+        self.inline_doc_state = self.STATE_INLINE_NA
+        self.entry.brcount = 0
+
+        self.entry.in_doc_sect = False
+        self.entry.declaration_start_line = ln
+
+    def push_parameter(self, ln, decl_type, param, dtype,
+                       org_arg, declaration_name):
+        if self.entry.anon_struct_union and dtype == "" and param == "}":
+            return  # Ignore the ending }; from anonymous struct/union
+
+        self.entry.anon_struct_union = False
+
+        param = Re(r'[\[\)].*').sub('', param, count=1)
+
+        if dtype == "" and param.endswith("..."):
+            if Re(r'\w\.\.\.$').search(param):
+                # For named variable parameters of the form `x...`,
+                # remove the dots
+                param = param[:-3]
+            else:
+                # Handles unnamed variable parameters
+                param = "..."
+
+            if param not in self.entry.parameterdescs or \
+                not self.entry.parameterdescs[param]:
+
+                self.entry.parameterdescs[param] = "variable arguments"
+
+        elif dtype == "" and (not param or param == "void"):
+            param = "void"
+            self.entry.parameterdescs[param] = "no arguments"
+
+        elif dtype == "" and param in ["struct", "union"]:
+            # Handle unnamed (anonymous) union or struct
+            dtype = param
+            param = "{unnamed_" + param + "}"
+            self.entry.parameterdescs[param] = "anonymous\n"
+            self.entry.anon_struct_union = True
+
+        # Handle cache group enforcing variables: they do not need
+        # to be described in header files
+        elif "__cacheline_group" in param:
+            # Ignore __cacheline_group_begin and __cacheline_group_end
+            return
+
+        # Warn if parameter has no description
+        # (but ignore ones starting with # as these are not parameters
+        # but inline preprocessor statements)
+        if param not in self.entry.parameterdescs and not param.startswith("#"):
+            self.entry.parameterdescs[param] = self.undescribed
+
+            if self.show_warnings(dtype, declaration_name) and "." not in param:
+                if decl_type == 'function':
+                    dname = f"{decl_type} parameter"
+                else:
+                    dname = f"{decl_type} member"
+
+                self.emit_warning(ln,
+                                  f"{dname} '{param}' not described in '{declaration_name}'")
+
+        # Strip spaces from param so that it is one continuous string on
+        # parameterlist. This fixes a problem where check_sections()
+        # cannot find a parameter like "addr[6 + 2]" because it actually
+        # appears as "addr[6", "+", "2]" on the parameter list.
+        # However, it's better to maintain the param string unchanged for
+        # output, so just weaken the string compare in check_sections()
+        # to ignore "[blah" in a parameter string.
+
+        self.entry.parameterlist.append(param)
+        org_arg = Re(r'\s\s+').sub(' ', org_arg, count=1)
+        self.entry.parametertypes[param] = org_arg
+
+    def save_struct_actual(self, actual):
+        """
+        Strip all spaces from the actual param so that it looks like
+        one string item.
+        """
+
+        actual = Re(r'\s*').sub("", actual, count=1)
+
+        self.entry.struct_actual += actual + " "
+
+    def create_parameter_list(self, ln, decl_type, args, splitter, declaration_name):
+
+        # temporarily replace all commas inside function pointer definition
+        arg_expr = Re(r'(\([^\),]+),')
+        while arg_expr.search(args):
+            args = arg_expr.sub(r"\1#", args)
+
+        for arg in args.split(splitter):
+            # Strip comments
+            arg = Re(r'\/\*.*\*\/').sub('', arg)
+
+            # Ignore argument attributes
+            arg = Re(r'\sPOS0?\s').sub(' ', arg)
+
+            # Strip leading/trailing spaces
+            arg = arg.strip()
+            arg = Re(r'\s+').sub(' ', arg, count=1)
+
+            if arg.startswith('#'):
+                # Treat preprocessor directive as a typeless variable just to fill
+                # corresponding data structures "correctly". Catch it later in
+                # output_* subs.
+
+                # Treat preprocessor directive as a typeless variable
+                self.push_parameter(ln, decl_type, arg, "",
+                                    "", declaration_name)
+
+            elif Re(r'\(.+\)\s*\(').search(arg):
+                # Pointer-to-function
+
+                arg = arg.replace('#', ',')
+
+                r = Re(r'[^\(]+\(\*?\s*([\w\[\]\.]*)\s*\)')
+                if r.match(arg):
+                    param = r.group(1)
+                else:
+                    self.emit_warning(ln, f"Invalid param: {arg}")
+                    param = arg
+
+                dtype = Re(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
+                self.save_struct_actual(param)
+                self.push_parameter(ln, decl_type, param, dtype,
+                                    arg, declaration_name)
+
+            elif Re(r'\(.+\)\s*\[').search(arg):
+                # Array-of-pointers
+
+                arg = arg.replace('#', ',')
+                r = Re(r'[^\(]+\(\s*\*\s*([\w\[\]\.]*?)\s*(\s*\[\s*[\w]+\s*\]\s*)*\)')
+                if r.match(arg):
+                    param = r.group(1)
+                else:
+                    self.emit_warning(ln, f"Invalid param: {arg}")
+                    param = arg
+
+                dtype = Re(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
+
+                self.save_struct_actual(param)
+                self.push_parameter(ln, decl_type, param, dtype,
+                                    arg, declaration_name)
+
+            elif arg:
+                arg = Re(r'\s*:\s*').sub(":", arg)
+                arg = Re(r'\s*\[').sub('[', arg)
+
+                args = Re(r'\s*,\s*').split(arg)
+                if args[0] and '*' in args[0]:
+                    args[0] = re.sub(r'(\*+)\s*', r' \1', args[0])
+
+                first_arg = []
+                r = Re(r'^(.*\s+)(.*?\[.*\].*)$')
+                if args[0] and r.match(args[0]):
+                    args.pop(0)
+                    first_arg.extend(r.group(1))
+                    first_arg.append(r.group(2))
+                else:
+                    first_arg = Re(r'\s+').split(args.pop(0))
+
+                args.insert(0, first_arg.pop())
+                dtype = ' '.join(first_arg)
+
+                for param in args:
+                    if Re(r'^(\*+)\s*(.*)').match(param):
+                        r = Re(r'^(\*+)\s*(.*)')
+                        if not r.match(param):
+                            self.emit_warning(ln, f"Invalid param: {param}")
+                            continue
+
+                        param = r.group(1)
+
+                        self.save_struct_actual(r.group(2))
+                        self.push_parameter(ln, decl_type, r.group(2),
+                                            f"{dtype} {r.group(1)}",
+                                            arg, declaration_name)
+
+                    elif Re(r'(.*?):(\w+)').search(param):
+                        r = Re(r'(.*?):(\w+)')
+                        if not r.match(param):
+                            self.emit_warning(ln, f"Invalid param: {param}")
+                            continue
+
+                        if dtype != "":  # Skip unnamed bit-fields
+                            self.save_struct_actual(r.group(1))
+                            self.push_parameter(ln, decl_type, r.group(1),
+                                                f"{dtype}:{r.group(2)}",
+                                                arg, declaration_name)
+                    else:
+                        self.save_struct_actual(param)
+                        self.push_parameter(ln, decl_type, param, dtype,
+                                            arg, declaration_name)
+
+    def check_sections(self, ln, decl_name, decl_type, sectcheck, prmscheck):
+        sects = sectcheck.split()
+        prms = prmscheck.split()
+        err = False
+
+        for sx in range(len(sects)):                  # pylint: disable=C0200
+            err = True
+            for px in range(len(prms)):               # pylint: disable=C0200
+                prm_clean = prms[px]
+                prm_clean = Re(r'\[.*\]').sub('', prm_clean)
+                prm_clean = attribute.sub('', prm_clean)
+
+                # ignore array size in a parameter string;
+                # however, the original param string may contain
+                # spaces, e.g.:  addr[6 + 2]
+                # and this appears in @prms as "addr[6" since the
+                # parameter list is split at spaces;
+                # hence just ignore "[..." for the sections check;
+                prm_clean = Re(r'\[.*').sub('', prm_clean)
+
+                if prm_clean == sects[sx]:
+                    err = False
+                    break
+
+            if err:
+                if decl_type == 'function':
+                    dname = f"{decl_type} parameter"
+                else:
+                    dname = f"{decl_type} member"
+
+                self.emit_warning(ln,
+                                  f"Excess {dname} '{sects[sx]}' description in '{decl_name}'")
+
+    def check_return_section(self, ln, declaration_name, return_type):
+
+        if not self.config.wreturn:
+            return
+
+        # Ignore an empty return type (It's a macro)
+        # Ignore functions with a "void" return type (but not "void *")
+        if not return_type or Re(r'void\s*\w*\s*$').search(return_type):
+            return
+
+        if not self.entry.sections.get("Return", None):
+            self.emit_warning(ln,
+                              f"No description found for return value of '{declaration_name}'")
+
+    def dump_struct(self, ln, proto):
+        """
+        Store an entry for an struct or union
+        """
+
+        type_pattern = r'(struct|union)'
+
+        qualifiers = [
+            "__attribute__",
+            "__packed",
+            "__aligned",
+            "____cacheline_aligned_in_smp",
+            "____cacheline_aligned",
+        ]
+
+        definition_body = r'\{(.*)\}\s*' + "(?:" + '|'.join(qualifiers) + ")?"
+        struct_members = Re(type_pattern + r'([^\{\};]+)(\{)([^\{\}]*)(\})([^\{\}\;]*)(\;)')
+
+        # Extract struct/union definition
+        members = None
+        declaration_name = None
+        decl_type = None
+
+        r = Re(type_pattern + r'\s+(\w+)\s*' + definition_body)
+        if r.search(proto):
+            decl_type = r.group(1)
+            declaration_name = r.group(2)
+            members = r.group(3)
+        else:
+            r = Re(r'typedef\s+' + type_pattern + r'\s*' + definition_body + r'\s*(\w+)\s*;')
+
+            if r.search(proto):
+                decl_type = r.group(1)
+                declaration_name = r.group(3)
+                members = r.group(2)
+
+        if not members:
+            self.emit_warning(ln, f"{proto} error: Cannot parse struct or union!")
+            self.config.errors += 1
+            return
+
+        if self.entry.identifier != declaration_name:
+            self.emit_warning(ln,
+                              f"expecting prototype for {decl_type} {self.entry.identifier}. Prototype was for {decl_type} {declaration_name} instead\n")
+            return
+
+        args_pattern =r'([^,)]+)'
+
+        sub_prefixes = [
+            (Re(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', re.S | re.I),  ''),
+            (Re(r'\/\*\s*private:.*', re.S| re.I),  ''),
+
+            # Strip comments
+            (Re(r'\/\*.*?\*\/', re.S),  ''),
+
+            # Strip attributes
+            (attribute, ' '),
+            (Re(r'\s*__aligned\s*\([^;]*\)', re.S),  ' '),
+            (Re(r'\s*__counted_by\s*\([^;]*\)', re.S),  ' '),
+            (Re(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S),  ' '),
+            (Re(r'\s*__packed\s*', re.S),  ' '),
+            (Re(r'\s*CRYPTO_MINALIGN_ATTR', re.S),  ' '),
+            (Re(r'\s*____cacheline_aligned_in_smp', re.S),  ' '),
+            (Re(r'\s*____cacheline_aligned', re.S),  ' '),
+
+            # Unwrap struct_group() based on this definition:
+            # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
+            # which has variants like: struct_group(NAME, MEMBERS...)
+
+            (Re(r'\bstruct_group\s*\(([^,]*,)', re.S),  r'STRUCT_GROUP('),
+            (Re(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S),  r'STRUCT_GROUP('),
+            (Re(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S),  r'struct \1 \2; STRUCT_GROUP('),
+            (Re(r'\b__struct_group\s*\(([^,]*,){3}', re.S),  r'STRUCT_GROUP('),
+
+            # This is incompatible with Python re, as it uses:
+            #  recursive patterns ((?1)) and atomic grouping ((?>...)):
+            #   '\bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;'
+            # Let's see if this works instead:
+            (Re(r'\bSTRUCT_GROUP\(([^\)]+)\)[^;]*;', re.S),  r'\1'),
+
+            # Replace macros
+            (Re(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),  r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
+            (Re(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S),  r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
+            (Re(r'DECLARE_BITMAP\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S),  r'unsigned long \1[BITS_TO_LONGS(\2)]'),
+            (Re(r'DECLARE_HASHTABLE\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S),  r'unsigned long \1[1 << ((\2) - 1)]'),
+            (Re(r'DECLARE_KFIFO\s*\(' + args_pattern + r',\s*' + args_pattern + r',\s*' + args_pattern + r'\)', re.S),  r'\2 *\1'),
+            (Re(r'DECLARE_KFIFO_PTR\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S),  r'\2 *\1'),
+            (Re(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S),  r'\1 \2[]'),
+            (Re(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + args_pattern + r'\)', re.S),  r'dma_addr_t \1'),
+            (Re(r'DEFINE_DMA_UNMAP_LEN\s*\(' + args_pattern + r'\)', re.S),  r'__u32 \1'),
+        ]
+
+        for search, sub in sub_prefixes:
+            members = search.sub(sub, members)
+
+        # Keeps the original declaration as-is
+        declaration = members
+
+        # Split nested struct/union elements
+        #
+        # This loop was simpler at the original kernel-doc perl version, as
+        #   while ($members =~ m/$struct_members/) { ... }
+        # reads 'members' string on each interaction.
+        #
+        # Python behavior is different: it parses 'members' only once,
+        # creating a list of tuples from the first interaction.
+        #
+        # On other words, this won't get nested structs.
+        #
+        # So, we need to have an extra loop on Python to override such
+        # re limitation.
+
+        while True:
+            tuples = struct_members.findall(members)
+            if not tuples:
+                break
+
+            for t in tuples:
+                newmember = ""
+                maintype = t[0]
+                s_ids = t[5]
+                content = t[3]
+
+                oldmember = "".join(t)
+
+                for s_id in s_ids.split(','):
+                    s_id = s_id.strip()
+
+                    newmember += f"{maintype} {s_id}; "
+                    s_id = Re(r'[:\[].*').sub('', s_id)
+                    s_id = Re(r'^\s*\**(\S+)\s*').sub(r'\1', s_id)
+
+                    for arg in content.split(';'):
+                        arg = arg.strip()
+
+                        if not arg:
+                            continue
+
+                        r = Re(r'^([^\(]+\(\*?\s*)([\w\.]*)(\s*\).*)')
+                        if r.match(arg):
+                            # Pointer-to-function
+                            dtype = r.group(1)
+                            name = r.group(2)
+                            extra = r.group(3)
+
+                            if not name:
+                                continue
+
+                            if not s_id:
+                                # Anonymous struct/union
+                                newmember += f"{dtype}{name}{extra}; "
+                            else:
+                                newmember += f"{dtype}{s_id}.{name}{extra}; "
+
+                        else:
+                            arg = arg.strip()
+                            # Handle bitmaps
+                            arg = Re(r':\s*\d+\s*').sub('', arg)
+
+                            # Handle arrays
+                            arg = Re(r'\[.*\]').sub('', arg)
+
+                            # Handle multiple IDs
+                            arg = Re(r'\s*,\s*').sub(',', arg)
+
+
+                            r = Re(r'(.*)\s+([\S+,]+)')
+
+                            if r.search(arg):
+                                dtype = r.group(1)
+                                names = r.group(2)
+                            else:
+                                newmember += f"{arg}; "
+                                continue
+
+                            for name in names.split(','):
+                                name = Re(r'^\s*\**(\S+)\s*').sub(r'\1', name).strip()
+
+                                if not name:
+                                    continue
+
+                                if not s_id:
+                                    # Anonymous struct/union
+                                    newmember += f"{dtype} {name}; "
+                                else:
+                                    newmember += f"{dtype} {s_id}.{name}; "
+
+                members = members.replace(oldmember, newmember)
+
+        # Ignore other nested elements, like enums
+        members = re.sub(r'(\{[^\{\}]*\})', '', members)
+
+        self.create_parameter_list(ln, decl_type, members, ';',
+                                   declaration_name)
+        self.check_sections(ln, declaration_name, decl_type,
+                            self.entry.sectcheck, self.entry.struct_actual)
+
+        # Adjust declaration for better display
+        declaration = Re(r'([\{;])').sub(r'\1\n', declaration)
+        declaration = Re(r'\}\s+;').sub('};', declaration)
+
+        # Better handle inlined enums
+        while True:
+            r = Re(r'(enum\s+\{[^\}]+),([^\n])')
+            if not r.search(declaration):
+                break
+
+            declaration = r.sub(r'\1,\n\2', declaration)
+
+        def_args = declaration.split('\n')
+        level = 1
+        declaration = ""
+        for clause in def_args:
+
+            clause = clause.strip()
+            clause = Re(r'\s+').sub(' ', clause, count=1)
+
+            if not clause:
+                continue
+
+            if '}' in clause and level > 1:
+                level -= 1
+
+            if not Re(r'^\s*#').match(clause):
+                declaration += "\t" * level
+
+            declaration += "\t" + clause + "\n"
+            if "{" in clause and "}" not in clause:
+                level += 1
+
+        self.output_declaration(decl_type, declaration_name,
+                    struct=declaration_name,
+                    module=self.entry.modulename,
+                    definition=declaration,
+                    parameterlist=self.entry.parameterlist,
+                    parameterdescs=self.entry.parameterdescs,
+                    parametertypes=self.entry.parametertypes,
+                    sectionlist=self.entry.sectionlist,
+                    sections=self.entry.sections,
+                    purpose=self.entry.declaration_purpose)
+
+    def dump_enum(self, ln, proto):
+
+        # Ignore members marked private
+        proto = Re(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', flags=re.S).sub('', proto)
+        proto = Re(r'\/\*\s*private:.*}', flags=re.S).sub('}', proto)
+
+        # Strip comments
+        proto = Re(r'\/\*.*?\*\/', flags=re.S).sub('', proto)
+
+        # Strip #define macros inside enums
+        proto = Re(r'#\s*((define|ifdef|if)\s+|endif)[^;]*;', flags=re.S).sub('', proto)
+
+        members = None
+        declaration_name = None
+
+        r = Re(r'typedef\s+enum\s*\{(.*)\}\s*(\w*)\s*;')
+        if r.search(proto):
+            declaration_name = r.group(2)
+            members = r.group(1).rstrip()
+        else:
+            r = Re(r'enum\s+(\w*)\s*\{(.*)\}')
+            if r.match(proto):
+                declaration_name = r.group(1)
+                members = r.group(2).rstrip()
+
+        if not members:
+            self.emit_warning(ln, f"{proto}: error: Cannot parse enum!")
+            self.config.errors += 1
+            return
+
+        if self.entry.identifier != declaration_name:
+            if self.entry.identifier == "":
+                self.emit_warning(ln,
+                                  f"{proto}: wrong kernel-doc identifier on prototype")
+            else:
+                self.emit_warning(ln,
+                                  f"expecting prototype for enum {self.entry.identifier}. Prototype was for enum {declaration_name} instead")
+            return
+
+        if not declaration_name:
+            declaration_name = "(anonymous)"
+
+        member_set = set()
+
+        members = Re(r'\([^;]*?[\)]').sub('', members)
+
+        for arg in members.split(','):
+            if not arg:
+                continue
+            arg = Re(r'^\s*(\w+).*').sub(r'\1', arg)
+            self.entry.parameterlist.append(arg)
+            if arg not in self.entry.parameterdescs:
+                self.entry.parameterdescs[arg] = self.undescribed
+                if self.show_warnings("enum", declaration_name):
+                    self.emit_warning(ln,
+                                      f"Enum value '{arg}' not described in enum '{declaration_name}'")
+            member_set.add(arg)
+
+        for k in self.entry.parameterdescs:
+            if k not in member_set:
+                if self.show_warnings("enum", declaration_name):
+                    self.emit_warning(ln,
+                                      f"Excess enum value '%{k}' description in '{declaration_name}'")
+
+        self.output_declaration('enum', declaration_name,
+                   enum=declaration_name,
+                   module=self.config.modulename,
+                   parameterlist=self.entry.parameterlist,
+                   parameterdescs=self.entry.parameterdescs,
+                   sectionlist=self.entry.sectionlist,
+                   sections=self.entry.sections,
+                   purpose=self.entry.declaration_purpose)
+
+    def dump_declaration(self, ln, prototype):
+        if self.entry.decl_type == "enum":
+            self.dump_enum(ln, prototype)
+            return
+
+        if self.entry.decl_type == "typedef":
+            self.dump_typedef(ln, prototype)
+            return
+
+        if self.entry.decl_type in ["union", "struct"]:
+            self.dump_struct(ln, prototype)
+            return
+
+        # TODO: handle other types
+        self.output_declaration(self.entry.decl_type, prototype,
+                   entry=self.entry)
+
+    def dump_function(self, ln, prototype):
+
+        func_macro = False
+        return_type = ''
+        decl_type = 'function'
+
+        # Prefixes that would be removed
+        sub_prefixes = [
+            (r"^static +", "", 0),
+            (r"^extern +", "", 0),
+            (r"^asmlinkage +", "", 0),
+            (r"^inline +", "", 0),
+            (r"^__inline__ +", "", 0),
+            (r"^__inline +", "", 0),
+            (r"^__always_inline +", "", 0),
+            (r"^noinline +", "", 0),
+            (r"^__FORTIFY_INLINE +", "", 0),
+            (r"__init +", "", 0),
+            (r"__init_or_module +", "", 0),
+            (r"__deprecated +", "", 0),
+            (r"__flatten +", "", 0),
+            (r"__meminit +", "", 0),
+            (r"__must_check +", "", 0),
+            (r"__weak +", "", 0),
+            (r"__sched +", "", 0),
+            (r"_noprof", "", 0),
+            (r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +", "", 0),
+            (r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +", "", 0),
+            (r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +", "", 0),
+            (r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)", r"\1, \2", 0),
+            (r"__attribute_const__ +", "", 0),
+
+            # It seems that Python support for re.X is broken:
+            # At least for me (Python 3.13), this didn't work
+#            (r"""
+#              __attribute__\s*\(\(
+#                (?:
+#                    [\w\s]+          # attribute name
+#                    (?:\([^)]*\))?   # attribute arguments
+#                    \s*,?            # optional comma at the end
+#                )+
+#              \)\)\s+
+#             """, "", re.X),
+
+            # So, remove whitespaces and comments from it
+            (r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+", "", 0),
+        ]
+
+        for search, sub, flags in sub_prefixes:
+            prototype = Re(search, flags).sub(sub, prototype)
+
+        # Macros are a special case, as they change the prototype format
+        new_proto = Re(r"^#\s*define\s+").sub("", prototype)
+        if new_proto != prototype:
+            is_define_proto = True
+            prototype = new_proto
+        else:
+            is_define_proto = False
+
+        # Yes, this truly is vile.  We are looking for:
+        # 1. Return type (may be nothing if we're looking at a macro)
+        # 2. Function name
+        # 3. Function parameters.
+        #
+        # All the while we have to watch out for function pointer parameters
+        # (which IIRC is what the two sections are for), C types (these
+        # regexps don't even start to express all the possibilities), and
+        # so on.
+        #
+        # If you mess with these regexps, it's a good idea to check that
+        # the following functions' documentation still comes out right:
+        # - parport_register_device (function pointer parameters)
+        # - atomic_set (macro)
+        # - pci_match_device, __copy_to_user (long return type)
+
+        name = r'[a-zA-Z0-9_~:]+'
+        prototype_end1 = r'[^\(]*'
+        prototype_end2 = r'[^\{]*'
+        prototype_end = fr'\(({prototype_end1}|{prototype_end2})\)'
+
+        # Besides compiling, Perl qr{[\w\s]+} works as a non-capturing group.
+        # So, this needs to be mapped in Python with (?:...)? or (?:...)+
+
+        type1 = r'(?:[\w\s]+)?'
+        type2 = r'(?:[\w\s]+\*+)+'
+
+        found = False
+
+        if is_define_proto:
+            r = Re(r'^()(' + name + r')\s+')
+
+            if r.search(prototype):
+                return_type = ''
+                declaration_name = r.group(2)
+                func_macro = True
+
+                found = True
+
+        if not found:
+            patterns = [
+                rf'^()({name})\s*{prototype_end}',
+                rf'^({type1})\s+({name})\s*{prototype_end}',
+                rf'^({type2})\s*({name})\s*{prototype_end}',
+            ]
+
+            for p in patterns:
+                r = Re(p)
+
+                if r.match(prototype):
+
+                    return_type = r.group(1)
+                    declaration_name = r.group(2)
+                    args = r.group(3)
+
+                    self.create_parameter_list(ln, decl_type, args, ',',
+                                               declaration_name)
+
+                    found = True
+                    break
+        if not found:
+            self.emit_warning(ln,
+                              f"cannot understand function prototype: '{prototype}'")
+            return
+
+        if self.entry.identifier != declaration_name:
+            self.emit_warning(ln,
+                              f"expecting prototype for {self.entry.identifier}(). Prototype was for {declaration_name}() instead")
+            return
+
+        prms = " ".join(self.entry.parameterlist)
+        self.check_sections(ln, declaration_name, "function",
+                            self.entry.sectcheck, prms)
+
+        self.check_return_section(ln, declaration_name, return_type)
+
+        if 'typedef' in return_type:
+            self.output_declaration(decl_type, declaration_name,
+                       function=declaration_name,
+                       typedef=True,
+                       module=self.config.modulename,
+                       functiontype=return_type,
+                       parameterlist=self.entry.parameterlist,
+                       parameterdescs=self.entry.parameterdescs,
+                       parametertypes=self.entry.parametertypes,
+                       sectionlist=self.entry.sectionlist,
+                       sections=self.entry.sections,
+                       purpose=self.entry.declaration_purpose,
+                       func_macro=func_macro)
+        else:
+            self.output_declaration(decl_type, declaration_name,
+                       function=declaration_name,
+                       typedef=False,
+                       module=self.config.modulename,
+                       functiontype=return_type,
+                       parameterlist=self.entry.parameterlist,
+                       parameterdescs=self.entry.parameterdescs,
+                       parametertypes=self.entry.parametertypes,
+                       sectionlist=self.entry.sectionlist,
+                       sections=self.entry.sections,
+                       purpose=self.entry.declaration_purpose,
+                       func_macro=func_macro)
+
+    def dump_typedef(self, ln, proto):
+        typedef_type = r'((?:\s+[\w\*]+\b){1,8})\s*'
+        typedef_ident = r'\*?\s*(\w\S+)\s*'
+        typedef_args = r'\s*\((.*)\);'
+
+        typedef1 = Re(r'typedef' + typedef_type + r'\(' + typedef_ident + r'\)' + typedef_args)
+        typedef2 = Re(r'typedef' + typedef_type + typedef_ident + typedef_args)
+
+        # Strip comments
+        proto = Re(r'/\*.*?\*/', flags=re.S).sub('', proto)
+
+        # Parse function typedef prototypes
+        for r in [typedef1, typedef2]:
+            if not r.match(proto):
+                continue
+
+            return_type = r.group(1).strip()
+            declaration_name = r.group(2)
+            args = r.group(3)
+
+            if self.entry.identifier != declaration_name:
+                self.emit_warning(ln,
+                                  f"expecting prototype for typedef {self.entry.identifier}. Prototype was for typedef {declaration_name} instead\n")
+                return
+
+            decl_type = 'function'
+            self.create_parameter_list(ln, decl_type, args, ',', declaration_name)
+
+            self.output_declaration(decl_type, declaration_name,
+                       function=declaration_name,
+                       typedef=True,
+                       module=self.entry.modulename,
+                       functiontype=return_type,
+                       parameterlist=self.entry.parameterlist,
+                       parameterdescs=self.entry.parameterdescs,
+                       parametertypes=self.entry.parametertypes,
+                       sectionlist=self.entry.sectionlist,
+                       sections=self.entry.sections,
+                       purpose=self.entry.declaration_purpose)
+            return
+
+        # Handle nested parentheses or brackets
+        r = Re(r'(\(*.\)\s*|\[*.\]\s*);$')
+        while r.search(proto):
+            proto = r.sub('', proto)
+
+        # Parse simple typedefs
+        r = Re(r'typedef.*\s+(\w+)\s*;')
+        if r.match(proto):
+            declaration_name = r.group(1)
+
+            if self.entry.identifier != declaration_name:
+                self.emit_warning(ln, f"expecting prototype for typedef {self.entry.identifier}. Prototype was for typedef {declaration_name} instead\n")
+                return
+
+            self.output_declaration('typedef', declaration_name,
+                       typedef=declaration_name,
+                       module=self.entry.modulename,
+                       sectionlist=self.entry.sectionlist,
+                       sections=self.entry.sections,
+                       purpose=self.entry.declaration_purpose)
+            return
+
+        self.emit_warning(ln, "error: Cannot parse typedef!")
+        self.config.errors += 1
+
+    @staticmethod
+    def process_export(function_table, line):
+        """
+        process EXPORT_SYMBOL* tags
+
+        This method is called both internally and externally, so, it
+        doesn't use self.
+        """
+
+        if export_symbol.search(line):
+            symbol = export_symbol.group(2)
+            function_table.add(symbol)
+
+        if export_symbol_ns.search(line):
+            symbol = export_symbol_ns.group(2)
+            function_table.add(symbol)
+
+    def process_normal(self, ln, line):
+        """
+        STATE_NORMAL: looking for the /** to begin everything.
+        """
+
+        if not doc_start.match(line):
+            return
+
+        # start a new entry
+        self.reset_state(ln + 1)
+        self.entry.in_doc_sect = False
+
+        # next line is always the function name
+        self.state = self.STATE_NAME
+
+    def process_name(self, ln, line):
+        """
+        STATE_NAME: Looking for the "name - description" line
+        """
+
+        if doc_block.search(line):
+            self.entry.new_start_line = ln
+
+            if not doc_block.group(1):
+                self.entry.section = self.section_intro
+            else:
+                self.entry.section = doc_block.group(1)
+
+            self.state = self.STATE_DOCBLOCK
+            return
+
+        if doc_decl.search(line):
+            self.entry.identifier = doc_decl.group(1)
+            self.entry.is_kernel_comment = False
+
+            decl_start = str(doc_com)       # comment block asterisk
+            fn_type = r"(?:\w+\s*\*\s*)?"  # type (for non-functions)
+            parenthesis = r"(?:\(\w*\))?"   # optional parenthesis on function
+            decl_end = r"(?:[-:].*)"         # end of the name part
+
+            # test for pointer declaration type, foo * bar() - desc
+            r = Re(fr"^{decl_start}([\w\s]+?){parenthesis}?\s*{decl_end}?$")
+            if r.search(line):
+                self.entry.identifier = r.group(1)
+
+            # Test for data declaration
+            r = Re(r"^\s*\*?\s*(struct|union|enum|typedef)\b\s*(\w*)")
+            if r.search(line):
+                self.entry.decl_type = r.group(1)
+                self.entry.identifier = r.group(2)
+                self.entry.is_kernel_comment = True
+            else:
+                # Look for foo() or static void foo() - description;
+                # or misspelt identifier
+
+                r1 = Re(fr"^{decl_start}{fn_type}(\w+)\s*{parenthesis}\s*{decl_end}?$")
+                r2 = Re(fr"^{decl_start}{fn_type}(\w+[^-:]*){parenthesis}\s*{decl_end}$")
+
+                for r in [r1, r2]:
+                    if r.search(line):
+                        self.entry.identifier = r.group(1)
+                        self.entry.decl_type = "function"
+
+                        r = Re(r"define\s+")
+                        self.entry.identifier = r.sub("", self.entry.identifier)
+                        self.entry.is_kernel_comment = True
+                        break
+
+            self.entry.identifier = self.entry.identifier.strip(" ")
+
+            self.state = self.STATE_BODY
+
+            # if there's no @param blocks need to set up default section here
+            self.entry.section = self.section_default
+            self.entry.new_start_line = ln + 1
+
+            r = Re("[-:](.*)")
+            if r.search(line):
+                # strip leading/trailing/multiple spaces
+                self.entry.descr = r.group(1).strip(" ")
+
+                r = Re(r"\s+")
+                self.entry.descr = r.sub(" ", self.entry.descr)
+                self.entry.declaration_purpose = self.entry.descr
+                self.state = self.STATE_BODY_MAYBE
+            else:
+                self.entry.declaration_purpose = ""
+
+            if not self.entry.is_kernel_comment:
+                self.emit_warning(ln,
+                                  f"This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst\n{line}")
+                self.state = self.STATE_NORMAL
+
+            if not self.entry.declaration_purpose and self.config.wshort_desc:
+                self.emit_warning(ln,
+                                  f"missing initial short description on line:\n{line}")
+
+            if not self.entry.identifier and self.entry.decl_type != "enum":
+                self.emit_warning(ln,
+                                  f"wrong kernel-doc identifier on line:\n{line}")
+                self.state = self.STATE_NORMAL
+
+            if self.config.verbose:
+                self.emit_warning(ln,
+                                  f"Scanning doc for {self.entry.decl_type} {self.entry.identifier}",
+                             warning=False)
+
+            return
+
+        # Failed to find an identifier. Emit a warning
+        self.emit_warning(ln, f"Cannot find identifier on line:\n{line}")
+
+    def process_body(self, ln, line):
+        """
+        STATE_BODY and STATE_BODY_MAYBE: the bulk of a kerneldoc comment.
+        """
+
+        if self.state == self.STATE_BODY_WITH_BLANK_LINE:
+            r = Re(r"\s*\*\s?\S")
+            if r.match(line):
+                self.dump_section()
+                self.entry.section = self.section_default
+                self.entry.new_start_line = line
+                self.entry.contents = ""
+
+        if doc_sect.search(line):
+            self.entry.in_doc_sect = True
+            newsection = doc_sect.group(1)
+
+            if newsection.lower() in ["description", "context"]:
+                newsection = newsection.title()
+
+            # Special case: @return is a section, not a param description
+            if newsection.lower() in ["@return", "@returns",
+                                    "return", "returns"]:
+                newsection = "Return"
+
+            # Perl kernel-doc has a check here for contents before sections.
+            # the logic there is always false, as in_doc_sect variable is
+            # always true. So, just don't implement Wcontents_before_sections
+
+            # .title()
+            newcontents = doc_sect.group(2)
+            if not newcontents:
+                newcontents = ""
+
+            if self.entry.contents.strip("\n"):
+                self.dump_section()
+
+            self.entry.new_start_line = ln
+            self.entry.section = newsection
+            self.entry.leading_space = None
+
+            self.entry.contents = newcontents.lstrip()
+            if self.entry.contents:
+                self.entry.contents += "\n"
+
+            self.state = self.STATE_BODY
+            return
+
+        if doc_end.search(line):
+            if self.entry.contents.strip("\n"):
+                self.dump_section()
+
+            # Look for doc_com + <text> + doc_end:
+            r = Re(r'\s*\*\s*[a-zA-Z_0-9:\.]+\*/')
+            if r.match(line):
+                self.emit_warning(ln, f"suspicious ending line: {line}")
+
+            self.entry.prototype = ""
+            self.entry.new_start_line = ln + 1
+
+            self.state = self.STATE_PROTO
+            return
+
+        if doc_content.search(line):
+            cont = doc_content.group(1)
+
+            if cont == "":
+                if self.entry.section == self.section_context:
+                    self.dump_section()
+
+                    self.entry.new_start_line = ln
+                    self.state = self.STATE_BODY
+                else:
+                    if self.entry.section != self.section_default:
+                        self.state = self.STATE_BODY_WITH_BLANK_LINE
+                    else:
+                        self.state = self.STATE_BODY
+
+                    self.entry.contents += "\n"
+
+            elif self.state == self.STATE_BODY_MAYBE:
+
+                # Continued declaration purpose
+                self.entry.declaration_purpose = self.entry.declaration_purpose.rstrip()
+                self.entry.declaration_purpose += " " + cont
+
+                r = Re(r"\s+")
+                self.entry.declaration_purpose = r.sub(' ',
+                                                       self.entry.declaration_purpose)
+
+            else:
+                if self.entry.section.startswith('@') or        \
+                   self.entry.section == self.section_context:
+                    if self.entry.leading_space is None:
+                        r = Re(r'^(\s+)')
+                        if r.match(cont):
+                            self.entry.leading_space = len(r.group(1))
+                        else:
+                            self.entry.leading_space = 0
+
+                    # Double-check if leading space are realy spaces
+                    pos = 0
+                    for i in range(0, self.entry.leading_space):
+                        if cont[i] != " ":
+                            break
+                        pos += 1
+
+                    cont = cont[pos:]
+
+                    # NEW LOGIC:
+                    # In case it is different, update it
+                    if self.entry.leading_space != pos:
+                        self.entry.leading_space = pos
+
+                self.entry.contents += cont + "\n"
+            return
+
+        # Unknown line, ignore
+        self.emit_warning(ln, f"bad line: {line}")
+
+    def process_inline(self, ln, line):
+        """STATE_INLINE: docbook comments within a prototype."""
+
+        if self.inline_doc_state == self.STATE_INLINE_NAME and \
+           doc_inline_sect.search(line):
+            self.entry.section = doc_inline_sect.group(1)
+            self.entry.new_start_line = ln
+
+            self.entry.contents = doc_inline_sect.group(2).lstrip()
+            if self.entry.contents != "":
+                self.entry.contents += "\n"
+
+            self.inline_doc_state = self.STATE_INLINE_TEXT
+            # Documentation block end */
+            return
+
+        if doc_inline_end.search(line):
+            if self.entry.contents not in ["", "\n"]:
+                self.dump_section()
+
+            self.state = self.STATE_PROTO
+            self.inline_doc_state = self.STATE_INLINE_NA
+            return
+
+        if doc_content.search(line):
+            if self.inline_doc_state == self.STATE_INLINE_TEXT:
+                self.entry.contents += doc_content.group(1) + "\n"
+                if not self.entry.contents.strip(" ").rstrip("\n"):
+                    self.entry.contents = ""
+
+            elif self.inline_doc_state == self.STATE_INLINE_NAME:
+                self.emit_warning(ln,
+                                  f"Incorrect use of kernel-doc format: {line}")
+
+                self.inline_doc_state = self.STATE_INLINE_ERROR
+
+    def syscall_munge(self, ln, proto):
+        """
+        Handle syscall definitions
+        """
+
+        is_void = False
+
+        # Strip newlines/CR's
+        proto = re.sub(r'[\r\n]+', ' ', proto)
+
+        # Check if it's a SYSCALL_DEFINE0
+        if 'SYSCALL_DEFINE0' in proto:
+            is_void = True
+
+        # Replace SYSCALL_DEFINE with correct return type & function name
+        proto = Re(r'SYSCALL_DEFINE.*\(').sub('long sys_', proto)
+
+        r = Re(r'long\s+(sys_.*?),')
+        if r.search(proto):
+            proto = proto.replace(',', '(', count=1)
+        elif is_void:
+            proto = proto.replace(')', '(void)', count=1)
+
+        # Now delete all of the odd-numbered commas in the proto
+        # so that argument types & names don't have a comma between them
+        count = 0
+        length = len(proto)
+
+        if is_void:
+            length = 0  # skip the loop if is_void
+
+        for ix in range(length):
+            if proto[ix] == ',':
+                count += 1
+                if count % 2 == 1:
+                    proto = proto[:ix] + ' ' + proto[ix+1:]
+
+        return proto
+
+    def tracepoint_munge(self, ln, proto):
+        """
+        Handle tracepoint definitions
+        """
+
+        tracepointname = None
+        tracepointargs = None
+
+        # Match tracepoint name based on different patterns
+        r = Re(r'TRACE_EVENT\((.*?),')
+        if r.search(proto):
+            tracepointname = r.group(1)
+
+        r = Re(r'DEFINE_SINGLE_EVENT\((.*?),')
+        if r.search(proto):
+            tracepointname = r.group(1)
+
+        r = Re(r'DEFINE_EVENT\((.*?),(.*?),')
+        if r.search(proto):
+            tracepointname = r.group(2)
+
+        if tracepointname:
+            tracepointname = tracepointname.lstrip()
+
+        r = Re(r'TP_PROTO\((.*?)\)')
+        if r.search(proto):
+            tracepointargs = r.group(1)
+
+        if not tracepointname or not tracepointargs:
+            self.emit_warning(ln,
+                              f"Unrecognized tracepoint format:\n{proto}\n")
+        else:
+            proto = f"static inline void trace_{tracepointname}({tracepointargs})"
+            self.entry.identifier = f"trace_{self.entry.identifier}"
+
+        return proto
+
+    def process_proto_function(self, ln, line):
+        """Ancillary routine to process a function prototype"""
+
+        # strip C99-style comments to end of line
+        r = Re(r"\/\/.*$", re.S)
+        line = r.sub('', line)
+
+        if Re(r'\s*#\s*define').match(line):
+            self.entry.prototype = line
+        elif line.startswith('#'):
+            # Strip other macros like #ifdef/#ifndef/#endif/...
+            pass
+        else:
+            r = Re(r'([^\{]*)')
+            if r.match(line):
+                self.entry.prototype += r.group(1) + " "
+
+        if '{' in line or ';' in line or Re(r'\s*#\s*define').match(line):
+            # strip comments
+            r = Re(r'/\*.*?\*/')
+            self.entry.prototype = r.sub('', self.entry.prototype)
+
+            # strip newlines/cr's
+            r = Re(r'[\r\n]+')
+            self.entry.prototype = r.sub(' ', self.entry.prototype)
+
+            # strip leading spaces
+            r = Re(r'^\s+')
+            self.entry.prototype = r.sub('', self.entry.prototype)
+
+            # Handle self.entry.prototypes for function pointers like:
+            #       int (*pcs_config)(struct foo)
+
+            r = Re(r'^(\S+\s+)\(\s*\*(\S+)\)')
+            self.entry.prototype = r.sub(r'\1\2', self.entry.prototype)
+
+            if 'SYSCALL_DEFINE' in self.entry.prototype:
+                self.entry.prototype = self.syscall_munge(ln,
+                                                          self.entry.prototype)
+
+            r = Re(r'TRACE_EVENT|DEFINE_EVENT|DEFINE_SINGLE_EVENT')
+            if r.search(self.entry.prototype):
+                self.entry.prototype = self.tracepoint_munge(ln,
+                                                             self.entry.prototype)
+
+            self.dump_function(ln, self.entry.prototype)
+            self.reset_state(ln)
+
+    def process_proto_type(self, ln, line):
+        """Ancillary routine to process a type"""
+
+        # Strip newlines/cr's.
+        line = Re(r'[\r\n]+', re.S).sub(' ', line)
+
+        # Strip leading spaces
+        line = Re(r'^\s+', re.S).sub('', line)
+
+        # Strip trailing spaces
+        line = Re(r'\s+$', re.S).sub('', line)
+
+        # Strip C99-style comments to the end of the line
+        line = Re(r"\/\/.*$", re.S).sub('', line)
+
+        # To distinguish preprocessor directive from regular declaration later.
+        if line.startswith('#'):
+            line += ";"
+
+        r = Re(r'([^\{\};]*)([\{\};])(.*)')
+        while True:
+            if r.search(line):
+                if self.entry.prototype:
+                    self.entry.prototype += " "
+                self.entry.prototype += r.group(1) + r.group(2)
+
+                self.entry.brcount += r.group(2).count('{')
+                self.entry.brcount -= r.group(2).count('}')
+
+                self.entry.brcount = max(self.entry.brcount, 0)
+
+                if r.group(2) == ';' and self.entry.brcount == 0:
+                    self.dump_declaration(ln, self.entry.prototype)
+                    self.reset_state(ln)
+                    break
+
+                line = r.group(3)
+            else:
+                self.entry.prototype += line
+                break
+
+    def process_proto(self, ln, line):
+        """STATE_PROTO: reading a function/whatever prototype."""
+
+        if doc_inline_oneline.search(line):
+            self.entry.section = doc_inline_oneline.group(1)
+            self.entry.contents = doc_inline_oneline.group(2)
+
+            if self.entry.contents != "":
+                self.entry.contents += "\n"
+                self.dump_section(start_new=False)
+
+        elif doc_inline_start.search(line):
+            self.state = self.STATE_INLINE
+            self.inline_doc_state = self.STATE_INLINE_NAME
+
+        elif self.entry.decl_type == 'function':
+            self.process_proto_function(ln, line)
+
+        else:
+            self.process_proto_type(ln, line)
+
+    def process_docblock(self, ln, line):
+        """STATE_DOCBLOCK: within a DOC: block."""
+
+        if doc_end.search(line):
+            self.dump_section()
+            self.output_declaration("doc", None,
+                       sectionlist=self.entry.sectionlist,
+                       sections=self.entry.sections,                    module=self.config.modulename)
+            self.reset_state(ln)
+
+        elif doc_content.search(line):
+            self.entry.contents += doc_content.group(1) + "\n"
+
+    def run(self):
+        """
+        Open and process each line of a C source file.
+        he parsing is controlled via a state machine, and the line is passed
+        to a different process function depending on the state. The process
+        function may update the state as needed.
+        """
+
+        cont = False
+        prev = ""
+        prev_ln = None
+
+        try:
+            with open(self.fname, "r", encoding="utf8",
+                      errors="backslashreplace") as fp:
+                for ln, line in enumerate(fp):
+
+                    line = line.expandtabs().strip("\n")
+
+                    # Group continuation lines on prototypes
+                    if self.state == self.STATE_PROTO:
+                        if line.endswith("\\"):
+                            prev += line.removesuffix("\\")
+                            cont = True
+
+                            if not prev_ln:
+                                prev_ln = ln
+
+                            continue
+
+                        if cont:
+                            ln = prev_ln
+                            line = prev + line
+                            prev = ""
+                            cont = False
+                            prev_ln = None
+
+                    self.config.log.debug("%d %s%s: %s",
+                                          ln, self.st_name[self.state],
+                                          self.st_inline_name[self.inline_doc_state],
+                                          line)
+
+                    # TODO: not all states allow EXPORT_SYMBOL*, so this
+                    # can be optimized later on to speedup parsing
+                    self.process_export(self.config.function_table, line)
+
+                    # Hand this line to the appropriate state handler
+                    if self.state == self.STATE_NORMAL:
+                        self.process_normal(ln, line)
+                    elif self.state == self.STATE_NAME:
+                        self.process_name(ln, line)
+                    elif self.state in [self.STATE_BODY, self.STATE_BODY_MAYBE,
+                                        self.STATE_BODY_WITH_BLANK_LINE]:
+                        self.process_body(ln, line)
+                    elif self.state == self.STATE_INLINE:  # scanning for inline parameters
+                        self.process_inline(ln, line)
+                    elif self.state == self.STATE_PROTO:
+                        self.process_proto(ln, line)
+                    elif self.state == self.STATE_DOCBLOCK:
+                        self.process_docblock(ln, line)
+        except OSError:
+            self.config.log.error(f"Error: Cannot open file {self.fname}")
+            self.config.errors += 1
+
+
+class GlobSourceFiles:
+    """
+    Parse C source code file names and directories via an Interactor.
+
+    """
+
+    def __init__(self, srctree=None, valid_extensions=None):
+        """
+        Initialize valid extensions with a tuple.
+
+        If not defined, assume default C extensions (.c and .h)
+
+        It would be possible to use python's glob function, but it is
+        very slow, and it is not interactive. So, it would wait to read all
+        directories before actually do something.
+
+        So, let's use our own implementation.
+        """
+
+        if not valid_extensions:
+            self.extensions = (".c", ".h")
+        else:
+            self.extensions = valid_extensions
+
+        self.srctree = srctree
+
+    def _parse_dir(self, dirname):
+        """Internal function to parse files recursively"""
+
+        with os.scandir(dirname) as obj:
+            for entry in obj:
+                name = os.path.join(dirname, entry.name)
+
+                if entry.is_dir():
+                    yield from self._parse_dir(name)
+
+                if not entry.is_file():
+                    continue
+
+                basename = os.path.basename(name)
+
+                if not basename.endswith(self.extensions):
+                    continue
+
+                yield name
+
+    def parse_files(self, file_list, file_not_found_cb):
+        for fname in file_list:
+            if self.srctree:
+                f = os.path.join(self.srctree, fname)
+            else:
+                f = fname
+
+            if os.path.isdir(f):
+                yield from self._parse_dir(f)
+            elif os.path.isfile(f):
+                yield f
+            elif file_not_found_cb:
+                file_not_found_cb(fname)
+
+
+class KernelFiles():
+
+    def parse_file(self, fname):
+
+        doc = KernelDoc(self.config, fname)
+        doc.run()
+
+        return doc
+
+    def process_export_file(self, fname):
+        try:
+            with open(fname, "r", encoding="utf8",
+                      errors="backslashreplace") as fp:
+                for line in fp:
+                    KernelDoc.process_export(self.config.function_table, line)
+
+        except IOError:
+            print(f"Error: Cannot open fname {fname}", fname=sys.stderr)
+            self.config.errors += 1
+
+    def file_not_found_cb(self, fname):
+        self.config.log.error("Cannot find file %s", fname)
+        self.config.errors += 1
+
+    def __init__(self, files=None, verbose=False, out_style=None,
+                 werror=False, wreturn=False, wshort_desc=False,
+                 wcontents_before_sections=False,
+                 logger=None, modulename=None, export_file=None):
+        """Initialize startup variables and parse all files"""
+
+
+        if not verbose:
+            verbose = bool(os.environ.get("KBUILD_VERBOSE", 0))
+
+        if not modulename:
+            modulename = "Kernel API"
+
+        dt = datetime.now()
+        if os.environ.get("KBUILD_BUILD_TIMESTAMP", None):
+            # use UTC TZ
+            to_zone = tz.gettz('UTC')
+            dt = dt.astimezone(to_zone)
+
+        if not werror:
+            kcflags = os.environ.get("KCFLAGS", None)
+            if kcflags:
+                match = re.search(r"(\s|^)-Werror(\s|$)/", kcflags)
+                if match:
+                    werror = True
+
+            # reading this variable is for backwards compat just in case
+            # someone was calling it with the variable from outside the
+            # kernel's build system
+            kdoc_werror = os.environ.get("KDOC_WERROR", None)
+            if kdoc_werror:
+                werror = kdoc_werror
+
+        # Set global config data used on all files
+        self.config = argparse.Namespace
+
+        self.config.verbose = verbose
+        self.config.werror = werror
+        self.config.wreturn = wreturn
+        self.config.wshort_desc = wshort_desc
+        self.config.wcontents_before_sections = wcontents_before_sections
+        self.config.modulename = modulename
+
+        self.config.function_table = set()
+        self.config.source_map = {}
+
+        if not logger:
+            self.config.log = logging.getLogger("kernel-doc")
+        else:
+            self.config.log = logger
+
+        self.config.kernel_version = os.environ.get("KERNELVERSION",
+                                                    "unknown kernel version'")
+        self.config.src_tree = os.environ.get("SRCTREE", None)
+
+        self.out_style = out_style
+        self.export_file = export_file
+
+        # Initialize internal variables
+
+        self.config.errors = 0
+        self.results = []
+
+        self.file_list = files
+        self.files = set()
+
+    def parse(self):
+        """
+        Parse all files
+        """
+
+        glob = GlobSourceFiles(srctree=self.config.src_tree)
+
+        # Let's use a set here to avoid duplicating files
+
+        for fname in glob.parse_files(self.file_list, self.file_not_found_cb):
+            if fname in self.files:
+                continue
+
+            self.files.add(fname)
+
+            res = self.parse_file(fname)
+            self.results.append((res.fname, res.entries))
+
+        if not self.files:
+            sys.exit(1)
+
+        # If a list of export files was provided, parse EXPORT_SYMBOL*
+        # from the ones not already parsed
+
+        if self.export_file:
+            files = self.files
+
+            glob = GlobSourceFiles(srctree=self.config.src_tree)
+
+            for fname in glob.parse_files(self.export_file,
+                                          self.file_not_found_cb):
+                if fname not in files:
+                    files.add(fname)
+
+                    self.process_export_file(fname)
+
+    def out_msg(self, fname, name, arg):
+        # TODO: filter out unwanted parts
+
+        return self.out_style.msg(fname, name, arg)
+
+    def msg(self, enable_lineno=False, export=False, internal=False,
+            symbol=None, nosymbol=None):
+
+        function_table = self.config.function_table
+
+        if symbol:
+            for s in symbol:
+                function_table.add(s)
+
+        # Output none mode: only warnings will be shown
+        if not self.out_style:
+            return
+
+        self.out_style.set_config(self.config)
+
+        self.out_style.set_filter(export, internal, symbol, nosymbol,
+                                  function_table, enable_lineno)
+
+        for fname, arg_tuple in self.results:
+            for name, arg in arg_tuple:
+                if self.out_msg(fname, name, arg):
+                    ln = arg.get("ln", 0)
+                    dtype = arg.get('type', "")
+
+                    self.config.log.warning("%s:%d Can't handle %s",
+                                            fname, ln, dtype)
+
+
+class OutputFormat:
+    # output mode.
+    OUTPUT_ALL          = 0 # output all symbols and doc sections
+    OUTPUT_INCLUDE      = 1 # output only specified symbols
+    OUTPUT_EXPORTED     = 2 # output exported symbols
+    OUTPUT_INTERNAL     = 3 # output non-exported symbols
+
+    # Virtual member to be overriden at the  inherited classes
+    highlights = []
+
+    def __init__(self):
+        """Declare internal vars and set mode to OUTPUT_ALL"""
+
+        self.out_mode = self.OUTPUT_ALL
+        self.enable_lineno = None
+        self.nosymbol = {}
+        self.symbol = None
+        self.function_table = set()
+        self.config = None
+
+    def set_config(self, config):
+        self.config = config
+
+    def set_filter(self, export, internal, symbol, nosymbol, function_table,
+                   enable_lineno):
+        """
+        Initialize filter variables according with the requested mode.
+
+        Only one choice is valid between export, internal and symbol.
+
+        The nosymbol filter can be used on all modes.
+        """
+
+        self.enable_lineno = enable_lineno
+
+        if symbol:
+            self.out_mode = self.OUTPUT_INCLUDE
+            function_table = symbol
+        elif export:
+            self.out_mode = self.OUTPUT_EXPORTED
+        elif internal:
+            self.out_mode = self.OUTPUT_INTERNAL
+        else:
+            self.out_mode = self.OUTPUT_ALL
+
+        if nosymbol:
+            self.nosymbol = set(nosymbol)
+
+        if function_table:
+            self.function_table = function_table
+
+    def highlight_block(self, block):
+        """
+        Apply the RST highlights to a sub-block of text.
+        """
+
+        for r, sub in self.highlights:
+            block = r.sub(sub, block)
+
+        return block
+
+    def check_doc(self, name):
+        """Check if DOC should be output"""
+
+        if self.out_mode == self.OUTPUT_ALL:
+            return True
+
+        if self.out_mode == self.OUTPUT_INCLUDE:
+            if name in self.nosymbol:
+                return False
+
+            if name in self.function_table:
+                return True
+
+        return False
+
+    def check_declaration(self, dtype, name):
+        if name in self.nosymbol:
+            return False
+
+        if self.out_mode == self.OUTPUT_ALL:
+            return True
+
+        if self.out_mode in [ self.OUTPUT_INCLUDE, self.OUTPUT_EXPORTED ]:
+            if name in self.function_table:
+                return True
+
+        if self.out_mode == self.OUTPUT_INTERNAL:
+            if dtype != "function":
+                return True
+
+            if name not in self.function_table:
+                return True
+
+        return False
+
+    def check_function(self, fname, name, args):
+        return True
+
+    def check_enum(self, fname, name, args):
+        return True
+
+    def check_typedef(self, fname, name, args):
+        return True
+
+    def msg(self, fname, name, args):
+
+        dtype = args.get('type', "")
+
+        if dtype == "doc":
+            self.out_doc(fname, name, args)
+            return False
+
+        if not self.check_declaration(dtype, name):
+            return False
+
+        if dtype == "function":
+            self.out_function(fname, name, args)
+            return False
+
+        if dtype == "enum":
+            self.out_enum(fname, name, args)
+            return False
+
+        if dtype == "typedef":
+            self.out_typedef(fname, name, args)
+            return False
+
+        if dtype in ["struct", "union"]:
+            self.out_struct(fname, name, args)
+            return False
+
+        # Warn if some type requires an output logic
+        self.config.log.warning("doesn't now how to output '%s' block",
+                                dtype)
+
+        return True
+
+    # Virtual methods to be overridden by inherited classes
+    def out_doc(self, fname, name, args):
+        pass
+
+    def out_function(self, fname, name, args):
+        pass
+
+    def out_enum(self, fname, name, args):
+        pass
+
+    def out_typedef(self, fname, name, args):
+        pass
+
+    def out_struct(self, fname, name, args):
+        pass
+
+
+class RestFormat(OutputFormat):
+    # """Consts and functions used by ReST output"""
+
+    highlights = [
+        (type_constant, r"``\1``"),
+        (type_constant2, r"``\1``"),
+
+        # Note: need to escape () to avoid func matching later
+        (type_member_func, r":c:type:`\1\2\3\\(\\) <\1>`"),
+        (type_member, r":c:type:`\1\2\3 <\1>`"),
+        (type_fp_param, r"**\1\\(\\)**"),
+        (type_fp_param2, r"**\1\\(\\)**"),
+        (type_func, r"\1()"),
+        (type_enum, r":c:type:`\1 <\2>`"),
+        (type_struct, r":c:type:`\1 <\2>`"),
+        (type_typedef, r":c:type:`\1 <\2>`"),
+        (type_union, r":c:type:`\1 <\2>`"),
+
+        # in rst this can refer to any type
+        (type_fallback, r":c:type:`\1`"),
+        (type_param_ref, r"**\1\2**")
+    ]
+    blankline = "\n"
+
+    sphinx_literal = Re(r'^[^.].*::$', cache=False)
+    sphinx_cblock = Re(r'^\.\.\ +code-block::', cache=False)
+
+    def __init__(self):
+        """
+        Creates class variables.
+
+        Not really mandatory, but it is a good coding style and makes
+        pylint happy.
+        """
+
+        super().__init__()
+        self.lineprefix = ""
+
+    def print_lineno (self, ln):
+        """Outputs a line number"""
+
+        if self.enable_lineno and ln:
+            print(f".. LINENO {ln}")
+
+    def output_highlight(self, args):
+        input_text = args
+        output = ""
+        in_literal = False
+        litprefix = ""
+        block = ""
+
+        for line in input_text.strip("\n").split("\n"):
+
+            # If we're in a literal block, see if we should drop out of it.
+            # Otherwise, pass the line straight through unmunged.
+            if in_literal:
+                if line.strip():  # If the line is not blank
+                    # If this is the first non-blank line in a literal block,
+                    # figure out the proper indent.
+                    if not litprefix:
+                        r = Re(r'^(\s*)')
+                        if r.match(line):
+                            litprefix = '^' + r.group(1)
+                        else:
+                            litprefix = ""
+
+                        output += line + "\n"
+                    elif not Re(litprefix).match(line):
+                        in_literal = False
+                    else:
+                        output += line + "\n"
+                else:
+                    output += line + "\n"
+
+            # Not in a literal block (or just dropped out)
+            if not in_literal:
+                block += line + "\n"
+                if self.sphinx_literal.match(line) or self.sphinx_cblock.match(line):
+                    in_literal = True
+                    litprefix = ""
+                    output += self.highlight_block(block)
+                    block = ""
+
+        # Handle any remaining block
+        if block:
+            output += self.highlight_block(block)
+
+        # Print the output with the line prefix
+        for line in output.strip("\n").split("\n"):
+            print(self.lineprefix + line)
+
+    def out_section(self, args, out_reference=False):
+        """
+        Outputs a block section.
+
+        This could use some work; it's used to output the DOC: sections, and
+        starts by putting out the name of the doc section itself, but that
+        tends to duplicate a header already in the template file.
+        """
+
+        sectionlist = args.get('sectionlist', [])
+        sections = args.get('sections', {})
+        section_start_lines = args.get('section_start_lines', {})
+
+        for section in sectionlist:
+            # Skip sections that are in the nosymbol_table
+            if section in self.nosymbol:
+                continue
+
+            if not self.out_mode == self.OUTPUT_INCLUDE:
+                if out_reference:
+                    print(f".. _{section}:\n")
+
+                if not self.symbol:
+                    print(f'{self.lineprefix}**{section}**\n')
+
+            self.print_lineno(section_start_lines.get(section, 0))
+            self.output_highlight(sections[section])
+            print()
+        print()
+
+    def out_doc(self, fname, name, args):
+        if not self.check_doc(name):
+            return
+
+        self.out_section(args, out_reference=True)
+
+    def out_function(self, fname, name, args):
+
+        oldprefix = self.lineprefix
+        signature = ""
+
+        func_macro = args.get('func_macro', False)
+        if func_macro:
+            signature = args['function']
+        else:
+            if args.get('functiontype'):
+                signature = args['functiontype'] + " "
+            signature += args['function'] + " ("
+
+        parameterlist = args.get('parameterlist', [])
+        parameterdescs = args.get('parameterdescs', {})
+        parameterdesc_start_lines = args.get('parameterdesc_start_lines', {})
+
+        ln = args.get('ln', 0)
+
+        count = 0
+        for parameter in parameterlist:
+            if count != 0:
+                signature += ", "
+            count += 1
+            dtype = args['parametertypes'].get(parameter, "")
+
+            if function_pointer.search(dtype):
+                signature += function_pointer.group(1) + parameter + function_pointer.group(3)
+            else:
+                signature += dtype
+
+        if not func_macro:
+            signature += ")"
+
+        if args.get('typedef') or not args.get('functiontype'):
+            print(f".. c:macro:: {args['function']}\n")
+
+            if args.get('typedef'):
+                self.print_lineno(ln)
+                print("   **Typedef**: ", end="")
+                self.lineprefix = ""
+                self.output_highlight(args.get('purpose', ""))
+                print("\n\n**Syntax**\n")
+                print(f"  ``{signature}``\n")
+            else:
+                print(f"``{signature}``\n")
+        else:
+            print(f".. c:function:: {signature}\n")
+
+        if not args.get('typedef'):
+            self.print_lineno(ln)
+            self.lineprefix = "   "
+            self.output_highlight(args.get('purpose', ""))
+            print()
+
+        # Put descriptive text into a container (HTML <div>) to help set
+        # function prototypes apart
+        self.lineprefix = "  "
+
+        if parameterlist:
+            print(".. container:: kernelindent\n")
+            print(f"{self.lineprefix}**Parameters**\n")
+
+        for parameter in parameterlist:
+            parameter_name = Re(r'\[.*').sub('', parameter)
+            dtype = args['parametertypes'].get(parameter, "")
+
+            if dtype:
+                print(f"{self.lineprefix}``{dtype}``")
+            else:
+                print(f"{self.lineprefix}``{parameter}``")
+
+            self.print_lineno(parameterdesc_start_lines.get(parameter_name, 0))
+
+            self.lineprefix = "    "
+            if parameter_name in parameterdescs and \
+               parameterdescs[parameter_name] != KernelDoc.undescribed:
+
+                self.output_highlight(parameterdescs[parameter_name])
+                print()
+            else:
+                print(f"{self.lineprefix}*undescribed*\n")
+            self.lineprefix = "  "
+
+        self.out_section(args)
+        self.lineprefix = oldprefix
+
+    def out_enum(self, fname, name, args):
+
+        oldprefix = self.lineprefix
+        name = args.get('enum', '')
+        parameterlist = args.get('parameterlist', [])
+        parameterdescs = args.get('parameterdescs', {})
+        ln = args.get('ln', 0)
+
+        print(f"\n\n.. c:enum:: {name}\n")
+
+        self.print_lineno(ln)
+        self.lineprefix = "  "
+        self.output_highlight(args.get('purpose', ''))
+        print()
+
+        print(".. container:: kernelindent\n")
+        outer = self.lineprefix + "  "
+        self.lineprefix = outer + "  "
+        print(f"{outer}**Constants**\n")
+
+        for parameter in parameterlist:
+            print(f"{outer}``{parameter}``")
+
+            if parameterdescs.get(parameter, '') != KernelDoc.undescribed:
+                self.output_highlight(parameterdescs[parameter])
+            else:
+                print(f"{self.lineprefix}*undescribed*\n")
+            print()
+
+        self.lineprefix = oldprefix
+        self.out_section(args)
+
+    def out_typedef(self, fname, name, args):
+
+        oldprefix = self.lineprefix
+        name = args.get('typedef', '')
+        ln = args.get('ln', 0)
+
+        print(f"\n\n.. c:type:: {name}\n")
+
+        self.print_lineno(ln)
+        self.lineprefix = "   "
+
+        self.output_highlight(args.get('purpose', ''))
+
+        print()
+
+        self.lineprefix = oldprefix
+        self.out_section(args)
+
+    def out_struct(self, fname, name, args):
+
+        name = args.get('struct', "")
+        purpose = args.get('purpose', "")
+        declaration = args.get('definition', "")
+        dtype = args.get('type', "struct")
+        ln = args.get('ln', 0)
+
+        parameterlist = args.get('parameterlist', [])
+        parameterdescs = args.get('parameterdescs', {})
+        parameterdesc_start_lines = args.get('parameterdesc_start_lines', {})
+
+        print(f"\n\n.. c:{dtype}:: {name}\n")
+
+        self.print_lineno(ln)
+
+        oldprefix = self.lineprefix
+        self.lineprefix += "  "
+
+        self.output_highlight(purpose)
+        print()
+
+        print(".. container:: kernelindent\n")
+        print(f"{self.lineprefix}**Definition**::\n")
+
+        self.lineprefix = self.lineprefix + "  "
+
+        declaration = declaration.replace("\t", self.lineprefix)
+
+        print(f"{self.lineprefix}{dtype} {name}" + ' {')
+        print(f"{declaration}{self.lineprefix}" + "};\n")
+
+        self.lineprefix = "  "
+        print(f"{self.lineprefix}**Members**\n")
+        for parameter in parameterlist:
+            if not parameter or parameter.startswith("#"):
+                continue
+
+            parameter_name = parameter.split("[", maxsplit=1)[0]
+
+            if parameterdescs.get(parameter_name) == KernelDoc.undescribed:
+                continue
+
+            self.print_lineno(parameterdesc_start_lines.get(parameter_name, 0))
+
+            print(f"{self.lineprefix}``{parameter}``")
+
+            self.lineprefix = "    "
+            self.output_highlight(parameterdescs[parameter_name])
+            self.lineprefix = "  "
+
+            print()
+
+        print()
+
+        self.lineprefix = oldprefix
+        self.out_section(args)
+
+
+class ManFormat(OutputFormat):
+    """Consts and functions used by man pages output"""
+
+    highlights = (
+        (type_constant, r"\1"),
+        (type_constant2, r"\1"),
+        (type_func, r"\\fB\1\\fP"),
+        (type_enum, r"\\fI\1\\fP"),
+        (type_struct, r"\\fI\1\\fP"),
+        (type_typedef, r"\\fI\1\\fP"),
+        (type_union, r"\\fI\1\\fP"),
+        (type_param, r"\\fI\1\\fP"),
+        (type_param_ref, r"\\fI\1\2\\fP"),
+        (type_member, r"\\fI\1\2\3\\fP"),
+        (type_fallback, r"\\fI\1\\fP")
+    )
+    blankline = ""
+
+    def __init__(self):
+        """
+        Creates class variables.
+
+        Not really mandatory, but it is a good coding style and makes
+        pylint happy.
+        """
+
+        super().__init__()
+
+        dt = datetime.now()
+        if os.environ.get("KBUILD_BUILD_TIMESTAMP", None):
+            # use UTC TZ
+            to_zone = tz.gettz('UTC')
+            dt = dt.astimezone(to_zone)
+
+        self.man_date = dt.strftime("%B %Y")
+
+    def output_highlight(self, block):
+
+        contents = self.highlight_block(block)
+
+        if isinstance(contents, list):
+            contents = "\n".join(contents)
+
+        for line in contents.strip("\n").split("\n"):
+            line = Re(r"^\s*").sub("", line)
+
+            if line and line[0] == ".":
+                print("\\&" + line)
+            else:
+                print(line)
+
+    def out_doc(self, fname, name, args):
+        module = args.get('module')
+        sectionlist = args.get('sectionlist', [])
+        sections = args.get('sections', {})
+
+        print(f'.TH "{module}" 9 "{module}" "{self.man_date}" "API Manual" LINUX')
+
+        for section in sectionlist:
+            print(f'.SH "{section}"')
+            self.output_highlight(sections.get(section))
+
+    def out_function(self, fname, name, args):
+        """output function in man"""
+
+        parameterlist = args.get('parameterlist', [])
+        parameterdescs = args.get('parameterdescs', {})
+        sectionlist = args.get('sectionlist', [])
+        sections = args.get('sections', {})
+
+        print(f'.TH "{args['function']}" 9 "{args['function']}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX')
+
+        print(".SH NAME")
+        print(f"{args['function']} \\- {args['purpose']}")
+
+        print(".SH SYNOPSIS")
+        if args.get('functiontype', ''):
+            print(f'.B "{args['functiontype']}" {args['function']}')
+        else:
+            print(f'.B "{args['function']}')
+
+        count = 0
+        parenth = "("
+        post = ","
+
+        for parameter in parameterlist:
+            if count == len(parameterlist) - 1:
+                post = ");"
+
+            dtype = args['parametertypes'].get(parameter, "")
+            if function_pointer.match(dtype):
+                # Pointer-to-function
+                print(f'".BI "{parenth}{function_pointer.group(1)}" " ") ({function_pointer.group(2)}){post}"')
+            else:
+                dtype = Re(r'([^\*])$').sub(r'\1 ', dtype)
+
+                print(f'.BI "{parenth}{dtype}"  "{post}"')
+            count += 1
+            parenth = ""
+
+        if parameterlist:
+            print(".SH ARGUMENTS")
+
+        for parameter in parameterlist:
+            parameter_name = re.sub(r'\[.*', '', parameter)
+
+            print(f'.IP "{parameter}" 12')
+            self.output_highlight(parameterdescs.get(parameter_name, ""))
+
+        for section in sectionlist:
+            print(f'.SH "{section.upper()}"')
+            self.output_highlight(sections[section])
+
+    def out_enum(self, fname, name, args):
+
+        name = args.get('enum', '')
+        parameterlist = args.get('parameterlist', [])
+        sectionlist = args.get('sectionlist', [])
+        sections = args.get('sections', {})
+
+        print(f'.TH "{args['module']}" 9 "enum {args['enum']}" "{self.man_date}" "API Manual" LINUX')
+
+        print(".SH NAME")
+        print(f"enum {args['enum']} \\- {args['purpose']}")
+
+        print(".SH SYNOPSIS")
+        print(f"enum {args['enum']}" + " {")
+
+        count = 0
+        for parameter in parameterlist:
+            print(f'.br\n.BI "    {parameter}"')
+            if count == len(parameterlist) - 1:
+                print("\n};")
+            else:
+                print(", \n.br")
+
+            count += 1
+
+        print(".SH Constants")
+
+        for parameter in parameterlist:
+            parameter_name = Re(r'\[.*').sub('', parameter)
+            print(f'.IP "{parameter}" 12')
+            self.output_highlight(args['parameterdescs'].get(parameter_name, ""))
+
+        for section in sectionlist:
+            print(f'.SH "{section}"')
+            self.output_highlight(sections[section])
+
+    def out_typedef(self, fname, name, args):
+        module = args.get('module')
+        typedef = args.get('typedef')
+        purpose = args.get('purpose')
+        sectionlist = args.get('sectionlist', [])
+        sections = args.get('sections', {})
+
+        print(f'.TH "{module}" 9 "{typedef}" "{self.man_date}" "API Manual" LINUX')
+
+        print(".SH NAME")
+        print(f"typedef {typedef} \\- {purpose}")
+
+        for section in sectionlist:
+            print(f'.SH "{section}"')
+            self.output_highlight(sections.get(section))
+
+    def out_struct(self, fname, name, args):
+        module = args.get('module')
+        struct_type = args.get('type')
+        struct_name = args.get('struct')
+        purpose = args.get('purpose')
+        definition = args.get('definition')
+        sectionlist = args.get('sectionlist', [])
+        parameterlist = args.get('parameterlist', [])
+        sections = args.get('sections', {})
+        parameterdescs = args.get('parameterdescs', {})
+
+        print(f'.TH "{module}" 9 "{struct_type} {struct_name}" "{self.man_date}" "API Manual" LINUX')
+
+        print(".SH NAME")
+        print(f"{struct_type} {struct_name} \\- {purpose}")
+
+        # Replace tabs with two spaces and handle newlines
+        declaration = definition.replace("\t", "  ")
+        declaration = Re(r"\n").sub('"\n.br\n.BI "', declaration)
+
+        print(".SH SYNOPSIS")
+        print(f"{struct_type} {struct_name} " + "{" +"\n.br")
+        print(f'.BI "{declaration}\n' + "};\n.br\n")
+
+        print(".SH Members")
+        for parameter in parameterlist:
+            if parameter.startswith("#"):
+                continue
+
+            parameter_name = re.sub(r"\[.*", "", parameter)
+
+            if parameterdescs.get(parameter_name) == KernelDoc.undescribed:
+                continue
+
+            print(f'.IP "{parameter}" 12')
+            self.output_highlight(parameterdescs.get(parameter_name))
+
+        for section in sectionlist:
+            print(f'.SH "{section}"')
+            self.output_highlight(sections.get(section))
+
+
+# Command line interface
+
+
+DESC = """
+Read C language source or header FILEs, extract embedded documentation comments,
+and print formatted documentation to standard output.
+
+The documentation comments are identified by the "/**" opening comment mark.
+
+See Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
+"""
+
+EXPORT_FILE_DESC = """
+Specify an additional FILE in which to look for EXPORT_SYMBOL information.
+
+May be used multiple times.
+"""
+
+EXPORT_DESC = """
+Only output documentation for the symbols that have been
+exported using EXPORT_SYMBOL() and related macros in any input
+FILE or -export-file FILE.
+"""
+
+INTERNAL_DESC = """
+Only output documentation for the symbols that have NOT been
+exported using EXPORT_SYMBOL() and related macros in any input
+FILE or -export-file FILE.
+"""
+
+FUNCTION_DESC = """
+Only output documentation for the given function or DOC: section
+title. All other functions and DOC: sections are ignored.
+
+May be used multiple times.
+"""
+
+NOSYMBOL_DESC = """
+Exclude the specified symbol from the output documentation.
+
+May be used multiple times.
+"""
+
+FILES_DESC = """
+Header and C source files to be parsed.
+"""
+
+WARN_CONTENTS_BEFORE_SECTIONS_DESC = """
+Warns if there are contents before sections (deprecated).
+
+This option is kept just for backward-compatibility, but it does nothing,
+neither here nor at the original Perl script.
+"""
+
+
+def main():
+    """Main program"""
+
+    parser = argparse.ArgumentParser(formatter_class=argparse.RawTextHelpFormatter,
+                                     description=DESC)
+
+    # Normal arguments
+
+    parser.add_argument("-v", "-verbose", "--verbose", action="store_true",
+                        help="Verbose output, more warnings and other information.")
+
+    parser.add_argument("-d", "-debug", "--debug", action="store_true",
+                        help="Enable debug messages")
+
+    parser.add_argument("-M", "-modulename", "--modulename",
+                        help="Allow setting a module name at the output.")
+
+    parser.add_argument("-l", "-enable-lineno", "--enable_lineno",
+                        action="store_true",
+                        help="Enable line number output (only in ReST mode)")
+
+    # Arguments to control the warning behavior
+
+    parser.add_argument("-Wreturn", "--wreturn", action="store_true",
+                        help="Warns about the lack of a return markup on functions.")
+
+    parser.add_argument("-Wshort-desc", "-Wshort-description", "--wshort-desc",
+                        action="store_true",
+                        help="Warns if initial short description is missing")
+
+    parser.add_argument("-Wcontents-before-sections",
+                        "--wcontents-before-sections", action="store_true",
+                        help=WARN_CONTENTS_BEFORE_SECTIONS_DESC)
+
+    parser.add_argument("-Wall", "--wall", action="store_true",
+                        help="Enable all types of warnings")
+
+    parser.add_argument("-Werror", "--werror", action="store_true",
+                        help="Treat warnings as errors.")
+
+    parser.add_argument("-export-file", "--export-file", action='append',
+                        help=EXPORT_FILE_DESC)
+
+    # Output format mutually-exclusive group
+
+    out_group = parser.add_argument_group("Output format selection (mutually exclusive)")
+
+    out_fmt = out_group.add_mutually_exclusive_group()
+
+    out_fmt.add_argument("-m", "-man", "--man", action="store_true",
+                         help="Output troff manual page format.")
+    out_fmt.add_argument("-r", "-rst", "--rst", action="store_true",
+                         help="Output reStructuredText format (default).")
+    out_fmt.add_argument("-N", "-none", "--none", action="store_true",
+                         help="Do not output documentation, only warnings.")
+
+    # Output selection mutually-exclusive group
+
+    sel_group = parser.add_argument_group("Output selection (mutually exclusive)")
+    sel_mut = sel_group.add_mutually_exclusive_group()
+
+    sel_mut.add_argument("-e", "-export", "--export", action='store_true',
+                         help=EXPORT_DESC)
+
+    sel_mut.add_argument("-i", "-internal", "--internal", action='store_true',
+                         help=INTERNAL_DESC)
+
+    sel_mut.add_argument("-s", "-function", "--symbol", action='append',
+                         help=FUNCTION_DESC)
+
+    # This one is valid for all 3 types of filter
+    parser.add_argument("-n", "-nosymbol", "--nosymbol", action='append',
+                         help=NOSYMBOL_DESC)
+
+    parser.add_argument("files", metavar="FILE",
+                        nargs="+", help=FILES_DESC)
+
+    args = parser.parse_args()
+
+    if args.wall:
+        args.wreturn = True
+        args.wshort_desc = True
+        args.wcontents_before_sections = True
+
+    if not args.debug:
+        level = logging.INFO
+    else:
+        level = logging.DEBUG
+
+    if args.man:
+        out_style = ManFormat()
+    elif args.none:
+        out_style = None
+    else:
+        out_style = RestFormat()
+
+    logging.basicConfig(level=level, format="%(levelname)s: %(message)s")
+
+    kfiles = KernelFiles(files=args.files, verbose=args.verbose,
+                         out_style=out_style, werror=args.werror,
+                         wreturn=args.wreturn, wshort_desc=args.wshort_desc,
+                         wcontents_before_sections=args.wcontents_before_sections,
+                         modulename=args.modulename,
+                         export_file=args.export_file)
+
+    kfiles.parse()
+
+    kfiles.msg(enable_lineno=args.enable_lineno, export=args.export,
+               internal=args.internal, symbol=args.symbol,
+               nosymbol=args.nosymbol)
+
+
+# Call main method
+if __name__ == "__main__":
+    main()
-- 
2.49.0


