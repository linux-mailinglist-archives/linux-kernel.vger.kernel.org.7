Return-Path: <linux-kernel+bounces-735611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E41DB0918B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D147188A7BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D12FA64B;
	Thu, 17 Jul 2025 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jtvW4g+B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24882F85C5;
	Thu, 17 Jul 2025 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769094; cv=none; b=tXgUU7lZCzz6/NpB9qr7/YhrdX2bugNBvtLDCx6yEcFUuO7fVhW/3LZxh+pi9cbx45kARcxoQKE5ps9Lm7qcJxub2NEf7xgKGIPuOUjA8m29BlUSjBKnFRRUO6HUIPm7UeEQOs9KbSW17cEvpjT0PYb5pY80c4b+CmZcYT7vtk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769094; c=relaxed/simple;
	bh=qgF2PhCCu2jrCR6ppj6iEwCr5hXPYuPLJcbCsGAlPik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF5CSShU2rCNmvWeN6HYmZ+IaTIncT4W3iBcZXhM3aYb38IHPnX15YdFGDwQePOOfvnV4tFBSrQAM3IoKRqWC+lJ+CnlDUcA3ibD2umyNieLSY9zqazW8Ja92KcoYncuKFPjs+xe9GKBF3ZsZPo5cp1pjyioRKsM39vVn29rXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jtvW4g+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8CCC4CEE3;
	Thu, 17 Jul 2025 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752769094;
	bh=qgF2PhCCu2jrCR6ppj6iEwCr5hXPYuPLJcbCsGAlPik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jtvW4g+B8zNptsFPV/+lOe0Vik3l15/yWbobnPH5pkJd7MIpfwUydpK377VIr1iFj
	 +HXflmN+GTlzbW2yVX752etUI4Y9VgMK0605P2X8IlAbWHYEruaGRuxaZjDKLkywh6
	 b3vhTPXVZC8KivQVqGDDeqsvsxlhMNblmY+d5rho=
Date: Thu, 17 Jul 2025 18:18:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
	"Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] usb: vhci-hcd: Consistently use __func__
Message-ID: <2025071755-vitalize-nineteen-f843@gregkh>
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
 <20250717-vhci-hcd-suspend-fix-v1-8-2b000cd05952@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-vhci-hcd-suspend-fix-v1-8-2b000cd05952@collabora.com>

On Thu, Jul 17, 2025 at 06:54:57PM +0300, Cristian Ciocaltea wrote:
> Replace all explicit function names in string literals with __func__ and
> silent several checkpatch complaints similar to the following one:
> 
>   WARNING: Prefer using '"%s...", __func__' to using 'vhci_start', this function's name, in a string
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/usb/usbip/vhci_hcd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 841902482fb15d1d86525f23492e4966f35630a0..95034440c84f931bdf47552b499e0fdc6f726e59 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -160,7 +160,7 @@ void rh_port_connect(struct vhci_device *vdev, enum usb_device_speed speed)
>  	u32		status;
>  	unsigned long	flags;
>  
> -	usbip_dbg_vhci_rh("rh_port_connect %d\n", rhport);
> +	usbip_dbg_vhci_rh("%s %d\n", __func__, rhport);

So now you have __func__ twice in the log (hint, pr_debug() provides you
the function name.)

For "trace" debugging lines like this, just remove them, ftrace is
better to use instead.


>  
>  	spin_lock_irqsave(&vhci->lock, flags);
>  
> @@ -194,7 +194,7 @@ static void rh_port_disconnect(struct vhci_device *vdev)
>  	u32		status;
>  	unsigned long	flags;
>  
> -	usbip_dbg_vhci_rh("rh_port_disconnect %d\n", rhport);
> +	usbip_dbg_vhci_rh("%s %d\n", __func__, rhport);

Can be removed.

>  
>  	spin_lock_irqsave(&vhci->lock, flags);
>  
> @@ -1172,7 +1172,7 @@ static int vhci_start(struct usb_hcd *hcd)
>  	int id, rhport;
>  	int err;
>  
> -	usbip_dbg_vhci_hc("enter vhci_start\n");
> +	usbip_dbg_vhci_hc("enter %s\n", __func__);

Also removed.

>  
>  	if (usb_hcd_is_primary_hcd(hcd))
>  		spin_lock_init(&vhci_hcd->vhci->lock);
> @@ -1299,7 +1299,7 @@ static int vhci_alloc_streams(struct usb_hcd *hcd, struct usb_device *udev,
>  			      struct usb_host_endpoint **eps, unsigned int num_eps,
>  			      unsigned int num_streams, gfp_t mem_flags)
>  {
> -	dev_dbg(&hcd->self.root_hub->dev, "vhci_alloc_streams not implemented\n");
> +	dev_dbg(&hcd->self.root_hub->dev, "%s not implemented\n", __func__);

Just drop __func__ as it's now duplicated.

>  	return 0;
>  }
>  
> @@ -1308,7 +1308,7 @@ static int vhci_free_streams(struct usb_hcd *hcd, struct usb_device *udev,
>  			     struct usb_host_endpoint **eps, unsigned int num_eps,
>  	gfp_t mem_flags)
>  {
> -	dev_dbg(&hcd->self.root_hub->dev, "vhci_free_streams not implemented\n");
> +	dev_dbg(&hcd->self.root_hub->dev, "%s not implemented\n", __func__);

Same here.

thanks,

greg k-h

