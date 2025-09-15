Return-Path: <linux-kernel+bounces-817162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F19B57EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1A6205295
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D244320A11;
	Mon, 15 Sep 2025 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PlegFgvH"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877931E10D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945708; cv=none; b=W3Ceoekg0nYj4z4F8PePDeGyyuXExjWXHS2GxThubpTkqZIvG7vfK/WUxPArxhBCRmRTlCzNlQ7ZaHDb3Orolj1IsT1ymD5qwcngqEc2KX9jQ1+2nfW5vkpv6JWxOoHOGkraJx5qEtgJD/JQ8Whd0QUnZGAN+PlE4amvlWgXzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945708; c=relaxed/simple;
	bh=XRiNYief/IEvSm/SxnJ3REEILG4WjhTmot/8iaoEjG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFxNUX3brgvudWxZR3xfdzF40AdQPI7i9vRcaHm86chVNLfkhOXArb+M5JQpkNDc4iRfWx4ZjF1FTAD4sFxVyQPixyS4OgkUoddCx7KAjSGUQUM4uuTuo4pnKlpZVh8fmkrUquaH3F6q6rtVODjyDPc0zs/t4gh5AWJJ9mE20YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PlegFgvH; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757945703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=azrrm5X17by/tgEO5KTP64W2twBn0KTK7kQ1jsx7wZM=;
	b=PlegFgvHf9oDdS/L7LfCJFj2C11mm8tTCiWUD0AWcBJwQOiUcnEDSWFJnc4WzqHW3vWUrq
	H/yKybeHwWaa2DzP+oc66OQ/SWXW5nmFy6Jf0JgdyHh9ieva1B96xe3oavnYJc2+WnI2/w
	S9Qv1vXoh+rR4F/MTJ84H3htEIkAySg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: 
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] init: Replace simple_strtoul with kstrtoul to improve lpj_setup
Date: Mon, 15 Sep 2025 16:14:15 +0200
Message-ID: <20250915141418.2364826-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace simple_strtoul() with the recommended kstrtoul() for parsing the
'lpj=' boot parameter.

Check the return value of kstrtoul() and reject invalid values. This
adds error handling while preserving existing behavior for valid values,
and removes use of the deprecated simple_strtoul() helper.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 init/calibrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/calibrate.c b/init/calibrate.c
index f3831272f113..09c2e6102110 100644
--- a/init/calibrate.c
+++ b/init/calibrate.c
@@ -14,10 +14,10 @@
 
 unsigned long lpj_fine;
 unsigned long preset_lpj;
+
 static int __init lpj_setup(char *str)
 {
-	preset_lpj = simple_strtoul(str,NULL,0);
-	return 1;
+	return kstrtoul(str, 0, &preset_lpj) == 0;
 }
 
 __setup("lpj=", lpj_setup);
-- 
2.51.0


