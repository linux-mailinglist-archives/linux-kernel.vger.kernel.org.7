Return-Path: <linux-kernel+bounces-799388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FECBB42ACD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79677188E80E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E9F362071;
	Wed,  3 Sep 2025 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xalCdJwa"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C75291C19
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931068; cv=none; b=JL3dVyky+6hV3rUDwuUhTnkGdMj4Vrya49HpVXdYXpQMOb//20xRYt/jmzPM0NiCG9lKxLbuI+Pcpj9/iJ8W6IUCP1i12V9AsQLzvlzbDG0nyyTbbZBRO0vAby7UqgkvhpGXMN/bhj99g2UKCLiFlfY8sIMoj+7jPoCMs/Kl+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931068; c=relaxed/simple;
	bh=cm7SdgZgkxtui+GkbchDrYWoPSVeL5/7U+YIDanGUJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L6EDieSrwxSNeocchdERxEKaAs2AiQW6IJwyX4JzjHZOiyAMvkKSE6my/hmexd7Thb90j/QsKyJU5veGdEp1JSzVbCsi9mrTkVpasNCxG9IYNjlI6LkRIXWLpA0g6swJJRl4oXmRmMgER1kLq2G24XafsnUbALJ8A9xleaxNf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xalCdJwa; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756931063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TCVFbIDdqcds7yG8QsnnTOBrtHX7GbG3Sh0owoi1FuA=;
	b=xalCdJwaHZduIr5S7941i7bAnA+YkMAup4FfAMrWVmMxNEPSp8IFxFHkf+6CTeVCKAUKtR
	1y9k6ESQ6SlrT7NMxsJmpuIla2dtZFmhQ/NPjyAQGoNcEaQe8lUNlKH+yOngvqR9B81qcP
	UMm/Tzc7SfierA3Pp6A85QoqYTpEq4Y=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] char/adi: Remove redundant less-than-zero check in adi_write()
Date: Wed,  3 Sep 2025 22:23:51 +0200
Message-ID: <20250903202350.182446-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The function parameter 'size_t count' is unsigned and cannot be less
than zero. Remove the redundant condition.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/char/adi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/adi.c b/drivers/char/adi.c
index f9bec10a6064..4312b0cc391c 100644
--- a/drivers/char/adi.c
+++ b/drivers/char/adi.c
@@ -131,7 +131,7 @@ static ssize_t adi_write(struct file *file, const char __user *buf,
 	ssize_t ret;
 	int i;
 
-	if (count <= 0)
+	if (count == 0)
 		return -EINVAL;
 
 	ver_buf_sz = min_t(size_t, count, MAX_BUF_SZ);
-- 
2.51.0


