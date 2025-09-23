Return-Path: <linux-kernel+bounces-829307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3809B96C28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D634A1646
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA3D2E62AD;
	Tue, 23 Sep 2025 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="XBO6kneD"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7D52E2679
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643751; cv=none; b=gp5pcC1+n7EzKWYYoXyaziUEpRZcehlNxWKgTGy3AcUHTknlSA30Dxg0JjpkrIztovGi4L/55R/dviF/PMO2HnfTbxpB51rvcR2EYM6wnXJcuQesQwQRhVl4YfCb7+hcrUzIXAUuuQtV9BHDrJNGB7C9AgjbvhY5tJq2n+DPLbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643751; c=relaxed/simple;
	bh=N+Ft/PmrtbS1c2vl4AHC6AfYZVStrjBDS5Fxlyfgs08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhCQGylvhmjbOlYc+JQeJp7x2R/4+fAjiExoTRmvNhpHXuIxSYpsH9MAoX3P8P46jgJDgopNApalt+l4M+AOe1EM/JGOUa9UM3pIEAI8Yr8+TWIDJB209USizrwaIAk+T6mKvCBP1OZ/TqBAEt3bVR8GvXKmT9S6uGQk/nUkzQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=XBO6kneD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=nQYxBu/Q09Up2UjAV3Yg5ScyfmPTkQa5TKMKUGdESZo=; b=XBO6kneDxyPXIz3mq/G6EWlO/2
	p9hiVyAKvjd7otWEKBp22ZS0G0urwjXx9WjrybDKbboIxffGWOrMwEi4nsRzAF8gTjV1wHr5cEv6/
	1HbBiUqWN+UwgR9qR+BrQwgcpYDijAz9DE1tE2/9+vsz1PVbdJF12GSmgQEm1lrr3vL0c6tpJk0YI
	Y9JQgSuGvVL41s3kD+HRsx0zXk+UbAFUfCZn3ihOsmto5Ca4Uss5sqCCbYL1XLVbSOp89GU8Gh/1+
	IoYdn75apiU+OyOcNbv0tzch4UMU2CgdmqmKH9jTldGgjQMux6QjlIT1zcllkDaMd92DiikYtEov9
	D760RK9w==;
Received: from i53875a1e.versanet.de ([83.135.90.30] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v15Zj-0004vp-6V; Tue, 23 Sep 2025 18:09:07 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH 2/4] mfd: qnap-mcu: Use EPROTO in stead of EIO on checksum errors
Date: Tue, 23 Sep 2025 18:08:51 +0200
Message-ID: <20250923160853.1925674-3-heiko@sntech.de>
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


