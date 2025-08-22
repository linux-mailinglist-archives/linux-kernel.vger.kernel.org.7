Return-Path: <linux-kernel+bounces-782134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87920B31B93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4181D622FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EBF334372;
	Fri, 22 Aug 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1sGOReh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B83126A9;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=Dl3jvL4OCbMIGR7+ZpHzO5R6ZRto7u2HQ4LokFbToTzS94o6AoabG1lgn90gvuDibLccK/kT2Wn5JzzsUFxTphMbPJPlVOSZk7LU33SXFsGys/Mq29wdT5N66rgGoe+czMSicGYw+oSY5M3pohIhpicZXXiyw2Ce4jsA2peRR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=XLpGjVmiz7KWSgkDl0zwCX9wJOnCvElrKCUuUORJrj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSdzuA+0ow5XOBeB+KUGPCEqkX3aH0OQP/FE+HCxcK9li3h5xUA6jhS/VAj1g2E+dauAKIyUiGE3HBatoZxr4+T9dAc/MpUACvsxQwYiMMOv+KiWxFWz4rgHRP//ANePbgyUfhhchVdkwpHCX0WrnYc2aMI1xdYnfJpKecW+wO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1sGOReh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44211C2BCB8;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=XLpGjVmiz7KWSgkDl0zwCX9wJOnCvElrKCUuUORJrj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F1sGORehtpcfx0NvTk0TWxy4b1/C9716/JIBnVQYA2XcZl6dwmLl/aAPKjbRF4Onl
	 GOz6J9sz/mTkMTSYlkhyE4iASqOcerz/nKWw6v8J/0Pb0ZsLzmz5r8DFe16Rwd/+2B
	 youByWaCw7uodBK2E3wY5ksN7z3hScnKBVZFeBueFA2XEapIewoMcRk5WINRUq+QJ+
	 nDyz5i96sNLUcLQk73kp+JTe/SKmjqYv3u/hqq/qmfpzDXZh93wYYFeh4ZRt4oJy1x
	 OqOTkRxoO19j5nlVc86hekohRSO0GWW5BXj1W/wMAUJTGHuiVUYzqz5feWZLgj7C6d
	 zvParDAEiN+LQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCru-2DaE;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/24] docs: kernel_include.py: move code and literal functions
Date: Fri, 22 Aug 2025 16:19:28 +0200
Message-ID: <78d08dfa3f08adabc30bf93b8a1cde4e19b7bd41.1755872208.git.mchehab+huawei@kernel.org>
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

Simplify run() even more by moving the code which handles
with code and literal blocks to their own functions.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 100 +++++++++++++++----------
 1 file changed, 59 insertions(+), 41 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index 4cdd1c77982e..0909eb3a07ea 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -160,6 +160,52 @@ class KernelInclude(Include):
 
         return rawtext
 
+    def literal(self, path, tab_width, rawtext):
+        """Output a literal block"""
+
+        # Convert tabs to spaces, if `tab_width` is positive.
+        if tab_width >= 0:
+            text = rawtext.expandtabs(tab_width)
+        else:
+            text = rawtext
+        literal_block = nodes.literal_block(rawtext, source=path,
+                                            classes=self.options.get("class", []))
+        literal_block.line = 1
+        self.add_name(literal_block)
+        if "number-lines" in self.options:
+            try:
+                startline = int(self.options["number-lines"] or 1)
+            except ValueError:
+                raise self.error(":number-lines: with non-integer start value")
+            endline = startline + len(include_lines)
+            if text.endswith("\n"):
+                text = text[:-1]
+            tokens = NumberLines([([], text)], startline, endline)
+            for classes, value in tokens:
+                if classes:
+                    literal_block += nodes.inline(value, value,
+                                                    classes=classes)
+                else:
+                    literal_block += nodes.Text(value, value)
+        else:
+            literal_block += nodes.Text(text, text)
+        return [literal_block]
+
+    def code(self, path, include_lines):
+        """Output a code block"""
+
+        self.options["source"] = path
+        codeblock = CodeBlock(self.name,
+                                [self.options.pop("code")],  # arguments
+                                self.options,
+                                include_lines,
+                                self.lineno,
+                                self.content_offset,
+                                self.block_text,
+                                self.state,
+                                self.state_machine)
+        return codeblock.run()
+
     def run(self):
         """Include a file as part of the content of this reST file."""
         env = self.state.document.settings.env
@@ -200,6 +246,13 @@ class KernelInclude(Include):
         startline = self.options.get("start-line", None)
         endline = self.options.get("end-line", None)
 
+        if "literal" in self.options:
+            ouptut_type = "literal"
+        elif "code" in self.options:
+            ouptut_type = "code"
+        else:
+            ouptut_type = "normal"
+
         # Get optional arguments to related to cross-references generation
         if 'generate-cross-refs' in self.options:
             rawtext = self.read_rawtext_with_xrefs(env, path)
@@ -213,50 +266,15 @@ class KernelInclude(Include):
 
         rawtext = self.apply_range(rawtext)
 
+        if ouptut_type == "literal":
+            return self.literal(path, tab_width, rawtext)
+
         include_lines = statemachine.string2lines(rawtext, tab_width,
                                                   convert_whitespace=True)
-        if "literal" in self.options:
-            # Convert tabs to spaces, if `tab_width` is positive.
-            if tab_width >= 0:
-                text = rawtext.expandtabs(tab_width)
-            else:
-                text = rawtext
-            literal_block = nodes.literal_block(rawtext, source=path,
-                                                classes=self.options.get("class", [])
-            )
-            literal_block.line = 1
-            self.add_name(literal_block)
-            if "number-lines" in self.options:
-                try:
-                    startline = int(self.options["number-lines"] or 1)
-                except ValueError:
-                    raise self.error(":number-lines: with non-integer start value")
-                endline = startline + len(include_lines)
-                if text.endswith("\n"):
-                    text = text[:-1]
-                tokens = NumberLines([([], text)], startline, endline)
-                for classes, value in tokens:
-                    if classes:
-                        literal_block += nodes.inline(value, value,
-                                                      classes=classes)
-                    else:
-                        literal_block += nodes.Text(value, value)
-            else:
-                literal_block += nodes.Text(text, text)
-            return [literal_block]
 
-        if "code" in self.options:
-            self.options["source"] = path
-            codeblock = CodeBlock(self.name,
-                                  [self.options.pop("code")],  # arguments
-                                  self.options,
-                                  include_lines,  # content
-                                  self.lineno,
-                                  self.content_offset,
-                                  self.block_text,
-                                  self.state,
-                                  self.state_machine)
-            return codeblock.run()
+        if ouptut_type == "code":
+            return self.code(path, include_lines)
+
         self.state_machine.insert_input(include_lines, path)
         return []
 
-- 
2.50.1


