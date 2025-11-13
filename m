Return-Path: <linux-kernel+bounces-899909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5775C590CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 635805403FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA1335B14D;
	Thu, 13 Nov 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="tvTNLPAP"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1191A3385A9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052748; cv=none; b=QdnkwnHGB1ZVddmKn9LHDYwifOIZzSi5ymsjE3asTfAJl6FjGyq1+Ncerzi5jslBwo/3nkJTBG8P7FadUzqn6p9ax/ulidu22EG4FKOyjTnId0NBen64BGDh/28WsjrFtcSHtYgu/2OPs3fkLtP4a7oP7YoipxtGLOrgeERmQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052748; c=relaxed/simple;
	bh=nXovU8Z9lcvw9h3dBvRi7sK4wfZTfh+iEEWHXqhJ3Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afXFUgUp4t1SPlhzs+WnTRXv6eL3iKJJplKezjiIEsCsSMkaL6Eb0F+jb7mhZ6qN3Ho4ZlgNRXKyvTl2jdLwBTNQZBtFlBPgg0ZC2NRTVaGmDkl16DPihdXOz5cDIGplskbgxfYA2AB6fVLcXofaSzp7VN4nRez95cp5PHnukEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=tvTNLPAP; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=/P2H1HQIzFcvBqE1RaZPIVfxAOIj1n2GfQ8xkB+a48M=; b=tvTNLPAPRAq0BJdaE+HJT+L9pw
	Ku0nVR9uu97JNIQIiYotK9TcrmtzUgFkvQY2uBF0H1Umyf5nMLvpNdPlZ2Eyqce2rr7IYyz0K6mmV
	h/l2tUT8xVxxgG55Qkw5K+Ey2Pb04SrfG5RBKhGyB8Pb5XiJeow0wdcEvMY5yKtopxBftQ5DdjVkr
	9bfgzJ4hEVCun9Km49wkzy3rTRIE35A35W97PBXL/34tqbOtQJdj3/FFKiKsIKipvoeR4BdlQ9srr
	n0Qo3tRDTxxg5uL9G6yOMNiWY3CMY7yKvV0sKSbxXKyzAxXNQ/QkpMOnLZKQHyI2ZWfdEcKZ/GUMC
	oU7hb9wQ==;
Received: from i53875a11.versanet.de ([83.135.90.17] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vJaYZ-0003BD-Pp; Thu, 13 Nov 2025 17:52:23 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v3 1/4] mfd: qnap-mcu: Calculate the checksum on the actual number of bytes received
Date: Thu, 13 Nov 2025 17:52:15 +0100
Message-ID: <20251113165218.449616-2-heiko@sntech.de>
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

In the case of an error message, the number of received bytes can be
less than originally expected but still contain a valid message.

If the transfer itself ended in an error we would exit earlier already.

So calculate the checksum on the number of received bytes and not the
number of expected bytes.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/mfd/qnap-mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
index 2be429a50611..e3210541ec56 100644
--- a/drivers/mfd/qnap-mcu.c
+++ b/drivers/mfd/qnap-mcu.c
@@ -175,8 +175,8 @@ int qnap_mcu_exec(struct qnap_mcu *mcu,
 		return -ETIMEDOUT;
 	}
 
-	crc = qnap_mcu_csum(rx, reply_data_size);
-	if (crc != rx[reply_data_size]) {
+	crc = qnap_mcu_csum(rx, reply->received - QNAP_MCU_CHECKSUM_SIZE);
+	if (crc != rx[reply->received - QNAP_MCU_CHECKSUM_SIZE]) {
 		dev_err(&mcu->serdev->dev, "Invalid Checksum received\n");
 		return -EIO;
 	}
-- 
2.47.2


