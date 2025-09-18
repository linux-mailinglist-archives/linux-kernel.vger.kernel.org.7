Return-Path: <linux-kernel+bounces-822459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE68B83EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFFA1BC4073
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774142F617A;
	Thu, 18 Sep 2025 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eiEpgipr"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D423D2DEA78;
	Thu, 18 Sep 2025 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189320; cv=none; b=CZfgiFOdiJ9cTAtSV1sN2OJtB7o1jxAlcOFOpXxJz28yg3y97AdFHtW5zfg7ZgFgd1EeZ1HlN4bXRaARO6DLu82J/6SJyUbSYm3uV+5FrprR/IOkV5ML/yKlqcxMQq2WFTp0zKnErg6akMwzg0AumXq1xSliFN88j905WBUA3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189320; c=relaxed/simple;
	bh=4SY4L670TJgPKQAU5EDjQSQZtr3mz6KwQpF7XwYu4Yc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9ATC2Yc9YjUaLHT1WPkeP2S1W38pEcpRzgSicTtPiKRAEW0sm8OPgrz1gXhLpv7nBNQpZxDG2nR+wsVDFeynGIwDHg/6ZgMyjltULPo117of68YgA+lSXvpmc41JBj5xmLNY2ozEdwO/0cEKfNUmDH2KcQ52uep/IQi2uMlbqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eiEpgipr; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758189318; x=1789725318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4SY4L670TJgPKQAU5EDjQSQZtr3mz6KwQpF7XwYu4Yc=;
  b=eiEpgiprwbB952G1mWJa+pa/yDIkWOp+phIjjwI4s+gZerhQiIXa30KG
   wJzSkuokl+vaciE2HH2dBB9KLG4WlOsVn/IZ0IJF8ZW6gqa1N9tUkih/q
   Xs85bT+kAxMJ9OJ5oL6da5MNVhM1qS2pADSjj5M98o/vtou2XLnN+q8XJ
   CElEOeDHuR3neHgAvML+8qcvoGS+8+fGiA/zkTG4u5xTXVnAx88J/dRMI
   rUrZd2iXMyo2GxKoQ9VXhEulsHxn8dMNjAOF3wTdcEfvyxB93/9WyM5ZY
   FrwS/nn1aEO50QZyTErG/Z1Z0FZlmcUzrlMGSxvW8Jl9+ayWE2yJ2pebZ
   Q==;
X-CSE-ConnectionGUID: jSMfuw15TJGzquobHcasUg==
X-CSE-MsgGUID: KQynU7MpQvaYijX37AGwbA==
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="46088881"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 02:55:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 02:54:47 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 02:54:43 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
To: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <balamanikandan.gunasundar@microchip.com>,
	<nicolas.ferre@microchip.com>
CC: Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH 2/4] i3c: mipi-i3c-hci: add microchip sama7d65 SoC
Date: Thu, 18 Sep 2025 15:24:27 +0530
Message-ID: <20250918095429.232710-3-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918095429.232710-1-durai.manickamkr@microchip.com>
References: <20250918095429.232710-1-durai.manickamkr@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for microchip sama7d65 SoC I3C HCI master only IP.
Features tested and supported :
           Standard CCC commands.
           I3C SDR mode private transfers in PIO mode.
           I2C transfers in PIO mode.
           Pure bus mode and mixed bus mode.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 drivers/i3c/master/mipi-i3c-hci/Makefile      |  3 +-
 drivers/i3c/master/mipi-i3c-hci/core.c        | 28 ++++++++++++
 drivers/i3c/master/mipi-i3c-hci/hci.h         | 12 ++++++
 .../i3c/master/mipi-i3c-hci/hci_quirks_mchp.c | 43 +++++++++++++++++++
 4 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 drivers/i3c/master/mipi-i3c-hci/hci_quirks_mchp.c

diff --git a/drivers/i3c/master/mipi-i3c-hci/Makefile b/drivers/i3c/master/mipi-i3c-hci/Makefile
index e3d3ef757035..f463afc4566a 100644
--- a/drivers/i3c/master/mipi-i3c-hci/Makefile
+++ b/drivers/i3c/master/mipi-i3c-hci/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_MIPI_I3C_HCI)		+= mipi-i3c-hci.o
 mipi-i3c-hci-y				:= core.o ext_caps.o pio.o dma.o \
 					   cmd_v1.o cmd_v2.o \
 					   dat_v1.o dct_v1.o \
