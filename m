Return-Path: <linux-kernel+bounces-785252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE65B34828
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD8C5E5C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891EF155C97;
	Mon, 25 Aug 2025 17:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y38Tenu3"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507BF1AAE28
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141311; cv=none; b=SsbgPZVHTQkg2FhPL0qFCKzNbEAy20VD93xGZLKW4RNfLSpMC11ufrPQL8wkyHkq9Z/TmuTAbx08FCjR9HVcYXEb8urMoVTpCWud/qwJk9PYR+P9B3C7KA9SRTgcsiPCXBsiDL+DByy8UTTwhbIbC+P6Ei5aVG6SsvwZHxh1bNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141311; c=relaxed/simple;
	bh=JbjaUCNNq59pUE+ugocXnVw1t4DerBdPv3Lw3ndbspo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGslWXRqDGPneQKmezGKg+DyWMJIbWKVEDbui1c3Z9Y+kyIqXja1X7DRQGyb2nxLM7y/d+te1eEOmkotW7sCGTgYR4O8zOUewCtKBr7OS6VWNSJfB4KLgGicqc7epWLJ2S1BMkulTb8utopuc3Gx2EL5bGLbA2okpCHLirck/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y38Tenu3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b474e8d6d01so3022412a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756141309; x=1756746109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ak9l7Fg6l2LvYXRcTPen8iTILFfM1AH3OjnsIesU9Y=;
        b=y38Tenu3MfLAuUPkGKFXnrPQizsR3bfefu1w3R2+1q1d7vF2zH44jeR2ryhRNNoxcz
         MR/5UilkcdQJ/6y/Qn+XknyIN+iKw9+BZYVBPKKwMI888SFlyxFiepazbHvR0wW+/Yun
         +NPd8nCXf9Isr3m6GaoOhLfySM+52kA3xaYnp31oP4JrUUJD9WEUuSn5/OBNAOdZ7QFG
         dPfS9IbKjgJj/nbA+eF8iJuSyCZwhAwEC3QdUd44vNdpGqxqbf9qMIMI2bjARTdtt6Cj
         ej6ewAjeLMOiKMc2yCSimZniwnVV5AbXu6dhA4opByKsyXgZWNqmwrdeU1ge1rgvgZLt
         /BSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756141309; x=1756746109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ak9l7Fg6l2LvYXRcTPen8iTILFfM1AH3OjnsIesU9Y=;
        b=gRDlAhEt82TSSRxB+PelmF+DJH0MlRg/qu7otb5bt+0/sefbbK4m9OpTCb7eOlouZZ
         h9VX2RhWTihU7YvGT+aJR+PKmAf43M3AQtOL9U+DtW+w57++8l2bKD/H6tIDMoh5fkMs
         v/WwmJq2h2Q1t7WgMc7kEW/PvFrpGvBUd+pVwZJISB1G/f7uEQxBGMudyhNjNxO9i76t
         ZOnGIs5lpap/PD5SdFvTy0458G3RWElga7jM2mRWdKoHv3lUhdS89t9PTDvwqYDgwsYK
         g2eYboT98wVWIlTXFpD9QqkZI2l7DYclhvY2fR82jmhET788/GS99vgEVnzkluRwdyhO
         LXBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQj1gfQuXHtX5HvWk2ikI1xpW4aEu/gn3/41e+CJg50Wr51M7M2fpqV7GWofIiTZElXFl6xTKtbJDMoK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ2l4voVWGpAaT7Bj7C+EmyfIGd3Bsn5/PzQjVqgOX5NCnCNnp
	iK779Jps8Lk5RYKx7f0VUdho/SCWEBVCdoR/l2uBe+u191PWTuXFt+w1VJvblfKF1rI=
