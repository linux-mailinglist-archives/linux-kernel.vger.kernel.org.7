Return-Path: <linux-kernel+bounces-863370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A993DBF7AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F3F18C7ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEDF34FF6E;
	Tue, 21 Oct 2025 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xOOXa3ih"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B634FF4E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064399; cv=none; b=ItAItiXJyz3f2T8gxKVUVEtgD5VbwGEJoujB+kyo2sWAGuEZLhXXxOAzHaqizfqkKXO5LKwbWwu/1X1ClOGFJab1CnfBgxUAU/njIJ/J0JB0UWkFLI0OAgL8084iCKBfPgcrPkfFFLIh4snuGSaR7tzPi+kZf5tIJ4oe6SLlMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064399; c=relaxed/simple;
	bh=0QkH3T2bEXT83CHCQSI6m5aj4GerMQ/hyyR5h0m9pvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkm2WUta8U/9yT9PY/AZrCzT5EtTi6IPVfuZ6LbM0B0ejMfHvLW8ga/tK2FOKuMU893Z6JZcd7nU68H+xYLU186eDoG/Xnnvyvp2kbQnfpXH/V8EIx+NgyQObB4+1kEmYEc0pRE4MYyfffjenwZx+hi+IQ+B3IKyBvkRfrNmmhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xOOXa3ih; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 193671A15A2;
	Tue, 21 Oct 2025 16:33:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E1D4F60680;
	Tue, 21 Oct 2025 16:33:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3E4B102F23EA;
	Tue, 21 Oct 2025 18:33:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761064394; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=j8hzkMx0NGZAJQ/xFkuORjF0T7wqXOb0/2K4DFFgOl8=;
	b=xOOXa3ih9rTHX6pBNbuMIj9QgflJXrD8M2PwQra8Sou1iFuJH953sMTHOiFzgJIO3xgO4Q
	eo0jHAS0RuQIVRK2+L8Kpai4CLYbItShUEmDAhoXbqgB+M9BSSVuOE8I047yPRSj5SLS9B
	LkiII1STET/nKnamzD2u6Yt+vGaoSWcvBz7T0xE7PyU7lNWJQdESc6pF+y6Tw3id6vzsIV
	bF1xJKj6n/2k8Di9c3NzGmzhdHPbAvOa8yK0SMv26KfNobS2KgO5o0mQER3GwH4zPEc4xq
	c6JwVfHCWurZNuMG1DWPJ5ZmbvaQgDZJ4Jv0oOdu3V9GswCOUc5YfeWCyNPgCQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 21 Oct 2025 18:32:44 +0200
Subject: [PATCH net-next 03/12] net: macb: match skb_reserve(skb,
 NET_IP_ALIGN) with HW alignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251021-macb-eyeq5-v1-3-3b0b5a9d2f85@bootlin.com>
References: <20251021-macb-eyeq5-v1-0-3b0b5a9d2f85@bootlin.com>
In-Reply-To: <20251021-macb-eyeq5-v1-0-3b0b5a9d2f85@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Russell King <linux@armlinux.org.uk>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

If HW is RSC capable, it cannot add dummy bytes at the start of IP
packets. Alignment (ie number of dummy bytes) is configured using the
RBOF field inside the NCFGR register.

On the software side, the skb_reserve(skb, NET_IP_ALIGN) call must only
be done if those dummy bytes are added by the hardware; notice the
skb_reserve() is done AFTER writing the address to the device.

We cannot do the skb_reserve() call BEFORE writing the address because
the address field ignores the low 2/3 bits. Conclusion: in some cases,
we risk not being able to respect the NET_IP_ALIGN value (which is
picked based on unaligned CPU access performance).

Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  3 +++
 drivers/net/ethernet/cadence/macb_main.c | 21 ++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 5b7d4cdb204d..93e8dd092313 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -537,6 +537,8 @@
 /* Bitfields in DCFG6. */
 #define GEM_PBUF_LSO_OFFSET			27
 #define GEM_PBUF_LSO_SIZE			1
+#define GEM_PBUF_RSC_OFFSET			26
+#define GEM_PBUF_RSC_SIZE			1
 #define GEM_PBUF_CUTTHRU_OFFSET			25
 #define GEM_PBUF_CUTTHRU_SIZE			1
 #define GEM_DAW64_OFFSET			23
@@ -775,6 +777,7 @@
 #define MACB_CAPS_MACB_IS_GEM			BIT(20)
 #define MACB_CAPS_DMA_64B			BIT(21)
 #define MACB_CAPS_DMA_PTP			BIT(22)
+#define MACB_CAPS_RSC				BIT(23)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 214f543af3b8..8d951faf00c3 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1301,8 +1301,19 @@ static void gem_rx_refill(struct macb_queue *queue)
 			dma_wmb();
 			macb_set_addr(bp, desc, paddr);
 
-			/* properly align Ethernet header */
-			skb_reserve(skb, NET_IP_ALIGN);
+			/* Properly align Ethernet header.
+			 *
+			 * Hardware can add dummy bytes if asked using the RBOF
+			 * field inside the NCFGR register. That feature isn't
+			 * available if hardware is RSC capable.
+			 *
+			 * We cannot fallback to doing the 2-byte shift before
+			 * DMA mapping because the address field does not allow
+			 * setting the low 2/3 bits.
+			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
+			 */
+			if (!(bp->caps & MACB_CAPS_RSC))
+				skb_reserve(skb, NET_IP_ALIGN);
 		} else {
 			desc->ctrl = 0;
 			dma_wmb();
@@ -2774,7 +2785,9 @@ static void macb_init_hw(struct macb *bp)
 	macb_set_hwaddr(bp);
 
 	config = macb_mdc_clk_div(bp);
-	config |= MACB_BF(RBOF, NET_IP_ALIGN);	/* Make eth data aligned */
+	/* Make eth data aligned. If RSC capable, that offset is ignored by HW. */
+	if (!(bp->caps & MACB_CAPS_RSC))
+		config |= MACB_BF(RBOF, NET_IP_ALIGN);
 	config |= MACB_BIT(DRFCS);		/* Discard Rx FCS */
 	if (bp->caps & MACB_CAPS_JUMBO)
 		config |= MACB_BIT(JFRAME);	/* Enable jumbo frames */
@@ -4322,6 +4335,8 @@ static void macb_configure_caps(struct macb *bp,
 		dcfg = gem_readl(bp, DCFG2);
 		if ((dcfg & (GEM_BIT(RX_PKT_BUFF) | GEM_BIT(TX_PKT_BUFF))) == 0)
 			bp->caps |= MACB_CAPS_FIFO_MODE;
+		if (GEM_BFEXT(PBUF_RSC, gem_readl(bp, DCFG6)))
+			bp->caps |= MACB_CAPS_RSC;
 		if (gem_has_ptp(bp)) {
 			if (!GEM_BFEXT(TSU, gem_readl(bp, DCFG5)))
 				dev_err(&bp->pdev->dev,

-- 
2.51.1


