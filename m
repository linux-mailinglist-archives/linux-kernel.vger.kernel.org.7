Return-Path: <linux-kernel+bounces-827576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FB4B9221B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DDE37A80A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A591310763;
	Mon, 22 Sep 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRLfBTly"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6648CFC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557234; cv=none; b=MyPA/zakeWX40ifWo3qombqW+ogGG+7gDq4zNaakCdeXsT8hojP2/or3gES2QCfxsdX0nElLVClcwgZ3EhJ1oRvHuplz5H8XAsCpc8ZFz/f9Sz/k1lk9AgZML1O1Psi6MDB0FjJhsirVw45rIULIOK1CXp8ZqIgUvvvWnhWLWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557234; c=relaxed/simple;
	bh=SGd/Y77sUXn6Zr/jkMncw9ZuF4nFQwtDQXKAhq+qfS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoP4WNpR8K+2f2RslABDdwfI7mdPIuPHse970ff/+ssBcqdHMYI8UPHSBtNVEqmOaPHg73jCJYghnGlu12Wm8S2jxFKvJdh8TPFbS93/QAUWcvafseRj/H1tCX7idLxmA0lzaKNy+ZTTKj94yLT621wm622Zt0Ul44gKkEy1FR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DRLfBTly; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2680cf68265so33959705ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758557232; x=1759162032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fBIeGLBQwDo9z1+Bndm5UcTEHsot/RRojoQ38PoeRdg=;
        b=DRLfBTlyHnUlMcWvnYMgQvmpSaqcJiqzu0BEqpV1QgdubDyXcYGLmLUnJxLti/all/
         dj/5C5VxBetClD9Mqyhzea5S+AaWykDwyvTRSXnxn7gxMI/lfVQ1WfDrN7u0ep2Ob5/9
         XKMODoLfya6/uZJEUFyCuM7sS5CdHQHvR+tGs8jLU0s2/vmZHa4T5Dt5mVizV1z78zA0
         3tII8HM3bLRGPauj6SO6sLU0hDEZ7bmafog/uxTmYaAPprJgh/9+cNGohmVxsDlhFDL4
         XS/wHbJ7KMbNyTfOFgG0N+Vt5VB6Do56MBtBx3oCXEvoiGlh3XdyytqWAqKOryA0X7Yq
         Jy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758557232; x=1759162032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBIeGLBQwDo9z1+Bndm5UcTEHsot/RRojoQ38PoeRdg=;
        b=khIuSCECLcaO/3eQTWzSo+1hIkWUcCNrT15nXtB+7ffJwJ2aNKYmvcqFYeYcEQw4H/
         zOl0U+vQBI8hioX6Xct5wUtHosCz8n2Je8XyiSxuvNTY73p0mFtVVTlx2Fnx95wK34ZA
         xlzg0MNGUcUcUIpYXIuMVqQUIF2QrFa92W+IxCbxpwcwhOw1MONfhEvswdbt6mMv9Zqe
         aSSgHb5v920Tccs+w6j22kANyvOT6uKfSQNxl0NGg28SAyrPsBixpBYuojQnhg8+fHrE
         KpNsNDgr4RipFfbX/jM3NhNtsAWTRmdK5fQrTahZS/Od3aglQImCILolayxu5itNAyb+
         YNTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkcICIiOoOL1/Nvhqf/+cFuidEBlLYRD97mVLRDsP2GhINctruqUuUKQXz2/Acc0hctzLAvTAVHg+5FEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8V2nL0e4b7K5EB1nUqPAa8bvh7ZwnZub3xKVkn6/+Nepx84Q
	zUCd1g3tkv3jiZ39ujL6Q3cpKQ1cZXs7CnV2X6Fz35qxaCgNv2lqUtnrBm4I+LvEaG0=
X-Gm-Gg: ASbGncvxsH2ftUwWsi1wBHZx3eB0PAW5DN1RwLKzP28oLZWmdvkb6rdWUBzRuePvJ14
	Ywe5w8uUCXIKDECMjhyy7fuhpPTzcCsfrwMG38z9kDBPf0mIaHTKVF/0sJXy5r0HrwNVehyQQD+
	m3QiyaIEHsJjtcHpRbtJSzehIGISB+HJhWCkyIY3Nzx98l/4x7uOQDH3vfpC4XAUGx9/d4rFiMy
	tznWHstTtGjeQqThgYm721Py92VKrz3kDb86BNxdnCM/2+Mbuu4yiLrXdPtu+TF78jn6qHVNJqX
	OsA4eZpxIUUAoZ7g9VJuM8YY4jXNRG431GuwTeuJlI33iPIT9MUTmIeqbIWZnWuicaaEPNaL4FB
	9J8QBXgxSVlxbGqtUNvyzL5lDv4VzAxrRbnx2um5PXtrrr++ZPg1oBzn7sjPIzZ61l+nEFf6QAR
	hzqLNfVjLObbSsJnig1EwkYnIxmZHg/Tl7RHU=
