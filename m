Return-Path: <linux-kernel+bounces-752755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A725B17A83
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C525A0DCC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A92157A6B;
	Fri,  1 Aug 2025 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RvE1tyyv"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D0979FE;
	Fri,  1 Aug 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007226; cv=none; b=YHn1jMK/5369qcUAvfdk9LkIyaJRPfk+Ly2fOicOPQOaBrsKcF5CSMXjlDPKm557oyW3AaDUu7nqpIDcaI/CazsoNaeuvLFDQ0ggq5LCsS2qwZhzJ9mLwBN96gHfs2Iz5DnytQ52resd1dbz5mufSJ81qzMFrPAq53T0FgHGD+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007226; c=relaxed/simple;
	bh=nSu3sd4zO5fsEW54GGSTyH9Gaz2ZPGqxpG/A+jYGb10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnPRrP2OyLx+pqZaE7RjkvWesSSpxBufS8y8fSpVKMLWtI28poxuq8BM2jUG5ho9wAs0r6tA1uN69NgsKxMi4wxCH4RYmiUtb2qLNPXMSL4dCPMl/TdWP0JJ9NfXk8gXOxHPRnjq46OKE9So0OudUuBAtSigBU4eBSIjcG7ZaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RvE1tyyv; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 00F7F40AEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754007218; bh=GZtVIHs+qGS2JnvOEqLwKgsnB7hdteAAz8AZ24kN6ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvE1tyyv6fx+NbE5qmJStYIVmysXNqVwNphIV9teMslYegDY3atbh/TKX+n7PTwpL
	 VXOMQPF7LI50qzGcDV+ENfvbB7yJzA5+0RXWhygX9QewdapCKoBFmPRqZ72zo0rfbu
	 hxUd4bv63fj0M4z1MiTooLY3QeFpDM9kf8juICoAxWy2F1YfIwOFzZexyIjwMHAcWH
	 Yg1BITWSp+QVitbVPE3JzANtDoyREx7GURuicHZQzylA5XAKJrnLT1erGoQMk5nw0G
	 0cP/MBOCOs7uT0vg7oR64MRK85hXN7ywo/oxE5WcnERXve4wByzq4K0Il9StW8gyfQ
	 nP9XNmp5kWuFQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 00F7F40AEB;
	Fri,  1 Aug 2025 00:13:37 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 06/12] docs: kdoc: split struct-member rewriting out of dump_struct()
Date: Thu, 31 Jul 2025 18:13:20 -0600
Message-ID: <20250801001326.924276-7-corbet@lwn.net>
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

The massive loop that massages struct members shares no data with the rest
of dump_struct(); split it out into its own function.  Code movement only,
no other changes.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 65 +++++++++++++++++----------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 2bb0da22048f..5c4ad8febb9f 100644
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


