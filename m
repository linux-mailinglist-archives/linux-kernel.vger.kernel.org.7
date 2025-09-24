Return-Path: <linux-kernel+bounces-830383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9534BB9984F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F196F7A2EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6392E3B08;
	Wed, 24 Sep 2025 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9NBSlHU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9F2D77F1;
	Wed, 24 Sep 2025 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711667; cv=none; b=A8mgWHh4nZPnbE6hRhHIrKnwp0mkUS+yRryDQY3ahmGMkHGTiM+KCQwDs57diJ2KvecXJX56UVArf4Jxb6rwelfQ2AkUpU94vv9mBwvdcLW2XUCxf9lW1PKQouPZlv2Q7j+qWfH0wzZZf38vZ10Elw14DYpTBQCiUGzE2x/RHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711667; c=relaxed/simple;
	bh=FWi+sdP+3A5sl++XyQXcfBP4+Bq72Kxuhvvsb8DdlHM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A3MvcSEcqhWJvQVJAd+ttR3l2D1Nk8GD5CAoKSnnt8LHCk+YvFycZ2A3mTmqiSSm/83CV3/92M4gy6L9E2NId3aH4R+OswufHy4wkzW7qBtdpN9tzLM7xbQ11N0ODYDxJgeCRDJl4jJttQ0QdrU3u6GCEtPxCMVF03OPu/1cnyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9NBSlHU; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758711666; x=1790247666;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FWi+sdP+3A5sl++XyQXcfBP4+Bq72Kxuhvvsb8DdlHM=;
  b=m9NBSlHUJFnUC5A1DWcr9LZgayEKcdL3h8/VslEpt9WvidYKep//6jc7
   X2PYe+Y9DDOZkL8l/UdY4h2HZt1jAWjen8UIJOorIbyeE+1hjBy6BBAip
   Xe5fy8b2/yVWKM2uhXKZmbgwTo+G7zbFUDoSW0MpkFb6HJINNR0dDTnPt
   pC9V8GE8FdrSE6o8vl7vlWYCBQ1k3Jme4Ss2lkq7AMen3FzcVeFw7A2ut
   MzWwYWLWeePx7rKO2r9YDqNcTkceNAjZiSYt0xdashy6yRUTKlzMGHTV3
   EToJsDSm7WlgMUbg3bHSXUw5NNFkxpJ9kBakt7qio6AjsKG1Lrvz6jkhG
   Q==;
X-CSE-ConnectionGUID: DHOi0KWEQdCgtnu4144Pvw==
X-CSE-MsgGUID: gsCFcO6kRwCBRzlxiI/MMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="72361976"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="72361976"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 04:00:45 -0700
X-CSE-ConnectionGUID: dnRZxMOrTViMZYn0IV0trw==
X-CSE-MsgGUID: MbDbjP3iQB2NzSuPYd6zqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; 
   d="scan'208";a="181297301"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.210])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 04:00:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 24 Sep 2025 14:00:36 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: jlee@suse.com, basak.sb2006@gmail.com, rayanmargham4@gmail.com, 
    kuurtb@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] platform/x86: acer-wmi: Fix setting of fan
 behavior
In-Reply-To: <20250923215205.326367-2-W_Armin@gmx.de>
Message-ID: <f1be3296-4cae-3c0e-3b5f-23774f20f37a@linux.intel.com>
References: <20250923215205.326367-1-W_Armin@gmx.de> <20250923215205.326367-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 23 Sep 2025, Armin Wolf wrote:

> After studying the linuwu_sense driver
> (https://github.com/0x7375646F/Linuwu-Sense) i was able to understand
> the meaning of the SetGamingFanBehavior() WMI method:
> 
> - the first 16-bit are a bitmap of all fans affected by a fan behavior
>   change request.
> 
> - the next 8 bits contain four fan mode fields (2-bit), each being
>   associated with a bit inside the fan bitmap.
> 
> There are three fan modes: auto, turbo and custom.
> 
> Use this newfound knowledge to fix the turbo fan handling by setting
> the correct bits before calling SetGamingFanBehavior(). Also check
> the result of the WMI method call and return an error should the ACPI
> firmware signal failure.
> 
> Reviewed-by: Kurt Borja <kuurtb@gmail.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/acer-wmi.c | 76 +++++++++++++++++++++++----------
>  1 file changed, 53 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 69336bd778ee..a41555ee8589 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -68,10 +68,19 @@ MODULE_LICENSE("GPL");
>  #define ACER_WMID_SET_GAMING_LED_METHODID 2
>  #define ACER_WMID_GET_GAMING_LED_METHODID 4
>  #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
> -#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
> +#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
>  #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
>  #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23
>  
> +#define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
> +#define ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK GENMASK_ULL(23, 16)
> +
> +#define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
> +#define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
> +
> +#define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
> +#define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)
> +
>  #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
>  #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
>  #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
> @@ -121,6 +130,12 @@ enum acer_wmi_predator_v4_sensor_id {
>  	ACER_WMID_SENSOR_GPU_TEMPERATURE	= 0x0A,
>  };
>  
> +enum acer_wmi_gaming_fan_mode {
> +	ACER_WMID_FAN_MODE_AUTO		= 0x01,
> +	ACER_WMID_FAN_MODE_TURBO	= 0x02,
> +	ACER_WMID_FAN_MODE_CUSTOM	= 0x03,
> +};
> +
>  enum acer_wmi_predator_v4_oc {
>  	ACER_WMID_OC_NORMAL			= 0x0000,
>  	ACER_WMID_OC_TURBO			= 0x0002,
> @@ -1565,9 +1580,6 @@ static acpi_status WMID_gaming_set_u64(u64 value, u32 cap)
>  	case ACER_CAP_TURBO_LED:
>  		method_id = ACER_WMID_SET_GAMING_LED_METHODID;
>  		break;
> -	case ACER_CAP_TURBO_FAN:
> -		method_id = ACER_WMID_SET_GAMING_FAN_BEHAVIOR;
> -		break;
>  	default:
>  		return AE_BAD_PARAMETER;
>  	}
> @@ -1618,25 +1630,43 @@ static int WMID_gaming_get_sys_info(u32 command, u64 *out)
>  	return 0;
>  }
>  
> +static int WMID_gaming_set_fan_behavior(u16 fan_bitmap, u8 mode_bitmap)

