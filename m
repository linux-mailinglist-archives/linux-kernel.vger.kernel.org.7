Return-Path: <linux-kernel+bounces-836157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 989FBBA8E57
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 420361C23AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0932F2FC031;
	Mon, 29 Sep 2025 10:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PMayS3Me"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D12FBDF6;
	Mon, 29 Sep 2025 10:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759142012; cv=none; b=UKYHTjKUWTFzQZ/acc3c4vwtrfLWuJzua5g31EzZf844YbW116VLOUwkHE4cnbiHDcg5nqWKzKQMV3iG2xC7GiO5n+c5RL3/ZjYQAEwnS2Bho+i2ncz55oKKW5FMjEm065zlyhcDHgtq8Ne2Lthhzy3mSkiISzjA7M92qEi9snY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759142012; c=relaxed/simple;
	bh=VnSH6QTa5NpwE1TNlzdQCXuXVLs4Gn0vTe5U6PFFyig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lg7Ibpnuj9HIFKl/YSZq9dEmzudjsCvxb+MYR6qObhaI7rDX/B+jNNz5oJ5gPqm3lNRxVuKP3nYgwLVNTSgaQLthDaHyNuwYBnlNScQAs4uhPNINRjvPz07UgzP9nW8H2M+LpN0ouwPpyu8biKb2uJ0bDuCmRLD9pG0nTnjLqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PMayS3Me; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759142008;
	bh=VnSH6QTa5NpwE1TNlzdQCXuXVLs4Gn0vTe5U6PFFyig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PMayS3MeXGIR3X4kukcqHEuV7MXltaopARkXd3WrmcEx/bMqdlh7Vw2I5czb3ZWQ0
	 7dmnejiiyauAFmNf39VDrwELTBTB4Aadtulxe/AMyuNFD1k2FBFFNilXcYmhdnERrd
	 d8BDoZNIgfj5fA+KGVsU9bSRVt8d4Zd8Z3kwQbfwxc+gHMrQimIC/Emol81/qv5Zlq
	 LpFgbyomMCmNSrhsHfeuYgukjxcAiKBJGsoAzgECpRPbbZNPWiE8NEDJ6JQF52+Jnx
	 J7OjN0OhQCypMxq/er9JTYfaBm8AWyfRS4Dg3T1Ohk3GUx+rrFSsy1CniTn8hAqrDM
	 Zmmp3W7/4uSfA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A23F017E108C;
	Mon, 29 Sep 2025 12:33:27 +0200 (CEST)
Message-ID: <b62611ef-7ead-4bbe-8c96-d39e3c5c8dd8@collabora.com>
Date: Mon, 29 Sep 2025 12:33:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
To: Jjian Zhou <jjian.zhou@mediatek.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250926090505.26267-1-jjian.zhou@mediatek.com>
 <20250926090505.26267-3-jjian.zhou@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250926090505.26267-3-jjian.zhou@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 26/09/25 11:05, Jjian Zhou ha scritto:
