Return-Path: <linux-kernel+bounces-874150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C96C15A33
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7D6250905E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123E53451D1;
	Tue, 28 Oct 2025 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jBQ1AbYA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378503451A9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666547; cv=none; b=XrUXjQGGVPwRleW03EIHboNFmsNfBCTCPatjO1ctnBU9HBavKs9sJ3EUZtzNqvSQ3rQxMjzUnjMOaHCnPhZUJp9WWXmAnW0rzLdAUDuBmkzHf+g0nsbuwJ7Hy8Mu7WNxVMVNgIfYAD/o2WqHVhKZ3kuqbc0mGkaW0IOj5anwFPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666547; c=relaxed/simple;
	bh=l01DKyQC0PTsXWdnuRqRYStmYUw5jCENSutaJBHzE1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqtCMC2Qc3+rCEAf+oQVVz/xVNuHOIsRw90wPDoIYNj5uWfS7Qx+QV5jQlVN3A74OSMp7fN/GdyNXIh7TMVuvPOD6YZRk08vgTOtYxKEcA3ahihOrRsE1fDn3lCLrbXLLhjkO6YcLF1gadG8o8UhpQDmWzzqJhgbD2fpEGSu3Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jBQ1AbYA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761666542;
	bh=l01DKyQC0PTsXWdnuRqRYStmYUw5jCENSutaJBHzE1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jBQ1AbYA8Hvuh8VixD34dl3PERXuemF+curQiifdvo7E2Yx+kFJnyS49M9wpUHiqE
	 ZSXiGMYstHG1FIOoEUY5wm0g+vMu6hKIX2s1S9MqxDPcPPvm5+IxyoxxhDpTbkPYxe
	 fWWK0I05WsvO1/FQ4sq8g0oDs9e3eZHesjRobm8MmWBXh2yWMZPRk965MM1bXR3dk3
	 z51lD8BxuujfpF6YfKqGkZ2GfwG3g3Oq7l3KpKWKR7E25xYTOkAWFBoc3XzFLSHLC5
	 mysKNSuUG/BTjC0yOJpfAv2uP8obFVYDhADKN7ScepCor6ToSIENBoesh9shk6rh33
	 MOGPFTDxhCd5g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D70F17E1276;
	Tue, 28 Oct 2025 16:49:01 +0100 (CET)
Message-ID: <51af30ea-dce9-49b8-a5e1-0ee8e9644879@collabora.com>
Date: Tue, 28 Oct 2025 16:49:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/mediatek: mtk_disp_rdma: Enable/disable interrupt
 on bind/unbind
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: Alexandre Mergnat <amergnat@baylibre.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "djkurtz@chromium.org" <djkurtz@chromium.org>,
 "granquet@baylibre.com" <granquet@baylibre.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 =?UTF-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "littlecvr@chromium.org" <littlecvr@chromium.org>,
 =?UTF-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= <Rex-BC.Chen@mediatek.com>
References: <20250924103708.19071-1-angelogioacchino.delregno@collabora.com>
 <20250924103708.19071-4-angelogioacchino.delregno@collabora.com>
 <fb2c7169b3c3e2e376ee0b092699735dc38bcbb6.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <fb2c7169b3c3e2e376ee0b092699735dc38bcbb6.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 28/10/25 10:49, CK Hu (胡俊光) ha scritto:
