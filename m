Return-Path: <linux-kernel+bounces-735614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37516B09193
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6143B36FF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C542FC000;
	Thu, 17 Jul 2025 16:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rmGHzEq3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634172FBFE9;
	Thu, 17 Jul 2025 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769188; cv=none; b=XTwK2cDHn3Dl04R3hojxs7hvKINMaiD/wiophjJhCTLRAQmk1ipvmEYRpfCnktPcKfUdJW1trCilX+h5lrhbXdGfa7FBNq8Z5X20PwjOG9IZmNlg5AQZ6qM5UrVpbIvZZ0uxuXq39zIDixN/RcfRT6mgqIEn7VhxBDtYZAeA9XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769188; c=relaxed/simple;
	bh=bIKb0O30JNksa/bN12EZuB7px7OzxQsuWs1UcWRnoFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sv9n1n0gkB5vdIduCGzwZMkVJyyNSuNXjyQK8+7IKB7ZNaTLEKHRTUEyh6KYvDQuxKfGYHS31wWAaAob9wIPZdOPrzZ9QDvTh75XhoNXOtpglfaZ7eA0e7BQi06lh6CYYsf6FFfVuWjpNQ5BibfiW0xfDCRowqE7GTItd6jzeRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rmGHzEq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696CAC4CEE3;
	Thu, 17 Jul 2025 16:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752769187;
	bh=bIKb0O30JNksa/bN12EZuB7px7OzxQsuWs1UcWRnoFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmGHzEq3Hr8C08qx5NRedsRToEeS1+Glfg7n27g+/SaEOOsHXdXMYu48TbsSbrR/O
	 DKp2OISn627WLR61OWZsYZSscnYXaljAqPdswFGmiG0E1JPk1FmXlEImvk9RE4BaDS
	 2iUklXU8rSCh8hh+pMJAYT4h6M7F3krkKCn2x8+c=
Date: Thu, 17 Jul 2025 18:19:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
	"Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] usb: vhci-hcd: Do not split quoted strings
Message-ID: <2025071713-passivism-suggest-436d@gregkh>
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
 <20250717-vhci-hcd-suspend-fix-v1-5-2b000cd05952@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717-vhci-hcd-suspend-fix-v1-5-2b000cd05952@collabora.com>

On Thu, Jul 17, 2025 at 06:54:54PM +0300, Cristian Ciocaltea wrote:
> Join the split strings to make checkpatch happy and regain ability to
> grep for those log messages in the source code:
> 
>   WARNING: quoted string split across lines
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/usb/usbip/vhci_hcd.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 3f888455d238b983a6aafa52418fb89a914c32b5..53691d5e77d386b0b0e16fe9d08824baa04c0b1e 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -376,8 +376,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  		switch (wValue) {
>  		case USB_PORT_FEAT_SUSPEND:
>  			if (hcd->speed >= HCD_USB3) {
> -				pr_err(" ClearPortFeature: USB_PORT_FEAT_SUSPEND req not "
> -				       "supported for USB 3.0 roothub\n");
> +				pr_err(" ClearPortFeature: USB_PORT_FEAT_SUSPEND req not supported for USB 3.0 roothub\n");

Why the leading " "?

And shouldn't this be dev_err()?

>  				goto error;
>  			}
>  
> @@ -506,8 +505,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  		case USB_PORT_FEAT_LINK_STATE:
>  			usbip_dbg_vhci_rh(" SetPortFeature: USB_PORT_FEAT_LINK_STATE\n");
>  			if (hcd->speed < HCD_USB3) {
> -				pr_err("USB_PORT_FEAT_LINK_STATE req not "
> -				       "supported for USB 2.0 roothub\n");
> +				pr_err("USB_PORT_FEAT_LINK_STATE req not supported for USB 2.0 roothub\n");

dev_err()?

Same for the others.

thanks,

greg k-h

