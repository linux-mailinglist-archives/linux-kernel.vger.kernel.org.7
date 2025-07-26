Return-Path: <linux-kernel+bounces-746641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201B1B12946
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 08:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17B03BE07A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 06:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6F7946C;
	Sat, 26 Jul 2025 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jp/CUEsD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6576F1F790F;
	Sat, 26 Jul 2025 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753512221; cv=none; b=MnKHcxs9g5TZKFqAzVku5gBK+v7iXP1K3AKYHEffIvjyiMUIK513LLm0Ve9VRHx0gSjzrjVaZLJi7j14mYJr8WdLFVCpP6vRihF0XX0oiS0wU8/Y+dLZJUu5OoZ37Kw50X9J1TpO3hr0Nka8C/rmpJVd4JkQmJTBmMMA+p3tiaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753512221; c=relaxed/simple;
	bh=fwvFkIj3wH2ejqrWyzwARHeKFWZ9oOcR7mslddw864o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToDXTg5dJoKfYB84b1rpBvMGTK43YyzhyClyA2SiU3XjJZsuKHCWKYJlpaUyVdPU2tbicuOuulbW0Jdc582MQJ8T2fJDKLh9NMNXZG/UkezLAv1CZPjAJw92RsC59D9BRcnEDpy2CeraFO4CZ98Lwqwn+97OxqauY9iVXOMu8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jp/CUEsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FA2C4CEED;
	Sat, 26 Jul 2025 06:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753512220;
	bh=fwvFkIj3wH2ejqrWyzwARHeKFWZ9oOcR7mslddw864o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jp/CUEsDGLYLYhUZAlhhNXvbJ8mjjRN2jalOAhPvk9NGK24fNFmttrhmIDJBHAca3
	 tPVpv1la0L4aL+EoH1mT7K0U3pChuULGbDPhUbSXG2Rr6HyqsPWRDo2fmLf/V6AeS5
	 0ROUIwjJ2Vro7qrHHo08QsbLQhY2aGO6d5hEJT/E=
Date: Sat, 26 Jul 2025 08:43:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
	"Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/18] usb: vhci-hcd: Prevent suspending virtually
 attached devices
Message-ID: <2025072630-elevate-occultist-c67f@gregkh>
References: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
 <20250726-vhci-hcd-suspend-fix-v2-1-189266dfdfaa@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726-vhci-hcd-suspend-fix-v2-1-189266dfdfaa@collabora.com>

On Sat, Jul 26, 2025 at 01:08:03AM +0300, Cristian Ciocaltea wrote:
> The VHCI platform driver aims to forbid entering system suspend when at
> least one of the virtual USB ports are bound to an active USB/IP
> connection.
> 
> However, in some cases, the detection logic doesn't work reliably, i.e.
> when all devices attached to the virtual root hub have been already
> suspended, leading to a broken suspend state, with unrecoverable resume.
> 
> Ensure the virtually attached devices do not enter suspend by setting
> the syscore PM flag.  Note this is currently limited to the client side
> only, since the server side doesn't implement system suspend prevention.
> 
> Fixes: 04679b3489e0 ("Staging: USB/IP: add client driver")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/usb/usbip/vhci_hcd.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index e70fba9f55d6a0edf3c5fde56a614dd3799406a1..b4b0ed5d64966214636b157968478600e2e4178a 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -765,6 +765,17 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>  				 ctrlreq->wValue, vdev->rhport);
>  
>  			vdev->udev = usb_get_dev(urb->dev);
> +			/*
> +			 * FIXME: A similar operation has been done via
> +			 * USB_REQ_GET_DESCRIPTOR handler below, which is
> +			 * supposed to always precede USB_REQ_SET_ADDRESS.
> +			 *
> +			 * It's not entirely clear if operating on a different
> +			 * usb_device instance here is a real possibility,
> +			 * otherwise this call and vdev->udev assignment above
> +			 * should be dropped.
> +			 */
> +			dev_pm_syscore_device(&vdev->udev->dev, true);
>  			usb_put_dev(old);
>  
>  			spin_lock(&vdev->ud.lock);
> @@ -785,6 +796,17 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>  					"Not yet?:Get_Descriptor to device 0 (get max pipe size)\n");
>  
>  			vdev->udev = usb_get_dev(urb->dev);
> +			/*
> +			 * Set syscore PM flag for the virtually attached
> +			 * devices to ensure they will not enter suspend on
> +			 * the client side.
> +			 *
> +			 * Note this doesn't have any impact on the physical
> +			 * devices attached to the host system on the server
> +			 * side, hence there is no need to undo the operation
> +			 * on disconnect.
> +			 */
> +			dev_pm_syscore_device(&vdev->udev->dev, true);
>  			usb_put_dev(old);
>  			goto out;
>  
> 
> -- 
> 2.50.0
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

