Return-Path: <linux-kernel+bounces-726641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95184B00FBC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE7A760E93
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53299309DC0;
	Thu, 10 Jul 2025 23:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="sIvIcwYa"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CEF307AD8;
	Thu, 10 Jul 2025 23:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190319; cv=none; b=abs4fAePfofRCJZU/EEwa0OzCdxiz5yw4b1YAibd2ihy9jqtz2XTk2gu66x0F1mS5J/gmqr96KJUu+Vt/26/o9HiXtam8jE3DGKl+VbWic/6ZmreElcCXxf1A/d8+3bMTM06n1GHfP2oXRIUZnaYRjm8rAhv3bAH47iG721VPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190319; c=relaxed/simple;
	bh=tbOvNdFwAz7DluAs34x2f5JXEIHvMZMO8z4scT0/uo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwmjwb6oIemaISKx/1JJmoFGNwpB4tiK9cjwLpL8Avtqb01jTJa30dJ2lp1D+qatCo873vjQ0ILXFuAh4TKOCuDtAuecomW66vAXSRv1Q9W0gry1y2MQPxtq/L31y0cNjcoxkdD7Fz506zvhPqlDwnjAIkJfxGButLvVwqZObQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=sIvIcwYa; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2151840ADF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752190317; bh=lmv2UYWelgqU/j6Ln6KNIN6Kr5IxIFH4NLkcLWXjSok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIvIcwYao7Imeozm411KCWZU3FKPNJdDjwX9UClTDdPL6rA0a3QCqaf3iiC66DWtZ
	 zkecHwmgclVn0kufbQHM0w8vfBUsL7jzWk49UqM38pGaWiLh48XOsRKedSPSbXbSCq
	 u+2WpYv4b2GfPf2rj5G4xe+I2tXTkqS/mLzFxXQlUqCjqlijVwZZ5j/r/8raXJ+gRe
	 nWqKyrp7c/LHSF8NuMYR8ZUqm3uitT695x+7Oi0JvwQwbxA8TlU0lfDCUsuDIYUJrE
	 jaOEg1PyWLNXkCnr8pZX1Mzih0ziFcR8LLPE/YeiJzLVlcyL1mAoLs4mC/nd4R3gWZ
	 YiUZuXsUrGJQQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 2151840ADF;
	Thu, 10 Jul 2025 23:31:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 09/12] docs: kdoc: straighten up dump_declaration()
Date: Thu, 10 Jul 2025 17:31:39 -0600
Message-ID: <20250710233142.246524-10-corbet@lwn.net>
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

Get rid of the excess "return" statements in dump_declaration(), along with
a line of never-executed dead code.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 6e35e508608b..7191fa94e17a 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -878,18 +878,13 @@ class KernelDoc:
 
         if self.entry.decl_type == "enum":
             self.dump_enum(ln, prototype)
-            return
-
-        if self.entry.decl_type == "typedef":
+        elif self.entry.decl_type == "typedef":
             self.dump_typedef(ln, prototype)
-            return
-
-        if self.entry.decl_type in ["union", "struct"]:
+        elif self.entry.decl_type in ["union", "struct"]:
             self.dump_struct(ln, prototype)
-            return
-
-        self.output_declaration(self.entry.decl_type, prototype,
-                                entry=self.entry)
+        else:
+            # This would be a bug
+            self.emit_message(ln, f'Unknown declaration type: {self.entry.decl_type}')
 
     def dump_function(self, ln, prototype):
         """
-- 
2.49.0


