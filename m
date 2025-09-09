Return-Path: <linux-kernel+bounces-809000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51ACB5074D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5186E4E8796
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0103136997E;
	Tue,  9 Sep 2025 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YKcO3g1D"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0614362086;
	Tue,  9 Sep 2025 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450652; cv=none; b=Gs7Id/Cwxmpzxckh5l/iALSKCY5/xKVgsJ0iWvmE2LOGpy8fv3qjluZp89Y9YGD5bb2jm2iF7/eLtoUwlGsDJakYOrTRKX0ru/MHQ13ahFVC5Mq9k9Y/vGdvhNksnadAd7RZzuCDUtOUY4qRQ1MvJBEqfb2J41gcz6lecGAS5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450652; c=relaxed/simple;
	bh=Pbi97irdb+l3J3vafjWQ+be7jYpu3PYYTrbjHKpYHO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrqsHg/NbN+EgoqN75BCliXqK9Xa1S5R9M3wBbAXIvqRa9k/Va7K0JqCpBlmcXQDG0aZ4kqnNH7wqfk+ChnlyLWjpJrHNZ4Nn4PPN8oAtwE2OyEsJG98NYRqNVQy6ZiusjPFDfFkasWG1T+RjlZSXdDy1foxGjHz2/M1b+7Jx9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YKcO3g1D; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 22FBA40B0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757450650; bh=hgUN8fgcYskEUVklIECVzi6lK3ek6ekWW59of72+uww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKcO3g1DgUm9nQUuhWN30ENfXQah4k0j9mFkpzgHNpCLYWcW4DIcZCSRTkgbk8ugi
	 x4MPcDm3/fJsKGCBtw1qEU8WtzOwjKCn08aTECYPlgA2aG6/auCGIXiUYciRSINOAg
	 pUwSlgYepyCito34ScDEYsJSHLYIcTkSQn+aaYgUXrsi840Qz7nscslS6hY6kUDFma
	 YeM9SfWrTCPLzgr3wmQoXGZd9tUbXQMKSG1UppZsWAA+qqF0BdLZ1JKe6Sdw0ImYcg
	 NZtp5daZrnMdYWJ8X8uzPbFi1c/wSM13Dm+uL5DFpbYrhgjPZ/EZZPZkaHPAsK3mkl
	 QUfDMDLP3aP1w==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 22FBA40B0A;
	Tue,  9 Sep 2025 20:44:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 08/13] docs: kdoc: Simplify the dump_function() prototype regexes
Date: Tue,  9 Sep 2025 14:43:44 -0600
Message-ID: <20250909204349.123680-9-corbet@lwn.net>
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

The regexes for the parsing of function prototypes were more complicated
than they needed to be and difficult to understand -- at least, I spent a
fair amount of time bashing my head against them.  Simplify them, and add
some documentation comments as well.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index f9be5414244d..ec2e6e83df05 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -959,15 +959,15 @@ class KernelDoc:
         # - pci_match_device, __copy_to_user (long return type)
 
         name = r'\w+'
-        prototype_end1 = r'[^\(]*'
-        prototype_end2 = r'[^\{]*'
-        prototype_end = fr'\(({prototype_end1}|{prototype_end2})\)'
-
-        # Besides compiling, Perl qr{[\w\s]+} works as a non-capturing group.
-        # So, this needs to be mapped in Python with (?:...)? or (?:...)+
-
         type1 = r'(?:[\w\s]+)?'
         type2 = r'(?:[\w\s]+\*+)+'
+        #
+        # Attempt to match first on (args) with no internal parentheses; this
+        # lets us easily filter out __acquires() and other post-args stuff.  If
+        # that fails, just grab the rest of the line to the last closing
+        # parenthesis.
+        #
+        proto_args = r'\(([^\(]*|.*)\)'
 
         found = False
 
@@ -983,9 +983,9 @@ class KernelDoc:
 
         if not found:
             patterns = [
-                rf'^()({name})\s*{prototype_end}',
-                rf'^({type1})\s+({name})\s*{prototype_end}',
-                rf'^({type2})\s*({name})\s*{prototype_end}',
+                rf'^()({name})\s*{proto_args}',
+                rf'^({type1})\s+({name})\s*{proto_args}',
+                rf'^({type2})\s*({name})\s*{proto_args}',
             ]
 
             for p in patterns:
-- 
2.51.0


