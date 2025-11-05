Return-Path: <linux-kernel+bounces-887510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7431BC3866D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961261A21E52
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35B12F6902;
	Wed,  5 Nov 2025 23:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="iYBwEYxf"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820022F618B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386435; cv=none; b=XQuGE32ZqVwaJ9Out8dYUAUZZQ3te7sloXyj95CijoaLA1OohB+6vcEiTeXi6Z4o1hKqPZ4Z3FwLD5AsjdojtMec3TrRYTD0a7LpPSKygCO/fxvnM5FbiieHDuJBpJyta86MV1UveBjly+xkHyymAxDYl1N/KirMQp16MXBMMHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386435; c=relaxed/simple;
	bh=DY/Ofcn/Ow8r+LCBGOumGnV6d/7pc2frhjwOPeU7DJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3rVpI2vY5QEdlDt//91p3wX8AQ3zdXg4Kkkw28p/zJU67gef2BJ5/hEM9kZcukW9+SURmCqO64qkOPt8Q6p2QvJQMC7cFbIxgKcJq1wfW4blvANHpuTOKE2vmnMzjWKm8HeUdj/7XToT6gavx6V6snbt6mNFRTngVUHiu8mecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=iYBwEYxf; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=YXITm8DEAzGdardV/rwB/49K9rMVAUg6IGseVbSkN+U=; b=iYBwEYxftn0bFpTj0tc/lu2Wa4
	N9lUbPwBf5Po5yNqu3bZI0YyvlJ6xyQ8wR6AriFOPJ1ZDsvgPTpgXmgmSG5e5PDakjYjpuhz1XbbD
	ISy/69nRD1isrbmbBH8j/pehOfnJE9mVjEcyLfMZfqKlomZHNkqY4o7m9MzNEuimGeaS+8H3kZSvR
	ZqVTzlLWhOOO7QrvNcorVFjQr2go5DwGN76EUgyPW+D6rdQ0nl1/I4wycHpcX/vDz1e1tNvJzMuAZ
	gqEGJE4l0pc9iI564oZID9MRG+llX3U3cb/tNElzWJgdX076Ze06vmQqfWXEssn6HY/JneORJYco+
	hVTUHvpw==;
Received: from i53875bde.versanet.de ([83.135.91.222] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vGnDb-0001Oh-OD; Thu, 06 Nov 2025 00:47:11 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v2 3/4] mfd: qnap-mcu: Move checksum verification to its own function
Date: Thu,  6 Nov 2025 00:47:03 +0100
Message-ID: <20251105234704.159381-4-heiko@sntech.de>
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


