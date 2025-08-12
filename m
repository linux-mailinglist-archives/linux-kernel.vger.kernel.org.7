Return-Path: <linux-kernel+bounces-765520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9450FB23971
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138C758761A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7BD307AF8;
	Tue, 12 Aug 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JzKI3t2g"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EA02FFDD7;
	Tue, 12 Aug 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028682; cv=none; b=lzIFx84mB4Kfrm6cX3xkl8AnD1lDoNprRbPv9dLL05j95AGhO9B9JqdPuCW+HZBuPxGNx08nqBRq34GTFrw9omMYxGYqvU81g5utBg99ymIjI4zYAm9rGpcc65eYaMK+7cMi3tlme3yOiwXL/vv+Xwijw320eI73AcsUQPNP2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028682; c=relaxed/simple;
	bh=V1IDGL8cFlZaKVSCaLX9tbLB7CYsTMuCCYHx4ufoRas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LH6GXJRjH4b+d+uO6r5uZ33ng3hAEy3maBWFmR75ee2qGibYqVlUi8+jnlSnvHGcFGoZl6HHuirUKnEVITHMq8VoHSK99o9BttOofX63dnQdk2DZK1SaWg+khfJhK+wAiMz5SnaQtll6BBn78VAY35xQE0rP38ev04L2IUZL98E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=JzKI3t2g; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B058440AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755028680; bh=yqlFTUjm2yToir6qAqz3bh+1fa6rWAIvKLsj0oc3CbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JzKI3t2gzK0r6gGqKxFPeaCEynl348Bs1JwlWWCPdZWwzzENerdsIlaO1jmUF52+N
	 KoIa27SBFLt9oiz+J/2Xej68v8HvQzm3bgxO+RdfyKJ/BY5/h20b76kg9iTHZYdXPc
	 ++R9EdI99xkUxjFtWJN7/gKyfIjPqUlIHwEc3KhAgjrOcUUJINC1BGqdjpdY6W90Kw
	 sQrVPT3wqsXisvC/RQMUfGO1CY8ENYJqYAi52/aVXZA06z9DDRSXXFKJfKzPRqKGAy
	 UixzQ0qXrWBtZ1hYuvQiir0KewLFWSp3+R+VBAV4m/bYmtSwkTyU9pk3dqZzQyWTBd
	 Fk0tP6UW/URoQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id B058440AB4;
	Tue, 12 Aug 2025 19:57:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5/7] docs: kdoc: tighten up the array-of-pointers case
Date: Tue, 12 Aug 2025 13:57:46 -0600
Message-ID: <20250812195748.124402-6-corbet@lwn.net>
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

Simplify one gnarly regex and remove another altogether; add a comment
describing what is going on.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 36c4035343dc..d7fb79a64487 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -527,23 +527,19 @@ class KernelDoc:
                 dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
                 self.push_parameter(ln, decl_type, param, dtype,
                                     arg, declaration_name)
-
+            #
+            # The array-of-pointers case.  Dig the parameter name out from the middle
+            # of the declaration.
+            #
             elif KernRe(r'\(.+\)\s*\[').search(arg):
-                # Array-of-pointers
-
-                arg = arg.replace('#', ',')
-                r = KernRe(r'[^\(]+\(\s*\*\s*([\w\[\].]*?)\s*(\s*\[\s*[\w]+\s*\]\s*)*\)')
+                r = KernRe(r'[^\(]+\(\s*\*\s*' r'([\w.]*?)' r'\s*(\[\s*\w+\s*\]\s*)*\)')
                 if r.match(arg):
                     param = r.group(1)
                 else:
                     self.emit_msg(ln, f"Invalid param: {arg}")
                     param = arg
-
-                dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
-
-                self.push_parameter(ln, decl_type, param, dtype,
-                                    arg, declaration_name)
-
+                dtype = arg.replace(param, '')
+                self.push_parameter(ln, decl_type, param, dtype, arg, declaration_name)
             elif arg:
                 #
                 # Clean up extraneous spaces and split the string at commas; the first
-- 
2.50.1


