Return-Path: <linux-kernel+bounces-899907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC507C5938A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A50BE541708
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA2D358D39;
	Thu, 13 Nov 2025 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="CQOUZbWU"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D49C3557E7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052747; cv=none; b=QSsg7g8r9/3pwziMnD+IRf8icT89lTWKeVKrD1RLRBtct7quojK/49p6UbC1fW9lOFgB5IAFiQXGIyNJ2mMWLb7S91UkBYo2aLef5bLip0/uMppgwS4qYujB0h5pd/hdsR6I2S+3sXOSoNl6YF445S+81/z8OBgZubggFYV/4vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052747; c=relaxed/simple;
	bh=DY/Ofcn/Ow8r+LCBGOumGnV6d/7pc2frhjwOPeU7DJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kF3rCN+IWq3lhjcXvvvbsp11ObDCRoMK9x32IJ0UNoDIgmeyzL4dToXh4sU1aXjP6hsv6TXT8Wd45mHfZnvgstJWz5U9GvISbeB0HB7b1G+WC7Cd8i1s1nwFd49ANmCPcrEDwkQzoRbSA8kuh17WBKREq3+7dm2pjL2wWUO5pkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=CQOUZbWU; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=YXITm8DEAzGdardV/rwB/49K9rMVAUg6IGseVbSkN+U=; b=CQOUZbWU5pJXyk6xboN3VKCqPS
	63gizcWI8JkiXIkZVcehdHJeVPbIbLrjhtmK2+m9XcxInawdn2x6/K9ejVrRAq2r7Szt2eu1/s2H3
	JfHJDoOqRVGU1AiMYRQxgAk14sizAAmSdDPa45lxrqIahoYHU4LaF9CHW0zv6wTv3q9j0PziaHQsK
	UMaEEF+LmBUk+6ykJU4uBlqQzI45bYiNwuKzL/jZ22gDZbpudDHQXR4kj/226KpSK9BHa47vK0KDy
	dbKCqX2RU/sir9G1wq2bpE7dE9kv+0JMlA7Y6lyO/jyQyJNn8gNBwjv2Syxh0/MYl6WC0BtQiz/DE
	dGGPViNg==;
Received: from i53875a11.versanet.de ([83.135.90.17] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vJaYa-0003BD-7O; Thu, 13 Nov 2025 17:52:24 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v3 3/4] mfd: qnap-mcu: Move checksum verification to its own function
Date: Thu, 13 Nov 2025 17:52:17 +0100
Message-ID: <20251113165218.449616-4-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251113165218.449616-1-heiko@sntech.de>
References: <20251113165218.449616-1-heiko@sntech.de>
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


