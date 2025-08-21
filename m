Return-Path: <linux-kernel+bounces-780043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E49B2FCC5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED19B1C20871
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E582EDD58;
	Thu, 21 Aug 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln2v4AlA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A88285C9D;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786100; cv=none; b=hAkZc5/vVtyCw6TZH6bLTEe5bRszbE2MRJ9cnwTTBjJKVnHSIpvFTIPIUJsbV8sZARvE+ojgtTMMnU1fgN6U1G1k0AN1MqHAzXPW+EbK90rTYTe7mY3vWBK6DWUxoeIwIqZoRQW6LdhgQVrC9bDSoSKaDvGY/G7EoYqmZN9SVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786100; c=relaxed/simple;
	bh=QHi7tmIl6nunuTAnM3ij6+YulhA5kpLqxpviwyDbWAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRLqwhDZyPapofQQQ+cqwcq+50rL1M2MMOLSJp+ZbB5UfKZe8HozIijeoUIMX3K+xTP2I/33WTe1LMpaUWkwmY+/8u4aSomt/cFmt8TirRvkNZ6iGmEst0Y+yeFluXN7zK+ABF+nFRW/R4R+ogntSYD3x3CW1gI3blO+j5NuA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln2v4AlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2644BC2BC86;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=QHi7tmIl6nunuTAnM3ij6+YulhA5kpLqxpviwyDbWAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ln2v4AlA8O21gO/gkX0Ap2mbzGys9N9GousLxteJMiuK44zLRQmeIlvWvKDvky1dU
	 quCDx3bGJKNp4cF/yLdrDGvonoPnrRyK5mWQxT2etx+7ItprxaPzmPCyxsRJts1hve
	 vnbQN8oJG3xC+2JA0Nie4SoGo9Oymz1uCPsCGpiX09qugkMOxtGdQBR0Y7YgLtTnw3
	 IQ1F9GtJu+YX8Q4vGpCnBvEtBm1pFQU9RkBzV9zDrTs+EMM46/pK4oOuzJe+FYZWxl
	 3vOT0ELBVVN4R5o5mfL76UnOSef6xEJXEchfRqiJ7gZzjPcZJxvzym3qa+1KegQ0vS
	 k9pyiDo4K8USQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT8e-115S;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/24] docs: kernel_include.py: Update its coding style
Date: Thu, 21 Aug 2025 16:21:16 +0200
Message-ID: <6ff25e39e2f0548ef8906c7c4ecc5edbcd9f1b70.1755784930.git.mchehab+huawei@kernel.org>
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

With the help of tools like black, pylint, autopep8 and flake,
improve the code style in preparation for further changes.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 100 ++++++++++++-------------
 1 file changed, 47 insertions(+), 53 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index 1e566e87ebcd..1212786ac516 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -1,7 +1,6 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8; mode: python -*-
 # SPDX-License-Identifier: GPL-2.0
