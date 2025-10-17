Return-Path: <linux-kernel+bounces-857270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3026BE65F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D2F24EE3E2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C6230C635;
	Fri, 17 Oct 2025 05:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UyTN1ptN"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD781F4165
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760677748; cv=none; b=WdXDtuQMo9kHaFCJEj6GVHqMrfk9148cQVS/Xc++I4WF/+ZGRij/em5W+nX76ANzDIIflj8klSH4+Fd5PJCAG0dexYNXjA4sLnSA6rRuf3lNRs/nT6vUv26DcBHLwiwboyEwwNIEQFSGeBnBiHHpFxeBDYSggFZZdfrkmLDmwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760677748; c=relaxed/simple;
	bh=hPhYcJBahqMqyJ9NZbktJ31yJvCBaD8L6HNgbzSSI04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs8cHJR/oTeqAnceYhynPDtjRc6M7t8W5FJaNHa3qg8A1QT3mlHmiL6I+oqnTV3G6tX50ZX+XqeEcdwy4/0OeVx+7V+gzQTsgUtXZTD87+Adx6YwaCZCFhlmx/alW2c/tHJKBwoFxpbWHAkQbUSE8bJsCtQexkD4oO74cBhsh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UyTN1ptN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-791c287c10dso1291673b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760677746; x=1761282546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ55DkM8tzaRgU5i+eke6Xg0gqLmGe9Gfxt+VQ9ObUk=;
        b=UyTN1ptNQBHEGDRixol6Fs1pv7IlrV/xCkY/JCDSSoo97tkTV7XlDwXE/mSJ/WC40h
         DrpG1fL+5V3oE4bpp1LU26SAURXJhrAxM4TFBvx0Q3D7f5P/4rmkMwQpQOqjkgRXZcd/
         3LRwq9lZ0OhmzBLzn82/jxJQi+mtQZVn3zEKSNdhA85m38O4AvdvQrr8/+PCb1NkEpt3
         6sUgFGi/+eXpHSZRm/fySRjkWe1f6++9i2y1/WWeSdhIeqt55imt5VMBjzo8fsREQDyM
         +Ee3/WLMrb2gQK0HH8+CnhRrMNnzasID3tHaNB1MgDUWXfP1fVe+pd7qRAm/N2GQje5H
         pEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760677746; x=1761282546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ55DkM8tzaRgU5i+eke6Xg0gqLmGe9Gfxt+VQ9ObUk=;
        b=mBltFxCq9744HJcjDElYE7RXeFE3nTcydv8Qi8wJT1UuGAK42tjF6AfaWs5cM/VVZ3
         eMBhx/qcyZ/Y3hUd5vqexpzOLxkqIciGr7FQUlVkrChUhy2oLBqBJnQteQnVPJcugrrR
         EvDtnSp6p5V++UQ53mTw7wp8IcgLNyzhIz2YJsFGI8NkPXQspFoiNoDgsDgWLxF+juJL
         I7QwFTeC+ynLo6eL6erDqnkaM7/kiPnvO+a7jeJaSnngAR7Ci3X+gnS/6Lg/ECg6kgi/
         S9GOgxmEONKQddHat4Gl9awo27dRYtJFwaa7z2L7PYqmSIt7L84ipOmTcerKTnbMzP3o
         kq5g==
X-Forwarded-Encrypted: i=1; AJvYcCVVB5RNcxJkafgHRVuqcqdk94jkfnIJnkhihzVdYh7b4nrMwYPyH9zvlYdQnfULqtX6mlLYP/1sRbl3VXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnEeZ/YH8RvqxdyTy12LeMMWc46p/gtB5d3wbqYRpWKLUa50X
	0UbxNCo4yyRd6QWs8XOd8Xjw/GWIMobVF9XJuE+yJnKnmNr/cIb25swvtD/+NAx9PTg=
X-Gm-Gg: ASbGncvHPySglchwx7BpNGU7ppnxIyhvIxT9YL3UHYBnsQVMvBW5n/e3/SuKpGdhNfb
	yks5z0oCUiU9mT3TNfr2S3RqsD4j/VtPuSvJ0zPxTUbF08jJWM2wbUA7XPsnfMDK6ITuefrb6zF
	Qd/URjD221UfcB/XybkQWUzmH29s4H17aTUMi8X4y2fsbjwPXvUrRfnxqXjGT44O6ecs1HDe/Cn
	fGaEPotq8ft1sVdPILAMKQj3fcEwYWYKeDhp2Jm+g9NpbNAzYNv4ZtkVopTU8/tgkpT6BvKt44w
	UIRo3WC1QA7Ul+hc4om2jd3DURMIe4fy+d5CCCE30I/2aejhgbjK9uzo72P6iqGcJ8X9hwV7dzg
	dwwoy/6o5gDKItN9oes6Gb/gyY+Oa4g1LynFMFf/4jbOuGIUbmRP8hI2Ue1Mw5ENHgsVTxTWKHn
	vA4A==
X-Google-Smtp-Source: AGHT+IGVLyzmj++RqMMVihtjmmGd1jHdy2DiGxYxK8sK9GSZnnLKdl9JAGdP0GHlJpy4pu/1751zZA==
X-Received: by 2002:a05:6a21:99a4:b0:334:a784:304a with SMTP id adf61e73a8af0-334a8609160mr3483247637.33.1760677745414;
        Thu, 16 Oct 2025 22:09:05 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e3f89sm23882072b3a.66.2025.10.16.22.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 22:09:04 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:39:02 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, E Shattow <e@freeshell.de>, Paul Walmsley <pjw@kernel.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/7] cpufreq: dt-platdev: Add JH7110S SOC to the
 allowlist
Message-ID: <jurnfpufll4twv2hfp2dv6qk6d3gr7gfmek5czigb5bcon636q@opb6hrdb424p>
References: <20251016080054.12484-1-hal.feng@starfivetech.com>
 <20251016080054.12484-2-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016080054.12484-2-hal.feng@starfivetech.com>

On 16-10-25, 16:00, Hal Feng wrote:
> Add the compatible strings for supporting the generic
> cpufreq driver on the StarFive JH7110S SoC.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index cd1816a12bb9..dc11b62399ad 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -87,6 +87,7 @@ static const struct of_device_id allowlist[] __initconst = {
>  	{ .compatible = "st-ericsson,u9540", },
>  
>  	{ .compatible = "starfive,jh7110", },
> +	{ .compatible = "starfive,jh7110s", },
>  
>  	{ .compatible = "ti,omap2", },
>  	{ .compatible = "ti,omap4", },

Applied. Thanks.

-- 
viresh

