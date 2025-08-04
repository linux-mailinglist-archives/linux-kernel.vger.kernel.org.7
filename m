Return-Path: <linux-kernel+bounces-755196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCDFB1A2EB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8636018A3795
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E2D26A1D9;
	Mon,  4 Aug 2025 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="koG0dxPH"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF52561DD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312860; cv=none; b=brMg4PYCSQgyxxa8fPGAi+Q7ARHLXgoPCZUFML2VqR7p9Ov1CIQNANbRKw1L2/nMBFOJX5M7urOaKoGf24D/3UpC5VhKexD0JQfl+2EUGhhRCWPLpWcJlh/8Gd3NbVV2q3GM+B/vuYybNs4zkV/y/hCCYiXx95ScmORgT4P+1po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312860; c=relaxed/simple;
	bh=gszgmE3egusp73Kl9T+BXMe1xCZq6NJI1lDr6hNEKtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IY1nmzMvyVSxcIvNelOhYveQxLQCsBMh44q+LENaRI5wzwE3VZ2icDZK6CXpkhX+Bxx0E5EOqEpJAQwOpWcUHCBFDgR/a7hyIkwDQ9/mE/WGAwCGW8FE2aUsAIvwBXsOSakzKXQCb5DzYPpWwYCwYnGru56fCal5sDyIZw/tBJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=koG0dxPH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=PlsxJs5jBRnnm3qO38nHT7pYaFCNT0nICADm4nW+Jvg=; b=koG0dxPH2MJYIICwEd60WRb0so
	W50Y5uMuo4mvDCpLc7587LcLKpemA8pjnA2Ew5rAt3yeECUQ3xCVVOxeCVoJLQQIxEcK5syv+0e/M
	VTb84itU/h4THY7ElrPxAdFfXX0tinCl4SsheIlMCcxoN70teY9jco8l6IbMx6S46DpxULA1wCafB
	jhpXY3L50u8yr9LtSCP/gyJfEoDvOmWXor108mhPtEh3kedN7u0a6lLsf9CZFPGINeY1jdftlZiEy
	kvh3pMLIId3bQ0xiryHd+aB4FSOehoGB90ZOI7YXmNsJSvSIjj2oXz6mU1lr8LaGI5zMWCdcdfqTo
	m/13w01w==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uiuud-0004Ov-27; Mon, 04 Aug 2025 15:07:35 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: heiko@sntech.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mfd: qnap-mcu: improve structure in qnap_mcu_exec
Date: Mon,  4 Aug 2025 15:07:26 +0200
Message-ID: <20250804130726.3180806-5-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804130726.3180806-1-heiko@sntech.de>
References: <20250804130726.3180806-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now with guard(mutex) in place, we can make the function's structure
a bit easier to read, by removing the nested if-else-clauses.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/qnap-mcu.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index 7bc44c64b7fd..2be429a50611 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -150,6 +150,7 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 	size_t length = reply_data_size + QNAP_MCU_CHECKSUM_SIZE;
 	struct qnap_mcu_reply *reply = &mcu->reply;
 	int ret = 0;
+	u8 crc;
 
 	if (length > sizeof(rx)) {
 		dev_err(&mcu->serdev->dev, "expected data too big for receive buffer");
@@ -172,18 +173,16 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 	if (!wait_for_completion_timeout(&reply->done, msecs_to_jiffies(QNAP_MCU_TIMEOUT_MS))) {
 		dev_err(&mcu->serdev->dev, "Command timeout\n");
 		return -ETIMEDOUT;
-	} else {
-		u8 crc = qnap_mcu_csum(rx, reply_data_size);
-
-		if (crc != rx[reply_data_size]) {
-			dev_err(&mcu->serdev->dev,
-				"Invalid Checksum received\n");
-			return -EIO;
-		} else {
-			memcpy(reply_data, rx, reply_data_size);
-		}
 	}
 
+	crc = qnap_mcu_csum(rx, reply_data_size);
+	if (crc != rx[reply_data_size]) {
+		dev_err(&mcu->serdev->dev, "Invalid Checksum received\n");
+		return -EIO;
+	}
+
+	memcpy(reply_data, rx, reply_data_size);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qnap_mcu_exec);
-- 
2.47.2


