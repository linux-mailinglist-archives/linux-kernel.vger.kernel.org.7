Return-Path: <linux-kernel+bounces-780031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00055B2FC51
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B4C7B500A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B2D2D6624;
	Thu, 21 Aug 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVdoq3vS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC03A283FDE;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786099; cv=none; b=iA+jKjbPvnz7K9cGyJBfhSi19bsrGSgEYGkS9JIAfNUvhHkwJHiMJlrpXGoRQIFzyr1H87DJWCqGqIVSdVZuZA7NFjzDBYGhHb/lnCQ6hgc0vmk6MYvwH2Ifec8ePk5qIV+XtfqsEM5F3xdPeZyDbJGoL8Rwu4fRuNxycwkc08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786099; c=relaxed/simple;
	bh=Ryz5fK1HBEzZjQk/ZMX2f1BMYW5Jfa7MSrJhKnqCZ5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJIhD38jehjwoe0f2zNOYXNTaCkn04yvO+rmH6s5MYZRlIlouCP/xrUwYVFaqcyormQ1rpTrW/vzI567yH55uvGSufO9lruXRfdIK71jqm8OA/1VEvslsdnAbWpJL66dLu33zHKQ34G70h6kyamtdOmGOYWlgjunsrObujeLyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVdoq3vS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3822BC2BCB3;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=Ryz5fK1HBEzZjQk/ZMX2f1BMYW5Jfa7MSrJhKnqCZ5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kVdoq3vS2SugNOsq7BvkiRhD2lu+lhaIXr0UJ0b1qzyBBkhZmF5RUpJ8dHB1kKvYi
	 8/9QuyCURlQALDJuCWRYTapDSBNqDX/P3o13b4zKg7vuDMLI10o/bt/ayNDTaBZCoX
	 Vn9iD9Zino0PkhKbXaC1y0tfRp4xSQ5lPE59akzhyECskxQ1QA8R6IDhxRem22A1sp
	 vZkXrTn7xQfRwONFuHZ8J6siXyZ9PFumkfbcWcpFZjn8NgKiFLhvhMGXeIDuyzW1ZM
	 LQi8qUpg6vuY2XHpt+whPR2EoLn5uU918NFAicDZtiK5vQM2l4Yd2ExlM/h+zPqkhY
	 lIJfwxcCJV93A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT9A-1tBm;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/24] docs: kernel_include.py: append line numbers to better report errors
Date: Thu, 21 Aug 2025 16:21:24 +0200
Message-ID: <4e6309dbd113648a481c1bbe364bfe477cc3f598.1755784930.git.mchehab+huawei@kernel.org>
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

It is best to point to the original line of code that generated
an error than to point to the beginning of a directive.

Add support for it. It should be noticed that this won't work
for literal or code blocks, as Sphinx will ignore it, pointing
to the beginning of the directive. Yet, when the output is known
to be in ReST format, like on TOC, this makes the error a lot
more easier to be handled.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 81 ++++++++++++++------------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index 79682408105e..90ed8428f776 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -60,6 +60,7 @@ import re
 import sys
 
 from docutils import io, nodes, statemachine
+from docutils.statemachine import ViewList
 from docutils.utils.error_reporting import SafeString, ErrorString
 from docutils.parsers.rst import directives
 from docutils.parsers.rst.directives.body import CodeBlock, NumberLines
@@ -112,7 +113,14 @@ class KernelInclude(Include):
             except UnicodeError as error:
                 raise self.severe('Problem with directive:\n%s' % ErrorString(error))
 
-    def read_rawtext_with_xrefs(self, env, path, output_type):
+    def xref_text(self, env, path, tab_width):
+        """
+        Read and add contents from a C file parsed to have cross references.
+
+        There are two types of supported output here:
+        - A C source code with cross-references;
+        - a TOC table containing cross references.
+        """
         parser = ParseDataStructs()
         parser.parse_file(path)
 
@@ -127,10 +135,33 @@ class KernelInclude(Include):
         if 'warn-broken' in self.options:
             env._xref_files.add(path)
 
-        if output_type == "toc":
-            return parser.gen_toc()
+        if "toc" in self.options:
+            rawtext = parser.gen_toc()
+        else:
+            rawtext = ".. parsed-literal::\n\n" + parser.gen_output()
+            self.apply_range(rawtext)
 
-        return ".. parsed-literal::\n\n" + parser.gen_output()
+        title = os.path.basename(path)
+
+        include_lines = statemachine.string2lines(rawtext, tab_width,
+                                                  convert_whitespace=True)
+
+        # Append line numbers data
+
+        startline = self.options.get('start-line', None)
+
+        result = ViewList()
+        if startline and startline > 0:
+            offset = startline - 1
+        else:
+            offset = 0
+
+        for ln, line in enumerate(include_lines, start=offset):
+            result.append(line, path, ln)
+
+        self.state_machine.insert_input(result, path)
+
+        return []
 
     def apply_range(self, rawtext):
         # Get to-be-included content
@@ -195,9 +226,12 @@ class KernelInclude(Include):
             literal_block += nodes.Text(text, text)
         return [literal_block]
 
-    def code(self, path, include_lines):
+    def code(self, path, tab_width):
         """Output a code block"""
 
+        include_lines = statemachine.string2lines(rawtext, tab_width,
+                                                  convert_whitespace=True)
+
         self.options["source"] = path
         codeblock = CodeBlock(self.name,
                                 [self.options.pop("code")],  # arguments
@@ -244,47 +278,20 @@ class KernelInclude(Include):
 
         encoding = self.options.get("encoding",
                                     self.state.document.settings.input_encoding)
-        e_handler = self.state.document.settings.input_encoding_error_handler
         tab_width = self.options.get("tab-width",
                                      self.state.document.settings.tab_width)
 
-        if "literal" in self.options:
-            output_type = "literal"
-        elif "code" in self.options:
-            output_type = "code"
-        else:
-            output_type = "rst"
-
         # Get optional arguments to related to cross-references generation
         if "generate-cross-refs" in self.options:
-            if "toc" in self.options:
-                 output_type = "toc"
-
-            rawtext = self.read_rawtext_with_xrefs(env, path, output_type)
-
-            # When :generate-cross-refs: is used, the input is always a C
-            # file, so it has to be handled as a parsed-literal
-            if output_type == "rst":
-                output_type = "literal"
-
-            title = os.path.basename(path)
-        else:
-            rawtext = self.read_rawtext(path, encoding)
+            return self.xref_text(env, path, tab_width)
 
+        rawtext = self.read_rawtext(path, encoding)
         rawtext = self.apply_range(rawtext)
 
-        if output_type == "literal":
-            return self.literal(path, tab_width, rawtext)
+        if "code" in self.options:
+            return self.code(path, tab_width, rawtext)
 
-        include_lines = statemachine.string2lines(rawtext, tab_width,
-                                                  convert_whitespace=True)
-
-        if output_type == "code":
-            return self.code(path, include_lines)
-
-        self.state_machine.insert_input(include_lines, path)
-
-        return []
+        return self.literal(path, tab_width, rawtext)
 
 # ==============================================================================
 
-- 
2.50.1


