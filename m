Return-Path: <linux-kernel+bounces-892925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3FAC46233
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037753AEAE2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12917308F3A;
	Mon, 10 Nov 2025 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="W8DYShZ4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05770307ADE;
	Mon, 10 Nov 2025 11:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772890; cv=none; b=WzlBOnI2z2nyEmJhTvaueq+zJVTVeBi005gbvhkGy8FumUvPToVFN6ciZNN+N2yT8syzRJB8pf86ncvt+w7DH0PXIrLaG2pAIAjvWLCQ7kDM7n7JMg0I9uIowllBEUw9I1KT8adYdobYvrDN0ggUvPsAKFa5o60QUzOJcKMYFEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772890; c=relaxed/simple;
	bh=AUHDCMu0KXPuI5V/+/etna1r+bnfhQHZs/+ltDeH1VI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSGwX98Go8PTWfUbIUtmJNTuq5tIWvEIAhlEvvj3peCP6+a5NMGUR0dIj69B877zIcfTQTJ66jZsq5jPQRUuhd81gewUWr6VX9OCtmsVXek2NsFer8biU3lqdztwyBR3VaQZlEffVQ7fo0f4TeX6S9CEq183xl//HhtkPWg5e3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=W8DYShZ4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762772889; x=1794308889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AUHDCMu0KXPuI5V/+/etna1r+bnfhQHZs/+ltDeH1VI=;
  b=W8DYShZ41/Tt8ggK2P9A44NOaxCiwrArtyVOdX1YL+ZIXPQF7m9cGdqw
   SVa9QJKdTmu72eGx4S2Bv2LrZEzkKJhdXUTQkz2xZATRi1QYiLh2czI2S
   LkYZURqL8IQ8rW97MY1SzOYr+K7kyS2kQ1FTrs/s2F6Mq+WQZcCkB1NpA
   cX+EdcYuG8T/aL9gK0kyAA4LuuXCYkbgVB6PzEt7G8GfPM+4eBvq05j1/
   zo+0UKRgQUiFFC4wLUZv+OZBTKyxAJt6QRhWukGDv+lOjporT19ggjLso
   ZzU9Sd5qC8BiCiU0h3jGYPaxcnnc4Ph8Mmwy3S8W0SA/4fdrKINDoO9Fa
   A==;
X-CSE-ConnectionGUID: Q9dKRpgHTC2cSW5Q+Klg/w==
X-CSE-MsgGUID: odQaj7KdR0Stvi3Q8OkdvQ==
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="280271401"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:08:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Mon, 10 Nov 2025 04:07:26 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 10 Nov 2025 04:07:24 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH 1/2] phy: microchip: lan966x: Add support for inverting the rx/tx lanes
Date: Mon, 10 Nov 2025 12:05:35 +0100
Message-ID: <20251110110536.2596490-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110110536.2596490-1-horatiu.vultur@microchip.com>
References: <20251110110536.2596490-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The lan966x has 3 SerDes and they have the capability to invert the P
and N signal for the TX and RX. Add this configuration option, which is
done through device tree ans the board designer will decide if the
serdes signals to be inverted.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/phy/microchip/lan966x_serdes.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/phy/microchip/lan966x_serdes.c b/drivers/phy/microchip/lan966x_serdes.c
index 835e369cdfc5f..5faf2001a100b 100644
--- a/drivers/phy/microchip/lan966x_serdes.c
+++ b/drivers/phy/microchip/lan966x_serdes.c
@@ -17,6 +17,11 @@
 #define PLL_CONF_SERDES_125MHZ	2
 #define PLL_CONF_BYPASS		3
 
+#define LAN966X_SERDES_MAX	3
+#define LAN966X_SERDES_DIR	2
+#define LAN966X_SERDES_TX	0
+#define LAN966X_SERDES_RX	1
+
 #define lan_offset_(id, tinst, tcnt,			\
 		   gbase, ginst, gcnt, gwidth,		\
 		   raddr, rinst, rcnt, rwidth)		\
@@ -129,6 +134,7 @@ struct serdes_ctrl {
 	struct device		*dev;
 	struct phy		*phys[SERDES_MAX];
 	int			ref125;
+	bool			inverted[LAN966X_SERDES_MAX][LAN966X_SERDES_DIR];
 };
 
 struct serdes_macro {
@@ -387,6 +393,11 @@ static int lan966x_sd6g40_setup(struct serdes_macro *macro, u32 idx, int mode)
 
 	conf.refclk125M = macro->ctrl->ref125;
 
+	if (macro->ctrl->inverted[idx][LAN966X_SERDES_TX])
+		conf.txinvert = 1;
+	if (macro->ctrl->inverted[idx][LAN966X_SERDES_RX])
+		conf.rxinvert = 1;
+
 	if (mode == PHY_INTERFACE_MODE_QSGMII)
 		conf.mode = LAN966X_SD6G40_MODE_QSGMII;
 	else
@@ -596,6 +607,18 @@ static int serdes_probe(struct platform_device *pdev)
 	ctrl->ref125 = (val == PLL_CONF_125MHZ ||
 			val == PLL_CONF_SERDES_125MHZ);
 
+	for (i = 0; i < LAN966X_SERDES_MAX; ++i) {
+		u8 prop[25];
+
+		sprintf(prop, "microchip,s%d-tx-inverted", i);
+		if (device_property_read_bool(ctrl->dev, prop))
+			ctrl->inverted[i][LAN966X_SERDES_TX] = true;
+
+		sprintf(prop, "microchip,s%d-rx-inverted", i);
+		if (device_property_read_bool(ctrl->dev, prop))
+			ctrl->inverted[i][LAN966X_SERDES_RX] = true;
+	}
+
 	dev_set_drvdata(&pdev->dev, ctrl);
 
 	provider = devm_of_phy_provider_register(ctrl->dev,
-- 
2.34.1


