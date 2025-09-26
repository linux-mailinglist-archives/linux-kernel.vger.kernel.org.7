Return-Path: <linux-kernel+bounces-833786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A00F2BA3120
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F23BE7B125B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3938329CB4D;
	Fri, 26 Sep 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SwbrWYyN"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36660279DDD;
	Fri, 26 Sep 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877525; cv=none; b=KDpdqwEtFQH5jOWHIZtDszlwHoTKbbIPl3Yal5/0lOqkUfd8NMkJOMKA00AK8KDC/0wlDS6rPp7wfZuLwA74lp9CdxJzKJ+BPfaWyua61OA2nDx525doOWhKSjoMWQ8JrkODDGDlCj+p3lRZgxJbZt/KpALcVNViaeaJzIZyA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877525; c=relaxed/simple;
	bh=MGT7M3ho+6f2a7H56V1e5bSJ+/b8/yfyKV3uaQ1SEEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtO5haJvUU2vpdBKt+wI8KL6I7qHnHYAr3v2l0SVaTb9OcafsV5fsXTr5yOERczfjZzDTyUtcfZlNu3zGSTeWsuqunjr0HcNMIwDKfPB9DRl0jGhNszsovcduG0Jy6/5mf3N/mZsIxlw0tA1/5rNMS7eTvGKh1CjK9B7Aw11j00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SwbrWYyN; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eb4bec889ab711f0b33aeb1e7f16c2b6-20250926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XsEdkxZdfIK6EVNlkW4okmzuOpoq4VM/hmomJzMKJ7I=;
	b=SwbrWYyN0asnIR1fiLQ+asGKDq4MLQ4U/X+ASh6xuA8tM3MzL/tXEhIBCf/uVD1o6h0BbPZkXfI4jwjwR/TyLl3J6Ni97IKG7cXnA68yMHdCgLOxcr4krzHwTNqXvufwGMzi9mCMcvNgg7i0y7+MumB4s9yYoX0O7iLX2oHoIDg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ab7397bd-6e9b-4b67-af49-1241ab1c4ef9,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:5f1ce121-c299-443d-bb51-d77d2f000e20,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: eb4bec889ab711f0b33aeb1e7f16c2b6-20250926
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 299667676; Fri, 26 Sep 2025 17:05:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Sep 2025 17:05:11 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 26 Sep 2025 17:05:10 +0800
From: Jjian Zhou <jjian.zhou@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Jjian Zhou
	<Jjian.Zhou@mediatek.com>, Chen-Yu Tsai <wenst@chromium.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jjian Zhou
	<jjian.zhou@mediatek.com>
