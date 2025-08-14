Return-Path: <linux-kernel+bounces-769216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2315AB26B69
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A7A1CE5D34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A268A2FABFD;
	Thu, 14 Aug 2025 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MB0B/k2E"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC0E23D280;
	Thu, 14 Aug 2025 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186050; cv=none; b=M+oJsiCBqoEoU3IjKRgMy08l6VjAqZyCJoB4I1WB3BnJbOhBA9q/8sUYeVGW9A2/RPN5rjLLgmY6eJlFu9H9kusPykuVtfoO80AruiWSL8iVUA5EwqchiZkcSPqjp4GPudQy31f8miQDBhLQja+cZRdq+9t+ijNlyJVi/pPSDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186050; c=relaxed/simple;
	bh=Oqps/HN0376Z+iO1VnPfvkXyHaLfOktPPOgMRRe0TJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fKmwR20DQAskvCd3gesKh5H7JYO7RKL8d1Gbu8gc6pBlQacYR9Wco3Aw4fIjqQKIsu81j1IT4/891pyLaXGGmhAmpn7fVCHjz4JmPaU7bdcorTGiT6okZiDM2+rGDpE2jvxZYfZPC3T63Xi+57DGtKKvOmFvk99BEpIrSpFF00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=MB0B/k2E; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5A72640AF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755186048; bh=2INnb41BXqyj8VwmOeb4ftIjMI1ezvVXAMGWOSxv3Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MB0B/k2EAOVGmWbrtM+WpnwHy18Q7cSbNVCxyDUJpNQkQ8DaOdSVO45+0ZMGWw18r
	 oxuiJfXLmhXTlBKLl6B0tsiJCgz3ZzFlbGVaRBRral+c+RiCzsxe33XVpLe+ZVlz/n
	 CzMnowm395WWD2BUUF5Sd7sve6e3JeFYLuN2RZ2q1BkhNQztofFydGTnYasx363IlE
	 4fRLR2uHvvFHTaUwtJiQNmU736CrlZzwJodIR1R82VWFoB/+214WbxOy63o2kPhvm+
	 0KWXqcdC4ZVhHlvF/fLj7TY+kpFlBrN/eX+x9H7twTzY7idU1gjRJVPtEtZ41x7QD8
	 SzFkmniGg09kw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 5A72640AF4;
	Thu, 14 Aug 2025 15:40:48 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 6/7] docs: kdoc: tighten up the pointer-to-function case
Date: Thu, 14 Aug 2025 09:40:34 -0600
Message-ID: <20250814154035.328769-7-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814154035.328769-1-corbet@lwn.net>
References: <20250814154035.328769-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tighten up the code and remove an unneeded regex operation.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 7f4d95dd47d4..998b1ece932a 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -511,22 +511,21 @@ class KernelDoc:
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
+                r = KernRe(r'[^\(]+\(\*?\s*'  # Everything up to "(*"
+                           r'([\w\[\].]*)'    # Capture the name and possible [array]
+                           r'\s*\)')	      # Make sure the trailing ")" is there
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


