Return-Path: <linux-kernel+bounces-882803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D000C2B86D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E17D3A91E6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D287306488;
	Mon,  3 Nov 2025 11:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xo33jnNE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7803054F8;
	Mon,  3 Nov 2025 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170573; cv=none; b=BHp+xAUdjDVCpsN1+0WKM4KMkPNoJtUbyXOaxIbQWxCrjADpm6qJX6OMNd8cg6l0i8grhTUtL7oHiu6Mea7Xf3xsMOb5cTZVpqH/BZLy6ya1S//Imqk50oSrf9YhXtELEZboOGzx0X7/xVo6h139mLKMrVI9dZnIcGWcmYRx/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170573; c=relaxed/simple;
	bh=ZwAgCATanaBWIqO1E6H8E5QJTHevA2isw2ecO03UmJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/SberuxZYLcq5VKqQfbbv7zpzIq1XePcnoONjj8eFK8KMqDvtyd4cj00MRqr+2CI2QcoSuUK+SLc8xtf9QCpAC28hlbhtAt2NcqVuogTSDi9bFSph8MxdrYUq3xww6Tyr1PW1ShTd1obuZwh9aGdh0vwPhe2GgljEK6h/fZKD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xo33jnNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE03AC4CEFD;
	Mon,  3 Nov 2025 11:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762170573;
	bh=ZwAgCATanaBWIqO1E6H8E5QJTHevA2isw2ecO03UmJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xo33jnNEgTi3HzVNIVS3g6ls4E7ZMUvwWA4OkLZRrXcV0ZlpIpG6bOeBgKG8OFuvX
	 WM4Al9mdJL1AaZkbRmmDFVze7zkR98jNPJ2EtNJRloji+/iS2qt21VsWG6UYuwRp00
	 TnkpgoRsdhCFVECs4BUqLtmTSbzVJy7NINeEIzug=
Date: Mon, 3 Nov 2025 20:49:30 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Wesley Cheng <quic_wcheng@quicinc.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Check kcalloc_node() when allocating
 interrupter array in xhci_mem_init()
Message-ID: <2025110342-rimless-change-0a95@gregkh>
References: <20250918130838.3551270-1-lgs201920130244@gmail.com>
 <20251103094036.2d1593bc.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103094036.2d1593bc.michal.pecio@gmail.com>

On Mon, Nov 03, 2025 at 09:40:36AM +0100, Michal Pecio wrote:
> On Thu, 18 Sep 2025 21:08:38 +0800, Guangshuo Li wrote:
> > kcalloc_node() may fail. When the interrupter array allocation returns
> > NULL, subsequent code uses xhci->interrupters (e.g. in xhci_add_interrupter()
> > and in cleanup paths), leading to a potential NULL pointer dereference.
> > 
> > Check the allocation and bail out to the existing fail path to avoid
> > the NULL dereference.
> > 
> > Fixes: c99b38c412343 ("xhci: add support to allocate several interrupters")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/usb/host/xhci-mem.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> > index d698095fc88d..da257856e864 100644
> > --- a/drivers/usb/host/xhci-mem.c
> > +++ b/drivers/usb/host/xhci-mem.c
> > @@ -2505,7 +2505,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
> >  		       "Allocating primary event ring");
> >  	xhci->interrupters = kcalloc_node(xhci->max_interrupters, sizeof(*xhci->interrupters),
> >  					  flags, dev_to_node(dev));
> > -
> > +	if (!xhci->interrupters)
> > +		goto fail;
> >  	ir = xhci_alloc_interrupter(xhci, 0, flags);
> >  	if (!ir)
> >  		goto fail;
> > -- 
> > 2.43.0
> 
> Hi Greg and Mathias,
> 
> I noticed that this bug still exists in current 6.6 and 6.12 releases,
> what would be the sensible course of action to fix it?
> 
> The patch from Guangshuo Li is a specific fix and it applies cleanly on
> those branches. By simulating allocation failure, I confirmed the bug
> and the fix on 6.6.113, which is identical to the current 6.6.116.
> 
> Mainline added an identical check in 83d98dea48eb ("usb: xhci: add
> individual allocation checks in xhci_mem_init()") which is a cleanup
> that has a merge conflict at least with 6.6.
> 
> The conflict seems superficial and probably the cleanup would have no
> side effects on 6.6/6.12, but I haven't really reviewed this and maybe
> it would be simpler to just take the targeted fix?

A backport is always appreciated if you want a patch in stable kernels.
And as this really can never be triggerd by a user, it's a low priority :)

thanks,

greg k-h

