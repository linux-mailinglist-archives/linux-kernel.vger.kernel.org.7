Return-Path: <linux-kernel+bounces-614713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE737A97094
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 17:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1063B1980
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8960D28EA7C;
	Tue, 22 Apr 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCL1Fhxt"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5DE2857C9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335583; cv=none; b=GQ8c3UgQQNfxMcOBzZX4F9TU+rPZnj3tOnhc2WxXTKotnDepsXKZOOq/URsHWK4IOmtR1as2UCm2SGZScFtiLdPnq+KKNTrYY3ptDVnDxqYEoKVLd7AqxajChZEywbGm5XRqz6I1klYAbK2ZzAF2S53ok6ZHkd2BDPI12hqocC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335583; c=relaxed/simple;
	bh=NoIMWwnq7BHouS5MdwFKZQWpwEd6LRNzgqmMj0dTMR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWdnQX0hOuTCQyWZLOiMVFdcywoO1o+ZRYcZcKgebtX+dif6BuGFNQHw1CV/7n6WOW1YS7VC15f+oRGNHMKcDu4w8cJE+FhVhSyngzgT5vrKwLjnXK5metBcGkdtpX0NZDMBshZCu+c+LCo/3URsdPj70KnnuHo3IUmsssEf15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DCL1Fhxt; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-301a4d5156aso5595493a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 08:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745335581; x=1745940381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYHxgDGXO5+KmD5hIUPp/Tj+/YwJQfgj9/mg6ZyVl2Y=;
        b=DCL1FhxtlOgZJfKmHDOmammvTTYncuF/xcNScRGQWKnYGv5QmtVocv0RyvVcUYM7Pk
         fquqrAfRwDwDcAI2yF5MzGhpq9yzpzK+hlNmGeX6efcrmQdrIP5zVPQckOyUc/4bXB7G
         mAbsVserxxJMueABFjmEh6kT8nIdo3om0d59Y7duQahHPKPkZvRH42REMJlXzwPbvub5
         6jWGZwiHdZJ/FcYqjRxfJyPkldLyMwpskXdqsK13oqa9y9sF6Srg42OwunLcfO/bU8QU
         ogBIsGfBhfT08VoJ305jEo6/k/dS4kVf7bLVIQO8YjlyiJt+Bcisck4ycnDZ4czm6VCv
         9VfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745335581; x=1745940381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYHxgDGXO5+KmD5hIUPp/Tj+/YwJQfgj9/mg6ZyVl2Y=;
        b=VpgVfaDZ22sCPkqe5nREC4zLC09WCYiEdtKMM9Jpmb9CLxqCUkz3zOCtbhyjo0fqQG
         fnBIYWXesith4GtodIBWUg242hru1RXJhhwtirURjWNEXzTD0dsxUNpGE9SQIJVVzMT0
         XdVUh99X+z9jCPVa/bh+OwKervt8oqhA/ok8NIUsGMxK3X2xkboSYbGbGl/agn6YEUJm
         zEJtF9LFSGld5+82mFyxJiMrp45YUFh6DPrfCtPDGtaA6Y8XBEEOaT4Wwp4I4NDvQWIv
         /3O5YQfLoDwOdz5F4hgPG+NRe9oPNLDE+VSdWj0RZr0pW/L2ydwxmFmh55LA3tZuaFuY
         BrSw==
X-Forwarded-Encrypted: i=1; AJvYcCVbUeXuIphlNh7UiNNX8P5ORrIB0M707fPTdjVdEyli8Q7pdxg2swXI5U9EyQy51HpYhdCdH1lTjwxp9Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pp80n5lon0ucPMflETwdh2HYh1NwMTJ5dubKp7Ck+TYvKHz+
	2q3a5ahH9UCVwCNmtsvkmNklcztEu8Dc+l9SePn7/38WyrDJbzDR4ETJpa4Xf5lZU6+3C0jfFvN
	i
X-Gm-Gg: ASbGnctNv5IAkwa0LYGjUUI72e7B/rEzwiCAwTdDTVk8Jg0NGL5dUSCsbQ3fcRjvIQV
	GsZ35livu9CGtIo0fun1KtkaduBsYvMcEDxxwCuzRo3rnYcTfNTtjdIroCl8TFsV1UcMemyp1kU
	fMHPmyBhL+Iuni/zz/vnVM4tODmL6dHL8IvpDWkk7JPtWBUP/k6IMjCCD+bUWC93l+5a0m+PeUV
	X6oTIrNPyETClNo54vVG0jVMn3xevqQyn7ALcLlOHmBt9B+osC30zEzmH9Yp74H+mYw+6dM2dAD
	vUq1835h1KYCJ13NetXigI6cbXw41OlbfBJubYOHQ4XR
