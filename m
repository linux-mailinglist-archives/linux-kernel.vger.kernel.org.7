Return-Path: <linux-kernel+bounces-847981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FEABCC339
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4481C1A65691
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A2C248880;
	Fri, 10 Oct 2025 08:45:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779625C70C
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085922; cv=none; b=CZUAEuqyGRk7KX7DReBG0HpSEnYa6kZ9S5de68UgNdR7gri9A0BlollfNpwLbX8kenQPbuxUQzIKBW8fLfOSH9VNSpq/wmERR9s8aM3Rdxh5IYiPjWHjpKW3d2Or6wdq81Sznk4Nn38POudrnTZqdESHa7Mr42hvQoIS0xLICM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085922; c=relaxed/simple;
	bh=J7C8gisNVHFUUCpyirZyFtk7rUnMc8ldzuxGXyDR1+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ulbidl0OLdoYpiRDrjFr7907XZoUegWgNZ5NlhhMAZflbf2Pn458XUDK0WsoCLvkwOTNTQ3Xe00t1Z4lvcaNnJJthyQFPHHfjabGeFvowV35WuiKhIahNNKPbu3UNGpd3rRu/NZtV1WVbBGghEUlsjae+e29/ZqWy9jH0qSC/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.pueschel@pengutronix.de>)
	id 1v78kK-0003BM-Eg; Fri, 10 Oct 2025 10:45:04 +0200
Message-ID: <bdebed9c-2980-4d5d-9eb3-1cb5e5e8e226@pengutronix.de>
Date: Fri, 10 Oct 2025 10:45:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] media: rockchip: rga: add iommu restore function
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jacob Chen <jacob-chen@iotwrt.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kernel@pengutronix.de
References: <20251007-spu-rga3-v1-0-36ad85570402@pengutronix.de>
 <20251007-spu-rga3-v1-11-36ad85570402@pengutronix.de>
 <97879b9b078055fb130edfd126d253320ce616a1.camel@ndufresne.ca>
Content-Language: en-US
From: =?UTF-8?Q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
In-Reply-To: <97879b9b078055fb130edfd126d253320ce616a1.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.pueschel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


On 10/7/25 20:30, Nicolas Dufresne wrote:
> Hi,
>
> Le mardi 07 octobre 2025 à 10:32 +0200, Sven Püschel a écrit :
>> Add an iommu restore function in preparation for the rga3 addition.
>> This is necessary for a soft reset, as the rga3 will also reset
>> it's iommu paging table to 0 and disable paging.
>>
>> The empty domain attach/detach to restore the iommu is copied
>> from the rkvdec driver.
> We did receive negative feedback after the fact on this one. We will likely
> upset further the iommu subsystem maintainers with that. Have you considered
> adding a restore function in the rkiommu driver, similar to TI mmu and Benjamin
> VSI MMU proposal ?
>
> I have no precise objection, I know it works, but adding a restore function
> seems also pretty straight forward.

I haven't considered adding an restore function. I've implemented this 
to handle potential command stream failures like scaling beyond the 
supported 8x factor. I'll probably drop this for now to keep it simple 
and instead correctly announce the constraints to avoid creating invalid 
commands in the first place.

>> Signed-off-by: Sven Püschel <s.pueschel@pengutronix.de>
>> ---
>>   drivers/media/platform/rockchip/rga/rga.c | 24 ++++++++++++++++++++++++
>>   drivers/media/platform/rockchip/rga/rga.h |  7 +++++++
>>   2 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/media/platform/rockchip/rga/rga.c
>> b/drivers/media/platform/rockchip/rga/rga.c
>> index
>> cd4da01645611e5fb51ed94e09b5f1463dad72c5..0a725841b0cfa41bbc5b861b8f5ceac2452f
>> c2b5 100644
>> --- a/drivers/media/platform/rockchip/rga/rga.c
>> +++ b/drivers/media/platform/rockchip/rga/rga.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/fs.h>
>>   #include <linux/interrupt.h>
>> +#include <linux/iommu.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>   #include <linux/pm_runtime.h>
>> @@ -560,6 +561,19 @@ static const struct video_device rga_videodev = {
>>   	.device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING,
>>   };
>>   
>> +void rga_iommu_restore(struct rockchip_rga *rga)
>> +{
>> +	if (rga->empty_domain) {
>> +		/*
>> +		 * To rewrite mapping into the attached IOMMU core, attach a
>> new empty domain that
>> +		 * will program an empty table, then detach it to restore the
>> default domain and
>> +		 * all cached mappings.
>> +		 */
>> +		iommu_attach_device(rga->empty_domain, rga->dev);
>> +		iommu_detach_device(rga->empty_domain, rga->dev);
>> +	}
>> +}
>> +
>>   static int rga_parse_dt(struct rockchip_rga *rga)
>>   {
>>   	struct reset_control *core_rst, *axi_rst, *ahb_rst;
>> @@ -657,6 +671,13 @@ static int rga_probe(struct platform_device *pdev)
>>   		goto err_put_clk;
>>   	}
>>   
>> +	if (iommu_get_domain_for_dev(rga->dev)) {
>> +		rga->empty_domain = iommu_paging_domain_alloc(rga->dev);
>> +
>> +		if (!rga->empty_domain)
> Its an error pointer, see:
>
> https://gitlab.freedesktop.org/linux-media/media-committers/-/commit/6347dc7fb967521a77f9ff0774d25ef0cca4c6cd
>
>> +			dev_warn(rga->dev, "cannot alloc new empty
>> domain\n");
>> +	}
>> +
>>   	ret = v4l2_device_register(&pdev->dev, &rga->v4l2_dev);
>>   	if (ret)
>>   		goto err_put_clk;
>> @@ -741,6 +762,9 @@ static void rga_remove(struct platform_device *pdev)
>>   	v4l2_device_unregister(&rga->v4l2_dev);
>>   
>>   	pm_runtime_disable(rga->dev);
>> +
>> +	if (rga->empty_domain)
>> +		iommu_domain_free(rga->empty_domain);
>>   }
>>   
>>   static int __maybe_unused rga_runtime_suspend(struct device *dev)
>> diff --git a/drivers/media/platform/rockchip/rga/rga.h
>> b/drivers/media/platform/rockchip/rga/rga.h
>> index
>> fc4805ba4e8ef7fb311f780a198ba6ba4d3aff17..e19c4c82aca5ae2056f52d525138093fbbb8
>> 1af8 100644
>> --- a/drivers/media/platform/rockchip/rga/rga.h
>> +++ b/drivers/media/platform/rockchip/rga/rga.h
>> @@ -75,6 +75,7 @@ struct rockchip_rga {
>>   	void __iomem *regs;
>>   	struct clk_bulk_data clks[3];
>>   	struct rockchip_rga_version version;
>> +	struct iommu_domain *empty_domain;
>>   
>>   	/* vfd lock */
>>   	struct mutex mutex;
>> @@ -114,6 +115,12 @@ static inline struct rga_vb_buffer *vb_to_rga(struct
>> vb2_v4l2_buffer *vb)
>>   
>>   struct rga_frame *rga_get_frame(struct rga_ctx *ctx, enum v4l2_buf_type
>> type);
>>   
>> +/*
>> + * This should be called in an interrupt handler to make sure no memory
>> + * is mapped through the IOMMU while the empty domain is attached.
>> + */
>> +void rga_iommu_restore(struct rockchip_rga *rga);
>> +
>>   /* RGA Buffers Manage */
>>   extern const struct vb2_ops rga_qops;
>>   

