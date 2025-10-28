Return-Path: <linux-kernel+bounces-873893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD873C15068
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6FE424797
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB03258ECF;
	Tue, 28 Oct 2025 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p33tTYtw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E497F35B130;
	Tue, 28 Oct 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659809; cv=none; b=FDDCN3Xe1pIBKZGdSYABuqrFbQx52fEWvca/cgaJBu/XD6MJORpO5OjOE7wqEQ/RKWH9V1jr5cpToe/4sWFS2+mV+HYgMi8jcFO8y/CP9PIYT5iBcVQiAHoHXH9aBZbfyTPr3e/RaddWaRe5SJz2YhZiPuWRs/lvDWhLZ74dRQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659809; c=relaxed/simple;
	bh=39rRzHYJg6U7sdYDWxlypira1t/bdk+oC8ElN/fpzvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xr7FAGy2sdqpQBUDx0rbkqOWGIwjF3bvk3gpCZtN7DTd704V/oLVHhtM3xAnnOpaNhWvEs7awIJo+3XNSoJbDcLzyU/3mdMAlgJXThwc1jf3enW6A/3oNmyhNvT9GsAzqt/0j8jON6eknMyNmsihUISPn99I0rnmX1+HyprlY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p33tTYtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFB0C4CEE7;
	Tue, 28 Oct 2025 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761659808;
	bh=39rRzHYJg6U7sdYDWxlypira1t/bdk+oC8ElN/fpzvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p33tTYtwfrjj1qsf/FWa69pDCO8O3C2FevlZXeNHsKI7XSHwVrSr8QZicQ6i6Yn2N
	 WsJZyERjqFoLF5Hu5rQDI4NrpjRMOTSEe8u/8w1AiLlau6HFmuFPgqcvDg2qhOSb03
	 /dKY0FSYVEl4iM96dWkHTJJVsBYqLGRs5yc3YIec=
Date: Tue, 28 Oct 2025 14:56:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: uttkarsh.aggarwal@oss.qualcomm.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, mathias.nyman@intel.com,
	wesley.cheng@oss.qualcomm.com
Subject: Re: [RFT PATCH] xhci: sideband: Fix race condition in sideband
 unregister
Message-ID: <2025102808-sublime-substance-74bb@gregkh>
References: <51ca2248-5699-4c6d-b037-a57c90ed44ac@linux.intel.com>
 <20251028134452.244096-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028134452.244096-1-mathias.nyman@linux.intel.com>

On Tue, Oct 28, 2025 at 03:44:51PM +0200, Mathias Nyman wrote:
> Uttkarsh Aggarwal observed a kernel panic during sideband un-register
> and found it was caused by a race condition between sideband unregister,
> and creating sideband interrupters.
> The issue occurrs when thread T1 runs uaudio_disconnect() and released
> sb->xhci via sideband_unregister, while thread T2 simultaneously accessed
> the now-NULL sb->xhci in xhci_sideband_create_interrupter() resulting in
> a crash.
> 
> Ensure new endpoints or interrupter can't be added to a sidenband after
> xhci_sideband_unregister() cleared the existing ones, and unlocked the
> sideband mutex.
> Reorganise code so that mutex is only taken and released once in
> xhci_sideband_unregister(), and clear sb->vdev while mutex is taken.
> 
> Refuse to add endpoints or interrupter if sb->vdev is not set.
> sb->vdev is set when sideband is created and registered.
> 
> Reported-by: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
> Closes: https://lore.kernel.org/linux-usb/20251028080043.27760-1-uttkarsh.aggarwal@oss.qualcomm.com
> Fixes: de66754e9f80 ("xhci: sideband: add initial api to register a secondary interrupter entity")
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---
>  drivers/usb/host/xhci-sideband.c | 55 ++++++++++++++++++++++++--------
>  1 file changed, 41 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
> index e771a476fef2..c308be9a8e9f 100644
> --- a/drivers/usb/host/xhci-sideband.c
> +++ b/drivers/usb/host/xhci-sideband.c
> @@ -86,6 +86,22 @@ __xhci_sideband_remove_endpoint(struct xhci_sideband *sb, struct xhci_virt_ep *e
>  	sb->eps[ep->ep_index] = NULL;
>  }
>  
> +static void
> +__xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
> +{
> +	struct usb_device *udev;
> +
> +	if (!sb->ir)
> +		return;
> +
> +	xhci_remove_secondary_interrupter(xhci_to_hcd(sb->xhci), sb->ir);
> +	sb->ir = NULL;
> +	udev = sb->vdev->udev;
> +
> +	if (udev->state != USB_STATE_NOTATTACHED)
> +		usb_offload_put(udev);
> +}
> +
>  /* sideband api functions */
>  
>  /**
> @@ -132,6 +148,12 @@ xhci_sideband_add_endpoint(struct xhci_sideband *sb,
>  	unsigned int ep_index;
>  
>  	mutex_lock(&sb->mutex);
> +
> +	if (!sb->vdev) {
> +		mutex_unlock(&sb->mutex);
> +		return -ENODEV;
> +	}
> +
>  	ep_index = xhci_get_endpoint_index(&host_ep->desc);
>  	ep = &sb->vdev->eps[ep_index];
>  
> @@ -317,6 +339,12 @@ xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
>  		return -ENODEV;
>  
>  	mutex_lock(&sb->mutex);
> +
> +	if (!sb->vdev) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
>  	if (sb->ir) {
>  		ret = -EBUSY;
>  		goto out;
> @@ -352,20 +380,11 @@ EXPORT_SYMBOL_GPL(xhci_sideband_create_interrupter);
>  void
>  xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
>  {
> -	struct usb_device *udev;
> -
> -	if (!sb || !sb->ir)
> +	if (!sb)
>  		return;
>  
>  	mutex_lock(&sb->mutex);
> -	xhci_remove_secondary_interrupter(xhci_to_hcd(sb->xhci), sb->ir);
> -
> -	sb->ir = NULL;
> -	udev = sb->vdev->udev;
> -
> -	if (udev->state != USB_STATE_NOTATTACHED)
> -		usb_offload_put(udev);
> -
> +	__xhci_sideband_remove_interrupter(sb);
>  	mutex_unlock(&sb->mutex);
>  }
>  EXPORT_SYMBOL_GPL(xhci_sideband_remove_interrupter);
> @@ -465,6 +484,7 @@ EXPORT_SYMBOL_GPL(xhci_sideband_register);
>  void
>  xhci_sideband_unregister(struct xhci_sideband *sb)
>  {
> +	struct xhci_virt_device *vdev;
>  	struct xhci_hcd *xhci;
>  	int i;
>  
> @@ -474,16 +494,23 @@ xhci_sideband_unregister(struct xhci_sideband *sb)
>  	xhci = sb->xhci;
>  
>  	mutex_lock(&sb->mutex);
> +
> +	vdev = sb->vdev;
> +	if (!vdev)
> +		return;

Lock is still held :(

I think you need to use guard() to make this more sane.

thanks,

greg k-h

