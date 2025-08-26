Return-Path: <linux-kernel+bounces-786808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAB6B36B78
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5C71C41FED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC8F350D47;
	Tue, 26 Aug 2025 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tB4vy3ww"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD4A350D46
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218642; cv=none; b=Loy2s9R7aXbH1FpRgVfuKJQ3BT02jVn494nIn/dVhjh1aLYNN8GRTgIHEut1PFcwTU9diuRuWI2b7dOQXGyqSNtj+nNHW9RqxZTivZZvZ1WiJ2SFYNBsHdhQIo8NlMkFhzomUbFlDUjrs1T6ZH2SDlcyKJaiZ0Z2ICkdPqR86BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218642; c=relaxed/simple;
	bh=uXNI4bQ3AbAZOS1zgTjXD+zsVVSXdhhuIZU4+M2tGY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LSn30rj/LXj1bZRAEMeeTNL0AFIQvsph/hpQ875B+qWC11M2Z4pu3BE1cBAxS4n67RCSmPXbKsRYeV4FmHWxa0lRHzWt453ZAhn2x2AMZHM3cW2NH7Yptxswq7GOPvwAHalDvZ7TIdUstbs1neyD++F1aR0WrSk4zQXZTiudKjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tB4vy3ww; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756218636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6JxtbOXSRkomOfuA5EBVABjJNq8UxfxHsZRgnolb+hM=;
	b=tB4vy3wwusGXq053PKnR5gdPrRrXzbC78L5W5PE26X3GDLFbORyAOpbAMGn+BHKXCPoiCD
	bdOMUq1Fcw49OgJosrAdUhFezjYlR78GPimmDuJ+0590MrjKr+f5kq2V5mZZgVGrmSahkB
	+dwkagCbOK80tHFERB6r/mDLFTEKU3U=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
	Neil Mandir <neil.mandir@seco.com>,
	linux-kernel@vger.kernel.org,
	Harini Katakam <harini.katakam@xilinx.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net v2] net: macb: Disable clocks once
Date: Tue, 26 Aug 2025 10:30:22 -0400
Message-Id: <20250826143022.935521-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Neil Mandir <neil.mandir@seco.com>

When the driver is removed the clocks are disabled twice: once in
macb_remove and a second time by runtime pm. Disable wakeup in remove so
all the clocks are disabled and skip the second call to macb_clks_disable.
Always suspend the device as we always set it active in probe.

Fixes: d54f89af6cc4 ("net: macb: Add pm runtime support")
Signed-off-by: Neil Mandir <neil.mandir@seco.com>
Co-developed-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Spruce up the commit message
- Rebase

 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b29c3beae0b2..ca9f671d971f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5404,14 +5404,11 @@ static void macb_remove(struct platform_device *pdev)
 		mdiobus_unregister(bp->mii_bus);
 		mdiobus_free(bp->mii_bus);
 
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


