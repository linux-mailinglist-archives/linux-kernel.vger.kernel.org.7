Return-Path: <linux-kernel+bounces-858046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB445BE8AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5036C35C4D1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE85F33031E;
	Fri, 17 Oct 2025 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMfdEOJX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D821B9F5;
	Fri, 17 Oct 2025 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705654; cv=none; b=ObGCiNP77pmHmtrANUFiTz+X9KFN+X9YDrT/821ROEOuUkm8eJkpWB4cyifP1EqR3DJDeqhoG8OjmIjb1Od7+Osl2VYnP70/qs4ee1ys8iB1xQ8pNxstNd36bGgg/dKt6DMwCT7w2wO7M5ntRMxf9GPOA3BdN6laMVqFE3lFzm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705654; c=relaxed/simple;
	bh=tr8UW+lJ1nmmD2HNeBZVml2viWAUvY6rNWC9BqbjKoU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Te0atM/cjDuM7FQYtrfLClITPHlkNUOQAkUjkROblPz/K/1IT8L1ua+5hLd/yyxQVTIPPNScEqN13VAyxFeegA15GnAuvqLNSRSOaDCIBwfUTgyDBMSZuJocUrN5B1aTDc6z5U3TEZcPFUerYtbjNh016MECgyz3g7KXz5s1ffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMfdEOJX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760705653; x=1792241653;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tr8UW+lJ1nmmD2HNeBZVml2viWAUvY6rNWC9BqbjKoU=;
  b=GMfdEOJXT9jJuP2jusgTVVa73Ile9/kVMP5LD5sWWLhPWyGBaYF8KMND
   ZSpYCaSDY5ViISMWcmmhpMKp+Di0OqAf4IofGPPZjp0GH5fd3yKtuVWK1
   UN5HeIp7rAIAIZymR7a0V9dfkItyWDy3bNVvV/RIpSzcgFCVw4NlfnhGQ
   FCUmeP6lsYEIyMNZ6MQZePdPbTey0J6LaLqiuM+CqTD+xg7RokmT3aSmU
   rfTXClS02sRcxdgDaheOlPIRsvXG+BF8ZwerRWgX4Ei+/e9GcFCRqGmpp
   Ji+/A+FvmjbpsMpHxM/wwV826fCuhpGPl9GGAk95ocxNTk7OpLIVU8/5h
   g==;
X-CSE-ConnectionGUID: HjTuo3mhSlOdYhpFYYSqEQ==
X-CSE-MsgGUID: sgiFiCGYTl2jr7wr75rH1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73199344"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="73199344"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 05:54:12 -0700
X-CSE-ConnectionGUID: PZtLkGMPS5e5Gy5roJziAA==
X-CSE-MsgGUID: dD5wONloTnOMVm6UOxG0gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182672919"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 05:54:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 17 Oct 2025 15:54:03 +0300 (EEST)
To: Denis Benato <benato.denis96@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, 
    "Limonciello, Mario" <mario.limonciello@amd.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Alok Tiwari <alok.a.tiwari@oracle.com>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
Subject: Re: [PATCH v14 7/9] platform/x86: asus-wmi: deprecate bios
 features
In-Reply-To: <20251015014736.1402045-8-benato.denis96@gmail.com>
Message-ID: <53e8ae0b-6033-2a99-46b0-e3d8ed4d3f97@linux.intel.com>
References: <20251015014736.1402045-1-benato.denis96@gmail.com> <20251015014736.1402045-8-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Oct 2025, Denis Benato wrote:

> From: "Luke D. Jones" <luke@ljones.dev>
> 
> With the existence of the asus-armoury module the attributes no longer
> need to live under the /sys/devices/platform/asus-nb-wmi/ path.
> 
> Deprecate all those that were implemented in asus-bioscfg with the goal
> of removing them fully in the next LTS cycle.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Denis Benato <benato.denis96@gmail.com>
> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  17 +++
>  drivers/platform/x86/Kconfig                  |  11 ++
>  drivers/platform/x86/asus-wmi.c               | 121 ++++++++++++++----
>  3 files changed, 124 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 28144371a0f1..765d50b0d9df 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -63,6 +63,7 @@ Date:		Aug 2022
>  KernelVersion:	6.1
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON

Could these include also "please use ..." to direct the reader to correct 
direction.

-- 
 i.

