Return-Path: <linux-kernel+bounces-829310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22635B96C25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8663518A8872
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137452F6198;
	Tue, 23 Sep 2025 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="KdyLdjmg"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7592E1F01
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643752; cv=none; b=RrRJm+cKkwLFJlp6P6At0oMuZ7J4I3Ju0oa9XZBdTYmox6GFA40Lvp96jOk1Zuz5OYqKBaCT6pPG/9m6Ut0tTRgnGU8VGbTOE8nN7iYTHzd+95nkKMQLrurcq4hU5y8kTzotETISQ7ak0M3fhv06QxFuxJ23Hd1EFa0GUGNRHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643752; c=relaxed/simple;
	bh=DY/Ofcn/Ow8r+LCBGOumGnV6d/7pc2frhjwOPeU7DJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaBkkngjkXubMURPeAa+SrFqkDrLe1djkjTUEZqK3jCGGuTgxEKXP1flST/5nzqDfJLYMmrhbZHpsMveGIDS0pFFxpXl/SM/7uyB4YoYoI5W9y8TDqL+ftYb1JAx3bF8DZ2JyBhxsePg3OCCmSJ1MYQZJ8ITvqpKwDuIjveQ91s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=KdyLdjmg; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=YXITm8DEAzGdardV/rwB/49K9rMVAUg6IGseVbSkN+U=; b=KdyLdjmg7bs8ftzQi7VcHMjS+B
	d436hzdTJdbT1ntJ3V3AqbsrtY9bC1/Aay21ZyhbJsz5z2oSLmdS7CDRzoOzwKZOk6l2qYhVRFy5O
	BiG5wciEWmyEU3cG0tNUiyRfQBYRrVY5ptGs4QviqkHc9Y9RpXrHo9xCclYawqoHXKo2A2dor2VE9
	OyiTEN8RAdZwRVHnJYhKUTJYm+nz4c9IcBOyJs/q+nXcR0UOf240kqqX86uEQRrBm6tGlbso8hOkA
	M9y2qXDPQSVelQigEDbw3l7fAfMX+2PbR1soHUhIWV8ybTzMsYIv5PXMguZz9zamgqPNfb8jAdpwb
	2//lnDEA==;
Received: from i53875a1e.versanet.de ([83.135.90.30] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v15Zj-0004vp-DZ; Tue, 23 Sep 2025 18:09:07 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH 3/4] mfd: qnap-mcu: Move checksum verification to its own function
Date: Tue, 23 Sep 2025 18:08:52 +0200
Message-ID: <20250923160853.1925674-4-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250923160853.1925674-1-heiko@sntech.de>
References: <20250923160853.1925674-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll need the checksum check in a second place in the future, so
move the verification code to a separate function.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/qnap-mcu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index b4b630f7d413..cd836bdd44a8 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -78,6 +78,13 @@ static u8 qnap_mcu_csum(const u8 *buf, size_t size)
 	return csum;
 }
 
+static bool qnap_mcu_verify_checksum(const u8 *buf, size_t size)
+{
+	u8 crc = qnap_mcu_csum(buf, size - QNAP_MCU_CHECKSUM_SIZE);
+
+	return crc == buf[size - QNAP_MCU_CHECKSUM_SIZE];
+}
+
 static int qnap_mcu_write(struct qnap_mcu *mcu, const u8 *data, u8 data_size)
 {
 	unsigned char tx[QNAP_MCU_TX_BUFFER_SIZE];
@@ -150,7 +157,6 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 	size_t length = reply_data_size + QNAP_MCU_CHECKSUM_SIZE;
 	struct qnap_mcu_reply *reply = &mcu->reply;
 	int ret = 0;
-	u8 crc;
 
 	if (length > sizeof(rx)) {
 		dev_err(&mcu->serdev->dev, "expected data too big for receive buffer");
@@ -175,8 +181,7 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 		return -ETIMEDOUT;
 	}
 
-	crc = qnap_mcu_csum(rx, reply->received - QNAP_MCU_CHECKSUM_SIZE);
-	if (crc != rx[reply->received - QNAP_MCU_CHECKSUM_SIZE]) {
+	if (!qnap_mcu_verify_checksum(rx, reply->received)) {
 		dev_err(&mcu->serdev->dev, "Invalid Checksum received\n");
 		return -EPROTO;
 	}
-- 
2.47.2


