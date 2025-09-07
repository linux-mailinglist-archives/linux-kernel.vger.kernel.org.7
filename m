Return-Path: <linux-kernel+bounces-804742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA69B47C68
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070A13BE634
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 16:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43166284672;
	Sun,  7 Sep 2025 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRdSjPNf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5F1283FD4;
	Sun,  7 Sep 2025 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757262148; cv=none; b=FfV61DUprR/AJTQ/KBmFPyn9MfraMeVRt5xrbjcpSyHbMBPOVRvSh6sm8Lo3AQu62Q2GxqAKwypjQsRkVsp2u8D8Xbts73dEon9rvaSR8fHSIbgh6EijAohQYcPSxW9U7D8mDLqylV+lwBRZaaO8tBFvI7rGCe2Eo+WvCfIIUNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757262148; c=relaxed/simple;
	bh=rseNWx4p8Z6IKHAzzmqFgXVjwzTwBA/0+6t5EuWmh7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=n/WXoe+yPVCejdPehnDUgfAZdiWCXlxAVaOE/DtKg0nZOHAjQZq7pkF/X/JUK/lGhicizGMFTYFJdtExckZlPk5hHl+kKFyZhx3U9Vm9UfvMgG33T56FfYNKkKxtA8Y3qmdieLW6ebmwy+txtQUT7GZwUvRrq34/FXMlOccd018=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRdSjPNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FF6C4CEF0;
	Sun,  7 Sep 2025 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757262148;
	bh=rseNWx4p8Z6IKHAzzmqFgXVjwzTwBA/0+6t5EuWmh7Q=;
	h=From:To:Cc:Subject:Date:From;
	b=RRdSjPNflz3p8XyQK4Sm6PmaCz5vYZGVnVA5a7Lr3z140VvMEB62b7dshiK09SilK
	 caxoQGIrr8NPbc1L89Cj4XrIdMtXtSWVIm9qBGYlIiSjsm7Ttlc6PCECVo92tTMi/I
	 85MpYMZvZqvyj13cB2+CY2bK1kcG7xqwjSdnImcJTTjgYcZ2PRLRRPHMWKX5HmH6J0
	 mmdaHqyE3Uo+lRZnSDeHyXaRW5eyFfRSkagZtyeEbYaJ+7zTo5NyIYDb93uOR9m0Xw
	 k4kiBYBB3aNuqnE1FQINMgdnR9Y4XtcHt4efHtFzfq1EnL2Xtom+U8cGt0v1rWjfHq
	 eSfIhsb/NGemg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uvI9p-00000004DP1-22GX;
	Sun, 07 Sep 2025 18:22:25 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kernel-doc: add support for handling global variables
Date: Sun,  7 Sep 2025 18:22:22 +0200
Message-ID: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Specially on kAPI, sometimes it is desirable to be able to
describe global variables that are part of kAPI.

Documenting vars with Sphinx is simple, as we don't need
to parse a data struct. All we need is the variable
declaration and use natice C domain ::c:var: to format it
for us.

Add support for it.

Link: https://lore.kernel.org/linux-doc/491c3022-cef8-4860-a945-c9c4a3b63c09@infradead.org/T/#m947c25d95cb1d96a394410ab1131dc8e9e5013f1
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_output.py | 31 +++++++++++++++++++++++++++++++
 scripts/lib/kdoc/kdoc_parser.py | 25 ++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 1eca9a918558..405a5c407522 100644
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -199,6 +199,10 @@ class OutputFormat:
             self.out_enum(fname, name, args)
             return self.data
 
+        if dtype == "global":
+            self.out_global(fname, name, args)
+            return self.data
+
         if dtype == "typedef":
             self.out_typedef(fname, name, args)
             return self.data
@@ -227,6 +231,9 @@ class OutputFormat:
     def out_enum(self, fname, name, args):
         """Outputs an enum"""
 
+    def out_global(self, fname, name, args):
+        """Outputs a global variable"""
+
     def out_typedef(self, fname, name, args):
         """Outputs a typedef"""
 
@@ -472,6 +479,18 @@ class RestFormat(OutputFormat):
         self.lineprefix = oldprefix
         self.out_section(args)
 
+    def out_global(self, fname, name, args):
+        oldprefix = self.lineprefix
+        ln = args.declaration_start_line
+        prototype = args.other_stuff["var_type"]
+
+        self.data += f"

.. c:var:: {prototype}

"
+
+        self.print_lineno(ln)
+        self.lineprefix = "  "
+        self.output_highlight(args.get('purpose', ''))
+        self.data += "
"
+
     def out_typedef(self, fname, name, args):
 
         oldprefix = self.lineprefix
@@ -772,6 +791,18 @@ class ManFormat(OutputFormat):
             self.data += f'.SH "{section}"' + "
"
             self.output_highlight(text)
 
+    def out_global(self, fname, name, args):
+        out_name = self.arg_name(args, name)
+        prototype = args.other_stuff["var_type"]
+
+        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "
"
+
+        self.data += ".SH NAME
"
+        self.data += f"{prototype} \- {args['purpose']}
"
+
+        self.data += ".SH SYNOPSIS
"
+        self.data += f"enum {name}" + " {
"
+
     def out_typedef(self, fname, name, args):
         module = self.modulename
         purpose = args.get('purpose')
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 574972e1f741..e2a3f4574894 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -64,7 +64,7 @@ type_param = KernRe(r"@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
 # Tests for the beginning of a kerneldoc block in its various forms.
 #
 doc_block = doc_com + KernRe(r'DOC:\s*(.*)?', cache=False)
-doc_begin_data = KernRe(r"^\s*\*?\s*(struct|union|enum|typedef)\s*(\w*)", cache = False)
+doc_begin_data = KernRe(r"^\s*\*?\s*(struct|union|enum|typedef|global)\s*(\w*)", cache = False)
 doc_begin_func = KernRe(str(doc_com) +			# initial " * '
                         r"(?:\w+\s*\*\s*)?" + 		# type (not captured)
                         r'(?:define\s+)?' + 		# possible "define" (not captured)
@@ -886,6 +886,27 @@ class KernelDoc:
         self.output_declaration('enum', declaration_name,
                                 purpose=self.entry.declaration_purpose)
 
+    def dump_global(self, ln, proto):
+        """
+        Stores global variables that are part of kAPI.
+        """
+        VAR_ATTRIBS = [
+            "extern",
+        ]
+        OPTIONAL_VAR_ATTR = "^(?:" + "|".join(VAR_ATTRIBS) + ")?"
+
+        r= KernRe(OPTIONAL_VAR_ATTR + r"(\w.*)\s+([\w_]+)[\d\]\[]*\s*;(?:#.*)?$")
+        if not r.match(proto):
+           self.emit_msg(ln,f"{proto}: can't parse variable")
+           return
+
+        declaration_name = r.group(2)
+        var_type = r.group(0)
+
+        self.output_declaration("global", declaration_name,
+                                var_type=var_type,
+                                purpose=self.entry.declaration_purpose)
+
     def dump_declaration(self, ln, prototype):
         """
         Stores a data declaration inside self.entries array.
@@ -897,6 +918,8 @@ class KernelDoc:
             self.dump_typedef(ln, prototype)
         elif self.entry.decl_type in ["union", "struct"]:
             self.dump_struct(ln, prototype)
+        elif self.entry.decl_type == "global":
+            self.dump_global(ln, prototype)
         else:
             # This would be a bug
             self.emit_message(ln, f'Unknown declaration type: {self.entry.decl_type}')
-- 
2.51.0


