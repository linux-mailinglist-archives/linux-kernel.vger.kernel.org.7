Return-Path: <linux-kernel+bounces-893788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844F3C485D9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E1E188971E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C02D879C;
	Mon, 10 Nov 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sx4BEZf5"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FA92D8790
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796026; cv=none; b=O1eFQpqg0YIe4HJ+TFZex1/YylKz7NzJ1xy29IqEASXQcUrDKN+ZtYil+MAg4jsoMu6y7asrmAp03CF0/XhbijntoHQDYFJUD/fv9DxRK7Z3xirG7vHgqRU1yDVAVbjSL9dXlprhbyYjlfh5bCZonNiL1n2WIEBvSlvy53wdcDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796026; c=relaxed/simple;
	bh=epQWzE9IqdOYIvIMjtycLMzjv8i/QGwMZGi4GnaEnFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1gZzb47QUVD4Klh2HkRCKWVJ8kpv3nlJpAQYaKOzsJYLB0PMpb7X8XpChcCFw29krIFRBX2CFU0bQY+fe9+W6i4VutwGhGnuCR3arrVei6NiI5Qbi4AiX+fbZQoGlk6i7nSzonHa9H9YjrYkWaeHf7Pt8Q1xZOE/N8zHvUgBAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sx4BEZf5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so15730625e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762796021; x=1763400821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9ofbGBR+xMrQIIY1/AJwTKYKF4NQnUPu2a6hkEzIaU=;
        b=Sx4BEZf55q/iyHKTO8YqY8KQ5S82BCE46x2v2nx8yGDZ3yInq+u8ECqauHk6PxavQ2
         9EksUWQfe4GOOvYsV4QQfD3WaaK6Ll87Fz472NzeAK8DxzvDrTfppb83gW6+dmfpKN+6
         fSJVfAHCkbAehEctlTO4dEjLut9lIkP/CdvARH00vTT1EerSjABtdMybjlr1vS2GWBX+
         hRJ/qYgzrv1kQczEhd08hy2gzwSpE9LLu0Up0Fw5568n/atCYjn7jCLbe16i0JYZ5fcq
         5yHRPcUDjlyMuUN0ULhTtANo8xzQoqjkcWaivUwaMgjT7LqBufFjK6gtd+3JxXBqzDLJ
         zHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796021; x=1763400821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9ofbGBR+xMrQIIY1/AJwTKYKF4NQnUPu2a6hkEzIaU=;
        b=gOXbJXcoQY18fwTNB5AUann48QDKkpvDGJ3zW1POipqAoVx7tfUeQGqwkZg0PtysRS
         eqfCUNDw81Q+P7mbHPCBXYCYT44NWsVWiQ36kc30Ti6GcYvAFYkmTbXAInqd0DrBteNl
         uNC8OdsbWhCCA4taTS6s29ijrNkRXhqB/jwPG2bz251UZMt0iHct3pyqR/feGgVNtQaK
         LWafYw4oGtudvVJkhUYuTdazC6CifqOMrmAM2lV2Lvzwdr6RwXO/WRidNFfmQnXbA5+h
         vgAUHW4HkB4yW5QMFOOQDMYgHh5YW10GuNpCDMBW1lYaMLUMvVO8cD+jwcRb9bJ6KNtJ
         j5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgsenl6lgYZpH1oj4G7hQHHJgEMygdjvXBjGe2D/pBg1jQpvgYh7Hvsv5VFyRKCPeEiCMXtajydIyKRp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4outkE4LugIG8NFOJC/e1otcorcKjg6DUi9PBxMvzBpsUCdtS
	HthHYxISoJ/TGuv2wUirq1vn8GV5nfDh/Ddi3CoAFzVqHw8socboHWGkf+036vQIa5o=
