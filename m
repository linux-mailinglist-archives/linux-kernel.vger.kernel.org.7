Return-Path: <linux-kernel+bounces-855842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADA3BE2786
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2BB3E2DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1E031987A;
	Thu, 16 Oct 2025 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FTLo6um0"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5433002DC;
	Thu, 16 Oct 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607605; cv=none; b=DdZhkN78Jl4PKAfvDFfbvn0l8JmmLWYf9LKeegV0KOcsz784n7ActWNo60A0iS+FaZBPe9/2AAePPLyl1vxy4tihmoomw+Jk6fbPp7WNgThpg32uMmiMA+PoDZYmlt7gjl+0K1xVo6lmr4fIo37IcUsl1Nx3Ydui8vjomI355M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607605; c=relaxed/simple;
	bh=8BtFjskRd48ujwF9mV6u4BWa5uALKCKGYtPUNvAu3p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbFLRAznEGlc2gtfmxSXl2daMbYOCF6ok9w98DHDVHIet9q5TNvEuMW4N6SlXoATlSL12eQoZVwMqkHswP1I4PyLMU9Ez04OeV2NLSAirVH4M9xOOvxKyBLKlRBuvFXEjkb/Ytn4AF3o+Y003DnbBJlenUCL0G+kEuCH9keAVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FTLo6um0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760607601;
	bh=8BtFjskRd48ujwF9mV6u4BWa5uALKCKGYtPUNvAu3p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTLo6um0n3bLRq7jjBuCz5jZkuUeJ5nwTKbmlTn9BMoB2HR+ywwvOT6vlfcZtSIl5
	 /G+MuLp+aAD8Cj2TPuxVsF9uTFLBydtaQhYlhpKs+Ugcfxg9w8rDxYD5KS4j1rqCel
	 N7Tt9+4qCllvv74pCO2nODfSGFjmEiBys3F+Urq9BDpjEMSVaaGtOC9rfo+k7Q0rEv
	 yAptFNXYk5Bq4la0nSZo2b3Qs3eYc3bMGnTIQ7oVz2ckwcyAecvIzZZTr4L7ryUFs8
	 75dQQ07BjVaD1UAb/EBT6i1rPyQB7SmdFtG8t9iRr6dCQHROiem3gCdRDUf7s92ya+
	 pQkCUj//WAHOA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8552E17E13A5;
	Thu, 16 Oct 2025 11:40:00 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	hsin-hsiung.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v3 2/5] spmi: mtk-pmif: Add multi-bus support for SPMI 2.0
Date: Thu, 16 Oct 2025 11:39:46 +0200
Message-ID: <20251016093949.127326-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016093949.127326-1-angelogioacchino.delregno@collabora.com>
References: <20251016093949.127326-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparation for adding support for MT8196/MT6991 SoCs having
multiple SPMI busses, move the bus specific parameters into a new
pmif_bus structure and keep the SoC-specific data in the already
existing struct pmif, and add means to register multiple SPMI
controllers.

