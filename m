Return-Path: <linux-kernel+bounces-836234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA903BA9118
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B90F175445
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A379302169;
	Mon, 29 Sep 2025 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDg4tRWN"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC73019C2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759145905; cv=none; b=UgP9QO0jHeX7jF228ORoCT0IOpglT9I9gvuRG4tCnzDXnVivhcur+DumqjzQpXyk/Q05FwKuH3LOC/Eo+rxTkZRfz7vUpjbavTbCBEHIJndhol90t+xac3BeOwNPut47zkJQDvse4AryXmpreIQdN8W0wLAi/F05frvWcTAfW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759145905; c=relaxed/simple;
	bh=OuzlMBf2DYxUrGozGqCnGqXutFM3aRqod7/0oO6AhUE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXVO2A+yUIOLkBAo3cS8ZHr1PGBXqPpkFA0PlebD8Zm/hHWgD/Mo4zJ7041coKgKRtumjLNrCcD88liYCHnqXMUBXaLOBSuvqQ2SoLZADDN6eKdjnIUrh5Z9mlM5nTzlNUyTRQaq4LGR3z1O6OHOBKPXBpk6iHlqETUA/DNb3s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDg4tRWN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e2826d5c6so34054575e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759145901; x=1759750701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LU04oH6Jeu7LPnO6lTLYJu+6qHSNvnAGZMQiBqSTLE=;
        b=cDg4tRWNlagFMKq37giuUe8paoEMsdJzfqj5yqjtUm+vHz1Oyr6GKuKSVYusQ1ldqF
         1fFTOG5vky8NLD6170RjsR2CG5P/5vV80nWCUoV4Xq4CXUsymPO/6ZzXSCAjxcOOFBHs
         z59DyiKFx0V3HlDd5Qpf09NcM0CE+v3YRzoU62VpaKtvD//L42HPF6xO+S3xhBswl6b2
         sRlUL5F86XW+j2LYcdyxQx09rxTQ66Gv574PT+uarL/o/0P0pkSU09goo8lgaOcp3f4y
         7HyWyg8TG2rLnzfvTYCfweg+jdd5TC0Hw9G84sRUswxo7JVg+wX0QhtF0Cq8RCkiQgvx
         d/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759145901; x=1759750701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LU04oH6Jeu7LPnO6lTLYJu+6qHSNvnAGZMQiBqSTLE=;
        b=aF/cYPdrajFTM/UH6zAMBI1bNc4UBQCzd7HzrU8SmnccDGMFiM+0qf4bZpZnt8zS2J
         d6Y/qxtPWBRohZyS9Q86RCzQKGYGBSD5E5J84HNA06DOD44clwIFemYtVYJpnPWnoB4u
         nEXpGUWT1T9SvRTcT/kzYbBdv3O71SWH0dnKP7vsI2R2DQuAqfH+2Evy795P5zfVP/2I
         O+HmcfGRFzfGrfZuk/GHvU/QQ7Za078z1CUlsVohZWIjCaf28uNviVrGj1Rc4BFCxpbQ
         5YM31tylkf2sbRX2Gy+DRDzyhJTGl0vlMS4vnRzodvvmtz37FYtKlcEq5k10NVnWrdP0
         nKLw==
X-Forwarded-Encrypted: i=1; AJvYcCXePHFfd1KN+T+1p6ZVQeXaG29Nb+VijE81WvxkULKtwrbSk9vIDFiIDeEUYyJvzECDvNfE8FY9twbppxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJHKf31Ssnoa+aWAsqavGJkVZuZqMuPX2XHqJZ6gdHZFRJ6TS
	E/3qxfS0nAO5W/9Uz2TU2nduu5gDDJ1T1iwgQZExYEDOrUDK+AftgDuVymilNw==
X-Gm-Gg: ASbGncuP/Tp2eMMaSbE/4dNztdNXiEpFB1iUzYS28l+Zba3sfLUK5lBsEBXE8whm08s
	BPQ4nFyrBMy2rCQAiq7E8xKOJ3JkitAQuHcg/p5u/UG3+7+KtdU3JXwK22Zewf0elgMlCgMrdlZ
	BkOlpogkVvG9oMtP0CwdpRvMROx02nUnQ+qXWAS/dT9BRgYGJrk/I1f0Vv8RjkAqNEbKCqKPCj3
	aDPZLDwLdEd2GFptNJ6ZvriA52hUBVg78zaUIhoh1G4hNiFF2/JeskfSxLSpzyzMgO9+Q0jka+J
	HSoYH//Wyvr3C9DmQbKbpcieTtKsHzNjL1REeJJSqpfFQoQ2mbgmva7gUAaQyjkR1tfFegYWfvz
	wWXW4BROt0rwbtJkSXpUusNrvMvUBchNgusnauyu7qt8DK+rg4kqLjT/S4UfsUQ4RwdUdpm8=
