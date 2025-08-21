Return-Path: <linux-kernel+bounces-780035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C575EB2FC52
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5717A46BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172C22D7385;
	Thu, 21 Aug 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqH23nLl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6385285042;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786099; cv=none; b=d5HjfOdT0clD3yoiM6lYhZiILrRjQR7I9Kl7Qz85tOx7I4uMk6S6P6cC9Ei44CV5QFW/SaMGjeD6n5/ICrmmQrfhiZI98OzMVr2RO+SA4t9gmJNbsH2P9iL7OWIAkRMuCosZj8iMNfWbesJ9vihHl6d/q2QY1mrahBog4xHNrdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786099; c=relaxed/simple;
	bh=R6Yr4duEC8arn5hYajMGz65rXfC8mfkSt1jOlvNU8yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3cGBM9HPZzwH7ZzG05iHCDTyu8qwZO1kHx1KvtGHfaQIJ+IJOyF4Jhw/aS/CFYzDksRblOYQ3UC1XID2bk1Vug7UES7e24fwdECwspLgXx7pHFVUTVHfa94p3lT8oqbd4iSzXGpyy213SCigTNtfGi25ysP6s1QQAdMQhab/4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqH23nLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A596C2BCB6;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=R6Yr4duEC8arn5hYajMGz65rXfC8mfkSt1jOlvNU8yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HqH23nLlB0O2qhbrws+Op98u1vfopuebC0S2m0L4PBLY4VIgLiBJTHsiQm0+bw92I
	 LzYrzHa/8mx+UIQdWdBgobQFIlQPm58BtinK8j4wzICBF86AcMkPri3BPA/1U9AvN+
	 vdQmOJqgrNmpeoYnOsScGMTGP7/k1zsEQH5Q6DnHYHD64XKO8nysuoCzfdnORQmKX9
	 ycW9haBIgMrQArSNfcvXfWSxYMmVXwcstKvXNo6zRIvz10adlDFJV4J3EaL5HUI7i+
	 F0O/Mew5N5fGsjQSGBw+qQRNFus8PZpQbtQeyawiegAVKCcwkcwNicckrNWapXU/aU
	 /tpvOmsvce/6Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT96-1mXD;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 17/24] docs: kernel_include.py: add support to generate a TOC table
Date: Thu, 21 Aug 2025 16:21:23 +0200
Message-ID: <a91896f6d8050b3bc62cdbca40906cc2804be50d.1755784930.git.mchehab+huawei@kernel.org>
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


