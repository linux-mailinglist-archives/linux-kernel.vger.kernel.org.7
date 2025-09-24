Return-Path: <linux-kernel+bounces-830370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4BCB997E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EAEC3206BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9664B2E1749;
	Wed, 24 Sep 2025 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecyqf5Wz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AA14E2F2;
	Wed, 24 Sep 2025 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711136; cv=none; b=qMwnbIctIrT41QBSKR7GzS9jdrVXtcMcmVl8n46f7NwT2oYstKoKZg9zCx8VSw0DAiZ4B4PJhs1Kwm67yz8fkQGUPvaNV8eqHTN/1TB2cPB6LH7EtAXym0fupbdsR+aTv7iVQZydFMqbhlEez7B9K3xx/6ezBeSZ7E6Aqiu2UxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711136; c=relaxed/simple;
	bh=labmhPgIashUI6/F/fI+XFIKMTkkD2x6uL2O8IGsx34=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R6gOhiuQQLMMAhYc9v7mPKhqZnQlr0RJiK9hq/QpQfbXv8Zhg8jCzE7TWri3xI9GDSkKomiRfBpNzs0WxQO8R3ad6p7fBwCWS4as7j32cM7fi1PV7IIy7DIyZ8Meh19oklgz0lESl570OHLRwNnjrkzbRE62wgU7gOwh1HVHG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecyqf5Wz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758711131; x=1790247131;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=labmhPgIashUI6/F/fI+XFIKMTkkD2x6uL2O8IGsx34=;
  b=ecyqf5WzMYg3ZlcjYXuuW1D0bkIxr4TkI3QU5EhsSAQbqcY4w+BEjtAM
   e0ySnLJwcPvsdPsPj29ng7iUgfmETJFm10mGXrBVspKtXak1ZLZInA0PW
   EFiaw/35T+KrimWiLzg1X9DMLR0nX9cXE7RCQbWO7kFIBJT6Yho5efO43
   FptFBCCLz0SbFknUljGqDa3koNrmqHjpjgVWhR8I1pvqyN7tgPE52d5xI
   +oF+8dBMTDmcvR3RU9Xlcv4M2c7UEz2VFEnlgWcQW0BJrkAwv5bqiFYU3
   HeSdqzfTdlCBS/CvYsMzSW69ULmjipex/Q6FANDyfiSPya3+0CK37dBK6
   w==;
X-CSE-ConnectionGUID: 31EujAn7REa0hvRKENkCFg==
X-CSE-MsgGUID: VEmAHhBSSZWCiOqjv1sBVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60043664"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="60043664"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 03:52:10 -0700
X-CSE-ConnectionGUID: oayd8SSLQV+nWbuLIWvdgA==
X-CSE-MsgGUID: a/UK0lWxRgKS5hpVHI64HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="176843889"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.210])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 03:52:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 24 Sep 2025 13:52:03 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: jlee@suse.com, basak.sb2006@gmail.com, rayanmargham4@gmail.com, 
    kuurtb@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] platform/x86: acer-wmi: Add fan control support
In-Reply-To: <20250923215205.326367-3-W_Armin@gmx.de>
Message-ID: <3e5a0387-9850-c85e-8636-71590133117d@linux.intel.com>
References: <20250923215205.326367-1-W_Armin@gmx.de> <20250923215205.326367-3-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 23 Sep 2025, Armin Wolf wrote:

