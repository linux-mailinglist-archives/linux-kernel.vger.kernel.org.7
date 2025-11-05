Return-Path: <linux-kernel+bounces-887511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A43EDC38670
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A737E1A22544
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9F62F692A;
	Wed,  5 Nov 2025 23:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2vfv8yg6"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4AC2F6180
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386435; cv=none; b=VzsNxM2zLNhvO9IA9iDzKJL0xDsAAJ1RyVDM/6cwK76ihwmJiO+cwwmk1TyZu4ahgA5WqCurzbcAyanucOYAS7ojPBIE7VFTLoxaJIR6Tzn42dsIHlOS9Fz/7C2ozPoXg1o7ulCSsFfLU+xjjnS7xcjz7yImnr7x5HoFeYR8mJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386435; c=relaxed/simple;
	bh=Sd+NKy39TSbX+RkKmGRiW1DJIVJLykXwHgc6FJ8Ct8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpMkyaCJySRg7a7mCqLsDk1q6comd6wlVKBvy9WoAu/U4ipNRQH0H3THwdExIZXzDoPBU+fPozqgv6imXElu6DTYu2oqapgUoS8vAZ2T6hYFRwwaQP6FFOBeqterwPuJIgUnN5a4FxSsGFdpnWcZpkpdckIaVlhWX5KA9hco3BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2vfv8yg6; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=C75UguP6CTqG3pj4T88TFnBval75AVF75tb86M6LdKU=; b=2vfv8yg6OfduldmclbUTupJk9b
	VIqviedoutvc5ps1M8u8IuNC0ZGAULCeaXYNqOFezVn+N5Jf+3z+/K7qK86jdNgIIZbFtSoi9zWPu
	mbe+7sTchTS8HOHQbczq+cKubgZFdx2GQP0pLYYKiOjBdlbJFZ+bSApt4nIcPZDq0Nmeeq4Zd82Of
	pD2/cDrX9RVNzQSSKHeHBRFuWseWwKXG7gDnWjXTr5pqRXQaEcoXBjA7K3/hvbe0TSHHQHwb4A615
	SVFgx/S4mVM4RmpKF0aNM6z42cz8u08t8VYh9Y65ef2mDrX88yn42SKjexx4fSZGfV4bkhaoHMoV/
	qDAVrFVQ==;
Received: from i53875bde.versanet.de ([83.135.91.222] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vGnDb-0001Oh-Ur; Thu, 06 Nov 2025 00:47:12 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v2 4/4] mfd: qnap-mcu: Add proper error handling for command errors
Date: Thu,  6 Nov 2025 00:47:04 +0100
Message-ID: <20251105234704.159381-5-heiko@sntech.de>
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

Further investigation revealed that the MCU in QNAP devices may return
two error states. One "@8" for a checksum error in the submitted command
and one "@9" for any generic (and sadly unspecified) error.

These error codes with 2 data character can of course also be shorter
then the expected reply length for the submitted command, so we'll
need to check the received data for error codes and exit the receive
portion early in that case.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/qnap-mcu.c | 65 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index cd836bdd44a8..8c5eb4a72829 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -19,6 +19,7 @@
 /* The longest command found so far is 5 bytes long */
 #define QNAP_MCU_MAX_CMD_SIZE		5
 #define QNAP_MCU_MAX_DATA_SIZE		36
+#define QNAP_MCU_ERROR_SIZE		2
 #define QNAP_MCU_CHECKSUM_SIZE		1
 
 #define QNAP_MCU_RX_BUFFER_SIZE		\
@@ -103,6 +104,47 @@ static int qnap_mcu_write(struct qnap_mcu *mcu, const u8 *data, u8 data_size)
 	return serdev_device_write(mcu->serdev, tx, length, HZ);
 }
 
+static bool qnap_mcu_is_error_msg(size_t size) {
+	return (size == QNAP_MCU_ERROR_SIZE + QNAP_MCU_CHECKSUM_SIZE);
+}
+
+static bool qnap_mcu_reply_is_generic_error(unsigned char *buf, size_t size)
+{
+	if (!qnap_mcu_is_error_msg(size))
+		return false;
+
+	if (buf[0] == '@' && buf[1] == '9')
+		return true;
+
+	return false;
+}
+
+static bool qnap_mcu_reply_is_checksum_error(unsigned char *buf, size_t size)
+{
+	if (!qnap_mcu_is_error_msg(size))
+		return false;
+
+	if (buf[0] == '@' && buf[1] == '8')
+		return true;
+
+	return false;
+}
+
+static bool qnap_mcu_reply_is_any_error(struct qnap_mcu *mcu, unsigned char *buf, size_t size)
+{
+	if (qnap_mcu_reply_is_generic_error(buf, size)) {
+		dev_err(&mcu->serdev->dev, "Controller sent generic error response\n");
+		return true;
+	}
+
+	if (qnap_mcu_reply_is_checksum_error(buf, size)) {
+		dev_err(&mcu->serdev->dev, "Controller received invalid checksum for the command\n");
+		return true;
+	}
+
+	return false;
+}
+
 static size_t qnap_mcu_receive_buf(struct serdev_device *serdev, const u8 *buf, size_t size)
 {
 	struct device *dev = &serdev->dev;
@@ -136,6 +178,24 @@ static size_t qnap_mcu_receive_buf(struct serdev_device *serdev, const u8 *buf,
 		}
 	}
 
+	/*
+	 * We received everything the uart had to offer for now.
+	 * This could mean that either the uart will send more in a 2nd
+	 * receive run, or that the MCU cut the reply short because it
+	 * sent an error code instead of the expected reply.
+	 *
+	 * So check if the received data has the correct size for an error
+	 * reply and if it matches, is an actual error code.
+	 */
+	if (qnap_mcu_is_error_msg(reply->received) &&
+	    qnap_mcu_verify_checksum(reply->data, reply->received) &&
+	    qnap_mcu_reply_is_any_error(mcu, reply->data, reply->received)) {
+		/* The reply was an error code, we're done */
+		reply->length = 0;
+
+		complete(&reply->done);
+	}
+
 	/*
 	 * The only way to get out of the above loop and end up here
 	 * is through consuming all of the supplied data, so here we
@@ -182,10 +242,13 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 	}
 
 	if (!qnap_mcu_verify_checksum(rx, reply->received)) {
-		dev_err(&mcu->serdev->dev, "Invalid Checksum received\n");
+		dev_err(&mcu->serdev->dev, "Invalid Checksum received from controller\n");
 		return -EPROTO;
 	}
 
+	if (qnap_mcu_reply_is_any_error(mcu, rx, reply->received))
+		return -EPROTO;
+
 	memcpy(reply_data, rx, reply_data_size);
 
 	return 0;
-- 
2.47.2


