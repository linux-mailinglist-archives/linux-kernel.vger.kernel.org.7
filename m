Return-Path: <linux-kernel+bounces-808999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C148B50749
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7AC7AD93F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DDE36932A;
	Tue,  9 Sep 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JX4gfELN"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F241362065;
	Tue,  9 Sep 2025 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450651; cv=none; b=ILCA1vbLeTCcXQ80HoUo6Nds9Ftq87GuJ8itydPwDUErsWIl1wVxVopOZzpntt2Aehqk6zCOY0K5a7BSIkh/FDNsFT4v2l9wBC54R/wfC/MfFtf+fD5w2obZiSV0dyZqiYv731GMzi9sVuWpk+6Qfx7ig4u4TUpxEB56oZAbhac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450651; c=relaxed/simple;
	bh=zUbK1eRvQNBcMGzevTG6U8Mg+cORrqJFgihTfL+HD/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mV5kz9t9Kzw3XhSfh/gZXXzFyQ+pTPk3C4bU39JExQ+Gw0WJAYNIbTpacXoEGuXVwgU88sE9f1TkeAeN4rluLz7zqx/gzQ3t1ddhkMEPpYILDcisvAQ8du4ymAmKzc7L5vDZCLXGlxLKoAjVEfQc/zMFdF6vYu2RRAN4A8pwdWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=JX4gfELN; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8E33540AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757450649; bh=mx/+MAve9gRBP77jA9qbgrPKmVOV176WxvHPdldB/Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JX4gfELN3ozI9r9A1SfhiWbP3ILvz0ODqCPECh2advPluTWnENNK3sPP2C7yk+OFN
	 /BngFmxLe3GH4zyERQ7RGWjTf9L9ShKKOQE1U9YtGVB8ynLquZnSfc8iZJbAWTrKwx
	 8vlOvPoRuwquJ0y7/tZ1V9hVOo5HdAdxiU+yJP0n29a+raOB+5fHYZ3D7neuWGLNb1
	 TmH5w1CfzZzgvbc66nXSruXxrdz1GP2cEeXlm224i3vbCQO1pkrZ5J2hFYMhOOx+8/
	 21Pt/BIp5rneQmIbJbFhQOIBxjslpM2iQtEpZbSVwCb1JGkMukTJNvAcr6wCQREbEv
	 XcsiKl5S9fMHg==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 8E33540AF9;
	Tue,  9 Sep 2025 20:44:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 07/13] docs: kdoc: remove a useless empty capture group
Date: Tue,  9 Sep 2025 14:43:43 -0600
Message-ID: <20250909204349.123680-8-corbet@lwn.net>
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

The is_define_proto case in dump_function() uses a regex with an empty
capture group - () - that has no use; just take it out.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index decd127df82e..f9be5414244d 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -972,11 +972,11 @@ class KernelDoc:
         found = False
 
         if is_define_proto:
-            r = KernRe(r'^()(' + name + r')\s+')
+            r = KernRe(r'^(' + name + r')\s+')
 
             if r.search(prototype):
                 return_type = ''
-                declaration_name = r.group(2)
+                declaration_name = r.group(1)
                 func_macro = True
 
                 found = True
-- 
2.51.0


