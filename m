Return-Path: <linux-kernel+bounces-743600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2587FB100B0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154BD962DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C86214A7B;
	Thu, 24 Jul 2025 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X6Tsx2hx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270912747B;
	Thu, 24 Jul 2025 06:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753338912; cv=none; b=Wcu8d3uao/kPHgICHQNpkZs76F8cmQFIgVslTDRDAgb5/n9/Zkw72mCKXz8PYws0Xpi+aTmwXtNpMGaIGM4YZGlY1LDNgyfL3KFZw4mL01NpqAA+y1YMxvZymmS2bdvoOb8Azo77GzPzOSjPv5+8R1anFk8VFa87yiP4dISI9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753338912; c=relaxed/simple;
	bh=9zvOSICa2FeVuefvrf6MwW6UMADF+oTp6ZY6obKi5+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+hfqRErmXZDqce1DhzyqX6Va2aABojRH6AUKh/yZQfR0+4736F83Eidefi0a0PMaON5z69RW8QszmuHPkxopi/y+CJXBpW+yuhjLEMF4XrHG2P0CkbI3lc+eax/3QLfM1bnGAIPXDEkobL+crGvCHywWO03MPBYYzA61OiJ2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X6Tsx2hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAD9C4CEED;
	Thu, 24 Jul 2025 06:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753338910;
	bh=9zvOSICa2FeVuefvrf6MwW6UMADF+oTp6ZY6obKi5+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6Tsx2hxPydNtveiVG7iEDK356UTrnYovx1bsgtbtsUpOQdEaWwIjWaEKdYwMB+by
	 vEbVJph23JEv+pPbwtiREr94RLLFP0t4kF64JRkzOJpkEX80DFMOWQT8RFYSeFEIim
	 PLVmPIWSQ0rTgWmdT3uoCICRJ3nleuDr10SYSGog=
Date: Thu, 24 Jul 2025 08:35:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, WeitaoWang@zhaoxin.com,
	wwt8723@163.com, CobeChen@zhaoxin.com
Subject: Re: [PATCH] usb:xhci:Fix slot_id resource race conflict
Message-ID: <2025072457-quaking-each-ea25@gregkh>
References: <20250724124012.296934-1-WeitaoWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724124012.296934-1-WeitaoWang-oc@zhaoxin.com>

