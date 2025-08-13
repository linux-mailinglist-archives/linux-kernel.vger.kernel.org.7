Return-Path: <linux-kernel+bounces-766899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A84B24C84
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013FF1BC06DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346B52ECD3A;
	Wed, 13 Aug 2025 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T2MIFxkt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C96DF71;
	Wed, 13 Aug 2025 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096708; cv=none; b=RvsHPMr32ISBxm5Kyc8umqtdMdXtDr6tXOcjb4cYTNN6Dzz9K/Cz2K+HRnP4q0h3xyLE4GrCkpeytAY1wk7A4NdB4bXtaTSvnhTKwH2367G5TY3deu/GUeu6d7VwcNxoq5Fs8t71gdvP8GykKsF/9MlKNvKENlabqzjXTi8SZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096708; c=relaxed/simple;
	bh=xxpMbfiaWB55Ztf6P895yr5kYrVSh8V8ted8HzQxqN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTmsLejQERqz9oEpBwo+uL+orxtZMUvcOm1lQRlOH40J1sqSVUwcRiFc41AoHkYtdDDBAyw7n753qcSjhg4GB5MdFcM2AWhHMyue43pgv08EMnIBwINHTJm7L9zV2u3eTVDAY4zqrQLtYg7hUGhe3HsQEnvmrjAM4TW1i/yUymE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T2MIFxkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8124AC4CEEF;
	Wed, 13 Aug 2025 14:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755096708;
	bh=xxpMbfiaWB55Ztf6P895yr5kYrVSh8V8ted8HzQxqN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2MIFxktCVDcFwhiJY0MVy38TSnd1c+QEbDetYMz1a5jkcXL2J+7pt4o8xsE31wWa
	 7eN0XdAP8dCS2mpsBCSxYqWsRPpJMVKuJnKwRCvg7myn1Sc+004rTwXxB/8V868RoR
	 Y/Xqbzjn6Jhbh3GM4Jt7VCQYCzWiuSvcN9ItMsFY=
Date: Wed, 13 Aug 2025 16:51:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: mathias.nyman@intel.com, hannelotta@gmail.com,
	zijun.hu@oss.qualcomm.com, xu.yang_2@nxp.com,
	stern@rowland.harvard.edu, andriy.shevchenko@linux.intel.com,
	ben@decadent.org.uk, quic_wcheng@quicinc.com,
	krzysztof.kozlowski@linaro.org, dh10.jung@samsung.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 3/4] xhci: sideband: add api to trace sideband usage
Message-ID: <2025081313-senate-unhearing-4396@gregkh>
References: <20250801034004.3314737-1-guanyulin@google.com>
 <20250801034004.3314737-4-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801034004.3314737-4-guanyulin@google.com>

On Fri, Aug 01, 2025 at 03:39:32AM +0000, Guan-Yu Lin wrote:
> The existing sideband driver only registers sidebands without tracking
> their active usage. To address this, sideband will now record its active
> usage when it creates/removes interrupters. In addition, a new api is
> introduced to provide a means for other dirvers to fetch sideband
> activity information on a USB host controller.
> 
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> ---
>  drivers/usb/host/Kconfig          | 11 +++++++++
>  drivers/usb/host/xhci-sideband.c  | 38 +++++++++++++++++++++++++++++++
>  include/linux/usb/xhci-sideband.h |  9 ++++++++
>  3 files changed, 58 insertions(+)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 109100cc77a3..49b9cdc11298 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -113,6 +113,17 @@ config USB_XHCI_SIDEBAND
>  	  xHCI USB endpoints directly, allowing CPU to sleep while playing
>  	  audio.
>  
> +config USB_XHCI_SIDEBAND_SUSPEND
> +	  bool "xHCI support for sideband during system suspend"
> +	  depends on USB_XHCI_SIDEBAND
> +	  depends on USB_XHCI_PLATFORM
> +	  depends on SUSPEND
> +	  help
> +	    Say 'Y' to enable the support for the xHCI sideband capability
> +	    after system suspended. In addition to USB_XHCI_SIDEBAND, this
> +	    config allows endpoints and interrupters associated with the
> +	    sideband function when system is suspended.

Again, why is a new config option needed here?  Why can't we just use
the existing one?  Why would you ever want one and not the other?


> +
>  config USB_XHCI_TEGRA
>  	tristate "xHCI support for NVIDIA Tegra SoCs"
>  	depends on PHY_TEGRA_XUSB
> diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
> index d49f9886dd84..15d72c23c0e0 100644
> --- a/drivers/usb/host/xhci-sideband.c
> +++ b/drivers/usb/host/xhci-sideband.c
> @@ -266,6 +266,33 @@ xhci_sideband_get_event_buffer(struct xhci_sideband *sb)
>  }
>  EXPORT_SYMBOL_GPL(xhci_sideband_get_event_buffer);
>  
> +#if IS_ENABLED(CONFIG_USB_XHCI_SIDEBAND_SUSPEND)
> +/**
> + * xhci_sideband_check - check the existence of active sidebands
> + * @hcd: the host controller driver associated with the target host controller
> + *
> + * Allow other drivers, such as usb controller driver, to check if there are
> + * any sideband activity on the host controller. This information could be used
> + * for power management or other forms of resource management. The caller should
> + * ensure downstream usb devices are all either suspended or marked as
> + * "offload_at_suspend" to ensure the correctness of the return value.
> + *
> + * Returns true on any active sideband existence, false otherwise.
> + */
> +bool xhci_sideband_check(struct usb_hcd *hcd)
> +{
> +	struct usb_device *udev = hcd->self.root_hub;
> +	bool active;
> +
> +	usb_lock_device(udev);
> +	active = usb_offload_check(udev);
> +	usb_unlock_device(udev);
> +
> +	return active;
> +}
> +EXPORT_SYMBOL_GPL(xhci_sideband_check);
> +#endif /* IS_ENABLED(CONFIG_USB_XHCI_SIDEBAND_SUSPEND) */

#ifdef in .c files is generally not a good idea, is it really needed
here?  Maybe it is, it's hard to unwind...

thanks,

greg k-h

