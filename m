Return-Path: <linux-kernel+bounces-887509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ED9C38667
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884D43B3D6D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1FD2F690A;
	Wed,  5 Nov 2025 23:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="E/MkvX3c"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C4A2F60A2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386434; cv=none; b=LMdsuYqw8nPm22gANzkayqoQQkjtexk36bu6lxQxpYYLy6YFBIcjbk2ZwGYxdLIlP8Pb6s3uulib1Kw+QBAm4xwySIYNN1U0gDX8Ewm6YLieCls6cQO3eq+ZGRuiuoFhEF+p2iyXD6ui88X7EWaQ3Y5DUn2ZNvfz1uDf7HatWLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386434; c=relaxed/simple;
	bh=nXovU8Z9lcvw9h3dBvRi7sK4wfZTfh+iEEWHXqhJ3Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqK7OHLoWObZtwf1IVuBbbWKoB3x1y+L428/w7A67JqifJnsIPklZ3SzLRDd+808nBALil2gTeQhIIe0yrK1Wq/I4IzPSem+uKM/13RswE19a7dCN4F8W5dDbUi1KwWC2mtICqGkY/ncPr9gzlzeR2Z2CtFcXF1y2c/CUxWFq3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=E/MkvX3c; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=/P2H1HQIzFcvBqE1RaZPIVfxAOIj1n2GfQ8xkB+a48M=; b=E/MkvX3cO8Yvl5KzfQgBkpkWyC
	soLKyL3dyPD9dDTCbpW/Ww1AA3MWHoaKHUlLSn2HSxo8rBgB6t6JuMR8kZ5Mwob+lgUeR9evaaCjc
	KdBvNPUA+PDxzwYk8fPPh15ql+iny1SMDIKnbJqkEJISxyLnoY/fgiYmoMRL9onbw+5KeFOi59seP
	ves8vjIKGkgmD/tCk5eQI0mh1Iz2FgOg9lWEMpdPRP/VIwg8JI0oWaCuFbAY4EBfF1M73OCrYj3/k
	vEmK6J6Ud+J2rXcnGIWSF3OXsCF93BUNhG/VG228mmbRk0S9msyMR7/zW8v6I4lAH4cRBpGwZ4/WX
	aUu467fQ==;
Received: from i53875bde.versanet.de ([83.135.91.222] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vGnDb-0001Oh-8P; Thu, 06 Nov 2025 00:47:11 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	heiko@sntech.de
Subject: [PATCH v2 1/4] mfd: qnap-mcu: Calculate the checksum on the actual number of bytes received
Date: Thu,  6 Nov 2025 00:47:01 +0100
Message-ID: <20251105234704.159381-2-heiko@sntech.de>
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


