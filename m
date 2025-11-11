Return-Path: <linux-kernel+bounces-895526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ACFC4E355
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA4C3AC7CC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4065B342506;
	Tue, 11 Nov 2025 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sc3RuWAb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4627D331229;
	Tue, 11 Nov 2025 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868490; cv=none; b=FbWUBBHv1Yd+2d03tnOxol0IgeY7v1TSU7A6d7z9jxph8+R/VWBdB1V4GUvupnmt2JCj6/A+8MXW+IIkkkz8z11k3X5pYdJQu8/CGjZCvy5dkLZwL7T3i+O1UF8YgyH5RTMUGDNKbTfjiUo9/caCGYwV78Dd5FyszpI8rqqCb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868490; c=relaxed/simple;
	bh=vdt4eEniWQ6G5tvEkGqmg4Yt5wxYS0asG/VShfWg9Zw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lMVzD11GdVl5wkVGHeZGDZj/rdWtNouBfdp2dCo5Q1wnpsklROIwg7X6DNIeYJTbPcfMkwYM0yY9DCYaT0ZqBrJ9Tx+15mKutYLbBBBuKfD/i8/aIVv0CJAXU2CRt6fdbz3GH4PfYNAf7krmqvT2WKS3+F67gSHzZrldpfR4oDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sc3RuWAb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762868488; x=1794404488;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vdt4eEniWQ6G5tvEkGqmg4Yt5wxYS0asG/VShfWg9Zw=;
  b=Sc3RuWAbZEOF8uT2+d2wCp4SPvnuTdtDeHsq7a3yOkPV/RgwD5Nc1j/m
   LobJJQC4Z4fl8y08iQ9zX5XMoJMkvfI8xPT2lzPkUNIcKw72gZiP8s9T8
   gRcXdAZyF+k+yaifmIAG9q2IEL1zk+msYZQ36Bu33sU2CRUQVDMcoFrp7
   eMUiHsncgR4mlGFRP/BRwS+/A2drVt37eM0UpTPY+kED1p8Ah4Sl+SEJh
   PpHMXipuj/38Lb7tTEvqw6IIpbP4tMuZbVgflAuKp0vsYrZwWPdnZLSLh
   q6Fcp/3dN9JLzbaKymKnsCIXh3O+P3pkVb8nSZNRugsgKk5ceVDasEnPt
   w==;
X-CSE-ConnectionGUID: prS+p5g+RmKt86kEp725bg==
X-CSE-MsgGUID: 48fJ7igLTdy+KpvKYTzgRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64969587"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="64969587"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 05:41:27 -0800
X-CSE-ConnectionGUID: h65u1Nz+TKSismXQpctPDg==
X-CSE-MsgGUID: zEpZ/kokSP+pPfBxx9mU3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="189225225"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.132])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 05:41:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 11 Nov 2025 15:41:19 +0200 (EET)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
    Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v4 4/6] platform/x86: ayaneo-ec: Add controller power
 and modules attributes
In-Reply-To: <20251110180846.1490726-5-lkml@antheas.dev>
Message-ID: <888ff0d3-c613-b5a7-3b84-37ff3036e0a4@linux.intel.com>
References: <20251110180846.1490726-1-lkml@antheas.dev> <20251110180846.1490726-5-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 10 Nov 2025, Antheas Kapenekakis wrote:

