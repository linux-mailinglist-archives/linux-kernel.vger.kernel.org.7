Return-Path: <linux-kernel+bounces-752754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A879B17A84
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF515A0E35
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A6F16D9BF;
	Fri,  1 Aug 2025 00:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Af4DUZAQ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A01D8F6F;
	Fri,  1 Aug 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007226; cv=none; b=MCrpeVx99jkyMDh77SusxsxXvC8ZqF6jLhKf5h0+FrzmEFao/vQIJep7+dFXcK+xZ7+wDo4To2xSm8QKgRvuWyJL0KJbCtEXaW9qWmW3YXE0keLCsniuEir+pRh9t0J7KN7B2XENk5nIrT7wnFFFmTLPRs4feZfWUTkOyd4bNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007226; c=relaxed/simple;
	bh=QHY5CU7DPP4vg/fuxV4AfA5GvYFe49NXylWjF6I+0eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMzw19pKepQhfGwQBYpNrDWKXhlCL4EI4iEy3GrBYTl/ZY7HASEKcouu0rV0eZgFZwELv5WTOldrEnD06cVcHAIbLjSMi6u9HBxfsbZ7MvmXaWdoJGe/bO2MZeH7YJL+6PCeD4zScN/ZIeU1GPM4KbCoPGj5tcS1qn3Mb55s0tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Af4DUZAQ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D1AAF40AE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754007217; bh=K1rLw1lGMZaw6VPlI0c2e+hxCM9FeMejujw6wy4PgsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Af4DUZAQQJD/H6KDcjSoOXfM8IYABuJKpeIvQVC30XvH4ZO+GPPbnfsfEkFgbW100
	 qBOeY4Erya6pukLLBg2vYJKO1zkv3Petm2aEcMTtx2trDv/SkzQ2TPWnLgI3r0AWuK
	 /rkwbk8nM0iNnmr/MigY4VyFLlIJH3tWDnak2A6MAZ5yUUDajc19GK4UC9xQ7tEBk/
	 6iGD9WcueyPubcB9a5m0+DP31czCyXoAnyjdceXHlW9GiDV0wbwm5q05F8+14HWWvd
	 78CHobWIIMwCrcG0rbTMoawCplXB9rnHoRUkBMHZXTO2w3ac6ya+2VSuo/QtBAHyVE
	 7/VUh9ZvQHS2w==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id D1AAF40AE9;
	Fri,  1 Aug 2025 00:13:36 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 04/12] docs: kdoc: move the prefix transforms out of dump_struct()
Date: Thu, 31 Jul 2025 18:13:18 -0600
Message-ID: <20250801001326.924276-5-corbet@lwn.net>
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

dump_struct is one of the longest functions in the kdoc_parser class,
making it hard to read and reason about.  Move the definition of the prefix
transformations out of the function, join them with the definition of
"attribute" (which was defined at the top of the file but only used here),
and reformat the code slightly for shorter line widths.

Just code movement in the end.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 178 +++++++++++++++++---------------
 1 file changed, 96 insertions(+), 82 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index e1efa65a3480..5e375318df9c 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -54,8 +54,6 @@ doc_inline_start = KernRe(r'^\s*/\*\*\s*$', cache=False)
 doc_inline_sect = KernRe(r'\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)', cache=False)
 doc_inline_end = KernRe(r'^\s*\*/\s*$', cache=False)
 doc_inline_oneline = KernRe(r'^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$', cache=False)
-attribute = KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)",
-               flags=re.I | re.S, cache=False)
 
 export_symbol = KernRe(r'^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*', cache=False)
 export_symbol_ns = KernRe(r'^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*"\S+"\)\s*', cache=False)
@@ -74,6 +72,97 @@ doc_begin_func = KernRe(str(doc_com) +			# initial " * '
                         r'(?:[-:].*)?$',		# description (not captured)
                         cache = False)
 
