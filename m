Return-Path: <linux-kernel+bounces-808996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4239B50745
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C99B4E7CF2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC067362081;
	Tue,  9 Sep 2025 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LQ6qP+qV"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21963570DE;
	Tue,  9 Sep 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450650; cv=none; b=WEGSkQUpcMvDZrWg7LdKHsK1RzLCcEpqszZrlPDWblzyqi72vcZSd5U4StJ6ziACWImDkXb6HYtrZWMHRnXy+nLIfhB1uH8TurKsYF8KzFac1OKSCC3Nwbh+6eP9iiMu0OJnSz9awJKtLaePc0Yh32ZYvpxyPv4neRTqeWRlfH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450650; c=relaxed/simple;
	bh=dVnTN1ZB9rHPPAewB8+4/hp3Yefxvz9mJGdD6N6SVug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgmrPS020pKPGhQFx8LvQPnvl75yk+/nWq/DcmfY4XcMm112Q70YdNxkiTHKI6RENqr00puEN1CYgH6VYjRlSEUQNXBwPyz97WsNREFQqO3YeZqicz4hn/GhWv2BUJD4cidKOJ5X4GV1SjTcap6oej/a42dcWzrjJG2OayLiT84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=LQ6qP+qV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E929040B0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757450648; bh=sM6yLOmeT9VY//fAZZjmTl/NENsjERpuU/z8WGNUlX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQ6qP+qVfIbSYkiF0OaPwO5KNComZUR/Ijspw5tPp7L6EWMPb5GPzLgKQEyH0aJWh
	 QUi7d/tesaKFAIVf7LURUNAWu/VTzwpjvBpKxjiSr718HGp1WDBESKcvrZ8H5idSJE
	 atcUzkxqBqBlIqDvS71ibv43Z6i44WrlV77VAzc+F+UcAC+6Whh414Rj8uOA6mWJ0K
	 iqtaPDpczEW3QsN7ioSI81/SOWjUEN8Ia0KhDBgdgRNEwsX5lv3MOGupt246/Us+BB
	 ZMNMoD+yIcToVBmKK2ex1k2WJyFCRzXvKz0Ix6AlS5gEz4crY63Y2VbYSoNPm9jhIX
	 uaRoOrcpvItfw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id E929040B0D;
	Tue,  9 Sep 2025 20:44:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 04/13] docs: kdoc: move the function transform patterns out of dump_function()
Date: Tue,  9 Sep 2025 14:43:40 -0600
Message-ID: <20250909204349.123680-5-corbet@lwn.net>
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

Move these definitions to file level, where they are executed once, and
don't clutter the function itself.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 78 +++++++++++++++------------------
 1 file changed, 35 insertions(+), 43 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index b25c8d80b965..37811cddd55c 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -161,6 +161,37 @@ struct_nested_prefixes = [
     (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
 ]
 
+#
+# Transforms for function prototypes
+#
+function_xforms  = [
+    (r"^static +", "", 0),
+    (r"^extern +", "", 0),
+    (r"^asmlinkage +", "", 0),
+    (r"^inline +", "", 0),
+    (r"^__inline__ +", "", 0),
+    (r"^__inline +", "", 0),
+    (r"^__always_inline +", "", 0),
+    (r"^noinline +", "", 0),
+    (r"^__FORTIFY_INLINE +", "", 0),
+    (r"__init +", "", 0),
+    (r"__init_or_module +", "", 0),
+    (r"__deprecated +", "", 0),
+    (r"__flatten +", "", 0),
+    (r"__meminit +", "", 0),
+    (r"__must_check +", "", 0),
+    (r"__weak +", "", 0),
+    (r"__sched +", "", 0),
+    (r"_noprof", "", 0),
+    (r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +", "", 0),
+    (r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +", "", 0),
+    (r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +", "", 0),
+    (r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)", r"\1, \2", 0),
+    (r"__attribute_const__ +", "", 0),
+    (r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+", "", 0),
+]
+
+
 
 #
 # A little helper to get rid of excess white space
@@ -894,49 +925,10 @@ class KernelDoc:
         return_type = ''
         decl_type = 'function'
 
-        # Prefixes that would be removed
-        sub_prefixes = [
-            (r"^static +", "", 0),
-            (r"^extern +", "", 0),
-            (r"^asmlinkage +", "", 0),
-            (r"^inline +", "", 0),
-            (r"^__inline__ +", "", 0),
-            (r"^__inline +", "", 0),
-            (r"^__always_inline +", "", 0),
-            (r"^noinline +", "", 0),
-            (r"^__FORTIFY_INLINE +", "", 0),
-            (r"__init +", "", 0),
-            (r"__init_or_module +", "", 0),
-            (r"__deprecated +", "", 0),
-            (r"__flatten +", "", 0),
-            (r"__meminit +", "", 0),
-            (r"__must_check +", "", 0),
-            (r"__weak +", "", 0),
-            (r"__sched +", "", 0),
-            (r"_noprof", "", 0),
-            (r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +", "", 0),
-            (r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +", "", 0),
-            (r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +", "", 0),
-            (r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)", r"\1, \2", 0),
-            (r"__attribute_const__ +", "", 0),
-
-            # It seems that Python support for re.X is broken:
-            # At least for me (Python 3.13), this didn't work
-#            (r"""
-#              __attribute__\s*\(\(
-#                (?:
-#                    [\w\s]+          # attribute name
-#                    (?:\([^)]*\))?   # attribute arguments
-#                    \s*,?            # optional comma at the end
-#                )+
-#              \)\)\s+
-#             """, "", re.X),
-
-            # So, remove whitespaces and comments from it
-            (r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+", "", 0),
-        ]
-
-        for search, sub, flags in sub_prefixes:
+        #
+        # Apply the initial transformations.
+        #
+        for search, sub, flags in function_xforms:
             prototype = KernRe(search, flags).sub(sub, prototype)
 
         # Macros are a special case, as they change the prototype format
-- 
2.51.0


