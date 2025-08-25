Return-Path: <linux-kernel+bounces-785253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 192DEB3482D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8C91A872B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A24B2797A3;
	Mon, 25 Aug 2025 17:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ar4qc99A"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937A1D5CC9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141457; cv=none; b=n70eoKXrCrkaZ+QY8cLV2US/hW/oGcIgBoylDALUqimVAWDDOw9XCijpz9eaQw8UEJBIXdoqxigaPR+tjsqj7iaDs1VfuwyOdnstmMdOvSU0V/r+oQ1rxBsNvHc6O86KH1hqtLKknCuHNlKTjkj3/EAyqQcyKXYPRl85AX1q/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141457; c=relaxed/simple;
	bh=bjMd344q5N5pg4iTG/2tiNcHP5sFWJ/LN69d/Fwd570=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF2ahp/NG2ZKov9ZTI97nNX9qk4bjteDeO1lCfRkxdcZtJKGvESml9B70Ur6NojZrkV+k4OUL4hshf3SfcKRxIul0SnJAz/7vv+JvIIRdPT9JEC7JXrIM8acysiScnoHvf3ZY5KV2GXqWmP06BumkqGbNO4qRoPO/5l+3mxZAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ar4qc99A; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-771e15ce64eso915810b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756141455; x=1756746255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/9baOducWk07zRHRmC5T13Bf7TGkxoCIjk+kLvTMf9U=;
        b=ar4qc99AVdrQJQ7Fi47YNWkRQSNWtIYz4CWXwue/0hHtrA8T1XlqKXrXyUGt0NO3lD
         /N0snQv8bDfMIsgNB9gTRUvqZXdpZTKA/M41CN4ZLJ4NyCPAwca0oHaizFLZQt3waYKm
         SsYO7e6fUvcoFgIr6nVM5aoCpirS+VgmJCz/YfLja5uQBrnHP7SsfppkvbMiS/k2mfjq
         u3ouLwO9awovLqeexBH8AYeWseMWG9FzSjoGgbmLUVfUNBoo25ORdg+NUKZtjzt6kTkL
         hu+n3+/t8+X5ABmMmIc9exgIey8wJioUT3PryXLcCh52ynTs6QOsZYklcTxJ7MtKKkO5
         1BzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756141455; x=1756746255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9baOducWk07zRHRmC5T13Bf7TGkxoCIjk+kLvTMf9U=;
        b=AU77ZtRYXlCD6vKvCdyMGs3aSKz8XhTg1HUlgyCoPQ4yPAO31JPh86wwnZYeCcx3f8
         F+vtm512X/B8bEJjr8If0b1rIgpntZpdnLhgW0Pgfm4Gk3qxPbBRDUU6IZPOJCzQsVAF
         Yb7KJytr2hkb09NAT77sgzzMcbGE57bYGPEbqSt1df9/0rcA2jjiWwFe5HvnL/LoaIOn
         sszWuzdar1fX5hona1owisdHncuPUOT2wxXeVwIfpk+kVaM3VwptmFUnWIrqTz818SN8
         CKOB2liOMIcl3816U2EvPYdyBTcf2QLF/cMmJy/fS8WiPlGnwaiKY4mQuhco30E7F3Tn
         jLDA==
X-Forwarded-Encrypted: i=1; AJvYcCVQNdm0kP62bxLek8+ppaXVQQPYvAFClGLr99da6u+d6VFecHiSZ+DC4PXYxSm5WwB9PHH9Eut67F+n07M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8TJ32xtGzt9XiWuUuT/AvyxSC4WyFTYhm/LdZTQXHO66Ugswi
	p5H2mmMAr6fi6cSeaHwzcu7Gg6V5xNjSWX/cIoFx1affw1Tp8cHeh+bDI5B8QOU5bDg=
X-Gm-Gg: ASbGncuTEoWnxiTiR6e+s15FuH4B7C7pfM0c0PmZe+I62u/Kt0tfSRGJiRhS9s8/plH
	+qNLhlA/U60lBdBGg+pfhzFcz/r0iFeqTgB57U37XIQAPCn+NSwlR9RqqX54l77FjaoVRST81Bp
	99E+MLAAGmOkJEoO2GqljlHCbmH4xWWykMZVN1+MXdeYifacaYqAPmHk6veuZe9Zsz4LSBQ8/4F
	VS4LJELuxssMhwg2CabhRGgF/7zTqCN0sk/VbBUOk2hF6p0Ey3Q9b23Gmx3vOnRhkwgLjbKhQ+j
	WVVlqXx5i4JhMvSb8hP/v3iX0zZhrgv+2i2GIH9RLSFiCIfpfiDf0AFfI7KRM31X5XLwKqlN3IK
	5Dshw5ifAlaKs3gsEV7TC27OvF8L15b7KpYNyJT65iqWx9j6VRutqDYMAn8tLT9rfELJgpbnhbu
	Ttx53ptPc1Iyq7ZwfXg6C/1Zyh