> Add support for controlling the fan speed using the
> SetGamingFanSpeed() and GetGamingFanSpeed() WMI methods.
> 
> This feature is only enabled if the machine has ACER_CAP_PWM enabled
> and depend on ACER_CAP_HWMON for detecting the number of available
> fans.
> 
> Reviewed-by: Kurt Borja <kuurtb@gmail.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/acer-wmi.c | 221 +++++++++++++++++++++++++++++++-
>  1 file changed, 219 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index a41555ee8589..345b6e24ae31 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -12,10 +12,12 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/kernel.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/dmi.h>
> +#include <linux/fixp-arith.h>
>  #include <linux/backlight.h>
>  #include <linux/leds.h>
>  #include <linux/platform_device.h>
> @@ -69,11 +71,16 @@ MODULE_LICENSE("GPL");
>  #define ACER_WMID_GET_GAMING_LED_METHODID 4
>  #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
>  #define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
> +#define ACER_WMID_GET_GAMING_FAN_BEHAVIOR_METHODID 15
> +#define ACER_WMID_SET_GAMING_FAN_SPEED_METHODID 16
> +#define ACER_WMID_GET_GAMING_FAN_SPEED_METHODID 17
>  #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
>  #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23
>  
> +#define ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK GENMASK_ULL(7, 0)
>  #define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
>  #define ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK GENMASK_ULL(23, 16)
> +#define ACER_GAMING_FAN_BEHAVIOR_GET_MODE_MASK GENMASK_ULL(23, 8)
>  
>  #define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
>  #define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
> @@ -81,6 +88,10 @@ MODULE_LICENSE("GPL");
>  #define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
>  #define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)
>  
> +#define ACER_GAMING_FAN_SPEED_STATUS_MASK GENMASK_ULL(7, 0)
> +#define ACER_GAMING_FAN_SPEED_ID_MASK GENMASK_ULL(7, 0)
> +#define ACER_GAMING_FAN_SPEED_VALUE_MASK GENMASK_ULL(15, 8)
> +
>  #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
>  #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
>  #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
> @@ -130,6 +141,11 @@ enum acer_wmi_predator_v4_sensor_id {
>  	ACER_WMID_SENSOR_GPU_TEMPERATURE	= 0x0A,
>  };
>  
> +enum acer_wmi_gaming_fan_id {
> +	ACER_WMID_CPU_FAN	= 0x01,
> +	ACER_WMID_GPU_FAN	= 0x04,
> +};

In patch 1 you added these:

+#define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
...
+#define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
+#define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)

Are these numbers related (you even called the field "ID mask")? Could we 
do with less defines for the same thing if they're related?

