Return-Path: <linux-kernel+bounces-827630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BAEB92417
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6A8444AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18627311C2C;
	Mon, 22 Sep 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nf5M7KnP"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782926CE3C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559264; cv=none; b=QelJ9+hxuOOsmQaNatq7wfPnLOwjt4++RJVtGvFLv2s0BXOYjBPwxOH+YxMtrNshU6DhsmjNITsXRysZwgnUP348V7V0RAUMz+gUBOnN5lUu97omkRWDFM+viFZwkhsG/QKNzofUj+QK/6aykD0i+ki7NyyLORly7F31EB6Y/+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559264; c=relaxed/simple;
	bh=1ZvXKVOnEWKPv0EuGqrvl/hwuFDcuRdXnxKxZqVvQdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYJTVouBeG7PvSjY9sB8Wsou91NzAb2lDpghjaEUUUtlu2I+BlS3xaKyD3ELnRjFz6drJl4srpHOBG9hWyEiGDNQ3mLJ2+U2JPEW+ssCKvaAlLoSTZLrw3q05OR2GqrHqlgecdWwqQ/YpFrjmgkcS8gogoDkTtC4qtHrAH0seko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nf5M7KnP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-271067d66fbso22014185ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758559262; x=1759164062; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8IhdqQk9DvI4AFmg9naSg1FH7sc1HQKYfUNgmIemfvA=;
        b=nf5M7KnPeUm3huL6e/ik80s9jzojdxfQn7cSdBAqSNFTBOUZu89RAVSd1AhsnsnhzH
         56g9HzRbkl9YnPUFK7TnhlggDZF5BtJgZvNyrPg2uCpmElfjPkEw8XwDcFv80I5E3T7Q
         ZcPGyGE4LGJcLmLIc423Wn7212Q7yQlKmd7G44WSOcytGtZZrHE/EYsJrUgXbdGTFJCr
         VlpRbHi6j9sXkjg3z8ooS+l7bkdUZ1aJwl6c9hoqhoSMpPY9MFcNJyUBQQ2KiAwBdql8
         L+f9odkqCrtt7umII1Uk0WhfRmyRM1U2klsDJjyPOnUsugBSjs5m9C6kOsuyU0xoOiUx
         dlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758559262; x=1759164062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IhdqQk9DvI4AFmg9naSg1FH7sc1HQKYfUNgmIemfvA=;
        b=JYx7iFFvrcDbUGwyIevaNdLE0qmh0jZCS44l31pBm6Ryy5Otml4peu/svKBSxUSxpb
         iCclNLRJ0z2CfsSJrob6tUQg2aLfq7G6k6pmRGiRkbQP0IoBAJ4n0yD8HhwnMdU3zy2e
         OCiLqzhr36xTMQmbQAWu9XCzyDH1SOGSq8XUsy57M+Rq3tEBJKHQv7ZQth8nUyUnVgiI
         ghDOKv7S+VNUj/zwBFl+iq1DSEV+oXOvzsK3vkov3BsaQLlFLO91r2C9MWo9lm1BZUf9
         kF6jIt2CXlvZGI+/LgEXWwh0sE8vtVBWcFpZANAwTUhpznojXrj8DbkhJ/Y2BNKHle7o
         bMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXa5x69UxjPly7Im/taty4oYhshkzZZHh0pkCYOElCTc+VXcZ+OPQJc4o4Vi6e23OANOJU5JmZCBY5XXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQOMa8fUFGTUiqr0iwLVo5Kz8JVkUzcbvG/IIBz9o0UXDjLbTH
	8XZa/cQN1AgNH9dc8cu1xc/Ez+WsGTAEm+Lk7bG81pVNqdMM99Z7Ng3N5+GMgfYE7kk=
X-Gm-Gg: ASbGnctd2wG9RsACXqoaHaRyCIiXifziv+4QPQkTcEIvyoEQKKK94X/eR+iIrQ/83+k
	Y3OFrdbHkX01lnQ7Ynyb+X2fVTWJC0IlBXaKNpHw8zuZx2ZtvQXWiFcKES5RJmB6yn4f8ZLEwwP
	HaSu4bDQMFfWsl8MWYTBCr/ZmcYPLm3OimCqFT6tLyxRDZ3WMFQJ4grVNm500TJ1WReXVfW39Ft
	fpgvjiShnSNRs4GqWnKsl7UkzA+mMAWJQf/pi2A0BEwQy9oJRXw8S7uCbedVMvRhxoUrqVSBMyT
	iIrzMGUvp3a57Nk6MAOQA+6cqft0OZl/wN3pFM4xl5aPNQl6B4EI+5rYLTTXe7jydv8jPiSvG/N
	RM4AdLnYPCWPsOy5oeAxi0/H+Z8lr68XJXLsb3wIWNyot2wISnOjxJhtnkB6mz/FO6J9JC9Vjlz
	/fc4etwKr9jSjxxtV7WhVQy71u
X-Google-Smtp-Source: AGHT+IEfgeLF7s67XVRDD8PRT9D2ccPv3NRL1m9Ax/Yy510Mn/2xkDPBuMAlPcQAyv9mkisQ4XQ6SQ==
X-Received: by 2002:a17:902:c402:b0:267:8049:7c7f with SMTP id d9443c01a7336-269ba3e9219mr175928935ad.7.1758559262001;
        Mon, 22 Sep 2025 09:41:02 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:4631:7929:7e95:6485])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698018167asm136546225ad.57.2025.09.22.09.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:41:01 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:40:58 -0600
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
Subject: Re: [PATCH 4/6] remoteproc: imx_rproc: Use devm_clk_get_enabled()
 and simplify cleanup
