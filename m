Return-Path: <linux-kernel+bounces-854289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA38BDE00C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BBDA355252
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ACB3203BA;
	Wed, 15 Oct 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XSBuRolC"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C66B320CDD
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524084; cv=none; b=oMH89k3BV9uDB86SrDXoU0HWcXXIaU//NuhR8DqTFxt8QXKw3vBuOoG42NI5UTIPDyYpF6dOL2OoqFxi5VsQJVV4xaiZaHhzbBlz/bGJhpe4NeMS1DL/7yM6xxTbvttWHphOiNUo4bs6gxmEYHVL5xiKfDsduWHdsOYCtlPy6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524084; c=relaxed/simple;
	bh=NYSK67UaKTt6ePTsH2+/an5FnpshwDQGbnEUVoFh8KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noG0+Z/res1FbjoI5T+mYXIY8K/S89aO8ZTMnlmjR5u+DvD39DFfOYaXvy2+Mb5jYdsf/+YkHzaQMBEB3ejMlq0ihjimZ9Lx7En8AKcJAL9yQCa8wS1pUUEWFmizUuH90b/M8h9PaEZOPBRL+7y0/r+PCNSF0n7KkFu5dkWy2Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XSBuRolC; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 18A0C4E410C8;
	Wed, 15 Oct 2025 10:27:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E1B5E606F9;
	Wed, 15 Oct 2025 10:27:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 02430102F22B6;
	Wed, 15 Oct 2025 12:27:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760524072; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=QHVnsSy8bd4MBHdkXAoKW/zEg8SUtl8twOZfbMKVdIg=;
	b=XSBuRolCicBkNJm8OH1Xd8R5w3Q8ZF5Tt5gZJzjGi5wmyvKOA7n7zpn+oEpXRd0ZOGotmB
	zVbgUqeZYcrpTXDcm4FUe/M+ZNzceoKZV7HEdOwYruNARjNQGZ+ECPR7veLInMp/bP7sOq
	RtJHttX25uC4rB3OmIiTZyAhFWzJzxH5CIlacffkU2/cLNRu2FVqjlXOuk+Y9BbovwwYe2
	t08dlaBqLA1OkfVVGAWW/Z8oP1J1Allq4tM9ptcGExAeYN64SwQTxWz68ita3Rlw0A0Hxa
	fe21oratbSDiLL7OtW592xBPYSMqecFEnNBVx5yHkO98kdkkWR88GX3rsarHug==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] net: stmmac: Move subsecond increment configuration in dedicated helper
Date: Wed, 15 Oct 2025 12:27:21 +0200
Message-ID: <20251015102725.1297985-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In preparation for fine/coarse support, let's move the subsecond increment
and addend configuration in a dedicated helper.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 48 +++++++++++--------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 650d75b73e0b..3f79b61d64b9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -463,6 +463,33 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
 	}
 }
 
+static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
+{
+	bool xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
+	u32 sec_inc = 0;
+	u64 temp = 0;
+
+	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
+
+	/* program Sub Second Increment reg */
+	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
+					   priv->plat->clk_ptp_rate,
+					   xmac, &sec_inc);
+	temp = div_u64(1000000000ULL, sec_inc);
+
+	/* Store sub second increment for later use */
+	priv->sub_second_inc = sec_inc;
+
+	/* calculate default added value:
+	 * formula is :
+	 * addend = (2^32)/freq_div_ratio;
+	 * where, freq_div_ratio = 1e9ns/sec_inc
+	 */
+	temp = (u64)(temp << 32);
+	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
+	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
+}
+
 /**
  *  stmmac_hwtstamp_set - control hardware timestamping.
  *  @dev: device pointer.
@@ -696,10 +723,7 @@ static int stmmac_hwtstamp_get(struct net_device *dev,
 static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
 				      u32 systime_flags)
 {
-	bool xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
 	struct timespec64 now;
-	u32 sec_inc = 0;
-	u64 temp = 0;
 
 	if (!priv->plat->clk_ptp_rate) {
 		netdev_err(priv->dev, "Invalid PTP clock rate");
@@ -709,23 +733,7 @@ static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
 	priv->systime_flags = systime_flags;
 
-	/* program Sub Second Increment reg */
-	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
-					   priv->plat->clk_ptp_rate,
-					   xmac, &sec_inc);
-	temp = div_u64(1000000000ULL, sec_inc);
-
-	/* Store sub second increment for later use */
-	priv->sub_second_inc = sec_inc;
-
-	/* calculate default added value:
-	 * formula is :
-	 * addend = (2^32)/freq_div_ratio;
-	 * where, freq_div_ratio = 1e9ns/sec_inc
-	 */
-	temp = (u64)(temp << 32);
-	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
-	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
+	stmmac_update_subsecond_increment(priv);
 
 	/* initialize system time */
 	ktime_get_real_ts64(&now);
-- 
2.49.0