X-Gm-Gg: ASbGncvBAGnXqc3tRkdnQ6Ou7VaeZNIhPIeLDGfOioDUSQ2+AxuTv4CRrRxsMfDzNlv
	h20tpUgGoDfOWvrR7h/xmZmvp/ayhurmV9L30fxOkpmef8Q2esjvJDim5mRYp1h1apoF+W9EY2e
	KSnU9IvjwnuNhcdEu/tIexE98abpWJy0nee2NFcAavgi01qa1kjyPdFvjexXugKuw3bAsgKqnpW
	6sngh+QIBo+fo7xlgRUyrwVvF9spRZiER25Qarh/smhprOpvTvKu3/pcCxNj/D7S6H03j8wwkrv
	iPaEnM3VfU1cDMq0QnWF7NNR5YzcXfUxabHTD9zJ+JQRG+zAohELVmF1l0dNyGamiW8ScbPxSmV
	OI/F/qRLYI+h3ExI3iVCclhdJqSe4GkZX7lOvgwHuHKZvI5ggF3wK0QZlVjZ7pfD9LLXX2BvLqx
	re/LWhuHYLYLBwFYmIqEg64whW
X-Google-Smtp-Source: AGHT+IE1SxCcVPjQEknO8iyQnbOBTN5XYqsMYCNx0q4628NZu3zWYavkSuR+TiKqhP2rTdODkzX2FA==
X-Received: by 2002:a17:902:ce01:b0:245:fd33:5b16 with SMTP id d9443c01a7336-2462ef1f2f6mr178350195ad.36.1756141309478;
        Mon, 25 Aug 2025 10:01:49 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:f3a7:cbcf:8fdd:91a8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466878152esm73702815ad.12.2025.08.25.10.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:01:48 -0700 (PDT)
Date: Mon, 25 Aug 2025 11:01:46 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Hari Nagalla <hnagalla@ti.com>,
	Beleswar Padhi <b-padhi@ti.com>, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] remoteproc: da8xx: Use devm_rproc_alloc() helper
Message-ID: <aKyW-oMAZR791GF2@p14s>
References: <20250814135532.638040-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814135532.638040-1-afd@ti.com>

On Thu, Aug 14, 2025 at 08:55:30AM -0500, Andrew Davis wrote:
> Use the device lifecycle managed allocation function. This helps prevent
> mistakes like freeing out of order in cleanup functions and forgetting to
> free on error paths.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>

Applied.
 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index 93031f0867d10..47df21bea5254 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -276,8 +276,8 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  			return dev_err_probe(dev, ret, "device does not have specific CMA pool\n");
>  	}
>  
> -	rproc = rproc_alloc(dev, "dsp", &da8xx_rproc_ops, da8xx_fw_name,
> -		sizeof(*drproc));
> +	rproc = devm_rproc_alloc(dev, "dsp", &da8xx_rproc_ops, da8xx_fw_name,
> +				 sizeof(*drproc));
>  	if (!rproc) {
>  		ret = -ENOMEM;
>  		goto free_mem;
> @@ -294,7 +294,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  
>  	ret = da8xx_rproc_get_internal_memories(pdev, drproc);
>  	if (ret)
> -		goto free_rproc;
> +		goto free_mem;
>  
>  	platform_set_drvdata(pdev, rproc);
>  
> @@ -304,7 +304,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  					rproc);
>  	if (ret) {
>  		dev_err(dev, "devm_request_threaded_irq error: %d\n", ret);
> -		goto free_rproc;
> +		goto free_mem;
>  	}
>  
>  	/*
> @@ -314,7 +314,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  	 */
>  	ret = reset_control_assert(dsp_reset);
>  	if (ret)
> -		goto free_rproc;
> +		goto free_mem;
>  
>  	drproc->chipsig = chipsig;
>  	drproc->bootreg = bootreg;
> @@ -325,13 +325,11 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  	ret = rproc_add(rproc);
>  	if (ret) {
>  		dev_err(dev, "rproc_add failed: %d\n", ret);
> -		goto free_rproc;
> +		goto free_mem;
>  	}
>  
>  	return 0;
>  
> -free_rproc:
> -	rproc_free(rproc);
>  free_mem:
>  	if (dev->of_node)
>  		of_reserved_mem_device_release(dev);
> @@ -352,7 +350,6 @@ static void da8xx_rproc_remove(struct platform_device *pdev)
>  	disable_irq(drproc->irq);
>  
>  	rproc_del(rproc);
> -	rproc_free(rproc);
>  	if (dev->of_node)
>  		of_reserved_mem_device_release(dev);
>  }
> -- 
> 2.39.2
> 