Message-ID: <aNF8GgKGvokLq0mf@p14s>
References: <20250917-imx_rproc_c2-v1-0-00ce23dc9c6e@nxp.com>
 <20250917-imx_rproc_c2-v1-4-00ce23dc9c6e@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917-imx_rproc_c2-v1-4-00ce23dc9c6e@nxp.com>

On Wed, Sep 17, 2025 at 09:19:16PM +0800, Peng Fan wrote:
> Replace separate calls to devm_clk_get() and clk_prepare_enable() with
> devm_clk_get_enabled(), which combines clock acquisition and enabling
> into a single managed step. Simplify the probe logic and remove the need
> for manual clock disable in error and remove paths.
> 
> Also, update error handling to eliminate redundant cleanup steps and use
> return-based error propagation where appropriate. Improve code clarity and
> reduce the chance of resource leaks or incorrect ordering in cleanup paths.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index e30b61ee39dacc88f9e938f8c6ffe61fef63dbda..c6cfb308ddb376f370fd4492f8a84f734602bac8 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -1006,26 +1006,19 @@ static int imx_rproc_clk_enable(struct imx_rproc *priv)
>  {
>  	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
>  	struct device *dev = priv->dev;
> -	int ret;
>  
>  	/* Remote core is not under control of Linux or it is managed by SCU API */
>  	if (dcfg->method == IMX_RPROC_NONE || dcfg->method == IMX_RPROC_SCU_API)
>  		return 0;
>  
> -	priv->clk = devm_clk_get(dev, NULL);
> -	if (IS_ERR(priv->clk)) {
> -		dev_err(dev, "Failed to get clock\n");
> -		return PTR_ERR(priv->clk);
> -	}
> -
>  	/*
>  	 * clk for M4 block including memory. Should be
>  	 * enabled before .start for FW transfer.
>  	 */
> -	ret = clk_prepare_enable(priv->clk);
> -	if (ret) {
> +	priv->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(priv->clk)) {
>  		dev_err(dev, "Failed to enable clock\n");
> -		return ret;
> +		return PTR_ERR(priv->clk);
>  	}
>  
>  	return 0;
> @@ -1134,7 +1127,7 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  						    imx_rproc_sys_off_handler, rproc);
>  		if (ret) {
>  			dev_err(dev, "register power off handler failure\n");
> -			goto err_put_clk;
> +			goto err_put_scu;
>  		}
>  
>  		ret = devm_register_sys_off_handler(dev, SYS_OFF_MODE_RESTART_PREPARE,
> @@ -1142,7 +1135,7 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  						    imx_rproc_sys_off_handler, rproc);
>  		if (ret) {
>  			dev_err(dev, "register restart handler failure\n");
> -			goto err_put_clk;
> +			goto err_put_scu;
>  		}
>  	}
>  
> @@ -1150,32 +1143,30 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  		ret = devm_pm_runtime_enable(dev);
>  		if (ret) {
>  			dev_err(dev, "Failed to enable runtime PM, %d\n", ret);
> -			goto err_put_clk;
> +			goto err_put_scu;
>  		}
>  
>  		ret = pm_runtime_resume_and_get(dev);
>  		if (ret) {
>  			dev_err(dev, "pm_runtime get failed: %d\n", ret);
> -			goto err_put_clk;
> +			goto err_put_scu;
>  		}
>  
>  		ret = devm_add_action_or_reset(dev, imx_rproc_pm_runtime_put, dev);
>  		if (ret) {
>  			dev_err(dev, "Failed to add devm disable pm action: %d\n", ret);
> -			goto err_put_clk;
> +			goto err_put_scu;
>  		}
>  	}
>  
>  	ret = rproc_add(rproc);
>  	if (ret) {
>  		dev_err(dev, "rproc_add failed\n");
> -		goto err_put_clk;
> +		goto err_put_scu;
>  	}
>  
>  	return 0;
>  
> -err_put_clk:
> -	clk_disable_unprepare(priv->clk);
>  err_put_scu:
>  	imx_rproc_put_scu(rproc);
>  
> @@ -1187,7 +1178,6 @@ static void imx_rproc_remove(struct platform_device *pdev)
>  	struct rproc *rproc = platform_get_drvdata(pdev);
>  	struct imx_rproc *priv = rproc->priv;
>  
> -	clk_disable_unprepare(priv->clk);

/home/mpoirier/work/remoteproc/kernel/drivers/remoteproc/imx_rproc.c: In
function ‘imx_rproc_remove’:
/home/mpoirier/work/remoteproc/kernel/drivers/remoteproc/imx_rproc.c:1179:27:
warning: unused variable ‘priv’ [-Wunused-variable]
 1179 |         struct imx_rproc *priv = rproc->priv;
      |                           ^~~~
  AR      drivers/remoteproc/built-in.a
  AR      drivers/built-in.a
  AR      kernel/module/built-in.a
  AR      kernel/built-in.a

>  	rproc_del(rproc);
>  	imx_rproc_put_scu(rproc);
>  }
> 
> -- 
> 2.37.1
> 

