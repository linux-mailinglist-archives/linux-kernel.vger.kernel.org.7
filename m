Return-Path: <linux-kernel+bounces-726638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623BAB00FB4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E745D4A8976
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A70307AF9;
	Thu, 10 Jul 2025 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="KzoIrpeb"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE462E6135;
	Thu, 10 Jul 2025 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190317; cv=none; b=b7aglSHf0BqlAwoVYpCwcZNNZDsoW+d7f7q+ObntYOhIX4VRceOYVEBVyPDejsY8V0nefButsu+8H0/9a8sXd6bkbzi6/AKFut8JJ2M0XgpSO+2cFJT6wcT379dgvqq7Mpl4URAcoMhVKAct1bIp7XRL7p2vlJKWwRTtNxbZeh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190317; c=relaxed/simple;
	bh=CEmS+NvjxQazKvv4Mw4nPnbu5aQTJLiBK7thQk03xT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWMo+UBNLp+nH9L7k3EuVYO/kI4vZg4+G2I+WRjoBvAPCzzKm7CBI0W6hxEz21Eg0jvnlj2ASSz87Xlwutc1ExZv60FP5KuOK35BflWu3KRz709gDyV1WeVyyZl6ir8PziH3Aq2goaoVWg3O2PS/L8GdqES9C2c4Nz4Zm2HNrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=KzoIrpeb; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 87BA440AB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752190315; bh=gJHOkXvIy/8jemb/jqaH5LGkDKd+1dRGQTpjc5JSSAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzoIrpebGgZl2QLNpShvFrJYvjEAS4R816JrXXK7eWlKRSxEmdVpAukxZok5fGnXU
	 AscqaAoY8PVEY8vS6ZL++Q30JyGfz75jeSlGtknMAFz+Q+67DCpqgz6CzY9d178Om/
	 eqM/XlyB7+tqIe0TDGyy9MeC5H3PKIDus5oyLiKlbeFB01Pj8Ajq5UbysIg6KJJxpe
	 6h5rqc/1Q4/L3S3zg9lj1JlWntHJL0ytqErhouyXpK/oB0QexYcXHJ70UQ2vFoHIxB
	 +nhZ7cNNPoLIyHNtJaX5mQHXYvRhQ7PoW3bqbP2BBTZ7RAGqruQF/K9bCnlI6cIQFH
	 o781Jgi092beQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 87BA440AB5;
	Thu, 10 Jul 2025 23:31:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 06/12] docs: kdoc: use self.entry.parameterlist directly in check_sections()
Date: Thu, 10 Jul 2025 17:31:36 -0600
Message-ID: <20250710233142.246524-7-corbet@lwn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710233142.246524-1-corbet@lwn.net>
References: <20250710233142.246524-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of check_sections() join parameterlist into a single string, which
is then immediately split back into the original list.  Rather than do all
that, just use parameterlist directly in check_sections().

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index b28f056365cb..ffd49f9395ae 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -476,19 +476,18 @@ class KernelDoc:
                         self.push_parameter(ln, decl_type, param, dtype,
                                             arg, declaration_name)
 
-    def check_sections(self, ln, decl_name, decl_type, sectcheck, prmscheck):
+    def check_sections(self, ln, decl_name, decl_type, sectcheck):
         """
         Check for errors inside sections, emitting warnings if not found
         parameters are described.
         """
 
         sects = sectcheck.split()
-        prms = prmscheck.split()
 
         for sx in range(len(sects)):                  # pylint: disable=C0200
             err = True
-            for px in range(len(prms)):               # pylint: disable=C0200
-                if prms[px] == sects[sx]:
+            for param in self.entry.parameterlist:
+                if param == sects[sx]:
                     err = False
                     break
 
@@ -753,8 +752,7 @@ class KernelDoc:
 
         self.create_parameter_list(ln, decl_type, members, ';',
                                    declaration_name)
-        self.check_sections(ln, declaration_name, decl_type,
-                            self.entry.sectcheck, ' '.join(self.entry.parameterlist))
+        self.check_sections(ln, declaration_name, decl_type, self.entry.sectcheck)
 
         # Adjust declaration for better display
         declaration = KernRe(r'([\{;])').sub(r'\1\n', declaration)
@@ -1032,9 +1030,7 @@ class KernelDoc:
                           f"expecting prototype for {self.entry.identifier}(). Prototype was for {declaration_name}() instead")
             return
 
-        prms = " ".join(self.entry.parameterlist)
-        self.check_sections(ln, declaration_name, "function",
-                            self.entry.sectcheck, prms)
+        self.check_sections(ln, declaration_name, "function", self.entry.sectcheck)
 
         self.check_return_section(ln, declaration_name, return_type)
 
-- 
2.49.0


