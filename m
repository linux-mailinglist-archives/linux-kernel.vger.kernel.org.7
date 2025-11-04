Return-Path: <linux-kernel+bounces-884936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD28EC31893
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220ED18C5911
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7FA330332;
	Tue,  4 Nov 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RYhNbb2X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC8232ED59;
	Tue,  4 Nov 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266624; cv=none; b=a4g3PFCCRfoo8oyKN2jz6g3crLvy9cGl3SWdIVQchdlM0EUHLebrL1+8iK1ZrhDOIrzaLcb2jfIJ/WjHk/K48MyXMgCpZHUretRSY65sJCXkHcu0NLVHHJPTLTrXs5K96HMlGFV6h+NYEGIoFU3JZZw25dpQWJjgEKdxLtD/sZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266624; c=relaxed/simple;
	bh=xjMIBr6AMjwygXnX/e3NAeGPHp4K/p0K97biE5sQOhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zo70HxSFdqFOS8APSzcnNToOhzrxMYwtXTT1x2Nv7afNz1F+xHpbBaRj7lqtU+jMK37sJjJJO6mHS+8QfQ4H7VjpskMm880wzCoLNiupcqjBFw4b52fpWIsMH6zuugIsxK9Eky6Vz0AiRaUVOA+hbqsb9k+e44zgoLHYKJGwS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RYhNbb2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F48C4CEF7;
	Tue,  4 Nov 2025 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762266623;
	bh=xjMIBr6AMjwygXnX/e3NAeGPHp4K/p0K97biE5sQOhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYhNbb2Xcx6i6i/LaW6+2C8lVhP52SbjCr9FpEZZWvICau9hP6b6xmn19rrA/tNhb
	 iybm6l0CdKD38ERqWLSV2dcucbuJu/wJKKYG70ASiESC79aI7i2scX8E3Y+urIF5zp
	 wTobQVJ4FYoXe12+DxMZk/1mRLjR6srx/fDxwGT4=
Date: Tue, 4 Nov 2025 23:30:18 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Lecki <lec.jakub@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>
Subject: Re: [PATCH 3/3] usbip: Limit maximum number of virtual host
 controllers to 31.
Message-ID: <2025110450-abnormal-goofball-bc68@gregkh>
References: <20251104113248.223594-1-lec.jakub@gmail.com>
 <20251104113248.223594-4-lec.jakub@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104113248.223594-4-lec.jakub@gmail.com>

On Tue, Nov 04, 2025 at 12:32:48PM +0100, Jakub Lecki wrote:
> When loading the vhci-hcd module with number of virtual host controllers
> configured to max value of 128, the module initialization fails due to
> insufficient number of available IDs for USB busses.
> 
> Each virtual host controller registers two usb hubs (USB2.0 & USB3.0) to
> the usb core, each with a unique bus number. The number of USB busses is
> limited by ID allocation range [1 .. USB_MAXBUS - 1] (defined in
> usb_register_bus()). Therefore, VHCI_MAX_NR_HCS must not be greater than
> (USB_MAXBUS - 1) / 2 = 31.
> 
> In real world scenarios the maximum number of virtual host controllers
> possible to create may be even lower as other USB host controllers may
> be registered. In this case, the module initialization failure is
> correct as the number of virtual host controllers must be adjusted by
> a user to a given use-case.
> 
> Signed-off-by: Jakub Lecki <lec.jakub@gmail.com>
> ---
>  drivers/usb/usbip/vhci.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/usbip/vhci.h b/drivers/usb/usbip/vhci.h
> index 2772d923a8cb..3b0ea4038e51 100644
> --- a/drivers/usb/usbip/vhci.h
> +++ b/drivers/usb/usbip/vhci.h
> @@ -76,8 +76,17 @@ enum hub_speed {
>  #define VHCI_DEFAULT_HC_PORTS 8
>  #define VHCI_MAX_HC_PORTS USB_SS_MAXPORTS
>  
> +/*
> + * Number of supported virtual host controllers. Value has upperbound of
> + * maximum possible usb busses.
> + * It is limited by a bus ID allocation in [1 .. USB_MAXBUS - 1] range,
> + * resulting in maximum of USB_MAXBUS - 1 usb busses allocated.
> + * Additionally, each virtual host controller registers 2 usb hubs (USB2.0
> + * & USB3.0), therefore maximum number of virtual host controllers is:
> + * (USB_MAXBUS - 1) / 2
> + */
>  #define VHCI_DEFAULT_NR_HCS 1
> -#define VHCI_MAX_NR_HCS 128
> +#define VHCI_MAX_NR_HCS 31

Why have any max at all?  Why not just dynamically allocate them when
asked for?

thanks,

greg k-h

