Return-Path: <linux-kernel+bounces-828808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DB7B9589A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3731175F16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CEF32144D;
	Tue, 23 Sep 2025 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diKdR+y+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F6460B8A;
	Tue, 23 Sep 2025 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625134; cv=none; b=RTkGhgzwriXe+wtOb0FTTmldSL+Crr7RX1aWr9zTxY0dUimVQvw9hzbp2sJGWxMIeHH6oLy15R0S+nXMmv1+IR0yBAAmzluGhH5B0mR8j5AMoLRyQNPwAEIvriVPt6RuJjGdFUj4jhTDZQWcKMC4cxH8lio5Z0lkKF0RrjcuVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625134; c=relaxed/simple;
	bh=7dXiJ5vxlZVNAbnCOicOtemenL/y6O2PAMg/vHblEZY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HKOWKpEwaJFLYkcBm7KGnXlEm16V7oUPD73lKMnW1euC2/S6VPTYwFYBJsto2bcV6yVigLWw5c5usXzzm+ovwPpeEtXFSpmeA+5G2HSTjubUNGnDftVT4OsLfj9QQYoX/aNWJJhJDxcnW5kS0s2z0Caih3uLLt0iZyG/RZELtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diKdR+y+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758625133; x=1790161133;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7dXiJ5vxlZVNAbnCOicOtemenL/y6O2PAMg/vHblEZY=;
  b=diKdR+y+9+R3oUJ6mAI6xMWbRHsxY9tQWyzAVaEq9J2B2xjcAs44bkiv
   pt3QimEmXcsAAoYoW5EWZqarCvWYqtoYlI6hIRQs8ab6Di/rJMj5axqv0
   m/khn/SsAexzTZtnSV5DuqYLvGN9qkJ9CbjmV6rmKZse0NoMsfk5z7x4G
   7YIb9QtMqFXKxrEHkkNlsgq0d7A89afHRS5GFuOKpXCouNJwH4ljElVNG
   9D+WB7CHzhPjxtmMQTmRzkgPUJEsP1yAuqY0g5y9TqGJ4UITtFIvn+Et7
   CPHxAJ7ceRlATTEOPzI4IM9U6/AvH6Oja7Ni+mnRvuoLYZVomp3olb00y
   g==;
X-CSE-ConnectionGUID: SDdyJsmsTEmWBLX4PPBP8A==
X-CSE-MsgGUID: kllOLrlWTU+n8NOq9pBZEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="61070163"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="61070163"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 03:58:52 -0700
X-CSE-ConnectionGUID: ZDmbx+JvSiSh/Qn2HI9bKQ==
X-CSE-MsgGUID: Bvuo/pZLTCO3Az+I4q/L6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; 
   d="scan'208";a="177520223"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 03:58:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 23 Sep 2025 13:58:45 +0300 (EEST)
To: Ciju Rajan K <crajank@nvidia.com>
cc: hdegoede@redhat.com, tglx@linutronix.de, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, christophe.jaillet@wanadoo.fr, 
    platform-driver-x86@vger.kernel.org, vadimp@nvidia.com
Subject: Re: [PATCH platform-next v2 1/2] [PATCH platform-next 1/2]
 platform_data/mlxreg: Add fields for interrupt storm handling
In-Reply-To: <20250923104452.2407460-2-crajank@nvidia.com>
Message-ID: <4d131477-f188-7a42-e382-6168299fa5cf@linux.intel.com>
References: <20250923104452.2407460-1-crajank@nvidia.com> <20250923104452.2407460-2-crajank@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 23 Sep 2025, Ciju Rajan K wrote:

> Add fields for interrupt storm handling.
> Extend structure mlxreg_core_data with the following fields:
>  'wmark_cntr'   - interrupt storm counter.
>  'wmark_window' - time window to count interrupts to check for storm.
> 
> Extend structure mlxreg_core_item with the following field:
>  'storming_bits' - interrupt storming bits mask.
> 
> Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
> Signed-off-by: Ciju Rajan K <crajank@nvidia.com>
> ---
>  include/linux/platform_data/mlxreg.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
> index f6cca7a035c7..453c8dfd7eb9 100644
> --- a/include/linux/platform_data/mlxreg.h
> +++ b/include/linux/platform_data/mlxreg.h
> @@ -131,6 +131,8 @@ struct mlxreg_hotplug_device {
>   * @regnum: number of registers occupied by multi-register attribute;
>   * @slot: slot number, at which device is located;
>   * @secured: if set indicates that entry access is secured;
> + * @wmark_cntr: interrupt storm counter;
> + * @wmark_window: time window to count interrupts to check for storm;
>   */
>  struct mlxreg_core_data {
>  	char label[MLXREG_CORE_LABEL_MAX_SIZE];
> @@ -151,6 +153,8 @@ struct mlxreg_core_data {
>  	u8 regnum;
>  	u8 slot;
>  	u8 secured;
> +	unsigned int wmark_cntr;
> +	unsigned long wmark_window;
>  };
>  
>  /**
> @@ -167,6 +171,7 @@ struct mlxreg_core_data {
>   * @ind: element's index inside the group;
>   * @inversed: if 0: 0 for signal status is OK, if 1 - 1 is OK;
>   * @health: true if device has health indication, false in other case;
> + * @storming_bits: interrupt storming bits mask;
>   */
>  struct mlxreg_core_item {
>  	struct mlxreg_core_data *data;
> @@ -180,6 +185,7 @@ struct mlxreg_core_item {
>  	u8 ind;
>  	u8 inversed;
>  	u8 health;
> +	u32 storming_bits;
>  };
>  
>  /**
> 

I don't know what's the benefit of having this as a separate patch, the 
fields are getting used in patch 2 so it would feel natural to introduce 
them there so the entire change would end up into the same commit.

-- 
 i.


