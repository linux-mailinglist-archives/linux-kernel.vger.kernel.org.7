Return-Path: <linux-kernel+bounces-832859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 369BABA0964
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6E5387C61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF0030B53C;
	Thu, 25 Sep 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwcIO6K4"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E253306491
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758817436; cv=none; b=KBukXNb58q1XAm8QHtFPyc+YN2P60NCQPqbMFyFecozq+YTUaXJWgrfWD+LyU6nks2BKU10nAGNExz1BuIGlqNDFnMbENx5Ty7iOEPEJFktKD9x9byFoI/OhrO3TAfM4Fz2Yt5AD9XBkQJgSXZR3Cqrz77eBj9ZkW0UKtsed310=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758817436; c=relaxed/simple;
	bh=gQpZKL9PYN00DxqOhZ2zLTrFv9ZJsPxReul3Hvo1omc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ne0XSThVPRPWMoQyWPFjGjXdeKNEs9AXB5HTLgBMZLVY2wu+z83rMLMLVQXEU3se7J5vdfv9Vlo06q30csLvpheJumue+N0p5AE60MlzQvDkz+4Q8hlsb2ZvLYMVo+zlZiSCbFATLP7otEjXfqduQM2NFKxjBIIcoM54g8eFLpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwcIO6K4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so7913505e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758817432; x=1759422232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aly97HE4DbfA98BoW1r98QzzxmSOsTSspnaWMcDHFeI=;
        b=RwcIO6K4UkCEIzl3A+n2uk8TzfU+nJlneRBdYxKx3rk+WkD10IRJG/jY09S0gZhkWY
         5QveVH3Akfc8KD2o/jnCVYOo/SxQR8A8MrhTmRXCRn2ouMB5145n/JtTrbTXr9CFXM5r
         OMBnteRFgfZIOy+YHL7YUjxVAKEVypqZncVErVp2uSHBeND+ZiwO29xi/4uWtzY/XDdM
         XfTRv8W06+/uAr9rX+TMvLf/3epqGAHURMexrLpo8g6yxAiRX+7AP7hFqMoAIlrHTLqs
         ljkiLeqrGGQZyPlw/WGOH/u27rInhEhB56mL8yD/IJyFJm1M0PPKVqgB3ga5BsWO2A9d
         6Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758817432; x=1759422232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aly97HE4DbfA98BoW1r98QzzxmSOsTSspnaWMcDHFeI=;
        b=WDgHSPuj2fGHoFXxMrY1BnJBSf+2IHKOI6IzVZ+y+iSIJc67roLxgZOpz3yMlNcjln
         SLBukYprc3mSLOrZqkTFlCSlo1W+SBxT+KKgo/sg3VO6yeNV1qDNxY3+5P4Z09jV+sm0
         uaQIEqWQ+6UHFXk3c7E/QVMVy+sIvzboAzp41AJErHVDwbCwXmNNTEfOYI52vyd9g06l
         WiZu9BfoTZvrO1bp37JCm7xdq1/OnDqG5wYsXXlxt9emCWA0koIJbTD48I2N3GywzTVr
         wH5rafCb2SwuvyWoXlXbSu+LZrZRpZJyhx9co5CaxtUQ/GwoazXsiWL6QpmiGOQ6b94+
         kZtg==
X-Forwarded-Encrypted: i=1; AJvYcCWghmSNu+kAInyYSl5+hALpd50xGKBxR+3n7ULKujnYa+7TjcybFIqSrG/R1SSHjliJ3DhBRVFnsfZgFqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHMf+IkLUFgl/OLnV1EFjO1LZPkyanL9gVgJfXA7So3HNc/Occ
	5Jz7+QHFI4cdmqP7dooNJCSqvXYfP2N4f+Ahe/spidfU3je1Qhwnga+c
X-Gm-Gg: ASbGncsgPts3SkLJQ9/NEZpPJbilZMEAEY/g7jeAzL/33UvXZWPOzgyochxCNlwQzGg
	olksbiK8xNBUHcpqiS/7OacZUL5c2UwGgGvjf2VOOYoI4+ktRsBL2iGNY6M3eRL1ajDyDxDioMa
	f8EBFuiSGRlXhO9YFYA+rB4VynlG6VrdZROjiEWcXdkUPusTPVnbaVk/T9SRz+/xP5u0ltEV1su
	wHPScECW5aSEk1AbH8LBh/A2fkDKhgLtSljXd9LDukI5JAq4EqG5hwFFBlF5GFA1TbdwWxcZpoH
	22Q1mB2XYabY5vV//JjQzhx5AnR+ji9GgEeBJAi7KSjn8k4HRP77x6LPqbdlTtKTWZdRNajJUpm
	WHGjDk+1FRQlO7c7kNMjnrBt9NV2L1BaMoaTZj+8fRfm3kaw9gUb8jUtBj1h5Yo8IyhRwzw0=
X-Google-Smtp-Source: AGHT+IFhkM3OKIYZ93q3zFo4tpZKrSRaN1CT2/veh5W7Rq8BDbOwn+wtTdHslVzv0uNMo1/McPbcEg==
X-Received: by 2002:a05:600c:489a:b0:459:d8c2:80b2 with SMTP id 5b1f17b1804b1-46e329af060mr29111225e9.7.1758817432312;
        Thu, 25 Sep 2025 09:23:52 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-40fb985e080sm3534819f8f.24.2025.09.25.09.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:23:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Subject: [PATCH v3 4/4] PCI: mediatek: add support for Airoha AN7583 SoC
