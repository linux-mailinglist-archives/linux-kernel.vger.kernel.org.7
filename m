Return-Path: <linux-kernel+bounces-759530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A823B1DEB5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94ED5581E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23CC9478;
	Thu,  7 Aug 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="K2CSc4BP"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB324886C;
	Thu,  7 Aug 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601418; cv=none; b=fVlLd4KtnLpF8Xfiq6WuhPaM93l3zD0NcBsP2nYPsCtQDFuYrDwevKi/OAXOz2NWJP2AUuGn3lk42an9LYOKwP7yYgrsCR+uhisYFMh04GvQ1e/IrUYsJKRcU5QkAjWcqRSR/by9J+NSCKbdyd08g5fOngtVY0C8KLefHjcnEwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601418; c=relaxed/simple;
	bh=hVmO1mXfYScEIC9DCreeKf4cE/D+CuTSXXgUR9zbjAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDmBxsZ61iRfzxopKB5pvOs9W5Idiy5sDtQRTp7Yqi9HpRFG5V/pqSYroX9zXFjZMv5FxXViMEvIvXTQ8Xwmwn1I10w4rsrRxbjjoEAirlUDPhpC6Ovc98r51cZ6Qib/1aI9rKC3M3TUCKRQBJUqhAE+0/I01QN9dIogfZ5x7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=K2CSc4BP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A2A0B40AD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754601410; bh=rHWEDvv2LL6zewZlA89rUn/FMk+/6JqzsmSk7xj66XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K2CSc4BP9+fe9N9Xh+xNfEf8wL/V1wCVbp2bpT5v9I3fKLcgfDp9egwoA4BXmT1Am
	 9qVxiginp2ulT5vxe2pLfhLMydHlo2cpE3wkTe1xHYP5ojxGU/EboPRgHqsAV190fH
	 e1r/gI/elSBm4hXfN+nk2vPAiFCgT6XxXvV5w4os2dG+HQgIqx2a0iEDV1jblFbnuU
	 9QyoHlMe/ctSJL+I1E/BjvkuB8/kGvBGTiBOM0rMGrNk44oeya4mV4nQfGQTQAECVS
	 znbEnL5EAa306fDThdJjJL8rnHujVF8LWpKFpfQmB6xLNff15GDlJjCzBmgMMhvrpq
	 6zzUrLvEQqU0g==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id A2A0B40AD9;
	Thu,  7 Aug 2025 21:16:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 01/12] docs: kdoc: consolidate the stripping of private struct/union members
Date: Thu,  7 Aug 2025 15:16:28 -0600
Message-ID: <20250807211639.47286-2-corbet@lwn.net>
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

There were two locations duplicating the logic of stripping private members
and associated comments; coalesce them into one, and add some comments
describing what's going on.

Output change: we now no longer add extraneous white space around macro
definitions.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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


