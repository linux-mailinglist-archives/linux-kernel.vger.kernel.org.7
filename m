Return-Path: <linux-kernel+bounces-726639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 390C7B00FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C66A4A89F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A2F309A5D;
	Thu, 10 Jul 2025 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="crjqaG/p"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA31306DD2;
	Thu, 10 Jul 2025 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190318; cv=none; b=gxYP1Iqyq1ckuGjKXvyGpV692Prpr8Gmrv1XFcFoAk3jO1oD/+/MmtBpm4bQyCathumnMZcrXhC2II3AgNKrV2z2m2ABq6KgIVLUVhtupCCXD+ZB1LrPCUJkQLGB0s5A2ks7DFi+aYcSBn+9Yti4Csh3ojdA/PMRfC2DR+CG0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190318; c=relaxed/simple;
	bh=yi3E5gGZtFWAfnqaMvkeYMGQdRCxjIcRoAvpERtedZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sG4yFMYPlKuQOXI/V4rubaPhgeUuoEDZZ/KM4Ws1fW9Ge5PstAl7v+ovvDu3qkrjZLZZqDPLi1SpP6g4oD0SD3Zlkgtjq0c86uL/qnDii0RXfaDGVO0zwV442WOfRZA0NyAhkydXJl65a5kYUOqSGN3uCl7giEiNgCqFbfpyE1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=crjqaG/p; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 138D140AD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752190316; bh=mVkW5pQctwOVUnvld2bEO+nCywghD/K9nqJLvCYfBNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=crjqaG/pb+ZCBs2GF2ee1eodmKlu6vhSHtvuA8q7M0kMhWfSxQMgAqT46QPw7+HUG
	 kg8TlS3Wf2aNz9xwZXbtkrkY9AuWxhQFaIDH4JjRvgPbid5wCGx0IwaonvyzcxMiuu
	 CTkOjYhaK7fU85Hb8m6Q4A6/SaOxFQyFoPaqM/rU0yrFsL/0BM9SyhFYv6BQ0hvroO
	 D1FHuQi5/a0NdrcJ3zPyPw2NPkGfQdm+PZF8sf2O+DkFdRv8C1hbW44/vEBfi/FOyo
	 /xFRfQmtYCaCjuqUbLURRLG5hGaoKTk3w551ViXRd/Vlf4EUZgeqgNaRK3V6BA67MN
	 5WBC41Sb4b3Ww==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 138D140AD8;
	Thu, 10 Jul 2025 23:31:56 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 07/12] docs: kdoc: Coalesce parameter-list handling
Date: Thu, 10 Jul 2025 17:31:37 -0600
Message-ID: <20250710233142.246524-8-corbet@lwn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710233142.246524-1-corbet@lwn.net>
References: <20250710233142.246524-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers to output_declaration() always pass the parameter information from
self.entry; remove all of the boilerplate arguments and just get at that
information directly.  Formalize its placement in the KdocItem class.

It would be nice to get rid of parameterlist as well, but that has the
effect of reordering the output of function parameters and struct fields to
match the order in the kerneldoc comment rather than in the declaration.
One could argue about which is more correct, but the ordering has been left
unchanged for now.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_item.py   | 11 ++++-
 scripts/lib/kdoc/kdoc_output.py | 75 +++++++++++++--------------------
 scripts/lib/kdoc/kdoc_parser.py | 23 ++--------
 3 files changed, 42 insertions(+), 67 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_item.py b/scripts/lib/kdoc/kdoc_item.py
index f0b2b9082c56..beac5c70a881 100644
--- a/scripts/lib/kdoc/kdoc_item.py
+++ b/scripts/lib/kdoc/kdoc_item.py
@@ -11,6 +11,9 @@ class KdocItem:
         self.declaration_start_line = start_line
         self.sections = {}
         self.sections_start_lines = {}
+        self.parameterlist = self.parameterdesc_start_lines = []
+        self.parameterdescs = {}
+        self.parametertypes = {}
         #
         # Just save everything else into our own dict so that the output
         # side can grab it directly as before.  As we move things into more
@@ -28,8 +31,14 @@ class KdocItem:
         return self.get(key)
 
     #