X-Google-Smtp-Source: AGHT+IGIjRD4vnI2qkQHnIDHuFVbnlSg4ZRwRIfz8qCZLAs2k7tIRdtAflzgUDlm/uVMUzjlSMhbow==
X-Received: by 2002:a05:6a00:1991:b0:770:3ef5:1caf with SMTP id d2e1a72fcca58-7703ef51d86mr12958397b3a.24.1756141455561;
        Mon, 25 Aug 2025 10:04:15 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:f3a7:cbcf:8fdd:91a8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7705647e03esm4881985b3a.59.2025.08.25.10.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:04:15 -0700 (PDT)
Date: Mon, 25 Aug 2025 11:04:12 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Hari Nagalla <hnagalla@ti.com>,
	Beleswar Padhi <b-padhi@ti.com>, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] remoteproc: da8xx: Use devm action to release
 reserved memory
Message-ID: <aKyXjH-3lnCYM2rG@p14s>
References: <20250814135532.638040-1-afd@ti.com>
 <20250814135532.638040-2-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814135532.638040-2-afd@ti.com>

On Thu, Aug 14, 2025 at 08:55:31AM -0500, Andrew Davis wrote:
> This helps prevent mistakes like freeing out of order in cleanup functions
> and forgetting to free on error paths.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 30 +++++++++++++--------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index 47df21bea5254..58b4f05283d92 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -233,6 +233,13 @@ static int da8xx_rproc_get_internal_memories(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static void da8xx_rproc_mem_release(void *data)
> +{
> +	struct device *dev = data;
> +

The check for dev->of_node from "free_mem" is missing.  I can add it if you
agree.

> +	of_reserved_mem_device_release(dev);
> +}
> +
>  static int da8xx_rproc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -274,14 +281,13 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  		ret = of_reserved_mem_device_init(dev);
>  		if (ret)
>  			return dev_err_probe(dev, ret, "device does not have specific CMA pool\n");
> +		devm_add_action_or_reset(&pdev->dev, da8xx_rproc_mem_release, &pdev->dev);
>  	}
>  
>  	rproc = devm_rproc_alloc(dev, "dsp", &da8xx_rproc_ops, da8xx_fw_name,
>  				 sizeof(*drproc));
> -	if (!rproc) {
> -		ret = -ENOMEM;
> -		goto free_mem;
> -	}
> +	if (!rproc)
> +		return -ENOMEM;
>  
>  	/* error recovery is not supported at present */
>  	rproc->recovery_disabled = true;
> @@ -294,7 +300,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  
>  	ret = da8xx_rproc_get_internal_memories(pdev, drproc);
>  	if (ret)
> -		goto free_mem;
> +		return ret;
>  
>  	platform_set_drvdata(pdev, rproc);
>  
> @@ -304,7 +310,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  					rproc);
>  	if (ret) {
>  		dev_err(dev, "devm_request_threaded_irq error: %d\n", ret);
> -		goto free_mem;
> +		return ret;
>  	}
>  
>  	/*
> @@ -314,7 +320,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  	 */
>  	ret = reset_control_assert(dsp_reset);
>  	if (ret)
> -		goto free_mem;
> +		return ret;
>  
>  	drproc->chipsig = chipsig;
>  	drproc->bootreg = bootreg;
> @@ -325,22 +331,16 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  	ret = rproc_add(rproc);
>  	if (ret) {
>  		dev_err(dev, "rproc_add failed: %d\n", ret);
> -		goto free_mem;
> +		return ret;
>  	}
>  
>  	return 0;
> -
> -free_mem:
> -	if (dev->of_node)
> -		of_reserved_mem_device_release(dev);
> -	return ret;
>  }
>  
>  static void da8xx_rproc_remove(struct platform_device *pdev)
>  {
>  	struct rproc *rproc = platform_get_drvdata(pdev);
>  	struct da8xx_rproc *drproc = rproc->priv;
> -	struct device *dev = &pdev->dev;
>  
>  	/*
>  	 * The devm subsystem might end up releasing things before
> @@ -350,8 +350,6 @@ static void da8xx_rproc_remove(struct platform_device *pdev)
>  	disable_irq(drproc->irq);
>  
>  	rproc_del(rproc);
> -	if (dev->of_node)
> -		of_reserved_mem_device_release(dev);
>  }
>  
>  static const struct of_device_id davinci_rproc_of_match[] __maybe_unused = {
> -- 
> 2.39.2
> 

