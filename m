Return-Path: <linux-kernel+bounces-759534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A076B1DEC0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EE218963DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CAD2749D5;
	Thu,  7 Aug 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="GH/rzsIw"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D91525B1C7;
	Thu,  7 Aug 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601419; cv=none; b=IdhHK/quoueskSaeg2a31uIpJhKtydeSSb/io7vM+7YuRPHxNP20afmBWCxZDILz7B/s6SJRQC/Y3MSIAY53JOimxrYt82XQuKDJJa0MzxH+cPZsnyfgjhV4Wy3TiH11t4IT2XuJSoPwfWC2k5jBXx6vVxlprxscnVx1EDnaAQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601419; c=relaxed/simple;
	bh=OttkNfFB3rq2l5lDSJzL3TNmcfpJs1eRTZkzGTeq7EI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sw+L20Gc3cOeGW5YPUQUOh1k5D3OyATrZbzzOcmHVyVfp90CzhJwAKqRB0woSXthx4XaM1DYR+t9zxtJKLb8sZmkUzAe2+8owSj+Vtrszlm6V2/pz+sOkIbL4e4tUJJl0X7PIpqaXc8OYR3rWSrBBUsesmvleRogi2bzpSwXoSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=GH/rzsIw; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 77D7740AF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754601413; bh=H8s0gCkWKetxbMm7vsp83FemoWM7FDJeSxCXej5rgdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GH/rzsIwbC6u7ZDqo7DkLt8VZWI+mIsW9Wt4E7xLTtkGi+ALS1Xyk0StMjC/Tfp49
	 xIOVHUWG/l0ENwXR3gwu+T3+Bj5k7NCsO4sn/GqLIdabiTcF9rBifsv7sPJFM7P1YK
	 PREpC/JcCB1q/6ng1mwx4ztXWpCmGRq3lSN5JsgZ1gKPsrxryPImCu0kwe1kDzrrlS
	 WGVgE01chxiCJU4giRU7VUBwrqZeL5G0GlKFHdqd/5/PT7lMKiMkIL/3uCfxzuJIgx
	 cwzVqNrurGmcKrLzpj9zT9Riejm+6icIcse+x1pwPhpfMsIJtmUk0ChCh1ElTwTLPj
	 4SI75AjX+GVjA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 77D7740AF0;
	Thu,  7 Aug 2025 21:16:53 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 08/12] docs: kdoc: remove an extraneous strip() call
Date: Thu,  7 Aug 2025 15:16:35 -0600
Message-ID: <20250807211639.47286-9-corbet@lwn.net>
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

...the variable in question was already strip()ed at the top of the loop.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index e11f3d6e9469..0c279aa802a0 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -703,7 +703,6 @@ class KernelDoc:
                                 newmember += f"{dtype}{s_id}.{name}{extra}; "
 
                         else:
-                            arg = arg.strip()
                             # Handle bitmaps
                             arg = KernRe(r':\s*\d+\s*').sub('', arg)
 
-- 
2.50.1