X-Google-Smtp-Source: AGHT+IH2NzERQbi1RoTQELtlO5ZOlqSD7C5iySM5N99gbWGr6H6ojxxoxB4xZsUBWMUxh34xDnn+dA==
X-Received: by 2002:a17:902:ccd2:b0:267:99bf:6724 with SMTP id d9443c01a7336-269ba50876fmr165383605ad.31.1758557232460;
        Mon, 22 Sep 2025 09:07:12 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:4631:7929:7e95:6485])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803184d3sm133896545ad.116.2025.09.22.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:07:11 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:07:08 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] remoteproc: imx_rproc: Fix runtime PM cleanup order
 and error handling
Message-ID: <aNF0LFkuS_hADmrz@p14s>
References: <20250917-imx_rproc_c2-v1-0-00ce23dc9c6e@nxp.com>
 <20250917-imx_rproc_c2-v1-1-00ce23dc9c6e@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-imx_rproc_c2-v1-1-00ce23dc9c6e@nxp.com>

On Wed, Sep 17, 2025 at 09:19:13PM +0800, Peng Fan wrote:
> The order of runtime PM API calls in the remove path is wrong.
> pm_runtime_put() should be called before pm_runtime_disable(), per the
> runtime PM guidelines.

Where is this mentioned?  I have looked in [1] and couldn't find anything.

[1]. Documentation/power/runtime_pm.rst

> Calling pm_runtime_disable() prematurely can
> lead to incorrect reference counting and improper device suspend behavior.
> 
> Additionally, proper cleanup should be done when rproc_add() fails by
> invoking both pm_runtime_put() and pm_runtime_disable() to avoid leaving
> the device in an inconsistent power state.
> 
> With using devm_pm_runtime_enable() for automatic resource management and
> introducing a devres-managed cleanup action imx_rproc_pm_runtime_put() to
> enforce correct PM API usage and simplify error paths, the upper two
> issues could be fixed. Also print out error log in case of error.
> 
> Fixes: a876a3aacc43 ("remoteproc: imx_rproc: detect and attach to pre-booted remote cores")
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Hiago De Franco <hiago.franco@toradex.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index bb25221a4a8987ff427d68e2a5535f0e156b0097..12305f36552fb5265b0953a099ea0d561880e3ff 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -1046,6 +1046,13 @@ static int imx_rproc_sys_off_handler(struct sys_off_data *data)
>  	return NOTIFY_DONE;
>  }
>  
> +static void imx_rproc_pm_runtime_put(void *data)
> +{
> +	struct device *dev = data;
> +
> +	pm_runtime_put(dev);
> +}
> +
>  static int imx_rproc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1125,12 +1132,23 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  	}
>  
>  	if (dcfg->method == IMX_RPROC_SCU_API) {
> -		pm_runtime_enable(dev);
> +		ret = devm_pm_runtime_enable(dev);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable runtime PM, %d\n", ret);
> +			goto err_put_clk;
> +		}
> +
>  		ret = pm_runtime_resume_and_get(dev);
>  		if (ret) {
>  			dev_err(dev, "pm_runtime get failed: %d\n", ret);
>  			goto err_put_clk;
>  		}
> +
> +		ret = devm_add_action_or_reset(dev, imx_rproc_pm_runtime_put, dev);
> +		if (ret) {
> +			dev_err(dev, "Failed to add devm disable pm action: %d\n", ret);
> +			goto err_put_clk;
> +		}
>  	}
>  
>  	ret = rproc_add(rproc);
> @@ -1158,10 +1176,6 @@ static void imx_rproc_remove(struct platform_device *pdev)
>  	struct rproc *rproc = platform_get_drvdata(pdev);
>  	struct imx_rproc *priv = rproc->priv;
>  
> -	if (priv->dcfg->method == IMX_RPROC_SCU_API) {
> -		pm_runtime_disable(priv->dev);
> -		pm_runtime_put(priv->dev);
> -	}
>  	clk_disable_unprepare(priv->clk);
>  	rproc_del(rproc);
>  	imx_rproc_put_scu(rproc);
> 
> -- 
> 2.37.1
> 

