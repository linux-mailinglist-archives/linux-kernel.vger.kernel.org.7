Return-Path: <linux-kernel+bounces-860523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EAABF0520
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8B03BA031
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C8E23D290;
	Mon, 20 Oct 2025 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHCopz3M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3072F12CA;
	Mon, 20 Oct 2025 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953936; cv=none; b=T36wdWNFjBDInfybFEW0lK5ifulejBk+U3UHOxV718EmuxCJVJ/3DHMNDq4zH0abJYyon7vAClIVqQRD4H6SLw62Ns58pCUEy2QbKtAxJHObVjHu0wrWeiCPdLEs0ziWySwb57liI57XqQ55fEUmDGV4RfdyTBhUXvj3IGDVpZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953936; c=relaxed/simple;
	bh=XriBJIddsaKWx8Da2RYbDDQAEdnpJC1tY8CP4DJlTj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjR8r2+lgvnWSzmIAn8mujqlJk8WKrIt2D/gkWH0FogXnNhNmfFPUa9RsONC4DJb6bwfdPVoT53qkZUcWaddE9s+IiOtTF1KgVcOzX1knyuBS13Hra+VgV6t8rHyTg3+DwAzUtTevsFHga0Pr30FlkY2wgz7/a6TYplM5xtM6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHCopz3M; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760953934; x=1792489934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XriBJIddsaKWx8Da2RYbDDQAEdnpJC1tY8CP4DJlTj4=;
  b=HHCopz3McQaY3DG0lmdNCxS0uQa7eRDs+ONvWFL3d0AygupDaYUaB0de
   Ocp+SpK8uB+O5J3qedD5MqvJRpmohYHoy/zSCzzr1P52OgCnOAiR9zh2O
   vIxGcYLj8nQ0nhmlD+pOrnaIsX3HPep6k6OBReD14qMx69ANwmOEYbT6N
   6rR2nyyHlD5pievPw7aOnL4WlyoWqAso0pgikyL6J46EO1R73v0tBduot
   G431dc1O4FEgtC2KtOO8VrXgIagJmDs21GzIYsyH+8xACq/QjGHS5cOna
   hW1260iHj7erFlIhsuIKuE4x8/kuIkqFns8gSuIUPg8JFOxp3eczG/R7d
   Q==;
X-CSE-ConnectionGUID: Sp7dP3bYSCC4ooJtbn105Q==
X-CSE-MsgGUID: KjlKhCw6Ro+fnmbDO9VB9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62985397"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62985397"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 02:52:13 -0700
X-CSE-ConnectionGUID: ySitvfI7QTmsIQ969iCSdA==
X-CSE-MsgGUID: B09bY3bST9ajXvaSCeFJEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="183703018"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO kuha.fi.intel.com) ([10.124.220.112])
  by fmviesa008.fm.intel.com with SMTP; 20 Oct 2025 02:52:10 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 20 Oct 2025 12:52:09 +0300
Date: Mon, 20 Oct 2025 12:52:09 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: gregkh@linuxfoundation.org, amitsd@google.com, kyletso@google.com,
	rdbabiera@google.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: pd: Register SPR AVS caps with
 usb_power_delivery class
Message-ID: <aPYGScL2G3sCMfFj@kuha.fi.intel.com>
References: <20251015043017.3382908-1-badhri@google.com>
 <20251015043017.3382908-2-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015043017.3382908-2-badhri@google.com>