>  		Switch the GPU hardware MUX mode. Laptops with this feature can
>  		can be toggled to boot with only the dGPU (discrete mode) or in
>  		standard Optimus/Hybrid mode. On switch a reboot is required:
> @@ -75,6 +76,7 @@ Date:		Aug 2022
>  KernelVersion:	5.17
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Disable discrete GPU:
>  			* 0 - Enable dGPU,
>  			* 1 - Disable dGPU
> @@ -84,6 +86,7 @@ Date:		Aug 2022
>  KernelVersion:	5.17
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Enable the external GPU paired with ROG X-Flow laptops.
>  		Toggling this setting will also trigger ACPI to disable the dGPU:
>  
> @@ -95,6 +98,7 @@ Date:		Aug 2022
>  KernelVersion:	5.17
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Enable an LCD response-time boost to reduce or remove ghosting:
>  			* 0 - Disable,
>  			* 1 - Enable
> @@ -104,6 +108,7 @@ Date:		Jun 2023
>  KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Get the current charging mode being used:
>  			* 1 - Barrel connected charger,
>  			* 2 - USB-C charging
> @@ -114,6 +119,7 @@ Date:		Jun 2023
>  KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Show if the egpu (XG Mobile) is correctly connected:
>  			* 0 - False,
>  			* 1 - True
> @@ -123,6 +129,7 @@ Date:		Jun 2023
>  KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Change the mini-LED mode:
>  			* 0 - Single-zone,
>  			* 1 - Multi-zone
> @@ -133,6 +140,7 @@ Date:		Apr 2024
>  KernelVersion:	6.10
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		List the available mini-led modes.
>  
>  What:		/sys/devices/platform/<platform>/ppt_pl1_spl
> @@ -140,6 +148,7 @@ Date:		Jun 2023
>  KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Set the Package Power Target total of CPU: PL1 on Intel, SPL on AMD.
>  		Shown on Intel+Nvidia or AMD+Nvidia based systems:
>  
> @@ -150,6 +159,7 @@ Date:		Jun 2023
>  KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Set the Slow Package Power Tracking Limit of CPU: PL2 on Intel, SPPT,
>  		on AMD. Shown on Intel+Nvidia or AMD+Nvidia based systems:
>  
> @@ -160,6 +170,7 @@ Date:		Jun 2023
>  KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Set the Fast Package Power Tracking Limit of CPU. AMD+Nvidia only:
>  			* min=5, max=250
>  
> @@ -168,6 +179,7 @@ Date:		Jun 2023
>  KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Set the APU SPPT limit. Shown on full AMD systems only:
>  			* min=5, max=130
>  
> @@ -176,6 +188,7 @@ Date:		Jun 2023
>  KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Set the platform SPPT limit. Shown on full AMD systems only:
>  			* min=5, max=130
>  
> @@ -184,6 +197,7 @@ Date:		Jun 2023
>  KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Set the dynamic boost limit of the Nvidia dGPU:
>  			* min=5, max=25
>  
> @@ -192,6 +206,7 @@ Date:		Jun 2023
>  KernelVersion:	6.5
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Set the target temperature limit of the Nvidia dGPU:
>  			* min=75, max=87
>  
> @@ -200,6 +215,7 @@ Date:		Apr 2024
>  KernelVersion:	6.10
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Set if the BIOS POST sound is played on boot.
>  			* 0 - False,
>  			* 1 - True
> @@ -209,6 +225,7 @@ Date:		Apr 2024
>  KernelVersion:	6.10
>  Contact:	"Luke Jones" <luke@ljones.dev>
>  Description:
> +        DEPRECATED, WILL BE REMOVED SOON
>  		Set if the MCU can go in to low-power mode on system sleep
>  			* 0 - False,
>  			* 1 - True
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 8b827680754c..a17288401746 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -296,6 +296,17 @@ config ASUS_WMI
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called asus-wmi.
>  
> +config ASUS_WMI_DEPRECATED_ATTRS
> +	bool "BIOS option support in WMI platform (DEPRECATED)"
> +	depends on ASUS_WMI
> +	default y
> +	help
> +	  Say Y to expose the configurable BIOS options through the asus-wmi
> +	  driver.
> +
> +	  This can be used with or without the asus-armoury driver which
> +	  has the same attributes, but more, and better features.
> +
>  config ASUS_NB_WMI
>  	tristate "Asus Notebook WMI Driver"
>  	depends on ASUS_WMI
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 0d0c84a37ad8..3727ae00133d 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -337,6 +337,13 @@ struct asus_wmi {
>  /* Global to allow setting externally without requiring driver data */
>  static enum asus_ally_mcu_hack use_ally_mcu_hack = ASUS_WMI_ALLY_MCU_HACK_INIT;
>  
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
> +static void asus_wmi_show_deprecated(void)
> +{
> +	pr_notice_once("Accessing attributes through /sys/bus/platform/asus_wmi is deprecated and will be removed in a future release. Please switch over to /sys/class/firmware_attributes.\n");
> +}
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
> +
>  /* WMI ************************************************************************/
>  
>  static int asus_wmi_evaluate_method3(u32 method_id,
> @@ -723,6 +730,7 @@ static void asus_wmi_tablet_mode_get_state(struct asus_wmi *asus)
>  }
>  
>  /* Charging mode, 1=Barrel, 2=USB ******************************************/
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
>  static ssize_t charge_mode_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -733,12 +741,16 @@ static ssize_t charge_mode_show(struct device *dev,
>  	if (result < 0)
>  		return result;
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%d\n", value & 0xff);
>  }
>  
>  static DEVICE_ATTR_RO(charge_mode);
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
>  
>  /* dGPU ********************************************************************/
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
>  static ssize_t dgpu_disable_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -749,6 +761,8 @@ static ssize_t dgpu_disable_show(struct device *dev,
>  	if (result < 0)
>  		return result;
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%d\n", result);
>  }
>  
> @@ -802,8 +816,10 @@ static ssize_t dgpu_disable_store(struct device *dev,
>  	return count;
>  }
>  static DEVICE_ATTR_RW(dgpu_disable);
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
>  
>  /* eGPU ********************************************************************/
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
>  static ssize_t egpu_enable_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -814,6 +830,8 @@ static ssize_t egpu_enable_show(struct device *dev,
>  	if (result < 0)
>  		return result;
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%d\n", result);
>  }
>  
> @@ -870,8 +888,10 @@ static ssize_t egpu_enable_store(struct device *dev,
>  	return count;
>  }
>  static DEVICE_ATTR_RW(egpu_enable);
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
>  
>  /* Is eGPU connected? *********************************************************/
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
>  static ssize_t egpu_connected_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -882,12 +902,16 @@ static ssize_t egpu_connected_show(struct device *dev,
>  	if (result < 0)
>  		return result;
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%d\n", result);
>  }
>  
>  static DEVICE_ATTR_RO(egpu_connected);
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
>  
>  /* gpu mux switch *************************************************************/
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
>  static ssize_t gpu_mux_mode_show(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
>  {
> @@ -898,6 +922,8 @@ static ssize_t gpu_mux_mode_show(struct device *dev,
>  	if (result < 0)
>  		return result;
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%d\n", result);
>  }
>  
> @@ -956,6 +982,7 @@ static ssize_t gpu_mux_mode_store(struct device *dev,
>  	return count;
>  }
>  static DEVICE_ATTR_RW(gpu_mux_mode);
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
>  
>  /* TUF Laptop Keyboard RGB Modes **********************************************/
>  static ssize_t kbd_rgb_mode_store(struct device *dev,
> @@ -1079,6 +1106,7 @@ static const struct attribute_group *kbd_rgb_mode_groups[] = {
>  };
>  
>  /* Tunable: PPT: Intel=PL1, AMD=SPPT *****************************************/
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
>  static ssize_t ppt_pl2_sppt_store(struct device *dev,
>  				    struct device_attribute *attr,
>  				    const char *buf, size_t count)
> @@ -1117,6 +1145,8 @@ static ssize_t ppt_pl2_sppt_show(struct device *dev,
>  {
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%u\n", asus->ppt_pl2_sppt);
>  }
>  static DEVICE_ATTR_RW(ppt_pl2_sppt);
> @@ -1159,6 +1189,8 @@ static ssize_t ppt_pl1_spl_show(struct device *dev,
>  {
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%u\n", asus->ppt_pl1_spl);
>  }
>  static DEVICE_ATTR_RW(ppt_pl1_spl);
> @@ -1202,6 +1234,8 @@ static ssize_t ppt_fppt_show(struct device *dev,
>  {
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%u\n", asus->ppt_fppt);
>  }
>  static DEVICE_ATTR_RW(ppt_fppt);
> @@ -1245,6 +1279,8 @@ static ssize_t ppt_apu_sppt_show(struct device *dev,
>  {
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%u\n", asus->ppt_apu_sppt);
>  }
>  static DEVICE_ATTR_RW(ppt_apu_sppt);
> @@ -1288,6 +1324,8 @@ static ssize_t ppt_platform_sppt_show(struct device *dev,
>  {
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%u\n", asus->ppt_platform_sppt);
>  }
>  static DEVICE_ATTR_RW(ppt_platform_sppt);
> @@ -1331,6 +1369,8 @@ static ssize_t nv_dynamic_boost_show(struct device *dev,
>  {
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%u\n", asus->nv_dynamic_boost);
>  }
>  static DEVICE_ATTR_RW(nv_dynamic_boost);
> @@ -1374,9 +1414,12 @@ static ssize_t nv_temp_target_show(struct device *dev,
>  {
>  	struct asus_wmi *asus = dev_get_drvdata(dev);
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%u\n", asus->nv_temp_target);
>  }
>  static DEVICE_ATTR_RW(nv_temp_target);
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
>  
>  /* Ally MCU Powersave ********************************************************/
>  
> @@ -1417,6 +1460,7 @@ void set_ally_mcu_powersave(bool enabled)
>  }
>  EXPORT_SYMBOL_NS_GPL(set_ally_mcu_powersave, "ASUS_WMI");
>  
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
>  static ssize_t mcu_powersave_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -1427,6 +1471,8 @@ static ssize_t mcu_powersave_show(struct device *dev,
>  	if (result < 0)
>  		return result;
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%d\n", result);
>  }
>  
> @@ -1462,6 +1508,7 @@ static ssize_t mcu_powersave_store(struct device *dev,
>  	return count;
>  }
>  static DEVICE_ATTR_RW(mcu_powersave);
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
>  
>  /* Battery ********************************************************************/
>  
> @@ -2335,6 +2382,7 @@ static int asus_wmi_rfkill_init(struct asus_wmi *asus)
>  }
>  
>  /* Panel Overdrive ************************************************************/
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
>  static ssize_t panel_od_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -2345,6 +2393,8 @@ static ssize_t panel_od_show(struct device *dev,
>  	if (result < 0)
>  		return result;
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%d\n", result);
>  }
>  
> @@ -2381,9 +2431,10 @@ static ssize_t panel_od_store(struct device *dev,
>  	return count;
>  }
>  static DEVICE_ATTR_RW(panel_od);
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
>  
>  /* Bootup sound ***************************************************************/
> -
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
>  static ssize_t boot_sound_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
> @@ -2394,6 +2445,8 @@ static ssize_t boot_sound_show(struct device *dev,
>  	if (result < 0)
>  		return result;
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%d\n", result);
>  }
>  
> @@ -2429,8 +2482,10 @@ static ssize_t boot_sound_store(struct device *dev,
>  	return count;
>  }
>  static DEVICE_ATTR_RW(boot_sound);
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
>  
>  /* Mini-LED mode **************************************************************/
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
>  static ssize_t mini_led_mode_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -2461,6 +2516,8 @@ static ssize_t mini_led_mode_show(struct device *dev,
>  		}
>  	}
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "%d\n", value);
>  }
>  
> @@ -2531,10 +2588,13 @@ static ssize_t available_mini_led_mode_show(struct device *dev,
>  		return sysfs_emit(buf, "0 1 2\n");
>  	}
>  
> +	asus_wmi_show_deprecated();
> +
>  	return sysfs_emit(buf, "0\n");
>  }
>  
>  static DEVICE_ATTR_RO(available_mini_led_mode);
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
>  
>  /* Quirks *********************************************************************/
>  
> @@ -3822,6 +3882,7 @@ static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
>  	return throttle_thermal_policy_write(asus);
>  }
>  
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
>  static ssize_t throttle_thermal_policy_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
> @@ -3865,6 +3926,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
>   * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
>   */
>  static DEVICE_ATTR_RW(throttle_thermal_policy);
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
>  
>  /* Platform profile ***********************************************************/
>  static int asus_wmi_platform_profile_get(struct device *dev,
> @@ -4466,27 +4528,29 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_camera.attr,
>  	&dev_attr_cardr.attr,
>  	&dev_attr_touchpad.attr,
> -	&dev_attr_charge_mode.attr,
> -	&dev_attr_egpu_enable.attr,
> -	&dev_attr_egpu_connected.attr,
> -	&dev_attr_dgpu_disable.attr,
> -	&dev_attr_gpu_mux_mode.attr,
>  	&dev_attr_lid_resume.attr,
>  	&dev_attr_als_enable.attr,
>  	&dev_attr_fan_boost_mode.attr,
> -	&dev_attr_throttle_thermal_policy.attr,
> -	&dev_attr_ppt_pl2_sppt.attr,
> -	&dev_attr_ppt_pl1_spl.attr,
> -	&dev_attr_ppt_fppt.attr,
> -	&dev_attr_ppt_apu_sppt.attr,
> -	&dev_attr_ppt_platform_sppt.attr,
> -	&dev_attr_nv_dynamic_boost.attr,
> -	&dev_attr_nv_temp_target.attr,
> -	&dev_attr_mcu_powersave.attr,
> -	&dev_attr_boot_sound.attr,
> -	&dev_attr_panel_od.attr,
> -	&dev_attr_mini_led_mode.attr,
> -	&dev_attr_available_mini_led_mode.attr,
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
> +		&dev_attr_charge_mode.attr,
> +		&dev_attr_egpu_enable.attr,
> +		&dev_attr_egpu_connected.attr,
> +		&dev_attr_dgpu_disable.attr,
> +		&dev_attr_gpu_mux_mode.attr,
> +		&dev_attr_ppt_pl2_sppt.attr,
> +		&dev_attr_ppt_pl1_spl.attr,
> +		&dev_attr_ppt_fppt.attr,
> +		&dev_attr_ppt_apu_sppt.attr,
> +		&dev_attr_ppt_platform_sppt.attr,
> +		&dev_attr_nv_dynamic_boost.attr,
> +		&dev_attr_nv_temp_target.attr,
> +		&dev_attr_mcu_powersave.attr,
> +		&dev_attr_boot_sound.attr,
> +		&dev_attr_panel_od.attr,
> +		&dev_attr_mini_led_mode.attr,
> +		&dev_attr_available_mini_led_mode.attr,
> +		&dev_attr_throttle_thermal_policy.attr,
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
>  	NULL
>  };
>  
> @@ -4508,7 +4572,11 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		devid = ASUS_WMI_DEVID_LID_RESUME;
>  	else if (attr == &dev_attr_als_enable.attr)
>  		devid = ASUS_WMI_DEVID_ALS_ENABLE;
> -	else if (attr == &dev_attr_charge_mode.attr)
> +	else if (attr == &dev_attr_fan_boost_mode.attr)
> +		ok = asus->fan_boost_mode_available;
> +
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
> +	if (attr == &dev_attr_charge_mode.attr)
>  		devid = ASUS_WMI_DEVID_CHARGE_MODE;
>  	else if (attr == &dev_attr_egpu_enable.attr)
>  		ok = asus->egpu_enable_available;
> @@ -4546,6 +4614,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		ok = asus->mini_led_dev_id != 0;
>  	else if (attr == &dev_attr_available_mini_led_mode.attr)
>  		ok = asus->mini_led_dev_id != 0;
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
>  
>  	if (devid != -1) {
>  		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
> @@ -4801,6 +4870,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	}
>  
>  	/* ensure defaults for tunables */
> +#if IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS)
>  	asus->ppt_pl2_sppt = 5;
>  	asus->ppt_pl1_spl = 5;
>  	asus->ppt_apu_sppt = 5;
> @@ -4823,17 +4893,18 @@ static int asus_wmi_add(struct platform_device *pdev)
>  		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX;
>  	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_GPU_MUX_VIVO))
>  		asus->gpu_mux_dev = ASUS_WMI_DEVID_GPU_MUX_VIVO;
> -
> -	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE))
> -		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE;
> -	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
> -		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
> +#endif /* IS_ENABLED(CONFIG_ASUS_WMI_DEPRECATED_ATTRS) */
>  
>  	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
>  		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY;
>  	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO))
>  		asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
>  
> +	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE))
> +		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE;
> +	else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
> +		asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
> +
>  	err = fan_boost_mode_check_present(asus);
>  	if (err)
>  		goto fail_fan_boost_mode;
> 

