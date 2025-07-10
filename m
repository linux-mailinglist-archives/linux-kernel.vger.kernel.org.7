Return-Path: <linux-kernel+bounces-725939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43C7B005B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AEC761E31
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC05F27780D;
	Thu, 10 Jul 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+GCSVvG"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9A2749DB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158889; cv=none; b=PJtrARIU82fZdUUGGrIIwnwjmrLFY0yXCr54eTI/r2C2UdJDAfjd67jQY5pace0yK6BmEtAhnSP+qOB9OIzvZbAdJFORm60S4D+G1fmYZTLHf7w+QjikAt45shb200G+UA7WD6TpEMWXrzJBS8U4QMmks7pSuy1snqg+v83njCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158889; c=relaxed/simple;
	bh=2cIMHUhX+1c5+mkwL7rxFG92dv6iIfSQwLBq+uKyI9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZj1rpb/qzvIKoGejccUzJOT3VnocRelp84GxzEn1+9rSfqfaXMFg3l8Wqlu7NVJo5A5bNjOlu4eykgbbPZLhkKB4o738b2y4Iu9mJ7x0sWga/Ccoz0paYMTL2FFjEwBIcSW1b0VTDZMVDAUpZVTLpo7rI3Wro9PakAQMpy+PpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G+GCSVvG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-748d982e92cso757511b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752158885; x=1752763685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ccNFb5decGRIhbzkAZ9bEAXhYiv4SrqNXeSyqn4xl9E=;
        b=G+GCSVvGhsQG/YChNWX26RS2P+Ornzu9trm9rfN4NIL2WEiu9Qmn/ZD20PCouXZtWl
         jKR7SmNmxDrgcoNjeZh5fkp7KMDBkhESHvIXTE+sY1R6Lld01diZZyVJKXsy3AhRTXP8
         DqeDsLlMFvscBo1cRVtFQvt8FvxssbFAVC1KeOYYhvoT/oqpPbaWxAjZjBz+83Vy0E3c
         jWzcgVXlw8CIelvT5uNtLAxq4IkmTryMoh7PMgH+Hy2LdQ00FgprfTPIxo5OA1efvpRC
         tV6lb7tbQXtFdQ6k7kbXMiZjFYNcNhLsfKjmTHy/XxloJeeVxmq19b7X2+m1S5BjcTSP
         ugdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752158885; x=1752763685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccNFb5decGRIhbzkAZ9bEAXhYiv4SrqNXeSyqn4xl9E=;
        b=OvIZuTBPVT7697SZqtqGi7JJFpi4DRQA+XAsGMLc3Xv+1kDXadLscZB/7sTBfpOVkU
         ICWZOrdyE5fkTEwm9+AJ7sTLL26XC0tsqbmgOrTd1DLqTytH7RqDsnAK2MnT5yC9Osdp
         qcm/tVuS2srzA9Bu5kfUwgwvbbjPVr4VxF/OK7PiX1s0Llo2XSttDwd3d4cs+Fcs2Mwj
         WHEEM7/cuZgwrzWFJe0D5c7c9CD2meVN2otux8VqLTilRweZJbi+aM7loq9eH4nFYaw9
         T/XkpPBaFI6fcD9rjTWvL6xbSGHk+YAkSzOMW7N5YyalyXcImc7g2+ei/Lhu3hbE/Z9I
         p1bg==
X-Forwarded-Encrypted: i=1; AJvYcCVJnn3+F/D/E8sl1p+tEs8XPPYFIpTMJz2P5e9ikU7yWMIV04kdM3lSWe2tP5CHV2iCj+hefv4XMUFMDUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkamb/xpI9G+NhsdC8CpFkFoG8gS5hjyxcNsF1d9pVAjrb8DRR
	91TJyTrO7pbLDExl51yrZKW5W0wAiuIthnGJPv504CKf/bWXKrvZCMIPrtIAfmt+txw=
X-Gm-Gg: ASbGncuhrKkAJjZE79yShMSKtmIoUN9eIfKkR2Rj1TDcRg0uWXoGozGrkqUjdNWO+0m
	L/05pJEMCQIxdEtxYx9MY9M4ljfd8Zr9Q0smdJ7u9ej9+xp4VziRzsWmQ37b8WjWSE4etw1q9j1
	FR99s7o7akZ3Sau7Kbmr5epkD6o00BRvMcXddLvpMiE0WXmq7ymFMyDd5O6N1XHUx7Z/griIWww
	jowEJDjW8UHAcN5mIcQ4Fq2QaDPXn/ccnGLgHLYJcS/YGA2SXY6lSYQDxtNJ0PXltn6k8UH6Vyr
	IgDFhyFMOFgmvK67bqcv1bMhIbvWQp8/xxPIDAf4EmlfjJ1cZP/VSJuigNWS6v5tsBY9DHpqgmc
	=