>  enum acer_wmi_gaming_fan_mode {
>  	ACER_WMID_FAN_MODE_AUTO		= 0x01,
>  	ACER_WMID_FAN_MODE_TURBO	= 0x02,
> @@ -292,6 +308,7 @@ struct hotkey_function_type_aa {
>  #define ACER_CAP_TURBO_FAN		BIT(9)
>  #define ACER_CAP_PLATFORM_PROFILE	BIT(10)
>  #define ACER_CAP_HWMON			BIT(11)
> +#define ACER_CAP_PWM			BIT(12)
>  
>  /*
>   * Interface type flags
> @@ -386,6 +403,7 @@ struct quirk_entry {
>  	u8 cpu_fans;
>  	u8 gpu_fans;
>  	u8 predator_v4;
> +	u8 pwm;
>  };
>  
>  static struct quirk_entry *quirks;
> @@ -405,6 +423,9 @@ static void __init set_quirks(void)
>  	if (quirks->predator_v4)
>  		interface->capability |= ACER_CAP_PLATFORM_PROFILE |
>  					 ACER_CAP_HWMON;
> +
> +	if (quirks->pwm)
> +		interface->capability |= ACER_CAP_PWM;
>  }
>  
>  static int __init dmi_matched(const struct dmi_system_id *dmi)
> @@ -1651,6 +1672,27 @@ static int WMID_gaming_set_fan_behavior(u16 fan_bitmap, u8 mode_bitmap)
>  	return 0;
>  }
>  
> +static int WMID_gaming_get_fan_behavior(u16 fan_bitmap, u8 *mode_bitmap)
> +{
> +	acpi_status status;
> +	u32 input = 0;
> +	u64 result;
> +
> +	input |= FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitmap);
> +	status = WMI_gaming_execute_u32_u64(ACER_WMID_GET_GAMING_FAN_BEHAVIOR_METHODID, input,
> +					    &result);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	/* The return status must be zero for the operation to have succeeded */
> +	if (FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK, result))
> +		return -EIO;
> +
> +	*mode_bitmap = FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_GET_MODE_MASK, result);
> +
> +	return 0;
> +}
> +
>  static void WMID_gaming_set_fan_mode(u8 fan_mode)
>  {
>  	u16 mode_bitmap = 0;
> @@ -1669,6 +1711,55 @@ static void WMID_gaming_set_fan_mode(u8 fan_mode)
>  	WMID_gaming_set_fan_behavior(fan_bitmap, mode_bitmap);
>  }
>  
> +static int WMID_gaming_set_gaming_fan_speed(u8 fan, u8 speed)
> +{
> +	acpi_status status;
> +	u64 input = 0;
> +	u64 result;
> +
> +	if (speed > 100)
> +		return -EINVAL;
> +
> +	input |= FIELD_PREP(ACER_GAMING_FAN_SPEED_ID_MASK, fan);
> +	input |= FIELD_PREP(ACER_GAMING_FAN_SPEED_VALUE_MASK, speed);
> +
> +	status = WMI_gaming_execute_u64(ACER_WMID_SET_GAMING_FAN_SPEED_METHODID, input, &result);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	switch (FIELD_GET(ACER_GAMING_FAN_SPEED_STATUS_MASK, result)) {
> +	case 0x00:
> +		return 0;
> +	case 0x01:
> +		return -ENODEV;
> +	case 0x02:
> +		return -EINVAL;
> +	default:
> +		return -ENXIO;
> +	}
> +}
> +
> +static int WMID_gaming_get_gaming_fan_speed(u8 fan, u8 *speed)
> +{
> +	acpi_status status;
> +	u32 input = 0;
> +	u64 result;
> +
> +	input |= FIELD_PREP(ACER_GAMING_FAN_SPEED_ID_MASK, fan);
> +
> +	status = WMI_gaming_execute_u32_u64(ACER_WMID_GET_GAMING_FAN_SPEED_METHODID, input,
> +					    &result);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	if (FIELD_GET(ACER_GAMING_FAN_SPEED_STATUS_MASK, result))
> +		return -ENODEV;
> +
> +	*speed = FIELD_GET(ACER_GAMING_FAN_SPEED_VALUE_MASK, result);
> +
> +	return 0;
> +}
> +
>  static int WMID_gaming_set_misc_setting(enum acer_wmi_gaming_misc_setting setting, u8 value)
>  {
>  	acpi_status status;
> @@ -2840,6 +2931,16 @@ static const enum acer_wmi_predator_v4_sensor_id acer_wmi_fan_channel_to_sensor_
>  	[1] = ACER_WMID_SENSOR_GPU_FAN_SPEED,
>  };
>  
> +static const enum acer_wmi_gaming_fan_id acer_wmi_fan_channel_to_fan_id[] = {
> +	[0] = ACER_WMID_CPU_FAN,
> +	[1] = ACER_WMID_GPU_FAN,
> +};
> +
> +static const u16 acer_wmi_fan_channel_to_fan_bitmap[] = {
> +	[0] = ACER_GAMING_FAN_BEHAVIOR_CPU,
> +	[1] = ACER_GAMING_FAN_BEHAVIOR_GPU,
> +};
> +
>  static umode_t acer_wmi_hwmon_is_visible(const void *data,
>  					 enum hwmon_sensor_types type, u32 attr,
>  					 int channel)
> @@ -2851,6 +2952,11 @@ static umode_t acer_wmi_hwmon_is_visible(const void *data,
>  	case hwmon_temp:
>  		sensor_id = acer_wmi_temp_channel_to_sensor_id[channel];
>  		break;
> +	case hwmon_pwm:
> +		if (!has_cap(ACER_CAP_PWM))
> +			return 0;
> +
> +		fallthrough;
>  	case hwmon_fan:
>  		sensor_id = acer_wmi_fan_channel_to_sensor_id[channel];
>  		break;
> @@ -2858,8 +2964,12 @@ static umode_t acer_wmi_hwmon_is_visible(const void *data,
>  		return 0;
>  	}
>  
> -	if (*supported_sensors & BIT(sensor_id - 1))
> +	if (*supported_sensors & BIT(sensor_id - 1)) {
> +		if (type == hwmon_pwm)
> +			return 0644;
> +
>  		return 0444;
> +	}
>  
>  	return 0;
>  }
> @@ -2868,8 +2978,10 @@ static int acer_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  			       u32 attr, int channel, long *val)
>  {
>  	u64 command = ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING;
> +	u8 fan, speed, mode_bitmap;
> +	u16 fan_bitmap;
> +	int mode, ret;
>  	u64 result;
> -	int ret;
>  
>  	switch (type) {
>  	case hwmon_temp:
> @@ -2893,6 +3005,106 @@ static int acer_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
>  
>  		*val = FIELD_GET(ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK, result);
>  		return 0;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			fan = acer_wmi_fan_channel_to_fan_id[channel];
> +			ret = WMID_gaming_get_gaming_fan_speed(fan, &speed);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val = fixp_linear_interpolate(0, 0, 100, U8_MAX, speed);
> +			return 0;
> +		case hwmon_pwm_enable:
> +			fan_bitmap = acer_wmi_fan_channel_to_fan_bitmap[channel];
> +			ret = WMID_gaming_get_fan_behavior(fan_bitmap, &mode_bitmap);
> +			if (ret < 0)
> +				return ret;
> +
> +			switch (channel) {
> +			case 0:
> +				mode = FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK,
> +						 mode_bitmap);
> +				break;
> +			case 1:
> +				mode = FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK,
> +						 mode_bitmap);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}