> Add mtk-vcp-mailbox driver to support the communication with
> VCP remote microprocessor.
> 
> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> ---
>   drivers/mailbox/Kconfig                 |   9 ++
>   drivers/mailbox/Makefile                |   2 +
>   drivers/mailbox/mtk-vcp-mailbox.c       | 168 ++++++++++++++++++++++++
>   include/linux/mailbox/mtk-vcp-mailbox.h |  32 +++++
>   4 files changed, 211 insertions(+)
>   create mode 100644 drivers/mailbox/mtk-vcp-mailbox.c
>   create mode 100644 include/linux/mailbox/mtk-vcp-mailbox.h
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 02432d4a5ccd..c28bdb855663 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -294,6 +294,15 @@ config MTK_CMDQ_MBOX
>   	  critical time limitation, such as updating display configuration
>   	  during the vblank.
>   
> +config MTK_VCP_MBOX
> +	tristate "MediaTek VCP Mailbox Support"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	help
> +	  Say yes here to add support for the MediaTek VCP mailbox driver.
> +	  The mailbox implementation provides access from the application
> +	  processor to Video Companion Processor Unit.
> +	  If unsure say N.
> +
>   config ZYNQMP_IPI_MBOX
>   	tristate "Xilinx ZynqMP IPI Mailbox"
>   	depends on ARCH_ZYNQMP && OF
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index 98a68f838486..07278871d254 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -63,6 +63,8 @@ obj-$(CONFIG_MTK_ADSP_MBOX)	+= mtk-adsp-mailbox.o
>   
>   obj-$(CONFIG_MTK_CMDQ_MBOX)	+= mtk-cmdq-mailbox.o
>   
> +obj-$(CONFIG_MTK_VCP_MBOX)	+= mtk-vcp-mailbox.o
> +
>   obj-$(CONFIG_ZYNQMP_IPI_MBOX)	+= zynqmp-ipi-mailbox.o
>   
>   obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
> diff --git a/drivers/mailbox/mtk-vcp-mailbox.c b/drivers/mailbox/mtk-vcp-mailbox.c
> new file mode 100644
> index 000000000000..a2a80d124e50
> --- /dev/null
> +++ b/drivers/mailbox/mtk-vcp-mailbox.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 MediaTek Corporation. All rights reserved.
> + * Author: Jjian Zhou <jjian.zhou.@mediatek.com>
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox/mtk-vcp-mailbox.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +struct mtk_vcp_mbox {
> +	struct mbox_controller mbox;
> +	void __iomem *base;
> +	struct device *dev;
> +	const struct mtk_vcp_mbox_cfg *cfg;
> +	struct mtk_ipi_info ipi_recv;
> +	struct mbox_chan chans;
> +};
> +
> +struct mtk_vcp_mbox_cfg {
> +	u32 set_in;
> +	u32 clr_out;

u16 is enough for both register offsets, at least for now - and I suspect it's
going to be enough forever.

> +};
> +
> +static irqreturn_t mtk_vcp_mbox_irq_thread(int irq, void *data)
> +{
> +	struct mtk_vcp_mbox *priv = data;
> +
> +	/* get irq status */
> +	priv->ipi_recv.irq_status = readl(priv->base + priv->cfg->clr_out);
> +
> +	__ioread32_copy(priv->ipi_recv.msg, priv->base, MBOX_SLOT_MAX_SIZE / 4);
> +
> +	mbox_chan_received_data(&priv->chans, &priv->ipi_recv);
> +
> +	/* clear irq status */
> +	writel(priv->ipi_recv.irq_status, priv->base + priv->cfg->clr_out);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct mbox_chan *mtk_vcp_mbox_xlate(struct mbox_controller *mbox,
> +					    const struct of_phandle_args *sp)
> +{
> +	if (sp->args_count)
> +		return NULL;
> +
> +	return &mbox->chans[0];
> +}
> +
> +static int mtk_vcp_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct mtk_vcp_mbox *priv = chan->con_priv;
> +	struct mtk_ipi_info *ipi_info = data;
> +	u32 status;
> +
> +	if (!ipi_info->msg) {
> +		dev_err(priv->dev, "msg buffer is NULL.\n");
> +		return -EINVAL;
> +	}
> +
> +	status = readl(priv->base + priv->cfg->set_in) & BIT(ipi_info->index);

status = readl(priv->base + priv->cfg->set_in);
if (status & BIT(ipi_info->index) {
  ....
}

> +	if (status) {
> +		dev_warn(priv->dev, "mailbox IPI %d is busy.\n", ipi_info->id);
> +		return -EBUSY;
> +	}
> +
> +	if (ipi_info->slot_ofs + ipi_info->len > MBOX_SLOT_MAX_SIZE)
> +		return -EINVAL;
> +	__iowrite32_copy(priv->base + ipi_info->slot_ofs, ipi_info->msg,
> +			 ipi_info->len);
> +
> +	writel(BIT(ipi_info->index), priv->base + priv->cfg->set_in);
> +
> +	return 0;
> +}
> +
> +static bool mtk_vcp_mbox_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct mtk_ipi_info *ipi_info = chan->active_req;
> +	struct mtk_vcp_mbox *priv = chan->con_priv;
> +
> +	return !(readl(priv->base + priv->cfg->set_in) & BIT(ipi_info->index));
> +}
> +
> +static const struct mbox_chan_ops mtk_vcp_mbox_chan_ops = {
> +	.send_data	= mtk_vcp_mbox_send_data,
> +	.last_tx_done	= mtk_vcp_mbox_last_tx_done,
> +};
> +
> +static int mtk_vcp_mbox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_vcp_mbox *priv;
> +	struct mbox_controller *mbox;
> +	int ret, irq;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +	priv->chans.con_priv = priv;
> +	mbox = &priv->mbox;
> +	mbox->dev = dev;
> +	mbox->ops = &mtk_vcp_mbox_chan_ops;
> +	mbox->txdone_irq = false;
> +	mbox->txdone_poll = true;
> +	mbox->of_xlate = mtk_vcp_mbox_xlate;
> +	mbox->num_chans = 1;
> +	mbox->chans = &priv->chans;
> +
> +	priv->ipi_recv.msg = devm_kzalloc(dev, MBOX_SLOT_MAX_SIZE, GFP_KERNEL);
> +	if (!priv->ipi_recv.msg)
> +		return -ENOMEM;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->cfg = of_device_get_match_data(dev);
> +	if (!priv->cfg)
> +		return -EINVAL;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +

Please set the driver data before requesting the interrupt: what happens if the
ISR is run before having driver data available otherwise?! :-)

> +	ret = devm_request_threaded_irq(dev, irq, NULL,
> +					mtk_vcp_mbox_irq_thread, IRQF_ONESHOT,
> +					dev_name(dev), priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return devm_mbox_controller_register(dev, &priv->mbox);
> +}
> +
> +static const struct mtk_vcp_mbox_cfg mt8196_cfg = {
> +	.set_in		= 0x100,
> +	.clr_out	= 0x10c,
> +};
> +
> +static const struct of_device_id mtk_vcp_mbox_of_match[] = {
> +	{ .compatible = "mediatek,mt8196-vcp-mbox", .data = &mt8196_cfg },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mtk_vcp_mbox_of_match);
> +
> +static struct platform_driver mtk_vcp_mbox_driver = {
> +	.probe		= mtk_vcp_mbox_probe,
> +	.driver = {
> +		.name	= "mtk_vcp_mbox",
> +		.of_match_table = mtk_vcp_mbox_of_match,
> +	},
> +};
> +module_platform_driver(mtk_vcp_mbox_driver);
> +
> +MODULE_AUTHOR("Jjian Zhou <jjian.zhou@mediatek.com>");
> +MODULE_DESCRIPTION("MTK VCP Mailbox Controller");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mailbox/mtk-vcp-mailbox.h b/include/linux/mailbox/mtk-vcp-mailbox.h
> new file mode 100644
> index 000000000000..143fb0d06e30
> --- /dev/null
> +++ b/include/linux/mailbox/mtk-vcp-mailbox.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + */
> +
> +#ifndef __MTK_VCP_MAILBOX_H__
> +#define __MTK_VCP_MAILBOX_H__
> +
> +#define MBOX_SLOT_MAX_SIZE	0x100 /* mbox max slot size */

Please, change this definition to MTK_VCP_MBOX_SLOT_MAX_SIZE

Cheers,
Angelo

> +
> +/**
> + * struct mtk_ipi_info - mailbox message info for mtk-vcp-mailbox
> + * @msg: The share buffer between IPC and mailbox driver
> + * @len: Message length
> + * @id: This is for identification purposes and not actually used
> + *	by the mailbox hardware.
> + * @index: The signal number of the mailbox message.
> + * @slot_ofs: Data slot offset.
> + * @irq_status: Captures incoming signals for the RX path.
> + *
> + * It is used between IPC with mailbox driver.
> + */
> +struct mtk_ipi_info {
> +	void *msg;
> +	u32 len;
> +	u32 id;
> +	u32 index;
> +	u32 slot_ofs;
> +	u32 irq_status;
> +};
> +
> +#endif