While this needs a different devicetree node structure, where each
of the controllers are in subnodes of a main SPMI node, and where
each has its own resources (iospaces and clocks), support for the
legacy single-controller was retained and doesn't require any DT
change in the currently supported SoCs.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi-mtk-pmif.c | 235 +++++++++++++++++++++++------------
 1 file changed, 157 insertions(+), 78 deletions(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index 160d36f7d238..68f458587c67 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 //
 // Copyright (c) 2021 MediaTek Inc.
+// Copyright (c) 2025 Collabora Ltd
+//                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
 
 #include <linux/clk.h>
 #include <linux/iopoll.h>
@@ -25,6 +27,7 @@
 
 #define PMIF_CHAN_OFFSET 0x5
 
+#define PMIF_MAX_BUSES	2
 #define PMIF_MAX_CLKS	3
 
 #define SPMI_OP_ST_BUSY 1
@@ -41,16 +44,22 @@ struct pmif_data {
 	const u32	*regs;
 	const u32	*spmimst_regs;
 	u32	soc_chan;
+	u32	num_spmi_buses;
 };
 
-struct pmif {
+struct pmif_bus {
 	void __iomem	*base;
 	void __iomem	*spmimst_base;
-	struct ch_reg	chan;
+	struct spmi_controller *ctrl;
 	struct clk_bulk_data clks[PMIF_MAX_CLKS];
 	size_t nclks;
+	raw_spinlock_t	lock;
+};
+
+struct pmif {
+	struct pmif_bus bus[PMIF_MAX_BUSES];
+	struct ch_reg	chan;
 	const struct pmif_data *data;
-	raw_spinlock_t lock;
 };
 
 static const char * const pmif_clock_names[] = {
@@ -262,33 +271,41 @@ static const u32 mt8195_spmi_regs[] = {
 	[SPMI_MST_DBG] = 0x00FC,
 };
 
-static u32 pmif_readl(struct pmif *arb, enum pmif_regs reg)
+static inline struct pmif *to_mtk_pmif(struct spmi_controller *ctrl)
+{
+	return dev_get_drvdata(ctrl->dev.parent);
+}
+
+static u32 pmif_readl(struct pmif *arb, struct pmif_bus *pbus, enum pmif_regs reg)
 {
-	return readl(arb->base + arb->data->regs[reg]);
+	return readl(pbus->base + arb->data->regs[reg]);
 }
 
-static void pmif_writel(struct pmif *arb, u32 val, enum pmif_regs reg)
+static void pmif_writel(struct pmif *arb, struct pmif_bus *pbus,
+			u32 val, enum pmif_regs reg)
 {
-	writel(val, arb->base + arb->data->regs[reg]);
+	writel(val, pbus->base + arb->data->regs[reg]);
 }
 
-static void mtk_spmi_writel(struct pmif *arb, u32 val, enum spmi_regs reg)
+static void mtk_spmi_writel(struct pmif *arb, struct pmif_bus *pbus,
+			    u32 val, enum spmi_regs reg)
 {
-	writel(val, arb->spmimst_base + arb->data->spmimst_regs[reg]);
+	writel(val, pbus->spmimst_base + arb->data->spmimst_regs[reg]);
 }
 
-static bool pmif_is_fsm_vldclr(struct pmif *arb)
+static bool pmif_is_fsm_vldclr(struct pmif *arb, struct pmif_bus *pbus)
 {
 	u32 reg_rdata;
 
-	reg_rdata = pmif_readl(arb, arb->chan.ch_sta);
+	reg_rdata = pmif_readl(arb, pbus, arb->chan.ch_sta);
 
 	return GET_SWINF(reg_rdata) == SWINF_WFVLDCLR;
 }
 
 static int pmif_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid)
 {
-	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
+	struct pmif_bus *pbus = spmi_controller_get_drvdata(ctrl);
+	struct pmif *arb = to_mtk_pmif(ctrl);
 	u32 rdata, cmd;
 	int ret;
 
@@ -298,8 +315,8 @@ static int pmif_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid)
 
 	cmd = opc - SPMI_CMD_RESET;
 
-	mtk_spmi_writel(arb, (cmd << 0x4) | sid, SPMI_OP_ST_CTRL);
-	ret = readl_poll_timeout_atomic(arb->spmimst_base + arb->data->spmimst_regs[SPMI_OP_ST_STA],
+	mtk_spmi_writel(arb, pbus, (cmd << 0x4) | sid, SPMI_OP_ST_CTRL);
+	ret = readl_poll_timeout_atomic(pbus->spmimst_base + arb->data->spmimst_regs[SPMI_OP_ST_STA],
 					rdata, (rdata & SPMI_OP_ST_BUSY) == SPMI_OP_ST_BUSY,
 					PMIF_DELAY_US, PMIF_TIMEOUT_US);
 	if (ret < 0)
@@ -311,7 +328,8 @@ static int pmif_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid)
 static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 			      u16 addr, u8 *buf, size_t len)
 {
-	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
+	struct pmif_bus *pbus = spmi_controller_get_drvdata(ctrl);
+	struct pmif *arb = to_mtk_pmif(ctrl);
 	struct ch_reg *inf_reg;
 	int ret;
 	u32 data, cmd;
@@ -336,31 +354,31 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	else
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&arb->lock, flags);
+	raw_spin_lock_irqsave(&pbus->lock, flags);
 	/* Wait for Software Interface FSM state to be IDLE. */
 	inf_reg = &arb->chan;
-	ret = readl_poll_timeout_atomic(arb->base + arb->data->regs[inf_reg->ch_sta],
+	ret = readl_poll_timeout_atomic(pbus->base + arb->data->regs[inf_reg->ch_sta],
 					data, GET_SWINF(data) == SWINF_IDLE,
 					PMIF_DELAY_US, PMIF_TIMEOUT_US);
 	if (ret < 0) {
 		/* set channel ready if the data has transferred */
-		if (pmif_is_fsm_vldclr(arb))
-			pmif_writel(arb, 1, inf_reg->ch_rdy);
-		raw_spin_unlock_irqrestore(&arb->lock, flags);
+		if (pmif_is_fsm_vldclr(arb, pbus))
+			pmif_writel(arb, pbus, 1, inf_reg->ch_rdy);
+		raw_spin_unlock_irqrestore(&pbus->lock, flags);
 		dev_err(&ctrl->dev, "failed to wait for SWINF_IDLE\n");
 		return ret;
 	}
 
 	/* Send the command. */
 	cmd = (opc << 30) | (sid << 24) | ((len - 1) << 16) | addr;
-	pmif_writel(arb, cmd, inf_reg->ch_send);
-	raw_spin_unlock_irqrestore(&arb->lock, flags);
+	pmif_writel(arb, pbus, cmd, inf_reg->ch_send);
+	raw_spin_unlock_irqrestore(&pbus->lock, flags);
 
 	/*
 	 * Wait for Software Interface FSM state to be WFVLDCLR,
 	 * read the data and clear the valid flag.
 	 */
-	ret = readl_poll_timeout_atomic(arb->base + arb->data->regs[inf_reg->ch_sta],
+	ret = readl_poll_timeout_atomic(pbus->base + arb->data->regs[inf_reg->ch_sta],
 					data, GET_SWINF(data) == SWINF_WFVLDCLR,
 					PMIF_DELAY_US, PMIF_TIMEOUT_US);
 	if (ret < 0) {
@@ -368,9 +386,9 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 		return ret;
 	}
 
-	data = pmif_readl(arb, inf_reg->rdata);
+	data = pmif_readl(arb, pbus, inf_reg->rdata);
 	memcpy(buf, &data, len);
-	pmif_writel(arb, 1, inf_reg->ch_rdy);
+	pmif_writel(arb, pbus, 1, inf_reg->ch_rdy);
 
 	return 0;
 }
@@ -378,7 +396,8 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 			       u16 addr, const u8 *buf, size_t len)
 {
-	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
+	struct pmif_bus *pbus = spmi_controller_get_drvdata(ctrl);
+	struct pmif *arb = to_mtk_pmif(ctrl);
 	struct ch_reg *inf_reg;
 	int ret;
 	u32 data, wdata, cmd;
@@ -409,27 +428,27 @@ static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	/* Set the write data. */
 	memcpy(&wdata, buf, len);
 
-	raw_spin_lock_irqsave(&arb->lock, flags);
+	raw_spin_lock_irqsave(&pbus->lock, flags);
 	/* Wait for Software Interface FSM state to be IDLE. */
 	inf_reg = &arb->chan;
-	ret = readl_poll_timeout_atomic(arb->base + arb->data->regs[inf_reg->ch_sta],
+	ret = readl_poll_timeout_atomic(pbus->base + arb->data->regs[inf_reg->ch_sta],
 					data, GET_SWINF(data) == SWINF_IDLE,
 					PMIF_DELAY_US, PMIF_TIMEOUT_US);
 	if (ret < 0) {
 		/* set channel ready if the data has transferred */
-		if (pmif_is_fsm_vldclr(arb))
-			pmif_writel(arb, 1, inf_reg->ch_rdy);
-		raw_spin_unlock_irqrestore(&arb->lock, flags);
+		if (pmif_is_fsm_vldclr(arb, pbus))
+			pmif_writel(arb, pbus, 1, inf_reg->ch_rdy);
+		raw_spin_unlock_irqrestore(&pbus->lock, flags);
 		dev_err(&ctrl->dev, "failed to wait for SWINF_IDLE\n");
 		return ret;
 	}
 
-	pmif_writel(arb, wdata, inf_reg->wdata);
+	pmif_writel(arb, pbus, wdata, inf_reg->wdata);
 
 	/* Send the command. */
 	cmd = (opc << 30) | BIT(29) | (sid << 24) | ((len - 1) << 16) | addr;
-	pmif_writel(arb, cmd, inf_reg->ch_send);
-	raw_spin_unlock_irqrestore(&arb->lock, flags);
+	pmif_writel(arb, pbus, cmd, inf_reg->ch_send);
+	raw_spin_unlock_irqrestore(&pbus->lock, flags);
 
 	return 0;
 }
@@ -446,84 +465,143 @@ static const struct pmif_data mt8195_pmif_arb = {
 	.soc_chan = 2,
 };
 
-static int mtk_spmi_probe(struct platform_device *pdev)
+static int mtk_spmi_bus_probe(struct platform_device *pdev,
+			      struct device_node *node,
+			      const struct pmif_data *pdata,
+			      struct pmif_bus *pbus)
 {
-	struct pmif *arb;
 	struct spmi_controller *ctrl;
-	int err, i;
-	u32 chan_offset;
+	int err, idx, bus_id, i;
+
+	if (pdata->num_spmi_buses > 1)
+		bus_id = of_alias_get_id(node, "spmi");
+	else
+		bus_id = 0;
+
+	if (bus_id < 0)
+		return dev_err_probe(&pdev->dev, bus_id,
+				     "Cannot find SPMI Bus alias ID\n");
 
-	ctrl = devm_spmi_controller_alloc(&pdev->dev, sizeof(*arb));
+	ctrl = devm_spmi_controller_alloc(&pdev->dev, sizeof(*pbus));
 	if (IS_ERR(ctrl))
 		return PTR_ERR(ctrl);
 
-	arb = spmi_controller_get_drvdata(ctrl);
-	arb->data = device_get_match_data(&pdev->dev);
-	if (!arb->data) {
-		dev_err(&pdev->dev, "Cannot get drv_data\n");
+	pbus = spmi_controller_get_drvdata(ctrl);
+	pbus->ctrl = ctrl;
+
+	idx = of_property_match_string(node, "reg-names", "pmif");
+	if (idx < 0)
 		return -EINVAL;
-	}
 
-	arb->base = devm_platform_ioremap_resource_byname(pdev, "pmif");
-	if (IS_ERR(arb->base))
-		return PTR_ERR(arb->base);
+	pbus->base = devm_of_iomap(&pdev->dev, node, idx, NULL);
+	if (IS_ERR(pbus->base))
+		return PTR_ERR(pbus->base);
 
-	arb->spmimst_base = devm_platform_ioremap_resource_byname(pdev, "spmimst");
-	if (IS_ERR(arb->spmimst_base))
-		return PTR_ERR(arb->spmimst_base);
+	idx = of_property_match_string(node, "reg-names", "spmimst");
+	if (idx < 0)
+		return -EINVAL;
 
-	arb->nclks = ARRAY_SIZE(pmif_clock_names);
-	for (i = 0; i < arb->nclks; i++)
-		arb->clks[i].id = pmif_clock_names[i];
+	pbus->spmimst_base = devm_of_iomap(&pdev->dev, node, idx, NULL);
+	if (IS_ERR(pbus->spmimst_base))
+		return PTR_ERR(pbus->spmimst_base);
 
-	err = clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to get clocks: %d\n", err);
-		return err;
+	pbus->nclks = ARRAY_SIZE(pmif_clock_names);
+	for (i = 0; i < pbus->nclks; i++) {
+		pbus->clks[i].id = pmif_clock_names[i];
+		pbus->clks[i].clk = of_clk_get_by_name(node, pbus->clks[i].id);
+		if (IS_ERR(pbus->clks[i].clk))
+			return PTR_ERR(pbus->clks[i].clk);
 	}
 
-	err = clk_bulk_prepare_enable(arb->nclks, arb->clks);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to enable clocks: %d\n", err);
+	err = clk_bulk_prepare_enable(pbus->nclks, pbus->clks);
+	if (err)
 		goto err_put_clks;
-	}
 
 	ctrl->cmd = pmif_arb_cmd;
 	ctrl->read_cmd = pmif_spmi_read_cmd;
 	ctrl->write_cmd = pmif_spmi_write_cmd;
+	ctrl->dev.of_node = node;
+	dev_set_name(&ctrl->dev, "spmi-%d", bus_id);
 
-	chan_offset = PMIF_CHAN_OFFSET * arb->data->soc_chan;
-	arb->chan.ch_sta = PMIF_SWINF_0_STA + chan_offset;
-	arb->chan.wdata = PMIF_SWINF_0_WDATA_31_0 + chan_offset;
-	arb->chan.rdata = PMIF_SWINF_0_RDATA_31_0 + chan_offset;
-	arb->chan.ch_send = PMIF_SWINF_0_ACC + chan_offset;
-	arb->chan.ch_rdy = PMIF_SWINF_0_VLD_CLR + chan_offset;
-
-	raw_spin_lock_init(&arb->lock);
-
-	platform_set_drvdata(pdev, ctrl);
+	raw_spin_lock_init(&pbus->lock);
 
 	err = spmi_controller_add(ctrl);
 	if (err)
 		goto err_domain_remove;
 
+	pbus->ctrl = ctrl;
+
 	return 0;
 
 err_domain_remove:
-	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
+	clk_bulk_disable_unprepare(pbus->nclks, pbus->clks);
 err_put_clks:
-	clk_bulk_put(arb->nclks, arb->clks);
+	clk_bulk_put(pbus->nclks, pbus->clks);
 	return err;
 }
 
+static int mtk_spmi_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct pmif *arb;
+	u32 chan_offset;
+	u8 cur_bus = 0;
+	int ret;
+
+	arb = devm_kzalloc(&pdev->dev, sizeof(*arb), GFP_KERNEL);
+	if (!arb)
+		return -ENOMEM;
+
+	arb->data = device_get_match_data(&pdev->dev);
+	if (!arb->data) {
+		dev_err(&pdev->dev, "Cannot get drv_data\n");
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, arb);
+
+	if (!arb->data->num_spmi_buses) {
+		ret = mtk_spmi_bus_probe(pdev, node, arb->data, &arb->bus[cur_bus]);
+		if (ret)
+			return ret;
+	} else {
+		for_each_available_child_of_node_scoped(node, child) {
+			if (!of_node_name_eq(child, "spmi"))
+				continue;
+
+			ret = mtk_spmi_bus_probe(pdev, child, arb->data,
+						 &arb->bus[cur_bus]);
+			if (ret)
+				return ret;
+			cur_bus++;
+		}
+	}
+
+	chan_offset = PMIF_CHAN_OFFSET * arb->data->soc_chan;
+	arb->chan.ch_sta = PMIF_SWINF_0_STA + chan_offset;
+	arb->chan.wdata = PMIF_SWINF_0_WDATA_31_0 + chan_offset;
+	arb->chan.rdata = PMIF_SWINF_0_RDATA_31_0 + chan_offset;
+	arb->chan.ch_send = PMIF_SWINF_0_ACC + chan_offset;
+	arb->chan.ch_rdy = PMIF_SWINF_0_VLD_CLR + chan_offset;
+
+	return 0;
+}
+
 static void mtk_spmi_remove(struct platform_device *pdev)
 {
-	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
-	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
+	struct pmif *arb = platform_get_drvdata(pdev);
+	int i;
 
-	spmi_controller_remove(ctrl);
-	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
-	clk_bulk_put(arb->nclks, arb->clks);
+	for (i = 0; i < PMIF_MAX_BUSES; i++) {
+		struct pmif_bus *pbus = &arb->bus[i];
+
+		if (!pbus->ctrl)
+			continue;
+
+		spmi_controller_remove(pbus->ctrl);
+		clk_bulk_disable_unprepare(pbus->nclks, pbus->clks);
+		clk_bulk_put(pbus->nclks, pbus->clks);
+	}
 }
 
 static const struct of_device_id mtk_spmi_match_table[] = {
@@ -549,6 +627,7 @@ static struct platform_driver mtk_spmi_driver = {
 };
 module_platform_driver(mtk_spmi_driver);
 
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
 MODULE_AUTHOR("Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>");
 MODULE_DESCRIPTION("MediaTek SPMI Driver");
 MODULE_LICENSE("GPL");
-- 
2.51.0