> The Ayaneo 3 features hot-swappable controller modules. The ejection
> and management is done through HID. However, after ejecting the modules,
> the controller needs to be power cycled via the EC to re-initialize.
> 
> For this, the EC provides a variable that holds whether the left or
> right modules are connected, and a power control register to turn
> the controller on or off. After ejecting the modules, the controller
> should be turned off. Then, after both modules are reinserted,
> the controller may be powered on again to re-initialize.
> 
> This patch introduces two new sysfs attributes:
>  - `controller_modules`: a read-only attribute that indicates whether
>    the left and right modules are connected (none, left, right, both).
>  - `controller_power`: a read-write attribute that allows the user
>    to turn the controller on or off (with '1'/'0').
> 
> Therefore, after ejection is complete, userspace can power off the
> controller, then wait until both modules have been reinserted
> (`controller_modules` will return 'both') to turn on the controller.
> 
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  .../ABI/testing/sysfs-platform-ayaneo-ec      |  19 ++++
>  MAINTAINERS                                   |   1 +
>  drivers/platform/x86/ayaneo-ec.c              | 106 ++++++++++++++++++
>  3 files changed, 126 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo-ec b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> new file mode 100644
> index 000000000000..4cffbf5fc7ca
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> @@ -0,0 +1,19 @@
> +What:		/sys/devices/platform/ayaneo-ec/controller_power
> +Date:		Nov 2025
> +KernelVersion:	6.19
> +Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
> +Description:
> +		Current controller power state. Allows turning on and off
> +		the controller power (e.g. for power savings). Write 1 to
> +		turn on, 0 to turn off. File is readable and writable.
> +
> +What:		/sys/devices/platform/ayaneo-ec/controller_modules
> +Date:		Nov 2025
> +KernelVersion:	6.19
> +Contact:	"Antheas Kapenekakis"  <lkml@antheas.dev>
> +Description:
> +		Shows which controller modules are currently connected to
> +		the device. Possible values are "left", "right" and "both".
> +		File is read-only. The Windows software for this device
> +		will only set controller power to 1 if both module sides
> +		are connected (i.e. this file returns "both").
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c5bf7207c45f..f8ab009b6224 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4196,6 +4196,7 @@ AYANEO PLATFORM EC DRIVER
>  M:	Antheas Kapenekakis <lkml@antheas.dev>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-platform-ayaneo
>  F:	drivers/platform/x86/ayaneo-ec.c
>  
>  AZ6007 DVB DRIVER
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> index 697bb053a7d6..0652c044ad76 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/bits.h>
>  #include <linux/dmi.h>
>  #include <linux/err.h>
>  #include <linux/hwmon.h>
> @@ -16,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
> +#include <linux/sysfs.h>
>  #include <acpi/battery.h>
>  
>  #define AYANEO_PWM_ENABLE_REG	 0x4A
> @@ -32,9 +34,17 @@
>  #define AYANEO_CHARGE_VAL_AUTO		0xaa
>  #define AYANEO_CHARGE_VAL_INHIBIT	0x55
>  
> +#define AYANEO_POWER_REG	0x2d
> +#define AYANEO_POWER_OFF	0xfe
> +#define AYANEO_POWER_ON		0xff
> +#define AYANEO_MODULE_REG	0x2f
> +#define AYANEO_MODULE_LEFT	BIT(0)
> +#define AYANEO_MODULE_RIGHT	BIT(1)
> +
>  struct ayaneo_ec_quirk {
>  	bool has_fan_control;
>  	bool has_charge_control;
> +	bool has_magic_modules;
>  };
>  
>  struct ayaneo_ec_platform_data {
> @@ -46,6 +56,7 @@ struct ayaneo_ec_platform_data {
>  static const struct ayaneo_ec_quirk quirk_ayaneo3 = {
>  	.has_fan_control = true,
>  	.has_charge_control = true,
> +	.has_magic_modules = true,
>  };
>  
>  static const struct dmi_system_id dmi_table[] = {
> @@ -266,6 +277,100 @@ static int ayaneo_remove_battery(struct power_supply *battery,
>  	return 0;
>  }
>  
> +static ssize_t controller_power_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf,
> +				      size_t count)
> +{
> +	bool value;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &value);
> +	if (ret)
> +		return ret;
> +
> +	ret = ec_write(AYANEO_POWER_REG, value ? AYANEO_POWER_ON : AYANEO_POWER_OFF);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t controller_power_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	int ret;
> +	u8 val;
> +
> +	ret = ec_read(AYANEO_POWER_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", val == AYANEO_POWER_ON);
> +}
> +
> +static DEVICE_ATTR_RW(controller_power);
> +
> +static ssize_t controller_modules_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	char *out;
> +	int ret;
> +	u8 val;
> +
> +	ret = ec_read(AYANEO_MODULE_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	switch (~val & (AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT)) {

This too is constructing mask still here which is ugly.

> +	case AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT:
> +		out = "both";
> +		break;
> +	case AYANEO_MODULE_LEFT:
> +		out = "left";
> +		break;
> +	case AYANEO_MODULE_RIGHT:
> +		out = "right";
> +		break;
> +	default:
> +		out = "none";
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%s\n", out);
> +}
> +
> +static DEVICE_ATTR_RO(controller_modules);
> +
> +static struct attribute *aya_mm_attrs[] = {
> +	&dev_attr_controller_power.attr,
> +	&dev_attr_controller_modules.attr,
> +	NULL
> +};
> +
> +static umode_t aya_mm_is_visible(struct kobject *kobj,
> +				 struct attribute *attr, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> +
> +	if (data->quirks->has_magic_modules)
> +		return attr->mode;
> +	return 0;
> +}
> +
> +static const struct attribute_group aya_mm_attribute_group = {
> +	.is_visible = aya_mm_is_visible,
> +	.attrs = aya_mm_attrs,
> +};
> +
> +static const struct attribute_group *ayaneo_ec_groups[] = {
> +	&aya_mm_attribute_group,
> +	NULL
> +};
> +
>  static int ayaneo_ec_probe(struct platform_device *pdev)
>  {
>  	const struct dmi_system_id *dmi_entry;
> @@ -307,6 +412,7 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
>  static struct platform_driver ayaneo_platform_driver = {
>  	.driver = {
>  		.name = "ayaneo-ec",
> +		.dev_groups = ayaneo_ec_groups,
>  	},
>  	.probe = ayaneo_ec_probe,
>  };
> 

-- 
 i.