X-Google-Smtp-Source: AGHT+IGKNID1gQGS7oI+kpuFVzsANRPvMDcUoQn73a5qDrhqS0bdqghfssNgK8KQOfs1Md97STuJ/A==
X-Received: by 2002:a05:6a00:1795:b0:742:3fb4:f992 with SMTP id d2e1a72fcca58-74ea64572dcmr9520507b3a.10.1752158885496;
        Thu, 10 Jul 2025 07:48:05 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3c1:4dff:9df5:b97c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe727e33sm2514249a12.68.2025.07.10.07.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:48:05 -0700 (PDT)
Date: Thu, 10 Jul 2025 08:48:02 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>, iuliana.prodan@nxp.com,
	daniel.baluta@nxp.com
Cc: andersson@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] remoteproc: imx_dsp_rproc: Add support of
 recovery process
Message-ID: <aG_SosukEqUxrHvH@p14s>
References: <20250704052529.1040602-1-shengjiu.wang@nxp.com>
 <20250704052529.1040602-2-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704052529.1040602-2-shengjiu.wang@nxp.com>

On Fri, Jul 04, 2025 at 01:25:28PM +0800, Shengjiu Wang wrote:
> When recovery is triggered, rproc_stop() is called first then
> rproc_start(), but there is no rproc_unprepare_device() and
> rproc_prepare_device() in the flow. As the software reset is needed
> before DSP starts, so move software reset from imx_dsp_runtime_resume()
> to .load() to make the recovery work. And make sure memory is cleared
> before loading firmware.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 43 +++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index 5ee622bf5352..ba764fc55686 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -774,7 +774,6 @@ static int imx_dsp_rproc_prepare(struct rproc *rproc)
>  {
>  	struct imx_dsp_rproc *priv = rproc->priv;
>  	struct device *dev = rproc->dev.parent;
> -	struct rproc_mem_entry *carveout;
>  	int ret;
>  
>  	ret = imx_dsp_rproc_add_carveout(priv);
> @@ -785,15 +784,6 @@ static int imx_dsp_rproc_prepare(struct rproc *rproc)
>  
>  	pm_runtime_get_sync(dev);
>  
> -	/*
> -	 * Clear buffers after pm rumtime for internal ocram is not
> -	 * accessible if power and clock are not enabled.
> -	 */
> -	list_for_each_entry(carveout, &rproc->carveouts, node) {
> -		if (carveout->va)
> -			memset(carveout->va, 0, carveout->len);
> -	}
> -
>  	return  0;
>  }
>  
> @@ -1022,13 +1012,39 @@ static int imx_dsp_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw
>  	return 0;
>  }
>  
> +static int imx_dsp_rproc_load(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct imx_dsp_rproc *priv = rproc->priv;
> +	const struct imx_dsp_rproc_dcfg *dsp_dcfg = priv->dsp_dcfg;
> +	struct rproc_mem_entry *carveout;
> +	int ret;
> +
> +	/* Reset DSP if needed */
> +	if (dsp_dcfg->reset)
> +		dsp_dcfg->reset(priv);
> +	/*
> +	 * Clear buffers after pm rumtime for internal ocram is not
> +	 * accessible if power and clock are not enabled.
> +	 */
> +	list_for_each_entry(carveout, &rproc->carveouts, node) {
> +		if (carveout->va)
> +			memset(carveout->va, 0, carveout->len);
> +	}
> +
> +	ret = imx_dsp_rproc_elf_load_segments(rproc, fw);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +

This is a much better approach.  During my last review I said that I would not
move forward with this work until Daniel or Iuliana provide their R-B and yet,
they have not been added to the recipient list.

>  static const struct rproc_ops imx_dsp_rproc_ops = {
>  	.prepare	= imx_dsp_rproc_prepare,
>  	.unprepare	= imx_dsp_rproc_unprepare,
>  	.start		= imx_dsp_rproc_start,
>  	.stop		= imx_dsp_rproc_stop,
>  	.kick		= imx_dsp_rproc_kick,
> -	.load		= imx_dsp_rproc_elf_load_segments,
> +	.load		= imx_dsp_rproc_load,
>  	.parse_fw	= imx_dsp_rproc_parse_fw,
>  	.handle_rsc	= imx_dsp_rproc_handle_rsc,
>  	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> @@ -1214,7 +1230,6 @@ static int imx_dsp_runtime_resume(struct device *dev)
>  {
>  	struct rproc *rproc = dev_get_drvdata(dev);
>  	struct imx_dsp_rproc *priv = rproc->priv;
> -	const struct imx_dsp_rproc_dcfg *dsp_dcfg = priv->dsp_dcfg;
>  	int ret;
>  
>  	/*
> @@ -1235,10 +1250,6 @@ static int imx_dsp_runtime_resume(struct device *dev)
>  		return ret;
>  	}
>  
> -	/* Reset DSP if needed */
> -	if (dsp_dcfg->reset)
> -		dsp_dcfg->reset(priv);
> -
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 

