Return-Path: <linux-kernel+bounces-751391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF76B16914
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29C237AFF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB30023370F;
	Wed, 30 Jul 2025 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cdoZlXYw"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5F21CC71
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914802; cv=none; b=N9Oiabt7fZslX4CiXSNjoxbRhxcTB7rly1Jw7e8/nAhdOZulMySOnbDtFApQBpkPqVLIZIhEfoK6OlisZXeNbisvbeRsNiFyBBzb+FynBjrA2f98uUcDN43F/sgmi0uXtEAuNboIwr4rAQJiM3hxoLppekiq2r3dIZRJsfERlFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914802; c=relaxed/simple;
	bh=CBP7jso/Xp5ZMfEj8/eklaWto5oiOkPvduOFttctQ1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q8OLLpBFeT/lqgIvc6emNTuZZs1Zp5eAXGTnl8M3PRah5ZPEIfetLkHLT6HR0jIGLkvZ5UtZ1UfIFTF4TG5cAk5ey6QylMAhsifGs3hRfZ3HFj/BPAU1hM6IuUH10AHmlvvJYa0JFd5qzg/rCvYY1oTCxJ15r3940Fc4gu+blwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cdoZlXYw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2401b855980so2959035ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753914799; x=1754519599; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps72b4v6Wc6/nkbPn38PGEcuWdxubn4Q9XVtS2h3BXc=;
        b=cdoZlXYwHsafghJfUg9vgvE7zbEXDUtKyzPaKCtHy06F/1sYbEpjUXczjbJKPBgnQ5
         +b2vkNVFUUmtc8f3OaOQ1DUZ3e+QmnKOikNKEH7bIHCVUcPLXEe5Cbg+aD4lFB3nX5FF
         JyliPeyFKr+lRMQAzPb0hR9MpB7tJtNm+MYmBvYqJyph9OjHjQN8ugeNfEXdP8sAZtjX
         pSRPSFurk4Lu8Emk5sgzyFIWkWIbFN8sSZ5WyIby15WriDMAqGiLfb5//J6OwS2j5TkE
         p5pcVmx4IPmnz5+dC5C83CQWvez9qNhEma/pdgyuKiqJYcibzIPGof7ov7QLSmxOVCYd
         PjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753914799; x=1754519599;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps72b4v6Wc6/nkbPn38PGEcuWdxubn4Q9XVtS2h3BXc=;
        b=IiWsWAycQiYExlL1I2B7DeowDQEZ0Y/qsSNN7cK8jYJg5U5rFggOYWE1e03QVXCQog
         9V0sSIWeRwE8ff0+gvx/gd9PlRD8BSVVfCAF2pKbvMZR9Mo9GaS09FhIquP9//kGxAy+
         u/vUtO5WEd7bi8naC6nuLOFxSGBsuGjJr1om1IgSJVSIHmoUVST9N3H8mcgSnOZYbkBh
         FllleWU2+IEGmJcg/Ill0ep4R/igP8oF923CrgB/ubVMr6aayERUjLz2AjWHf+RF+ltd
         6WqVfhR+OZAhVreJ+XRvMtCg5DiKG8FoL6IvISMmNygzhBUhsJOYrtfDALbFnE0ZN5KW
         yUAw==
X-Forwarded-Encrypted: i=1; AJvYcCWJR/1c4U7MwTcCI+JHqrC+Gwfh5Gp4vLunXVf4zbVCAHj9p8qZ1yIgiGg67zr/bfd+pCYvkyiAIzQWu7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxri3bKK1eyRgIMcEmy8ZAm/V5XpX3tkKkIXMJ+OGHiMopuxh/
	QeiLeDhH+BK5y+s9VirPj3JQd2SjSc6/8lop53sBi8pWZ9dwKuJU2PziV+VPNcd/+fk=
