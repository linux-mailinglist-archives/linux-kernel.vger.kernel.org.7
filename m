Return-Path: <linux-kernel+bounces-777429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F08BB2D94B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C431883DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A892EF67F;
	Wed, 20 Aug 2025 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i6Fdn38y"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929B02DECC0;
	Wed, 20 Aug 2025 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683161; cv=none; b=R3KOpyE/8U9/55Axff3EIzBWZmgbqlKGHlk8hGQwB5Cx7Z/O4T6h6jl7+xciUGDdvm9adN0QorhBzckPnVf7SJCA5Pan5x1HG3hqzhjTwtzxecH61pAjY63znqstoP+6rIvfALJ0oXHjtpGAf9w3NmMczhvhNkfdf141/HnUC8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683161; c=relaxed/simple;
	bh=1YozS+i8jkW7lv9MhNw3Hs1hJYz3VqmM7W9tDv1US/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMgOXipmQAKDHKYd0L5OH63yqH0QGbLtiVs/+TOtpKW3mNhNUa5wc5nEQI8JxuWiK/SZt/Juez/rICpgPRnGtnYepMo2Ig7Ra7DNTi1IHpQSM8nWvVZdM/kVJzmIJV/hlehnwg/9HZzdhhMpa9U5V0Ozs2w66CAxR0g2zCDc/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=i6Fdn38y; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 761f448e7daa11f0b33aeb1e7f16c2b6-20250820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=adpM1Tc6z23ljyv7fv///mOfS5qWi2huzDH4dGeqvos=;
	b=i6Fdn38ymq9E8JBzHCdpcT0nh6pKaI9M4qTjZZgWFIo9+F/DJFtLwe8SbgyjRJFp3ltyEB4VrsdZ/EQNoztLK9hEfoT3eBKZEGNQawgrC4NNfIXqezjR3YDvih6OmhzvHKRBkuxADCN61K/3NamFdO0jyO5VNc69OGZW3psF5Uk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:7cf48df6-4587-4e2e-a798-4d1488f5185d,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:40b6547a-966c-41bd-96b5-7d0b3c22e782,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 761f448e7daa11f0b33aeb1e7f16c2b6-20250820
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1309138076; Wed, 20 Aug 2025 17:45:52 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 20 Aug 2025 17:45:50 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 20 Aug 2025 17:45:49 +0800
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
Subject: [PATCH v4 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Date: Wed, 20 Aug 2025 17:45:38 +0800
Message-ID: <20250820094545.23821-3-jjian.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250820094545.23821-1-jjian.zhou@mediatek.com>
References: <20250820094545.23821-1-jjian.zhou@mediatek.com>
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
 drivers/mailbox/mtk-vcp-mailbox.c       | 174 ++++++++++++++++++++++++
 include/linux/mailbox/mtk-vcp-mailbox.h |  32 +++++
 4 files changed, 217 insertions(+)
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
index 000000000000..6f48215896d2
--- /dev/null
+++ b/drivers/mailbox/mtk-vcp-mailbox.c
@@ -0,0 +1,174 @@
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
+struct mtk_vcp_mbox_priv {
+	void __iomem *base;
+	struct device *dev;
+	struct mbox_controller mbox;
+	const struct mtk_vcp_mbox_cfg *cfg;
+	struct mtk_ipi_info ipi_recv;
+};
+
+struct mtk_vcp_mbox_cfg {
+	u32 set_in;
+	u32 clr_out;
+};
+
+static inline struct mtk_vcp_mbox_priv *get_mtk_vcp_mbox_priv(struct mbox_controller *mbox)
+{
+	return container_of(mbox, struct mtk_vcp_mbox_priv, mbox);
+}
+
+static irqreturn_t mtk_vcp_mbox_irq_thread(int irq, void *data)
+{
+	struct mbox_chan *chan = data;
+	struct mtk_vcp_mbox_priv *priv = get_mtk_vcp_mbox_priv(chan->mbox);
+
+	/* get irq status */
+	priv->ipi_recv.irq_status = readl(priv->base + priv->cfg->clr_out);
+
+	__ioread32_copy(priv->ipi_recv.msg, priv->base, MBOX_SLOT_MAX_SIZE / 4);
+
+	mbox_chan_received_data(chan, &priv->ipi_recv);
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
+	return mbox->chans;
+}
+
+static int mtk_vcp_mbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct mtk_vcp_mbox_priv *priv = get_mtk_vcp_mbox_priv(chan->mbox);
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
+	struct mtk_vcp_mbox_priv *priv = get_mtk_vcp_mbox_priv(chan->mbox);
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
+	struct mtk_vcp_mbox_priv *priv;
+	struct mbox_controller *mbox;
+	int ret, irq;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	mbox = &priv->mbox;
+	mbox->dev = dev;
+	mbox->ops = &mtk_vcp_mbox_chan_ops;
+	mbox->txdone_irq = false;
+	mbox->txdone_poll = true;
+	mbox->of_xlate = mtk_vcp_mbox_xlate;
+	mbox->num_chans = 1;
+	mbox->chans = devm_kzalloc(dev, sizeof(*mbox->chans), GFP_KERNEL);
+	if (!mbox->chans)
+		return -ENOMEM;
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
+					dev_name(dev), mbox->chans);
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
+	.clr_out	= 0x10C,
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


