Return-Path: <linux-kernel+bounces-746792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E4FB12B40
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A429AA21F7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E075327781D;
	Sat, 26 Jul 2025 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L75oBqSb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2962527455;
	Sat, 26 Jul 2025 15:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753545030; cv=none; b=XBr0PTvAaJxGcmJbTp9WGizXtlxA2hxEwy9UVLk083usYfiarXuTMVs457Zd7HWuM9pwgUaAD9ZYA1jrMMRZoZ6WZSDXPXKDvtEoN+huLd8kU+ScGI/smkQU+1dV2wA0VnwMjM8RYowDMarMW+uGqBOm8QIxMEJK4ZeUsRZeIP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753545030; c=relaxed/simple;
	bh=GC92yXfDBul7rG84MOYohuLtA+dRJ3XyMttBO4mFzuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mplSyzx5IelYJLfVwJyUYwpAlbTXKwnEfMPqc6D1IvVbQnZBqu4AcBA0PN8bSfVNxV7QfDORJ8/WncleBf/CtdiGTMmmOBkX71iWhh75Mwlbp/phVea4Fr1XzSQHzclkQEDYbLuJau+k7uT4nYdIvI98xibojv3pMs3dnaJ2T5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L75oBqSb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753545029; x=1785081029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GC92yXfDBul7rG84MOYohuLtA+dRJ3XyMttBO4mFzuo=;
  b=L75oBqSbj0aQ6Ck+Trn8hYP3/YBgUGA+jlSzWPOc46NP1iLO6q1VhREt
   Q3X6ZZn9Hgxk+iVzcjMlERHJ4wO0qouVsfSG4yntBJz4jDo3nmT/fiOvI
   CY/niQdpCY89NIPXHoAYscvbzqXJ1/io4lWc+FbkumeGJ//IFfqUJ0dHi
   za2ouScpmv6WgmUMgopbq3By5BNVB4AJioQlAgZQecgSqcwx8den8hBn1
   LU1jkhZUmrvsxqkx0gkIHPblNFcTyE8PdLVdbc2hFKaWuwJ9QTL2M5+n0
   WBIQ0EmnxagU+HsTQfv5ZVUODBXlE/6ZkzB3CBfl9W+5lFQjg5K8t1hSC
   A==;
X-CSE-ConnectionGUID: bp1disBLRpa3BGnx45VPuA==
X-CSE-MsgGUID: bGserau0RjG0e1XvziAgpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="73308938"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="73308938"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 08:50:28 -0700
X-CSE-ConnectionGUID: 6HG7iPA2TMWgYYFs9ugLhA==
X-CSE-MsgGUID: BxXPtvo0RS2UDYHQNPqqxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="192502537"
Received: from smoehrl-linux.amr.corp.intel.com (HELO localhost) ([10.124.220.149])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 08:50:25 -0700
Date: Sat, 26 Jul 2025 08:50:24 -0700
From: David Box <david.e.box@linux.intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/4] platform/x86: (ayn-ec) Add Temperature Sensors
Message-ID: <6f7lr653uffhzenm5fgl5cghrsscvqpcpoxyu6qmq6xzlia3h4@fa4ucvpnqwdg>
References: <20250725004533.63537-1-derekjohn.clark@gmail.com>
 <20250725004533.63537-2-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250725004533.63537-2-derekjohn.clark@gmail.com>