-# pylint: disable=R0903, C0330, R0914, R0912, E0401
+# pylint: disable=R0903, R0912, R0914, R0915, C0209,W0707
 
 """
     kernel-include
@@ -40,41 +39,38 @@ from docutils.parsers.rst import directives
 from docutils.parsers.rst.directives.body import CodeBlock, NumberLines
 from docutils.parsers.rst.directives.misc import Include
 
-__version__  = '1.0'
+__version__ = "1.0"
+
 
 # ==============================================================================
 def setup(app):
-# ==============================================================================
-
+    """Setup Sphinx exension"""
     app.add_directive("kernel-include", KernelInclude)
-    return dict(
-        version = __version__,
-        parallel_read_safe = True,
-        parallel_write_safe = True
-    )
+    return {
+        "version": __version__,
+        "parallel_read_safe": True,
+        "parallel_write_safe": True,
+    }
+
 
 # ==============================================================================
 class KernelInclude(Include):
-# ==============================================================================
-
     """KernelInclude (``kernel-include``) directive"""
 
     def run(self):
         env = self.state.document.settings.env
-        path = os.path.realpath(
-            os.path.expandvars(self.arguments[0]))
+        path = os.path.realpath(os.path.expandvars(self.arguments[0]))
 
         # to get a bit security back, prohibit /etc:
         if path.startswith(os.sep + "etc"):
-            raise self.severe(
-                'Problems with "%s" directive, prohibited path: %s'
-                % (self.name, path))
+            raise self.severe('Problems with "%s" directive, prohibited path: %s' %
+                              (self.name, path))
 
         self.arguments[0] = path
 
         env.note_dependency(os.path.abspath(path))
 
-        #return super(KernelInclude, self).run() # won't work, see HINTs in _run()
+        # return super(KernelInclude, self).run() # won't work, see HINTs in _run()
         return self._run()
 
     def _run(self):
@@ -87,41 +83,39 @@ class KernelInclude(Include):
 
         if not self.state.document.settings.file_insertion_enabled:
             raise self.warning('"%s" directive disabled.' % self.name)
-        source = self.state_machine.input_lines.source(
-            self.lineno - self.state_machine.input_offset - 1)
+        source = self.state_machine.input_lines.source(self.lineno -
+                                                       self.state_machine.input_offset - 1)
         source_dir = os.path.dirname(os.path.abspath(source))
         path = directives.path(self.arguments[0])
-        if path.startswith('<') and path.endswith('>'):
+        if path.startswith("<") and path.endswith(">"):
             path = os.path.join(self.standard_include_path, path[1:-1])
         path = os.path.normpath(os.path.join(source_dir, path))
 
         # HINT: this is the only line I had to change / commented out:
-        #path = utils.relative_path(None, path)
+        # path = utils.relative_path(None, path)
 
-        encoding = self.options.get(
-            'encoding', self.state.document.settings.input_encoding)
-        e_handler=self.state.document.settings.input_encoding_error_handler
-        tab_width = self.options.get(
-            'tab-width', self.state.document.settings.tab_width)
+        encoding = self.options.get("encoding",
+                                    self.state.document.settings.input_encoding)
+        e_handler = self.state.document.settings.input_encoding_error_handler
+        tab_width = self.options.get("tab-width",
+                                     self.state.document.settings.tab_width)
         try:
             self.state.document.settings.record_dependencies.add(path)
-            include_file = io.FileInput(source_path=path,
-                                        encoding=encoding,
+            include_file = io.FileInput(source_path=path, encoding=encoding,
                                         error_handler=e_handler)
-        except UnicodeEncodeError as error:
+        except UnicodeEncodeError:
             raise self.severe('Problems with "%s" directive path:\n'
                               'Cannot encode input file path "%s" '
-                              '(wrong locale?).' %
-                              (self.name, SafeString(path)))
+                              "(wrong locale?)." % (self.name, SafeString(path)))
         except IOError as error:
-            raise self.severe('Problems with "%s" directive path:\n%s.' %
-                      (self.name, ErrorString(error)))
-        startline = self.options.get('start-line', None)
-        endline = self.options.get('end-line', None)
+            raise self.severe('Problems with "%s" directive path:\n%s.'
+                              % (self.name, ErrorString(error)))
+        startline = self.options.get("start-line", None)
+        endline = self.options.get("end-line", None)
         try:
             if startline or (endline is not None):
                 lines = include_file.readlines()
-                rawtext = ''.join(lines[startline:endline])
+                rawtext = "".join(lines[startline:endline])
             else:
                 rawtext = include_file.read()
         except UnicodeError as error:
@@ -129,43 +123,43 @@ class KernelInclude(Include):
                               (self.name, ErrorString(error)))
         # start-after/end-before: no restrictions on newlines in match-text,
         # and no restrictions on matching inside lines vs. line boundaries
-        after_text = self.options.get('start-after', None)
+        after_text = self.options.get("start-after", None)
         if after_text:
             # skip content in rawtext before *and incl.* a matching text
             after_index = rawtext.find(after_text)
             if after_index < 0:
                 raise self.severe('Problem with "start-after" option of "%s" '
-                                  'directive:\nText not found.' % self.name)
-            rawtext = rawtext[after_index + len(after_text):]
-        before_text = self.options.get('end-before', None)
+                                  "directive:\nText not found." % self.name)
+            rawtext = rawtext[after_index + len(after_text) :]
+        before_text = self.options.get("end-before", None)
         if before_text:
             # skip content in rawtext after *and incl.* a matching text
             before_index = rawtext.find(before_text)
             if before_index < 0:
                 raise self.severe('Problem with "end-before" option of "%s" '
-                                  'directive:\nText not found.' % self.name)
+                                  "directive:\nText not found." % self.name)
             rawtext = rawtext[:before_index]
 
         include_lines = statemachine.string2lines(rawtext, tab_width,
                                                   convert_whitespace=True)
-        if 'literal' in self.options:
+        if "literal" in self.options:
             # Convert tabs to spaces, if `tab_width` is positive.
             if tab_width >= 0:
                 text = rawtext.expandtabs(tab_width)
             else:
                 text = rawtext
             literal_block = nodes.literal_block(rawtext, source=path,
-                                    classes=self.options.get('class', []))
+                                                classes=self.options.get("class", [])
+            )
             literal_block.line = 1
             self.add_name(literal_block)
-            if 'number-lines' in self.options:
+            if "number-lines" in self.options:
                 try:
-                    startline = int(self.options['number-lines'] or 1)
+                    startline = int(self.options["number-lines"] or 1)
                 except ValueError:
-                    raise self.error(':number-lines: with non-integer '
-                                     'start value')
+                    raise self.error(":number-lines: with non-integer start value")
                 endline = startline + len(include_lines)
-                if text.endswith('\n'):
+                if text.endswith("\n"):
                     text = text[:-1]
                 tokens = NumberLines([([], text)], startline, endline)
                 for classes, value in tokens:
@@ -177,12 +171,12 @@ class KernelInclude(Include):
             else:
                 literal_block += nodes.Text(text, text)
             return [literal_block]
-        if 'code' in self.options:
-            self.options['source'] = path
+        if "code" in self.options:
+            self.options["source"] = path
             codeblock = CodeBlock(self.name,
-                                  [self.options.pop('code')], # arguments
+                                  [self.options.pop("code")],  # arguments
                                   self.options,
-                                  include_lines, # content
+                                  include_lines,  # content
                                   self.lineno,
                                   self.content_offset,
                                   self.block_text,
-- 
2.50.1


