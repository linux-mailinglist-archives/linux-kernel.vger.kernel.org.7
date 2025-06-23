Return-Path: <linux-kernel+bounces-698691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55951AE4873
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 17:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E10B1B61CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 15:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F5229A310;
	Mon, 23 Jun 2025 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecvmKvQV"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD130299AAA
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691758; cv=none; b=VIZQSYfQqcOQk9i1DIPVZ7seP3Y35E8UQDIc+wLCgZrn5M+12eSZ35WJccdChFMVB7BcwWbebkDtMh97Nkiwvmz1SHpRPNPNLTC91uPx1lxK1YSvjezx+q15aMiAgO0nhLdp1m4kECqe/bBzwfHXaID7nACALfWUw4/pIzxC8xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691758; c=relaxed/simple;
	bh=hY1AO9wd7FYeyL43dCiTnguCwp/cs4kPIauJ1coyPFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri1Y6vsKd8Xq16nwKiVXvfzgeoRUhVCDXfaDE/Xts2dLW1CsLIkLraa3+H2GrUimo1YJrfCcZcqMYZA9RYhy4BwPySZL6wioVA+kAetcedcOxcSUfpeu3Jc0afmrr9lui81BvvXlibH/z37GqgQLVSPWxv1ufAXHSeJuthi8sck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ecvmKvQV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23694cec0feso39407265ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750691755; x=1751296555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T27t2nmr6ecFVKTwe7GdRGC1UuMYhsoPFZxzjgMw7XA=;
        b=ecvmKvQVSsFDCL4gILMJcuuv0vsvKhtdS2iS3QwgZ8v9BVO4m0kn1XewyZ3vFdbZzd
         INqAk62Zz+oZe0dCKX4nX9F7kv7UOYC8g2G/8zGpUJPb+XKopYIijISRxe3VQYoiy7Pp
         8bxm/gxc/5mUoTQN+bh6YAROdbYEuwQFc56v11MVmOJcrn4u4AN1DXQsCuVJDWqF9TYe
         SdGIgJHBIP231dk8objzems6Z53hsBXyd9dkpb0DsphGKHCOOoCD0zFra04BXH6YCJgv
         EGACSMZL9cnQQcZJvdTKVuMi8350JkcF6R16DL+DCcb84v+IJAV+/tGPvWcQt7iYKrKS
         N3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691755; x=1751296555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T27t2nmr6ecFVKTwe7GdRGC1UuMYhsoPFZxzjgMw7XA=;
        b=wYtjCju+QDE9hohMg+BhpFtzGauj0ySWlHsvZZzDXXwT0VTTZyp9Cl1DCrn0qU+lCk
         qEYytPJu9ChLgBwZVWmX+65me7a9/1A1OttHna1TMRy5oBmvoyiKItMVmvLAjVpGDUgk
         4AbfrvWi8PUTY+5Xu65AP4LCFPybbfNXPq5C1qL89hh/+vjgxRMYKqWTnfjbgn9TJGkm
         7hcaPnBf0O7pJGNoaSAyCYQDwPUrOAws6hKs4wJGkWjDeyJU2x8kbPUF9SNfoyMW5MjC
         YGnHCO4GnweKqEkmE5CU92uv/qRFZnLPA2yv01qksVAxqIt2bErqij2nIg1g0BaUPhWW
         j/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUOnL1yzfyxqK3o5/s3qCxwQBJTLr3rNtXO9av1BteZ0T4uJi0VCuiEGVbNkNLJo4OeuRaIr6hihDd/aZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJzawMekwHeWP9QNd5ssnu7/qBANxZfU2YrUuJ6hOIwr6MHwP
	y5nQpis26X4ngJg2MZAIeSl33MmedxUDOha/tusGm5HwtcRN6QURNKKbFPxjHBAJ+j0=
X-Gm-Gg: ASbGncvjMNmh0IOloOjXFbFxhHvd7S3akTWA32GVp2ioxNUWpsh12i6F+8CeT6643My
	ynM1ztpsFKGy5ZcqeKDDe3WU1V3pOaT3SpTyGgzKcZnd0VMrSIVqmY3pMpdolEno9pnSK1Ir5CJ
	cn2b455fXvFxkv1Tgg9/oJS6kTP8sggYwj3mtv1Wtd0ojykURVMgKk9fb5uVVgFKtEtttrRCHWT
	s+xl0lvliC8Sm7d3MBGYsubyXFBsvL0QialRQr0bnuFWsIjUxYy54DnlWYMPgsSdkb8oF+KjedN
	sdqz4YePDqubwkyJ0Gbndmh7AURXVEgINgRK8AVaP6aW9DXEjxOpcSq+E1x0/utC
X-Google-Smtp-Source: AGHT+IGEfd7ew/DbegL4/ehEu6z8rdU2NqGKWQUxfqGQJFlSmPlquHaa0QFJscSdtTcWRu86BS4OCA==
X-Received: by 2002:a17:903:1b66:b0:234:d2fb:2d0e with SMTP id d9443c01a7336-237d96dfe41mr236501275ad.10.1750691755197;
        Mon, 23 Jun 2025 08:15:55 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:d145:b99:ea4b:a65f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d866488csm85961605ad.158.2025.06.23.08.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:15:54 -0700 (PDT)
Date: Mon, 23 Jun 2025 09:15:52 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com,
	iuliana.prodan@oss.nxp.com,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v5 2/3] remoteproc: imx_rproc: skip clock enable when
 M-core is managed by the SCU
Message-ID: <aFlvqK6SHvWHIpMn@p14s>
References: <20250617193450.183889-1-hiagofranco@gmail.com>
 <20250617193450.183889-3-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617193450.183889-3-hiagofranco@gmail.com>

Hi Hiago,

On Tue, Jun 17, 2025 at 04:34:49PM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> For the i.MX8X and i.MX8 family SoCs, when the M-core is powered up
> by the bootloader, M-core and Linux are in same SCFW (System Controller
> Firmware) partition, so linux has permission to control M-core.

Ok

> 
> But when M-core is started, the SCFW will automatically enable the clock

I find the "But when M-core is started" part confusing.  Started by who?  And
are you making a distinction between "powered up" and "started"?  It is not
possible for someone that doesn't have HW documentation to understand what is
going on. 

> and configure the rate, and any users that want to enable the clock will
> get error 'LOCKED' from SCFW. So current imx_rproc.c probe function
> fails because clk_prepare_enable also fails. With that, the M-core power
> domain is powered off when it is still running, causing a SCU (System
> Controller Unit) fault reset, and the system restarts.
> 
> To address the issue, ignore handling the clk for i.MX8X and i.MX8 M-core,
> because SCFW will automatically enable and configure the clock.
> 
> Suggested-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> ---
> v4 -> v5:
>  - Unchanged.
> v3 -> v4:
>  - Unchanged.
> v2 -> v3:
>  - Unchanged.
> v1 -> v2:
>  - Commit description updated, as suggested. Fixed Peng Fan email.
> ---
>  drivers/remoteproc/imx_rproc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 74299af1d7f1..627e57a88db2 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -1029,8 +1029,8 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv)
>  	struct device *dev = priv->dev;
>  	int ret;
>  
> -	/* Remote core is not under control of Linux */
> -	if (dcfg->method == IMX_RPROC_NONE)
> +	/* Remote core is not under control of Linux or it is managed by SCU API */
> +	if (dcfg->method == IMX_RPROC_NONE || dcfg->method == IMX_RPROC_SCU_API)
>  		return 0;
>  
>  	priv->clk = devm_clk_get(dev, NULL);
> -- 
> 2.39.5
> 

