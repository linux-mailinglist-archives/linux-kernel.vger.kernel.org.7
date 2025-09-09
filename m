Return-Path: <linux-kernel+bounces-809001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C39B50751
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A374B4E8796
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0F236C06F;
	Tue,  9 Sep 2025 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="iHPPZP2R"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A1A362982;
	Tue,  9 Sep 2025 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450652; cv=none; b=T4tF0XvmFEUsVUJicm35v2MxnrF5AvqsJbqDIeFDzPvhs+mZ6djoBTaCMYxkJtUHBU1XxivV5SC8uC+uVyEvY+8WPI/DbTX+dOMi6XMuVvoCK+5AqjIVsILKZ9h+sBiJXf1PdACJAvWcy6qLzu1cGlXP/5Ak+MiTgSOn+nPBDb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450652; c=relaxed/simple;
	bh=UUikvXhoU1n+d3L3fH+HOOxaLxdRorEDbrqgyrx1PLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJj1NAD0rGYAM3Z1Gme3sjHOm5YY+lk73+yVlEZ3tcuno9jxRKeIeb1jrv3ninfaWwjroLT801dUprs1Fcgh8EfJcwuA5yEo7j9QY2yA0t6/eG04Ic71D5ktuOedCfkeBLWQLYkGFEjgavLWfFV4ABtD0Ebhpvp29bPEXmYW+1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=iHPPZP2R; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A3A7140B0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757450651; bh=FuBMOOv3BTXg/gSEWq2cWSKAA57PetmUukt7C50G6AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iHPPZP2Ri6n0pYwd/kUQReM9eAhzgzEUjdl+JTpbgCJZqK4GF+r319w3eCYMBSeSa
	 JCSQ3hiuLiZulETdm7QTu0JYArMqX8FZwQkcPlim6lZIkXBB5LQNkEjZTOdfxZa+6p
	 GeYEtYDhHeiaQ9lZ5NI14gE9dh2Z0V6d+fNYuu43tld01YJ1FeaSVYs6KPK55JIFrk
	 XqHGXuvEFYfb9hVmcy76/yuHx3m06RltdUX3Aa2OjwIygY5WVqpr7rr/Cxqj4l/7tp
	 DjJ4TlGuanH33RAUVu7uCpKc91qn6EqfrnkfoNrWfk2aV+5hKHkJK6/fXMkE6yU3A9
	 KocdoX3HO4hHw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id A3A7140B0B;
	Tue,  9 Sep 2025 20:44:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 09/13] docs: kdoc: consolidate some of the macro-processing logic
Date: Tue,  9 Sep 2025 14:43:45 -0600
Message-ID: <20250909204349.123680-10-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909204349.123680-1-corbet@lwn.net>
References: <20250909204349.123680-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic to handle macros is split in dump_function(); bring it all
together into a single place and add a comment saying what's going on.
Remove the unneeded is_define_proto variable, and tighten up the code
a bit.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 43 +++++++++++++++------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index ec2e6e83df05..27329ce9b5e9 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -926,21 +926,31 @@ class KernelDoc:
         Stores a function of function macro inside self.entries array.
         """
 
-        func_macro = False
+        found = func_macro = False
         return_type = ''
         decl_type = 'function'
         #
         # Apply the initial transformations.
         #
         prototype = apply_transforms(function_xforms, prototype)
-
-        # Macros are a special case, as they change the prototype format
+        #
+        # If we have a macro, remove the "#define" at the front.
+        #
         new_proto = KernRe(r"^#\s*define\s+").sub("", prototype)
         if new_proto != prototype:
-            is_define_proto = True
             prototype = new_proto
-        else:
-            is_define_proto = False
+            #
+            # Dispense with the simple "#define A B" case here; the key
+            # is the space after the name of the symbol being defined.
+            # NOTE that the seemingly misnamed "func_macro" indicates a
+            # macro *without* arguments.
+            #
+            r = KernRe(r'^(\w+)\s+')
+            if r.search(prototype):
+                return_type = ''
+                declaration_name = r.group(1)
+                func_macro = True
+                found = True
 
         # Yes, this truly is vile.  We are looking for:
         # 1. Return type (may be nothing if we're looking at a macro)
@@ -968,19 +978,10 @@ class KernelDoc:
         # parenthesis.
         #
         proto_args = r'\(([^\(]*|.*)\)'
-
-        found = False
-
-        if is_define_proto:
-            r = KernRe(r'^(' + name + r')\s+')
-
-            if r.search(prototype):
-                return_type = ''
-                declaration_name = r.group(1)
-                func_macro = True
-
-                found = True
-
+        #
+        # (Except for the simple macro case) attempt to split up the prototype
+        # in the various ways we understand.
+        #
         if not found:
             patterns = [
                 rf'^()({name})\s*{proto_args}',
@@ -990,16 +991,12 @@ class KernelDoc:
 
             for p in patterns:
                 r = KernRe(p)
-
                 if r.match(prototype):
-
                     return_type = r.group(1)
                     declaration_name = r.group(2)
                     args = r.group(3)
-
                     self.create_parameter_list(ln, decl_type, args, ',',
                                                declaration_name)
-
                     found = True
                     break
         if not found:
-- 
2.51.0


