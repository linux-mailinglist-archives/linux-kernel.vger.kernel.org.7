Return-Path: <linux-kernel+bounces-759532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E4AB1DEBE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B23620EF9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD0C274677;
	Thu,  7 Aug 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="DLmIb4Rt"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21F256C6F;
	Thu,  7 Aug 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601419; cv=none; b=GhVckDg+hlwyHuksypVQ9OZyZPFJ1c9Uw7bb8Bu6iPOXRhZ3W1GyXzwxRjlrnEthnU8+ZKX1m718BHIntGO/ngkYwXWNOxVHvnfzQsJAkNIeNsHHidLN2udA3td2k3ayedTyjQeHmeBJCIptvBIkKFPtnUFeUzEHP8G2+ts3qWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601419; c=relaxed/simple;
	bh=N5rIVFjF8OXnuuACRtghmEIhy0e0sl7T4fPAn/1yutY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpS7PgHCIFZatpNjTQi6Q7sTCnAKiKZZ1gAiRVHCtc8bT6t+580GHqSeadzti2+zyZZbWpLafpFdUr9VOQboH+KS7NH9kArxrj7T+bPVL2mHHFF7LlCJlgU4+0Ia1sk8m1yjaPHGegFLDdp0fGEq7GIj83BIdfqxHP0nxyS9+4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=DLmIb4Rt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6139240AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754601412; bh=k0raakv8o00nkgtMwQK7Y4tf/xXq67ohe7aQZ0MsAag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLmIb4RtENxOvp0X1oW1VcH8uZxLTWyhr/fkyyjlZBpbhnChX9SKxJ6gKPu9X5swS
	 BNXbp67CgG1otwbYNlEy+ZALYADHzlhFdOVP2vcjWLBHcRht9b4E3hILc7kbdTT9HW
	 8dkYUy+WWQdN0UDq1Cd9yrQ8/Ouzn4zb3G+oF0kfCf0s+DDT3RUTWx8zts4u/NlfDS
	 QZuPmxq7fmmAJQdu3SrnPjvbsygsM2iWE7BphCBIRep5GaJ9iekzra6y0Bm4M+ewiH
	 dxPNTUFdDfO2AgMUhpVhw9wE8Zdch0dVL9jBsi15sCQT3kMNGHCmvMosgm2rG7vDeG
	 aTYFMm0Dq3KbQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 6139240AED;
	Thu,  7 Aug 2025 21:16:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 06/12] docs: kdoc: split struct-member rewriting out of dump_struct()
Date: Thu,  7 Aug 2025 15:16:33 -0600
Message-ID: <20250807211639.47286-7-corbet@lwn.net>
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

The massive loop that massages struct members shares no data with the rest
of dump_struct(); split it out into its own function.  Code movement only,
no other changes.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 65 +++++++++++++++++----------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index ab896dcd9572..fbd7f6ce3360 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -647,37 +647,7 @@ class KernelDoc:
                 return (r.group(1), r.group(3), r.group(2))
         return None
 
-    def dump_struct(self, ln, proto):
-        """
-        Store an entry for an struct or union
-        """
-        #
-        # Do the basic parse to get the pieces of the declaration.
-        #
-        struct_parts = self.split_struct_proto(proto)
-        if not struct_parts:
-            self.emit_msg(ln, f"{proto} error: Cannot parse struct or union!")
-            return
-        decl_type, declaration_name, members = struct_parts
-
-        if self.entry.identifier != declaration_name:
-            self.emit_msg(ln, f"expecting prototype for {decl_type} {self.entry.identifier}. "
-                          f"Prototype was for {decl_type} {declaration_name} instead\n")
-            return
-        #
-        # Go through the list of members applying all of our transformations.
-        #
-        members = trim_private_members(members)
-        for search, sub in struct_prefixes:
-            members = search.sub(sub, members)
-
-        nested = NestedMatch()
-        for search, sub in struct_nested_prefixes:
-            members = nested.sub(search, sub, members)
-
-        # Keeps the original declaration as-is
-        declaration = members
-
+    def rewrite_struct_members(self, members):
         # Split nested struct/union elements
         #
         # This loop was simpler at the original kernel-doc perl version, as
@@ -768,6 +738,39 @@ class KernelDoc:
                                     newmember += f"{dtype} {s_id}.{name}; "
 
                 members = members.replace(oldmember, newmember)
+        return members
+
+    def dump_struct(self, ln, proto):
+        """
+        Store an entry for an struct or union
+        """
+        #
+        # Do the basic parse to get the pieces of the declaration.
+        #
+        struct_parts = self.split_struct_proto(proto)
+        if not struct_parts:
+            self.emit_msg(ln, f"{proto} error: Cannot parse struct or union!")
+            return
+        decl_type, declaration_name, members = struct_parts
+
+        if self.entry.identifier != declaration_name:
+            self.emit_msg(ln, f"expecting prototype for {decl_type} {self.entry.identifier}. "
+                          f"Prototype was for {decl_type} {declaration_name} instead\n")
+            return
+        #
+        # Go through the list of members applying all of our transformations.
+        #
+        members = trim_private_members(members)
+        for search, sub in struct_prefixes:
+            members = search.sub(sub, members)
+
+        nested = NestedMatch()
+        for search, sub in struct_nested_prefixes:
+            members = nested.sub(search, sub, members)
+
+        # Keeps the original declaration as-is
+        declaration = members
+        members = self.rewrite_struct_members(members)
 
         # Ignore other nested elements, like enums
         members = re.sub(r'(\{[^\{\}]*\})', '', members)
-- 
2.50.1


