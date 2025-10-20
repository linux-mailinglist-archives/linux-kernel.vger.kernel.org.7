Return-Path: <linux-kernel+bounces-861239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 030E6BF223D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2641E42750E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2C326C3BF;
	Mon, 20 Oct 2025 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4euLhwA"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D279826B2DB
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974652; cv=none; b=JBkU1+3hkpBonJDU3pAIK3zCtILWaW03sAdqGwJhAmTomTWwxvraLJQij1HElCiDxSMkX6mmfn1vd0TavCpDi506eC2TEl5Bown4riRUOYuqOuQ1e0GPlpbVZm+gODEV/SymCn4UuDzZdENyD7C9afXOvjxd1qwWoUtyic8L2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974652; c=relaxed/simple;
	bh=uvtKdw8fhD9Bm/d4sfVL5BsOH6AlqthiaBj+rlosuKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emuL04huXAy5FWG8m9WHCgVaXmp7B7xHKokXW2RVtDeCSRlOnqRL1U4Ufn5SAAtwqdbNYesr3nZc5egIImOJqAkaRxZWIlQxrmQtnicIfzYUiqqfa09Kk0+UOr+WR79Bmcf6+42wj+ToL1QTTDBdtTy2/MkipWb3K7Ah0HCFkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w4euLhwA; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33bb090aa78so3819137a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760974650; x=1761579450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=An/szO/oyH3jWEETz4FjiP4MsyHyMfmUEnCotuUe/9s=;
        b=w4euLhwA6VURPhLN5/9ZDgcbPBFUP/Uo/bNr3L84dwkiV9zOPQIXTfBWhgt84fXFQB
         uBEbeTdS4mnyucbAYkLdxj7r9URbTlA74QelQRVeB4YUzkjbvGW3xETWpjYywcu2Ps4n
         KUO5NT5UtptrzjN4bf6cKwA0DURGe8GlY5wulGkBTrHCjLNc0zsdmVgobDDT+EyOLSP9
         B4S6/O5J6qE7yaxML+FKhyi4/GFKL3HnQsg0M8yQBCZ9Xy/PJ4cXKSmqU4qRSQBxKoRD
         qIS5pCVl+QEmT0O0GJBoLsU3ZUE/ghxUoFmcZ66VXnY/Wl3i5+d4CmQmeWE5Og5IJV6U
         Z5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760974650; x=1761579450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=An/szO/oyH3jWEETz4FjiP4MsyHyMfmUEnCotuUe/9s=;
        b=X1VBymj1aPYR9HAAql1KYeWX+fGfCC8IWaoJUQyQN9DYsHWWAZKRouWVBw7Dv5Ge5E
         AHyd+LqwKBUbGqloLOjzelwmv2jpfQJ/WMVUAhZHkIWTh189qHighHSi7inXP8xVddmt
         J3FJXJqHng+tbh/viI940DJeDvT8nKsDJOKt2vlIonVS3/FpUJDyBiMjBqlpsM6PAyCM
         qx3Wj7U5gbuZ3Cd1LqMmS5IrIkP2CcX1sniCbHxqgKns24sKOgq1SetXt1irWFUY+vMe
         t5lTs5XMeGo+snj/94UbouzOKmpDclxJG+7J0TwtMkboUocg5Sn+2yQgrqgF8OafIDPD
         HSpA==
X-Forwarded-Encrypted: i=1; AJvYcCU12X3jcJUafPQv6bdkAXtf/mCAJxvZVDj2OdESAIVTfZH7CVHsvjoF9iD7GYF+GQ0IWg8J+EeC5U7Q8ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoP+M1+btW7TWoUop2BPN5YXc2dhMXbVcJKQI9vIQqYKrD591x
	4mkTuXIXI2btLlrm8sKukqjnTwk3rASkujM+TMzB6CJgcdBGwX5D5W7fLidZstnMbcQ=
