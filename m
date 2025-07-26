Return-Path: <linux-kernel+bounces-746647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC88B12964
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 09:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D19BA7AA476
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 07:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1132200132;
	Sat, 26 Jul 2025 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XWRovUzQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515CF1FFC41;
	Sat, 26 Jul 2025 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753513578; cv=none; b=JU4DAEyP8BYTRJ6DBB2qLjcGNBytTEsEAq/sxqiUt49IVtBQ8Gb79T+Ipoj51VRr7dScG/ISaDGerapB+IUgrhfd1urPsdNLfTphlKVzgfh5qlevSzSNn/KfugBRuq/0XsL7Yu16qbBvSA0DW99rH39dPgo1ppVobIRmQ6UbKaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753513578; c=relaxed/simple;
	bh=rx4in36ibYcSogbrWv2Uqs+CysaZQCavA10gfHzEpzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxcRmUhHFltcVGG8fSwk7Q6fII/k+FyGsvSasQHLoy8e1/2hkZwAmTVzY4lRrIR138wB95iacyKv9DQYPnO1KMmLjfrmmSHQBtawBQYr/VTSSgfV8/xST4q9p39Rv4i/fyf9//YqoRgcYDO75G4EDv1iIybSdJCqnp/0IeS2+MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XWRovUzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56862C4CEED;
	Sat, 26 Jul 2025 07:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753513575;
	bh=rx4in36ibYcSogbrWv2Uqs+CysaZQCavA10gfHzEpzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWRovUzQqWxNbpxiMHX6JzGKNItQiMNJkm7H4COpjP8D5oNiLSE9PA9nT0C/Oh/c4
	 c7r5b2HDsmWS6LYSoYyPtWGoAQpucRSusU/MT9pufF9R+nejJEnl1CsbDu4Qhu8nGG
	 96+HP73KsJhjSAhYIdq1NTZnQUCRlnvMKGHTiPNQ=
Date: Sat, 26 Jul 2025 09:06:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
	"Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/18] usb: vhci-hcd: Prevent suspending virtually
 attached devices
Message-ID: <2025072637-google-referable-dc99@gregkh>
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

When is this FIXME going to be addressed and by whom?

> +			 *
> +			 * It's not entirely clear if operating on a different
> +			 * usb_device instance here is a real possibility,
> +			 * otherwise this call and vdev->udev assignment above
> +			 * should be dropped.

What is going to need to happen to figure this out?

thanks,

greg k-h

