Return-Path: <linux-kernel+bounces-781114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19925B30DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143BBA25337
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725B426E704;
	Fri, 22 Aug 2025 04:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UqbPcm62"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3EE393DF0;
	Fri, 22 Aug 2025 04:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838167; cv=none; b=GJ+DDZapeRQ+FZaX3VMBH8kxk5ErdqQG9KIirFnjCUXtw+0o48AyU9K2yX+U8RTmXe1Vnm1f6woNwhXDIVc8l+7DjlPpS0ZnmHuakp0XLUL4WNcQx3a828ZV9LS+IBuO8+HYPhAB1p22A42sIMwi7QnrGM3kzrn2rUJG78jtUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838167; c=relaxed/simple;
	bh=lrB9DC2wIo77kTJ7HkkZjFXvU4Cb/omt9e+VHXMqLRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFwvdOYYEe+nj7WEUhtzTMdQK3Eb+QIrbQ2QHQIS4T//E7+42/w4wLKW8qJqMvHkrtoI8fo+CYg6YC0DehXjhHwSVcKHBk2Cook/4GsC8GAPg1AU1B6+TWmApfh/JIRpBMb4NuPFO8Xu2SF505SfA5ncjyoRks3dFPa/B5E10ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UqbPcm62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3CAC4CEF1;
	Fri, 22 Aug 2025 04:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755838167;
	bh=lrB9DC2wIo77kTJ7HkkZjFXvU4Cb/omt9e+VHXMqLRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UqbPcm62uMesDWkt7g9hqVghT0corwH37xjm8lxMY7iq54BBBEi/iKJWFHBOT17uZ
	 rX4ev0Pe1F7ZFOapgE100JYc8FHHP9en2xlhSqpbloh1QbfS60JC3mEz9ca/wMsNkG
	 32sBoSwWSJ4lcqseo8v5bWZR8ns2Wm8lxAZ/RX74=
Date: Fri, 22 Aug 2025 06:49:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: ccc194101@163.com
Cc: jannh@google.com, stern@rowland.harvard.edu, rex.nie@jaguarmicro.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenchangcheng <chenchangcheng@kylinos.cn>
Subject: Re: [PATCH] usb: usbfs: Add reset_resume callback to usbfs.
Message-ID: <2025082256-wizard-traverse-1c88@gregkh>
References: <20250822024602.42894-1-ccc194101@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822024602.42894-1-ccc194101@163.com>

On Fri, Aug 22, 2025 at 10:46:02AM +0800, ccc194101@163.com wrote:
> From: chenchangcheng <chenchangcheng@kylinos.cn>
> 
> When an Apple device is inserted into the host, and the host
> wakes up from S3/S4 power states, if the reset_resume process
> is triggered, the absence of a reset_resume callback in usbfs will
> cause the device to unbind.
> By adding a reset_resume callback to usbfs and reporting REMOVE and ADD
> uevents in reset_resume, the userspace is prompted to reissue commands
> to re-establish the binding with usbfs.
> 
> Signed-off-by: chenchangcheng <chenchangcheng@kylinos.cn>

Nit, we need a "real name", see the kernel documentation for details.

> ---
>  drivers/usb/core/devio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> index f6ce6e26e0d4..358850596b0d 100644
> --- a/drivers/usb/core/devio.c
> +++ b/drivers/usb/core/devio.c
> @@ -749,6 +749,14 @@ static int driver_resume(struct usb_interface *intf)
>  	return 0;
>  }
>  
> +static int driver_reset_resume(struct usb_interface *intf)
> +{
> +	struct usb_device *udev = interface_to_usbdev(intf);
> +
> +	kobject_uevent(&udev->dev.kobj, KOBJ_REMOVE);
> +	kobject_uevent(&udev->dev.kobj, KOBJ_ADD);

But the object is not being removed and added.  So why lie like this?
How does userspace now handle this as the device did not go away?

This feels odd, what changed to require this kernel change to be added?

thanks,

greg k-h

