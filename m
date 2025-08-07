Return-Path: <linux-kernel+bounces-759533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEA9B1DEBC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54EF582B2F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EFD274678;
	Thu,  7 Aug 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kF0kF6fj"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28725744D;
	Thu,  7 Aug 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601419; cv=none; b=T8rM0rAAi37FwSE7lKb/bpNi+BItUskQ6jsxAvnHgh0/3U9qULURC/ewrn+auARul8SfI7tsFfep+LjizgHb1YPS68HHCnYZ68pkhE64RkukCUsrl8cFA9xu8+sLowNk1K69eX3xyEv+js6aQnW1WFP1EAEx+louWsQrJTrPuyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601419; c=relaxed/simple;
	bh=U6Cdb2UXHVXgM89ENeSInYghrH/875aBHDVu+2iR/ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWuF/dSba7ZPNKianBPixFFh0uKVt8tQ7m8CAcKJH0ZgcmLcdpuQhcYGKSSM8dSvyOma99/H8Zcdq1RefxzMsL6wN8N+DXNwJ6T20Y30bcSuBnDSWKLF2VaAZLvu98DJe2Svn2BXw9wHKQ9fgAUvmiK+BRXVqMg1N3yQHmdTHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kF0kF6fj; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CDB5940AEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754601412; bh=gWMBuOVlujIfTt07LRrVZBm2bcVGPhHFFpzO0WwZ40w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kF0kF6fjwrshWeKR2jxa7d/6do1K8tCf+hcsvTdTQVbcxfzAg+S6+BOXNzs95TTNa
	 ppcj5m7uy6UtWhSexRDDQBWB9jQposU6+GPBcoNWxmM8EjJp9BspoOfDv3SrEHYLTT
	 4BlIIMGSMpxGOHrUQVIqWjUUJcp5XOwftvBNuodevf+JEmF5lgGtUF7QB15NYqcTma
	 buniifLCSBLfC3A23y4LmKPHcluvzXBA6MJxEE83o0cmN+uxuiY5MRTPqPGVxaugSn
	 fzU2OhYH0CDeCH16LNTI+EgRmll1XvngZu96FnsWZX85k6aCN8qkE7hRXhE3itnvFA
	 Vi9xV4V6unVwg==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id CDB5940AEC;
	Thu,  7 Aug 2025 21:16:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 05/12] docs: kdoc: split top-level prototype parsing out of dump_struct()
Date: Thu,  7 Aug 2025 15:16:32 -0600
Message-ID: <20250807211639.47286-6-corbet@lwn.net>
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

Move the initial split of the prototype into its own function in the
ongoing effort to cut dump_struct() down to size.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 43 +++++++++++++++------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 3d007d200da6..ab896dcd9572 100644
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
@@ -638,34 +636,33 @@ class KernelDoc:
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
         #
         # Go through the list of members applying all of our transformations.
@@ -695,7 +692,7 @@ class KernelDoc:
         # So, we need to have an extra loop on Python to override such
         # re limitation.
 
-        struct_members = KernRe(type_pattern + r'([^\{\};]+)(\{)([^\{\}]*)(\})([^\{\};]*)(;)')
+        struct_members = KernRe(r'(struct|union)([^\{\};]+)(\{)([^\{\}]*)(\})([^\{\};]*)(;)')
         while True:
             tuples = struct_members.findall(members)
             if not tuples:
-- 
2.50.1


