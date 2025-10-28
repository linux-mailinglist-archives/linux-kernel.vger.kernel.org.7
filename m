Return-Path: <linux-kernel+bounces-873342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4195DC13B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55941188BCEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA6C2F12B6;
	Tue, 28 Oct 2025 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EmOliCbj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61AF2F549A;
	Tue, 28 Oct 2025 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642444; cv=none; b=jtNqbBxJeITXz6DToEhrXynVrBb0jE9Kdg56RBYElQDkTLvbnxitRslrtSXs+ZlOYbBeb9FvxJHWwDgerqUvUSv0v9w8+JVwBF0dgjt1YFFqQdYxuHxSBeTKhGDpr85KWcJ76tUpzL6Dj/novqIdV2oQwEoI54PSDCnLJQql7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642444; c=relaxed/simple;
	bh=WxHpl51n4EsbakrBuVvz8JyJIZAFgGu/0ttTPMvNUy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsOC0IZm9g5nhNjITksg/SUEbT1C6I2xpOS7gO8vRo4pICdEVR4pXf8ofS2i4cnPfY56EV2SJwotGI4WAbvAZGz+GfuwtA4aWsmJrfrmSK+XIoDZ/VXkFOvdFMEvypCmnHmFMO2ck462kBINTxGzsojYTgyOYcdBEDvpEN5J03g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EmOliCbj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AA4C4CEE7;
	Tue, 28 Oct 2025 09:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761642444;
	bh=WxHpl51n4EsbakrBuVvz8JyJIZAFgGu/0ttTPMvNUy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EmOliCbjaJFIBi3/P+bJGAth59P2tigGVXrNf2RUceOZ/7LeIkWtjbse/HPE1i+pA
	 eelsPmrxYGTM1UgelXb8fx+Nc4SbsK1UKfNku3/OjHqmXN9Rw27T9ruUu2dotDKRFB
	 moe3tGqpqvpwIyROnOP1pOCcUsX+HXlmze8SHn9w=
Date: Tue, 28 Oct 2025 10:07:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] usb: mtu3: fix possible NULL pointer dereference in
 ep0_rx_state()
Message-ID: <2025102811-helium-caloric-cac5@gregkh>
References: <20251027193152.3906497-1-Pavel.Zhigulin@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027193152.3906497-1-Pavel.Zhigulin@kaspersky.com>

On Mon, Oct 27, 2025 at 10:31:50PM +0300, Pavel Zhigulin wrote:
> The function 'ep0_rx_state()' accessed 'mreq->request' before verifying
> that mreq was valid. If 'next_ep0_request()' returned NULL, this could
> lead to a NULL pointer dereference. The return value of
> 'next_ep0_request()' is checked in every other code path except
> here. It appears that the intended 'if (mreq)' check was mistakenly
> written as 'if (req)', since the req pointer cannot be NULL when mreq
> is not NULL.
> 
> Initialize 'mreq' and 'req' to NULL by default, and switch 'req'
> NULL-checking to 'mreq' non-NULL check to prevent invalid memory access.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: df2069acb005 ("usb: Add MediaTek USB3 DRD driver")
> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
> ---
>  drivers/usb/mtu3/mtu3_gadget_ep0.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> index e4fd1bb14a55..ee7466ca4d99 100644
> --- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
> +++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> @@ -508,8 +508,8 @@ static int handle_standard_request(struct mtu3 *mtu,
>  /* receive an data packet (OUT) */
>  static void ep0_rx_state(struct mtu3 *mtu)
>  {
> -	struct mtu3_request *mreq;
> -	struct usb_request *req;
> +	struct mtu3_request *mreq = NULL;
> +	struct usb_request *req = NULL;
>  	void __iomem *mbase = mtu->mac_base;
>  	u32 maxp;
>  	u32 csr;
> @@ -519,10 +519,11 @@ static void ep0_rx_state(struct mtu3 *mtu)
> 
>  	csr = mtu3_readl(mbase, U3D_EP0CSR) & EP0_W1C_BITS;
>  	mreq = next_ep0_request(mtu);
> -	req = &mreq->request;
> 
>  	/* read packet and ack; or stall because of gadget driver bug */
> -	if (req) {
> +	if (mreq) {
> +		req = &mreq->request;
> +
>  		void *buf = req->buf + req->actual;
>  		unsigned int len = req->length - req->actual;
> 
> --
> 2.43.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

