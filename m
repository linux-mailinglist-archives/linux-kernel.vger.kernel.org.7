Return-Path: <linux-kernel+bounces-780038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A74AEB2FCAC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E34B723793
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43117266565;
	Thu, 21 Aug 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0vyeHCE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84C02857CF;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786099; cv=none; b=XixoRb/5uheiGz9kbwCW8ycGpcpydByJLDlWDi/2+2X0JXzRA00u8BGvGBEwb29YIzDKK1qaM5JtccZJJN186L97ePSV77haiROzFAS2cwGn750U34SCj2xVTrGX3UtM1ZOiiDBQ+cXh55KF0Y4+YuQzc0d6ryQe1iIr4TG/rjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786099; c=relaxed/simple;
	bh=XLpGjVmiz7KWSgkDl0zwCX9wJOnCvElrKCUuUORJrj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhhXKY2f4sNaCkeA2usVInqZD94rYkuq4v7KirfdUuF/vsuZD/BX+1jnDp4lbBkQlImekujx6T5vw7xcWGPp2BbW9DfXYUGXlDUsaslRvw3yneAL6ro4aICZiN+CXjVRl1WJ01nM1fvE9SlHBPFR9/+6FaDFSqN15T+foJRopHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0vyeHCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A51C2BCB5;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=XLpGjVmiz7KWSgkDl0zwCX9wJOnCvElrKCUuUORJrj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0vyeHCE3qfDsq0D4MUgUVrAQDhsIuCEzI/P548tnM9nZ5Muk91VVYMiRaeedD7Wt
	 vTONdyjILJMfX/ePvRar4MwZo7QGt34OAeIoPCd2OiuiJX8XR38CqmKFkqo4p0AJFu
	 xe9TEBOUOyTC4wzlOy7TWgGRz4VWvem0b0vZDy3NQVRv0ouIJqdPhpfxJZMsfeQwG0
	 phEHbF5YW44ATkBx4awRTIX9X5NjyexQ2E9szQYUqsurXoPTOYpndaqupjL2EfLWmh
	 BKUKPFEkGBom6ji4hWIoDLbspnhuSiYjN7Q3MNksPH8NBWlAzjNhxqXFaoHax/GD+V
	 /60orX2LtmQCA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT92-1ftd;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/24] docs: kernel_include.py: move code and literal functions
Date: Thu, 21 Aug 2025 16:21:22 +0200
Message-ID: <32c0cee9ef85f8d4789f50514d77f719118b3217.1755784930.git.mchehab+huawei@kernel.org>
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