X-Google-Smtp-Source: AGHT+IFKdPqXfG2PDOZJlWrx5F/OcrmgSWRYGt4yShrlHtNv9ZIbsa8RQSsnfUd0cOhJjZ0RKioIng==
X-Received: by 2002:a17:90b:270b:b0:2fe:a614:5cf7 with SMTP id 98e67ed59e1d1-3087bb422e9mr21115170a91.3.1745335581018;
        Tue, 22 Apr 2025 08:26:21 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2e83:e5cb:87bf:4641])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087e0febd4sm8823408a91.36.2025.04.22.08.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 08:26:20 -0700 (PDT)
Date: Tue, 22 Apr 2025 09:26:17 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"S.J. Wang" <shengjiu.wang@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mpuaudiosw <Mpuaudiosw@nxp.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, imx@lists.linux.dev,
	linux-remoteproc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v5] remoteproc: imx_dsp_rproc: Add support for
 DSP-specific features
Message-ID: <aAe1GUqYT_Iv2ZmB@p14s>
References: <20250416075613.2116792-1-iuliana.prodan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416075613.2116792-1-iuliana.prodan@oss.nxp.com>

On Wed, Apr 16, 2025 at 10:56:13AM +0300, Iuliana Prodan (OSS) wrote:
> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> 
> Some DSP firmware requires a FW_READY signal before proceeding, while
> others do not.
> Therefore, add support to handle i.MX DSP-specific features.
> 
> Implement handle_rsc callback to handle resource table parsing and to
> process DSP-specific resource, to determine if waiting is needed.
> 
> Update imx_dsp_rproc_start() to handle this condition accordingly.
> 
> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Applied.

Thanks,
Mathieu

