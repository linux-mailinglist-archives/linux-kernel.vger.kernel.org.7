Return-Path: <linux-kernel+bounces-892549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 267D2C45562
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C8AA4E6D29
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC89C2253EB;
	Mon, 10 Nov 2025 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJUv0V2d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F71E492D;
	Mon, 10 Nov 2025 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762571; cv=none; b=bUFq5YWDPQOeFpInIOctko1CJbwNzOZrRs610dOWM2Y6LsMtkv+f5Ev+c25AlR4odfNwiCSNjLWJUJKUJa/oNQa82LJV5eZLm0oHIYJc+uaYrswLMBdu7QSciGXkjw3qwWyXk9TQqi9hk2/orvgrSQZGL691UJRQipevGlbWDfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762571; c=relaxed/simple;
	bh=z3E6CYqiFhwSS9Guwnxfu2nbMrN67DSOuGk+BvTGPWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz7PQZV+RK1VkOQETX4ntJOmAr51D9fwVoNXqv/JsQhU6FhAyFIZxsbayc/aKCJ9LYzb9ICA/b9JAltKywkRiurGTcHvgzc2Un3aF+Lvy1y1yGrrorhXePoohi4GT9bko5UX6Hm/A7UPEmod2MN0vkZmKA+asgFNJTnP7ZeS/qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJUv0V2d; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762762569; x=1794298569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z3E6CYqiFhwSS9Guwnxfu2nbMrN67DSOuGk+BvTGPWk=;
  b=KJUv0V2dqdUfB25P5Z7mvbcwidrLzMnhuDAgVUgm4PoVdIM4WDUlREdz
   57UIY9qDR7o5URfvzEg13j4oNQRNkMwEXuoGMYrJH6bw3BhKRla3LKNRN
   fS0oyURs8eGruRczhvCUJPMdDpdwTOvo6d14/FaEFtUTYWnnGnwhZ0kK5
   3aguPi39W7DMlGSZvaPP2HX0+aGYtvMSEiDpUT5Ce6gZ2BnCg14QyW+w4
   Z/GeqEsjVcD4UifaEzRGGYbPxnSozxvsESezvz6nCxWr9KhD9cVW2gZv8
   yA4C3AJZZ29n2vtHeg6bFBtirgX3T9p+8cuYdt865t5o7rfTbPL+/NRvx
   g==;
X-CSE-ConnectionGUID: ClfA5vQrThenvjBw4qVPog==
X-CSE-MsgGUID: NA6ndUpOQjC00Rwa0upzWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75496069"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="75496069"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 00:16:07 -0800
X-CSE-ConnectionGUID: KVsy8Z28SW2LS9FTFSRebw==
X-CSE-MsgGUID: oHm9W1/sR9q2b/uStU2mLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="219269685"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.222.208])
  by orviesa002.jf.intel.com with SMTP; 10 Nov 2025 00:16:05 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 10 Nov 2025 10:16:03 +0200
Date: Mon, 10 Nov 2025 10:16:03 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Peter Korsgaard <peter@korsgaard.com>, javier.carrasco@wolfvision.net,
	neal@gompa.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tipd: drop double register read in
 tps6598x_interrupt
Message-ID: <aRGebbVWwNV0cK1x@kuha.fi.intel.com>
References: <20251106164850.1703648-1-peter@korsgaard.com>
 <2025110750-diminish-film-f952@gregkh>
 <87bjld51h3.fsf@dell.be.48ers.dk>
 <2025110840-varnish-exhale-c362@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025110840-varnish-exhale-c362@gregkh>

Sat, Nov 08, 2025 at 09:43:14AM +0900, Greg KH kirjoitti:
> On Fri, Nov 07, 2025 at 04:03:36PM +0100, Peter Korsgaard wrote:
> > >>>>> "Greg" == Greg KH <gregkh@linuxfoundation.org> writes:
> > 
> >  > On Thu, Nov 06, 2025 at 05:48:49PM +0100, Peter Korsgaard wrote:
> >  >> Commit 409c1cfb5a80 ("usb: typec: tipd: fix event checking for tps6598x")
> >  >> added (by accident?) a double read of the TPS_REG_INT_EVENT1 register.  Drop
> >  >> that.
> > 
> >  > Are you sure?  Sometimes 2 reads are required.  How was this tested?
> > 
> > Hard to be 100% sure, but the code did not have a double read before the
> > above commit and sticking a printk in the driver like this:
> > 
> > diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> > index 01db27cbf1d1..6687d192dbd4 100644
> > --- a/drivers/usb/typec/tipd/core.c
> > +++ b/drivers/usb/typec/tipd/core.c
> > @@ -536,8 +536,9 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
> >                 intev_len = TPS_65987_8_INTEVENT_LEN;
> > 
> >         ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, intev_len);
> > -
> > +       printk(KERN_ERR "1st: %llx %llx\n", event1[0], event1[1]);
> >         ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, intev_len);
> > +       printk(KERN_ERR "2nd: %llx %llx\n", event1[0], event1[1]);
> >         if (ret) {
> >                 dev_err(tps->dev, "%s: failed to read event1\n", __func__);
> >                 goto err_unlock;
> > 
> > 
> > and (un)plugging the USB cable I see:
> > 
> > [ 3267.257341] 1st: 3000008 0
> > [ 3267.262097] 2nd: 3000008 0
> > 
> > [ 3267.345179] 1st: 1000000 0
> > [ 3267.350512] 2nd: 1000000 0
> > 
> > [ 3267.388947] 1st: 1000000 0
> > [ 3267.393707] 2nd: 1000000 0
> > 
> > [ 3267.912112] 1st: 1000000 0
> > [ 3267.916872] 2nd: 1000000 0
> > 
> > [ 3268.049505] 1st: 1000000 0
> > [ 3268.054773] 2nd: 1000000 0
> > 
> > [ 3269.105173] 1st: 1000000 0
> > [ 3269.109970] 2nd: 1000000 0
> > 
> > [ 3280.049111] 1st: 3000008 0
> > [ 3280.053865] 2nd: 3000008 0
> > 
> > So I am fairly sure it is not needed.
> 
> Sometimes hardware requires it, even if it is not noticed by the actual
> read value, so I would like to get an ack from the original author on
> this before accepting it.

The hardware should not require it. Javier, can you comment on this?
If there really is need to do double read, then there needs to be a
comment explaining why IMO.

thanks,

-- 
heikki

