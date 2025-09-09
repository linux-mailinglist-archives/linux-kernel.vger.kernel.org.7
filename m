Return-Path: <linux-kernel+bounces-809005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F979B50754
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04774E8807
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91612362086;
	Tue,  9 Sep 2025 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XYHmQAjw"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793EF36C069;
	Tue,  9 Sep 2025 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450655; cv=none; b=a8D9kho4Kh90HVH/yVb3jyngDqwtwotfboGcTbDvhjqLDKY3Q+InD7yEm9h/Srb2UJaa5o+yZS+B9E5tu7vPifGPFpHfwyRc7GTdziMSSbqgi9uW8ZkZ/kqkTOHn67GSZlwbT4Djl3ILQ+b1NkLwif2Buf1BT5KLjBWCajng+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450655; c=relaxed/simple;
	bh=NMocIPZH9YYVlYA4WELxtNVYiL1e4gKHtr7tQenrv4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=diOtomOL+f7NjTybU2lJcttVyLq9AEC4OlFd13jI97LWuAH/hyWLo6K2fmZvQVgqa/4s300vi5gerOaPsvxsNdLJvcA/mxI95qZOcOVQJaBxm2UUrA7Me+0vPLIPf2fN/hqdOjm9owISfioSlb7p50TT4H/1yeBC+vWRarqQbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XYHmQAjw; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CBD3B40B0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757450653; bh=hBEi+Apqy84zf44aihUNbWI24oug2rNRLrGTbbRP7Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYHmQAjwL4G9TmRkRFLn87fPqkxQRM88ByOmFfPoxivzGTGCZGSqPCriDiXHJH8h0
	 vzZv80QmmSImn/fxVtpm3qOTY+8pI5Di/IkruFjuCCibltxsvesD1UsmVHtIA8duZX
	 ZNC47z6N4mR2jDd4HAmRJWS9rUfCeVw0qm0Jgp79CPdIESp9gvR/O4HyKblKF4D/9J
	 tLyruu6A4yjJjNV6BXSR7bgl9s11p5l5kwBDRdRfKGoAC4ylA2EUtv6CZZvWU2A915
	 w1kW77RHHYZfURqw1ZaVR4/P1o5+tX4OtRmkJ7G5QIFWsbbFLgigpgJ9eO9mlHtR0x
	 eK/wmhuQYfsXA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id CBD3B40B0A;
	Tue,  9 Sep 2025 20:44:12 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 13/13] docs: kdoc: a few more dump_typedef() tweaks
Date: Tue,  9 Sep 2025 14:43:49 -0600
Message-ID: <20250909204349.123680-14-corbet@lwn.net>
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

Merge "typedef" into the typedef_type pattern rather than repeating it
later, and add some comments.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index ad9df0536bbf..8215948dd548 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -1026,13 +1026,15 @@ class KernelDoc:
         """
         Stores a typedef inside self.entries array.
         """
-
-        typedef_type = r'((?:\s+[\w*]+\b){0,7}\s+(?:\w+\b|\*+))\s*'
+        #
+        # We start by looking for function typedefs.
+        #
+        typedef_type = r'typedef((?:\s+[\w*]+\b){0,7}\s+(?:\w+\b|\*+))\s*'
         typedef_ident = r'\*?\s*(\w\S+)\s*'
         typedef_args = r'\s*\((.*)\);'
 
-        typedef1 = KernRe(r'typedef' + typedef_type + r'\(' + typedef_ident + r'\)' + typedef_args)
-        typedef2 = KernRe(r'typedef' + typedef_type + typedef_ident + typedef_args)
+        typedef1 = KernRe(typedef_type + r'\(' + typedef_ident + r'\)' + typedef_args)
+        typedef2 = KernRe(typedef_type + typedef_ident + typedef_args)
 
         # Parse function typedef prototypes
         for r in [typedef1, typedef2]:
@@ -1048,16 +1050,16 @@ class KernelDoc:
                               f"expecting prototype for typedef {self.entry.identifier}. Prototype was for typedef {declaration_name} instead\n")
                 return
 
-            decl_type = 'function'
-            self.create_parameter_list(ln, decl_type, args, ',', declaration_name)
+            self.create_parameter_list(ln, 'function',_type, args, ',', declaration_name)
 
-            self.output_declaration(decl_type, declaration_name,
+            self.output_declaration('function', declaration_name,
                                     typedef=True,
                                     functiontype=return_type,
                                     purpose=self.entry.declaration_purpose)
             return
-
-        # Parse simple typedefs
+        #
+        # Not a function, try to parse a simple typedef.
+        #
         r = KernRe(r'typedef.*\s+(\w+)\s*;')
         if r.match(proto):
             declaration_name = r.group(1)
-- 
2.51.0