X-Gm-Gg: ASbGncvSmWgbtbfBRjW8S6EkY18UaTX37Lv6fyQn/mDDDLJ/Eq1sRb0z+WhKBcActHE
	T0hMsYFDatFCipKVazdSGvU9BHCulw7m4QV2OB/O048L36lrzDrjOb8V+1SHLW7jDARSNiRt0fe
	CjBxhlfArTXqGYHJyW/LMN0+eosyrZcT+Mo3uPi56REQxCLfOTwFkoe9RVD1iUgIvbI3q3NLBQ4
	CACOfYWG3pHjOUi432A8zMEGsOgm6d83wfSpDwh2PWHhZWJSOeTE0xiiRKXf1GwDaVUXuiuuCjc
	q4LhmLWrPz5gg1oCjyFZQLOMQyGjLnaumMqG+n0fH3RmLOoJBiZVFIMyZfQ9sEc66flyh0ZrUEn
	ZI8NTicnENVwc7LtpPgdSWZRzgQVNJxBM/L1E+deyGc0voI/yWowU1WTI/jnq/Tzf72MMbCbZOf
	z86G+NgnDy8jdsE0iGWhE=
X-Google-Smtp-Source: AGHT+IEcx7V5e1K9hFIE7Sp7bOLUQK45hDxORgECM+xzDTmKuw+QSLpz4BfkjwtSz2xqwGgrOPMCQw==
X-Received: by 2002:a05:600c:1990:b0:475:dc98:4489 with SMTP id 5b1f17b1804b1-4777329e327mr91569485e9.33.1762796020234;
        Mon, 10 Nov 2025 09:33:40 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:d5ec:666a:8d59:87fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47774df2d80sm140111375e9.14.2025.11.10.09.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:33:39 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 3/4 v4] PCI: s32g: Add initial PCIe support (RC)
Date: Mon, 10 Nov 2025 18:33:33 +0100
Message-ID: <20251110173334.234303-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110173334.234303-1-vincent.guittot@linaro.org>
References: <20251110173334.234303-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support of the PCIe controller for S32G Soc family. Only
host mode is supported.

Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 .../pci/controller/dwc/pcie-nxp-s32g-regs.h   |  27 ++
 drivers/pci/controller/dwc/pcie-nxp-s32g.c    | 435 ++++++++++++++++++
 4 files changed, 473 insertions(+)
 create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
 create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g.c

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 349d4657393c..e276956c3fca 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -256,6 +256,16 @@ config PCIE_TEGRA194_EP
 	  in order to enable device-specific features PCIE_TEGRA194_EP must be
 	  selected. This uses the DesignWare core.
 
+config PCIE_NXP_S32G
+	tristate "NXP S32G PCIe controller (host mode)"
+	depends on ARCH_S32 || COMPILE_TEST
+	select PCIE_DW_HOST
+	help
+	  Enable support for the PCIe controller in NXP S32G based boards to
+	  work in Host mode. The controller is based on DesignWare IP and
+	  can work either as RC or EP. In order to enable host-specific
+	  features PCIE_NXP_S32G must be selected.
+
 config PCIE_DW_PLAT
 	bool
 
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 7ae28f3b0fb3..3301bbbad78c 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
 obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
