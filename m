Return-Path: <linux-kernel+bounces-849739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B1BBD0C5B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 22:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1007347300
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A4B242D6C;
	Sun, 12 Oct 2025 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtHkRNkF"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8EB238C2A
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760302757; cv=none; b=Tts0PZODhIxAGXQ8Xh9KBOkEInaqXh3kNudDgv2gpm7EXjY2KnTIj8D/X9927jpYKSyX0tTglfHUuOxrLSPb0m06pajXd0P7/KYfpzp2AzSZT9Gq+4nmYgVG9RIRB2fxrEG/8nMmMNMyBO2lrBelEHnMXgrSyTNjY7ribkjVvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760302757; c=relaxed/simple;
	bh=OuzlMBf2DYxUrGozGqCnGqXutFM3aRqod7/0oO6AhUE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcOoeOt/x48dcu8HK0JLjwEtXwq6s7aMidMfKXfOh7iQUg9tzfOxVSzcO5h+dDx1Zcbn8DZ9ml38n+eOx2FtW0VcXX50MAvhSKXEYCyauyjtdzvMlGt28v/duf/cj/rK7GvNk3qT7yy3t43cfjUw/ZyRndYFoELdOBuRsU/3JCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtHkRNkF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e4f2696bdso37880975e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 13:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760302754; x=1760907554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LU04oH6Jeu7LPnO6lTLYJu+6qHSNvnAGZMQiBqSTLE=;
        b=DtHkRNkFksHqXz2/tbiNmV90QbRCxpF/rvEfWE7okfhJcvdU6BBZWVa6jU96WRwuLC
         N/wX4+qX/vt9PiZUXG31V3NHmVfnZrbxLJ1YZOeuocFuSeQUQUeE3Jg1jFjsJQpkDFGz
         FsRF2jjHzfn9y26qReOcWzojttuoryz67wUNldjaFad5/N6wlKKLeoG2jd8XTxYfarkK
         VIEIivz4QaPG+nCBEYviC1l8PsRrGbue5j5PxuxQ+Tapkh2g24U+rUkfhxW3Ln6VLzWh
         t9vDupoVuDN9L5aFTA0AeI2SKiy0N+1qqaUxtVNXgqNzT1CJ8maVNVKYNZbQk6aMk+YK
         p+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760302754; x=1760907554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LU04oH6Jeu7LPnO6lTLYJu+6qHSNvnAGZMQiBqSTLE=;
        b=gWfGP1KdqAwKIE4uT9Owb5dc1byBl2SF41Pe2WA8oAs46K3YUrjjllpGf6Kx5HLXM0
         DMEjFjqrtwxBrYdtSaeEdDQH3D8NxSMERtlWHWG6d1yhhXekh6K49wLbqrFQwWrwBVZK
         apBB3jBrHbB+sO7xdl9IQxnu1BQU4Av8xgH4uSSNnvj7LBk9QP9WPWMyhUuswtUba313
         IDD745vAeOT/Xz/HhXWG43YBlxFWpT1ezBc8RoociGiHd9jrYv0eo7eCJGHuXeRT+Afe
         mBqdp7Nrp29haskViwP7E11rfiAZdjcUKEfApambisGCF8LSjj6DDMY2fGfHgfKb8ZcZ
         dU2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGZGLvfgfvI3zGm+2KdA7b0Fj2hStI8WTkoEsKvetdJ+7l3eZ9P9Yj8zk4gifqGtFKfDCl1Q/sCl15UY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Tb0H+fSXZ/gQX+0Er110+LoIu0NQD5CivTskqNKu8fQOiPDq
	fMhXv8u+IWEkbYglB2Fo5tCyCPq/V8YwHpEKpx2UhbB1+3ttlmDqqobr
X-Gm-Gg: ASbGncup6DjNy8AKJsolgBDu+nw3mHInvWWgpsopbMZssVL3+ebEhU5VJLYq2NBL/dV
	QeeVesCIHZUXrz6Cyu8rO0uPC4bXs/7iPE9D/lntjMmYMMUIVLU60xWBTVEO88tyQgJH3PL0GNv
	dbmSM7SgBtRbN+alHmJmIDMYbgXmQEDKTGoipnLGND6Fnco48EqLEasaR5EWEs5rMop++ZI96od
	cyAp6YfBr3VGgP1P3vOLFjbvw9OQXHfIAvcNF8TX+MFjQeqNS4KhgSX50Ep0hx3ggfQXQ6xy6Kr
	KDnhn0KEMZK45hdkZxAhNxtndMs/wbeW9v9mgF6B08FEii4IS8bhwnoxW7SUs3vO5yEo7aIp+CF
	A2iRwAeqt7dGAHUGmX1dLe7/BvkECdRyuW01DiuL2wNUv2MCHpjVNjd5cVEmjKEydeBduKrLCoQ
	==
X-Google-Smtp-Source: AGHT+IFb/bAhpEKJ/FBvurZ3ngymv1jIbjyeCuWNWFx0Ku04wvextCGWwGr4AETbratHm/u6QoIvxw==
X-Received: by 2002:a05:600c:3f10:b0:46e:5cb6:b904 with SMTP id 5b1f17b1804b1-46fa9b079f7mr131209665e9.28.1760302753575;
        Sun, 12 Oct 2025 13:59:13 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46fb489197dsm156506505e9.10.2025.10.12.13.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 13:59:12 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Subject: [PATCH v5 4/5] PCI: mediatek: convert bool to single flags entry and bitmap
Date: Sun, 12 Oct 2025 22:56:58 +0200
Message-ID: <20251012205900.5948-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012205900.5948-1-ansuelsmth@gmail.com>
References: <20251012205900.5948-1-ansuelsmth@gmail.com>
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