On Thu, Jul 24, 2025 at 05:45:31PM -0700, Derek J. Clark wrote:
> Adds temperature sensors to the ayn-ec hwmon interface. These read-only
> values include Battery, Motherboard, Charger IC, vCore, and CPU Core, as
> well as labels for each entry. The temperature values provided by the EC
> are whole numbers in degrees Celsius. As hwmon expects millidegrees, we
> scale the raw value up.
> 
> `sensors` output after this patch is applied:
> aynec-isa-0000
> Adapter: ISA adapter
> fan1:        1876 RPM
> Battery:      +29.0°C
> Motherboard:  +30.0°C
> Charger IC:   +30.0°C
> vCore:        +36.0°C
> CPU Core:     +48.0°C
> 
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>  drivers/platform/x86/ayn-ec.c | 89 +++++++++++++++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
> 
> diff --git a/drivers/platform/x86/ayn-ec.c b/drivers/platform/x86/ayn-ec.c
> index 06f232bd10fa..b2054dc2358a 100644
> --- a/drivers/platform/x86/ayn-ec.c
> +++ b/drivers/platform/x86/ayn-ec.c
> @@ -50,8 +50,16 @@
>  #define AYN_SENSOR_PWM_FAN_TEMP_4_REG	0x19
>  #define AYN_SENSOR_PWM_FAN_TEMP_5_REG	0x1B
>  
> +/* EC Teperature Sensors */
> +#define AYN_SENSOR_BAT_TEMP_REG		0x04 /* Battery */
> +#define AYN_SENSOR_CHARGE_TEMP_REG	0x07 /* Charger IC */
> +#define AYN_SENSOR_MB_TEMP_REG		0x05 /* Motherboard */
> +#define AYN_SENSOR_PROC_TEMP_REG	0x09 /* CPU Core */
> +#define AYN_SENSOR_VCORE_TEMP_REG	0x08 /* vCore */
> +
>  /* Handle ACPI lock mechanism */
>  #define ACPI_LOCK_DELAY_MS 500
> +
>  enum ayn_model {
>  	ayn_loki_max = 1,
>  	ayn_loki_minipro,
> @@ -63,6 +71,20 @@ struct ayn_device {
>  	u32 ayn_lock; /* ACPI EC Lock */
>  } drvdata;
>  
> +struct thermal_sensor {
> +	char *name;
> +	int reg;
> +};
> +
> +static struct thermal_sensor thermal_sensors[] = {
> +	{ "Battery", AYN_SENSOR_BAT_TEMP_REG },
> +	{ "Motherboard", AYN_SENSOR_MB_TEMP_REG },
> +	{ "Charger IC", AYN_SENSOR_CHARGE_TEMP_REG },
> +	{ "vCore", AYN_SENSOR_VCORE_TEMP_REG },
> +	{ "CPU Core", AYN_SENSOR_PROC_TEMP_REG },
> +	{}
> +};

Use tabs to align the constants for better readability.

David

> +
>  /* Handle ACPI lock mechanism */
>  #define ACPI_LOCK_DELAY_MS 500
>  
> @@ -503,6 +525,63 @@ static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point3_temp, pwm_curve, 7);
>  static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point4_temp, pwm_curve, 8);
>  static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point5_temp, pwm_curve, 9);
>  
> +/**
> + * thermal_sensor_show() - Read a thermal sensor attribute value.
> + *
> + * @dev: The attribute's parent device.
> + * @attr: The attribute to read.
> + * @buf: Buffer to read to.
> + *
> + * Return: Number of bytes read, or an error.
> + */
> +static ssize_t thermal_sensor_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	long ret, val;
> +	int i;
> +
> +	i = to_sensor_dev_attr(attr)->index;
> +
> +	ret = read_from_ec(thermal_sensors[i].reg, 1, &val);
> +	if (ret)
> +		return ret;
> +
> +	val = val * 1000L;
> +
> +	return sysfs_emit(buf, "%ld\n", val);
> +}
> +
> +/**
> + * thermal_sensor_label_show() - Read a thermal sensor attribute label.
> + *
> + * @dev: The attribute's parent device.
> + * @attr: The attribute to read.
> + * @buf: Buffer to read to.
> + *
> + * Return: Number of bytes read, or an error.
> + */
> +static ssize_t thermal_sensor_label_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	int i;
> +
> +	i = to_sensor_dev_attr(attr)->index;
> +
> +	return sysfs_emit(buf, "%s\n", thermal_sensors[i].name);
> +}
> +
> +static SENSOR_DEVICE_ATTR_RO(temp1_input, thermal_sensor, 0);
> +static SENSOR_DEVICE_ATTR_RO(temp2_input, thermal_sensor, 1);
> +static SENSOR_DEVICE_ATTR_RO(temp3_input, thermal_sensor, 2);
> +static SENSOR_DEVICE_ATTR_RO(temp4_input, thermal_sensor, 3);
> +static SENSOR_DEVICE_ATTR_RO(temp5_input, thermal_sensor, 4);
> +static SENSOR_DEVICE_ATTR_RO(temp1_label, thermal_sensor_label, 0);
> +static SENSOR_DEVICE_ATTR_RO(temp2_label, thermal_sensor_label, 1);
> +static SENSOR_DEVICE_ATTR_RO(temp3_label, thermal_sensor_label, 2);
> +static SENSOR_DEVICE_ATTR_RO(temp4_label, thermal_sensor_label, 3);
> +static SENSOR_DEVICE_ATTR_RO(temp5_label, thermal_sensor_label, 4);
> +
>  static struct attribute *ayn_sensors_attrs[] = {
>  	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
> @@ -514,6 +593,16 @@ static struct attribute *ayn_sensors_attrs[] = {
>  	&sensor_dev_attr_pwm1_auto_point4_temp.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_auto_point5_pwm.dev_attr.attr,
>  	&sensor_dev_attr_pwm1_auto_point5_temp.dev_attr.attr,
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_label.dev_attr.attr,
> +	&sensor_dev_attr_temp2_input.dev_attr.attr,
> +	&sensor_dev_attr_temp2_label.dev_attr.attr,
> +	&sensor_dev_attr_temp3_input.dev_attr.attr,
> +	&sensor_dev_attr_temp3_label.dev_attr.attr,
> +	&sensor_dev_attr_temp4_input.dev_attr.attr,
> +	&sensor_dev_attr_temp4_label.dev_attr.attr,
> +	&sensor_dev_attr_temp5_input.dev_attr.attr,
> +	&sensor_dev_attr_temp5_label.dev_attr.attr,
>  	NULL,
>  };
>  
> -- 
> 2.50.0
> 
> 

