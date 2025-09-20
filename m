Return-Path: <linux-kernel+bounces-825657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3127B8C70C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 13:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB0D172719
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F92FD7BE;
	Sat, 20 Sep 2025 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EfnrGlek"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3D02FD7A0
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758368637; cv=none; b=I9jaRUtpmQTYUwa24VJharyq6rezJDZ2iJaDEsXbVLoVKvJdp96RR63MwhjkIrB5ExyKAMgkv/AFVV89s/9PQCx+YJsOrH6N1jS6NRueKsmbSlRUFCVqRs/E+frM3/hNPcV7W29nIVWPGCtRoccJbtsvm1gJ5BhR8AaOGL84gZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758368637; c=relaxed/simple;
	bh=0rWlX1kT1KOjqeIexDj79uvTQkFPDw5D5N2istPloBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N1A75ftAW8s3JqsUQ1CPzmeSdGOUg0AOlnpzoqH68LxHwxkIn2rbxcf2x+EfEVn0hEJS+zXWoLTErQAVqcx/QwTcK8uLu/HRW4xQ3nYvNvJOMIaCS0/b6OysquTYnt4ZCGxIYvWsBag99pa23VUtmLnewhtPSrAMyxDNlNfHnGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EfnrGlek; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso1696277f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 04:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758368634; x=1758973434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5qPv4ldTq9iLR5m/Ew1ytbLOJ+vLoqEg9E8nbrL4xZQ=;
        b=EfnrGlekKLcn+aHOjn9cTbqviETQsTDMUQEL09zQ9E/BkovC6WCMRt4OAhM2shBqic
         Cilew4ZIz3omeDwWPIWcGiX9+INfRSlmdFnnYWlJGz/+dtUXuKAujyuOQQbH14Ez3IkS
         jbrYtFyCHMXxOlx4cmGe9+EhDrnveGxmMV0WCYv5v8m8eHAEEeu6gwMlysdExRmfh4tM
         jcRxbEPwCa62VdviKseUnD7ZJ4y4CGgtrTtq310msb3YR55UU7ncNmqGYVb6IX1UAfxq
         s/zDTUTdLOU8zklH2Y9gopxjtt7KvdW/yJU+r88o043/yhoCku9WQ/Vwt5PelZ4FXDLA
         wmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758368634; x=1758973434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qPv4ldTq9iLR5m/Ew1ytbLOJ+vLoqEg9E8nbrL4xZQ=;
        b=fkWcnKJhRyXgMJ7Mn34COlgHHbPDFuL5uzO9pJ9sh1Pru1Tc9TsvWPYmfDkcwc3JzF
         T+M1tWB1ECywNeA7eMIjjPxc3+zFZMPiqzMyBfq/CQml+j3Ph3GFMMlmmCXbv1uoImsr
         iOfIYVwxCWHiCalxTmgZb/oTjO0k0NTulHN+himWDxgYnI0gRHdIhg7aeanw81YXjw1B
         Fq0jaDTXmDLbTPBltsMGdQCz1Y83knnkbnuN4Hl+KNgLKnuoWSndddJm5X8M7M6JC8fg
         rY7BktR6SQOXy5dKePsF77eKvEBD5wq872VWo6jaM60EazWT8B+6nZ0OnPaC002pby7v
         blaw==
X-Forwarded-Encrypted: i=1; AJvYcCVY9AWYblbASkBqK/mTTf0LhBlXMeYAZLWWmS/QwL8t7R10Q8XZPZeUnEjGEQZZ2nBn3BPLF3rFjqBfpys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKatYqztFIM1mXr8XlVWEf13ZpwcZBifDFbq6Q7bIH0MsPMwLE
	fAIPIfoy1lF54oZpB2fb4XZfEOr7KBAC1CHqCSI5Lz+dvlftpgKlrQ/K
X-Gm-Gg: ASbGncuMXfAv406n3OSOqCYrIaTZuSRbJneLW4gI133keR2zCguakqBYR9gTjqamMmM
	zfSk0wbQw6echksVCNKuNzQcujXan1R71OY+fBHDnix4orHyLbdx6iHJKp0CTGWp/SQ6erECX3d
	RBBZ6Y+xt114nX1jGIyeQF/bQo/anxRaDtDqrQ/X+DoV4RFPx8UyLKtmNrEvqyPbwkgt+XK3OW0
	UEXvQtYnSOwgwhEG21p/T06p9ASzkkmCSWQ0Jn78cn2ery1C6VRtxOp+LWYF+AY3lUUxIB2TOYz
	6w7/jVU0KVKbzIUCiOkRgV9vi42HQEHBcwss1LJ+5Ecf9MNe+3xqoK61DoKReIRHz13wmPihy0J
	n3kRz0QtqF3pcyy6xv6FVd4aeEi3AMIQvz5G6JSkJQJpsWpXeqppuoN0q5YCQFx7dEIkhomo=
X-Google-Smtp-Source: AGHT+IGeKLyKQNfti4n7pQMmmIvBvMIuHbECb0sWa4jGH1bzRgL7YqTQVCn/1cA7YHkHgqvs03ymNA==
X-Received: by 2002:a05:6000:40ca:b0:3f0:f7dd:4b76 with SMTP id ffacd0b85a97d-3f0f7ec90c5mr4643851f8f.15.1758368633761;
        Sat, 20 Sep 2025 04:43:53 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3f305f837c5sm3392172f8f.47.2025.09.20.04.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 04:43:53 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] PCI: mediatek: add support for Airoha AN7583 SoC
Date: Sat, 20 Sep 2025 13:43:23 +0200
Message-ID: <20250920114341.17818-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
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
 drivers/pci/controller/pcie-mediatek.c | 84 +++++++++++++++++++-------
 1 file changed, 62 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 24cc30a2ab6c..ad7d47c18f0f 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -156,6 +156,7 @@ struct mtk_pcie_soc {
 	bool need_fix_class_id;
 	bool need_fix_device_id;
 	bool no_msi;
+	bool skip_pcie_rstb;
 	unsigned int device_id;
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
@@ -679,28 +680,30 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
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
@@ -1105,6 +1108,33 @@ static int mtk_pcie_probe(struct platform_device *pdev)
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
@@ -1205,6 +1235,15 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
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
@@ -1215,6 +1254,7 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
 };
 
 static const struct of_device_id mtk_pcie_ids[] = {
+	{ .compatible = "airoha,an7583-pcie", .data = &mtk_pcie_soc_an7583 },
 	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
 	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
 	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_mt2712 },
-- 
2.51.0