> On Wed, 2025-09-24 at 12:37 +0200, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until you have verified the sender or the content.
>>
>>
>> The RDMA driver is installing an ISR in the probe function but, if
>> the component is not bound yet, the interrupt handler may call the
>> vblank_cb ahead of time (while probing other drivers) or too late
>> (while removing other drivers), possibly accessing memory that it
>> should not try to access by reusing stale pointers.
>>
>> In order to fix this, like done in the OVL driver, add a new `irq`
>> member to struct mtk_disp_ovl and then set the NOAUTOEN flag to
>> the irq before installing the ISR to manually disable and clear
>> the hwirqs with register writes, and enable_irq() and disable_irq()
>> in the bind and unbind callbacks respectively.
>>
>> Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
>> Link: https://lore.kernel.org/r/20250402083628.20111-6-angelogioacchino.delregno@collabora.com
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 34 ++++++++++++++----------
>>   1 file changed, 20 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
>> index c9d41d75e7f2..9fd9bb1ee544 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
>> @@ -81,6 +81,7 @@ struct mtk_disp_rdma_data {
>>   struct mtk_disp_rdma {
>>          struct clk                      *clk;
>>          void __iomem                    *regs;
>> +       int                             irq;
>>          struct cmdq_client_reg          cmdq_reg;
>>          const struct mtk_disp_rdma_data *data;
>>          void                            (*vblank_cb)(void *data);
>> @@ -295,13 +296,23 @@ void mtk_rdma_layer_config(struct device *dev, unsigned int idx,
>>   static int mtk_disp_rdma_bind(struct device *dev, struct device *master,
>>                                void *data)
>>   {
>> -       return 0;
>> +       struct mtk_disp_rdma *priv = dev_get_drvdata(dev);
>> +
>> +       /* Disable and clear pending interrupts */
>> +       writel(0x0, priv->regs + DISP_REG_RDMA_INT_ENABLE);
>> +       writel(0x0, priv->regs + DISP_REG_RDMA_INT_STATUS);
>> +
>> +       enable_irq(priv->irq);
>>
>> +       return 0;
>>   }
>>
>>   static void mtk_disp_rdma_unbind(struct device *dev, struct device *master,
>>                                   void *data)
>>   {
>> +       struct mtk_disp_rdma *priv = dev_get_drvdata(dev);
>> +
>> +       disable_irq(priv->irq);
>>   }
>>
>>   static const struct component_ops mtk_disp_rdma_component_ops = {
>> @@ -313,16 +324,15 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
>>   {
>>          struct device *dev = &pdev->dev;
>>          struct mtk_disp_rdma *priv;
>> -       int irq;
>>          int ret;
>>
>>          priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>          if (!priv)
>>                  return -ENOMEM;
>>
>> -       irq = platform_get_irq(pdev, 0);
>> -       if (irq < 0)
>> -               return irq;
>> +       priv->irq = platform_get_irq(pdev, 0);
>> +       if (priv->irq < 0)
>> +               return priv->irq;
>>
>>          priv->clk = devm_clk_get(dev, NULL);
>>          if (IS_ERR(priv->clk))
>> @@ -345,21 +355,17 @@ static int mtk_disp_rdma_probe(struct platform_device *pdev)
>>          if (ret && (ret != -EINVAL))
>>                  return dev_err_probe(dev, ret, "Failed to get rdma fifo size\n");
>>
>> -       /* Disable and clear pending interrupts */
>> -       writel(0x0, priv->regs + DISP_REG_RDMA_INT_ENABLE);
>> -       writel(0x0, priv->regs + DISP_REG_RDMA_INT_STATUS);
> 
> Pending interrupt is cleared here, and interrupt is disabled here.
> So the problem you mention would not happen.
> 

When unbinding the component, the interrupt is not cleared nor disabled.

If there is any pending interrupt while unbinding (or if the HW raises an interrupt
after rdma gets unbound) the ISR will produce a use-after-free issue.

I wrote this after experiencing the issue that I described in the commit message,
didn't just go and casually write code.

I also want to remind you that use-after-free may also be a security concern.

Regards,
Angelo

> Regards,
> CK
> 
>> -
>> -       ret = devm_request_irq(dev, irq, mtk_disp_rdma_irq_handler,
>> -                              IRQF_TRIGGER_NONE, dev_name(dev), priv);
>> -       if (ret < 0)
>> -               return dev_err_probe(dev, ret, "Failed to request irq %d\n", irq);
>> -
>>          priv->data = of_device_get_match_data(dev);
>>
>>          platform_set_drvdata(pdev, priv);
>>
>>          pm_runtime_enable(dev);
>>
>> +       ret = devm_request_irq(dev, priv->irq, mtk_disp_rdma_irq_handler,
>> +                              IRQF_NO_AUTOEN, dev_name(dev), priv);
>> +       if (ret < 0)
>> +               return dev_err_probe(dev, ret, "Failed to request irq %d\n", priv->irq);
>> +
>>          ret = component_add(dev, &mtk_disp_rdma_component_ops);
>>          if (ret) {
>>                  pm_runtime_disable(dev);
>> --
>> 2.51.0
>>
>>
> 



