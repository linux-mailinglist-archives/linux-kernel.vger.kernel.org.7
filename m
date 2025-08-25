Return-Path: <linux-kernel+bounces-785247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45192B3481D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B122A41A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630B63019A9;
	Mon, 25 Aug 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nOUWDGH4"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A02FABE4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141194; cv=none; b=J+LF2kPGikut4adI7uf0VvLyCP8El89em8EZZXU1ibv3GAVDEZ0VBKobF7QcQ72nXa2QYVt5LavXrEaa0VZUoTz0fdnbm0qY7Ovl1XDS5XDxk4IQcUWiaGKYn2uGgd/gQXSI4QeDzXfOmffn00bYnp67fub4h6wu+QLGxfBSHXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141194; c=relaxed/simple;
	bh=sQ1bkkbxf39ZWaZ9tFJpNeMnvyUqeeh5Lm0+TTTw+oo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HG+XHbJ5rtiEan+AqnY4uy/yEy86UKooX1rTxdtE5G7OM6VAM5jMU7ViZD7ZcpAVqoBsW/oevGA/ocHmBwP95YMLQ6kt2T4TFFKiEG2sFH2YrOYbigqv22U1Qsj7DnoQVqWL4vwMa4qxvm48d7hYke0xAw+5uhyj/Hwdfht4P5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nOUWDGH4; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756141190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bs8/hdaOApU0BVyJ4z2vkQ88poBN5YurYlQq8z1LEnA=;
	b=nOUWDGH4aM3t/pCqRaFNPcawlTMqTLExaO3lxu3c49hQZCcRgMWI+2FAoA3w52/qT28YRm
	w3UNlk7yONscoTk9XtiCQtAO/RMJPfjpdUq3p3/N14h71EvPS/smlOB8t7gyRMlKSBwTho
	8AlT/bsNEyBSLhdt2DWQmq1vQ9R1MWE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Harini Katakam <harini.katakam@xilinx.com>,
	Neil Mandir <neil.mandir@seco.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net] net: macb: Disable clocks once
Date: Mon, 25 Aug 2025 12:59:25 -0400
Message-Id: <20250825165925.679275-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Neil Mandir <neil.mandir@seco.com>

When the driver is removed the clocks are twice: once by the driver and a
second time by runtime pm. Remove the redundant clock disabling. Disable
wakeup so all the clocks are disabled. Always suspend the device as we
always set it active in probe.

Fixes: d54f89af6cc4 ("net: macb: Add pm runtime support")
Signed-off-by: Neil Mandir <neil.mandir@seco.com>
Co-developed-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ce95fad8cedd..8e9bfd0f040d 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5403,14 +5403,11 @@ static void macb_remove(struct platform_device *pdev)
 		mdiobus_free(bp->mii_bus);
 
 		unregister_netdev(dev);
+		device_set_wakeup_enable(&bp->pdev->dev, 0);
 		cancel_work_sync(&bp->hresp_err_bh_work);
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
-		if (!pm_runtime_suspended(&pdev->dev)) {
-			macb_clks_disable(bp->pclk, bp->hclk, bp->tx_clk,
-					  bp->rx_clk, bp->tsu_clk);
-			pm_runtime_set_suspended(&pdev->dev);
-		}
+		pm_runtime_set_suspended(&pdev->dev);
 		phylink_destroy(bp->phylink);
 		free_netdev(dev);
 	}
-- 
2.35.1.1320.gc452695387.dirty


