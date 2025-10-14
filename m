Return-Path: <linux-kernel+bounces-852975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676FEBDA637
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB6A3A8812
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467AF30217A;
	Tue, 14 Oct 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AX0X6Lzv"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F8301702
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455554; cv=none; b=XH1qEps/T4xnZd2YI5zH6hQU4Zl+6HNKI3dwzO+TsinGnOmHRsAqIjA9VsUJuaAe4QgfZJ0XQ/zJlFIRExCp5Wj/+CH1fZmz0ket6rknzaIILqWRt0bQ0aZJp4GBS8aGlonjTwqKrF5vKQfxKT4HhTun99q+nSpaWHj0URijx8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455554; c=relaxed/simple;
	bh=wNa3DuvAMhvPEjR2gCMGl0nFFBwN+pt81lUdYbdjvA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJNcetGGUJ6e7lKS6YMOxXLVCgb2EwX39gAoNcOqVQDip+TFFA0D1TzY8QH3+Txc4bTfiNu5tn5C81FeSYTZQtdbSdwSR3n2Sui2LKmMUrtBM7IS3G4uhMu9StufmKyWOk1zcJPUN4pmu3ftE0uTVmo2n9mYWcYvEgMC6EOPLtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AX0X6Lzv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7EBDA1A1386;
	Tue, 14 Oct 2025 15:25:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 543E1606EC;
	Tue, 14 Oct 2025 15:25:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 744C7102F22B0;
	Tue, 14 Oct 2025 17:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455549; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=L8xSHmDqJqypWN0BQtijSoqyQPcRedqk94nr6mZnyuk=;
	b=AX0X6Lzv5aXzbg9C7x7kW0oI2A69pahCmRCe8s3K7MmSVJDi9dHyXFWBIOhc2oYGFDR0Te
	5YrZJ9zl3n5KgVMB1BdJuQWyt1QLfLtun4cM2Gpxm8Y20PA7Xk+PwtT0eBvNcdfFQJmFZO
	/cVo2ytrdpuyp+ZZPJUcximFgFBErcyfak5tpyc3aa9GqlV9gqeEoeMFVjASYTG5jRu07S
	zOUVK4bs9p1ooITh3nuXIRFI0IJDlqzlTdWrPaOdYg7bL/1mLtHEryY8kI90dhQDT7KCrh
	35ugoWkdUF/VKiTiMwggiP+XfbP0aeIZPRx2/oxa1fU3MyAIvaww0/0deJv14A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:06 +0200
Subject: [PATCH net-next 05/15] net: macb: drop macb_config NULL checking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-5-31cd266e22cd@bootlin.com>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
In-Reply-To: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Sean Anderson <sean.anderson@linux.dev>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Remove NULL checks on macb_config as it is always valid:
 - either it is its default value &default_gem_config,
 - or it got overridden using match data.

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index dad1188ef9d87fc3846590032995223174177e89..33e99aab1dcb360a699d0e80762ef421001d19a1 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5485,15 +5485,13 @@ static int macb_probe(struct platform_device *pdev)
 	}
 	bp->num_queues = num_queues;
 	bp->queue_mask = queue_mask;
-	if (macb_config)
-		bp->dma_burst_length = macb_config->dma_burst_length;
+	bp->dma_burst_length = macb_config->dma_burst_length;
 	bp->pclk = pclk;
 	bp->hclk = hclk;
 	bp->tx_clk = tx_clk;
 	bp->rx_clk = rx_clk;
 	bp->tsu_clk = tsu_clk;
-	if (macb_config)
-		bp->jumbo_max_len = macb_config->jumbo_max_len;
+	bp->jumbo_max_len = macb_config->jumbo_max_len;
 
 	if (!hw_is_gem(bp->regs, bp->native_io))
 		bp->max_tx_length = MACB_MAX_TX_LEN;

-- 
2.51.0


