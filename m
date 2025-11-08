Return-Path: <linux-kernel+bounces-891205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69373C42253
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9184262E7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3320428136C;
	Sat,  8 Nov 2025 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fZm+FoUu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA7F2727FC;
	Sat,  8 Nov 2025 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562599; cv=none; b=CObUO0Av+AufFFRtL/AG0H1SbqMUcjPcRu3i/TYg3/PVYdZHKOyPyA19k91eK9zv0IM/tEVenMlGBvvsN2TdmXZbcItSwpTUDwJ4l/feQLPFCoGHifyon1JItqVZF3oaFWJSEOEhfjMDOawKfJ2R1tQXmXZ6kvWVPOaBu9NCIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562599; c=relaxed/simple;
	bh=kD8864aiUsyx8ERVp5u8M1YCNeVdVth68YNi3jnw+vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFDY/aKNz5Q8GTO4zPwc5CT6ehGWK9aC7M99s3TYsxVvxzWebk71FqP6XZgKlXBxavrjCmUI2qOCVgLpxFJ/MaFlHBjWgSToQVSZgHdQuqmuy3VvBqysTkJvMKwwfeN5umPeH+GGpGgmyasnlUFwlWjX1rcjD8Q05XcW9SADmg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fZm+FoUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7AFC113D0;
	Sat,  8 Nov 2025 00:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762562598;
	bh=kD8864aiUsyx8ERVp5u8M1YCNeVdVth68YNi3jnw+vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZm+FoUu5/tJUNV2QXCh+E7Zw30ydJyEzyiW71KTU+0XMKy8438tsEqTUKnQSt6Az
	 BecBwS2j2MAqYZMwZJO9MXJdeklUY6m8XM7B8o3mAZDKyibYkErF2pMp0RX3K5ivBv
	 9zELGu+ptdkJTL7v4/h4xcWeUGP5gzc4Udd0+CBI=
Date: Sat, 8 Nov 2025 09:43:14 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Peter Korsgaard <peter@korsgaard.com>
Cc: javier.carrasco@wolfvision.net, heikki.krogerus@linux.intel.com,
	neal@gompa.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tipd: drop double register read in
 tps6598x_interrupt
Message-ID: <2025110840-varnish-exhale-c362@gregkh>
References: <20251106164850.1703648-1-peter@korsgaard.com>
 <2025110750-diminish-film-f952@gregkh>
 <87bjld51h3.fsf@dell.be.48ers.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjld51h3.fsf@dell.be.48ers.dk>

On Fri, Nov 07, 2025 at 04:03:36PM +0100, Peter Korsgaard wrote:
> >>>>> "Greg" == Greg KH <gregkh@linuxfoundation.org> writes:
> 
>  > On Thu, Nov 06, 2025 at 05:48:49PM +0100, Peter Korsgaard wrote:
>  >> Commit 409c1cfb5a80 ("usb: typec: tipd: fix event checking for tps6598x")
>  >> added (by accident?) a double read of the TPS_REG_INT_EVENT1 register.  Drop
>  >> that.
> 
>  > Are you sure?  Sometimes 2 reads are required.  How was this tested?
> 
> Hard to be 100% sure, but the code did not have a double read before the
> above commit and sticking a printk in the driver like this:
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 01db27cbf1d1..6687d192dbd4 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -536,8 +536,9 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
>                 intev_len = TPS_65987_8_INTEVENT_LEN;
> 
>         ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, intev_len);
> -
> +       printk(KERN_ERR "1st: %llx %llx\n", event1[0], event1[1]);
>         ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, intev_len);
> +       printk(KERN_ERR "2nd: %llx %llx\n", event1[0], event1[1]);
>         if (ret) {
>                 dev_err(tps->dev, "%s: failed to read event1\n", __func__);
>                 goto err_unlock;
> 
> 
> and (un)plugging the USB cable I see:
> 
> [ 3267.257341] 1st: 3000008 0
> [ 3267.262097] 2nd: 3000008 0
> 
> [ 3267.345179] 1st: 1000000 0
> [ 3267.350512] 2nd: 1000000 0
> 
> [ 3267.388947] 1st: 1000000 0
> [ 3267.393707] 2nd: 1000000 0
> 
> [ 3267.912112] 1st: 1000000 0
> [ 3267.916872] 2nd: 1000000 0
> 
> [ 3268.049505] 1st: 1000000 0
> [ 3268.054773] 2nd: 1000000 0
> 
> [ 3269.105173] 1st: 1000000 0
> [ 3269.109970] 2nd: 1000000 0
> 
> [ 3280.049111] 1st: 3000008 0
> [ 3280.053865] 2nd: 3000008 0
> 
> So I am fairly sure it is not needed.

Sometimes hardware requires it, even if it is not noticed by the actual
read value, so I would like to get an ack from the original author on
this before accepting it.

thanks,

greg k-h