X-Gm-Gg: ASbGncuqX0PFyBChq9w1EAsVQ/x31CPNLsNe9OTqH79u+tJYH0k+dyeNSut0cQT7Rlz
	DIsUwDFgtM3aM32Y4Fxa6ZRHzRYSMFTQMhIdZ4XkNgzsx5XbsoLD9IvmNnGcuxp0HtSf9+7RLrw
	w6H5iVai7ypp3RC+jZhrGSpZqRFGJgNVZx1WUHRTrs3LKksryWvUDp2d8Qq/unYvipSlf+NeYjX
	mB81s9uYKBfiVKOZLoemBop/ALQkFfcbiKinP/OMtHS7UiaKcTCUeAFPCFw4Bk+n5f40z7LFOEx
	kTRfdJaXPYyaPHMRU+K7w14Vtsuf8giWG87E7qDLO7XyTr2mZ20vfvLcHcXsvfCrGfCEa12hoc2
	qTI3zpa9nRMIWV5w9sjWa
X-Google-Smtp-Source: AGHT+IEeqos7CIku+zP9/irmW0u5wzQb5lU9PgyKItg6ERfePipoY9vyNWFmppJ8TSOaNVwTJTDdkA==
X-Received: by 2002:a17:903:41c4:b0:234:cc7c:d2e2 with SMTP id d9443c01a7336-24096a47498mr85346865ad.1.1753914799167;
        Wed, 30 Jul 2025 15:33:19 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a814sm1291845ad.117.2025.07.30.15.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 15:33:18 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Bin Liu <b-liu@ti.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
 stable@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH 4/5] usb: musb: omap2430: fix device leak at unbind
In-Reply-To: <20250724091910.21092-5-johan@kernel.org>
References: <20250724091910.21092-1-johan@kernel.org>
 <20250724091910.21092-5-johan@kernel.org>
Date: Wed, 30 Jul 2025 15:33:18 -0700
Message-ID: <7hqzxxb975.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johan Hovold <johan@kernel.org> writes:

> Make sure to drop the reference to the control device taken by
> of_find_device_by_node() during probe when the driver is unbound.
>
> Fixes: 8934d3e4d0e7 ("usb: musb: omap2430: Don't use omap_get_control_dev()")
> Cc: stable@vger.kernel.org	# 3.13
> Cc: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/usb/musb/omap2430.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 2970967a4fd2..36f756f9b7f6 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -400,7 +400,7 @@ static int omap2430_probe(struct platform_device *pdev)
>  	ret = platform_device_add_resources(musb, pdev->resource, pdev->num_resources);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to add resources\n");
> -		goto err2;
> +		goto err_put_control_otghs;
>  	}
>  
>  	if (populate_irqs) {
> @@ -413,7 +413,7 @@ static int omap2430_probe(struct platform_device *pdev)
>  		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  		if (!res) {
>  			ret = -EINVAL;
> -			goto err2;
> +			goto err_put_control_otghs;
>  		}
>  
>  		musb_res[i].start = res->start;
> @@ -441,14 +441,14 @@ static int omap2430_probe(struct platform_device *pdev)
>  		ret = platform_device_add_resources(musb, musb_res, i);
>  		if (ret) {
>  			dev_err(&pdev->dev, "failed to add IRQ resources\n");
> -			goto err2;
> +			goto err_put_control_otghs;
>  		}
>  	}
>  
>  	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to add platform_data\n");
> -		goto err2;
> +		goto err_put_control_otghs;
>  	}
>  
>  	pm_runtime_enable(glue->dev);
> @@ -463,7 +463,9 @@ static int omap2430_probe(struct platform_device *pdev)
>  
>  err3:
>  	pm_runtime_disable(glue->dev);
> -
> +err_put_control_otghs:
> +	if (!IS_ERR(glue->control_otghs))
> +		put_device(glue->control_otghs);
>  err2:
>  	platform_device_put(musb);
>  
> @@ -477,6 +479,8 @@ static void omap2430_remove(struct platform_device *pdev)
>  
>  	platform_device_unregister(glue->musb);
>  	pm_runtime_disable(glue->dev);
> +	if (!IS_ERR(glue->control_otghs))
> +		put_device(glue->control_otghs);
>  }
>  
>  #ifdef CONFIG_PM
> -- 
> 2.49.1

