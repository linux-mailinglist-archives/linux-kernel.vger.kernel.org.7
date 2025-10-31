Return-Path: <linux-kernel+bounces-880271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3700C25487
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCC974E046D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3C4223DD0;
	Fri, 31 Oct 2025 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0rzNmhfb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F269221577;
	Fri, 31 Oct 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761917924; cv=none; b=r7nPYH3AOGKE5WM1Lq8DepF/bzqemJKt2iuGbh1BpKFox73nyzDKsF2sf4c3axt9vaxBqc/MdYST6GGflxzqu8SYPALoH5NLGmtg9pzaGRBdKA1BAlQUYiI8CP7JUr0amP++YicLVQ5uZFwmUR6R47Eqr2VytuL14vaefbAbBqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761917924; c=relaxed/simple;
	bh=5ZpTYHAdSZWN5K+ss9cIl0hFJcGM7waDKRJA1f+oNg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAFczLcTHVUIbRzKF8BkBSF2iFenr0Iwl0JFVwZxGSKrpjNWnlsqvPMP+uyWwk+adyOsFAfVvD3bnignKYQZQnVSduln7yLgV5u0EgnpbJXSMcmt6w144lMmcnBNWxS6KjvmLyJafYxgLDWlJjgFxQqeSsYuerao+n0c2u/x1sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0rzNmhfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99722C4CEE7;
	Fri, 31 Oct 2025 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761917924;
	bh=5ZpTYHAdSZWN5K+ss9cIl0hFJcGM7waDKRJA1f+oNg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0rzNmhfbslyU9hGtbqAqVEJyVnWxqg4CYYkoqdZ25FVJlPSLuHwEH4WCsTtLTynig
	 XsCDmL+YiW2NG2zo8kicOEuRJbOFrmwXeLrGksZk5hYKJq94jO+1zyfSHbZ+4HrIzw
	 5qYC9tk9m/yMs/Q/n3/rD5N+DkISygJpi8fPgpCQ=
Date: Fri, 31 Oct 2025 14:38:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: vsshingne <vaibhavshingne66@gmail.com>
Cc: skhan@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: prevent double URB enqueue leading to
 corruption
Message-ID: <2025103110-earful-taekwondo-081a@gregkh>
References: <20251031132651.219859-1-vaibhavshingne66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031132651.219859-1-vaibhavshingne66@gmail.com>

On Fri, Oct 31, 2025 at 06:56:51PM +0530, vsshingne wrote:
> Signed-off-by: vsshingne <vaibhavshingne66@gmail.com>
> ---
>  drivers/usb/core/hcd.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 87fcb78c34a8..66861f372daf 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1758,16 +1758,15 @@ void usb_hcd_giveback_urb(struct usb_hcd *hcd, struct urb *urb, int status)
>  		pr_warn("usb: URB already linked to bh->head, skipping duplicate addition\n");
>  		return;
>  	}
> -	
>  	list_add_tail(&urb->urb_list, &bh->head);
>  	running = bh->running;
>  	spin_unlock(&bh->lock);
>  
>  	if (!running) {
> -        	if (bh->high_prio)
> -                	queue_work(system_bh_highpri_wq, &bh->bh);
> -        	else
> -        	        queue_work(system_bh_wq, &bh->bh);
> +		if (bh->high_prio)
> +			queue_work(system_bh_highpri_wq, &bh->bh);
> +		else
> +			queue_work(system_bh_wq, &bh->bh);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(usb_hcd_giveback_urb);
> -- 
> 2.48.1
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

