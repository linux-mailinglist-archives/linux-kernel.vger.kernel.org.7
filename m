Return-Path: <linux-kernel+bounces-752759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1D5B17A87
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B027AEF39
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DA418DB1C;
	Fri,  1 Aug 2025 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pGlv1bbO"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8633DF;
	Fri,  1 Aug 2025 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007227; cv=none; b=Bp6Cb1JM8JXc3S/C/LLVJyXuk6+sIHxXYk9idxfzZuid8gSF8ac1rcGR1pWv+3nhgEUNReymuyefOHSkc8YWIqhfMMj2w0NVirUvaKKgTEuZoSA1fpK5xDvEsv6+YPsum1z8MuonyeQDB5XXO2iaMEwGMjXT20dytUHiwvG2m6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007227; c=relaxed/simple;
	bh=cySWM4d6Zu1D+4PkGvnJjrzGxriO8AGGSEx5r9Yti8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBhYtGV4OEB7R3AzNcppfwpdgK9QsJ+wAqjgSSFfdqUgmnUIArXmGzM1eZt4G13MBB6svsHCD/HPhLEC0Zaf7pWUpYiDTKlShgy+7hjoauvUrHj1AfmZTLp+6BHYDuwKZn4c7mW2Xv7BKnAI7Vz/v7UqUdT6NOJmZQLC2x1zvcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pGlv1bbO; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E819940AF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754007221; bh=Gq5Dfzv5xqo7YhSMK7c2zzkvwfQxptpVHiU1PPp2vYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pGlv1bbOQnqLgpLptUlxRNnWkyLDkweZI2RuoAvyXxdH07hquY+I3pOixfV5qqcNc
	 /jrhiwr4u5qkDWPGH/dgd322l661UmBujsC5RriaNj6Jp7384mfiamlADkJ98/ZO2u
	 FuNm45Vb5zNChBHX7cStXO5OFE3MXBqywRyRjp8fQq2yQAGDaoN6e3h9c3eDSoINVH
	 1SUYJay9yJyrg5HO2lHkwFaplS2ZgSHxRPc+GDF8U7cW38PpqE9MuSa9tTINUohsmX
	 T6CExqNLKraM72yWd3Q6K9rYjH0fTMI0Y9AseuhJJDc/U5xlZugUjTvBlPgI925qHa
	 xkqhiU0/89s+w==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id E819940AF2;
	Fri,  1 Aug 2025 00:13:40 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 11/12] docs: kdoc: extract output formatting from dump_struct()
Date: Thu, 31 Jul 2025 18:13:25 -0600
Message-ID: <20250801001326.924276-12-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801001326.924276-1-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last thing done in dump_struct() is to format the structure for
printing.  That, too, is a separate activity; split it out into its own
function.

dump_struct() now fits in a single, full-hight editor screen.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 72 +++++++++++++++++----------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 2b7d7e646367..131956d89f84 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -738,6 +738,42 @@ class KernelDoc:
             tuples = struct_members.findall(members)
         return members
 
+    #
+    # Format the struct declaration into a standard form for inclusion in the
+    # resulting docs.
+    #
+    def format_struct_decl(self, declaration):
+        #
+        # Insert newlines, get rid of extra spaces.
+        #
+        declaration = KernRe(r'([{;])').sub(r'\1\n', declaration)
+        declaration = KernRe(r'\}\s+;').sub('};', declaration)
+        #
+        # Format inline enums with each member on its own line.
+        #
+        r = KernRe(r'(enum\s+\{[^}]+),([^\n])')
+        while r.search(declaration):
+            declaration = r.sub(r'\1,\n\2', declaration)
+        #
+        # Now go through and supply the right number of tabs
+        # for each line.
+        #
+        def_args = declaration.split('\n')
+        level = 1
+        declaration = ""
+        for clause in def_args:
+            clause = KernRe(r'\s+').sub(' ', clause.strip(), count=1)
+            if clause:
+                if '}' in clause and level > 1:
+                    level -= 1
+                if not clause.startswith('#'):
+                    declaration += "\t" * level
+                declaration += "\t" + clause + "\n"
+                if "{" in clause and "}" not in clause:
+                    level += 1
+        return declaration
+
+
     def dump_struct(self, ln, proto):
         """
         Store an entry for an struct or union
@@ -776,42 +812,8 @@ class KernelDoc:
         self.create_parameter_list(ln, decl_type, members, ';',
                                    declaration_name)
         self.check_sections(ln, declaration_name, decl_type)
-
-        # Adjust declaration for better display
-        declaration = KernRe(r'([{;])').sub(r'\1\n', declaration)
-        declaration = KernRe(r'\}\s+;').sub('};', declaration)
-
-        # Better handle inlined enums
-        while True:
-            r = KernRe(r'(enum\s+\{[^}]+),([^\n])')
-            if not r.search(declaration):
-                break
-
-            declaration = r.sub(r'\1,\n\2', declaration)
-
-        def_args = declaration.split('\n')
-        level = 1
-        declaration = ""
-        for clause in def_args:
-
-            clause = clause.strip()
-            clause = KernRe(r'\s+').sub(' ', clause, count=1)
-
-            if not clause:
-                continue
-
-            if '}' in clause and level > 1:
-                level -= 1
-
-            if not KernRe(r'^\s*#').match(clause):
-                declaration += "\t" * level
-
-            declaration += "\t" + clause + "\n"
-            if "{" in clause and "}" not in clause:
-                level += 1
-
         self.output_declaration(decl_type, declaration_name,
-                                definition=declaration,
+                                definition=self.format_struct_decl(declaration),
                                 purpose=self.entry.declaration_purpose)
 
     def dump_enum(self, ln, proto):
-- 
2.50.1


