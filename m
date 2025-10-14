Return-Path: <linux-kernel+bounces-852565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B57BD9554
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A016353272
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50FD313E19;
	Tue, 14 Oct 2025 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZg3VAbg"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020CC313559
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444840; cv=none; b=kQqP7DVDHCHoQKwwnLdG7md8bQgm0uminh6iWNUukaYO5DJYdclK2+KzYZnwjEG1hxCkH67QxXgvoWLd9NMu043tVXLC1h1BPZpvt3r9xapZeBG1Q+89lONXddqi85GVrYI7mbvGv0SGvnrBiKlT8UnQ1qDcIfRrMApmPlD0mzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444840; c=relaxed/simple;
	bh=UpiGm1rT9EBDp1/84eMBMTQZvXgS8tY9SKg2mGiKuq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/t089i/DAfP1/cgHa8T8DPEgnmGLdkDXSO/GC5ZgMX2Mmt85Bop4Dr/Jml0gBrXhyswaXawNQ5NDGvD1EXACxUGiHVnAX3Ouz/wL83OVK0hT+e9hwnSfI8MRU+PMfiIeds2BVRjuB9uGYkTQkD7jpV7hJ+1TEp6hfzQOS3Z6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZg3VAbg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e52279279so37638555e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760444836; x=1761049636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QjHopu1UwDxsV5IdNPvI1jrj2EChfALYrLzFCq9lMBc=;
        b=NZg3VAbgYfyuhhHWEl8X/2XvmJHHHRVPSgPCcXTIHGLuCpv/nfLkznKXKjUHy7sYCp
         +zb9IY6o+xvxizK0KHyyvv88aXXbQXdlWwl51Dw3G9h3+zNvgmUyGPrwGcsb94x2tg0k
         eQh2DQHWYpagg7TdYtBHFF+71BCf3p4MWHusQbbaIOi+KoSGrCUgPsk71+GtV1VFF9At
         J5t30adq0S54wUrl1GPFekg9ABQqP0+7+lrkjseLMggs3oHcJuKIXGlaW+sZNx8r9dQq
         5s8L0vt/i/MWt2PToWydqgmcmtHw1RqNn/wB0mxgugCiQSNdlMRUN1Flpz8nBWv6nA/y
         icBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444836; x=1761049636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjHopu1UwDxsV5IdNPvI1jrj2EChfALYrLzFCq9lMBc=;
        b=DhkFlrHOJfafMVC6wjOkf0rguy91Q8PkpUikTcn50fK97peI02I0jSjk2d9yQXnDbW
         X51R1adWUvAT0v3lb0v0rgYH7lpt9Ba3jyi2trvD4k9jFbe2WpMIGEVFF9gbFvYFJPf3
         E/L/sz1VJc1c3v7LAIDmsZ7wsNpLUUFMqXWWipi1PNbE2KNPAZGHNlkxCHv/ayvC4QHJ
         WjRoKNe2LnlneVufTSABBUso6SNFALnqWz6o1kuIj9N06oWN4X3H+Z6dIG4BeZ3d6q3o
         jDo/YZgsQEu36xvBuX66DiWV09TpnwJdF+xbIfO2CExAE8ayZaspKv9IGZj4vwuIFp5n
         /z+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmXe6l/1pNG2P/rwyd5Yme+3j/8LGYiwo1ZhNpIIPukFz37a4mP5z9mlvUjLAE4/JlhWqW2YBB/CmHC4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT90FSagJ87qS/wx37gAwu8Aew6h510QOzmOYubywtcJiGHXrl
	IkQeBbjBVI+LDCWq5InlXEXS/V4Vsp/wqc2xj7cqQmdxrSmS9wPjuPPrFdWGB2xDXQE=
X-Gm-Gg: ASbGncvOkMQhCWL0ubHCNNzd352kJRVuzNrWHOVLpB12UCLliivFJjRyMXXD7icS1b4
	Cflcbv9538YkFEnHh515OGf6Mb3J/mfZv3IdeBph1qCMWGeysBLJuh0YibyMQ1mlcBSmgo4GFzM
	q9dyqtMGIKG4eQIU+VVnCGKwIUUENlWKndAQjhZAXxsSxPa91sB68fFDnrAB3b3/n8R8JNGESwC
	ojLTjeanBSKRh3BYwvucevh9MQbM4AFrmBo0Q3Ny8xukYorrUVd9W9/b50ltY8TGq8QrWTrPXkw
	UeOzIUdVRJjLmKO5093ligVpl8yP80LE2Ha6uheQ6VrU8q2Y5xFP1miq04DO325o0nwfPQmAOC5
	ZYMSmIvY2t7rh7rSlIgLXdIQ8ywhkP4BDs076fKTAnf2K48uGY1SMFz7YHWQxCQ==
