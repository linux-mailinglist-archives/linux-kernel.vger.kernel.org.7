Return-Path: <linux-kernel+bounces-766896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D34D3B24C69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990CA7BD808
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AFF2EBDC6;
	Wed, 13 Aug 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cNuQsrcH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D32D7395;
	Wed, 13 Aug 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096602; cv=none; b=ls+Fux2/S4P5WmxJU4bHocoVeCifinZDXkeZ0G5Eq3rljlhniv2HuosQqsG2YBgW8HN85JEsCARx3fgYesSRlePpQdst9YqpqU/yC51/tb6aWKJYkRp9qe2YBB/fUGWiOKsLeLGWaPWawpGWelnYVHFnyAEggDlCCDmlgr82d/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096602; c=relaxed/simple;
	bh=IKd79XSfYGYNJK3qu4xBaxWtMjaCoeER7z8B0Tnv+34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jikviEPKKdLabEcQBUY31SryDouaBDqQEtAATLsLrEsUxhvN5PYszmqAbOTp+hiB/vQJ3bPmh5PRIrVIZfipzzyPgBJ+6wPbojGg16kSYiNnAgl6csj7gyA5SPVbEl2m/ULsfZTiE+yzAGtt9frTmgpPub6NrkrKez0v8KK9kl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cNuQsrcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55D9C4CEEB;
	Wed, 13 Aug 2025 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755096601;
	bh=IKd79XSfYGYNJK3qu4xBaxWtMjaCoeER7z8B0Tnv+34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNuQsrcHD5VGQ+uByKxbvwmEZyCgKCmWumBJDT0EGv2CiEyL2RVSFLIM385uIr8wm
	 pD0TB2dOWQ5I0WXMZ4q6Oj+EkJfcuuiwxrw+Ji1ZpfFb40sP2hEinKXJoxHRGicKD+
	 2cj+PlTRIiVjqmywuneewZPQT7ExldINaqUH5iJU=
Date: Wed, 13 Aug 2025 16:49:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: mathias.nyman@intel.com, hannelotta@gmail.com,
	zijun.hu@oss.qualcomm.com, xu.yang_2@nxp.com,
	stern@rowland.harvard.edu, andriy.shevchenko@linux.intel.com,
	ben@decadent.org.uk, quic_wcheng@quicinc.com,
	krzysztof.kozlowski@linaro.org, dh10.jung@samsung.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 2/4] usb: offload: add apis for offload usage tracking
Message-ID: <2025081326-guileless-lego-ec59@gregkh>
References: <20250801034004.3314737-1-guanyulin@google.com>
 <20250801034004.3314737-3-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801034004.3314737-3-guanyulin@google.com>

On Fri, Aug 01, 2025 at 03:39:31AM +0000, Guan-Yu Lin wrote:
> Introduce offload_usage and corresponding apis to track offload usage
> on each USB device. Offload denotes that there is another co-processor
> accessing the USB device via the same USB host controller. To optimize
> power usage, it's essential to monitor whether the USB device is
> actively used by other co-processor. This information is vital when
> determining if a USB device can be safely suspended during system power
> state transitions.
> 
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> ---
>  drivers/usb/core/Kconfig   |  10 +++
>  drivers/usb/core/Makefile  |   1 +
>  drivers/usb/core/offload.c | 136 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/core/usb.c     |   1 +
>  include/linux/usb.h        |  18 +++++
>  5 files changed, 166 insertions(+)
>  create mode 100644 drivers/usb/core/offload.c
> 
> diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
> index 58e3ca7e4793..d5d38657f929 100644
> --- a/drivers/usb/core/Kconfig
> +++ b/drivers/usb/core/Kconfig
> @@ -143,3 +143,13 @@ config USB_DEFAULT_AUTHORIZATION_MODE
>  	  ACPI selecting value 2 is analogous to selecting value 0.
>  
>  	  If unsure, keep the default value.
> +
> +config USB_OFFLOAD
> +	bool "Enable USB offload feature"

I'm confused, we already have a "USB offload feature" that went into the
last kernel release, why do we need a separate config option for this as
well?  Shouldn't this code only get built if the drivers that need it
select it automatically?  Forcing distros to configure this isn't
generally a good idea if at all possible.


> +	depends on USB
> +	depends on USB_XHCI_SIDEBAND_SUSPEND
> +	help
> +	  Offload denotes that there is another co-processor accessing the
> +	  USB device via the same USB host controller, creating the
> +	  "offloaded USB transfers". Say Y to allow offloaded USB
> +	  transfers during system sleep (Suspend-to-RAM).

Especially because all "desktops" do not want this code selected, so
having it in all distros feels like a waste to me.

thanks,

greg k-h