On Thu, Jul 24, 2025 at 08:40:12PM +0800, Weitao Wang wrote:
> In such a scenario, device-A with slot_id equal to 1 is disconnecting
> while device-B is enumerating, device-B will fail to enumerate in the
> follow sequence.
> 
> 1.[device-A] send disable slot command
> 2.[device-B] send enable slot command
> 3.[device-A] disable slot command completed and wakeup waiting thread
> 4.[device-B] enable slot command completed with slot_id equal to 1 and
> wakeup waiting thread
> 5.[device-B] driver check this slot_id was used by someone(device-A) in
> xhci_alloc_virt_device, this device fails to enumerate as this conflict
> 6.[device-A] xhci->devs[slot_id] set to NULL in xhci_free_virt_device
> 
> To fix drivers slot_id resources conflict, let the xhci_free_virt_device
> function call in the interrupt handler when disable slot command success.
> 
> Fixes: 7faac1953ed1 ("xhci: avoid race between disable slot command and host runtime suspend")
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> ---
>  drivers/usb/host/xhci-hub.c  |  5 +++--
>  drivers/usb/host/xhci-ring.c |  7 +++++--
>  drivers/usb/host/xhci.c      | 29 ++++++++++++++++++++++-------
>  3 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 92bb84f8132a..fd8a64aa5779 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -705,10 +705,11 @@ static int xhci_enter_test_mode(struct xhci_hcd *xhci,
>  			continue;
>  
>  		retval = xhci_disable_slot(xhci, i);
> -		xhci_free_virt_device(xhci, i);
> -		if (retval)
> +		if (retval) {
>  			xhci_err(xhci, "Failed to disable slot %d, %d. Enter test mode anyway\n",
>  				 i, retval);
> +			xhci_free_virt_device(xhci, i);
> +		}
>  	}
>  	spin_lock_irqsave(&xhci->lock, *flags);
>  	/* Put all ports to the Disable state by clear PP */
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 94c9c9271658..93dc28399c3c 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1589,7 +1589,8 @@ static void xhci_handle_cmd_enable_slot(int slot_id, struct xhci_command *comman
>  		command->slot_id = 0;
>  }
>  
> -static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id)
> +static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id,
> +					u32 cmd_comp_code)
>  {
>  	struct xhci_virt_device *virt_dev;
>  	struct xhci_slot_ctx *slot_ctx;
> @@ -1604,6 +1605,8 @@ static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id)
>  	if (xhci->quirks & XHCI_EP_LIMIT_QUIRK)
>  		/* Delete default control endpoint resources */
>  		xhci_free_device_endpoint_resources(xhci, virt_dev, true);
> +	if (cmd_comp_code == COMP_SUCCESS)
> +		xhci_free_virt_device(xhci, slot_id);
>  }
>  
>  static void xhci_handle_cmd_config_ep(struct xhci_hcd *xhci, int slot_id)
> @@ -1853,7 +1856,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
>  		xhci_handle_cmd_enable_slot(slot_id, cmd, cmd_comp_code);
>  		break;
>  	case TRB_DISABLE_SLOT:
> -		xhci_handle_cmd_disable_slot(xhci, slot_id);
> +		xhci_handle_cmd_disable_slot(xhci, slot_id, cmd_comp_code);
>  		break;
>  	case TRB_CONFIG_EP:
>  		if (!cmd->completion)
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 8a819e853288..4d219418f9e1 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -3931,13 +3931,14 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
>  		 * the USB device has been reset.
>  		 */
>  		ret = xhci_disable_slot(xhci, udev->slot_id);
> -		xhci_free_virt_device(xhci, udev->slot_id);
>  		if (!ret) {
>  			ret = xhci_alloc_dev(hcd, udev);
>  			if (ret == 1)
>  				ret = 0;
>  			else
>  				ret = -EINVAL;
> +		} else {
> +			xhci_free_virt_device(xhci, udev->slot_id);
>  		}
>  		return ret;
>  	}
> @@ -4085,10 +4086,11 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
>  	for (i = 0; i < 31; i++)
>  		virt_dev->eps[i].ep_state &= ~EP_STOP_CMD_PENDING;
>  	virt_dev->udev = NULL;
> -	xhci_disable_slot(xhci, udev->slot_id);
> +	ret = xhci_disable_slot(xhci, udev->slot_id);
>  
>  	spin_lock_irqsave(&xhci->lock, flags);
> -	xhci_free_virt_device(xhci, udev->slot_id);
> +	if (ret)
> +		xhci_free_virt_device(xhci, udev->slot_id);
>  	spin_unlock_irqrestore(&xhci->lock, flags);
>  
>  }
> @@ -4128,9 +4130,20 @@ int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id)
>  
>  	wait_for_completion(command->completion);
>  
> -	if (command->status != COMP_SUCCESS)
> +	if (command->status != COMP_SUCCESS) {
>  		xhci_warn(xhci, "Unsuccessful disable slot %u command, status %d\n",
>  			  slot_id, command->status);
> +		switch (command->status) {
> +		case COMP_COMMAND_ABORTED:
> +		case COMP_COMMAND_RING_STOPPED:
> +			xhci_warn(xhci, "Timeout while waiting for disable slot command\n");
> +			ret = -ETIME;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +	}
>  
>  	xhci_free_command(xhci, command);
>  
> @@ -4243,8 +4256,9 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
>  	return 1;
>  
>  disable_slot:
> -	xhci_disable_slot(xhci, udev->slot_id);
> -	xhci_free_virt_device(xhci, udev->slot_id);
> +	ret = xhci_disable_slot(xhci, udev->slot_id);
> +	if (ret)
> +		xhci_free_virt_device(xhci, udev->slot_id);
>  
>  	return 0;
>  }
> @@ -4381,10 +4395,11 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
>  
>  		mutex_unlock(&xhci->mutex);
>  		ret = xhci_disable_slot(xhci, udev->slot_id);
> -		xhci_free_virt_device(xhci, udev->slot_id);
>  		if (!ret) {
>  			if (xhci_alloc_dev(hcd, udev) == 1)
>  				xhci_setup_addressable_virt_dev(xhci, udev);
> +		} else {
> +			xhci_free_virt_device(xhci, udev->slot_id);
>  		}
>  		kfree(command->completion);
>  		kfree(command);
> -- 
> 2.32.0
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