Should the name be in plural as this sets all fans?

Please also consider what I noted to patch 2 about this nesting of 
FIELD_PREP()s. Getting rid of that effectively means the caller ORs all 
bits together but I don't think that would make the code harder to read.

> +{
> +	acpi_status status;
> +	u64 input = 0;
> +	u64 result;
> +
> +	input |= FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitmap);
> +	input |= FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK, mode_bitmap);
> +
> +	status = WMI_gaming_execute_u64(ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID, input,
> +					&result);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +
> +	/* The return status must be zero for the operation to have succeeded */
> +	if (FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK, result))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
>  static void WMID_gaming_set_fan_mode(u8 fan_mode)
>  {
> -	/* fan_mode = 1 is used for auto, fan_mode = 2 used for turbo*/
> -	u64 gpu_fan_config1 = 0, gpu_fan_config2 = 0;
> -	int i;
> -
> -	if (quirks->cpu_fans > 0)
> -		gpu_fan_config2 |= 1;
> -	for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
> -		gpu_fan_config2 |= 1 << (i + 1);
> -	for (i = 0; i < quirks->gpu_fans; ++i)
> -		gpu_fan_config2 |= 1 << (i + 3);
> -	if (quirks->cpu_fans > 0)
> -		gpu_fan_config1 |= fan_mode;
> -	for (i = 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
> -		gpu_fan_config1 |= fan_mode << (2 * i + 2);
> -	for (i = 0; i < quirks->gpu_fans; ++i)
> -		gpu_fan_config1 |= fan_mode << (2 * i + 6);
> -	WMID_gaming_set_u64(gpu_fan_config2 | gpu_fan_config1 << 16, ACER_CAP_TURBO_FAN);
> +	u16 mode_bitmap = 0;
> +	u16 fan_bitmap = 0;
> +
> +	if (quirks->cpu_fans > 0) {
> +		fan_bitmap |= ACER_GAMING_FAN_BEHAVIOR_CPU;
> +		mode_bitmap |= FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK, fan_mode);
> +	}
> +
> +	if (quirks->gpu_fans > 0) {
> +		fan_bitmap |= ACER_GAMING_FAN_BEHAVIOR_GPU;
> +		mode_bitmap |= FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK, fan_mode);
> +	}
> +
> +	WMID_gaming_set_fan_behavior(fan_bitmap, mode_bitmap);
>  }
>  
>  static int WMID_gaming_set_misc_setting(enum acer_wmi_gaming_misc_setting setting, u8 value)
> @@ -1923,7 +1953,7 @@ static int acer_toggle_turbo(void)
>  		WMID_gaming_set_u64(0x1, ACER_CAP_TURBO_LED);
>  
>  		/* Set FAN mode to auto */
> -		WMID_gaming_set_fan_mode(0x1);
> +		WMID_gaming_set_fan_mode(ACER_WMID_FAN_MODE_AUTO);
>  
>  		/* Set OC to normal */
>  		if (has_cap(ACER_CAP_TURBO_OC)) {
> @@ -1937,7 +1967,7 @@ static int acer_toggle_turbo(void)
>  		WMID_gaming_set_u64(0x10001, ACER_CAP_TURBO_LED);
>  
>  		/* Set FAN mode to turbo */
> -		WMID_gaming_set_fan_mode(0x2);
> +		WMID_gaming_set_fan_mode(ACER_WMID_FAN_MODE_TURBO);
>  
>  		/* Set OC to turbo mode */
>  		if (has_cap(ACER_CAP_TURBO_OC)) {
> 

-- 
 i.