On Wed, Oct 15, 2025 at 04:30:14AM +0000, Badhri Jagan Sridharan wrote:
> usb_power_delivery class will now display AVS cap as
> `spr_adjustable_voltage_supply`. `maximum_current_9V_to_15V` and
> `maximum_current_15V_to_20V` shows the corresponding current limits
> in mA. `peak_current` follows the same convention as fixed_supply
> where the value reported in the capabilities message is displayed
> as is.
> 
> Sample output with an SPR AVS capable PD charger:
> $cat /sys/class/usb_power_delivery/pd1/source-capabilities/5:spr_adjustable_voltage_supply/maximum_current_9V_to_15V
> 4000mA
> 
> $cat /sys/class/usb_power_delivery/pd1/source-capabilities/5:spr_adjustable_voltage_supply/maximum_current_15V_to_20V
> 3350mA
> 
> $cat /sys/class/usb_power_delivery/pd1/source-capabilities/5:spr_adjustable_voltage_supply/peak_current
> 0
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since V1:
> * Fixed incorrect squash
> ---
>  .../testing/sysfs-class-usb_power_delivery    | 28 ++++++
>  drivers/usb/typec/pd.c                        | 95 ++++++++++++++++++-
>  2 files changed, 118 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-usb_power_delivery b/Documentation/ABI/testing/sysfs-class-usb_power_delivery
> index 61d233c320ea..c754458a527e 100644
> --- a/Documentation/ABI/testing/sysfs-class-usb_power_delivery
> +++ b/Documentation/ABI/testing/sysfs-class-usb_power_delivery
> @@ -254,3 +254,31 @@ Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
>  Description:
>  		The PPS Power Limited bit indicates whether or not the source
>  		supply will exceed the rated output power if requested.
> +
> +Standard Power Range (SPR) Adjustable Voltage Supplies
> +
> +What:		/sys/class/usb_power_delivery/.../<capability>/<position>:spr_adjustable_voltage_supply
> +Date:		Oct 2025
> +Contact:	Badhri Jagan Sridharan <badhri@google.com>
> +Description:
> +		Adjustable Voltage Supply (AVS) Augmented PDO (APDO).
> +
> +What:		/sys/class/usb_power_delivery/.../<capability>/<position>:spr_adjustable_voltage_supply/maximum_current_9V_to_15V
> +Date:		Oct 2025
> +Contact:	Badhri Jagan Sridharan <badhri@google.com>
> +Description:
> +		Maximum Current for 9V to 15V range in milliamperes.
> +
> +What:		/sys/class/usb_power_delivery/.../<capability>/<position>:spr_adjustable_voltage_supply/maximum_current_15V_to_20V
> +Date:		Oct 2025
> +Contact:	Badhri Jagan Sridharan <badhri@google.com>
> +Description:
> +		Maximum Current for greater than 15V till 20V range in
> +		milliamperes.
> +
> +What:		/sys/class/usb_power_delivery/.../<capability>/<position>:spr_adjustable_voltage_supply/peak_current
> +Date:		Oct 2025
> +Contact:	Badhri Jagan Sridharan <badhri@google.com>
> +Description:
> +		This file shows the value of the Adjustable Voltage Supply Peak Current
> +		Capability field.
> diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
> index d78c04a421bc..67f20b5ffdf4 100644
> --- a/drivers/usb/typec/pd.c
> +++ b/drivers/usb/typec/pd.c
> @@ -359,6 +359,84 @@ static const struct device_type sink_pps_type = {
>  	.groups = sink_pps_groups,
>  };
>  
> +/* -------------------------------------------------------------------------- */
> +/* Standard Power Range (SPR) Adjustable Voltage Supply (AVS) */
> +
> +static ssize_t
> +spr_avs_9v_to_15v_max_current_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%umA\n",
> +			  pdo_spr_avs_apdo_9v_to_15v_max_current_ma(to_pdo(dev)->pdo));
> +}
> +
> +static ssize_t
> +spr_avs_15v_to_20v_max_current_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%umA\n",
> +			  pdo_spr_avs_apdo_15v_to_20v_max_current_ma(to_pdo(dev)->pdo));
> +}
> +
> +static ssize_t
> +spr_avs_src_peak_current_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n",
> +			  pdo_spr_avs_apdo_src_peak_current(to_pdo(dev)->pdo));
> +}
> +
> +static struct device_attribute spr_avs_9v_to_15v_max_current_attr = {
> +	.attr = {
> +		.name = "maximum_current_9V_to_15V",
> +		.mode = 0444,
> +	},
> +	.show = spr_avs_9v_to_15v_max_current_show,
> +};
> +
> +static struct device_attribute spr_avs_15v_to_20v_max_current_attr = {
> +	.attr = {
> +		.name = "maximum_current_15V_to_20V",
> +		.mode = 0444,
> +	},
> +	.show = spr_avs_15v_to_20v_max_current_show,
> +};
> +
> +static struct device_attribute spr_avs_src_peak_current_attr = {
> +	.attr = {
> +		.name = "peak_current",
> +		.mode = 0444,
> +	},
> +	.show = spr_avs_src_peak_current_show,
> +};
> +
> +static struct attribute *source_spr_avs_attrs[] = {
> +	&spr_avs_9v_to_15v_max_current_attr.attr,
> +	&spr_avs_15v_to_20v_max_current_attr.attr,
> +	&spr_avs_src_peak_current_attr.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(source_spr_avs);
> +
> +static const struct device_type source_spr_avs_type = {
> +	.name = "pdo",
> +	.release = pdo_release,
> +	.groups = source_spr_avs_groups,
> +};
> +
> +static struct attribute *sink_spr_avs_attrs[] = {
> +	&spr_avs_9v_to_15v_max_current_attr.attr,
> +	&spr_avs_15v_to_20v_max_current_attr.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(sink_spr_avs);
> +
> +static const struct device_type sink_spr_avs_type = {
> +	.name = "pdo",
> +	.release = pdo_release,
> +	.groups = sink_spr_avs_groups,
> +};
> +
>  /* -------------------------------------------------------------------------- */
>  
>  static const char * const supply_name[] = {
> @@ -368,7 +446,8 @@ static const char * const supply_name[] = {
>  };
>  
>  static const char * const apdo_supply_name[] = {
> -	[APDO_TYPE_PPS]  = "programmable_supply",
> +	[APDO_TYPE_PPS]      = "programmable_supply",
> +	[APDO_TYPE_SPR_AVS]  = "spr_adjustable_voltage_supply",
>  };
>  
>  static const struct device_type *source_type[] = {
> @@ -378,7 +457,8 @@ static const struct device_type *source_type[] = {
>  };
>  
>  static const struct device_type *source_apdo_type[] = {
> -	[APDO_TYPE_PPS]  = &source_pps_type,
> +	[APDO_TYPE_PPS]     = &source_pps_type,
> +	[APDO_TYPE_SPR_AVS] = &source_spr_avs_type,
>  };
>  
>  static const struct device_type *sink_type[] = {
> @@ -388,7 +468,8 @@ static const struct device_type *sink_type[] = {
>  };
>  
>  static const struct device_type *sink_apdo_type[] = {
> -	[APDO_TYPE_PPS]  = &sink_pps_type,
> +	[APDO_TYPE_PPS]     = &sink_pps_type,
> +	[APDO_TYPE_SPR_AVS] = &sink_spr_avs_type,
>  };
>  
>  /* REVISIT: Export when EPR_*_Capabilities need to be supported. */
> @@ -407,8 +488,12 @@ static int add_pdo(struct usb_power_delivery_capabilities *cap, u32 pdo, int pos
>  	p->object_position = position;
>  
>  	if (pdo_type(pdo) == PDO_TYPE_APDO) {
> -		/* FIXME: Only PPS supported for now! Skipping others. */
> -		if (pdo_apdo_type(pdo) > APDO_TYPE_PPS) {
> +		/*
> +		 * FIXME: Only PPS, SPR_AVS supported for now!
> +		 * Skipping others.
> +		 */
> +		if (pdo_apdo_type(pdo) != APDO_TYPE_PPS &&
> +		    pdo_apdo_type(pdo) != APDO_TYPE_SPR_AVS) {
>  			dev_warn(&cap->dev, "Unknown APDO type. PDO 0x%08x\n", pdo);
>  			kfree(p);
>  			return 0;
> -- 
> 2.51.0.858.gf9c4a03a3a-goog

-- 
heikki

