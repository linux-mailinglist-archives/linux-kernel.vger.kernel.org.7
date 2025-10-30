Return-Path: <linux-kernel+bounces-878464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F9FC20B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3024C4EE4BD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901FA274FD3;
	Thu, 30 Oct 2025 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYbCuPoc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1372741AC;
	Thu, 30 Oct 2025 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835499; cv=none; b=MZYivpnCXDqTfW9NeQFOK+N/XtewBJNiFVQyciRbE3RJj99bFSz/WZ6TjP+6L9y9ygNrJLkQX3fvVRMfHZaGCYAn+Kp8fe+ocOsXqo1lf+f8j+P6a4pMNSgcCQ4RG2c98odsMXpb4k5dJG7H3jhyXJb4xtC7KzzCS4zYldh5qoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835499; c=relaxed/simple;
	bh=6dhZsT9i35AP1anVdEddI5/ro72V1ZvA0zg0iWCPFQc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=stOSc3zflYC0j6GEsNZ2J9BhsSL6pmKhPgbncqz6KfKeTQYM6ejS35juKli7GWSIalSF22Fq1AMpQUVNH7goVHk0Sf7XZh2bKwJlnk0/WoUJ4te4K4JsSB+lk+zlYL6kFRgQKD+kh6qiDy+/dUWKoJD3XYpSIyqG9th4RJWBzdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYbCuPoc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761835497; x=1793371497;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6dhZsT9i35AP1anVdEddI5/ro72V1ZvA0zg0iWCPFQc=;
  b=VYbCuPocRZ3xg2nHNeuPRLjUlJJEOAuXgLKJL/00WUQab137KenUiAmY
   XuOkQ4JzvQ/Cl/h+jVtdx61+DN7qqIdrIXkdbjuK04kAFUZzJ3N10ZbY5
   fgDSBuInE3SZDTRyokAdV17xEuwsUK/vIBrfEj43y0totU+HL8wNysRFS
   LK9gUTAng5uipjBBoQarh3oGvYpzWaDYCkhp/YDIg086I0ImgYtGzA+bp
   lvRYs2OCIZrGMC9zGjxRg8vhLouu+dA1PbWtk7yj9TAJLrjA1tZ75R7fV
   CD686CSuy9c0Vo7UrMfsaZlpvGTO4KA2ktaZMWZFnO0Q7jLEJqvX8uIbe
   Q==;
X-CSE-ConnectionGUID: TH5JyLT2TP+e5bWqxkljYA==
X-CSE-MsgGUID: B7oqphtRRFugiOfEp+znqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63883440"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63883440"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 07:44:56 -0700
X-CSE-ConnectionGUID: Azs+OQQjQHSIl2M+aZdBug==
X-CSE-MsgGUID: C0m9wGhtRsG/lQg56JK60A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; 
   d="scan'208";a="185852445"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.175])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 07:44:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 30 Oct 2025 16:44:48 +0200 (EET)
To: Denis Benato <denis.benato@linux.dev>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, 
    "Limonciello, Mario" <mario.limonciello@amd.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Alok Tiwari <alok.a.tiwari@oracle.com>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    Mateusz Schyboll <dragonn@op.pl>, Denis Benato <benato.denis96@gmail.com>, 
    porfet828@gmail.com
Subject: Re: [PATCH v16 9/9] platform/x86: asus-armoury: add ppt_* and nv_*
 tuning knobs
In-Reply-To: <20251030130320.1287122-10-denis.benato@linux.dev>
Message-ID: <91cddea1-b5be-2bcc-cf64-7ac102c14aca@linux.intel.com>
References: <20251030130320.1287122-1-denis.benato@linux.dev> <20251030130320.1287122-10-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 30 Oct 2025, Denis Benato wrote:

> From: "Luke D. Jones" <luke@ljones.dev>
> 
> Adds the ppt_* and nv_* tuning knobs that are available via WMI methods
> and adds proper min/max levels plus defaults.
> 
> The min/max are defined by ASUS and typically gained by looking at what
> they allow in the ASUS Armoury Crate application - ASUS does not share
> the values outside of this. It could also be possible to gain the AMD
> values by use of ryzenadj and testing for the minimum stable value.
> 
> The general rule of thumb for adding to the match table is that if the
> model range has a single CPU used throughout, then the DMI match can
> omit the last letter of the model number as this is the GPU model.
> 
> If a min or max value is not provided it is assumed that the particular
> setting is not supported. for example ppt_pl2_sppt_min/max is not set.
> If a <ppt_setting>_def is not set then the default is assumed to be
> <ppt_setting>_max
> 
> It is assumed that at least AC settings are available so that the
> firmware attributes will be created - if no DC table is available
> and power is on DC, then reading the attributes is -ENODEV.
> 
> Co-developed-by: Denis Benato <denis.benato@linux.dev>
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Mateusz Schyboll <dragonn@op.pl>
> Tested-by: Porfet Lillian <porfet828@gmail.com>
> ---
>  drivers/platform/x86/asus-armoury.c        |  296 ++++-
>  drivers/platform/x86/asus-armoury.h        | 1267 ++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |    3 +
>  3 files changed, 1560 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index 63579034756a..9f0bbdc45ca0 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -30,6 +30,7 @@
>  #include <linux/pci.h>
>  #include <linux/platform_data/x86/asus-wmi.h>
>  #include <linux/printk.h>
> +#include <linux/power_supply.h>
>  #include <linux/sysfs.h>
>  
>  #include "asus-armoury.h"
> @@ -48,9 +49,23 @@
>  #define ASUS_MINI_LED_2024_STRONG 0x01
>  #define ASUS_MINI_LED_2024_OFF    0x02
>  
> +/* Power tunable attribute name defines */
> +#define ATTR_PPT_PL1_SPL        "ppt_pl1_spl"
> +#define ATTR_PPT_PL2_SPPT       "ppt_pl2_sppt"
> +#define ATTR_PPT_PL3_FPPT       "ppt_pl3_fppt"
> +#define ATTR_PPT_APU_SPPT       "ppt_apu_sppt"
> +#define ATTR_PPT_PLATFORM_SPPT  "ppt_platform_sppt"
> +#define ATTR_NV_DYNAMIC_BOOST   "nv_dynamic_boost"
> +#define ATTR_NV_TEMP_TARGET     "nv_temp_target"
> +#define ATTR_NV_BASE_TGP        "nv_base_tgp"
> +#define ATTR_NV_TGP             "nv_tgp"
> +
>  #define ASUS_POWER_CORE_MASK	GENMASK(15, 8)
>  #define ASUS_PERF_CORE_MASK	GENMASK(7, 0)
>  
> +#define ASUS_ROG_TUNABLE_DC 0
> +#define ASUS_ROG_TUNABLE_AC 1
> +
>  enum cpu_core_type {
>  	CPU_CORE_PERF = 0,
>  	CPU_CORE_POWER,
> @@ -78,6 +93,19 @@ struct cpu_cores {
>  	u32 max_power_cores;
>  };
>  
> +struct rog_tunables {
> +	const struct power_limits *power_limits;
> +	u32 ppt_pl1_spl;			// cpu
> +	u32 ppt_pl2_sppt;			// cpu
> +	u32 ppt_pl3_fppt;			// cpu
> +	u32 ppt_apu_sppt;			// plat
> +	u32 ppt_platform_sppt;		// plat
> +
> +	u32 nv_dynamic_boost;
> +	u32 nv_temp_target;
> +	u32 nv_tgp;
> +};
> +
>  struct asus_armoury_priv {
>  	struct device *fw_attr_dev;
>  	struct kset *fw_attr_kset;
> @@ -98,6 +126,9 @@ struct asus_armoury_priv {
>  	struct cpu_cores *cpu_cores;
>  	bool cpu_cores_changeable;
>  
> +	/* Index 0 for DC, 1 for AC */
> +	struct rog_tunables *rog_tunables[2];
> +
>  	u32 mini_led_dev_id;
>  	u32 gpu_mux_dev_id;
>  };
> @@ -918,6 +949,15 @@ static ssize_t cores_performance_current_value_store(struct kobject *kobj,
>  ASUS_ATTR_GROUP_CORES_RW(cores_performance, "cores_performance",
>  			 "Set the max available performance cores");
>  
> +/* Define helper to access the current power mode tunable values */
> +static inline struct rog_tunables *get_current_tunables(void)
> +{
> +	if (power_supply_is_system_supplied())
> +		return asus_armoury.rog_tunables[ASUS_ROG_TUNABLE_AC];
> +
> +	return asus_armoury.rog_tunables[ASUS_ROG_TUNABLE_DC];
> +}
> +
>  static ssize_t cores_efficiency_min_value_show(struct kobject *kobj, struct kobj_attribute *attr,
>  					       char *buf)
>  {
> @@ -973,6 +1013,24 @@ ASUS_ATTR_GROUP_BOOL_RW(screen_auto_brightness, "screen_auto_brightness",
>  			"Set the panel brightness to Off<0> or On<1>");
>  ASUS_ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU_CONNECTED,
>  			"Show the eGPU connection status");
> +ASUS_ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, ATTR_PPT_PL1_SPL, ASUS_WMI_DEVID_PPT_PL1_SPL,
> +			    "Set the CPU slow package limit");
> +ASUS_ATTR_GROUP_ROG_TUNABLE(ppt_pl2_sppt, ATTR_PPT_PL2_SPPT, ASUS_WMI_DEVID_PPT_PL2_SPPT,
> +			    "Set the CPU fast package limit");
> +ASUS_ATTR_GROUP_ROG_TUNABLE(ppt_pl3_fppt, ATTR_PPT_PL3_FPPT, ASUS_WMI_DEVID_PPT_PL3_FPPT,
> +			    "Set the CPU fastest package limit");
> +ASUS_ATTR_GROUP_ROG_TUNABLE(ppt_apu_sppt, ATTR_PPT_APU_SPPT, ASUS_WMI_DEVID_PPT_APU_SPPT,
> +			    "Set the APU package limit");
> +ASUS_ATTR_GROUP_ROG_TUNABLE(ppt_platform_sppt, ATTR_PPT_PLATFORM_SPPT, ASUS_WMI_DEVID_PPT_PLAT_SPPT,
> +			    "Set the platform package limit");
> +ASUS_ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, ATTR_NV_DYNAMIC_BOOST, ASUS_WMI_DEVID_NV_DYN_BOOST,
> +			    "Set the Nvidia dynamic boost limit");
> +ASUS_ATTR_GROUP_ROG_TUNABLE(nv_temp_target, ATTR_NV_TEMP_TARGET, ASUS_WMI_DEVID_NV_THERM_TARGET,
> +			    "Set the Nvidia max thermal limit");
> +ASUS_ATTR_GROUP_ROG_TUNABLE(nv_tgp, "nv_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP,
> +			    "Set the additional TGP on top of the base TGP");
> +ASUS_ATTR_GROUP_INT_VALUE_ONLY_RO(nv_base_tgp, ATTR_NV_BASE_TGP, ASUS_WMI_DEVID_DGPU_BASE_TGP,
> +				  "Read the base TGP value");
>  
>  /* If an attribute does not require any special case handling add it here */
>  static const struct asus_attr_group armoury_attr_groups[] = {
> @@ -983,6 +1041,16 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>  	{ &cores_efficiency_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>  	{ &cores_performance_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>  
> +	{ &ppt_pl1_spl_attr_group, ASUS_WMI_DEVID_PPT_PL1_SPL },
> +	{ &ppt_pl2_sppt_attr_group, ASUS_WMI_DEVID_PPT_PL2_SPPT },
> +	{ &ppt_pl3_fppt_attr_group, ASUS_WMI_DEVID_PPT_PL3_FPPT },
> +	{ &ppt_apu_sppt_attr_group, ASUS_WMI_DEVID_PPT_APU_SPPT },
> +	{ &ppt_platform_sppt_attr_group, ASUS_WMI_DEVID_PPT_PLAT_SPPT },
> +	{ &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
> +	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
> +	{ &nv_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
> +	{ &nv_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
> +
>  	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>  	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
>  	{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
> @@ -991,8 +1059,75 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>  	{ &screen_auto_brightness_attr_group, ASUS_WMI_DEVID_SCREEN_AUTO_BRIGHTNESS },
>  };
>  
> +/**
> + * is_power_tunable_attr - Determines if an attribute is a power-related tunable
> + * @name: The name of the attribute to check
> + *
> + * This function checks if the given attribute name is related to power tuning.
> + *
> + * Return: true if the attribute is a power-related tunable, false otherwise
> + */
> +static bool is_power_tunable_attr(const char *name)
> +{
> +	static const char * const power_tunable_attrs[] = {
> +		ATTR_PPT_PL1_SPL,	ATTR_PPT_PL2_SPPT,
> +		ATTR_PPT_PL3_FPPT,	ATTR_PPT_APU_SPPT,
> +		ATTR_PPT_PLATFORM_SPPT, ATTR_NV_DYNAMIC_BOOST,
> +		ATTR_NV_TEMP_TARGET,	ATTR_NV_BASE_TGP,
> +		ATTR_NV_TGP
> +	};
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(power_tunable_attrs); i++) {
> +		if (!strcmp(name, power_tunable_attrs[i]))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * has_valid_limit - Checks if a power-related attribute has a valid limit value
> + * @name: The name of the attribute to check
> + * @limits: Pointer to the power_limits structure containing limit values
> + *
> + * This function checks if a power-related attribute has a valid limit value.
> + * It returns false if limits is NULL or if the corresponding limit value is zero.
> + *
> + * Return: true if the attribute has a valid limit value, false otherwise
> + */
> +static bool has_valid_limit(const char *name, const struct power_limits *limits)
> +{
> +	u32 limit_value = 0;
> +
> +	if (!limits)
> +		return false;
> +
> +	if (!strcmp(name, ATTR_PPT_PL1_SPL))
> +		limit_value = limits->ppt_pl1_spl_max;
> +	else if (!strcmp(name, ATTR_PPT_PL2_SPPT))
> +		limit_value = limits->ppt_pl2_sppt_max;
> +	else if (!strcmp(name, ATTR_PPT_PL3_FPPT))
> +		limit_value = limits->ppt_pl3_fppt_max;
> +	else if (!strcmp(name, ATTR_PPT_APU_SPPT))
> +		limit_value = limits->ppt_apu_sppt_max;
> +	else if (!strcmp(name, ATTR_PPT_PLATFORM_SPPT))
> +		limit_value = limits->ppt_platform_sppt_max;
> +	else if (!strcmp(name, ATTR_NV_DYNAMIC_BOOST))
> +		limit_value = limits->nv_dynamic_boost_max;
> +	else if (!strcmp(name, ATTR_NV_TEMP_TARGET))
> +		limit_value = limits->nv_temp_target_max;
> +	else if (!strcmp(name, ATTR_NV_BASE_TGP) ||
> +		 !strcmp(name, ATTR_NV_TGP))
> +		limit_value = limits->nv_tgp_max;
> +
> +	return limit_value > 0;
> +}
> +
>  static int asus_fw_attr_add(void)
>  {
> +	const struct power_limits *limits;
> +	bool should_create;
> +	const char *name;
>  	int err, i;
>  
>  	asus_armoury.fw_attr_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
> @@ -1049,12 +1184,29 @@ static int asus_fw_attr_add(void)
>  		if (!armoury_has_devstate(armoury_attr_groups[i].wmi_devid))
>  			continue;
>  
> -		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> -					 armoury_attr_groups[i].attr_group);
> -		if (err) {
> -			pr_err("Failed to create sysfs-group for %s\n",
> -			       armoury_attr_groups[i].attr_group->name);
> -			goto err_remove_groups;
> +		/* Always create by default, unless PPT is not present */
> +		should_create = true;
> +		name = armoury_attr_groups[i].attr_group->name;
> +
> +		/* Check if this is a power-related tunable requiring limits */
> +		if (asus_armoury.rog_tunables[ASUS_ROG_TUNABLE_AC] &&
> +		    asus_armoury.rog_tunables[ASUS_ROG_TUNABLE_AC]->power_limits &&
> +		    is_power_tunable_attr(name)) {
> +			limits = asus_armoury.rog_tunables[ASUS_ROG_TUNABLE_AC]->power_limits;

Here too a local variable would have helped.

-- 
 i.