You've managed to create an internal API that resembles the WMI method 
input by working in terms of fan_bitmap and mode_bitmap which makes things 
complicated as then you have to build logic on top of it to do all the 
mapping in the caller...

I suggest changing this so you make WMID_gaming_get_fan_behavior() to 
input ACER_GAMING_FAN_BEHAVIOR_CPU / GPU (or ACER_WMID_CPU_FAN / GPU_FAN 
depending on the question I asked above) and perform the output mapping 
within that function. I think it would be much cleaner.

I didn't exactly like the internal API in patch 1 either and I'd prefer 
the field GENMASK()s to directly point to the correct bits instead of the 
nested FIELD_GET/PREP()s.

> +			switch (mode) {
> +			case ACER_WMID_FAN_MODE_AUTO:
> +				*val = 2;
> +				return 0;
> +			case ACER_WMID_FAN_MODE_TURBO:
> +				*val = 0;
> +				return 0;
> +			case ACER_WMID_FAN_MODE_CUSTOM:
> +				*val = 1;
> +				return 0;
> +			default:
> +				return -ENXIO;
> +			}
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int acer_wmi_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
> +				u32 attr, int channel, long val)
> +{
> +	u8 fan, speed, mode_bitmap;
> +	u16 fan_bitmap;
> +	int mode;
> +
> +	switch (type) {
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			fan = acer_wmi_fan_channel_to_fan_id[channel];
> +			speed = fixp_linear_interpolate(0, 0, U8_MAX, 100,
> +							clamp_val(val, 0, U8_MAX));
> +
> +			return WMID_gaming_set_gaming_fan_speed(fan, speed);
> +		case hwmon_pwm_enable:
> +			fan_bitmap = acer_wmi_fan_channel_to_fan_bitmap[channel];
> +
> +			switch (val) {
> +			case 0:
> +				mode = ACER_WMID_FAN_MODE_TURBO;
> +				break;
> +			case 1:
> +				mode = ACER_WMID_FAN_MODE_CUSTOM;
> +				break;
> +			case 2:
> +				mode = ACER_WMID_FAN_MODE_AUTO;
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +
> +			switch (channel) {
> +			case 0:
> +				mode_bitmap = FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK,
> +							 mode);
> +				break;
> +			case 1:
> +				mode_bitmap = FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK,
> +							 mode);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}

These too look they could be mapped inside WMID_gaming_set_fan_behavior().

> +
> +			return WMID_gaming_set_fan_behavior(fan_bitmap, mode_bitmap);
> +		default:
> +			return -EOPNOTSUPP;
> +		}
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -2908,11 +3120,16 @@ static const struct hwmon_channel_info *const acer_wmi_hwmon_info[] = {
>  			   HWMON_F_INPUT,
>  			   HWMON_F_INPUT
>  			   ),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE
> +			   ),
>  	NULL
>  };
>  
>  static const struct hwmon_ops acer_wmi_hwmon_ops = {
>  	.read = acer_wmi_hwmon_read,
> +	.write = acer_wmi_hwmon_write,
>  	.is_visible = acer_wmi_hwmon_is_visible,
>  };
>  
> 

-- 
 i.


