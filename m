Return-Path: <linux-kernel+bounces-752748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04554B17A73
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21F0624D3A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECBB2E3705;
	Fri,  1 Aug 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rpXoYbcg"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A533C17;
	Fri,  1 Aug 2025 00:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007223; cv=none; b=VupCa2UUU7hRra6JUnIP7lS0d6q1OLD1iHaISJeaxfBhq7TTi5SVod/oPDyhS8L3E6h5fEpNWIam9c0C5gBWwNOIhLh8kO4NOC76DtII80u0MHjZN0jon7/kTiEa2bJudDOp1mCH+GkDurRaCqUDgZe5uUIf8/drPTRoizkxFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007223; c=relaxed/simple;
	bh=WW1zK6X21lvMsWf5X/dyje1CjqFwmnQ4wIE57rzG/jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiPNEa3c6uAvSyO58lWhVEMNooJQG6M2MiDFTr104RF6xZIpW0o2vMoaYUVX7+b7g4c2Q5m9ca0hdGPm4PLqPraYEgUtXdZxZIToMELcfbHDQ370JC6BA/eYbDi4aPdxWhSBNybMkEsnbJw7wfATNDBVP0xq9JYWvvF/FW7qKps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=rpXoYbcg; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3265840ADD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754007215; bh=bAJMNiUlM1zaOfKybMz1uucAVs1vtJChh2CsSykFci4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rpXoYbcguW8yUdKyjphyrDMp93I655rd5yyc959d9GrOP4LKj80F+USfC/AvvSd9l
	 woJgkqQ/Tp59aZwA0/Br8ZsdKRPZ5vbs7Oh7NLDNFCMrXUdQDoGvbOk/qVLM37taRy
	 WCX9W2V1baTTt7x6qdiXBDzu3u9p0nmRYmIZ88gUZA2ReaXLzpCCm+sbuNKQ75fFv/
	 FjBmHgeoyneG3M1rkv0qxh8qCNHn9+uUcouGObu9mnbeSnCWIFCJDgUTM1n1Zs47T0
	 v/l7ddXahPDvI+eVyL7HhbzZhhitAttrO9nXh1RQJlkL7/44Dg+6XxfG0cqdLI39Tl
	 jGHXAmwlBaJHQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 3265840ADD;
	Fri,  1 Aug 2025 00:13:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 01/12] docs: kdoc: consolidate the stripping of private struct/union members
Date: Thu, 31 Jul 2025 18:13:15 -0600
Message-ID: <20250801001326.924276-2-corbet@lwn.net>
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

There were two locations duplicating the logic of stripping private members
and associated comments; coalesce them into one, and add some comments
describing what's going on.

Output change: we now no longer add extraneous white space around macro
definitions.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 40 ++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index c3fe4bd5eab4..93fcd8807aa8 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -81,6 +81,21 @@ multi_space = KernRe(r'\s\s+')
 def trim_whitespace(s):
     return multi_space.sub(' ', s.strip())
 
+#
+# Remove struct/enum members that have been marked "private".
+#
+def trim_private_members(text):
+    #
+    # First look for a "public:" block that ends a private region, then
+    # handle the "private until the end" case.
+    #
+    text = KernRe(r'/\*\s*private:.*?/\*\s*public:.*?\*/', flags=re.S).sub('', text)
+    text = KernRe(r'/\*\s*private:.*', flags=re.S).sub('', text)
+    #
+    # We needed the comments to do the above, but now we can take them out.
+    #
+    return KernRe(r'\s*/\*.*?\*/\s*', flags=re.S).sub('', text).strip()
+
 class state:
     """
     State machine enums
@@ -568,12 +583,6 @@ class KernelDoc:
         args_pattern = r'([^,)]+)'
 
         sub_prefixes = [
-            (KernRe(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', re.S | re.I), ''),
-            (KernRe(r'\/\*\s*private:.*', re.S | re.I), ''),
-
-            # Strip comments
-            (KernRe(r'\/\*.*?\*\/', re.S), ''),
-
             # Strip attributes
             (attribute, ' '),
             (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
@@ -648,6 +657,7 @@ class KernelDoc:
             (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
         ]
 
+        members = trim_private_members(members)
         for search, sub in sub_prefixes:
             members = search.sub(sub, members)
 
@@ -797,24 +807,18 @@ class KernelDoc:
         """
         Stores an enum inside self.entries array.
         """
-
-        # Ignore members marked private
-        proto = KernRe(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', flags=re.S).sub('', proto)
-        proto = KernRe(r'\/\*\s*private:.*}', flags=re.S).sub('}', proto)
-
-        # Strip comments
-        proto = KernRe(r'\/\*.*?\*\/', flags=re.S).sub('', proto)
-
-        # Strip #define macros inside enums
+        #
+        # Strip preprocessor directives.  Note that this depends on the
+        # trailing semicolon we added in process_proto_type().
+        #
         proto = KernRe(r'#\s*((define|ifdef|if)\s+|endif)[^;]*;', flags=re.S).sub('', proto)
-
         #
         # Parse out the name and members of the enum.  Typedef form first.
         #
         r = KernRe(r'typedef\s+enum\s*\{(.*)\}\s*(\w*)\s*;')
         if r.search(proto):
             declaration_name = r.group(2)
-            members = r.group(1).rstrip()
+            members = trim_private_members(r.group(1))
         #
         # Failing that, look for a straight enum
         #
@@ -822,7 +826,7 @@ class KernelDoc:
             r = KernRe(r'enum\s+(\w*)\s*\{(.*)\}')
             if r.match(proto):
                 declaration_name = r.group(1)
-                members = r.group(2).rstrip()
+                members = trim_private_members(r.group(2))
         #
         # OK, this isn't going to work.
         #
-- 
2.50.1