X-Gm-Gg: ASbGncuUHHbwNDYow26rafcZomgtrwt26X86dcY6VN75P6P0bQI/K/78Ua49rKYS+oP
	wKey7d7M1WhMT21K//bc8e9IHvWgtkxF/+P+x4kQ7KO3DIDAeWR1BtOjLMlSLcLOVpzZ/krQbc+
	UO62MfInx694znU40JVTz8nS0AoL13ywpHK0jdg/fQneYGtaabCNtUgbtTThySlH1Q1WB1GXxAl
	I/t/9v1Di5ddVsWTRtsoNzTVMWynhBlM1SPNFhuy/rvsNvIWCrweaQzNTyabqr7M22QU8OrEdNA
	q3WgSfihdfeQ6b8sEk3z+KcQehncQlf5V6gGRHkdvQleoYvsf/xrbMU/jehj/dO9Frmyo7jmoMy
	I2nWhxOLBg/q9bS+5JB5YqHdztYNXnyFaRfaqO+tn2kOe8l3kPaZ0Bs+eS7LD11xNGePo571SaO
	V13o9LsOB0knngGQ==
X-Google-Smtp-Source: AGHT+IEmsmD6amTLvHHE+2cwS/e0HUauPuXtYyoBUNl10cvdG4E4NSTe+f3ScOSD6PoiCIK82vESEA==
X-Received: by 2002:a17:90a:d44f:b0:32e:96b1:fb70 with SMTP id 98e67ed59e1d1-33bcf880809mr18130535a91.12.1760974650080;
        Mon, 20 Oct 2025 08:37:30 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2360:6c8a:189d:ae5a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33ba93cbb7asm6652052a91.1.2025.10.20.08.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:37:29 -0700 (PDT)
Date: Mon, 20 Oct 2025 09:37:26 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] remoteproc: imx_rproc: Enable PM runtime support
 unconditionally
Message-ID: <aPZXNlY1MK4--Q_g@p14s>
References: <20251015-imx-rproc-c3_1-v3-0-b4baa247358d@nxp.com>
 <20251015-imx-rproc-c3_1-v3-3-b4baa247358d@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015-imx-rproc-c3_1-v3-3-b4baa247358d@nxp.com>

On Wed, Oct 15, 2025 at 09:52:57PM +0800, Peng Fan wrote:
> PM runtime support is safe and applicable across all i.MX platforms, not
> just those using the SCU API. Remove the conditional check and enable PM
> runtime unconditionally to simplify the code and ensure consistent power
> management behavior.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 820b0cd5adbb17ce5665e7ec2786bca23f1a67ea..25f5cb4d414eabed7a166eb2a8ae5e20b6b4f667 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -1119,12 +1119,10 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  			return dev_err_probe(dev, ret, "register restart handler failure\n");
>  	}
>  
> -	if (dcfg->method == IMX_RPROC_SCU_API) {
> -		pm_runtime_enable(dev);
> -		ret = pm_runtime_resume_and_get(dev);
> -		if (ret)
> -			return dev_err_probe(dev, ret, "pm_runtime get failed\n");
> -	}
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "pm_runtime get failed\n");
>  
>  	ret = devm_rproc_add(dev, rproc);
>  	if (ret) {
> @@ -1135,10 +1133,8 @@ static int imx_rproc_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_put_pm:
> -	if (dcfg->method == IMX_RPROC_SCU_API) {
> -		pm_runtime_disable(dev);
> -		pm_runtime_put_noidle(dev);
> -	}
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
>  
>  	return ret;
>  }
> @@ -1148,10 +1144,8 @@ static void imx_rproc_remove(struct platform_device *pdev)
>  	struct rproc *rproc = platform_get_drvdata(pdev);
>  	struct imx_rproc *priv = rproc->priv;
>  
> -	if (priv->dcfg->method == IMX_RPROC_SCU_API) {
> -		pm_runtime_disable(priv->dev);
> -		pm_runtime_put_noidle(priv->dev);
> -	}
> +	pm_runtime_disable(priv->dev);
> +	pm_runtime_put_noidle(priv->dev);
>  }

Daniel - what is your take on this one?

>  
>  static const struct imx_rproc_plat_ops imx_rproc_ops_arm_smc = {
> 
> -- 
> 2.37.1
> 