+#
+# Here begins a long set of transformations to turn structure member prefixes
+# and macro invocations into something we can parse and generate kdoc for.
+#
+struct_attribute = KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)",
+                          flags=re.I | re.S, cache=False)
+struct_args_pattern = r'([^,)]+)'
+
+struct_prefixes = [
+    # Strip attributes
+    (struct_attribute, ' '),
+    (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
+    (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
+    (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
+    (KernRe(r'\s*__packed\s*', re.S), ' '),
+    (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
+    (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
+    (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
+    #
+    # Unwrap struct_group macros based on this definition:
+    # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
+    # which has variants like: struct_group(NAME, MEMBERS...)
+    # Only MEMBERS arguments require documentation.
+    #
+    # Parsing them happens on two steps:
+    #
+    # 1. drop struct group arguments that aren't at MEMBERS,
+    #    storing them as STRUCT_GROUP(MEMBERS)
+    #
+    # 2. remove STRUCT_GROUP() ancillary macro.
+    #
+    # The original logic used to remove STRUCT_GROUP() using an
+    # advanced regex:
+    #
+    #   \bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;
+    #
+    # with two patterns that are incompatible with
+    # Python re module, as it has:
+    #
+    #   - a recursive pattern: (?1)
+    #   - an atomic grouping: (?>...)
+    #
+    # I tried a simpler version: but it didn't work either:
+    #   \bSTRUCT_GROUP\(([^\)]+)\)[^;]*;
+    #
+    # As it doesn't properly match the end parenthesis on some cases.
+    #
+    # So, a better solution was crafted: there's now a NestedMatch
+    # class that ensures that delimiters after a search are properly
+    # matched. So, the implementation to drop STRUCT_GROUP() will be
+    # handled in separate.
+    #
+    (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
+    (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
+    (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
+    (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
+    #
+    # Replace macros
+    #
+    # TODO: use NestedMatch for FOO($1, $2, ...) matches
+    #
+    # it is better to also move those to the NestedMatch logic,
+    # to ensure that parenthesis will be properly matched.
+    #
+    (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^)]+)\)', re.S),
+     r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
+    (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^)]+)\)', re.S),
+     r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
+    (KernRe(r'DECLARE_BITMAP\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
+            re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
+    (KernRe(r'DECLARE_HASHTABLE\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
+            re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
+    (KernRe(r'DECLARE_KFIFO\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern +
+            r',\s*' + struct_args_pattern + r'\)', re.S), r'\2 *\1'),
+    (KernRe(r'DECLARE_KFIFO_PTR\s*\(' + struct_args_pattern + r',\s*' +
+            struct_args_pattern + r'\)', re.S), r'\2 *\1'),
+    (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + struct_args_pattern + r',\s*' +
+            struct_args_pattern + r'\)', re.S), r'\1 \2[]'),
+    (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
+    (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
+]
+#
+# Regexes here are guaranteed to have the end limiter matching
+# the start delimiter. Yet, right now, only one replace group
+# is allowed.
+#
+struct_nested_prefixes = [
+    (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
+]
+
+
 #
 # A little helper to get rid of excess white space
 #
@@ -579,90 +668,15 @@ class KernelDoc:
                           f"expecting prototype for {decl_type} {self.entry.identifier}. Prototype was for {decl_type} {declaration_name} instead\n")
             return
 
-        args_pattern = r'([^,)]+)'
-
-        sub_prefixes = [
-            # Strip attributes
-            (attribute, ' '),
-            (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
-            (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
-            (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
-            (KernRe(r'\s*__packed\s*', re.S), ' '),
-            (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
-            (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
-            (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
-
-            # Unwrap struct_group macros based on this definition:
-            # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
-            # which has variants like: struct_group(NAME, MEMBERS...)
-            # Only MEMBERS arguments require documentation.
-            #
-            # Parsing them happens on two steps:
-            #
-            # 1. drop struct group arguments that aren't at MEMBERS,
-            #    storing them as STRUCT_GROUP(MEMBERS)
-            #
-            # 2. remove STRUCT_GROUP() ancillary macro.
-            #
-            # The original logic used to remove STRUCT_GROUP() using an
-            # advanced regex:
-            #
-            #   \bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;
-            #
-            # with two patterns that are incompatible with
-            # Python re module, as it has:
-            #
-            #   - a recursive pattern: (?1)
-            #   - an atomic grouping: (?>...)
-            #
-            # I tried a simpler version: but it didn't work either:
-            #   \bSTRUCT_GROUP\(([^\)]+)\)[^;]*;
-            #
-            # As it doesn't properly match the end parenthesis on some cases.
-            #
-            # So, a better solution was crafted: there's now a NestedMatch
-            # class that ensures that delimiters after a search are properly
-            # matched. So, the implementation to drop STRUCT_GROUP() will be
-            # handled in separate.
-
-            (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
-            (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
-            (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
-            (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
-
-            # Replace macros
-            #
-            # TODO: use NestedMatch for FOO($1, $2, ...) matches
-            #
-            # it is better to also move those to the NestedMatch logic,
-            # to ensure that parenthesis will be properly matched.
-
-            (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^)]+)\)', re.S), r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
-            (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^)]+)\)', re.S), r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
-            (KernRe(r'DECLARE_BITMAP\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
-            (KernRe(r'DECLARE_HASHTABLE\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
-            (KernRe(r'DECLARE_KFIFO\s*\(' + args_pattern + r',\s*' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\2 *\1'),
-            (KernRe(r'DECLARE_KFIFO_PTR\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\2 *\1'),
-            (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\1 \2[]'),
-            (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + args_pattern + r'\)', re.S), r'dma_addr_t \1'),
-            (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + args_pattern + r'\)', re.S), r'__u32 \1'),
-        ]
-
-        # Regexes here are guaranteed to have the end limiter matching
-        # the start delimiter. Yet, right now, only one replace group
-        # is allowed.
-
-        sub_nested_prefixes = [
-            (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
-        ]
-
+        #
+        # Go through the list of members applying all of our transformations.
+        #
         members = trim_private_members(members)
-        for search, sub in sub_prefixes:
+        for search, sub in struct_prefixes:
             members = search.sub(sub, members)
 
         nested = NestedMatch()
-
-        for search, sub in sub_nested_prefixes:
+        for search, sub in struct_nested_prefixes:
             members = nested.sub(search, sub, members)
 
         # Keeps the original declaration as-is
-- 
2.50.1


