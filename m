Return-Path: <linux-kernel+bounces-752751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77350B17A7C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646C85A36E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357CD4CB5B;
	Fri,  1 Aug 2025 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ep9y+nvM"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EF18F49;
	Fri,  1 Aug 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007225; cv=none; b=CDeU4BP8jesYJDfNVr7dxhipKc/VJ1Kzx5AKGohOdrCpjaNFiiy2FX0jMS0GdUuiCYy4qAA0kMLvMKBGhJ/NvYVdlUxyd9SenpheR3YmPfDZMMsAvFReY8cPAchN5w/ABnSRam074/W6/sHiYlLlsOYROarFdByz8qPW2QC8zWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007225; c=relaxed/simple;
	bh=zMNGkKDVtrQYR1g6zgUl8wLnLKe4Yun+oWNyM5XI148=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5v6/mhqjUI9V13g1VXffCa17dBKF7NtoTHkNk67+sCXotzNqXN/O/7vtafeckhu0oRcQ8sBdmNsczxmv76vHdqikjsHlsrHh/VxBQ7khsk1dFLmNdHiOYSs73UUmLn1czRr8qQQKjtjtwDFk7m5jzVmfULSTMx9LY5ik16U25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Ep9y+nvM; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 635CD40AEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754007217; bh=Mq7zonfROPmRJEB1Vu+YlKjYMNVLogYxufUGthhqAMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ep9y+nvMg4DP2tYtX47Zdh//cOTkLUXRGZjNabtX+LXM4divpOWoucShqG0ssjYyB
	 VVtMx6ydPIJG9ruvjPRjfLPZaT/0hvnSvlNyGNU3hd51QTklrVpbxhfECszz1/oQ1s
	 GxYbwDxrqa0YRXg3HEg0BfP6EX6MqeJRh0h15H2X+xbg3JutfWwjKYAyD9VSWeWFJb
	 FAWCs6tOOKv6fKWoK9cEqfiP8mY6tz/aGiBhZMhAgJiVLtScZ5loD4k77yXZPAljXk
	 KCNMdyE7wiOdpTAvSdV6l9QPSRxxfv0d0ID2V5uPKMkOTakdYjpQUvwQo2OR7m+z6t
	 vOFbeLgv/X2PQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 635CD40AEA;
	Fri,  1 Aug 2025 00:13:37 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 05/12] docs: kdoc: split top-level prototype parsing out of dump_struct()
Date: Thu, 31 Jul 2025 18:13:19 -0600
Message-ID: <20250801001326.924276-6-corbet@lwn.net>
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

Move the initial split of the prototype into its own function in the
ongoing effort to cut dump_struct() down to size.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 44 +++++++++++++++------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 5e375318df9c..2bb0da22048f 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -624,13 +624,11 @@ class KernelDoc:
             self.emit_msg(ln,
                           f"No description found for return value of '{declaration_name}'")
 
-    def dump_struct(self, ln, proto):
-        """
-        Store an entry for an struct or union
-        """
-
+    #
+    # Split apart a structure prototype; returns (struct|union, name, members) or None
+    #
+    def split_struct_proto(self, proto):
         type_pattern = r'(struct|union)'
-
         qualifiers = [
             "__attribute__",
             "__packed",
@@ -638,36 +636,34 @@ class KernelDoc:
             "____cacheline_aligned_in_smp",
             "____cacheline_aligned",
         ]
-
         definition_body = r'\{(.*)\}\s*' + "(?:" + '|'.join(qualifiers) + ")?"
 
-        # Extract struct/union definition
-        members = None
-        declaration_name = None
-        decl_type = None
-
         r = KernRe(type_pattern + r'\s+(\w+)\s*' + definition_body)
         if r.search(proto):
-            decl_type = r.group(1)
-            declaration_name = r.group(2)
-            members = r.group(3)
+            return (r.group(1), r.group(2), r.group(3))
         else:
             r = KernRe(r'typedef\s+' + type_pattern + r'\s*' + definition_body + r'\s*(\w+)\s*;')
-
             if r.search(proto):
-                decl_type = r.group(1)
-                declaration_name = r.group(3)
-                members = r.group(2)
+                return (r.group(1), r.group(3), r.group(2))
+        return None
 
-        if not members:
+    def dump_struct(self, ln, proto):
+        """
+        Store an entry for an struct or union
+        """
+        #
+        # Do the basic parse to get the pieces of the declaration.
+        #
+        struct_parts = self.split_struct_proto(proto)
+        if not struct_parts:
             self.emit_msg(ln, f"{proto} error: Cannot parse struct or union!")
             return
+        decl_type, declaration_name, members = struct_parts
 
         if self.entry.identifier != declaration_name:
-            self.emit_msg(ln,
-                          f"expecting prototype for {decl_type} {self.entry.identifier}. Prototype was for {decl_type} {declaration_name} instead\n")
+            self.emit_msg(ln, f"expecting prototype for {decl_type} {self.entry.identifier}. "
+                          f"Prototype was for {decl_type} {declaration_name} instead\n")
             return
-
         #
         # Go through the list of members applying all of our transformations.
         #
@@ -696,7 +692,7 @@ class KernelDoc:
         # So, we need to have an extra loop on Python to override such
         # re limitation.
 
-        struct_members = KernRe(type_pattern + r'([^{};]+)(\{)([^{}]*)(\})([^{};]*)(;)')
+        struct_members = KernRe(r'(struct|union)([^{};]+)(\{)([^{}]*)(\})([^{};]*)(;)')
         while True:
             tuples = struct_members.findall(members)
             if not tuples:
-- 
2.50.1


