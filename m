Return-Path: <linux-kernel+bounces-884934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA50DC3188A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CAB189EE13
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1F732ED25;
	Tue,  4 Nov 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DymkLmE9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0163E32D7F4;
	Tue,  4 Nov 2025 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266580; cv=none; b=e2gPBRc94t1BKwfhMUh0oU47zH/CtvKHjn0m4nkM2WIHiV35HiOsUuC+uD9MAMJIreGghfSNyKvnS34MZduLYr1MFfPxX4xS41mVoQxJWznjxdRORVWB7ArG5sCM3ulsq2Kero3mIKWZZG3p7DWYPwdOV79nsPEMZjrkRyuq2Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266580; c=relaxed/simple;
	bh=c4RLP+0vDN22bgBLg9lz58qJzb1Ge1h66SNRV9dWN28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6P4l72H6Ma5MUAArx4mLeV1AxkmvjJlfiem2h+4sVud9VisLNTLWNDg/VXyVG3uanjEnsAZg8UhbDFHDoM/WZ5YjDIMme44ejngqhyQp95xZafbp6puTBWCFpFDQPQY7SFLbOoIXiO1PFf7xpAyg7kaX2pROMHbEWmIaNacdfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DymkLmE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF99C4CEF7;
	Tue,  4 Nov 2025 14:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762266578;
	bh=c4RLP+0vDN22bgBLg9lz58qJzb1Ge1h66SNRV9dWN28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DymkLmE9+QCgMxOa0/F3c/CZRjbA+jZYpn8aMVzxWJFt+fVGH9GajnxsNiUrFpEWD
	 G5njtKAG5qkT4+gpTDCGRwvPPzWl5rsfR91YJEr2Q6QRhsqwtGKFX9eCkTBwlyF36J
	 InzWg7MW4oJGqUbiSm0J6Ysy3Qz9i71DubLIAqcY=
Date: Tue, 4 Nov 2025 23:29:33 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Lecki <lec.jakub@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>
Subject: Re: [PATCH 1/3] usbip: Convert CONFIG_USBIP_VHCI_NR_HCS to a module
 parameter.
Message-ID: <2025110450-limping-retaliate-1ad9@gregkh>
References: <20251104113248.223594-1-lec.jakub@gmail.com>
 <20251104113248.223594-2-lec.jakub@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104113248.223594-2-lec.jakub@gmail.com>

On Tue, Nov 04, 2025 at 12:32:46PM +0100, Jakub Lecki wrote:
> In workflows involving a greater number of remote
> USB/IP devices, the default number of available virtual ports may be
> insufficient, forcing user to recompile the module with greater number
> of configured virtual host controllers and/or number of ports.
> 
> Allow a user to configure the number of USB/IP virtual host controllers
> via a new 'num_controllers' module parameter to simplify the usage of
> this module.
> 
> VHCI controller structures are already dynamically allocated during
> module initialization, so the only change is switch from assigning
> 'vhci_num_controllers' via Kconfig to using the module parameter
> framework.
> 
> - Remove the USBIP_VHCI_NR_HCS Kconfig option and replace it with a
>   module parameter.
> - Trim the value of the configured 'num_controllers' parameter if it
>   exceeds bounds, and emit a warning.
> 
> Signed-off-by: Jakub Lecki <lec.jakub@gmail.com>
> ---
>  drivers/usb/usbip/Kconfig    | 11 -----------
>  drivers/usb/usbip/vhci.h     |  9 +++------
>  drivers/usb/usbip/vhci_hcd.c | 16 ++++++++++++++--
>  3 files changed, 17 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/usb/usbip/Kconfig b/drivers/usb/usbip/Kconfig
> index b9f94e2e278d..bdcb6f4fdbec 100644
> --- a/drivers/usb/usbip/Kconfig
> +++ b/drivers/usb/usbip/Kconfig
> @@ -38,17 +38,6 @@ config USBIP_VHCI_HC_PORTS
>  	  host controller driver, this defines number of ports per
>  	  USB/IP virtual host controller.
>  
> -config USBIP_VHCI_NR_HCS
> -	int "Number of USB/IP virtual host controllers"
> -	range 1 128
> -	default 1
> -	depends on USBIP_VHCI_HCD
> -	help
> -	  To increase number of ports available for USB/IP virtual
> -	  host controller driver, this defines number of USB/IP
> -	  virtual host controllers as if adding physical host
> -	  controllers.
> -
>  config USBIP_HOST
>  	tristate "Host driver"
>  	depends on USBIP_CORE && USB
> diff --git a/drivers/usb/usbip/vhci.h b/drivers/usb/usbip/vhci.h
> index 5659dce1526e..30b8540e0b49 100644
> --- a/drivers/usb/usbip/vhci.h
> +++ b/drivers/usb/usbip/vhci.h
> @@ -82,11 +82,8 @@ enum hub_speed {
>  /* Each VHCI has 2 hubs (USB2 and USB3), each has VHCI_HC_PORTS ports */
>  #define VHCI_PORTS	(VHCI_HC_PORTS*2)
>  
> -#ifdef CONFIG_USBIP_VHCI_NR_HCS
> -#define VHCI_NR_HCS CONFIG_USBIP_VHCI_NR_HCS
> -#else
> -#define VHCI_NR_HCS 1
> -#endif
> +#define VHCI_DEFAULT_NR_HCS 1
> +#define VHCI_MAX_NR_HCS 128
>  
>  #define MAX_STATUS_NAME 16
>  
> @@ -118,7 +115,7 @@ struct vhci_hcd {
>  	struct vhci_device vdev[VHCI_HC_PORTS];
>  };
>  
> -extern int vhci_num_controllers;
> +extern unsigned int vhci_num_controllers;
>  extern struct vhci *vhcis;
>  extern struct attribute_group vhci_attr_group;
>  
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index e70fba9f55d6..93c3fa3e1c53 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -10,6 +10,7 @@
>  #include <linux/kthread.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/printk.h>
>  #include <linux/slab.h>
>  #include <linux/string_choices.h>
>  
> @@ -44,7 +45,12 @@ static int vhci_get_frame_number(struct usb_hcd *hcd);
>  static const char driver_name[] = "vhci_hcd";
>  static const char driver_desc[] = "USB/IP Virtual Host Controller";
>  
> -int vhci_num_controllers = VHCI_NR_HCS;
> +unsigned int vhci_num_controllers = VHCI_DEFAULT_NR_HCS;
> +module_param_named(num_controllers, vhci_num_controllers, uint, 0444);
> +MODULE_PARM_DESC(num_controllers, "Number of USB/IP virtual host controllers (range: 0-"
> +		 __MODULE_STRING(VHCI_MAX_NR_HCS) ", default: "
> +		 __MODULE_STRING(VHCI_DEFAULT_NR_HCS) ")");

I'm all for making this dynamic, but this is not the 1990's, please do
not add new module parameters.  Use the "proper" api for this, either
sysfs or configfs, instead.

thanks,

greg k-h

