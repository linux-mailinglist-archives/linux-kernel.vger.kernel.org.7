Return-Path: <linux-kernel+bounces-829308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488DFB96C31
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383344A1A69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A31D2E7657;
	Tue, 23 Sep 2025 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="lipjEu70"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956A324A069
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643751; cv=none; b=ZD6mhv1mAXVLf0qcNCPqX+sN14vVk1gy9oA84YtsVdCcgd3Sc1mtUjSJNYBOOjuenkO4iTDtedG1RWUB5Yxz2ZtorUzvvqNOAd97YJ1DEmarRsVJw2eDTdnntg6jteoETrAfXyTyTj1RaFegFiIh641lixKOLe1e+paJFhXi2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643751; c=relaxed/simple;
	bh=twIJTEcCMTy0Py/D0BH4AIzZpT9lz7OmtGrhpXbLpOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fcpq3Ht+dlh6AQD0zZ4a0tgnytC0PX/cJ9BY+V8wY04TFhvFd5uCQ4kJnDRyL4UXiIDHpzHcYlud9f213+o7QSJMX3BppWwpRfpKcQbkoOX3bawv14dkLcF0oVQHLuj7Gne9z3PDnKuiHX3hfo6iFkBR8dImpQ7mzxEBgQPKYT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=lipjEu70; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=QL8dkAR/dAKVEaSl3fM2kEqgsUQIAz7/pBW3yRVmCNg=; b=lipjEu708ETMYWdXFONd5xOHdO
	Hv33OmFbNElZNLJM3I/tdhmCgb15bkfivkD57bS36eogqWVYi3jZ3MWj6mqnlYsqjYGzhSFLjx3a8
	SO0VYDn6vAFa+DRQFzKfSFDE5pfUg1qeOQ8LZO+g+aVeGwDN9vIJcTMtzm4jrsqqkTMME4r4TV7gQ
	0QB0/7KL9maOmJKQ9miLdV/q9bbBnFmItgYvm/AEcYQ8f+Br3V1H4QCHShOzdKJ9LebvSUzk0+CaB
	ZcXt5sU1rtN2e9zu0+Lf5bMUHEDlFOlSDISj9klk74K+CHiJgKKuVpPSnZPGQeRra+MfH6bR9NSuB
	f5Q2O9Uw==;
Received: from i53875a1e.versanet.de ([83.135.90.30] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v15Zj-0004vp-Kf; Tue, 23 Sep 2025 18:09:07 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH 4/4] mfd: qnap-mcu: Add proper error handling for command errors
Date: Tue, 23 Sep 2025 18:08:53 +0200
Message-ID: <20250923160853.1925674-5-heiko@sntech.de>
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

Further investigation revealed that the MCU in QNAP devices may return
two error states. One "@8" for a checksum error in the submitted command
and one "@9" for any generic (and sadly unspecified) error.

These error codes with 2 data character can of course also be shorter
then the expected reply length for the submitted command, so we'll
need to check the received data for error codes and exit the receive
portion early in that case.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/qnap-mcu.c | 44 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index cd836bdd44a8..fb78609a8433 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -19,6 +19,7 @@
 /* The longest command found so far is 5 bytes long */
 #define QNAP_MCU_MAX_CMD_SIZE		5
 #define QNAP_MCU_MAX_DATA_SIZE		36
+#define QNAP_MCU_ERROR_SIZE		2
 #define QNAP_MCU_CHECKSUM_SIZE		1
 
 #define QNAP_MCU_RX_BUFFER_SIZE		\
@@ -103,6 +104,24 @@ static int qnap_mcu_write(struct qnap_mcu *mcu, const u8 *data, u8 data_size)
 	return serdev_device_write(mcu->serdev, tx, length, HZ);
 }
 
+static bool qnap_mcu_reply_is_generic_error(unsigned char *buf, size_t size)
+{
+	return (size == QNAP_MCU_ERROR_SIZE + QNAP_MCU_CHECKSUM_SIZE &&
+		buf[0] == '@' && buf[1] == '9');
+}
+
+static bool qnap_mcu_reply_is_checksum_error(unsigned char *buf, size_t size)
+{
+	return (size == QNAP_MCU_ERROR_SIZE + QNAP_MCU_CHECKSUM_SIZE &&
+		buf[0] == '@' && buf[1] == '8');
+}
+
+static bool qnap_mcu_reply_is_any_error(unsigned char *buf, size_t size)
+{
+	return (size == QNAP_MCU_ERROR_SIZE + QNAP_MCU_CHECKSUM_SIZE &&
+		buf[0] == '@' && (buf[1] == '8' || buf[1] == '9'));
+}
+
 static size_t qnap_mcu_receive_buf(struct serdev_device *serdev, const u8 *buf, size_t size)
 {
 	struct device *dev = &serdev->dev;
@@ -136,6 +155,19 @@ static size_t qnap_mcu_receive_buf(struct serdev_device *serdev, const u8 *buf,
 		}
 	}
 
+	/*
+	 * We received everything the uart had to offer for now.
+	 * Check for a possible error reply in the received data.
+	 */
+	if (reply->received == QNAP_MCU_ERROR_SIZE + QNAP_MCU_CHECKSUM_SIZE &&
+	    qnap_mcu_verify_checksum(reply->data, reply->received) &&
+	    qnap_mcu_reply_is_any_error(reply->data, reply->received)) {
+		/* The reply was an error code, we're done */
+		reply->length = 0;
+
+		complete(&reply->done);
+	}
+
 	/*
 	 * The only way to get out of the above loop and end up here
 	 * is through consuming all of the supplied data, so here we
@@ -182,10 +214,20 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 	}
 
 	if (!qnap_mcu_verify_checksum(rx, reply->received)) {
-		dev_err(&mcu->serdev->dev, "Invalid Checksum received\n");
+		dev_err(&mcu->serdev->dev, "Invalid Checksum received from controller\n");
+		return -EPROTO;
+	}
+
+	if (qnap_mcu_reply_is_checksum_error(rx, reply->received)) {
+		dev_err(&mcu->serdev->dev, "Controller received invalid Checksum\n");
 		return -EPROTO;
 	}
 
+	if (qnap_mcu_reply_is_generic_error(rx, reply->received)) {
+		dev_err(&mcu->serdev->dev, "Generic error received from controller\n");
+		return -EIO;
+	}
+
 	memcpy(reply_data, rx, reply_data_size);
 
 	return 0;
-- 
2.47.2


