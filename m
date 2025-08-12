Return-Path: <linux-kernel+bounces-765521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCBEB23973
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821FA563B83
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BE030AAC9;
	Tue, 12 Aug 2025 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="quTH9lIp"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C382FFDEC;
	Tue, 12 Aug 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028682; cv=none; b=jKjqREXghJ5ZdnDjIuV73zlTKsfEKQF2dZZrQ8m7Yer6c2QYQ7W2X3PqlV8106znQe9NhutSe/PoGegr23VurZZ+CmnAGgJPJLVTqbpPsUDbM7G240MIYlrEwBlHqKlrFHSCvEEgYK300Z0eW0rqDoC7FwI1Y+ryU9Fpi3Ai75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028682; c=relaxed/simple;
	bh=C6Q02unUU5uqvZL2/9uc58UlOCZiLYQ1uBvC+Z6nOh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7g/9r3jrfF8l/xcvT/BkxaPWWErnZYbiGxdKEASJjukeHFh4RRwY9yP9TEZ9egojZIPN9UdLZe1kDRTORwa7t4sbRj8lUA1wz9C80LftCimgw7XHQpTawsjKhEa81XlZTzEgwECK+wx+kBSJk4jZiJVglI4iQuOuyCX3L7qif8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=quTH9lIp; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3C79C40ADC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755028680; bh=P3NYcSVz8WaB2qHPWOisuFhEeyE7SQzDs3q7Nm4jogs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=quTH9lIpyBYJz2j3gx2Hq68BaKtaNwLyEpVfasrMHKrlvPJ7L8znrYD9ntiZABqQT
	 vBTBxYklWeb78aa8aX0Gq4aGIdneZq4uus8ESXaujDI54jjSCw9gYuNT2b87ZWBUtS
	 aRf5XIMiomB4LOO9kiPKPLfmV680sY/sVobvqmJRCC5KtysZabPdOwW5HxGa40CTjs
	 AGKoBMyButowQk0Z1Oszad9tv7w26uoEDCJSs6rpkqrsBzE96qTwkYo1KDGumBluZh
	 GXn8X3BtB+l90bqR6Ca/9lC8suz4bX07AuQwp9KyIo//kFg2DginsQDHJDUkFOxD7K
	 F74sm6lvuJE7Q==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 3C79C40ADC;
	Tue, 12 Aug 2025 19:58:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 6/7] docs: kdoc: tighten up the pointer-to-function case
Date: Tue, 12 Aug 2025 13:57:47 -0600
Message-ID: <20250812195748.124402-7-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812195748.124402-1-corbet@lwn.net>
References: <20250812195748.124402-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tighten up the code and remove an unneeded regex operation.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index d7fb79a64487..ceb38b59fb4c 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -511,22 +511,19 @@ class KernelDoc:
                 # Treat preprocessor directive as a typeless variable
                 self.push_parameter(ln, decl_type, arg, "",
                                     "", declaration_name)
-
+            #
+            # The pointer-to-function case.
+            #
             elif KernRe(r'\(.+\)\s*\(').search(arg):
-                # Pointer-to-function
-
                 arg = arg.replace('#', ',')
-
-                r = KernRe(r'[^\(]+\(\*?\s*([\w\[\].]*)\s*\)')
+                r = KernRe(r'[^\(]+\(\*?\s*' r'([\w\[\].]*)' r'\s*\)')
                 if r.match(arg):
                     param = r.group(1)
                 else:
                     self.emit_msg(ln, f"Invalid param: {arg}")
                     param = arg
-
-                dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
-                self.push_parameter(ln, decl_type, param, dtype,
-                                    arg, declaration_name)
+                dtype = arg.replace(param, '')
+                self.push_parameter(ln, decl_type, param, dtype, arg, declaration_name)
             #
             # The array-of-pointers case.  Dig the parameter name out from the middle
             # of the declaration.
-- 
2.50.1


