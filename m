Return-Path: <linux-kernel+bounces-838809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C90BB030F
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA74E177955
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0272522BE;
	Wed,  1 Oct 2025 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VYUPVfxk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD12D0607;
	Wed,  1 Oct 2025 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318520; cv=none; b=BKpFgoqCn2aeHFTkPBjYcSzuthtNJyxJYecFhxaCwvx44TkQbmhVuMlzJTeVk7L5QNBs+eI32xwF45EWa5n76mqdrZXarho5m6a0jnrtRCuCkhxFglOHlwCmMk/iwQXPeAbZH9BcbPIT3JjZp+VsJv/uWUP32Rv4aATSWEHFx28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318520; c=relaxed/simple;
	bh=WnOikCSnuc0MhHD5uJ+JkBcDcggU4x/o08v6yhqMGZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2zh6tM7k5hKfaTog3iOI/pNWRopQY1qrrvbrI604EhJ3tfrzOBucFpGn6OZQJcS2FmOw8iPnoZntHtWFlxAPM1k3a4h9xNtdfhtDZauTFPh8HrLMhGioEKfzUI1x3wmU1Xdjq5y/oUtYwfvylJYYtE+UiAe45xpv7pnh6jDOk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VYUPVfxk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759318517;
	bh=WnOikCSnuc0MhHD5uJ+JkBcDcggU4x/o08v6yhqMGZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VYUPVfxkcaz9GYd4udVsfsdqJBfE4lS8rShpipzv+fwlJ1wMU8ZPlKMOhFsF/YSTz
	 bJignkV+Yjd7WUCsIiLh6ZWVT3DNjZrIsSGepajzrxLfdqGGRBJVJzc2m7hQc/HGjj
	 1NDZ27uj31jA/h2Z8+eQ4V/UkIsxcjxPyZtQSwFCf6TnIhyt1AMSKk5C67V3FUexpN
	 cN8a25gPhqcBYiUd8inHuRpH6Eahnc6vMUQLFs80qKWNzlcpnThQad6kvdqjPRzoN+
	 Nu+Tr2ngknP7hDE7rjhenyOvjhNbZtsiY5VG5G36BDcNhGJ6OhIX/EAV9WukK+319C
	 +ia9SUG9iMqzg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BA30717E0B83;
	Wed,  1 Oct 2025 13:35:16 +0200 (CEST)
Message-ID: <fbe41fb5-1799-4b81-a6e2-4b783d1a2f7e@collabora.com>
Date: Wed, 1 Oct 2025 13:35:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
To: =?UTF-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>,
 "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "wenst@chromium.org" <wenst@chromium.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20250926090505.26267-1-jjian.zhou@mediatek.com>
 <20250926090505.26267-3-jjian.zhou@mediatek.com>
 <b62611ef-7ead-4bbe-8c96-d39e3c5c8dd8@collabora.com>
 <aa86f9012bc56231066846f423263504313b6717.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aa86f9012bc56231066846f423263504313b6717.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 30/09/25 04:59, Jjian Zhou (周建) ha scritto:
> On Mon, 2025-09-29 at 12:33 +0200, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> Il 26/09/25 11:05, Jjian Zhou ha scritto:
>>> Add mtk-vcp-mailbox driver to support the communication with
>>> VCP remote microprocessor.
>>>
>>> Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
>>> ---
>>>    drivers/mailbox/Kconfig                 |   9 ++
>>>    drivers/mailbox/Makefile                |   2 +
>>>    drivers/mailbox/mtk-vcp-mailbox.c       | 168
>>> ++++++++++++++++++++++++
>>>    include/linux/mailbox/mtk-vcp-mailbox.h |  32 +++++
>>>    4 files changed, 211 insertions(+)
>>>    create mode 100644 drivers/mailbox/mtk-vcp-mailbox.c
>>>    create mode 100644 include/linux/mailbox/mtk-vcp-mailbox.h
>>>
>>> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
>>> index 02432d4a5ccd..c28bdb855663 100644
>>> --- a/drivers/mailbox/Kconfig
>>> +++ b/drivers/mailbox/Kconfig
>>> @@ -294,6 +294,15 @@ config MTK_CMDQ_MBOX
>>>          critical time limitation, such as updating display
>>> configuration
>>>          during the vblank.
>>>
>>> +config MTK_VCP_MBOX
>>> +     tristate "MediaTek VCP Mailbox Support"
>>> +     depends on ARCH_MEDIATEK || COMPILE_TEST
>>> +     help
>>> +       Say yes here to add support for the MediaTek VCP mailbox
>>> driver.
>>> +       The mailbox implementation provides access from the
>>> application
>>> +       processor to Video Companion Processor Unit.
>>> +       If unsure say N.
>>> +
>>>    config ZYNQMP_IPI_MBOX
>>>        tristate "Xilinx ZynqMP IPI Mailbox"
>>>        depends on ARCH_ZYNQMP && OF
>>> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
>>> index 98a68f838486..07278871d254 100644
>>> --- a/drivers/mailbox/Makefile
>>> +++ b/drivers/mailbox/Makefile
>>> @@ -63,6 +63,8 @@ obj-$(CONFIG_MTK_ADSP_MBOX) += mtk-adsp-mailbox.o
>>>
>>>    obj-$(CONFIG_MTK_CMDQ_MBOX) += mtk-cmdq-mailbox.o
>>>
>>> +obj-$(CONFIG_MTK_VCP_MBOX)   += mtk-vcp-mailbox.o
>>> +
>>>    obj-$(CONFIG_ZYNQMP_IPI_MBOX)       += zynqmp-ipi-mailbox.o
>>>
>>>    obj-$(CONFIG_SUN6I_MSGBOX)  += sun6i-msgbox.o
>>> diff --git a/drivers/mailbox/mtk-vcp-mailbox.c
>>> b/drivers/mailbox/mtk-vcp-mailbox.c
>>> new file mode 100644
>>> index 000000000000..a2a80d124e50
>>> --- /dev/null
>>> +++ b/drivers/mailbox/mtk-vcp-mailbox.c
>>> @@ -0,0 +1,168 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2025 MediaTek Corporation. All rights reserved.
>>> + * Author: Jjian Zhou <jjian.zhou.@mediatek.com>
>>> + */
>>> +
>>> +#include <linux/interrupt.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/mailbox_controller.h>
>>> +#include <linux/mailbox/mtk-vcp-mailbox.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/slab.h>
>>> +
>>> +struct mtk_vcp_mbox {
>>> +     struct mbox_controller mbox;
>>> +     void __iomem *base;
>>> +     struct device *dev;
>>> +     const struct mtk_vcp_mbox_cfg *cfg;
>>> +     struct mtk_ipi_info ipi_recv;
>>> +     struct mbox_chan chans;
>>> +};
>>> +
>>> +struct mtk_vcp_mbox_cfg {
>>> +     u32 set_in;
>>> +     u32 clr_out;
>>
>> u16 is enough for both register offsets, at least for now - and I
>> suspect it's
>> going to be enough forever.
> 
> OK. I change u32 to u16 in the next version.
> 
>>
>>> +};
>>> +
>>> +static irqreturn_t mtk_vcp_mbox_irq_thread(int irq, void *data)
>>> +{
>>> +     struct mtk_vcp_mbox *priv = data;
>>> +
>>> +     /* get irq status */
>>> +     priv->ipi_recv.irq_status = readl(priv->base + priv->cfg-
>>>> clr_out);
>>> +
>>> +     __ioread32_copy(priv->ipi_recv.msg, priv->base,
>>> MBOX_SLOT_MAX_SIZE / 4);
>>> +
>>> +     mbox_chan_received_data(&priv->chans, &priv->ipi_recv);
>>> +
>>> +     /* clear irq status */
>>> +     writel(priv->ipi_recv.irq_status, priv->base + priv->cfg-
>>>> clr_out);
>>> +
>>> +     return IRQ_HANDLED;
>>> +}
>>> +
>>> +static struct mbox_chan *mtk_vcp_mbox_xlate(struct mbox_controller
>>> *mbox,
>>> +                                         const struct
>>> of_phandle_args *sp)
>>> +{
>>> +     if (sp->args_count)
>>> +             return NULL;
>>> +
>>> +     return &mbox->chans[0];
>>> +}
>>> +
>>> +static int mtk_vcp_mbox_send_data(struct mbox_chan *chan, void
>>> *data)
>>> +{
>>> +     struct mtk_vcp_mbox *priv = chan->con_priv;
>>> +     struct mtk_ipi_info *ipi_info = data;
>>> +     u32 status;
>>> +
>>> +     if (!ipi_info->msg) {
>>> +             dev_err(priv->dev, "msg buffer is NULL.\n");
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     status = readl(priv->base + priv->cfg->set_in) &
>>> BIT(ipi_info->index);
>>
>> status = readl(priv->base + priv->cfg->set_in);
>> if (status & BIT(ipi_info->index) {
>>    ....
>> }
> 
> OK.
> 
>>
>>> +     if (status) {
>>> +             dev_warn(priv->dev, "mailbox IPI %d is busy.\n",
>>> ipi_info->id);
>>> +             return -EBUSY;
>>> +     }
>>> +
>>> +     if (ipi_info->slot_ofs + ipi_info->len > MBOX_SLOT_MAX_SIZE)
>>> +             return -EINVAL;
>>> +     __iowrite32_copy(priv->base + ipi_info->slot_ofs, ipi_info-
>>>> msg,
>>> +                      ipi_info->len);
>>> +
>>> +     writel(BIT(ipi_info->index), priv->base + priv->cfg->set_in);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static bool mtk_vcp_mbox_last_tx_done(struct mbox_chan *chan)
>>> +{
>>> +     struct mtk_ipi_info *ipi_info = chan->active_req;
>>> +     struct mtk_vcp_mbox *priv = chan->con_priv;
>>> +
>>> +     return !(readl(priv->base + priv->cfg->set_in) &
>>> BIT(ipi_info->index));
>>> +}
>>> +
>>> +static const struct mbox_chan_ops mtk_vcp_mbox_chan_ops = {
>>> +     .send_data      = mtk_vcp_mbox_send_data,
>>> +     .last_tx_done   = mtk_vcp_mbox_last_tx_done,
>>> +};
>>> +
>>> +static int mtk_vcp_mbox_probe(struct platform_device *pdev)
>>> +{
>>> +     struct device *dev = &pdev->dev;
>>> +     struct mtk_vcp_mbox *priv;
>>> +     struct mbox_controller *mbox;
>>> +     int ret, irq;
>>> +
>>> +     priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> +     if (!priv)
>>> +             return -ENOMEM;
>>> +
>>> +     priv->dev = dev;
>>> +     priv->chans.con_priv = priv;
>>> +     mbox = &priv->mbox;
>>> +     mbox->dev = dev;
>>> +     mbox->ops = &mtk_vcp_mbox_chan_ops;
>>> +     mbox->txdone_irq = false;
>>> +     mbox->txdone_poll = true;
>>> +     mbox->of_xlate = mtk_vcp_mbox_xlate;
>>> +     mbox->num_chans = 1;
>>> +     mbox->chans = &priv->chans;
>>> +
>>> +     priv->ipi_recv.msg = devm_kzalloc(dev, MBOX_SLOT_MAX_SIZE,
>>> GFP_KERNEL);
>>> +     if (!priv->ipi_recv.msg)
>>> +             return -ENOMEM;
>>> +
>>> +     priv->base = devm_platform_ioremap_resource(pdev, 0);
>>> +     if (IS_ERR(priv->base))
>>> +             return PTR_ERR(priv->base);
>>> +
>>> +     priv->cfg = of_device_get_match_data(dev);
>>> +     if (!priv->cfg)
>>> +             return -EINVAL;
>>> +
>>> +     irq = platform_get_irq(pdev, 0);
>>> +     if (irq < 0)
>>> +             return irq;
>>> +
>>
>> Please set the driver data before requesting the interrupt: what
>> happens if the
>> ISR is run before having driver data available otherwise?! :-)
>>
> 
> OK, I put the "platform_set_drvdata(pdev, priv)" between
> "of_device_get_match_data(dev)" and "platform_get_irq(pdev, 0)".
> 
> Do you want me to submit a new version right now?

Yes, please.

Cheers,
Angelo