-    # Tracking of section information.
+    # Tracking of section and parameter information.
     #
     def set_sections(self, sections, start_lines):
         self.sections = sections
         self.section_start_lines = start_lines
+
+    def set_params(self, names, descs, types, starts):
+        self.parameterlist = names
+        self.parameterdescs = descs
+        self.parametertypes = types
+        self.parameterdesc_start_lines = starts
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 15cb89f91987..d6f4d9e7173b 100644
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -373,18 +373,13 @@ class RestFormat(OutputFormat):
                 signature = args['functiontype'] + " "
             signature += args['function'] + " ("
 
-        parameterlist = args.get('parameterlist', [])
-        parameterdescs = args.get('parameterdescs', {})
-        parameterdesc_start_lines = args.get('parameterdesc_start_lines', {})
-
         ln = args.get('declaration_start_line', 0)
-
         count = 0
-        for parameter in parameterlist:
+        for parameter in args.parameterlist:
             if count != 0:
                 signature += ", "
             count += 1
-            dtype = args['parametertypes'].get(parameter, "")
+            dtype = args.parametertypes.get(parameter, "")
 
             if function_pointer.search(dtype):
                 signature += function_pointer.group(1) + parameter + function_pointer.group(3)
@@ -419,26 +414,26 @@ class RestFormat(OutputFormat):
         # function prototypes apart
         self.lineprefix = "  "
 
-        if parameterlist:
+        if args.parameterlist:
             self.data += ".. container:: kernelindent\n\n"
             self.data += f"{self.lineprefix}**Parameters**\n\n"
 
-        for parameter in parameterlist:
+        for parameter in args.parameterlist:
             parameter_name = KernRe(r'\[.*').sub('', parameter)
-            dtype = args['parametertypes'].get(parameter, "")
+            dtype = args.parametertypes.get(parameter, "")
 
             if dtype:
                 self.data += f"{self.lineprefix}``{dtype}``\n"
             else:
                 self.data += f"{self.lineprefix}``{parameter}``\n"
 
-            self.print_lineno(parameterdesc_start_lines.get(parameter_name, 0))
+            self.print_lineno(args.parameterdesc_start_lines.get(parameter_name, 0))
 
             self.lineprefix = "    "
-            if parameter_name in parameterdescs and \
-               parameterdescs[parameter_name] != KernelDoc.undescribed:
+            if parameter_name in args.parameterdescs and \
+               args.parameterdescs[parameter_name] != KernelDoc.undescribed:
 
-                self.output_highlight(parameterdescs[parameter_name])
+                self.output_highlight(args.parameterdescs[parameter_name])
                 self.data += "\n"
             else:
                 self.data += f"{self.lineprefix}*undescribed*\n\n"
@@ -451,8 +446,6 @@ class RestFormat(OutputFormat):
 
         oldprefix = self.lineprefix
         name = args.get('enum', '')
-        parameterlist = args.get('parameterlist', [])
-        parameterdescs = args.get('parameterdescs', {})
         ln = args.get('declaration_start_line', 0)
 
         self.data += f"\n\n.. c:enum:: {name}\n\n"
@@ -467,11 +460,11 @@ class RestFormat(OutputFormat):
         self.lineprefix = outer + "  "
         self.data += f"{outer}**Constants**\n\n"
 
-        for parameter in parameterlist:
+        for parameter in args.parameterlist:
             self.data += f"{outer}``{parameter}``\n"
 
-            if parameterdescs.get(parameter, '') != KernelDoc.undescribed:
-                self.output_highlight(parameterdescs[parameter])
+            if args.parameterdescs.get(parameter, '') != KernelDoc.undescribed:
+                self.output_highlight(args.parameterdescs[parameter])
             else:
                 self.data += f"{self.lineprefix}*undescribed*\n\n"
             self.data += "\n"
@@ -505,10 +498,6 @@ class RestFormat(OutputFormat):
         dtype = args.get('type', "struct")
         ln = args.get('declaration_start_line', 0)
 
