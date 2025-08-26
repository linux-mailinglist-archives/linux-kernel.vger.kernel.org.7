Return-Path: <linux-kernel+bounces-787176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14911B3727F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D701C366CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9FF2F28EC;
	Tue, 26 Aug 2025 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WkFBPLsv"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A92D47EB
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234112; cv=none; b=XfDp1xKzJp6P8Aledgmm6ODLWRVHCxDObLMHT8D9/++L0GlZr+2CVwGrZUqFG+WRRBUZq2gD9YhDbplE4r5IRpLML9UbqmG5e3W7ErjIdb6scPIni9D22RmxcbFtDL93BeyYFtXkHGHAJXmhNmKLXCkgtLkgFdl946U1Jt8Qcp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234112; c=relaxed/simple;
	bh=shZVyhzhgMSVftGjjDW5YZz+fQPrA9ORLISgrRcpfz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQVBYYqAonWAWMp4XXfTjqiANCSHeqSn63XF1Im8/fFpgaaU6oNSWa1M7JxYV1vTUGtNpQ+xM6AUv2tE4zW3N6dyODjpadj9jGwksvTpMGXMX/CSzXR5j61NU4fgXlwkw7WacXVonUiAmKuemDSsM6i9+nfSFYX+zrHfRtvYkqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WkFBPLsv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2eb6ce24so4778730b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756234109; x=1756838909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FMvEjRZ7peseJNDS+e9oLCtx0ZTQPb3Js94QMS50KeM=;
        b=WkFBPLsvGk2xGMiBEaQijvEpUq+ZnBmkoHOf3ArpB3C2F5MaSelCg//HGUJ1nrDnXo
         8/AxSCnU7Tctbk1UHoMKoYA6v4fRgHlTjwbGmX4GTqD0quSH4DlMi36JQyQxiL9WrjkO
         rZiA0NWgw+GGafokzDrjMh6AVSuDNvkpMdy5jh57Jl0It9sXZwH5i/BR9nYn8xt2f1fW
         686yX6XizW+YThZD7LggG+rZEgYnJp90Vkcupycnz0ZruGnk8VeHVBG0lGgSyJM08LVo
         547gZfovV7DrM38mYEaxaDHC1F5jEuOUUS2lHl1uqB6eO37E54uK9FHKCeNaXCKICWVx
         39AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756234109; x=1756838909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMvEjRZ7peseJNDS+e9oLCtx0ZTQPb3Js94QMS50KeM=;
        b=kQjnmh9RruluSAGehX/NjHlTchh+Hdv1kZl9DhYlLN/6mK2c7DILMwANNvh8N2oBOc
         JkPu2JwyLCtVDcsMNmJGjiMjZoRl3XdJRgI8rXISFO+0/e8LfMn0cjtAvvUl45gwmknp
         KS2LFScBxC/OmGdoVpOVDoBf9vT7zZJV+LNko39kODokIoxrMxmU1bG/LLjzINkuKWm6
         GxV8G/w/cuh7RgvbHZbJXkXuK9LfIeeVCvMsDe4nJAmHy1ngti68Q1L/MsS2/dKSpEjk
         QX/tZRgi/7e2+3P2wscrMGzy9hoXtdYH47oClB0yxubozcBGW255cShbiVz8CV3v4OoN
         DjYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdU2gW0TEWQhZ18QVTb87YGAxOu6sPdF+njh3RKZAYTOc5balEtYbUlSpXuMiIQK9SpDUsJVkddFvLviU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73nm2fLNhhKCITCE941yhdy2z9+NAi69RrEffVccXfkyBlMrh
	HgEp854i5ORoZfQqHIwDPQ8IPigLnw9T1NKz6keP0pZTT7GSNdFznojJILUMhfhxPtY=
X-Gm-Gg: ASbGnctiqiGoxgu1Hc7R//i8+SN4uuUk4Q3r6kr2yBtgph8wpPil5Hc8JOAXS98EsK1
	ZnExsQ0gDA37BXyZnUdlyZ4PQy6VLh9Wom6Bfg2YreV2N77XFdPleeeGG+3foWSLLJxnS7HbzOI
	TgNLbPFSo/q1aXXaDGWqo0VfTGDnsWTY9bdeSA6FqtRfBfDyTeVLtZGo8Vh7lY8I8TJPYrPhaso
	PHHYrHLhboQWo2bgoJ0jGE2EnUVKjjCje66JifSTlO3/5TYNRr8Cma+PNvzIbqr5WekEXyTgC5Y
	Rbl4pPcvJmtFZjbBw6/nq2J+JebwXgP3o9s21JpStgMVPW7Rft+ZjiydDNLzhFIwtM/3dx5uMh2
	zsrMOSeiUELaw0/b1yI4TjW9B3LcbJ8F9tiZjjbuZhgCoC7KL1e/g0gB/nJRhiP/9zJdhSoZIXX
	bsgUawYbhVAsT1iyb+08D1Yso=
X-Google-Smtp-Source: AGHT+IHRcwQYxxPzzewXJmk7FtsIE1Bi9ofitDeay5FZuyieQ35UAnL2aLjN4DnF12wtcQC2EhI7/w==
X-Received: by 2002:a17:902:db0c:b0:240:887c:7b95 with SMTP id d9443c01a7336-2462edec14emr215403435ad.5.1756234109238;
        Tue, 26 Aug 2025 11:48:29 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5a7:9483:185f:8034])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466c13e13fsm101233265ad.139.2025.08.26.11.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:48:28 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:48:26 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Hari Nagalla <hnagalla@ti.com>,
	Beleswar Padhi <b-padhi@ti.com>, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] remoteproc: da8xx: Use devm action to release
 reserved memory