> ---
> Changes in v5:
> - Reviews from Mathieu Poirier:
>   - ensure resource length matches struct size exactly.
> - Link to v4: https://lore.kernel.org/all/20250409213030.3489481-1-iuliana.prodan@oss.nxp.com/
> 
> Changes in v4:
> - Reviews from Mathieu Poirier:
>   - Adjusted len to include the size of struct fw_rsc_imx_dsp.
>   - Updated len validation checks.
> - Review from Frank Li:
>   - In imx_dsp_rproc_handle_rsc(), removed the goto ignored statement.
> - In probe(), set flags to WAIT_FW_READY to ensure the host waits
> for fw_ready when no vendor-specific resource is defined.
> - Link to v3: https://lore.kernel.org/all/20250403100124.637889-1-iuliana.prodan@oss.nxp.com/
> 
> Changes in v3:
> - Reviews from Mathieu Poirier:
>   - Added version and magic number to vendor-specific resource table entry.
>   - Updated defines to maintain backward compatibility with a resource table that doesn't have a vendor-specific resource.
>     - By default, wait for `fw_ready`, unless specified otherwise.
> - Link to v2: https://lore.kernel.org/all/20250318215007.2109726-1-iuliana.prodan@oss.nxp.com
> 
> Changes in v2:
> - Reviews from Mathieu Poirier:
>   - Use vendor-specific resource table entry.
>   - Implement resource handler specific to the i.MX DSP.
> - Revise commit message to include recent updates.
> - Link to v1: https://lore.kernel.org/all/20250305123923.514386-1-iuliana.prodan@oss.nxp.com/
> 
>  drivers/remoteproc/imx_dsp_rproc.c | 98 +++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index b9bb15970966..a16d9c4238ed 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -35,9 +35,18 @@ module_param_named(no_mailboxes, no_mailboxes, int, 0644);
>  MODULE_PARM_DESC(no_mailboxes,
>  		 "There is no mailbox between cores, so ignore remote proc reply after start, default is 0 (off).");
>  
> +/* Flag indicating that the remote is up and running */
>  #define REMOTE_IS_READY				BIT(0)
> +/* Flag indicating that the host should wait for a firmware-ready response */
> +#define WAIT_FW_READY				BIT(1)
>  #define REMOTE_READY_WAIT_MAX_RETRIES		500
>  
> +/*
> + * This flag is set in the DSP resource table's features field to indicate
> + * that the firmware requires the host NOT to wait for a FW_READY response.
> + */
> +#define FEATURE_DONT_WAIT_FW_READY		BIT(0)
> +
>  /* att flags */
>  /* DSP own area */
>  #define ATT_OWN					BIT(31)
> @@ -72,6 +81,10 @@ MODULE_PARM_DESC(no_mailboxes,
>  
>  #define IMX8ULP_SIP_HIFI_XRDC			0xc200000e
>  
> +#define FW_RSC_NXP_S_MAGIC			((uint32_t)'n' << 24 |	\
> +						 (uint32_t)'x' << 16 |	\
> +						 (uint32_t)'p' << 8 |	\
> +						 (uint32_t)'s')
>  /*
>   * enum - Predefined Mailbox Messages
>   *
> @@ -136,6 +149,24 @@ struct imx_dsp_rproc_dcfg {
>  	int (*reset)(struct imx_dsp_rproc *priv);
>  };
>  
> +/**
> + * struct fw_rsc_imx_dsp - i.MX DSP specific info
> + *
> + * @len: length of the resource entry
> + * @magic_num: 32-bit magic number
> + * @version: version of data structure
> + * @features: feature flags supported by the i.MX DSP firmware
> + *
> + * This represents a DSP-specific resource in the firmware's
> + * resource table, providing information on supported features.
> + */
> +struct fw_rsc_imx_dsp {
> +	uint32_t len;
> +	uint32_t magic_num;
> +	uint32_t version;
> +	uint32_t features;
> +} __packed;
> +
>  static const struct imx_rproc_att imx_dsp_rproc_att_imx8qm[] = {
>  	/* dev addr , sys addr  , size	    , flags */
>  	{ 0x596e8000, 0x556e8000, 0x00008000, ATT_OWN },
> @@ -300,6 +331,66 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
>  	return -ETIMEDOUT;
>  }
>  
> +/**
> + * imx_dsp_rproc_handle_rsc() - Handle DSP-specific resource table entries
> + * @rproc: remote processor instance
> + * @rsc_type: resource type identifier
> + * @rsc: pointer to the resource entry
> + * @offset: offset of the resource entry
> + * @avail: available space in the resource table
> + *
> + * Parse the DSP-specific resource entry and update flags accordingly.
> + * If the WAIT_FW_READY feature is set, the host must wait for the firmware
> + * to signal readiness before proceeding with execution.
> + *
> + * Return: RSC_HANDLED if processed successfully, RSC_IGNORED otherwise.
> + */
> +static int imx_dsp_rproc_handle_rsc(struct rproc *rproc, u32 rsc_type,
> +				    void *rsc, int offset, int avail)
> +{
> +	struct imx_dsp_rproc *priv = rproc->priv;
> +	struct fw_rsc_imx_dsp *imx_dsp_rsc = rsc;
> +	struct device *dev = rproc->dev.parent;
> +
> +	if (!imx_dsp_rsc) {
> +		dev_dbg(dev, "Invalid fw_rsc_imx_dsp.\n");
> +		return RSC_IGNORED;
> +	}
> +
> +	/* Make sure resource isn't truncated */
> +	if (sizeof(struct fw_rsc_imx_dsp) > avail ||
> +	    sizeof(struct fw_rsc_imx_dsp) != imx_dsp_rsc->len) {
> +		dev_dbg(dev, "Resource fw_rsc_imx_dsp is truncated.\n");
> +		return RSC_IGNORED;
> +	}
> +
> +	/*
> +	 * If FW_RSC_NXP_S_MAGIC number is not found then
> +	 * wait for fw_ready reply (default work flow)
> +	 */
> +	if (imx_dsp_rsc->magic_num != FW_RSC_NXP_S_MAGIC) {
> +		dev_dbg(dev, "Invalid resource table magic number.\n");
> +		return RSC_IGNORED;
> +	}
> +
> +	/*
> +	 * For now, in struct fw_rsc_imx_dsp, version 0,
> +	 * only FEATURE_DONT_WAIT_FW_READY is valid.
> +	 *
> +	 * When adding new features, please upgrade version.
> +	 */
> +	if (imx_dsp_rsc->version > 0) {
> +		dev_warn(dev, "Unexpected fw_rsc_imx_dsp version %d.\n",
> +			 imx_dsp_rsc->version);
> +		return RSC_IGNORED;
> +	}
> +
> +	if (imx_dsp_rsc->features & FEATURE_DONT_WAIT_FW_READY)
> +		priv->flags &= ~WAIT_FW_READY;
> +
> +	return RSC_HANDLED;
> +}
> +
>  /*
>   * Start function for rproc_ops
>   *
> @@ -335,8 +426,8 @@ static int imx_dsp_rproc_start(struct rproc *rproc)
>  
>  	if (ret)
>  		dev_err(dev, "Failed to enable remote core!\n");
> -	else
> -		ret = imx_dsp_rproc_ready(rproc);
> +	else if (priv->flags & WAIT_FW_READY)
> +		return imx_dsp_rproc_ready(rproc);
>  
>  	return ret;
>  }
> @@ -936,6 +1027,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
>  	.kick		= imx_dsp_rproc_kick,
>  	.load		= imx_dsp_rproc_elf_load_segments,
>  	.parse_fw	= imx_dsp_rproc_parse_fw,
> +	.handle_rsc	= imx_dsp_rproc_handle_rsc,
>  	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
>  	.sanity_check	= rproc_elf_sanity_check,
>  	.get_boot_addr	= rproc_elf_get_boot_addr,
> @@ -1053,6 +1145,8 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
>  	priv = rproc->priv;
>  	priv->rproc = rproc;
>  	priv->dsp_dcfg = dsp_dcfg;
> +	/* By default, host waits for fw_ready reply */
> +	priv->flags |= WAIT_FW_READY;
>  
>  	if (no_mailboxes)
>  		imx_dsp_rproc_mbox_init = imx_dsp_rproc_mbox_no_alloc;
> -- 
> 2.25.1
> 

