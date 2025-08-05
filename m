Return-Path: <linux-kernel+bounces-756101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E80CB1B003
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2647189B9ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D280242D70;
	Tue,  5 Aug 2025 08:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hw7sU0cc"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BDB24291C;
	Tue,  5 Aug 2025 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754381389; cv=none; b=KzHbyjKzlVXADYV7Qr186c2AjaqEho/RcKBYe+E1nCvzB2uOI73AoTwtGKdC2JyCUcw3EBIhAC1sQDMjm3xfnT43P5TrbkbliQE2zYbiqNORVtJ8YbAz9DEkkd7T005kwLt4VtHHdz/rlXH6Wx0ehNB5YldTKCMvjqSyhcCwc20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754381389; c=relaxed/simple;
	bh=gaVaqlpEy9JGIrozx4nrkj/qEnklxwdTi9HgO+2XAYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXH4ta90FX4vg9ldNlSzgcVIkHV4QNJA4PNmLuuPv71DtQVys1aWIbQF/nQro8Ps+TFv3BwzQoU0BtHC2IYRVAA+AtJc+E5fQ4pT70ZEJBDwGWG+8k45BT13KDJvG3g4i0bQcPBPdlN3tGoY8Cm8q4MmsfowhFVViSKYb1pw5xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hw7sU0cc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754381379;
	bh=gaVaqlpEy9JGIrozx4nrkj/qEnklxwdTi9HgO+2XAYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hw7sU0cccyUdgfhf7BXoruo35ahJU0Pu0fKx773jOM4nkHLG3CGZl6iwX3jDlw1TA
	 6tVTvEPDRpww5Ni1J3sHJBo2OnBDV4Tx3xk73RqUm1NMVwlCAriQ+k8HTbIb65l2ho
	 5I2WO15dyW8dJHG0wVFs0i9lwKOKCjv2Fa16m38XClCrHaLrLbWpZmGE8kCTDW3Qwa
	 PoCLJAc213IKLrTaP4lnBatFfcVs9j0xZJC11Qm/KdG1syD8knlF7BISgyGeEor7Qd
	 gFfx3MVmnYOXxN+ho4XYTLfNVFSGZjImtvpxoYFX1YGcntN8nRKn016rZmQsKY+PeY
	 5Uf2OHkal4YlQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B6EA17E0593;
	Tue,  5 Aug 2025 10:09:39 +0200 (CEST)
Message-ID: <4801f911-c453-4ee1-83b5-ee2ae6087488@collabora.com>
Date: Tue, 5 Aug 2025 10:09:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
To: =?UTF-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "krzk@kernel.org" <krzk@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20250804125215.23076-1-friday.yang@mediatek.com>
 <20250804125215.23076-3-friday.yang@mediatek.com>
 <bc8d1bdc-8e19-4a1d-b5f4-d0e463e22dc9@collabora.com>
 <c45b8ffa0a5538b8170b3bae7b8c5a098b9677b9.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <c45b8ffa0a5538b8170b3bae7b8c5a098b9677b9.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 05/08/25 09:59, Friday Yang (杨阳) ha scritto:
> On Mon, 2025-08-04 at 15:08 +0200, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> Il 04/08/25 14:51, Friday Yang ha scritto:
>>> To prevent handling glitch signals during MTCMOS on/off
>>> transitions,
>>> SMI requires clamp and reset operations. Parse the reset settings
>>> for
>>> SMI LARBs and the clamp settings for the SMI Sub-Common. Register
>>> genpd callback for the SMI LARBs located in image, camera and IPE
>>> subsystems, and apply reset and clamp operations within the
>>> callback.
>>>
>>> Signed-off-by: Friday Yang <friday.yang@mediatek.com>
>>> ---
>>>    drivers/memory/mtk-smi.c | 131
>>> +++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 131 insertions(+)
>>>
>>> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
>>> index 733e22f695ab..8c1bd245aac9 100644
>>> --- a/drivers/memory/mtk-smi.c
>>> +++ b/drivers/memory/mtk-smi.c
>>> @@ -10,11 +10,15 @@
>>>    #include <linux/err.h>
>>>    #include <linux/io.h>
>>>    #include <linux/iopoll.h>
>>> +#include <linux/mfd/syscon.h>
>>>    #include <linux/module.h>
>>>    #include <linux/of.h>
>>>    #include <linux/of_platform.h>
>>>    #include <linux/platform_device.h>
>>> +#include <linux/pm_domain.h>
>>>    #include <linux/pm_runtime.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/reset.h>
>>>    #include <linux/soc/mediatek/mtk_sip_svc.h>
>>>    #include <soc/mediatek/smi.h>
>>>    #include <dt-bindings/memory/mt2701-larb-port.h>
>>> @@ -34,6 +38,8 @@
>>>    #define SMI_FIFO_TH1                        0x238
>>>    #define SMI_FIFO_TH2                        0x23c
>>>    #define SMI_DCM                             0x300
>>> +#define SMI_COMMON_CLAMP_EN_SET              0x3c4
>>> +#define SMI_COMMON_CLAMP_EN_CLR              0x3c8
>>>    #define SMI_DUMMY                   0x444
>>>
>>>    /* SMI LARB */
>>> @@ -134,6 +140,7 @@ struct mtk_smi_larb_gen {
>>>        unsigned int                    larb_direct_to_common_mask;
>>>        unsigned int                    flags_general;
>>>        const
>>> u8                        (*ostd)[SMI_LARB_PORT_NR_MAX];
>>> +     const u8                        *clamp_port;
>>>    };
>>>
>>>    struct mtk_smi {
>>> @@ -150,6 +157,7 @@ struct mtk_smi {
>>>    };
>>>
>>>    struct mtk_smi_larb { /* larb: local arbiter */
>>> +     struct device                   *dev;
>>>        struct mtk_smi                  smi;
>>>        void __iomem                    *base;
>>>        struct device                   *smi_common_dev; /* common or
>>> sub-common dev */
>>> @@ -157,6 +165,10 @@ struct mtk_smi_larb { /* larb: local arbiter
>>> */
>>>        int                             larbid;
>>>        u32                             *mmu;
>>>        unsigned char                   *bank;
>>> +     struct regmap                   *smi_comm_syscon; /* smi-comm
>>> or sub-comm */
>>> +     u8                              smi_comm_inport_id; /* smi-
>>> comm or sub-comm */
>>
>> one nit nere: smi_comm_in_port_id
>>
> Ok, I will rename 'smi_comm_inport_id' to 'smi_comm_in_port_id'.
> 
>>> +     struct notifier_block           nb;
>>> +     struct reset_control            *rst_con;
>>>    };
>>>
>>>    static int
>>> @@ -478,6 +490,19 @@ static const u8
>>> mtk_smi_larb_mt8195_ostd[][SMI_LARB_PORT_NR_MAX] = {
>>>        [28] = {0x1a, 0x0e, 0x0a, 0x0a, 0x0c, 0x0e, 0x10,},
>>>    };
>>>
>>> +static const u8 mtk_smi_larb_clamp_port_mt8188[MTK_LARB_NR_MAX] =
>>> {
>>> +     [9]     = BIT(1), /* larb10 */
>>> +     [10]    = BIT(2), /* larb11a */
>>> +     [11]    = BIT(2), /* larb11b */
>>> +     [12]    = BIT(3), /* larb11c */
>>> +     [13]    = BIT(0), /* larb12 */
>>> +     [16]    = BIT(1), /* larb15 */
>>> +     [17]    = BIT(2), /* larb16a */
>>> +     [18]    = BIT(2), /* larb16b */
>>> +     [19]    = BIT(3), /* larb17a */
>>> +     [20]    = BIT(3), /* larb17b */
>>> +};
>>> +
>>>    static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
>>>        .port_in_larb = {
>>>                LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
>>> @@ -531,6 +556,7 @@ static const struct mtk_smi_larb_gen
>>> mtk_smi_larb_mt8188 = {
>>>        .flags_general              = MTK_SMI_FLAG_THRT_UPDATE |
>>> MTK_SMI_FLAG_SW_FLAG |
>>>                                      MTK_SMI_FLAG_SLEEP_CTL |
>>> MTK_SMI_FLAG_CFG_PORT_SEC_CTL,
>>>        .ostd                       = mtk_smi_larb_mt8188_ostd,
>>> +     .clamp_port                 = mtk_smi_larb_clamp_port_mt8188,
>>>    };
>>>
>>>    static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
>>> @@ -582,6 +608,45 @@ static void
>>> mtk_smi_larb_sleep_ctrl_disable(struct mtk_smi_larb *larb)
>>>        writel_relaxed(0, larb->base + SMI_LARB_SLP_CON);
>>>    }
>>>
>>> +static int mtk_smi_larb_clamp_protect_enable(struct device *dev,
>>> bool enable)
>>> +{
>>> +     struct mtk_smi_larb *larb = dev_get_drvdata(dev);
>>> +     u32 reg;
>>> +     int ret;
>>> +
>>> +     /* smi_comm_syscon may be NULL if the subsys doesn't have bus
>>> glitch issues */
>>> +     if (!larb->smi_comm_syscon)
>>> +             return -EINVAL;
>>> +
>>> +     reg = enable ? SMI_COMMON_CLAMP_EN_SET :
>>> SMI_COMMON_CLAMP_EN_CLR;
>>> +
>>> +     ret = regmap_write(larb->smi_comm_syscon, reg, larb-
>>>> smi_comm_inport_id);
>>> +     if (ret)
>>> +             dev_err(dev, "Unable to %s clamp for input port %d:
>>> %d\n",
>>> +                     enable ? "enable" : "disable",
>>> +                     larb->smi_comm_inport_id, ret);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int mtk_smi_genpd_callback(struct notifier_block *nb,
>>> +                               unsigned long flags, void *data)
>>> +{
>>> +     struct mtk_smi_larb *larb = container_of(nb, struct
>>> mtk_smi_larb, nb);
>>> +     struct device *dev = larb->dev;
>>> +
>>> +     if (flags == GENPD_NOTIFY_PRE_ON || flags ==
>>> GENPD_NOTIFY_PRE_OFF) {
>>> +             /* disable related SMI sub-common port */
>>> +             mtk_smi_larb_clamp_protect_enable(dev, true);
>>> +     } else if (flags == GENPD_NOTIFY_ON) {
>>> +             /* enable related SMI sub-common port */
>>> +             reset_control_reset(larb->rst_con);
>>> +             mtk_smi_larb_clamp_protect_enable(dev, false);
>>> +     }
>>> +
>>> +     return NOTIFY_OK;
>>> +}
>>> +
>>>    static int mtk_smi_device_link_common(struct device *dev, struct
>>> device **com_dev)
>>>    {
>>>        struct platform_device *smi_com_pdev;
>>> @@ -638,6 +703,53 @@ static int mtk_smi_dts_clk_init(struct device
>>> *dev, struct mtk_smi *smi,
>>>        return ret;
>>>    }
>>>
>>> +static int mtk_smi_larb_parse_clamp_optional(struct mtk_smi_larb
>>> *larb)
>>> +{
>>> +     struct device *dev = larb->dev;
>>> +     const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
>>> +     u32 larb_id;
>>> +     int ret;
>>> +
>>> +     /*
>>> +      * Only SMI LARBs in camera, image and IPE subsys need to
>>> +      * apply clamp and reset operations, others can be skipped.
>>> +      */
>>> +     ret = of_property_read_u32(dev->of_node, "mediatek,larb-id",
>>> &larb_id);
>>> +     if (ret)
>>> +             return -EINVAL;
>>
>> This looks wrong.
>>
> I will change to 'return 0' here.
> 
>>> +     if (!larb_gen->clamp_port || !larb_gen->clamp_port[larb_id])
>>> +             return 0;
>>> +
>>> +     larb->smi_comm_inport_id = larb_gen->clamp_port[larb_id];
>>> +     larb->smi_comm_syscon = syscon_regmap_lookup_by_phandle(dev-
>>>> of_node,
>>> +                                                             "medi
>>> atek,smi");
>>> +     if (IS_ERR(larb->smi_comm_syscon)) {
>>> +             larb->smi_comm_syscon = NULL;
>>> +             return dev_err_probe(dev, -EINVAL,
>>> +                                  "Unknown clamp port for larb
>>> %d\n", larb_id);
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int mtk_smi_larb_parse_reset_optional(struct mtk_smi_larb
>>> *larb)
>>> +{
>>> +     struct device *dev = larb->dev;
>>> +     int ret;
>>> +
>>> +     larb->rst_con =
>>> devm_reset_control_get_optional_exclusive(dev, "larb");
>>> +     if (!larb->rst_con)
>>> +             return 0;
>>> +
>>> +     larb->nb.notifier_call = mtk_smi_genpd_callback;
>>> +     ret = dev_pm_genpd_add_notifier(dev, &larb->nb);
>>> +     if (ret)
>>> +             return dev_err_probe(dev, -EINVAL,
>>> +                                  "Failed to add genpd callback
>>> %d\n", ret);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>>    static int mtk_smi_larb_probe(struct platform_device *pdev)
>>>    {
>>>        struct mtk_smi_larb *larb;
>>> @@ -648,6 +760,7 @@ static int mtk_smi_larb_probe(struct
>>> platform_device *pdev)
>>>        if (!larb)
>>>                return -ENOMEM;
>>>
>>> +     larb->dev = dev;
>>>        larb->larb_gen = of_device_get_match_data(dev);
>>>        larb->base = devm_platform_ioremap_resource(pdev, 0);
>>>        if (IS_ERR(larb->base))
>>> @@ -664,6 +777,14 @@ static int mtk_smi_larb_probe(struct
>>> platform_device *pdev)
>>>        if (ret < 0)
>>>                return ret;
>>>
>>> +     ret = mtk_smi_larb_parse_clamp_optional(larb);
>>> +     if (ret)
>>> +             goto err_link_remove;
>>
>> That's optional, right?
>>
>> In function mtk_smi_larb_parse_clamp_optional(), you're returning
>> -EINVAL
>> and here you're failing probe, so that's not optional anymore.
>>
>> Regards,
>> Angelo
>>
> Yes, this clamp setting is optional. Not all smi larbs require it, only
> those within the ISP subsystem do. I understand your point that
> optional settings should not cause the probe to fail. Therefore, I
> could modify the code to 'return 0' if it fails to get 'larb_id',
> similar to when 'larb_gen->clamp_port' is NULL or 'larb_gen-
> clamp_port[larb_id]' is zero. Is this acceptable for you?
> Thanks.

Yes, that's ok.

Cheers,
Angelo

> 
>>> +
>>> +     ret = mtk_smi_larb_parse_reset_optional(larb);
>>> +     if (ret)
>>> +             goto err_link_remove;
>>> +
>>>        pm_runtime_enable(dev);
>>>        platform_set_drvdata(pdev, larb);
>>>        ret = component_add(dev, &mtk_smi_larb_component_ops);



