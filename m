Return-Path: <linux-kernel+bounces-740888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5CCB0DAAA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EC35608C6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C52E11BA;
	Tue, 22 Jul 2025 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9OmMQM2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2654E1E87B;
	Tue, 22 Jul 2025 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190532; cv=none; b=cl+zfawib8F2Zp8xBSFOKoy1KVbcCmljf9kqqixNIxqZ5M+pKb65RQv+AmodAbNGKyJo2Bfgj4yVmQlZ6TI71LLELicuu1Dd08RQ1mQuIwZiy0OwB8QLejvVSPIPgBERZpc4FuuW8RLFTY4lg9CWBhx+vYLyxaig6Cmv+58EHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190532; c=relaxed/simple;
	bh=hiiVm3MoevvxwaLZGF2qvRK1a9a+D7ISr391Qo+7l1U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e0Q+3tbgCKkDUh2nX7bU+Y0tTx3vgLmUw7W4oz/w7HDxwJUlgNEOFUVBO35nGLJ/sBoJqR85GOfr2XpfgZRXPFLmayQQvWiqA5A2Pn9fxGfUQ27LlugBPtg8lA2YEthZ4scmCdw+ZNHlYD9VqMZj5NlmUtr/OvbNp1v1LlFfkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9OmMQM2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753190531; x=1784726531;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hiiVm3MoevvxwaLZGF2qvRK1a9a+D7ISr391Qo+7l1U=;
  b=m9OmMQM2XMpAdVAgkmTFW1H2frn4vR5hqy9NzhuVQUJfgJF79dYR/5F2
   IUXREM8Jrwv2/sLiOF2YJUzz8558H2OhWrbkp5gsJ8m5TAMFBMT0Bf0AJ
   Vz0FithQOXpH61e2o+NaWZYiUDwapNh0DXOTNv8w+ilm+YxiNoW+Y8FmP
   KOrqkPMfP6/aHLpGD1hvZCoDMja0nY9sA5eNb7rN71oSUEqoNt5Krsk2k
   1pes6uSfs5zAFmPj2MdZJqnkE8duGhQNkjUN0MWbA+74AG2QMkasZtbS3
   rfaZ1D+JOCAR7pJUM1sGXPc/3ANZOajPCfnYXrmedJxsrv5UqiaVtCo5o
   Q==;
X-CSE-ConnectionGUID: wZTu94KDSdOlzcvKMBrb3w==
X-CSE-MsgGUID: mSU+8pKBTha46E+7DEL1rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="54540862"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="54540862"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 06:22:10 -0700
X-CSE-ConnectionGUID: b8V5oskZR2axqEKr0Ngb9A==
X-CSE-MsgGUID: wdUO5vqBRVWmiEp7q2eYHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="182842135"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.254])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 06:22:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 22 Jul 2025 16:22:04 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Hans de Goede <hdegoede@redhat.com>, Eileen <eileen@one-netbook.com>
Subject: Re: [PATCH v1 1/2] platform/x86: oxpec: Fix turbo register for G1
 AMD
In-Reply-To: <20250718163305.159232-1-lkml@antheas.dev>
Message-ID: <710baf02-fc18-6752-b8bd-bbf1354227e8@linux.intel.com>
References: <20250718163305.159232-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 18 Jul 2025, Antheas Kapenekakis wrote:

> Turns out that the AMD variant of the G1 uses different turbo registers
> than the Intel variant. Differentiate them and apply the correct ones
> to the AMD variant.
> 
> Fixes: b369395c895b ("platform/x86: oxpec: Add support for the OneXPlayer G1")
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 37 +++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index 06759036945d..9839e8cb82ce 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -58,7 +58,8 @@ enum oxp_board {
>  	oxp_mini_amd_a07,
>  	oxp_mini_amd_pro,
>  	oxp_x1,
> -	oxp_g1,
> +	oxp_g1_i,
> +	oxp_g1_a,
>  };
>  
>  static enum oxp_board board;
> @@ -247,14 +248,14 @@ static const struct dmi_system_id dmi_table[] = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
>  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER G1 A"),
>  		},
> -		.driver_data = (void *)oxp_g1,
> +		.driver_data = (void *)oxp_g1_a,
>  	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
>  			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER G1 i"),
>  		},
> -		.driver_data = (void *)oxp_g1,
> +		.driver_data = (void *)oxp_g1_i,
>  	},
>  	{
>  		.matches = {


> -	case oxp_g1:
> +	case oxp_g1_i:
>  		return read_from_ec(OXP_2_SENSOR_FAN_REG, 2, val);
> @@ -757,6 +765,7 @@ static int oxp_pwm_fan_speed(long *val)
> +	case oxp_g1_a:
>  		return read_from_ec(OXP_SENSOR_FAN_REG, 2, val);

> -	case oxp_g1:
> +	case oxp_g1_i:
>  		/* scale to range [0-184] */
>  		val = (val * 184) / 255;
>  		return write_to_ec(OXP_SENSOR_PWM_REG, val);
> @@ -796,6 +805,7 @@ static int oxp_pwm_input_write(long val)
> +	case oxp_g1_a:
>  		return write_to_ec(OXP_SENSOR_PWM_REG, val);
> @@ -816,7 +826,7 @@ static int oxp_pwm_input_read(long *val)
> -	case oxp_g1:
> +	case oxp_g1_i:
>  		ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
> @@ -842,6 +852,7 @@ static int oxp_pwm_input_read(long *val)
> +	case oxp_g1_a:
>  	default:
>  		ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);

Do these FAN and PWM registers fall under what is described in the 
changelog as "turbo registers"? Or did you extend the scope of this patch 
and forgot to update the changelog?


-- 
 i.