-					   hci_quirks.o
+					   hci_quirks.o \
+					   hci_quirks_mchp.o
 obj-$(CONFIG_MIPI_I3C_HCI_PCI)		+= mipi-i3c-hci-pci.o
diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 60f1175f1f37..cb0673d62c03 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/i3c/master.h>
@@ -651,6 +652,9 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	hci->DAT_regs = offset ? hci->base_regs + offset : NULL;
 	hci->DAT_entries = FIELD_GET(DAT_TABLE_SIZE, regval);
 	hci->DAT_entry_size = FIELD_GET(DAT_ENTRY_SIZE, regval) ? 0 : 8;
+	/* Microchip SAMA7D65 SoC doesnot support DAT entry size bits in the DAT section offset register */
+	if (hci->quirks & MCHP_HCI_QUIRK_SAMA7D65)
+		hci->DAT_entry_size = 8;
 	if (size_in_dwords)
 		hci->DAT_entries = 4 * hci->DAT_entries / hci->DAT_entry_size;
 	dev_info(&hci->master.dev, "DAT: %u %u-bytes entries at offset %#x\n",
@@ -661,6 +665,9 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	hci->DCT_regs = offset ? hci->base_regs + offset : NULL;
 	hci->DCT_entries = FIELD_GET(DCT_TABLE_SIZE, regval);
 	hci->DCT_entry_size = FIELD_GET(DCT_ENTRY_SIZE, regval) ? 0 : 16;
+	/* Microchip SAMA7D65 SoC doesnot support DCT entry size bits in the DCT section offset register */
+	if (hci->quirks & MCHP_HCI_QUIRK_SAMA7D65)
+		hci->DCT_entry_size = 16;
 	if (size_in_dwords)
 		hci->DCT_entries = 4 * hci->DCT_entries / hci->DCT_entry_size;
 	dev_info(&hci->master.dev, "DCT: %u %u-bytes entries at offset %#x\n",
@@ -753,6 +760,10 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	if (hci->quirks & HCI_QUIRK_PIO_MODE)
 		hci->RHS_regs = NULL;
 
+	/* Microchip SAMA7d65 SoC supports only PIO mode */
+	if (hci->quirks & MCHP_HCI_QUIRK_PIO_MODE)
+		hci->RHS_regs = NULL;
+
 	/* Try activating DMA operations first */
 	if (hci->RHS_regs) {
 		reg_clear(HC_CONTROL, HC_CONTROL_PIO_MODE);
@@ -788,6 +799,10 @@ static int i3c_hci_init(struct i3c_hci *hci)
 	if (hci->quirks & HCI_QUIRK_OD_PP_TIMING)
 		amd_set_od_pp_timing(hci);
 
+	/* Configure OD and PP timings for Microchip platforms */
+	if (hci->quirks & MCHP_HCI_QUIRK_OD_PP_TIMING)
+		mchp_set_od_pp_timing(hci);
+
 	return 0;
 }
 
@@ -803,6 +818,16 @@ static int i3c_hci_probe(struct platform_device *pdev)
 	if (IS_ERR(hci->base_regs))
 		return PTR_ERR(hci->base_regs);
 
+#if defined(CONFIG_SOC_SAMA7D65)
+	hci->gclk = devm_clk_get_enabled(&pdev->dev, "gclk");
+	if (IS_ERR(hci->gclk))
+		return PTR_ERR(hci->gclk);
+
+	hci->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
+	if (IS_ERR(hci->pclk))
+		return PTR_ERR(hci->pclk);
+#endif
+
 	platform_set_drvdata(pdev, hci);
 	/* temporary for dev_printk's, to be replaced in i3c_master_register */
 	hci->master.dev.init_name = dev_name(&pdev->dev);
@@ -836,6 +861,9 @@ static void i3c_hci_remove(struct platform_device *pdev)
 
 static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
 	{ .compatible = "mipi-i3c-hci", },
+	{ .compatible = "mchp,sama7d65-i3c-hci",
+	  .data = (void *)(MCHP_HCI_QUIRK_PIO_MODE | MCHP_HCI_QUIRK_OD_PP_TIMING |
+			   MCHP_HCI_QUIRK_RESP_BUF_THLD | MCHP_HCI_QUIRK_SAMA7D65) },
 	{},
 };
 MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 69ea1d10414b..e57f8d85402c 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -37,6 +37,10 @@ struct hci_cmd_ops;
 /* Our main structure */
 struct i3c_hci {
 	struct i3c_master_controller master;
+#if defined(CONFIG_SOC_SAMA7D65)
+	struct clk *gclk;
+	struct clk *pclk;
+#endif
 	void __iomem *base_regs;
 	void __iomem *DAT_regs;
 	void __iomem *DCT_regs;
@@ -144,6 +148,12 @@ struct i3c_hci_dev_data {
 #define HCI_QUIRK_OD_PP_TIMING		BIT(3)  /* Set OD and PP timings for AMD platforms */
 #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
 
+/* list of quirks for Microchip platforms */
+#define MCHP_HCI_QUIRK_PIO_MODE		BIT(2)  /* Set PIO mode */
+#define MCHP_HCI_QUIRK_OD_PP_TIMING	BIT(3)  /* Set OD and PP timings */
+#define MCHP_HCI_QUIRK_RESP_BUF_THLD	BIT(4)  /* Set resp buf thld to 0 */
+#define MCHP_HCI_QUIRK_SAMA7D65		BIT(5)  /* Set SAMA7D65 SoC specific features */
+
 
 /* global functions */
 void mipi_i3c_hci_resume(struct i3c_hci *hci);
@@ -151,5 +161,7 @@ void mipi_i3c_hci_pio_reset(struct i3c_hci *hci);
 void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
 void amd_set_od_pp_timing(struct i3c_hci *hci);
 void amd_set_resp_buf_thld(struct i3c_hci *hci);
+void mchp_set_od_pp_timing(struct i3c_hci *hci);
+void mchp_set_resp_buf_thld(struct i3c_hci *hci);
 
 #endif
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci_quirks_mchp.c b/drivers/i3c/master/mipi-i3c-hci/hci_quirks_mchp.c
new file mode 100644
index 000000000000..f2e54e6643c0
--- /dev/null
+++ b/drivers/i3c/master/mipi-i3c-hci/hci_quirks_mchp.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
+ *
+ * Authors: Durai Manickam KR <durai.manickamkr@microchip.com>
+ *
+ * Microchip I3C HCI Quirks
+ */
+
+#include <linux/i3c/master.h>
+#include "hci.h"
+
+/* Timing registers */
+#define MCHP_HCI_SCL_I3C_OD_TIMING          0x214
+#define MCHP_HCI_SCL_I3C_PP_TIMING          0x218
+#define MCHP_HCI_SDA_HOLD_SWITCH_DLY_TIMING 0x230
+
+/* Timing values to configure 9MHz frequency */
+#define MCHP_SCL_I3C_OD_TIMING          0x00cf00cf
+#define MCHP_SCL_I3C_PP_TIMING          0x00160016
+
+#define MCHP_QUEUE_THLD_CTRL                0xD0
+
+void mchp_set_od_pp_timing(struct i3c_hci *hci)
+{
+	u32 data;
+
+	reg_write(MCHP_HCI_SCL_I3C_OD_TIMING, MCHP_SCL_I3C_OD_TIMING);
+	reg_write(MCHP_HCI_SCL_I3C_PP_TIMING, MCHP_SCL_I3C_PP_TIMING);
+	data = reg_read(MCHP_HCI_SDA_HOLD_SWITCH_DLY_TIMING);
+	/* Configure maximum TX hold time */
+	data |= W0_MASK(18, 16);
+	reg_write(MCHP_HCI_SDA_HOLD_SWITCH_DLY_TIMING, data);
+}
+
+void mchp_set_resp_buf_thld(struct i3c_hci *hci)
+{
+	u32 data;
+
+	data = reg_read(MCHP_QUEUE_THLD_CTRL);
+	data = data & ~W0_MASK(15, 8);
+	reg_write(MCHP_QUEUE_THLD_CTRL, data);
+}
-- 
2.34.1


