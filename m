Return-Path: <linux-kernel+bounces-780037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20542B2FCCE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5279A640145
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3492ED14E;
	Thu, 21 Aug 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdUJS5bj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46571F91C8;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786099; cv=none; b=ewwS6oS1NR/GqRCH1jOJsslQhoGyd/8t9YbmEK/0D0QnL4sSOc9B7WiSSxYCY2TO3Sp59se7PymB5xhiqhgEtcN9Btqdl38/bRbWl7nV5pPPu95J+BeE5ypRrBjGGpyAqvAkksis3GoMz+efapHos0cf4LWZEt/ddzKBX4AEyeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786099; c=relaxed/simple;
	bh=lRH9SEB4iDb1LfHInxrSMa8aPsx5ggsWJbqLQRJAoqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dnqodbs2GFq6A53YbrKT6yirHt5sruFikzY+gojlT0setTR/PkVmoDYChOXbMtpyuIghAsRtfuxFBwVccoksPiYyvQKUfqq3V3sUkByH7Nr+gzX34jKbdSnUlgsPYn2al3wApBVQTAK3Q+Mg3SxfOaVxeLWU9+heYDG+leNkRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdUJS5bj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF21C16AAE;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=lRH9SEB4iDb1LfHInxrSMa8aPsx5ggsWJbqLQRJAoqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdUJS5bjPd3m1j90lbHlIC5VKp8nJ32DTzMXAaTtF6EKyzXABJdliCu/gSadIPbKS
	 cOW7oLiG5nziwKncu79UYUY1Ov/r8qc/fMEcFSpOW11xPJJ/LgicTMf4I+LmYlXdh/
	 3KekxDWiDk8Iowx6fHA/zO9JHnetiZC2dwD241mDXM4NHPIl8a8UXqIAiCNjDSsgTi
	 KaD0+wO3ygjfOhClkzwMhvMKkW8Yqt2WDQqclJA4qIIib/vpa+sZUq7Ud6NP+FZZ7D
	 VXysuvN6OnQHw0Hb49Ny0wQNYe0u5ZcTIy+8lUXhsQHA6oaUbG9K4YX7zNW3NFfwY0
	 6FBUfnd77Q6bA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT8i-17v9;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/24] docs: kernel_include.py: allow cross-reference generation
Date: Thu, 21 Aug 2025 16:21:17 +0200
Message-ID: <1e30edc994a3edba976aafbf182eef2ed5439ede.1755784930.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755784929.git.mchehab+huawei@kernel.org>
References: <cover.1755784929.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

kernel_include extension was originally designed to be used by the
media comprehensive uAPI documentation, where, instead of simpler
kernel-doc markups, the uAPI documentation is enriched with a larger
text, with images, complex tables, graphs, etc.

There, we wanted to include the much simpler yet documented .h
file.

This extension is needed to include files from other parts of the
Kernel tree outside Documentation, because the original Sphinx
include tag doesn't allow going outside of the directory passed
via sphinx-build command line.

Yet, the cross-references themselves to the full documentation
were using a perl script to create cross-references against the
comprehensive documentation.

As the perl script is now converted to Phython and there is a
Python class producing an include-compatible output with cross
references, add two optional arguments to kernel_include.py:

1. :generate-cross-refs:

        If present, instead of reading the file, it calls ParseDataStructs()
        class, which converts C data structures into cross-references to
        be linked to ReST files containing a more comprehensive documentation;

        Don't use it together with :start-line: and/or :end-line:, as
        filtering input file line range is currently not supported.

2. :exception-file:

        Used together with :generate-cross-refs:. Points to a file containing
        rules to ignore C data structs or to use a different reference name,
        optionally using a different reference type.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 94 ++++++++++++++++++++------
 1 file changed, 74 insertions(+), 20 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index 1212786ac516..fc37e6fa9d96 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -25,6 +25,24 @@
     Substrings of the form $name or ${name} are replaced by the value of
     environment variable name. Malformed variable names and references to
     non-existing variables are left unchanged.
