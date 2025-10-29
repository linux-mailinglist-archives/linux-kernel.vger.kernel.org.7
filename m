Return-Path: <linux-kernel+bounces-875697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3538C199F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E263BE79A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F22E7F1D;
	Wed, 29 Oct 2025 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zThxjnm1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9999C2E03F3;
	Wed, 29 Oct 2025 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732852; cv=none; b=ixH/LxlbM7Z646DDX+aaQ5MdcUrgfKHjSffcwsw+/kbGcywOKxHMaPTQYBj+tP6IhcA6oGKyIvafiDmbMkqqTTraEzynMB7Z+X8pmR99m3qLI4Qc+5saYXfunpn1R/6Oiy+Aq0i9DbsgBnPKVWR8IgfcoTsAixEp9mUhIo/NfaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732852; c=relaxed/simple;
	bh=oiA7zy0NdAu0L/ynPdQmpBGIMgCRLjHGckZBqV35RTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u69cABbpjLyz4FF0nETS4vnNvwFZ12KSXy2BgXHbDCgNwQzMDSeWKqcBIX3XJImJOgcvuZnJ9sLjaMcY1xl4UAQUCKSNSFRTtA9YDIyblayBPsToXkz36fOIcK3XRMn5ztfZm4quruJ8l9e+475nsx3W84ha6Vjx1qMQqzt+LHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zThxjnm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B704C4CEF7;
	Wed, 29 Oct 2025 10:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761732852;
	bh=oiA7zy0NdAu0L/ynPdQmpBGIMgCRLjHGckZBqV35RTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zThxjnm1T6e5WErhINrFddYqUkU+Uer1PMtSrBb83eUMgigHx+MXZ5Lqn/n6vlie6
	 Dj7m1o2Z1EUE+TxnekL92RDKptcz1l1DfhhT80gD9dQhpBQhRSESl2qkLYv084+tkL
	 fm+jubxWY6mcyjaTOVPFJYYzzt2ohpVgLK3y7gmU=
Date: Wed, 29 Oct 2025 11:14:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: uttkarsh.aggarwal@oss.qualcomm.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, mathias.nyman@intel.com,
	wesley.cheng@oss.qualcomm.com
Subject: Re: [RFT PATCH v2] xhci: sideband: Fix race condition in sideband
 unregister
Message-ID: <2025102948-trickery-creative-417e@gregkh>
References: <db07f48d-27cf-4681-b10e-38d252e24512@linux.intel.com>
 <20251028165153.283980-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028165153.283980-1-mathias.nyman@linux.intel.com>

On Tue, Oct 28, 2025 at 06:51:53PM +0200, Mathias Nyman wrote:
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
> Reorganize code so that mutex is only taken and released once in
> xhci_sideband_unregister(), and clear sb->vdev while mutex is taken.
> 
> Use mutex guards to reduce human unlock errors in code
> 
> Refuse to add endpoints or interrupter if sb->vdev is not set.
> sb->vdev is set when sideband is created and registered.
> 
> Reported-by: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
> Closes: https://lore.kernel.org/linux-usb/20251028080043.27760-1-uttkarsh.aggarwal@oss.qualcomm.com
> Fixes: de66754e9f80 ("xhci: sideband: add initial api to register a secondary interrupter entity")
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---
> 
> v2:
>   use guard() and fix missing mutex_unlock as recommended by greg k-h 
> 
> ---
>  drivers/usb/host/xhci-sideband.c | 97 +++++++++++++++++---------------
>  1 file changed, 53 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
> index e771a476fef2..2daa0ba7ad9a 100644
> --- a/drivers/usb/host/xhci-sideband.c
> +++ b/drivers/usb/host/xhci-sideband.c
> @@ -86,6 +86,22 @@ __xhci_sideband_remove_endpoint(struct xhci_sideband *sb, struct xhci_virt_ep *e
>  	sb->eps[ep->ep_index] = NULL;
>  }
>  
> +static void
> +__xhci_sideband_remove_interrupter(struct xhci_sideband *sb)

This function must be called with the mutex locked, so shouldn't you
document that here so that the compiler can catch it if we mess up in
the future and forget to grab it?

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
> @@ -131,14 +147,17 @@ xhci_sideband_add_endpoint(struct xhci_sideband *sb,
>  	struct xhci_virt_ep *ep;
>  	unsigned int ep_index;
>  
> -	mutex_lock(&sb->mutex);
> +	guard(mutex)(&sb->mutex);
> +
> +	if (!sb->vdev)
> +		return -ENODEV;
> +
>  	ep_index = xhci_get_endpoint_index(&host_ep->desc);
>  	ep = &sb->vdev->eps[ep_index];
>  
> -	if (ep->ep_state & EP_HAS_STREAMS) {
> -		mutex_unlock(&sb->mutex);
> +	if (ep->ep_state & EP_HAS_STREAMS)
>  		return -EINVAL;
> -	}
> +

Very minor nit, just delete the extra line, like you did in the rest of
the diff below here, otherwise you have 2 blank lines.

thanks,

greg k-h

