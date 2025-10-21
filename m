Return-Path: <linux-kernel+bounces-863371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0ECBF7B42
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50D404E8E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5FA3570B5;
	Tue, 21 Oct 2025 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B9BCn44P"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3DB34FF6D;
	Tue, 21 Oct 2025 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064402; cv=none; b=qj7YunAWSFr4fxcTow9dlb37EouZX/Wyt8nYSORjFwhuQOjst/rzPC1RMjp0BpMB1iheV+sajRH2C1zkprNDOQGz2s579+WxCmdaFH0JAo+NDuyZfeiz6WZK4EpnrOBMbtCGvklw2IUuLdQF/hDBIf8AGCTz41fA54wxwFblIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064402; c=relaxed/simple;
	bh=Tc8l9ZFS/27xtiHKic+Nw9ObTz+Q5Z1+7UxI999xik8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P3V2SFI6RbExSO/VqytLiBOsezwiMfuAv8HPwHf0R1+Hejcnm+J1LgCDkOnj+83gpIjN8O4uV4ZTtKe84rgB22qBGWK3LSijL0fG7+e6WdlMz/j3nZ2hPCu8N83cmHq46epn8wmvz/Pv+KZQpyEOOcyPwcIwtp9COEXClnJgULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B9BCn44P; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4664EC0B89B;
	Tue, 21 Oct 2025 16:32:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D414960680;
	Tue, 21 Oct 2025 16:33:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A1457102F2405;
	Tue, 21 Oct 2025 18:33:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761064397; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9mdT22bW8hHz3UcIVW5ieLvCN8QVDlwvevK9AMuWtRA=;
	b=B9BCn44P1EQNhvnmT7q8H6NA7TPYf+yZ1iSyRr+1SrLAbt1TuWnwmShY4Q6KIpfIsw8VvO
	t4zMt3FIB3+nPHNhUkseiOirAi6UN1puhnpuKcGWzZdAP9Yaym3HG+N8DbUOpyH9B97r2P
	OOY1jeisVrox9fOjGc8IobkUePTFQyL03YDP0ytqGhTqWiaJ2bG1V7XGv90w85Pz+pyLIe
	ZiLDwwj3rWf506aDfuwK3GHxIP02fsYDfqyQiEaKpC44953PNfJaN3uh2FNvkT8pOGXW3i
	3+Wgyim9kJqJA1IE8+0bF91dbXaTTbQQTg2NJ/F/HI+pukCAS5pYTlbrgsEaug==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 21 Oct 2025 18:32:45 +0200
Subject: [PATCH net-next 04/12] net: macb: add no LSO capability
 (MACB_CAPS_NO_LSO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251021-macb-eyeq5-v1-4-3b0b5a9d2f85@bootlin.com>
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

LSO is runtime-detected using the PBUF_LSO field inside register DCFG6.
Allow disabling that feature if it is broken by using bp->caps coming
from match data.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      | 1 +
 drivers/net/ethernet/cadence/macb_main.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 93e8dd092313..05bfa9bd4782 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -778,6 +778,7 @@
 #define MACB_CAPS_DMA_64B			BIT(21)
 #define MACB_CAPS_DMA_PTP			BIT(22)
 #define MACB_CAPS_RSC				BIT(23)
+#define MACB_CAPS_NO_LSO			BIT(24)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 8d951faf00c3..2010f9290c5c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4563,8 +4563,11 @@ static int macb_init(struct platform_device *pdev)
 	/* Set features */
 	dev->hw_features = NETIF_F_SG;
 
-	/* Check LSO capability */
-	if (GEM_BFEXT(PBUF_LSO, gem_readl(bp, DCFG6)))
+	/* Check LSO capability; runtime detection can be overridden by a cap
+	 * flag if the hardware is known to be buggy
+	 */
+	if (!(bp->caps & MACB_CAPS_NO_LSO) &&
+	    GEM_BFEXT(PBUF_LSO, gem_readl(bp, DCFG6)))
 		dev->hw_features |= MACB_NETIF_LSO;
 
 	/* Checksum offload is only available on gem with packet buffer */

-- 
2.51.1


