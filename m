Return-Path: <linux-kernel+bounces-745458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3F1B11A40
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517561C21D3E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197F7242D6D;
	Fri, 25 Jul 2025 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GPkrcGXH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704061EDA1A;
	Fri, 25 Jul 2025 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433453; cv=none; b=h5fCFHWxo4DlDys2Dm/9XD88DfflX5urMzhQJXPvsotC9r9684sjLjNr1vc46kFq1NR3C+n+jSLFp7yAiv8doiyHSD/HV864LiT21ZjODdOLABXpxHAemRwaiPDNN5g73ZsBsvRUaEhBV8dA2/8OLAnrZ264MiVukc5vD/b1Z30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433453; c=relaxed/simple;
	bh=oxC+6SjVjT1XPyW+gtPOfhw9G3Y4zcz3dl47prarPfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=infMPGRj/Gr9UcfK378eBpFesZkzl1OU9fwfssE+6i30xzxUGNuDjtIc6HgTJkf2F8Ovr+97Nc4sPJPgpKBuKPbAbJKLtzx6Kv9cIX9BfNrvDkKboyFoEXtpT9bGQIv4LEjBoaXtlDVCoEbUbRPpXVtLcWwUcRNpgGi6LlCHkUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GPkrcGXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7931EC4CEE7;
	Fri, 25 Jul 2025 08:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753433453;
	bh=oxC+6SjVjT1XPyW+gtPOfhw9G3Y4zcz3dl47prarPfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPkrcGXHxPCuWHVqcqe76RFcS6ZOejqssNL5ZRTGX7tx5uvWAyoLEnlgK66Z2SYy6
	 EwTkBCzc/3C1ErlqFwiK0SZE1r3OQXAX+LXFALHoibbAaSDBszBgkc+gXcXjyu7+oC
	 e+v4leqGIyIgjkpPMxCK/8PE/S85lXLNfYa3B7k4=
Date: Fri, 25 Jul 2025 10:50:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Su Hui <suhui@nfschina.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] usb: xhci: print xhci->xhc_state when queue_command
 failed
Message-ID: <2025072506-earthen-gloater-83e1@gregkh>
References: <20250725031308.1355371-1-suhui@nfschina.com>
 <20250725060117.1773770-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725060117.1773770-1-suhui@nfschina.com>

On Fri, Jul 25, 2025 at 02:01:18PM +0800, Su Hui wrote:
> When encounters some errors like these:
> xhci_hcd 0000:4a:00.2: xHCI dying or halted, can't queue_command
> xhci_hcd 0000:4a:00.2: FIXME: allocate a command ring segment
> usb usb5-port6: couldn't allocate usb_device
> 
> It's hard to know whether xhc_state is dying or halted. So it's better
> to print xhc_state's value which can help locate the resaon of the bug.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> v2:
>  - Print xhci->xhc_state with hex style.
> 
>  drivers/usb/host/xhci-ring.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 94c9c9271658..131e7530ec4a 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -4372,7 +4372,8 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
>  
>  	if ((xhci->xhc_state & XHCI_STATE_DYING) ||
>  		(xhci->xhc_state & XHCI_STATE_HALTED)) {
> -		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command\n");
> +		xhci_dbg(xhci, "xHCI dying or halted, can't queue_command. state: 0x%x\n",
> +			 xhci->xhc_state);
>  		return -ESHUTDOWN;
>  	}
>  
> -- 
> 2.30.2
> 

Simple enough, let me take this now as I want to close my tree...

thanks,

greg k-h

