Return-Path: <linux-kernel+bounces-893157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D567EC46A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81A6D3483D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC1E30E0F7;
	Mon, 10 Nov 2025 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjWFX7zL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3B30C361;
	Mon, 10 Nov 2025 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778436; cv=none; b=MbxkwL2FAnihRSMOxO4uWTab9HO4078j8gI2aW9fSQDdvVGn16nOcyLKX/cHbnOvXI3UWGQTx98yNLAiWsnkDr+NTOaHbhfsWSc4mSLIXK1uq4m1Y8u0LD8zg7sO57hCD8Y0yNiou4Flb+bETiAJddrRLj4rQE/pFxPBTPzQiCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778436; c=relaxed/simple;
	bh=o5s6iOHGuFplHT4BVEmvNUwBVxn0U3ZG8rddqsXhE2w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DbqGUCNpPrOiV97Yk86aGJtWc54l3zBT7oqqw6wveiGKEAF+snklGFF4gaSgoNHomrdqPgzF9XREuBKylcKJ7nfph49o7f4pBl+Gn69bnf+7lcCvW8r6qWlEocx+ptIIV9MhlQU+NQhr67SFy8Lvt8K28F2Gm8Q572v3MKwr/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjWFX7zL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762778435; x=1794314435;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=o5s6iOHGuFplHT4BVEmvNUwBVxn0U3ZG8rddqsXhE2w=;
  b=jjWFX7zL8oTQ7Hesv7CLjQAeDS774dMrzuY+jqL72eFxSN54zm8B7/8P
   C4Nu4w0iaQpcrSz12xZXb/2htYLqeR71uFnjs5UfbuGeLdn/Im4Zj5liF
   tGArtMDCaNnXJcVRyMKVOc9xKu+FAMT9QfDXTRn5/Dr+RpLBHIR0WZq7i
   HRE8H/EDBJHxEzwg0OycKoVJ/akckg8KBWK3q/J+fNJwT50wH97cex38P
   tGGm7duDEIX3B7IMUXNxZkkFsPr6teyORc0AYr9Vk+PBBszJzwz4L3qmZ
   suVnCz+IjvfcduKarrV+GA+PMdeABtJQNDbU4zs12q08yh+osQCHSxOQ+
   A==;
X-CSE-ConnectionGUID: VEojoamET/iGVhtzXpP+hQ==
X-CSE-MsgGUID: CYET8PXQT3C0KIMaxSy6Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="68469260"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="68469260"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:40:35 -0800
X-CSE-ConnectionGUID: aDqJRHSXQseGdVu2Nirjww==
X-CSE-MsgGUID: dhmiP5ImSk21p6AZCrYnqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="219318608"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:40:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Nov 2025 14:40:27 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, lkml@antheas.dev
Subject: Re: [PATCH 1/2] platform/x86: msi-wmi-platform: Only load on MSI
 devices
In-Reply-To: <20251110111253.16204-2-W_Armin@gmx.de>
Message-ID: <3014ce29-a707-2d77-71e6-11a631221804@linux.intel.com>
References: <20251110111253.16204-1-W_Armin@gmx.de> <20251110111253.16204-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 10 Nov 2025, Armin Wolf wrote:

> It turns out that the GUID used by the msi-wmi-platform driver
> (ABBC0F60-8EA1-11D1-00A0-C90629100000) is not unique, but was instead
> copied from the WIndows Driver Samples. This means that this driver
> could load on devices from other manufacturers that also copied this
> GUID, potentially causing hardware errors.

How unclever of them to copy-paste an unique identifier from an example...

I've applied this series to the review-ilpo-fixes branch.

> Prevent this by only loading on devices whitelisted via DMI. The DMI
> matches where taken from the msi-ec driver.
> 
> Fixes: 9c0beb6b29e7 ("platform/x86: wmi: Add MSI WMI Platform driver")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/Kconfig            |  1 +
>  drivers/platform/x86/msi-wmi-platform.c | 41 ++++++++++++++++++++++++-
>  2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 46e62feeda3c..d96728a0f18d 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -545,6 +545,7 @@ config MSI_WMI
>  config MSI_WMI_PLATFORM
>  	tristate "MSI WMI Platform features"
>  	depends on ACPI_WMI
> +	depends on DMI
>  	depends on HWMON
>  	help
>  	  Say Y here if you want to have support for WMI-based platform features
> diff --git a/drivers/platform/x86/msi-wmi-platform.c b/drivers/platform/x86/msi-wmi-platform.c
> index dc5e9878cb68..bd2687828a2e 100644
> --- a/drivers/platform/x86/msi-wmi-platform.c
> +++ b/drivers/platform/x86/msi-wmi-platform.c
> @@ -14,6 +14,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/device/driver.h>
> +#include <linux/dmi.h>
>  #include <linux/errno.h>
>  #include <linux/hwmon.h>
>  #include <linux/kernel.h>
> @@ -448,7 +449,45 @@ static struct wmi_driver msi_wmi_platform_driver = {
>  	.probe = msi_wmi_platform_probe,
>  	.no_singleton = true,
>  };
> -module_wmi_driver(msi_wmi_platform_driver);
> +
> +/*
> + * MSI reused the WMI GUID from the WMI-ACPI sample code provided by Microsoft,
> + * so other manufacturers might use it as well for their WMI-ACPI implementations.
> + */
> +static const struct dmi_system_id msi_wmi_platform_whitelist[] __initconst = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "MICRO-STAR INT"),
> +		},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International"),
> +		},
> +	},
> +	{ }
> +};
> +
> +static int __init msi_wmi_platform_module_init(void)
> +{
> +	if (!dmi_check_system(msi_wmi_platform_whitelist)) {
> +		if (!force)
> +			return -ENODEV;
> +
> +		pr_warn("Ignoring DMI whitelist\n");
> +	}
> +
> +	return wmi_driver_register(&msi_wmi_platform_driver);
> +}
> +
> +static void __exit msi_wmi_platform_module_exit(void)
> +{
> +	wmi_driver_unregister(&msi_wmi_platform_driver);
> +}
> +
> +module_init(msi_wmi_platform_module_init);
> +module_exit(msi_wmi_platform_module_exit);
> +
>  
>  MODULE_AUTHOR("Armin Wolf <W_Armin@gmx.de>");
>  MODULE_DESCRIPTION("MSI WMI platform features");
> 

-- 
 i.


