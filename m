Return-Path: <linux-kernel+bounces-726635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2FCB00FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F5E1CA8495
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158F9306DD9;
	Thu, 10 Jul 2025 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="dfC4xSJc"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC362216E1B;
	Thu, 10 Jul 2025 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190316; cv=none; b=BW7VChfnIFEZVEAvdG8nFgC0aIpu5YsOLuZGStrqZuCBU6naBlEELSWRX9hj/MMNplWXCjoKb3BaTgUmq3vjmegC73CTFKE+3g6D4d57xXco2oom4nGJSLMmrrPKu7nBujux4ofjwtN3hRIxEkZyP/J8YNsdC/G3OAlksZgenEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190316; c=relaxed/simple;
	bh=Pgb8LSDtxIzqmAipgaHHQZ057ikA2yl3SNNhfO18ASU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUKwq4EQk913taGhaegB8hynVUnU9bBXPHfMlRYEAF1uKM6hQuktHlbkFGmWwWlbscVGjOTS1zZdwWONFyQfTtjbnIU9pGJTaos16MvHPl9NlqqbBjdoXF83x2SBFvx0jQMfPyGKLhnHlOaiNgDDmdrzMQ7VWzfCshKEtR9X+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=dfC4xSJc; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F073340ADC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752190314; bh=NYjm9zhDgUZ/tCYwlre9mvWRl7P3MGpd9SwqGGfx1rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfC4xSJcm52hUCRnl0QrGJULHz55bDwUkPvlQF1OtLn/UfoXqurjGeye8kP+LOAs+
	 ulJHTszuEY7TBNCx6sgYx7eGEAoscu+f5b64uCif+BE09odcbOLdrfBRKg+cYBsjdR
	 sUHlqS5LnjCUPrm+6n+Nl+l6/IHZv3D2Xr3YoTNmGY9yjEM3QYeqLKi2C5UwblHP2a
	 PZv7UibqLXdx4iACVZjJB5RZ7FoHVp7MmHVYQDsbof4A8EljmbogeP+RVrj2frPgat
	 z5OMaDM9WIb72WufK+ItkldvNqMoZ0Ovz21waWuHVMu/n4pbfZIM4dij8Ez3VY7N9G
	 nNTgwskUzWoqw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id F073340ADC;
	Thu, 10 Jul 2025 23:31:53 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 03/12] docs: kdoc: drop "sectionlist"
Date: Thu, 10 Jul 2025 17:31:33 -0600
Message-ID: <20250710233142.246524-4-corbet@lwn.net>
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

