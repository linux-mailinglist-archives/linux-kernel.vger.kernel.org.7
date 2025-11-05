Return-Path: <linux-kernel+bounces-887512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 030BAC3866A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE2DF4F154A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29C42F7ACC;
	Wed,  5 Nov 2025 23:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="gpi5MKkn"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820872F6190
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386436; cv=none; b=IfTwbmKKM0mhm9RvBVWn+upvOXu+YM2+c/3RBiiiWzTMs+jKSqVIHDgrLbGmAjWX0Y2iEuRJns14IyoDW00n2PofEh5Qy/02ThQBQOIF+aeZ77bUwAU3VB/EEdZqWakcTxITnvhN9QbSr3Qb2ALKzQCdeePI+uG/6gKSXl73AAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386436; c=relaxed/simple;
	bh=N+Ft/PmrtbS1c2vl4AHC6AfYZVStrjBDS5Fxlyfgs08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJZCwAyuCnxwkIQtiBu/2wsPdJ7zNuy/ZFWQ31o02GOBqZu8IKE22dLexBo6/eqX2sUbxr+UREjB0eU/FnH9MRbeRn7NcIi5fHbE0eeRjfU7PwotJHY17CAESPvvRLmIrEEVtOq2sEB+byiqMR1Uoa3V79F/az9cM4Fq6lzGpDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=gpi5MKkn; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=nQYxBu/Q09Up2UjAV3Yg5ScyfmPTkQa5TKMKUGdESZo=; b=gpi5MKknn+gBrL08zj1SqDIH4z
	sw9TovzN3H0DL3Yl+yxAgJpmVa3fytRNsrfDBxFtx+eiIUcs7ASIVpTs6tRyznwZ16lgR+l7AsVcf
	zyXi1DMm+9W6/wVlOhTLqeM29MawaTFw+D80dF0KOWX7hNk+8wlqAIzsNbwkiJ4f/GtWf8vJUaOsY
	f5pgCZg0eCm9lE0DJUZrQOrrPWXqAFEo/Q3HeCK/wAXAGhw8leEVtCxr0f/7Myzi31Lw7D7MeicSa
	mnJ3YZahsG+5KZ1tcFf7uwCexkizWXGrlylTt5GnGvGL6IE0dlxhW036Py3U+2dqtDm0e2tMgA0x8
	90cRcvhg==;
Received: from i53875bde.versanet.de ([83.135.91.222] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vGnDb-0001Oh-Ey; Thu, 06 Nov 2025 00:47:11 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v2 2/4] mfd: qnap-mcu: Use EPROTO in stead of EIO on checksum errors
Date: Thu,  6 Nov 2025 00:47:02 +0100
Message-ID: <20251105234704.159381-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251105234704.159381-1-heiko@sntech.de>
References: <20251105234704.159381-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EPROTO stands for protocol error and a lot of driver already use it
to designate errors in the sent or received data from a peripheral.

So use it in the qnap-mcu as well for checksum errors.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/qnap-mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index e3210541ec56..b4b630f7d413 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -178,7 +178,7 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 	crc = qnap_mcu_csum(rx, reply->received - QNAP_MCU_CHECKSUM_SIZE);
 	if (crc != rx[reply->received - QNAP_MCU_CHECKSUM_SIZE]) {
 		dev_err(&mcu->serdev->dev, "Invalid Checksum received\n");
-		return -EIO;
+		return -EPROTO;
 	}
 
 	memcpy(reply_data, rx, reply_data_size);
-- 
2.47.2


