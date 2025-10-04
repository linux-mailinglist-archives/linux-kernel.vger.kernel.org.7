Return-Path: <linux-kernel+bounces-842136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23397BB910B
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 20:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C853C41D8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 18:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736ED283FE3;
	Sat,  4 Oct 2025 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6FexA7o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E17260F;
	Sat,  4 Oct 2025 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759602985; cv=none; b=ionncmPSpwZdSB6l+MnSRq5uFSMHMUuS6XmrzlVgX2DFFaVDa0TM2uTTjEvt/KVVkQBc1N1H0NiBz9qJzUVqIlolIr6sPh7Ij0KV53uIOD42D84IedEBaIYuyKkIWDR6S3V2/dYeDCK9qPDM39lHb2xvecJ+wD0ShaX4YpO2jGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759602985; c=relaxed/simple;
	bh=xuFxxT3Xf9Ae9zNzJIfLsMGbHQLQmEnZm54x5U7nYO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/LYZPDjKa4EVe9bLc1hfnZWAuem5EVrJRWhPs34bwsm3/Dhp76VaKSe+p957SfS4uKBcHYABJwejoejPx7/D5L6JeJ/Y24CMP1zCPcoq60yCrN4uK1FudWeu1EclJ4cHy0oADH9yrHtlQhuwD1fyfU1/xyMRL7MFTZNceEbB8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6FexA7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0D1C4CEF1;
	Sat,  4 Oct 2025 18:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759602985;
	bh=xuFxxT3Xf9Ae9zNzJIfLsMGbHQLQmEnZm54x5U7nYO0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q6FexA7o8CEdDVeSTQY8IlJaNPgHu5gO4X5GnCtqDj9MymQLAdXlchKSd8H+pgyJQ
	 NDjCWvXQMDVZg5rwqYqkvvaVBHJP6UD/pRqRPwKbvVsi89pyH0lecnDmBrwJHkBQxJ
	 5wedxKBDVIY4it9TOT/C1fiuOjKaU/OmJS/yQ9SZf/SifPulbI+7ptENHlZTREl8ad
	 LNyXqQvOGeB5VoFa8raezwq+CGPuOWhLZzUauKiTZD3EgzJFiA3XNDgljZsPe3KiuY
	 q3OjqxsolQFsb7X0uaX8AM5C/WYA0BNuQ2okXyoCvKnPDgQ+Ml8jHGCxoxSgFiINj9
	 mK/2SZgI3Y7ZA==
Message-ID: <7b281f10-f42c-454b-9c4d-96ea4f66c66f@kernel.org>
Date: Sat, 4 Oct 2025 19:36:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] misc: fastrpc: Update dma_mask for CDSP support on
 Kaanapali SoC
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
 trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
References: <20250924-knp-fastrpc-v1-0-4b40f8bfce1d@oss.qualcomm.com>
 <20250924-knp-fastrpc-v1-2-4b40f8bfce1d@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20250924-knp-fastrpc-v1-2-4b40f8bfce1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 12:46 AM, Jingyi Wang wrote:
> From: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
> 
> DSP currently supports 32-bit IOVA (32-bit PA + 4-bit SID) for
> both Q6 and user DMA (uDMA) access. This is being upgraded to
> 34-bit PA + 4-bit SID due to a hardware revision in CDSP for
> Kaanapali SoC, which expands the DMA addressable range.
> Update DMA mask configuration in the driver to support CDSP on
> Kaanapali SoC. Set the default `dma_mask` to 32-bit and update
> it to 34-bit based on CDSP and SoC-specific compatible string.
> 
> Signed-off-by: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index db396241b8ce..e019163eb265 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -275,6 +275,7 @@ struct fastrpc_session_ctx {
>  	bool used;
>  	bool valid;
>  	u32 sid_pos;
> +	u32 pa_bits;
same comments as in patch 1 move to channel ctx, also why do we even
need this  to be stored in the first place as dma mask is set in
probe,we will not need it after wards.
>  };
>  
>  struct fastrpc_channel_ctx {
> @@ -2179,9 +2180,9 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	sess->used = false;
>  	sess->valid = true;
>  	sess->dev = dev;
> +	sess->pa_bits = cctx->dma_mask;

>  	/* Configure where sid will be prepended to pa */
> -	sess->sid_pos =
> -		(cctx->iova_format ? SID_POS_IN_IOVA : DSP_DEFAULT_BUS_WIDTH);
> +	sess->sid_pos = (cctx->iova_format ? SID_POS_IN_IOVA : sess->pa_bits);
>  
>  	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
>  		dev_info(dev, "FastRPC Session ID not specified in DT\n");
> @@ -2198,9 +2199,9 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  		}
>  	}
>  	spin_unlock_irqrestore(&cctx->lock, flags);
> -	rc = dma_set_mask(dev, DMA_BIT_MASK(32));
> +	rc = dma_set_mask(dev, DMA_BIT_MASK(sess->pa_bits));
>  	if (rc) {
> -		dev_err(dev, "32-bit DMA enable failed\n");
> +		dev_err(dev, "%u-bit DMA enable failed\n", sess->pa_bits);
>  		return rc;
>  	}
>  
> @@ -2287,10 +2288,12 @@ static int fastrpc_get_domain_id(const char *domain)
>  
>  struct fastrpc_soc_data {
>  	u32 dsp_iova_format;
> +	u32 cdsp_dma_mask;
>  };
>  
>  static const struct fastrpc_soc_data kaanapali_soc_data = {
>  	.dsp_iova_format = 1,
> +	.cdsp_dma_mask = 34,
>  };
>  
>  static const struct of_device_id qcom_soc_match_table[] = {
> @@ -2310,6 +2313,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	const struct of_device_id *match;
>  	const struct fastrpc_soc_data *soc_data = NULL;
>  	u32 iova_format = 0;
> +	u32 ubs = DSP_DEFAULT_BUS_WIDTH;
>  
>  	root = of_find_node_by_path("/");
>  	if (!root)
> @@ -2322,6 +2326,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	} else {
>  		soc_data = match->data;
>  		iova_format = soc_data->dsp_iova_format;
> +		ubs = soc_data->cdsp_dma_mask;
>  	}
>  
>  	err = of_property_read_string(rdev->of_node, "label", &domain);
> @@ -2404,6 +2409,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	}
>  	/* determine where sid needs to be prepended to pa based on iova_format */
>  	data->iova_format = iova_format;
> +	data->dma_mask = (domain_id == CDSP_DOMAIN_ID ? ubs : DSP_DEFAULT_BUS_WIDTH);

set the default of 32 and move this inside switch case where we have
domain id checks.


>  	kref_init(&data->refcount);
>  
>  	dev_set_drvdata(&rpdev->dev, data);
> 


