Return-Path: <linux-kernel+bounces-759539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD52B1DEC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 859137B2147
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2582750F6;
	Thu,  7 Aug 2025 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="T0rRNTbW"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF2B273D79;
	Thu,  7 Aug 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601421; cv=none; b=j2hrel07lOo214GlCdMZHxQ+yLXKSGxhQ8XJjZp3U4TcjrmEu2qM6OPDQ+O/zax/dGrJ+HJIuJm4vOVaG2eOW+DUZL63ICZ0mYMyRvqJC27IuerZBd7TbfMFIdIIkpSVx1ETGsoETuMP1z4LjwKbO8l3/93fFxRspcYqS37nCPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601421; c=relaxed/simple;
	bh=adH7OXl+otzNFNzoSik5tKElfx+kwuSo0U+fRjSy0L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPH3z5+zb3Cw4EaYeLAHyOwpSf7v3pV3RiE8Y2TBCAM5JXfdlOBz/bHyDYVkIxuj+kUTrilNYaro2Ock2cupnzIwH74tfRon93gQ/oShcte7QvMDhjbTqZaDkoF45isTfign3n4oMESmVa/htVvDdsKXJ8gTNzGotktG8cXQ3os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=T0rRNTbW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1BDE440AF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754601415; bh=muRusV7g0EhklNFUmiNLJ9yssnHmtO7n6vX21TF1FXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0rRNTbWJli1JV/gXUiflnGsBZeoc/tVYaBmPiRRPPjvBkaD5fIMnH5yeoA+HgLwS
	 Yg9iFZEsthRqMMiu5+8iifSc+uQAENy65ROEsR8Ho0yYGhKFzkj2dULn82eiKx5PVr
	 QXVvnK4hzZM+keVKEpA2QlWJHtFizj1B62+PEWxymFO11r9SPgqE1kqO3mz9kVWW/P
	 Bw+WpHlVRvtq0fOrEH531S5vaKikza1n0nQOI/NqZxfzfu8pDqWEizrYD7T9BhvydR
	 SNB1Eum8v+3tWOy5q3oYdOfl3tKKRbn7+QU89vWtIwF+dhAsIrqULxIZLwoF2vZzK4
	 ZzcFMy+DF1d5A==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 1BDE440AF3;
	Thu,  7 Aug 2025 21:16:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 11/12] docs: kdoc: extract output formatting from dump_struct()
Date: Thu,  7 Aug 2025 15:16:38 -0600
Message-ID: <20250807211639.47286-12-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807211639.47286-1-corbet@lwn.net>
References: <20250807211639.47286-1-corbet@lwn.net>
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

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 72 +++++++++++++++++----------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index b3f937901037..878fbfab4ac7 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -739,6 +739,42 @@ class KernelDoc:
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
+        declaration = KernRe(r'([\{;])').sub(r'\1\n', declaration)
+        declaration = KernRe(r'\}\s+;').sub('};', declaration)
+        #
+        # Format inline enums with each member on its own line.
+        #
+        r = KernRe(r'(enum\s+\{[^\}]+),([^\n])')
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
@@ -777,42 +813,8 @@ class KernelDoc:
         self.create_parameter_list(ln, decl_type, members, ';',
                                    declaration_name)
         self.check_sections(ln, declaration_name, decl_type)
-
-        # Adjust declaration for better display
-        declaration = KernRe(r'([\{;])').sub(r'\1\n', declaration)
-        declaration = KernRe(r'\}\s+;').sub('};', declaration)
-
-        # Better handle inlined enums
-        while True:
-            r = KernRe(r'(enum\s+\{[^\}]+),([^\n])')
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


