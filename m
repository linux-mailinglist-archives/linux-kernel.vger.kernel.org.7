Return-Path: <linux-kernel+bounces-845377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76949BC49F6
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2E11890976
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A8D2F7ACC;
	Wed,  8 Oct 2025 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCskzSUU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F42F1FC3;
	Wed,  8 Oct 2025 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924285; cv=none; b=hdnveIqg7vq6kz6Kh2CB8fnTZ4zlASli43NSQXhXvT+SPQVxy84f8ZpNCCmDZJgZ6qRBT4+FOq6K9stfvOWl4zj1fUn5Z9WU8mv9jCkkaDt35AA1AIyZnv1sYU3aVseyLkIp3hGsDXRWuMsWADy4i+nTwYkRtCIM45eLwFtIGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924285; c=relaxed/simple;
	bh=ryM31503eMXvR81ecjmrnqZ+pmjpuK2RFkfc0Ve3/Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTt0dL/2c239BPWFBHiXRgO56I3vPDFGTwxSJ6mZBa1QBjcDYyNNktsxKHmUneZDw265X5LMA5QP5OyMMgTMydCdTjGXLlZ1nJzJlVoMqgRRCV82twiMINwo9pPyGQW4A99O+N/TAF52nq29nUV3rEZy3MWwY6IyVpCUeBvEh8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCskzSUU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759924283; x=1791460283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ryM31503eMXvR81ecjmrnqZ+pmjpuK2RFkfc0Ve3/Hg=;
  b=mCskzSUU0eSmbldZjkfhpRfHhB7pSlBM2Q64Ext3mSc0NYgdtJLJSLrp
   h7HL/wCWZyZOw0rGONBegAK/n0G8D97e5LY416jE/pMTVMyXSUNktpocG
   0YwtrztRsi+dAUp6Jd2YLBs55LPJjTTcbhiWE5lLWC0Wa+CCUTZYqlefG
   JnBcWbQhsNIjdCbaIhHeysKVtL7a/lswSG07cmUCkkoyXzXXFCYJlg17t
   zosvN8T+ZTOXQODPfZtwWNxQTHuvGheLqOOupwCkbWjrxelhuA9PzGGDt
   M7JSpLcfho3OBpYWtj8rm6Zk2wC+iDu9mFzBT2mk0UGxWNsu+VSiXO0Xp
   A==;
X-CSE-ConnectionGUID: xgumI4T8RY+dQaE0MDZUiw==
X-CSE-MsgGUID: Yj1fq/C+Ri2bYuklKoLCRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="72373482"
X-IronPort-AV: E=Sophos;i="6.19,323,1754982000"; 
   d="scan'208";a="72373482"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 04:51:14 -0700
X-CSE-ConnectionGUID: lSwJdvgRRKaNYFeRXQJS3g==
X-CSE-MsgGUID: QEGKyH1oTsad5GTZg8HvNQ==
X-ExtLoop1: 1
Received: from iherna2-mobl4.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.169])
  by fmviesa003.fm.intel.com with SMTP; 08 Oct 2025 04:51:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 08 Oct 2025 14:51:05 +0300
Date: Wed, 8 Oct 2025 14:51:05 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, abhishekpandit@chromium.org,
	krzk+dt@kernel.org, robh@kernel.org, bleung@chromium.org,
	ukaszb@chromium.org, tzungbi@kernel.org, devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] usb: typec: cros_ec_ucsi: Load driver from OF and
 ACPI definitions
Message-ID: <aOZQKfKUpae1cSvo@kuha.fi.intel.com>
References: <20251001193346.1724998-1-jthies@google.com>
 <20251001193346.1724998-3-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001193346.1724998-3-jthies@google.com>

On Wed, Oct 01, 2025 at 07:33:42PM +0000, Jameson Thies wrote:
> Add support for cros_ec_ucsi to load based on "google,cros-ec-ucsi"
> compatible devices and "GOOG0021" ACPI nodes.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>

One nitpick below. With that sorted out:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/cros_ec_ucsi.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/cros_ec_ucsi.c b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
> index eed2a7d0ebc6..3d19560bbaa7 100644
> --- a/drivers/usb/typec/ucsi/cros_ec_ucsi.c
> +++ b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
> @@ -5,11 +5,13 @@
>   * Copyright 2024 Google LLC.
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/container_of.h>
>  #include <linux/dev_printk.h>
>  #include <linux/jiffies.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/platform_data/cros_ec_commands.h>
>  #include <linux/platform_data/cros_usbpd_notify.h>
>  #include <linux/platform_data/cros_ec_proto.h>
> @@ -235,7 +237,7 @@ static void cros_ucsi_destroy(struct cros_ucsi_data *udata)
>  static int cros_ucsi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct cros_ec_dev *ec_data = dev_get_drvdata(dev->parent);
> +	struct cros_ec_dev *ec_data;
>  	struct cros_ucsi_data *udata;
>  	int ret;
>  
> @@ -244,8 +246,13 @@ static int cros_ucsi_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	udata->dev = dev;
> +	if (is_acpi_device_node(dev->fwnode) || is_of_node(dev->fwnode)) {
> +		udata->ec = dev_get_drvdata(pdev->dev.parent);

udata->ec = dev_get_drvdata(dev->parent);

> +	} else {
> +		ec_data = dev_get_drvdata(dev->parent);
> +		udata->ec = ec_data->ec_dev;

and just as a proposal:

udata->ec = ((struct cros_ec_dev *)dev_get_drvdata(dev->parent))->ec_dev;

> +	}
> -	udata->ec = ec_data->ec_dev;
>  	if (!udata->ec)
>  		return dev_err_probe(dev, -ENODEV, "couldn't find parent EC device\n");
>  
> @@ -326,10 +333,24 @@ static const struct platform_device_id cros_ucsi_id[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, cros_ucsi_id);
>  
> +static const struct acpi_device_id cros_ec_ucsi_acpi_device_ids[] = {
> +	{ "GOOG0021", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, cros_ec_ucsi_acpi_device_ids);
> +
> +static const struct of_device_id cros_ucsi_of_match[] = {
> +	{ .compatible = "google,cros-ec-ucsi", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cros_ucsi_of_match);
> +
>  static struct platform_driver cros_ucsi_driver = {
>  	.driver = {
>  		.name = KBUILD_MODNAME,
>  		.pm = &cros_ucsi_pm_ops,
> +		.acpi_match_table = cros_ec_ucsi_acpi_device_ids,
> +		.of_match_table = cros_ucsi_of_match,
>  	},
>  	.id_table = cros_ucsi_id,
>  	.probe = cros_ucsi_probe,

thanks,

-- 
heikki