X-Google-Smtp-Source: AGHT+IGpLJmj5ZZeE5vtmTg4lu6fLIqoCQTKP25wq9imxhpp1Co0qw1M1pvst4NVF+ct3P1g5F4ilQ==
X-Received: by 2002:a05:600c:c116:b0:46e:3709:d88a with SMTP id 5b1f17b1804b1-46fa9b17e16mr141372525e9.33.1760444836001;
        Tue, 14 Oct 2025 05:27:16 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb4989601sm232872755e9.9.2025.10.14.05.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:27:15 -0700 (PDT)
Date: Tue, 14 Oct 2025 15:27:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Khalid Aziz <khalid@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Rakuram Eswaran <rakuram.e96@gmail.com>, chenhuacai@kernel.org,
	david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	lkp@intel.com, skhan@linuxfoundation.org, ulf.hansson@linaro.org,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in
 pxamci_probe()
Message-ID: <aO5BnwkNNyv_GOGS@stanley.mountain>
References: <xxtrhbv5qm2crtvc5ejpgu5caadsmms3rfulmosjwq7lumrko3@5mlcpk24hymm>
 <20251012183804.15171-1-rakuram.e96@gmail.com>
 <6j7ix5yof7qmrp6cgxhqver7yimvmgj7dujqu4l7cnzbpjksfd@5sp7am47gigw>
 <8afff048-4fe1-440a-9739-e5a5ea43d6eb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8afff048-4fe1-440a-9739-e5a5ea43d6eb@kernel.org>

On Mon, Oct 13, 2025 at 04:54:13PM -0600, Khalid Aziz wrote:
> > @@ -703,20 +705,15 @@ static int pxamci_probe(struct platform_device *pdev)
> >   	platform_set_drvdata(pdev, mmc);
> > -	host->dma_chan_rx = dma_request_chan(dev, "rx");
> > -	if (IS_ERR(host->dma_chan_rx)) {
> > -		host->dma_chan_rx = NULL;
> > +	host->dma_chan_rx = devm_dma_request_chan(dev, "rx");
> > +	if (IS_ERR(host->dma_chan_rx))
> >   		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
> >   				     "unable to request rx dma channel\n");
> > -	}
> > -	host->dma_chan_tx = dma_request_chan(dev, "tx");
> > -	if (IS_ERR(host->dma_chan_tx)) {
> > -		dev_err(dev, "unable to request tx dma channel\n");
> > -		ret = PTR_ERR(host->dma_chan_tx);
> > -		host->dma_chan_tx = NULL;
> > -		goto out;
> > -	}
> > +	host->dma_chan_tx = devm_dma_request_chan(dev, "tx");
> > +	if (IS_ERR(host->dma_chan_tx))
> > +		return dev_err_probe(dev, PTR_ERR(host->dma_chan_tx),
> > +				     "unable to request tx dma channel\n");
> 
> We should still release DMA rx channel before returning here.
> 
> >   	if (host->pdata) {
> >   		host->detect_delay_ms = host->pdata->detect_delay_ms;
> > @@ -724,25 +721,21 @@ static int pxamci_probe(struct platform_device *pdev)
> >   		host->power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
> >   		if (IS_ERR(host->power)) {
> >   			ret = PTR_ERR(host->power);
> > -			dev_err(dev, "Failed requesting gpio_power\n");
> > -			goto out;
> > +			return dev_err_probe(dev, ret, "Failed requesting gpio_power\n");
> 
> Don't we need to release DMA Rx and Tx channels before we return from here?
> 
> >   		}
> >   		/* FIXME: should we pass detection delay to debounce? */
> >   		ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0);
> > -		if (ret && ret != -ENOENT) {
> > -			dev_err(dev, "Failed requesting gpio_cd\n");
> > -			goto out;
> > -		}
> > +		if (ret && ret != -ENOENT)
> > +			return dev_err_probe(dev, ret, "Failed requesting gpio_cd\n");
> 
> Same here
> 
> >   		if (!host->pdata->gpio_card_ro_invert)
> >   			mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
> >   		ret = mmc_gpiod_request_ro(mmc, "wp", 0, 0);
> > -		if (ret && ret != -ENOENT) {
> > -			dev_err(dev, "Failed requesting gpio_ro\n");
> > -			goto out;
> > -		}
> > +		if (ret && ret != -ENOENT)
> > +			return dev_err_probe(dev, ret, "Failed requesting gpio_ro\n");
> 
> and here.
> 
> Looking at Documentation/driver-api/driver-model/devres.rst,
> dma_request_chan() is not devres managed interface and thus will not be
> released automatically. Do you agree?
> 

The patch changes dma_request_chan() to devm_dma_request_chan().

regards,
dan carpenter


