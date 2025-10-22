Return-Path: <linux-kernel+bounces-864581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A52B0BFB1A7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AF7D5070AC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB75030FC25;
	Wed, 22 Oct 2025 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MMvJ3O6A"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5343126DF
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124490; cv=none; b=HE9RzFJ00kyzGCXDyK72r7VwmfKR5lYSrSBZ2+ojPAn4DrvNQwaBfuyLezwfAesMAqzFnHW3UChRFEzGVWVkzJjA4EJ6A8b+7Aw5C3Aq56qcwOLlkNQW+Tsn/1AysP7Qi/xbNvqrgAgRS1RAgQJRQpRDoo+YFADlN+i8RKH+5VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124490; c=relaxed/simple;
	bh=1NSB5qjI3HdwTQRBQBnjuqJ4TpcqIKiTpLxKV/W6NhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nObwx6PTCfmlDRchzSB1S+JfkS63Hf5qTiUm+VtVhlLsJeUNJ7Hw6VeG3VCC4PZum7ov0unkip/9lRR1rNTvrR94LwX2ZGr+PTicEll3f3HIvvI42JvcJzt1BYyBGevjVyDjBWtt1COVNpyMTBV2mjqFoqZt20GIPb2vew/3yoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MMvJ3O6A; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761124488; x=1792660488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1NSB5qjI3HdwTQRBQBnjuqJ4TpcqIKiTpLxKV/W6NhQ=;
  b=MMvJ3O6Ace3i2hQ+5kAuSj6cHKsHXlD7rHazrlDV1pDlyJq8iRzWrwVg
   ZaMLp4ljZFT1FN38JA1/oAjSA4ePcJh0PRv9Hzheks6aylYu+uoMn8MWB
   FWiXsOazvmI6AIFv/6k7z6cS4LH2OD34knsJZ4MC651Gv7yiVTp3puea+
   sfORet7HJKC/UnJuM2Od5QI06C040HTa2KwJWFABkKGC9KXkkOdCQEEX/
   Hu57U4ox014HtyESwbfPo0Pcan7K3LjNcnZXkj7yDSQx+NJnYv0QG37/3
   7zKUGZgfX/7exvvyZtCejUfdbK2KCk17mv2hYrrAut1kbV/es3R3Typ+P
   w==;
X-CSE-ConnectionGUID: SEdtYETcQTCEAf3r8pCwOw==
X-CSE-MsgGUID: fQ+HAR6MQ4689wGfuJBdYw==
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="54329616"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 02:14:47 -0700
Received: from chn-vm-ex3.mchp-main.com (10.10.87.32) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Oct 2025 02:14:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Wed, 22 Oct 2025 02:14:07 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 22 Oct 2025 02:14:01 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>, <dharma.b@microchip.com>
Subject: [PATCH v2 RESEND 2/3] mfd: atmel-hlcdc: fetch LVDS PLL clock for LVDS display
Date: Wed, 22 Oct 2025 14:43:50 +0530
Message-ID: <20251022091351.472331-3-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251022091351.472331-1-manikandan.m@microchip.com>
References: <20251022091351.472331-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The XLCDC IP supports parallel RGB, MIPI DSI and LVDS Display.
The LCD Generic clock (sys_clk) is used for Parallel RGB and MIPI
displays, while the LVDS PLL clock (lvds_pll_clk) is used for LVDS
displays.Since both the clocks cannot co-exist together in the DT
for a given display, this patch first attempts to retrieve sys_clk
If that fails,it then tries to acquire lvds_pll_clk.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
changes in v2:
- Rephrase the comments, commit message and err logs
- Replace dev_err wwith dev_warn
- Remove Initializing sys_clk and lvds_pll_clk to NULL post
devm_kzalloc() call

---
 drivers/mfd/atmel-hlcdc.c       | 16 ++++++++++++++--
 include/linux/mfd/atmel-hlcdc.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
index 4c4e35d404f3..f680392b01ba 100644
--- a/drivers/mfd/atmel-hlcdc.c
+++ b/drivers/mfd/atmel-hlcdc.c
@@ -108,10 +108,22 @@ static int atmel_hlcdc_probe(struct platform_device *pdev)
 		return PTR_ERR(hlcdc->periph_clk);
 	}
 
+	/*
+	 * Retrieve any one of the Main clk required by the LCD to operate:
+	 *
+	 * LCDC Generic Clock (sys_clk) - Parallel RGB and MIPI displays,
+	 * LVDS PLL (lvds_pll_clk)      - LVDS display
+	 */
 	hlcdc->sys_clk = devm_clk_get(dev, "sys_clk");
 	if (IS_ERR(hlcdc->sys_clk)) {
-		dev_err(dev, "failed to get system clock\n");
-		return PTR_ERR(hlcdc->sys_clk);
+		dev_warn(dev,
+			 "failed to get LCDC generic clock, trying for LVDS PLL clock instead\n");
+
+		hlcdc->lvds_pll_clk = devm_clk_get(dev, "lvds_pll_clk");
+		if (IS_ERR(hlcdc->lvds_pll_clk)) {
+			dev_err(dev, "failed to get LVDS PLL clock\n");
+			return PTR_ERR(hlcdc->lvds_pll_clk);
+		}
 	}
 
 	hlcdc->slow_clk = devm_clk_get(dev, "slow_clk");
diff --git a/include/linux/mfd/atmel-hlcdc.h b/include/linux/mfd/atmel-hlcdc.h
index 80d675a03b39..07c2081867fd 100644
--- a/include/linux/mfd/atmel-hlcdc.h
+++ b/include/linux/mfd/atmel-hlcdc.h
@@ -75,6 +75,7 @@
  */
 struct atmel_hlcdc {
 	struct regmap *regmap;
+	struct clk *lvds_pll_clk;
 	struct clk *periph_clk;
 	struct clk *sys_clk;
 	struct clk *slow_clk;
-- 
2.25.1


