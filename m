Return-Path: <linux-kernel+bounces-782135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D5FB31B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D521D620FB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4D73314DC;
	Fri, 22 Aug 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePCvR+L7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA08C3126AC;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=DwEAUXhj1F5+w2H8mDQY9uBZ+aicIRSukiQMuld0MSubyjvPlxniSNCCbcJU39II64p5I7do99C0LlSiC36sGKYqEDdEQLEcNVb0T6/6ruA3HQjESLkPNd9r7VrgkeWLZ/BdPKdUQNuJFBL5CJltWYuZ8zDJCHzDCzwnePx2Ch0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=R6Yr4duEC8arn5hYajMGz65rXfC8mfkSt1jOlvNU8yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9+5m5hMqxr9L68+CNdwGnoamiR28Wm89KgzaLrWUOlJyaYuml6JXgFqx4HZ0/NdnFE3hwChQ8m350Vsm9EKIEeYlO4ylXRyFPyuFRzafrsDsPo+JT9bWdKoQFUNZoP/mN4On2crU7x9+xREhbCYfubRdIAdZPe4WBTlNUPaf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePCvR+L7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EACAC2BCC4;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=R6Yr4duEC8arn5hYajMGz65rXfC8mfkSt1jOlvNU8yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePCvR+L7rN7B+iSOPEv1/U0vt/52uYLktgOFffaLMwGGvHc1j6sSfoFRaOL06vkKD
	 mQseree+rD5dqsdkuT4aNoCPLR82MZdPSaW/MAq1s3yiJ/7+F+Yi0PS2VznA5XFScS
	 bolHDFfq04eQFc3AADsjI7S9ZEKAfSY1Wmaw8lJl767MSktf6dQtqG0rB9QB1kl9Jy
	 jlVs+AnSlrwZC0Ai6XkNgOact86pMye9AvNHl2/284FsmPhWuPrRpeHsznovStUAWO
	 SIrpP/D2c05UNDpu62uFDKZ1zBZ6b/hXWQ+2MmJr4jZcE1SV8kJqAQGrHYQZf8Ehf2
	 LBCVNg69x0fBw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCrz-2KH0;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/24] docs: kernel_include.py: add support to generate a TOC table
Date: Fri, 22 Aug 2025 16:19:29 +0200
Message-ID: <c0d32cd1ef94017e05984b0a38bd2516f7db21e2.1755872208.git.mchehab+huawei@kernel.org>
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

When generate-cross-refs is used, instead of just implementing
the default of generating a literal block, we can also
generate a ReST file as a TOC.

The advantage is that, by being a ReST file, missing references
will point to the place inside the header file that has the
broken link.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 36 ++++++++++++++++----------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index 0909eb3a07ea..79682408105e 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -89,6 +89,7 @@ class KernelInclude(Include):
     option_spec.update({
         'generate-cross-refs': directives.flag,
         'warn-broken': directives.flag,
+        'toc': directives.flag,
         'exception-file': directives.unchanged,
     })
 
@@ -111,7 +112,7 @@ class KernelInclude(Include):
             except UnicodeError as error:
                 raise self.severe('Problem with directive:\n%s' % ErrorString(error))
 
-    def read_rawtext_with_xrefs(self, env, path):
+    def read_rawtext_with_xrefs(self, env, path, output_type):
         parser = ParseDataStructs()
         parser.parse_file(path)
 
@@ -126,7 +127,10 @@ class KernelInclude(Include):
         if 'warn-broken' in self.options:
             env._xref_files.add(path)
 
-        return parser.gen_output()
+        if output_type == "toc":
+            return parser.gen_toc()
+
+        return ".. parsed-literal::\n\n" + parser.gen_output()
 
     def apply_range(self, rawtext):
         # Get to-be-included content
@@ -243,39 +247,43 @@ class KernelInclude(Include):
         e_handler = self.state.document.settings.input_encoding_error_handler
         tab_width = self.options.get("tab-width",
                                      self.state.document.settings.tab_width)
-        startline = self.options.get("start-line", None)
-        endline = self.options.get("end-line", None)
 
         if "literal" in self.options:
-            ouptut_type = "literal"
+            output_type = "literal"
         elif "code" in self.options:
-            ouptut_type = "code"
+            output_type = "code"
         else:
-            ouptut_type = "normal"
+            output_type = "rst"
 
         # Get optional arguments to related to cross-references generation
-        if 'generate-cross-refs' in self.options:
-            rawtext = self.read_rawtext_with_xrefs(env, path)
+        if "generate-cross-refs" in self.options:
+            if "toc" in self.options:
+                 output_type = "toc"
+
+            rawtext = self.read_rawtext_with_xrefs(env, path, output_type)
+
+            # When :generate-cross-refs: is used, the input is always a C
+            # file, so it has to be handled as a parsed-literal
+            if output_type == "rst":
+                output_type = "literal"
 
             title = os.path.basename(path)
-
-            if "code" not in self.options:
-                rawtext = ".. parsed-literal::\n\n" + rawtext
         else:
             rawtext = self.read_rawtext(path, encoding)
 
         rawtext = self.apply_range(rawtext)
 
-        if ouptut_type == "literal":
+        if output_type == "literal":
             return self.literal(path, tab_width, rawtext)
 
         include_lines = statemachine.string2lines(rawtext, tab_width,
                                                   convert_whitespace=True)
 
-        if ouptut_type == "code":
+        if output_type == "code":
             return self.code(path, include_lines)
 
         self.state_machine.insert_input(include_lines, path)
+
         return []
 
 # ==============================================================================
-- 
2.50.1