Date: Thu, 25 Sep 2025 18:23:18 +0200
Message-ID: <20250925162332.9794-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925162332.9794-1-ansuelsmth@gmail.com>
References: <20250925162332.9794-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the second PCIe line present on Airoha AN7583 SoC.

This is based on the Mediatek Gen1/2 PCIe driver and similar to Gen3
also require workaround for the reset signals.

Introduce a new bool to skip having to reset signals and also introduce
some additional logic to configure the PBUS registers required for
Airoha SoC.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 85 +++++++++++++++++++-------
 1 file changed, 63 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 24cc30a2ab6c..640d1f1a6478 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -147,6 +147,7 @@ struct mtk_pcie_port;
  * @need_fix_class_id: whether this host's class ID needed to be fixed or not
  * @need_fix_device_id: whether this host's device ID needed to be fixed or not
  * @no_msi: Bridge has no MSI support, and relies on an external block
+ * @skip_pcie_rstb: Skip calling RSTB bits on PCIe probe
  * @device_id: device ID which this host need to be fixed
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
@@ -156,6 +157,7 @@ struct mtk_pcie_soc {
 	bool need_fix_class_id;
 	bool need_fix_device_id;
 	bool no_msi;
+	bool skip_pcie_rstb;
 	unsigned int device_id;
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
@@ -679,28 +681,30 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		regmap_update_bits(pcie->cfg, PCIE_SYS_CFG_V2, val, val);
 	}
 
-	/* Assert all reset signals */
-	writel(0, port->base + PCIE_RST_CTRL);
-
-	/*
-	 * Enable PCIe link down reset, if link status changed from link up to
-	 * link down, this will reset MAC control registers and configuration
-	 * space.
-	 */
-	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
-
-	/*
-	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
-	 * 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
-	 * be delayed 100ms (TPVPERL) for the power and clock to become stable.
-	 */
-	msleep(100);
-
-	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
-	val = readl(port->base + PCIE_RST_CTRL);
-	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
-	       PCIE_MAC_SRSTB | PCIE_CRSTB;
-	writel(val, port->base + PCIE_RST_CTRL);
+	if (!soc->skip_pcie_rstb) {
+		/* Assert all reset signals */
+		writel(0, port->base + PCIE_RST_CTRL);
+
+		/*
+		 * Enable PCIe link down reset, if link status changed from link up to
+		 * link down, this will reset MAC control registers and configuration
+		 * space.
+		 */
+		writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
+
+		/*
+		 * Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
+		 * 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
+		 * be delayed 100ms (TPVPERL) for the power and clock to become stable.
+		 */
+		msleep(100);
+
+		/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
+		val = readl(port->base + PCIE_RST_CTRL);
+		val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
+		       PCIE_MAC_SRSTB | PCIE_CRSTB;
+		writel(val, port->base + PCIE_RST_CTRL);
+	}
 
 	/* Set up vendor ID and class code */
 	if (soc->need_fix_class_id) {
@@ -1105,6 +1109,33 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	if (err)
 		goto put_resources;
 
+	if (device_is_compatible(dev, "airoha,an7583-pcie")) {
+		struct resource_entry *entry;
+		struct regmap *pbus_regmap;
+		resource_size_t addr;
+		u32 args[2], size;
+
+		/*
+		 * Configure PBus base address and base address mask to allow the
+		 * hw to detect if a given address is accessible on PCIe controller.
+		 */
+		pbus_regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+								   "mediatek,pbus-csr",
+								   ARRAY_SIZE(args),
+								   args);
+		if (IS_ERR(pbus_regmap))
+			return PTR_ERR(pbus_regmap);
+
+		entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
+		if (!entry)
+			return -ENODEV;
+
+		addr = entry->res->start - entry->offset;
+		regmap_write(pbus_regmap, args[0], lower_32_bits(addr));
+		size = lower_32_bits(resource_size(entry->res));
+		regmap_write(pbus_regmap, args[1], GENMASK(31, __fls(size)));
+	}
+
 	return 0;
 
 put_resources:
@@ -1205,6 +1236,15 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
 	.setup_irq = mtk_pcie_setup_irq,
 };
 
+static const struct mtk_pcie_soc mtk_pcie_soc_an7583 = {
+	.skip_pcie_rstb = true,
+	.need_fix_class_id = true,
+	.need_fix_device_id = false,
+	.ops = &mtk_pcie_ops_v2,
+	.startup = mtk_pcie_startup_port_v2,
+	.setup_irq = mtk_pcie_setup_irq,
+};
+
 static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
 	.need_fix_class_id = true,
 	.need_fix_device_id = true,
@@ -1215,6 +1255,7 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
 };
 
 static const struct of_device_id mtk_pcie_ids[] = {
+	{ .compatible = "airoha,an7583-pcie", .data = &mtk_pcie_soc_an7583 },
 	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
 	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
 	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_mt2712 },
-- 
2.51.0


