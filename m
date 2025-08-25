Return-Path: <linux-kernel+bounces-784166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6557EB3376E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8F2188D356
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEDC2874E6;
	Mon, 25 Aug 2025 07:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SJ6BDxkV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87BE22D7A5;
	Mon, 25 Aug 2025 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105782; cv=none; b=MVs80xLkQOW2aUDPWtNvWV2/cQC58zyDjEl2Edwp9S5kjs4G/5OZC5MFyT3yYWsR2fEieMAb6kBE5E+d7wugyIfxMVcC0I5CTPWhECLOe5dcH9MezOzyMj2Qpw3W14JdqJWMkIMThqzzhQc3D8zQN5v3Ox+rQ9uf6lO1pCXHKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105782; c=relaxed/simple;
	bh=KfsviukwirfVkfMtcHVCDuesFyzwAkTtepvkn5e6jkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slwmrEiTHcem4UOpgMkshaJFJh3xXOGPQC+96lmolPXZihUoblZtFZIJiuXKgSPQoqjGHQu4gpeL/UKidWhzJFp8MgSL8kYbZi7jpyqHbRXqPafx5V6E4VhnBKbi0ApMmMkKCgNk8u9o2Mg5wG4n8vXBWcTHDJgTtGg6IHrgGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SJ6BDxkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B10C4CEED;
	Mon, 25 Aug 2025 07:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756105782;
	bh=KfsviukwirfVkfMtcHVCDuesFyzwAkTtepvkn5e6jkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJ6BDxkV/O5kxOZ4ld+iD2/lTNGxtnuhc/Q8qowJFgvQIBvQLsqMTtvYkt3GbDgt0
	 yJnPuaQja4jJCeVHVdyeDzXcHb2Yw6acAJ2b8LXsCYdmU49szxlAoGNPb+cE9LXta9
	 OLMRWw+lHFfuuuSqPz/DhrkaxOhQOWL4BwOxOJIw=
Date: Mon, 25 Aug 2025 09:09:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Wu <william.wu@rock-chips.com>
Cc: stern@rowland.harvard.edu, Chris.Wulff@biamp.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	frank.wang@rock-chips.com, jianwei.zheng@rock-chips.com,
	yue.long@rock-chips.com
Subject: Re: [PATCH v2] usb: gadget: f_hid: Fix zero length packet transfer
Message-ID: <2025082512-flatfoot-verbose-3cd5@gregkh>
References: <1756095266-5736-1-git-send-email-william.wu@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1756095266-5736-1-git-send-email-william.wu@rock-chips.com>

On Mon, Aug 25, 2025 at 12:14:26PM +0800, William Wu wrote:
> Set the hid req->zero flag of ep0/in_ep to true by default,
> then the UDC drivers can transfer a zero length packet at
> the end if the hid transfer with size divisible to EPs max
> packet size according to the USB 2.0 spec.
> 
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> ---
>  drivers/usb/gadget/function/f_hid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index 8e1d1e8..307ea56 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -511,7 +511,7 @@ static ssize_t f_hidg_write(struct file *file, const char __user *buffer,
>  	}
>  
>  	req->status   = 0;
> -	req->zero     = 0;
> +	req->zero     = 1;
>  	req->length   = count;
>  	req->complete = f_hidg_req_complete;
>  	req->context  = hidg;
> @@ -967,7 +967,7 @@ static int hidg_setup(struct usb_function *f,
>  	return -EOPNOTSUPP;
>  
>  respond:
> -	req->zero = 0;
> +	req->zero = 1;
>  	req->length = length;
>  	status = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
>  	if (status < 0)
> -- 
> 2.0.0
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

