Return-Path: <linux-kernel+bounces-858009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64836BE88E1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4F1835CC26
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E876A2DC76D;
	Fri, 17 Oct 2025 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irXzLSEw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0250A1B3937;
	Fri, 17 Oct 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760703406; cv=none; b=Mo5aodYEinzSboDWo4Oht9rgrob2TCS2mlIh053gg1W0ZMejL2IVEae0iWXIMGoBkhTmJIxRDf3tiB8qG19ez/e90JwbG8Wm/SkUu/VCV6nB6wCsCI4yV/wLrNut5WSejE1tWJvjKK1yQBDefR9M97nCSJwTu4eqAOH1gFTpHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760703406; c=relaxed/simple;
	bh=eVPjMUpNd4SOXILsRQlQtRLt+NROVCdnUkhjcXXkBLA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B3vGaIm+i0KY1Qd5jPDn7yyNhTg/zliQycXADAeAcrgFJQUgP2YRNkFCOG+kvWxwRXF9dJvZrmvGrPZbgq57uElOnww7KXcJ/vCqYI9g2GNa++9KAzr9+CzYxJi5Uh+ZmhSVprcyeoNC50QmJ4cUEnh+Xct9qW4DHHdUVHlKalg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irXzLSEw; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760703404; x=1792239404;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=eVPjMUpNd4SOXILsRQlQtRLt+NROVCdnUkhjcXXkBLA=;
  b=irXzLSEwnOsdRbkB14/wwkLmo/HkZPMSGk7IA3RHi24r9NajhWQAR2Jv
   TgIIMFCBiRpKZVBCT/UFroPvAI2ej3tQnEjFLPiHPAnoXpmCpEF6C3asp
   k8W20/yHfH+by6H84P316CSD0SG52PQw+JEPY7IwznjY16diCytNxvzxW
   ZQfrOd/3JIV77J4mK3iwrwbCblvwQLB8zvmC61wVQFcUyzy7hhziN6I+6
   hXmMZF0+S/i+lhsCsJ1mrX522Kwwr508cfcv1FHFmTfj+KGS/BTvUOUwi
   PanLbvV3w82ja/SDuyUzQZVSpBGObsukH5Z0fQh/4BZtqmHPIeVAjKk9Y
   A==;
X-CSE-ConnectionGUID: 52ouIIIMTEyinSf8hLhXyA==
X-CSE-MsgGUID: 2ACHA5DnQl2rS43b/AdybQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62122076"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="62122076"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 05:16:43 -0700
X-CSE-ConnectionGUID: EoSQpeWPR8K/r291PyviOw==
X-CSE-MsgGUID: IcTQ3e0QSTCxs85fd5u5Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="186981986"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 05:16:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 17 Oct 2025 15:16:35 +0300 (EEST)
To: Denis Benato <benato.denis96@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, 
    "Limonciello, Mario" <mario.limonciello@amd.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Alok Tiwari <alok.a.tiwari@oracle.com>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
Subject: Re: [PATCH v14 4/9] platform/x86: asus-armoury: add apu-mem control
 support