-        parameterlist = args.get('parameterlist', [])
-        parameterdescs = args.get('parameterdescs', {})
-        parameterdesc_start_lines = args.get('parameterdesc_start_lines', {})
-
         self.data += f"\n\n.. c:{dtype}:: {name}\n\n"
 
         self.print_lineno(ln)
@@ -531,21 +520,21 @@ class RestFormat(OutputFormat):
 
         self.lineprefix = "  "
         self.data += f"{self.lineprefix}**Members**\n\n"
-        for parameter in parameterlist:
+        for parameter in args.parameterlist:
             if not parameter or parameter.startswith("#"):
                 continue
 
             parameter_name = parameter.split("[", maxsplit=1)[0]
 
-            if parameterdescs.get(parameter_name) == KernelDoc.undescribed:
+            if args.parameterdescs.get(parameter_name) == KernelDoc.undescribed:
                 continue
 
-            self.print_lineno(parameterdesc_start_lines.get(parameter_name, 0))
+            self.print_lineno(args.parameterdesc_start_lines.get(parameter_name, 0))
 
             self.data += f"{self.lineprefix}``{parameter}``\n"
 
             self.lineprefix = "    "
-            self.output_highlight(parameterdescs[parameter_name])
+            self.output_highlight(args.parameterdescs[parameter_name])
             self.lineprefix = "  "
 
             self.data += "\n"
@@ -643,9 +632,6 @@ class ManFormat(OutputFormat):
     def out_function(self, fname, name, args):
         """output function in man"""
 
-        parameterlist = args.get('parameterlist', [])
-        parameterdescs = args.get('parameterdescs', {})
-
         self.data += f'.TH "{args["function"]}" 9 "{args["function"]}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
 
         self.data += ".SH NAME\n"
@@ -661,11 +647,11 @@ class ManFormat(OutputFormat):
         parenth = "("
         post = ","
 
-        for parameter in parameterlist:
-            if count == len(parameterlist) - 1:
+        for parameter in args.parameterlist:
+            if count == len(args.parameterlist) - 1:
                 post = ");"
 
-            dtype = args['parametertypes'].get(parameter, "")
+            dtype = args.parametertypes.get(parameter, "")
             if function_pointer.match(dtype):
                 # Pointer-to-function
                 self.data += f'".BI "{parenth}{function_pointer.group(1)}" " ") ({function_pointer.group(2)}){post}"' + "\n"
@@ -676,14 +662,14 @@ class ManFormat(OutputFormat):
             count += 1
             parenth = ""
 
-        if parameterlist:
+        if args.parameterlist:
             self.data += ".SH ARGUMENTS\n"
 
-        for parameter in parameterlist:
+        for parameter in args.parameterlist:
             parameter_name = re.sub(r'\[.*', '', parameter)
 
             self.data += f'.IP "{parameter}" 12' + "\n"
-            self.output_highlight(parameterdescs.get(parameter_name, ""))
+            self.output_highlight(args.parameterdescs.get(parameter_name, ""))
 
         for section, text in args.sections.items():
             self.data += f'.SH "{section.upper()}"' + "\n"
@@ -692,7 +678,6 @@ class ManFormat(OutputFormat):
     def out_enum(self, fname, name, args):
 
         name = args.get('enum', '')
-        parameterlist = args.get('parameterlist', [])
 
         self.data += f'.TH "{self.modulename}" 9 "enum {args["enum"]}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
@@ -703,9 +688,9 @@ class ManFormat(OutputFormat):
         self.data += f"enum {args['enum']}" + " {\n"
 
         count = 0
-        for parameter in parameterlist:
+        for parameter in args.parameterlist:
             self.data += f'.br\n.BI "    {parameter}"' + "\n"
-            if count == len(parameterlist) - 1:
+            if count == len(args.parameterlist) - 1:
                 self.data += "\n};\n"
             else:
                 self.data += ", \n.br\n"
@@ -714,10 +699,10 @@ class ManFormat(OutputFormat):
 
         self.data += ".SH Constants\n"
 
-        for parameter in parameterlist:
+        for parameter in args.parameterlist:
             parameter_name = KernRe(r'\[.*').sub('', parameter)
             self.data += f'.IP "{parameter}" 12' + "\n"
