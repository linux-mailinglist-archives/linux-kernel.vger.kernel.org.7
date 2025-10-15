Return-Path: <linux-kernel+bounces-854124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 091DABDD99D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424E319A6106
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEB630AAD6;
	Wed, 15 Oct 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6RQXwVK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5642C235F;
	Wed, 15 Oct 2025 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519134; cv=none; b=ZCflFMVGRRIjqc4/T6jEkNiOb+PCJBYWIl1DJp8T6uEwqH3+mgZmEFBouMhbZvUkEHdKVCcOHcJ5W9OkXgZW0h2bZsQM/ftxJu4ZdbfYBjsZc7ldWYZOoccvhPBa+7jRbprTok09gcAg3+Xc28dyL9L0qXF47AERwD6G5QfWop4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519134; c=relaxed/simple;
	bh=ubEEufVnWuSQm0LGTyGQ86YiBsw1/5sOVCuzEyDvrC4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cOZ1MCvpNyK4xYAZudG89cPGvlKIskKCbtS6g2gkVeWyzJYm767JDtwF4Y63PaEUeGqGqR5c7XsnwkDRIpDd/+POiyE8NPUDAFsakJeBi+UpT77GjXSfeMhB88YYMtRUZN/uzCaDROd0+nDjIp05xjRTbAjsKTOMfBGgXJDwLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6RQXwVK; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760519132; x=1792055132;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ubEEufVnWuSQm0LGTyGQ86YiBsw1/5sOVCuzEyDvrC4=;
  b=Z6RQXwVKldwNlA/DYXvZFAvrVMaHjGuQ+CoUAjwNdAxICtENh/snC54f
   dCyP7O9ztv/Yi4e5BxRe/nYLD7edNLlUtW/khuNrgBnfGZzUOdR0VTvHv
   NC4XWQlmOi0DPNAPAPVijndG2EIdyR3+rF2SO7IJ9uafRj6k0uPIQLjKx
   Ka+KD/+J6BgZcnk/42Vxve2uZIDRSSfZ2AqM3w67D6wWfnVKdSn34aXR5
   ZaDEdDzB/zzw7l15oXP3fZDqlJ2aAUXdFL4/d9vhfSJyIvnYOvmxP3MHX
   bYiTXiUlSdnjZmFlOJiu+h4dtOgc0CI3UlNoTBPkiX3GdusSBkfei0mZX
   w==;
X-CSE-ConnectionGUID: CfxyjWHAQmu6ag06XNTQxA==
X-CSE-MsgGUID: gBNjuT0zTAaVO9isAf6xCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61896291"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61896291"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:05:32 -0700
X-CSE-ConnectionGUID: tXbBDd9ATSSxRn/mlMAx+w==
X-CSE-MsgGUID: D8iNAAdjTJC2Ig8wSqm/CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="181681390"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:05:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 15 Oct 2025 12:05:24 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 4/6] platform/x86: ayaneo-ec: Add controller power
 and modules attributes
In-Reply-To: <20251015084414.1391595-5-lkml@antheas.dev>
Message-ID: <9c482e01-88be-af7e-8a73-1e07b8781354@linux.intel.com>
References: <20251015084414.1391595-1-lkml@antheas.dev> <20251015084414.1391595-5-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Oct 2025, Antheas Kapenekakis wrote:

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
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  .../ABI/testing/sysfs-platform-ayaneo         |  19 ++++
>  MAINTAINERS                                   |   1 +
>  drivers/platform/x86/ayaneo-ec.c              | 100 ++++++++++++++++++
>  3 files changed, 120 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo b/Documentation/ABI/testing/sysfs-platform-ayaneo
> new file mode 100644
> index 000000000000..1fa32ba60fd0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-ayaneo
> @@ -0,0 +1,19 @@
> +What:		/sys/devices/platform/<platform>/controller_power
> +Date:		Oct 2025
> +KernelVersion:	6.9
> +Contact:	"Antheas Kapenekakis" <lkml@antheas.dev>
> +Description:
> +		Current controller power state. Allows turning on and off
> +		the controller power (e.g. for power savings). Write 1 to
> +		turn on, 0 to turn off. File is readable and writable.
> +
> +What:		/sys/devices/platform/<platform>/controller_modules
> +Date:		Oct 2025
> +KernelVersion:	6.9
> +Contact:	"Antheas Kapenekakis"  <lkml@antheas.dev>
> +Description:
> +		Shows which controller modules are currently connected to
> +		the device. Possible values are "left", "right" and "both".
> +		File is read-only. The Windows software for this device
> +		will only set controller power to 1 if both module sides
> +		are connected (i.e. this file returns "both").
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c4d0c26ca77..3dfa004555dd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4191,6 +4191,7 @@ AYANEO PLATFORM EC DRIVER
>  M:	Antheas Kapenekakis <lkml@antheas.dev>
>  L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-platform-ayaneo
>  F:	drivers/platform/x86/ayaneo-ec.c
>  
>  AZ6007 DVB DRIVER
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> index 23c283f5eb61..363b61fc6e12 100644
> --- a/drivers/platform/x86/ayaneo-ec.c
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -30,9 +30,17 @@
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
> @@ -44,6 +52,7 @@ struct ayaneo_ec_platform_data {
>  static const struct ayaneo_ec_quirk ayaneo3 = {
>  	.has_fan_control = true,
>  	.has_charge_control = true,
> +	.has_magic_modules = true,
>  };
>  
>  static const struct dmi_system_id dmi_table[] = {
> @@ -262,6 +271,96 @@ static int ayaneo_remove_battery(struct power_supply *battery,
>  	return 0;
>  }
>  
> +static ssize_t controller_power_store(struct device *dev,
> +			    struct device_attribute *attr, const char *buf,
> +			    size_t count)
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
> +			   struct device_attribute *attr, char *buf)
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
> +	bool left, right;
> +	char *out;
> +	int ret;
> +	u8 val;
> +
> +	ret = ec_read(AYANEO_MODULE_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	left = !(val & AYANEO_MODULE_LEFT);
> +	right = !(val & AYANEO_MODULE_RIGHT);
> +
> +	if (left && right)
> +		out = "both";
> +	else if (left)
> +		out = "left";
> +	else if (right)
> +		out = "right";
> +	else
> +		out = "none";

I suggest using switch/case for this so you don't need the internal 
booleans at all.

BTW, I appreciate it very much this series is split per feature, it's so 
much less daunting to start a review when I know I can actually finish 
before the next interruption (and having to flush context from my
mind). :-)

-- 
 i.


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
> @@ -303,6 +402,7 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
>  static struct platform_driver ayaneo_platform_driver = {
>  	.driver = {
>  		.name = "ayaneo-ec",
> +		.dev_groups = ayaneo_ec_groups,
>  	},
>  	.probe = ayaneo_ec_probe,
>  };
> 