+
+    This extension overrides Sphinx include directory, adding two extra
+    arguments:
+
+    1. :generate-cross-refs:
+
+        If present, instead of reading the file, it calls ParseDataStructs()
+        class, which converts C data structures into cross-references to
+        be linked to ReST files containing a more comprehensive documentation;
+
+        Don't use it together with :start-line: and/or :end-line:, as
+        filtering input file line range is currently not supported.
+
+    2. :exception-file:
+
+        Used together with :generate-cross-refs:. Points to a file containing
+        rules to ignore C data structs or to use a different reference name,
+        optionally using a different reference type.
 """
 
 # ==============================================================================
@@ -32,6 +50,7 @@
 # ==============================================================================
 
 import os.path
+import sys
 
 from docutils import io, nodes, statemachine
 from docutils.utils.error_reporting import SafeString, ErrorString
@@ -39,6 +58,11 @@ from docutils.parsers.rst import directives
 from docutils.parsers.rst.directives.body import CodeBlock, NumberLines
 from docutils.parsers.rst.directives.misc import Include
 
+srctree = os.path.abspath(os.environ["srctree"])
+sys.path.insert(0, os.path.join(srctree, "tools/docs/lib"))
+
+from parse_data_structs import ParseDataStructs
+
 __version__ = "1.0"
 
 
@@ -57,6 +81,14 @@ def setup(app):
 class KernelInclude(Include):
     """KernelInclude (``kernel-include``) directive"""
 
+    # Add extra options
+    option_spec = Include.option_spec.copy()
+
+    option_spec.update({
+        'generate-cross-refs': directives.flag,
+        'exception-file': directives.unchanged,
+    })
+
     def run(self):
         env = self.state.document.settings.env
         path = os.path.realpath(os.path.expandvars(self.arguments[0]))
@@ -99,28 +131,49 @@ class KernelInclude(Include):
         e_handler = self.state.document.settings.input_encoding_error_handler
         tab_width = self.options.get("tab-width",
                                      self.state.document.settings.tab_width)
-        try:
-            self.state.document.settings.record_dependencies.add(path)
-            include_file = io.FileInput(source_path=path, encoding=encoding,
-                                        error_handler=e_handler)
-        except UnicodeEncodeError:
-            raise self.severe('Problems with "%s" directive path:\n'
-                              'Cannot encode input file path "%s" '
-                              "(wrong locale?)." % (self.name, SafeString(path)))
-        except IOError as error:
-            raise self.severe('Problems with "%s" directive path:\n%s.'
-                              % (self.name, ErrorString(error)))
         startline = self.options.get("start-line", None)
         endline = self.options.get("end-line", None)
-        try:
-            if startline or (endline is not None):
-                lines = include_file.readlines()
-                rawtext = "".join(lines[startline:endline])
-            else:
-                rawtext = include_file.read()
-        except UnicodeError as error:
-            raise self.severe('Problem with "%s" directive:\n%s' %
-                              (self.name, ErrorString(error)))
+
+        # Get optional arguments to related to cross-references generation
+        if 'generate-cross-refs' in self.options:
+            parser = ParseDataStructs()
+            parser.parse_file(path)
+
+            exceptions_file = self.options.get('exception-file')
+            if exceptions_file:
+                exceptions_file = os.path.join(source_dir, exceptions_file)
+                parser.process_exceptions(exceptions_file)
+
+            title = os.path.basename(path)
+            rawtext = parser.gen_output()
+            if startline or endline:
+                raise self.severe('generate-cross-refs can\'t be used together with "start-line" or "end-line"')
+
+            if "code" not in self.options:
+                rawtext = ".. parsed-literal::\n\n" + rawtext
+        else:
+            try:
+                self.state.document.settings.record_dependencies.add(path)
+                include_file = io.FileInput(source_path=path, encoding=encoding,
+                                            error_handler=e_handler)
+            except UnicodeEncodeError:
+                raise self.severe('Problems with "%s" directive path:\n'
+                                'Cannot encode input file path "%s" '
+                                "(wrong locale?)." % (self.name, SafeString(path)))
+            except IOError as error:
+                raise self.severe('Problems with "%s" directive path:\n%s.'
+                                % (self.name, ErrorString(error)))
+
+            try:
+                if startline or (endline is not None):
+                    lines = include_file.readlines()
+                    rawtext = "".join(lines[startline:endline])
+                else:
+                    rawtext = include_file.read()
+            except UnicodeError as error:
+                raise self.severe('Problem with "%s" directive:\n%s' %
+                                (self.name, ErrorString(error)))
+
         # start-after/end-before: no restrictions on newlines in match-text,
         # and no restrictions on matching inside lines vs. line boundaries
         after_text = self.options.get("start-after", None)
@@ -171,6 +224,7 @@ class KernelInclude(Include):
             else:
                 literal_block += nodes.Text(text, text)
             return [literal_block]
+
         if "code" in self.options:
             self.options["source"] = path
             codeblock = CodeBlock(self.name,
-- 
2.50.1


