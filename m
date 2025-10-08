Return-Path: <linux-kernel+bounces-845393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350DFBC4B77
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5C03AC89A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BB32F83BA;
	Wed,  8 Oct 2025 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/qBddYg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7A42F7AB0;
	Wed,  8 Oct 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925428; cv=none; b=hkHnusiUCIiMkdEy+IxuBY5GULidzL3wbsY4zBimhbBcXpVu/4L4s+95I9h4f17NG9J+L/2YPsGllinffLElItQ+GpK8oXpFXxID5lfyU20FbC0czWFXXDv/L4RAOwW/PWD7XiFB+iIARybKulyTRn2qvpnEuUL12nCFIoB/nlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925428; c=relaxed/simple;
	bh=0Og/Yv2H3UYrtZ3KU1pRcOJr3otOKEz6cpop2r3nnpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtAg9QJJ9b/7gnEGwIEdy4UwVEGnZGYoGLRb20isOw+rD1zttpBO67qKzDVVzOOx73KpZKcL5hygiwVw+72E721zRp+GDNV6cWLXs0wRKcrn+O2x5/RXYbbyz7DWQBppuuKoNB1biG2NnJ2lkbW4C1cVGq/bAZrIeLnMBJEpwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/qBddYg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759925426; x=1791461426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Og/Yv2H3UYrtZ3KU1pRcOJr3otOKEz6cpop2r3nnpQ=;
  b=c/qBddYgIFGWzgi+bs38ApCZwKzmM5ffY5kvOJ5J9OOq04yC+xirEPPY
   wvPRnJsmggpkg0G/NtVcKHrNhktQczwUP4IDMUw4WrAF34wSdM9G/vLWQ
   Td77MTCW3L+wK1jmSIwJEe5TxBztZzNTq212OVOHM0D6q3suM8r0Qkn1M
   st1T9IMs9nst4aTmswwjouPCu/AsMS20tLVR4iYUJIox2Atq09qGhK8AB
   K6IWyc9iPeUGja2+LLuG0i7eUI7F2yRyL5tS0K5IJWaDO605WY0qMTlyn
   PGzPP0oP/07ZgNP7XINXO+3AYdLt8mlXILSLIiSjBO69GNIcRvJQrEEdP
   A==;
X-CSE-ConnectionGUID: tfQ7bzsZTv2lz1Gh5z9eIQ==
X-CSE-MsgGUID: AkItbHQiQSmPos4mxodoKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72375319"
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="72375319"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 05:10:25 -0700
X-CSE-ConnectionGUID: zCMM01epQqOAsrjnyC85Fg==
X-CSE-MsgGUID: wflDQcoZR7+Y2QBt5yi1Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="211370462"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.169])
  by fmviesa001.fm.intel.com with SMTP; 08 Oct 2025 05:10:20 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Oct 2025 15:10:19 +0300
Date: Wed, 8 Oct 2025 15:10:19 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, abhishekpandit@chromium.org,
	krzk+dt@kernel.org, robh@kernel.org, bleung@chromium.org,
	ukaszb@chromium.org, tzungbi@kernel.org, devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mfd: cros_ec: Don't add cros_ec_ucsi if it is
 defined in OF or ACPI
Message-ID: <aOZUq6K8bZtciL6Q@kuha.fi.intel.com>
References: <20251001193346.1724998-1-jthies@google.com>
 <20251001193346.1724998-4-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001193346.1724998-4-jthies@google.com>

On Wed, Oct 01, 2025 at 07:33:43PM +0000, Jameson Thies wrote:
> On devices with a UCSI PPM in the EC, check for cros_ec_ucsi to be
> defined in the OF device tree or an ACPI node. If it is defined by
> either OF or ACPI, it does not need to be added as a subdevice of
> cros_ec_dev.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
>  drivers/mfd/cros_ec_dev.c | 40 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index dc80a272726b..b0523f6541d2 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2014 Google, Inc.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/dmi.h>
>  #include <linux/kconfig.h>
>  #include <linux/mfd/core.h>
> @@ -131,11 +132,6 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
>  		.mfd_cells	= cros_ec_rtc_cells,
>  		.num_cells	= ARRAY_SIZE(cros_ec_rtc_cells),
>  	},
> -	{
> -		.id		= EC_FEATURE_UCSI_PPM,
> -		.mfd_cells	= cros_ec_ucsi_cells,
> -		.num_cells	= ARRAY_SIZE(cros_ec_ucsi_cells),
> -	},
>  	{
>  		.id		= EC_FEATURE_HANG_DETECT,
>  		.mfd_cells	= cros_ec_wdt_cells,
> @@ -177,6 +173,16 @@ static const struct mfd_cell cros_ec_vbc_cells[] = {
>  	{ .name = "cros-ec-vbc", }
>  };
>  
> +static int ucsi_acpi_match(struct device *dev, const void *data)
> +{
> +	struct acpi_device_id ucsi_acpi_device_ids[] = {
> +		{ "GOOG0021", 0 },
> +		{"", 0},
> +	};
> +	return !!acpi_match_device(ucsi_acpi_device_ids, dev);
> +}
> +
> +
>  static void cros_ec_class_release(struct device *dev)
>  {
>  	kfree(to_cros_ec_dev(dev));
> @@ -264,6 +270,30 @@ static int ec_device_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/*
> +	 * FW nodes can load cros_ec_ucsi, but early PDC devices did not define
> +	 * the required nodes. On PDC systems without FW nodes for cros_ec_ucsi,
> +	 * the driver should be added as an mfd subdevice.
> +	 */
> +	if (cros_ec_check_features(ec, EC_FEATURE_USB_PD) &&
> +	    cros_ec_check_features(ec, EC_FEATURE_UCSI_PPM)) {
> +		struct device *acpi_dev = device_find_child(ec->ec_dev->dev,
> +							    NULL,
> +							    ucsi_acpi_match);
> +
> +		if (!!acpi_dev) {
> +			put_device(acpi_dev);

If you are not using that for anything, then couldn't you just use
acpi_dev_found("GOOG0021") ?

Can there be multiple UCSI interfaces on these systems?

thanks,

> +		} else if (!of_find_compatible_node(NULL, NULL,
> +						    "google,cros-ec-ucsi")) {
> +			retval = mfd_add_hotplug_devices(
> +				ec->dev, cros_ec_ucsi_cells,
> +				ARRAY_SIZE(cros_ec_ucsi_cells));
> +			if (retval)
> +				dev_warn(ec->dev,
> +				    "failed to add cros_ec_ucsi: %d\n", retval);
> +		}
> +	}
> +
>  	/*
>  	 * UCSI provides power supply information so we don't need to separately
>  	 * load the cros_usbpd_charger driver.
> -- 
> 2.51.0.618.g983fd99d29-goog

-- 
heikki