-            self.output_highlight(args['parameterdescs'].get(parameter_name, ""))
+            self.output_highlight(args.parameterdescs.get(parameter_name, ""))
 
         for section, text in args.sections.items():
             self.data += f'.SH "{section}"' + "\n"
@@ -743,8 +728,6 @@ class ManFormat(OutputFormat):
         struct_name = args.get('struct')
         purpose = args.get('purpose')
         definition = args.get('definition')
-        parameterlist = args.get('parameterlist', [])
-        parameterdescs = args.get('parameterdescs', {})
 
         self.data += f'.TH "{module}" 9 "{struct_type} {struct_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
@@ -760,17 +743,17 @@ class ManFormat(OutputFormat):
         self.data += f'.BI "{declaration}\n' + "};\n.br\n\n"
 
         self.data += ".SH Members\n"
-        for parameter in parameterlist:
+        for parameter in args.parameterlist:
             if parameter.startswith("#"):
                 continue
 
             parameter_name = re.sub(r"\[.*", "", parameter)
 
-            if parameterdescs.get(parameter_name) == KernelDoc.undescribed:
+            if args.parameterdescs.get(parameter_name) == KernelDoc.undescribed:
                 continue
 
             self.data += f'.IP "{parameter}" 12' + "\n"
-            self.output_highlight(parameterdescs.get(parameter_name))
+            self.output_highlight(args.parameterdescs.get(parameter_name))
 
         for section, text in args.sections.items():
             self.data += f'.SH "{section}"' + "\n"
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index ffd49f9395ae..298abd260264 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -278,7 +278,9 @@ class KernelDoc:
             if section in sections and not sections[section].rstrip():
                 del sections[section]
         item.set_sections(sections, self.entry.section_start_lines)
-
+        item.set_params(self.entry.parameterlist, self.entry.parameterdescs,
+                        self.entry.parametertypes,
+                        self.entry.parameterdesc_start_lines)
         self.entries.append(item)
 
         self.config.log.debug("Output: %s:%s = %s", dtype, name, pformat(args))
@@ -790,10 +792,6 @@ class KernelDoc:
         self.output_declaration(decl_type, declaration_name,
                                 struct=declaration_name,
                                 definition=declaration,
-                                parameterlist=self.entry.parameterlist,
-                                parameterdescs=self.entry.parameterdescs,
-                                parametertypes=self.entry.parametertypes,
-                                parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
                                 purpose=self.entry.declaration_purpose)
 
     def dump_enum(self, ln, proto):
@@ -873,9 +871,6 @@ class KernelDoc:
 
         self.output_declaration('enum', declaration_name,
                                 enum=declaration_name,
-                                parameterlist=self.entry.parameterlist,
-                                parameterdescs=self.entry.parameterdescs,
-                                parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
                                 purpose=self.entry.declaration_purpose)
 
     def dump_declaration(self, ln, prototype):
@@ -1039,10 +1034,6 @@ class KernelDoc:
                                     function=declaration_name,
                                     typedef=True,
                                     functiontype=return_type,
-                                    parameterlist=self.entry.parameterlist,
-                                    parameterdescs=self.entry.parameterdescs,
-                                    parametertypes=self.entry.parametertypes,
-                                    parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
                                     purpose=self.entry.declaration_purpose,
                                     func_macro=func_macro)
         else:
@@ -1050,10 +1041,6 @@ class KernelDoc:
                                     function=declaration_name,
                                     typedef=False,
                                     functiontype=return_type,
-                                    parameterlist=self.entry.parameterlist,
-                                    parameterdescs=self.entry.parameterdescs,
-                                    parametertypes=self.entry.parametertypes,
-                                    parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
                                     purpose=self.entry.declaration_purpose,
                                     func_macro=func_macro)
 
@@ -1093,10 +1080,6 @@ class KernelDoc:
                                     function=declaration_name,
                                     typedef=True,
                                     functiontype=return_type,
-                                    parameterlist=self.entry.parameterlist,
-                                    parameterdescs=self.entry.parameterdescs,
-                                    parametertypes=self.entry.parametertypes,
-                                    parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
                                     purpose=self.entry.declaration_purpose)
             return
 
-- 
2.49.0


