Return-Path: <linux-kernel+bounces-773236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E351CB29D06
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3FDD189EB4B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C22308F35;
	Mon, 18 Aug 2025 09:02:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E0201269
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507757; cv=none; b=dK8QJ0CJhyUbBh8QRgMp4tIfNaNUhdlsY189Z3Dj8tNnlLp3CTjvzAcfu1sz7AAcvsnXPyd0WvqQ/sEXVHc2Bp03zsDYwEX6LcAo7J65oRoJkcyaNYgKLFpZkns/5oyQPNRgEN1RGiwLksVhAVLbOV/YtfUrJ8S+vNzI6KogiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507757; c=relaxed/simple;
	bh=9tiTx1Q3LRn2gqsaSeeENCt5/jgoRJCwOLQLl2JYKOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LPOUPKHcI2w1AdmUTx36d5OdG2CjTSPhwxG0WzP6ZYT/+8n6mR2MWewBHofoZRe+ehn5SQ5xQFghIWXOqu8cHHVyDVdFOy15jd47DUAjwIAvfpfA3rw1HFJJRwuOKqXfolE4Z+Bor5Q68hQX6WeBvcQzyhXWBc6yyUqIMgPprfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1unvky-0003N5-Rd; Mon, 18 Aug 2025 11:02:20 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1unvkw-000sBE-2S;
	Mon, 18 Aug 2025 11:02:18 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1unvkw-00BhhA-2D;
	Mon, 18 Aug 2025 11:02:18 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v1 3/3] net: stmmac: dwmac4: stop hardware from dropping checksum-error packets
Date: Mon, 18 Aug 2025 11:02:17 +0200
Message-Id: <20250818090217.2789521-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250818090217.2789521-1-o.rempel@pengutronix.de>
References: <20250818090217.2789521-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Tell the MAC not to discard frames that fail TCP/IP checksum
validation.

By default, when the hardware checksum engine (CoE) is enabled,
dwmac4 silently drops any packet where the offload engine detects
a checksum error. These frames are not reported to the driver and
are not counted in any statistics as dropped packets.

Set the MTL_OP_MODE_DIS_TCP_EF bit when initializing the Rx channel so
that all packets are delivered, even if they failed hardware checksum
validation. CoE remains enabled, but instead of dropping such frames,
the driver propagates the error status and marks the skb with
CHECKSUM_NONE. This allows the stack to verify and drop the packet
while updating statistics.

This change follows the decision made in the discussion:
Link: https://lore.kernel.org/all/20250625132117.1b3264e8@kernel.org/

It depends on the previous patches that added proper error propagation
in the Rx path.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h     | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index f4694fd576f5..3dec1a264cf6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -341,6 +341,7 @@ static inline u32 mtl_chanx_base_addr(const struct dwmac4_addrs *addrs,
 #define MTL_OP_MODE_RFA_SHIFT		8
 
 #define MTL_OP_MODE_EHFC		BIT(7)
+#define MTL_OP_MODE_DIS_TCP_EF		BIT(6)
 
 #define MTL_OP_MODE_RTC_MASK		GENMASK(1, 0)
 #define MTL_OP_MODE_RTC_SHIFT		0
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 0cb84a0041a4..d87a8b595e6a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -268,6 +268,8 @@ static void dwmac4_dma_rx_chan_op_mode(struct stmmac_priv *priv,
 
 	mtl_rx_op = readl(ioaddr + MTL_CHAN_RX_OP_MODE(dwmac4_addrs, channel));
 
+	mtl_rx_op |= MTL_OP_MODE_DIS_TCP_EF;
+
 	if (mode == SF_DMA_MODE) {
 		pr_debug("GMAC: enable RX store and forward mode\n");
 		mtl_rx_op |= MTL_OP_MODE_RSF;
-- 
2.39.5


