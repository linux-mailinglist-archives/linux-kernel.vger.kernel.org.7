Return-Path: <linux-kernel+bounces-808997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B41EB5074B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15074E776A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6063680BB;
	Tue,  9 Sep 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SFvkvOdf"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A1F35CEAC;
	Tue,  9 Sep 2025 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450650; cv=none; b=GO6U5634Fq5ATzypSqOhvPfPqGMkm3TKfl0i7wQjHcw1InGNNzHk+UitS7rCgUfCQoDAV631DJPVK/2vzxnFFPtknkyDoEEI5tXVrSErlgr1L6ML9r+tJS6dt8jouliH3uFFrTMxlUcgqv7XB7oePKMeVQtcTfblzP62lD7GIzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450650; c=relaxed/simple;
	bh=8coTWkl2AD9BkrxfhklAw1gUBG+qTo7VVyeQr2YqZKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jj3Ro0NVbk4V07Y9U1jDiznuiHokhl4Aidwi+Ff+13M8XIdJT8o82wtEblTLgRBGoWXFE5vidsjyAKRTTsq8iF+Gf/8/GQQD+sckvrxyaIWT9D23piVQlamUuMqnoR6qzQxCwKbjd3YPoHpk+bqeUHxFXTabQSoHzOuXV1eGqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SFvkvOdf; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 76BC440B0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757450648; bh=sWYJLRDobwyVmZeD8KxFPOinWqMDBv8Qm6wdf5j2Djc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFvkvOdf+m3mAWC77VKDK6Nss1wHfFsKtLXMY5jY36fuLUG8Gg71gH+8RI3Bo1G7b
	 Vz6IX9QHgWMgkEv06nuUfT/P+jLxbhecSdc4NGgABDBE46n2GdezLNtMkoGT3K5YCZ
	 YrYn5nkdH+ImLKxGeU/MNKKUWEsMvM9cCe7PpM0+sjKtLXwnYAPFxl3VMdsCB/GLVy
	 ZWBpdD6WKGfaiMDAvVL+I72u5gd/ZiScyRNjT5Py+taMdkpW7j0lxdnnaaAuOZlXhg
	 b89bUgPGcG3bMsCxXtw00/zp4uM2/Bcg5HfcA8Ss8NO31aEI3Y3Tc89kZOEQp96gTH
	 xggveqxuO9lXA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 76BC440B0E;
	Tue,  9 Sep 2025 20:44:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 05/13] doc: kdoc: unify transform handling
Date: Tue,  9 Sep 2025 14:43:41 -0600
Message-ID: <20250909204349.123680-6-corbet@lwn.net>
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

Both functions and structs are passed through a set of regex-based
transforms, but the two were structured differently, despite being the same
thing.  Create a utility function to apply transformations and use it in
both cases.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 65 +++++++++++++++++----------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 37811cddd55c..1a1558211acd 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -78,7 +78,7 @@ doc_begin_func = KernRe(str(doc_com) +			# initial " * '
 #
 struct_args_pattern = r'([^,)]+)'
 
-struct_prefixes = [
+struct_xforms = [
     # Strip attributes
     (KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)", flags=re.I | re.S, cache=False), ' '),
     (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
@@ -165,33 +165,39 @@ struct_nested_prefixes = [
 # Transforms for function prototypes
 #
 function_xforms  = [
-    (r"^static +", "", 0),
-    (r"^extern +", "", 0),
-    (r"^asmlinkage +", "", 0),
-    (r"^inline +", "", 0),
-    (r"^__inline__ +", "", 0),
-    (r"^__inline +", "", 0),
-    (r"^__always_inline +", "", 0),
-    (r"^noinline +", "", 0),
-    (r"^__FORTIFY_INLINE +", "", 0),
-    (r"__init +", "", 0),
-    (r"__init_or_module +", "", 0),
-    (r"__deprecated +", "", 0),
-    (r"__flatten +", "", 0),
-    (r"__meminit +", "", 0),
-    (r"__must_check +", "", 0),
-    (r"__weak +", "", 0),
-    (r"__sched +", "", 0),
-    (r"_noprof", "", 0),
-    (r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +", "", 0),
-    (r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +", "", 0),
-    (r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +", "", 0),
-    (r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)", r"\1, \2", 0),
-    (r"__attribute_const__ +", "", 0),
-    (r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+", "", 0),
+    (KernRe(r"^static +"), ""),
+    (KernRe(r"^extern +"), ""),
+    (KernRe(r"^asmlinkage +"), ""),
+    (KernRe(r"^inline +"), ""),
+    (KernRe(r"^__inline__ +"), ""),
+    (KernRe(r"^__inline +"), ""),
+    (KernRe(r"^__always_inline +"), ""),
+    (KernRe(r"^noinline +"), ""),
+    (KernRe(r"^__FORTIFY_INLINE +"), ""),
+    (KernRe(r"__init +"), ""),
+    (KernRe(r"__init_or_module +"), ""),
+    (KernRe(r"__deprecated +"), ""),
+    (KernRe(r"__flatten +"), ""),
+    (KernRe(r"__meminit +"), ""),
+    (KernRe(r"__must_check +"), ""),
+    (KernRe(r"__weak +"), ""),
+    (KernRe(r"__sched +"), ""),
+    (KernRe(r"_noprof"), ""),
+    (KernRe(r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +"), ""),
+    (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
+    (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
+    (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
+    (KernRe(r"__attribute_const__ +"), ""),
+    (KernRe(r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+"), ""),
 ]
 
-
+#
+# Apply a set of transforms to a block of text.
+#
+def apply_transforms(xforms, text):
+    for search, subst in xforms:
+        text = search.sub(subst, text)
+    return text
 
 #
 # A little helper to get rid of excess white space
@@ -807,8 +813,7 @@ class KernelDoc:
         # Go through the list of members applying all of our transformations.
         #
         members = trim_private_members(members)
-        for search, sub in struct_prefixes:
-            members = search.sub(sub, members)
+        members = apply_transforms(struct_xforms, members)
 
         nested = NestedMatch()
         for search, sub in struct_nested_prefixes:
@@ -924,12 +929,10 @@ class KernelDoc:
         func_macro = False
         return_type = ''
         decl_type = 'function'
-
         #
         # Apply the initial transformations.
         #
-        for search, sub, flags in function_xforms:
-            prototype = KernRe(search, flags).sub(sub, prototype)
+        prototype = apply_transforms(function_xforms, prototype)
 
         # Macros are a special case, as they change the prototype format
         new_proto = KernRe(r"^#\s*define\s+").sub("", prototype)
-- 
2.51.0


