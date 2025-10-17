Return-Path: <linux-kernel+bounces-858188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71227BE93D7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC94C3AE69D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF11832E13A;
	Fri, 17 Oct 2025 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ARrqHMVk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090662DAFD8;
	Fri, 17 Oct 2025 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712055; cv=none; b=isVxyJOXxqyH9B9SFWvtPGp0nPTDkch4eDbLLQzJmmVzJezTLeA4tnhxgBTc4LiKk7gEQ4QSRrF2suhxYN/uBdaLb+a18V0h+77bf0hMbuHbRHZfNuH9Vj0m4yRHUxCOJ48dAOq5eDlPPnjRWuQ374I3wWw/mTzxKtIu3LvIPFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712055; c=relaxed/simple;
	bh=8guJ2LM2mjoHjFcoWDhy5/9PcIyqGKJu/PtGoe4AVdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPoEdHhHHOoG0btTkHEfbv363fQkAK8KHzh0j/FfF262TGbS+cB7A5F4PtEHjxbN4HW323G57VNpK6EXlIw/mGW1XkTHmP3r76e1FQx9oWu+iT5sZSi8bqrVWqYyuS928offZ7IiMXSGuzrDQLAeejfU8EYKVcLVF8u2YcXUWDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ARrqHMVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F43EC4CEE7;
	Fri, 17 Oct 2025 14:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760712054;
	bh=8guJ2LM2mjoHjFcoWDhy5/9PcIyqGKJu/PtGoe4AVdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ARrqHMVkEqUTzizxQCDxhdYCFlvjPkBOb22y63dJ9JBGJ4z6jJ4wvnTViIhlyzZ+2
	 Oj2s62vnGpr4Jh2H8LW0SbDKQzdv5tlRIFHhxvPX390ay3YUYCwBk+bS1RHhyNBeY1
	 9TX3bgn6ljrmSm216K3dCce1NRgi0BP9DCve3mMM=
Date: Fri, 17 Oct 2025 16:40:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb/core/quirks: Add Huawei ME906S to wakeup quirk
Message-ID: <2025101740-cognition-stoplight-c8e6@gregkh>
References: <20251017143310.40220-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017143310.40220-1-wse@tuxedocomputers.com>

On Fri, Oct 17, 2025 at 04:33:03PM +0200, Werner Sembach wrote:
> From: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>
> 
> The list of Huawei LTE modules needing the quirk fixing spurious wakeups
> was missing the IDs of the Huawei ME906S module, therefore suspend did not
> work.
> 
> Signed-off-by: Tim Guttzeit <t.guttzeit@tuxedocomputers.com>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  drivers/usb/core/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index f5bc538753301..47f589c4104a3 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -467,6 +467,8 @@ static const struct usb_device_id usb_quirk_list[] = {
>  	/* Huawei 4G LTE module */
>  	{ USB_DEVICE(0x12d1, 0x15bb), .driver_info =
>  			USB_QUIRK_DISCONNECT_SUSPEND },
> +	{ USB_DEVICE(0x12d1, 0x15c1), .driver_info =
> +			USB_QUIRK_DISCONNECT_SUSPEND },
>  	{ USB_DEVICE(0x12d1, 0x15c3), .driver_info =
>  			USB_QUIRK_DISCONNECT_SUSPEND },
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

