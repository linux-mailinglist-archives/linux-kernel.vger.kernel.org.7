Return-Path: <linux-kernel+bounces-748655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 203A8B1444F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5C71887731
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A9A23A9AE;
	Mon, 28 Jul 2025 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JVGSeMEo"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0428E236A88
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753741122; cv=none; b=Bnuo/hrYMEniujOQNRJI87f+8nZfP+3GLTUSuU8/LQRPj3GKt/PaATiRRGYZeNEMvu0SZP3Zqg9nBbDGyivjn1aA5zHhA5z2H6XEw2S2FxUGlaUtSYacU0IU5TUsed69to5A6dcKFqz4g4yMJCYl95u8XyT5S4IohVyywJo1CvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753741122; c=relaxed/simple;
	bh=55XA8P1iUeREP32fWmuyomheQ5mp0ReLFQKKdLev96g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ml7wB4EP1hsCBsOa2TXdKcq17f9+1pPi0kPFk3EY/u+T9N69DqXqbBUaabTgQjwH8jhBdXc0+Ifni2VhbPhJfdwjE8DdkbjaMCI7XHXdj+j846WNdjmBKG17bYnFDnPA8/7kN1M0e37/u6JEIqHS3Jxc3haXtCN+0kGXxnsuw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JVGSeMEo; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753741119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Di1cyw3vFeHymmCdFM7oOslo1PcW+F7Rf0w8IzgGW8=;
	b=JVGSeMEoXYCLwM/PnBAUMf4YVK5EEjqIUhOBiZuCM3Bcf24r39TLSDmI5zMR54RsALG0ZX
	iOneZpgb/8VWYVXnHlFYF3iGjCuwVKtrNWEOxcS/sMZtz6Eec4ds7Id6B2yyc4TN3n1ExL
	dz429R5R/NSAifUUikaf48uvFulpmok=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Leon Romanovsky <leon@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v3 4/7] net: axienet: Simplify axienet_mdio_setup
Date: Mon, 28 Jul 2025 18:18:20 -0400
Message-Id: <20250728221823.11968-5-sean.anderson@linux.dev>
In-Reply-To: <20250728221823.11968-1-sean.anderson@linux.dev>
References: <20250728221823.11968-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We always put the mdio_node and disable the bus after probing, so
perform these steps unconditionally.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v1)

 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index cacd5590731d..2799d168ed9d 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -302,19 +302,14 @@ int axienet_mdio_setup(struct axienet_local *lp)
 	ret = axienet_mdio_enable(bus, mdio_node);
 	if (ret < 0)
 		goto unregister;
+
 	ret = of_mdiobus_register(bus, mdio_node);
-	if (ret)
-		goto unregister_mdio_enabled;
 	of_node_put(mdio_node);
 	axienet_mdio_mdc_disable(lp);
-	return 0;
-
-unregister_mdio_enabled:
-	axienet_mdio_mdc_disable(lp);
-unregister:
-	of_node_put(mdio_node);
-	mdiobus_free(bus);
-	lp->mii_bus = NULL;
+	if (ret) {
+		mdiobus_free(bus);
+		lp->mii_bus = NULL;
+	}
 	return ret;
 }
 
-- 
2.35.1.1320.gc452695387.dirty