+obj-$(CONFIG_PCIE_NXP_S32G) += pcie-nxp-s32g.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
new file mode 100644
index 000000000000..c264446a8f21
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2015-2016 Freescale Semiconductor, Inc.
+ * Copyright 2016-2023, 2025 NXP
+ */
+
+#ifndef PCIE_S32G_REGS_H
+#define PCIE_S32G_REGS_H
+
+/* PCIe controller Sub-System */
+
+/* PCIe controller 0 General Control 1 */
+#define PCIE_S32G_PE0_GEN_CTRL_1		0x50
+#define DEVICE_TYPE_MASK			GENMASK(3, 0)
+#define SRIS_MODE				BIT(8)
+
+/* PCIe controller 0 General Control 3 */
+#define PCIE_S32G_PE0_GEN_CTRL_3		0x58
+#define LTSSM_EN				BIT(0)
+
+/* PCIe Controller 0 Link Debug 2 */
+#define PCIE_S32G_PE0_LINK_DBG_2		0xB4
+#define SMLH_LTSSM_STATE_MASK			GENMASK(5, 0)
+#define SMLH_LINK_UP				BIT(6)
+#define RDLH_LINK_UP				BIT(7)
+
+#endif  /* PCI_S32G_REGS_H */
diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
new file mode 100644
index 000000000000..18bf0fe6f416
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for NXP S32G SoCs
+ *
+ * Copyright 2019-2025 NXP
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/memblock.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/pci.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+#include "pcie-designware.h"
+#include "pcie-nxp-s32g-regs.h"
+
+struct s32g_pcie_port {
+	struct list_head list;
+	struct phy *phy;
+};
+
+struct s32g_pcie {
+	struct dw_pcie	pci;
+	void __iomem *ctrl_base;
+	struct list_head ports;
+};
+
+#define to_s32g_from_dw_pcie(x) \
+	container_of(x, struct s32g_pcie, pci)
+
+static void s32g_pcie_writel_ctrl(struct s32g_pcie *s32g_pp, u32 reg, u32 val)
+{
+	writel(val, s32g_pp->ctrl_base + reg);
+}
+
+static u32 s32g_pcie_readl_ctrl(struct s32g_pcie *s32g_pp, u32 reg)
+{
+	return readl(s32g_pp->ctrl_base + reg);
+}
+
+static void s32g_pcie_enable_ltssm(struct s32g_pcie *s32g_pp)
+{
+	u32 reg;
+
+	reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3);
+	reg |= LTSSM_EN;
+	s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3, reg);
+}
+
+static void s32g_pcie_disable_ltssm(struct s32g_pcie *s32g_pp)
+{
+	u32 reg;
+
+	reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3);
+	reg &= ~LTSSM_EN;
+	s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3, reg);
+}
+
+static bool is_s32g_pcie_ltssm_enabled(struct s32g_pcie *s32g_pp)
+{
+	return (s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_3) & LTSSM_EN);
+}
+
+static enum dw_pcie_ltssm s32g_pcie_get_ltssm(struct dw_pcie *pci)
+{
+	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
+	u32 reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_LINK_DBG_2);
+
+	return (enum dw_pcie_ltssm)FIELD_GET(SMLH_LTSSM_STATE_MASK, reg);
+}
+
+#define PCIE_LINKUP	(SMLH_LINK_UP | RDLH_LINK_UP)
+
+static bool s32g_has_data_phy_link(struct s32g_pcie *s32g_pp)
+{
+	u32 reg = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_LINK_DBG_2);
+
+	if ((reg & PCIE_LINKUP) == PCIE_LINKUP) {
+		switch (FIELD_GET(SMLH_LTSSM_STATE_MASK, reg)) {
+		case DW_PCIE_LTSSM_L0:
+		case DW_PCIE_LTSSM_L0S:
+		case DW_PCIE_LTSSM_L1_IDLE:
+			return true;
+		default:
+			return false;
+		}
+	}
+
+	return false;
+}
+
+static bool s32g_pcie_link_up(struct dw_pcie *pci)
+{
+	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
+
+	if (!is_s32g_pcie_ltssm_enabled(s32g_pp))
+		return false;
+
+	return s32g_has_data_phy_link(s32g_pp);
+}
+
+static int s32g_pcie_start_link(struct dw_pcie *pci)
+{
+	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
+
+	s32g_pcie_enable_ltssm(s32g_pp);
+
+	return 0;
+}
+
+static void s32g_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
+
+	s32g_pcie_disable_ltssm(s32g_pp);
+}
+
+static struct dw_pcie_ops s32g_pcie_ops = {
+	.get_ltssm = s32g_pcie_get_ltssm,
+	.link_up = s32g_pcie_link_up,
+	.start_link = s32g_pcie_start_link,
+	.stop_link = s32g_pcie_stop_link,
+};
+
+/* Configure the AMBA AXI Coherency Extensions (ACE) interface */
+static void s32g_pcie_reset_mstr_ace(struct dw_pcie *pci, u64 ddr_base_addr)
+{
+	u32 ddr_base_low = lower_32_bits(ddr_base_addr);
+	u32 ddr_base_high = upper_32_bits(ddr_base_addr);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, 0x0);
+
+	/*
+	 * Ncore is a cache-coherent interconnect module that enables the
+	 * integration of heterogeneous coherent and non-coherent agents in
+	 * the chip. Ncore Transactions to peripheral should be non-coherent
+	 * or it might drop them.
+	 *
+	 * One example where this is needed are PCIe MSIs, which use NoSnoop=0
+	 * and might end up routed to Ncore.
+	 * Define the start of DDR as seen by Linux as the boundary between
+	 * "memory" and "peripherals", with peripherals being below.
+	 */
+	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_1_OFF,
+			   (ddr_base_low & CFG_MEMTYPE_BOUNDARY_LOW_ADDR_MASK));
+	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_2_OFF, ddr_base_high);
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
+static int s32g_init_pcie_controller(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct s32g_pcie *s32g_pp = to_s32g_from_dw_pcie(pci);
+	u32 val;
+
+	/* Set RP mode */
+	val = s32g_pcie_readl_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1);
+	val &= ~DEVICE_TYPE_MASK;
+	val |= FIELD_PREP(DEVICE_TYPE_MASK, PCI_EXP_TYPE_ROOT_PORT);
+
+	/* Use default CRNS */
+	val &= ~SRIS_MODE;
+
+	s32g_pcie_writel_ctrl(s32g_pp, PCIE_S32G_PE0_GEN_CTRL_1, val);
+
+	/*
+	 * Make sure we use the coherency defaults (just in case the settings
+	 * have been changed from their reset values)
+	 */
+	s32g_pcie_reset_mstr_ace(pci, memblock_start_of_DRAM());
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
+	val |= PORT_FORCE_DO_DESKEW_FOR_SRIS;
+	dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
+
+	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
+	val |= GEN3_RELATED_OFF_EQ_PHASE_2_3;
+	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops s32g_pcie_host_ops = {
+	.init = s32g_init_pcie_controller,
+};
+
+static int s32g_init_pcie_phy(struct s32g_pcie *s32g_pp)
+{
+	struct dw_pcie *pci = &s32g_pp->pci;
+	struct device *dev = pci->dev;
+	struct s32g_pcie_port *port, *tmp;
+	int ret;
+
+	list_for_each_entry(port, &s32g_pp->ports, list) {
+		ret = phy_init(port->phy);
+		if (ret) {
+			dev_err(dev, "Failed to init serdes PHY\n");
+			goto err_phy_revert;
+		}
+
+		ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, 0);
+		if (ret) {
+			dev_err(dev, "Failed to set mode on serdes PHY\n");
+			goto err_phy_exit;
+		}
+
+		ret = phy_power_on(port->phy);
+		if (ret) {
+			dev_err(dev, "Failed to power on serdes PHY\n");
+			goto err_phy_exit;
+		}
+	}
+
+	return 0;
+
+err_phy_exit:
+	phy_exit(port->phy);
+
+err_phy_revert:
+	list_for_each_entry_continue_reverse(port, &s32g_pp->ports, list) {
+		phy_power_off(port->phy);
+		phy_exit(port->phy);
+	}
+
+	list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
+		list_del(&port->list);
+
+	return ret;
+}
+
+static void s32g_deinit_pcie_phy(struct s32g_pcie *s32g_pp)
+{
+	struct s32g_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list) {
+		phy_power_off(port->phy);
+		phy_exit(port->phy);
+		list_del(&port->list);
+	}
+}
+
+static int s32g_pcie_init(struct device *dev, struct s32g_pcie *s32g_pp)
+{
+	int ret;
+
+	s32g_pcie_disable_ltssm(s32g_pp);
+
+	ret = s32g_init_pcie_phy(s32g_pp);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void s32g_pcie_deinit(struct s32g_pcie *s32g_pp)
+{
+	s32g_pcie_disable_ltssm(s32g_pp);
+
+	s32g_deinit_pcie_phy(s32g_pp);
+}
+
+static int s32g_pcie_parse_port(struct s32g_pcie *s32g_pp, struct device_node *node)
+{
+	struct device *dev = s32g_pp->pci.dev;
+	struct s32g_pcie_port *port;
+	int num_lanes;
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->phy = devm_of_phy_get(dev, node, NULL);
+	if (IS_ERR(port->phy))
+		return dev_err_probe(dev, PTR_ERR(port->phy),
+				"Failed to get serdes PHY\n");
+
+	INIT_LIST_HEAD(&port->list);
+	list_add_tail(&port->list, &s32g_pp->ports);
+
+	/*
+	 * The DWC core initialization code cannot parse yet the num-lanes
+	 * attribute in the Root Port node. The S32G only supports one Root
+	 * Port for now so its driver can parse the node and set the num_lanes
+	 * field of struct dwc_pcie before calling dw_pcie_host_init().
+	 */
+	if (!of_property_read_u32(node, "num-lanes", &num_lanes))
+		s32g_pp->pci.num_lanes = num_lanes;
+
+	return 0;
+}
+
+static int s32g_pcie_parse_ports(struct device *dev, struct s32g_pcie *s32g_pp)
+{
+	struct s32g_pcie_port *port, *tmp;
+	int ret = -ENOENT;
+
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+		if (!of_node_is_type(of_port, "pci"))
+			continue;
+		ret = s32g_pcie_parse_port(s32g_pp, of_port);
+		if (ret)
+			goto err_port;
+	}
+
+err_port:
+	list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
+		list_del(&port->list);
+
+	return ret;
+}
+
+static int s32g_pcie_get_resources(struct platform_device *pdev,
+				   struct s32g_pcie *s32g_pp)
+{
+	struct dw_pcie *pci = &s32g_pp->pci;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	pci->dev = dev;
+	pci->ops = &s32g_pcie_ops;
+
+	s32g_pp->ctrl_base = devm_platform_ioremap_resource_byname(pdev, "ctrl");
+	if (IS_ERR(s32g_pp->ctrl_base))
+		return PTR_ERR(s32g_pp->ctrl_base);
+
+	INIT_LIST_HEAD(&s32g_pp->ports);
+
+	ret = s32g_pcie_parse_ports(dev, s32g_pp);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				"Failed to parse Root Port: %d\n", ret);
+
+	platform_set_drvdata(pdev, s32g_pp);
+
+	return 0;
+}
+
+static int s32g_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct s32g_pcie *s32g_pp;
+	struct dw_pcie_rp *pp;
+	int ret;
+
+	s32g_pp = devm_kzalloc(dev, sizeof(*s32g_pp), GFP_KERNEL);
+	if (!s32g_pp)
+		return -ENOMEM;
+
+	ret = s32g_pcie_get_resources(pdev, s32g_pp);
+	if (ret)
+		return ret;
+
+	pm_runtime_no_callbacks(dev);
+	devm_pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		goto err_pm_runtime_put;
+
+	ret = s32g_pcie_init(dev, s32g_pp);
+	if (ret)
+		goto err_pm_runtime_put;
+
+	pp = &s32g_pp->pci.pp;
+	pp->ops = &s32g_pcie_host_ops;
+	pp->use_atu_msg = true;
+
+	ret = dw_pcie_host_init(pp);
+	if (ret)
+		goto err_pcie_deinit;
+
+	return 0;
+
+err_pcie_deinit:
+	s32g_pcie_deinit(s32g_pp);
+err_pm_runtime_put:
+	pm_runtime_put(dev);
+
+	return ret;
+}
+
+static int s32g_pcie_suspend_noirq(struct device *dev)
+{
+	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &s32g_pp->pci;
+
+	return dw_pcie_suspend_noirq(pci);
+}
+
+static int s32g_pcie_resume_noirq(struct device *dev)
+{
+	struct s32g_pcie *s32g_pp = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &s32g_pp->pci;
+
+	return dw_pcie_resume_noirq(pci);
+}
+
+static const struct dev_pm_ops s32g_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(s32g_pcie_suspend_noirq,
+				  s32g_pcie_resume_noirq)
+};
+
+static const struct of_device_id s32g_pcie_of_match[] = {
+	{ .compatible = "nxp,s32g2-pcie" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, s32g_pcie_of_match);
+
+static struct platform_driver s32g_pcie_driver = {
+	.driver = {
+		.name	= "s32g-pcie",
+		.of_match_table = s32g_pcie_of_match,
+		.suppress_bind_attrs = true,
+		.pm = pm_sleep_ptr(&s32g_pcie_pm_ops),
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe = s32g_pcie_probe,
+};
+
+module_platform_driver(s32g_pcie_driver);
+
+MODULE_AUTHOR("Ionut Vicovan <Ionut.Vicovan@nxp.com>");
+MODULE_DESCRIPTION("NXP S32G PCIe Host controller driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