Message-ID: <aK4BepPvXW6u7Eui@p14s>
References: <20250814135532.638040-1-afd@ti.com>
 <20250814135532.638040-2-afd@ti.com>
 <aKyXjH-3lnCYM2rG@p14s>
 <d54e1cb6-388d-4e0e-a3a0-387ed87082ce@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d54e1cb6-388d-4e0e-a3a0-387ed87082ce@ti.com>

On Mon, Aug 25, 2025 at 01:29:26PM -0500, Andrew Davis wrote:
> On 8/25/25 12:04 PM, Mathieu Poirier wrote:
> > On Thu, Aug 14, 2025 at 08:55:31AM -0500, Andrew Davis wrote:
> > > This helps prevent mistakes like freeing out of order in cleanup functions
> > > and forgetting to free on error paths.
> > > 
> > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > ---
> > >   drivers/remoteproc/da8xx_remoteproc.c | 30 +++++++++++++--------------
> > >   1 file changed, 14 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> > > index 47df21bea5254..58b4f05283d92 100644
> > > --- a/drivers/remoteproc/da8xx_remoteproc.c
> > > +++ b/drivers/remoteproc/da8xx_remoteproc.c
> > > @@ -233,6 +233,13 @@ static int da8xx_rproc_get_internal_memories(struct platform_device *pdev,
> > >   	return 0;
> > >   }
> > > +static void da8xx_rproc_mem_release(void *data)
> > > +{
> > > +	struct device *dev = data;
> > > +
> > 
> > The check for dev->of_node from "free_mem" is missing.  I can add it if you
> > agree.
> > 
> 
> It should not be needed, this devm_action callback is added inside a if(dev->of_node)
> block below, so this will only be called iff dev->of_node is not null.

I agree with your assessment.  This set has been applied, along with the other
two with similar aim.  

> 
> Andrew
> 
> > > +	of_reserved_mem_device_release(dev);
> > > +}
> > > +
> > >   static int da8xx_rproc_probe(struct platform_device *pdev)
> > >   {
> > >   	struct device *dev = &pdev->dev;
> > > @@ -274,14 +281,13 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
> > >   		ret = of_reserved_mem_device_init(dev);
> > >   		if (ret)
> > >   			return dev_err_probe(dev, ret, "device does not have specific CMA pool\n");
> > > +		devm_add_action_or_reset(&pdev->dev, da8xx_rproc_mem_release, &pdev->dev);
> > >   	}
> > >   	rproc = devm_rproc_alloc(dev, "dsp", &da8xx_rproc_ops, da8xx_fw_name,
> > >   				 sizeof(*drproc));
> > > -	if (!rproc) {
> > > -		ret = -ENOMEM;
> > > -		goto free_mem;
> > > -	}
> > > +	if (!rproc)
> > > +		return -ENOMEM;
> > >   	/* error recovery is not supported at present */
> > >   	rproc->recovery_disabled = true;
> > > @@ -294,7 +300,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
> > >   	ret = da8xx_rproc_get_internal_memories(pdev, drproc);
> > >   	if (ret)
> > > -		goto free_mem;
> > > +		return ret;
> > >   	platform_set_drvdata(pdev, rproc);
> > > @@ -304,7 +310,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
> > >   					rproc);
> > >   	if (ret) {
> > >   		dev_err(dev, "devm_request_threaded_irq error: %d\n", ret);
> > > -		goto free_mem;
> > > +		return ret;
> > >   	}
> > >   	/*
> > > @@ -314,7 +320,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
> > >   	 */
> > >   	ret = reset_control_assert(dsp_reset);
> > >   	if (ret)
> > > -		goto free_mem;
> > > +		return ret;
> > >   	drproc->chipsig = chipsig;
> > >   	drproc->bootreg = bootreg;
> > > @@ -325,22 +331,16 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
> > >   	ret = rproc_add(rproc);
> > >   	if (ret) {
> > >   		dev_err(dev, "rproc_add failed: %d\n", ret);
> > > -		goto free_mem;
> > > +		return ret;
> > >   	}
> > >   	return 0;
> > > -
> > > -free_mem:
> > > -	if (dev->of_node)
> > > -		of_reserved_mem_device_release(dev);
> > > -	return ret;
> > >   }
> > >   static void da8xx_rproc_remove(struct platform_device *pdev)
> > >   {
> > >   	struct rproc *rproc = platform_get_drvdata(pdev);
> > >   	struct da8xx_rproc *drproc = rproc->priv;
> > > -	struct device *dev = &pdev->dev;
> > >   	/*
> > >   	 * The devm subsystem might end up releasing things before
> > > @@ -350,8 +350,6 @@ static void da8xx_rproc_remove(struct platform_device *pdev)
> > >   	disable_irq(drproc->irq);
> > >   	rproc_del(rproc);
> > > -	if (dev->of_node)
> > > -		of_reserved_mem_device_release(dev);
> > >   }
> > >   static const struct of_device_id davinci_rproc_of_match[] __maybe_unused = {
> > > -- 
> > > 2.39.2
> > > 
> 