Subject: [PATCH v6 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Date: Fri, 26 Sep 2025 17:05:00 +0800
Message-ID: <20250926090505.26267-3-jjian.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250926090505.26267-1-jjian.zhou@mediatek.com>
References: <20250926090505.26267-1-jjian.zhou@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add mtk-vcp-mailbox driver to support the communication with
VCP remote microprocessor.

Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
---
 drivers/mailbox/Kconfig                 |   9 ++
 drivers/mailbox/Makefile                |   2 +
 drivers/mailbox/mtk-vcp-mailbox.c       | 168 ++++++++++++++++++++++++
 include/linux/mailbox/mtk-vcp-mailbox.h |  32 +++++
 4 files changed, 211 insertions(+)
 create mode 100644 drivers/mailbox/mtk-vcp-mailbox.c
 create mode 100644 include/linux/mailbox/mtk-vcp-mailbox.h

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 02432d4a5ccd..c28bdb855663 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -294,6 +294,15 @@ config MTK_CMDQ_MBOX
 	  critical time limitation, such as updating display configuration
 	  during the vblank.
 
+config MTK_VCP_MBOX
+	tristate "MediaTek VCP Mailbox Support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	help
+	  Say yes here to add support for the MediaTek VCP mailbox driver.
+	  The mailbox implementation provides access from the application
+	  processor to Video Companion Processor Unit.
+	  If unsure say N.
+
 config ZYNQMP_IPI_MBOX
 	tristate "Xilinx ZynqMP IPI Mailbox"
 	depends on ARCH_ZYNQMP && OF
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 98a68f838486..07278871d254 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -63,6 +63,8 @@ obj-$(CONFIG_MTK_ADSP_MBOX)	+= mtk-adsp-mailbox.o
 
 obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
 
+obj-$(CONFIG_MTK_VCP_MBOX)	+= mtk-vcp-mailbox.o
+
 obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
 
 obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
diff --git a/drivers/mailbox/mtk-vcp-mailbox.c b/drivers/mailbox/mtk-vcp-mailbox.c
new file mode 100644
index 000000000000..a2a80d124e50
--- /dev/null
+++ b/drivers/mailbox/mtk-vcp-mailbox.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Corporation. All rights reserved.
+ * Author: Jjian Zhou <jjian.zhou.@mediatek.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox/mtk-vcp-mailbox.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct mtk_vcp_mbox {
+	struct mbox_controller mbox;
+	void __iomem *base;
+	struct device *dev;
+	const struct mtk_vcp_mbox_cfg *cfg;
+	struct mtk_ipi_info ipi_recv;
+	struct mbox_chan chans;
+};
+
+struct mtk_vcp_mbox_cfg {
+	u32 set_in;
+	u32 clr_out;
+};
+
+static irqreturn_t mtk_vcp_mbox_irq_thread(int irq, void *data)
+{
+	struct mtk_vcp_mbox *priv = data;
+
+	/* get irq status */
+	priv->ipi_recv.irq_status = readl(priv->base + priv->cfg->clr_out);
+
+	__ioread32_copy(priv->ipi_recv.msg, priv->base, MBOX_SLOT_MAX_SIZE / 4);
+
+	mbox_chan_received_data(&priv->chans, &priv->ipi_recv);
+
+	/* clear irq status */
+	writel(priv->ipi_recv.irq_status, priv->base + priv->cfg->clr_out);
+
+	return IRQ_HANDLED;
+}
+
+static struct mbox_chan *mtk_vcp_mbox_xlate(struct mbox_controller *mbox,
+					    const struct of_phandle_args *sp)
+{
+	if (sp->args_count)
+		return NULL;
+
+	return &mbox->chans[0];
+}
+
+static int mtk_vcp_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct mtk_vcp_mbox *priv = chan->con_priv;
+	struct mtk_ipi_info *ipi_info = data;
+	u32 status;
+
+	if (!ipi_info->msg) {
+		dev_err(priv->dev, "msg buffer is NULL.\n");
+		return -EINVAL;
+	}
+
+	status = readl(priv->base + priv->cfg->set_in) & BIT(ipi_info->index);
+	if (status) {
+		dev_warn(priv->dev, "mailbox IPI %d is busy.\n", ipi_info->id);
+		return -EBUSY;
+	}
+
+	if (ipi_info->slot_ofs + ipi_info->len > MBOX_SLOT_MAX_SIZE)
+		return -EINVAL;
+	__iowrite32_copy(priv->base + ipi_info->slot_ofs, ipi_info->msg,
+			 ipi_info->len);
+
+	writel(BIT(ipi_info->index), priv->base + priv->cfg->set_in);
+
+	return 0;
+}
+
+static bool mtk_vcp_mbox_last_tx_done(struct mbox_chan *chan)
+{
+	struct mtk_ipi_info *ipi_info = chan->active_req;
+	struct mtk_vcp_mbox *priv = chan->con_priv;
+
+	return !(readl(priv->base + priv->cfg->set_in) & BIT(ipi_info->index));
+}
+
+static const struct mbox_chan_ops mtk_vcp_mbox_chan_ops = {
+	.send_data	= mtk_vcp_mbox_send_data,
+	.last_tx_done	= mtk_vcp_mbox_last_tx_done,
+};
+
+static int mtk_vcp_mbox_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_vcp_mbox *priv;
+	struct mbox_controller *mbox;
+	int ret, irq;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	priv->chans.con_priv = priv;
+	mbox = &priv->mbox;
+	mbox->dev = dev;
+	mbox->ops = &mtk_vcp_mbox_chan_ops;
+	mbox->txdone_irq = false;
+	mbox->txdone_poll = true;
+	mbox->of_xlate = mtk_vcp_mbox_xlate;
+	mbox->num_chans = 1;
+	mbox->chans = &priv->chans;
+
+	priv->ipi_recv.msg = devm_kzalloc(dev, MBOX_SLOT_MAX_SIZE, GFP_KERNEL);
+	if (!priv->ipi_recv.msg)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->cfg = of_device_get_match_data(dev);
+	if (!priv->cfg)
+		return -EINVAL;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL,
+					mtk_vcp_mbox_irq_thread, IRQF_ONESHOT,
+					dev_name(dev), priv);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, priv);
+
+	return devm_mbox_controller_register(dev, &priv->mbox);
+}
+
+static const struct mtk_vcp_mbox_cfg mt8196_cfg = {
+	.set_in		= 0x100,
+	.clr_out	= 0x10c,
+};
+
+static const struct of_device_id mtk_vcp_mbox_of_match[] = {
+	{ .compatible = "mediatek,mt8196-vcp-mbox", .data = &mt8196_cfg },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_vcp_mbox_of_match);
+
+static struct platform_driver mtk_vcp_mbox_driver = {
+	.probe		= mtk_vcp_mbox_probe,
+	.driver = {
+		.name	= "mtk_vcp_mbox",
+		.of_match_table = mtk_vcp_mbox_of_match,
+	},
+};
+module_platform_driver(mtk_vcp_mbox_driver);
+
+MODULE_AUTHOR("Jjian Zhou <jjian.zhou@mediatek.com>");
+MODULE_DESCRIPTION("MTK VCP Mailbox Controller");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mailbox/mtk-vcp-mailbox.h b/include/linux/mailbox/mtk-vcp-mailbox.h
new file mode 100644
index 000000000000..143fb0d06e30
--- /dev/null
+++ b/include/linux/mailbox/mtk-vcp-mailbox.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ */
+
+#ifndef __MTK_VCP_MAILBOX_H__
+#define __MTK_VCP_MAILBOX_H__
+
+#define MBOX_SLOT_MAX_SIZE	0x100 /* mbox max slot size */
+
+/**
+ * struct mtk_ipi_info - mailbox message info for mtk-vcp-mailbox
+ * @msg: The share buffer between IPC and mailbox driver
+ * @len: Message length
+ * @id: This is for identification purposes and not actually used
+ *	by the mailbox hardware.
+ * @index: The signal number of the mailbox message.
+ * @slot_ofs: Data slot offset.
+ * @irq_status: Captures incoming signals for the RX path.
+ *
+ * It is used between IPC with mailbox driver.
+ */
+struct mtk_ipi_info {
+	void *msg;
+	u32 len;
+	u32 id;
+	u32 index;
+	u32 slot_ofs;
+	u32 irq_status;
+};
+
+#endif
-- 
2.45.2


