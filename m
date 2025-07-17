Return-Path: <linux-kernel+bounces-735613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87988B09190
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB7BA60418
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9784F2FA64A;
	Thu, 17 Jul 2025 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LTmWl5Bi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015901F4623;
	Thu, 17 Jul 2025 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769149; cv=none; b=QWN9jrs4rbQ+/2oeLOVAoESQZO+ep54/sJ/d31PdJhZsnF5l1WpaA2TW3fhf3nNhxFSa0P6EPO0O6h1tj9OSiIAxVj270QSqnoc2NqZPg2CjovRxVcC6p/r0ekPjKL5noskV45bNGPa3faz/5cyJ8ACGa3bBFUipTaZTLBBpI0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769149; c=relaxed/simple;
	bh=+wrJqgQlRr4gK13e8GcDDdM47V6lJxiZBRQ5LXv7tm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT3GoX/qHYxunyMJycNCeJuixsd1zHLTgIxz8r8StAiVrycENRdqRdG8I7nQE5PTPTbukweylj1KdU8cXp0ajJ9F3oeCd3xyblt0Nkcbqe1o4zmkaw/VSHfWKfhflKoZpw0d0MlfMDVXtmQ5mOjLYaZa4Sw57DGV86/FjeAB4b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LTmWl5Bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9A0C4CEE3;
	Thu, 17 Jul 2025 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752769148;
	bh=+wrJqgQlRr4gK13e8GcDDdM47V6lJxiZBRQ5LXv7tm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTmWl5BibwVXG07bH103Jqc47ad7g7BYkqXCA9+VdIYR6nGtBhDAPnm87zASMcWjw
	 ZeJJBGWoD2o2X2lquXI7AHBmGwglS8FLrgzB9cQr24yenB4VzSPmMdxou2K7b6973y
	 lAsNcNjspfMN0Jj9OWqYp2GpgsOGbrQVjwpgBBog=
Date: Thu, 17 Jul 2025 18:19:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
	"Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] usb: vhci-hcd: Fix block comments
Message-ID: <2025071751-whomever-colt-14b4@gregkh>
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
 <20250717-vhci-hcd-suspend-fix-v1-6-2b000cd05952@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-vhci-hcd-suspend-fix-v1-6-2b000cd05952@collabora.com>

On Thu, Jul 17, 2025 at 06:54:55PM +0300, Cristian Ciocaltea wrote:
> Address a couple of comment formatting issues indicated by
> checkpatch.pl:
> 
>   WARNING: Block comments use a trailing */ on a separate line
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/usb/usbip/vhci_hcd.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 53691d5e77d386b0b0e16fe9d08824baa04c0b1e..a2a8418c77e58ae9e06d673d0012b972c92ee33b 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -879,7 +879,8 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>  	priv = urb->hcpriv;
>  	if (!priv) {
>  		/* URB was never linked! or will be soon given back by
> -		 * vhci_rx. */
> +		 * vhci_rx.
> +		 */

The comment should just be one line long.

>  		spin_unlock_irqrestore(&vhci->lock, flags);
>  		return -EIDRM;
>  	}
> @@ -936,7 +937,8 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>  		unlink->unlink_seqnum = priv->seqnum;
>  
>  		/* send cmd_unlink and try to cancel the pending URB in the
> -		 * peer */
> +		 * peer
> +		 */

Same here.

thanks,

greg k-h