In-Reply-To: <20251015014736.1402045-5-benato.denis96@gmail.com>
Message-ID: <61c69499-fb69-0642-915d-e3072d2dbd21@linux.intel.com>
References: <20251015014736.1402045-1-benato.denis96@gmail.com> <20251015014736.1402045-5-benato.denis96@gmail.com>
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
> Implement the APU memory size control under the asus-armoury module using
> the fw_attributes class.
> 
> This allows the APU allocated memory size to be adjusted depending on
> the users priority. A reboot is required after change.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> ---
>  drivers/platform/x86/asus-armoury.c        | 81 ++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  2 +
>  2 files changed, 83 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index 68ce2c159ae1..3b49a27e397d 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -394,6 +394,86 @@ static ssize_t egpu_enable_current_value_store(struct kobject *kobj, struct kobj
>  WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU);
>  ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
>  
> +/* Device memory available to APU */
> +
> +/* Values map for APU memory: some looks out of order but are actually correct */
> +static u32 apu_mem_map[] = {
> +	[0] = 0x000, /* called "AUTO" on the BIOS, is the minimum available */
> +	[1] = 0x102,
> +	[2] = 0x103,
> +	[3] = 0x104,
> +	[4] = 0x105,
> +	[5] = 0x107,
> +	[6] = 0x108,
> +	[7] = 0x109,
> +	[8] = 0x106,

Is BIT(8) actually telling non-AUTO here? I mean, it's not set for the 
AUTO case. If it has this special meaning, maybe that should be left out 
of this array and handled by the show/store functions as it seems 
different for the auto depending on which way the information is being 
passed.

> +};
> +
> +static ssize_t apu_mem_current_value_show(struct kobject *kobj, struct kobj_attribute *attr,
> +					  char *buf)
> +{
> +	int err;
> +	u32 mem;
> +
> +	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_APU_MEM, &mem);
> +	if (err)
> +		return err;
> +
> +	if ((mem & ASUS_WMI_DSTS_PRESENCE_BIT) == 0)
> +		return -ENODEV;
> +
> +	mem &= ~ASUS_WMI_DSTS_PRESENCE_BIT;
> +
> +	/* After 0x000 is set, a read will return 0x100 */
> +	if (mem == 0x100)
> +		return sysfs_emit(buf, "0\n");
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(apu_mem_map); i++) {
> +		if (apu_mem_map[i] == mem)
> +			return sysfs_emit(buf, "%u\n", i);
> +	}
> +
> +	pr_warn("Unrecognised value for APU mem 0x%08x\n", mem);
> +	return sysfs_emit(buf, "%u\n", mem);

??

Should this return -EIO or something like that instead. It definitely 
looks wrong to first log it as %x and then output to sysfs as %u.

> +}
> +
> +static ssize_t apu_mem_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +	int result, err;
> +	u32 requested, mem;
> +
> +	result = kstrtou32(buf, 10, &requested);
> +	if (result)
> +		return result;
> +
> +	if (requested >= ARRAY_SIZE(apu_mem_map))
> +		return -EINVAL;
> +
> +	mem = apu_mem_map[requested];
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_APU_MEM, mem, &result);
> +	if (err) {
> +		pr_warn("Failed to set apu_mem: %d\n", err);
> +		return err;
> +	}
> +
> +	pr_info("APU memory changed to %uGB, reboot required\n", requested+1);

requested + 1

Please mention GB up where the array is.

> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +	asus_set_reboot_and_signal_event();
> +
> +	return count;
> +}
> +
> +static ssize_t apu_mem_possible_values_show(struct kobject *kobj, struct kobj_attribute *attr,
> +					    char *buf)
> +{
> +	BUILD_BUG_ON(ARRAY_SIZE(apu_mem_map) != 9);
> +	return sysfs_emit(buf, "0;1;2;3;4;5;6;7;8\n");

You could make this future proof with a for loop and sysfs_emit_at() and 
drop the BUILD_BUG_ON(). Maybe all these multi-valued show functions could 
share a helper which does that.

> +}
> +ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set available system RAM (in GB) for the APU to use");
> +
>  /* Simple attribute creation */
>  ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
>  		       "Show the current mode of charging");
> @@ -414,6 +494,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>  	{ &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
>  	{ &egpu_enable_attr_group, ASUS_WMI_DEVID_EGPU },
>  	{ &dgpu_disable_attr_group, ASUS_WMI_DEVID_DGPU },
> +	{ &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
>  
>  	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>  	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 10acd5d52e38..a4f6bab93a6f 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -137,6 +137,8 @@
>  /* dgpu on/off */
>  #define ASUS_WMI_DEVID_DGPU		0x00090020
>  
> +#define ASUS_WMI_DEVID_APU_MEM		0x000600C1
> +
>  /* gpu mux switch, 0 = dGPU, 1 = Optimus */
>  #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
>  #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026
> 

-- 
 i.