Python dicts (as of 3.7) are guaranteed to remember the insertion order of
items, so we do not need a separate list for that purpose.  Drop the
per-entry sectionlist variable and just rely on native dict ordering.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_output.py | 18 ++++++------------
 scripts/lib/kdoc/kdoc_parser.py | 13 +------------
 2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 86102e628d91..4895c80e4b81 100644
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -339,11 +339,10 @@ class RestFormat(OutputFormat):
         tends to duplicate a header already in the template file.
         """
 
-        sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
         section_start_lines = args.get('section_start_lines', {})
 
-        for section in sectionlist:
+        for section in sections:
             # Skip sections that are in the nosymbol_table
             if section in self.nosymbol:
                 continue
@@ -636,7 +635,6 @@ class ManFormat(OutputFormat):
                 self.data += line + "\n"
 
     def out_doc(self, fname, name, args):
-        sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
 
         if not self.check_doc(name, args):
@@ -644,7 +642,7 @@ class ManFormat(OutputFormat):
 
         self.data += f'.TH "{self.modulename}" 9 "{self.modulename}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
-        for section in sectionlist:
+        for section in sections:
             self.data += f'.SH "{section}"' + "\n"
             self.output_highlight(sections.get(section))
 
@@ -653,7 +651,6 @@ class ManFormat(OutputFormat):
 
         parameterlist = args.get('parameterlist', [])
         parameterdescs = args.get('parameterdescs', {})
-        sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
 
         self.data += f'.TH "{args["function"]}" 9 "{args["function"]}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
@@ -695,7 +692,7 @@ class ManFormat(OutputFormat):
             self.data += f'.IP "{parameter}" 12' + "\n"
             self.output_highlight(parameterdescs.get(parameter_name, ""))
 
-        for section in sectionlist:
+        for section in sections:
             self.data += f'.SH "{section.upper()}"' + "\n"
             self.output_highlight(sections[section])
 
@@ -703,7 +700,6 @@ class ManFormat(OutputFormat):
 
         name = args.get('enum', '')
         parameterlist = args.get('parameterlist', [])
-        sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
 
         self.data += f'.TH "{self.modulename}" 9 "enum {args["enum"]}" "{self.man_date}" "API Manual" LINUX' + "\n"
@@ -731,7 +727,7 @@ class ManFormat(OutputFormat):
             self.data += f'.IP "{parameter}" 12' + "\n"
             self.output_highlight(args['parameterdescs'].get(parameter_name, ""))
 
-        for section in sectionlist:
+        for section in sections:
             self.data += f'.SH "{section}"' + "\n"
             self.output_highlight(sections[section])
 
@@ -739,7 +735,6 @@ class ManFormat(OutputFormat):
         module = self.modulename
         typedef = args.get('typedef')
         purpose = args.get('purpose')
-        sectionlist = args.get('sectionlist', [])
         sections = args.get('sections', {})
 
         self.data += f'.TH "{module}" 9 "{typedef}" "{self.man_date}" "API Manual" LINUX' + "\n"
@@ -747,7 +742,7 @@ class ManFormat(OutputFormat):
         self.data += ".SH NAME\n"
         self.data += f"typedef {typedef} \\- {purpose}\n"
 
-        for section in sectionlist:
+        for section in sections:
             self.data += f'.SH "{section}"' + "\n"
             self.output_highlight(sections.get(section))
 
@@ -757,7 +752,6 @@ class ManFormat(OutputFormat):
         struct_name = args.get('struct')
         purpose = args.get('purpose')
         definition = args.get('definition')
-        sectionlist = args.get('sectionlist', [])
         parameterlist = args.get('parameterlist', [])
         sections = args.get('sections', {})
         parameterdescs = args.get('parameterdescs', {})
@@ -788,6 +782,6 @@ class ManFormat(OutputFormat):
             self.data += f'.IP "{parameter}" 12' + "\n"
             self.output_highlight(parameterdescs.get(parameter_name))
 
-        for section in sectionlist:
+        for section in sections:
             self.data += f'.SH "{section}"' + "\n"
             self.output_highlight(sections.get(section))
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 97380ff30a0d..2e00c8b3a5f2 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -127,7 +127,6 @@ class KernelEntry:
         self.parameterdesc_start_lines = {}
 
         self.section_start_lines = {}
-        self.sectionlist = []
         self.sections = {}
 
         self.anon_struct_union = False
@@ -202,7 +201,6 @@ class KernelEntry:
                 self.sections[name] += '\n' + contents
             else:
                 self.sections[name] = contents
-                self.sectionlist.append(name)
                 self.section_start_lines[name] = self.new_start_line
                 self.new_start_line = 0
 
@@ -275,14 +273,12 @@ class KernelDoc:
         item.warnings = self.entry.warnings
 
         sections = item.get('sections', {})
-        sectionlist = item.get('sectionlist', [])
 
         # Drop empty sections
         # TODO: improve empty sections logic to emit warnings
         for section in ["Description", "Return"]:
-            if section in sectionlist and not sections[section].rstrip():
+            if section in sections and not sections[section].rstrip():
                 del sections[section]
-                sectionlist.remove(section)
 
         self.entries.append(item)
 
@@ -828,7 +824,6 @@ class KernelDoc:
                                 parameterdescs=self.entry.parameterdescs,
                                 parametertypes=self.entry.parametertypes,
                                 parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
-                                sectionlist=self.entry.sectionlist,
                                 sections=self.entry.sections,
                                 section_start_lines=self.entry.section_start_lines,
                                 purpose=self.entry.declaration_purpose)
@@ -913,7 +908,6 @@ class KernelDoc:
                                 parameterlist=self.entry.parameterlist,
                                 parameterdescs=self.entry.parameterdescs,
                                 parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
-                                sectionlist=self.entry.sectionlist,
                                 sections=self.entry.sections,
                                 section_start_lines=self.entry.section_start_lines,
                                 purpose=self.entry.declaration_purpose)
@@ -1085,7 +1079,6 @@ class KernelDoc:
                                     parameterdescs=self.entry.parameterdescs,
                                     parametertypes=self.entry.parametertypes,
                                     parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
-                                    sectionlist=self.entry.sectionlist,
                                     sections=self.entry.sections,
                                     section_start_lines=self.entry.section_start_lines,
                                     purpose=self.entry.declaration_purpose,
@@ -1099,7 +1092,6 @@ class KernelDoc:
                                     parameterdescs=self.entry.parameterdescs,
                                     parametertypes=self.entry.parametertypes,
                                     parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
-                                    sectionlist=self.entry.sectionlist,
                                     sections=self.entry.sections,
                                     section_start_lines=self.entry.section_start_lines,
                                     purpose=self.entry.declaration_purpose,
@@ -1145,7 +1137,6 @@ class KernelDoc:
                                     parameterdescs=self.entry.parameterdescs,
                                     parametertypes=self.entry.parametertypes,
                                     parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
-                                    sectionlist=self.entry.sectionlist,
                                     sections=self.entry.sections,
                                     section_start_lines=self.entry.section_start_lines,
                                     purpose=self.entry.declaration_purpose)
@@ -1168,7 +1159,6 @@ class KernelDoc:
 
             self.output_declaration('typedef', declaration_name,
                                     typedef=declaration_name,
-                                    sectionlist=self.entry.sectionlist,
                                     sections=self.entry.sections,
                                     section_start_lines=self.entry.section_start_lines,
                                     purpose=self.entry.declaration_purpose)
@@ -1653,7 +1643,6 @@ class KernelDoc:
         if doc_end.search(line):
             self.dump_section()
             self.output_declaration("doc", self.entry.identifier,
-                                    sectionlist=self.entry.sectionlist,
                                     sections=self.entry.sections,
                                     section_start_lines=self.entry.section_start_lines)
             self.reset_state(ln)
-- 
2.49.0