X-Google-Smtp-Source: AGHT+IGwis8GqJEF1Qzf9bSzV6u14blzsX+OeBzCW6GOkWLJgWkwGAve2YAB0K6RDda7Irm9+euaNA==
X-Received: by 2002:a05:600c:1e23:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-46e3a4e1b6amr123957035e9.5.1759145901122;
        Mon, 29 Sep 2025 04:38:21 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e56f53596sm9502465e9.7.2025.09.29.04.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:38:20 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 4/5] PCI: mediatek: convert bool to single flags entry and bitmap
Date: Mon, 29 Sep 2025 13:38:03 +0200
Message-ID: <20250929113806.2484-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929113806.2484-1-ansuelsmth@gmail.com>
References: <20250929113806.2484-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To clean Mediatek SoC PCIe struct, convert all the bool to a bitmap and
use a single flags to reference all the values. This permits cleaner
addition of new flag without having to define a new bool in the struct.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 28 +++++++++++++++-----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 24cc30a2ab6c..1678461e56d3 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -142,24 +142,29 @@
 
 struct mtk_pcie_port;
 
+enum mtk_pcie_flags {
+	NEED_FIX_CLASS_ID = BIT(0), /* host's class ID needed to be fixed */
+	NEED_FIX_DEVICE_ID = BIT(1), /* host's device ID needed to be fixed */
+	NO_MSI = BIT(2), /* Bridge has no MSI support, and relies on an
+			  * external block
+			  */
+};
+
 /**
  * struct mtk_pcie_soc - differentiate between host generations
- * @need_fix_class_id: whether this host's class ID needed to be fixed or not
- * @need_fix_device_id: whether this host's device ID needed to be fixed or not
  * @no_msi: Bridge has no MSI support, and relies on an external block
  * @device_id: device ID which this host need to be fixed
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
  * @setup_irq: pointer to initialize IRQ functions
+ * @flags: pcie device flags.
  */
 struct mtk_pcie_soc {
-	bool need_fix_class_id;
-	bool need_fix_device_id;
-	bool no_msi;
 	unsigned int device_id;
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
 	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
+	u32 flags;
 };
 
 /**
@@ -703,7 +708,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_RST_CTRL);
 
 	/* Set up vendor ID and class code */
-	if (soc->need_fix_class_id) {
+	if (soc->flags & NEED_FIX_CLASS_ID) {
 		val = PCI_VENDOR_ID_MEDIATEK;
 		writew(val, port->base + PCIE_CONF_VEND_ID);
 
@@ -711,7 +716,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		writew(val, port->base + PCIE_CONF_CLASS_ID);
 	}
 
-	if (soc->need_fix_device_id)
+	if (soc->flags & NEED_FIX_DEVICE_ID)
 		writew(soc->device_id, port->base + PCIE_CONF_DEVICE_ID);
 
 	/* 100ms timeout value should be enough for Gen1/2 training */
@@ -1099,7 +1104,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 
 	host->ops = pcie->soc->ops;
 	host->sysdata = pcie;
-	host->msi_domain = pcie->soc->no_msi;
+	host->msi_domain = !!(pcie->soc->flags & NO_MSI);
 
 	err = pci_host_probe(host);
 	if (err)
@@ -1187,9 +1192,9 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
-	.no_msi = true,
 	.ops = &mtk_pcie_ops,
 	.startup = mtk_pcie_startup_port,
+	.flags = NO_MSI,
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
@@ -1199,19 +1204,18 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
-	.need_fix_class_id = true,
 	.ops = &mtk_pcie_ops_v2,
 	.startup = mtk_pcie_startup_port_v2,
 	.setup_irq = mtk_pcie_setup_irq,
+	.flags = NEED_FIX_CLASS_ID,
 };
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
-	.need_fix_class_id = true,
-	.need_fix_device_id = true,
 	.device_id = PCI_DEVICE_ID_MEDIATEK_7629,
 	.ops = &mtk_pcie_ops_v2,
 	.startup = mtk_pcie_startup_port_v2,
 	.setup_irq = mtk_pcie_setup_irq,
+	.flags = NEED_FIX_CLASS_ID | NEED_FIX_DEVICE_ID,
 };
 
 static const struct of_device_id mtk_pcie_ids[] = {
-- 
2.51.0


