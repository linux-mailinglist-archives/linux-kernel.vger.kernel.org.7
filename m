Return-Path: <linux-kernel+bounces-731286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E0B0523C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5017B36FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5D826E718;
	Tue, 15 Jul 2025 06:53:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1276226A0EB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752562411; cv=none; b=c5qnaAxzfMHx4/ClWMaKgQxLA+IYa6WeLts6pIfm5SqcoHJCgf+n2AogoTaZiuB7oKds/MEp7ZiFYiZTu18VEQqHfBkjyMKplCFz0tleJGetR+A2XHToebhqmQu6pBJXbKBmjlMInJxZA5y31seJvTI0u+DiFgfTcjUx/g0fWkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752562411; c=relaxed/simple;
	bh=bDQOdgNeBInUAX9BNvl8ibVHDUes0QgSrzPKjG3sHY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAUtgq7NKLqXMwSFCwjf3hAVqAZVbQTmN23WAqA68mZDYgcQJwrXrvxBQJ4GtKjUNf86HNjn/E5Iy9KuAEAo39+AxXgwEH0kb/SoWm5psBMICSDqMkrIUGa4zOuz/vwGIbU4FP+fpBJt6Kl6OzC7lL+I9V5swLBWqNKcOYoOuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4171E12FC;
	Mon, 14 Jul 2025 23:53:20 -0700 (PDT)
Received: from [10.163.92.132] (unknown [10.163.92.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DAC13F66E;
	Mon, 14 Jul 2025 23:53:24 -0700 (PDT)
Message-ID: <cd8cba00-b495-4aab-b63c-699bb2c12d48@arm.com>
Date: Tue, 15 Jul 2025 12:23:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/28] coresight: Change device mode to atomic type
To: Leo Yan <leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Yabin Cui <yabinc@google.com>, Keita Morisaki <keyz@google.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250701-arm_cs_pm_fix_v3-v2-0-23ebb864fcc1@arm.com>
 <20250701-arm_cs_pm_fix_v3-v2-1-23ebb864fcc1@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250701-arm_cs_pm_fix_v3-v2-1-23ebb864fcc1@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/07/25 8:23 PM, Leo Yan wrote:
> The device mode is defined as local type. This type cannot promise
> SMP-safe access.
> 
> Change to atomic type and impose relax ordering, which ensures the
> SMP-safe synchronisation and the ordering between the mode setting and
> relevant operations.


But have we really faced such problems on real systems due to local_t
or this is just an improvement ?

> 
> Fixes: 22fd532eaa0c ("coresight: etm3x: adding operation mode for etm_enable()")
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  include/linux/coresight.h | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 4ac65c68bbf44b98db22c3dad2d83a224ce5278e..5fd3d08824e5a91a197aa01daf0fc392392f3e55 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -251,15 +251,11 @@ struct coresight_trace_id_map {
>   *		by @coresight_ops.
>   * @access:	Device i/o access abstraction for this device.
>   * @dev:	The device entity associated to this component.
> - * @mode:	This tracer's mode, i.e sysFS, Perf or disabled. This is
> - *		actually an 'enum cs_mode', but is stored in an atomic type.
> - *		This is always accessed through local_read() and local_set(),
> - *		but wherever it's done from within the Coresight device's lock,
> - *		a non-atomic read would also work. This is the main point of
> - *		synchronisation between code happening inside the sysfs mode's
> - *		coresight_mutex and outside when running in Perf mode. A compare
> - *		and exchange swap is done to atomically claim one mode or the
> - *		other.
> + * @mode:	The device mode, i.e sysFS, Perf or disabled. This is actually
> + *		an 'enum cs_mode' but stored in an atomic type. Access is always
> + *		through atomic APIs, ensuring SMP-safe synchronisation between
> + *		racing from sysFS and Perf mode. A compare-and-exchange
> + *		operation is done to atomically claim one mode or the other.
>   * @refcnt:	keep track of what is in use. Only access this outside of the
>   *		device's spinlock when the coresight_mutex held and mode ==
>   *		CS_MODE_SYSFS. Otherwise it must be accessed from inside the
> @@ -288,7 +284,7 @@ struct coresight_device {
>  	const struct coresight_ops *ops;
>  	struct csdev_access access;
>  	struct device dev;
> -	local_t	mode;
> +	atomic_t mode;
>  	int refcnt;
>  	bool orphan;
>  	/* sink specific fields */
> @@ -650,13 +646,14 @@ static inline bool coresight_is_percpu_sink(struct coresight_device *csdev)
>  static inline bool coresight_take_mode(struct coresight_device *csdev,
>  				       enum cs_mode new_mode)
>  {
> -	return local_cmpxchg(&csdev->mode, CS_MODE_DISABLED, new_mode) ==
> -	       CS_MODE_DISABLED;
> +	int curr = CS_MODE_DISABLED;
> +
> +	return atomic_try_cmpxchg_acquire(&csdev->mode, &curr, new_mode);
>  }
>  
>  static inline enum cs_mode coresight_get_mode(struct coresight_device *csdev)
>  {
> -	return local_read(&csdev->mode);
> +	return atomic_read_acquire(&csdev->mode);
>  }
>  
>  static inline void coresight_set_mode(struct coresight_device *csdev,
> @@ -672,7 +669,7 @@ static inline void coresight_set_mode(struct coresight_device *csdev,
>  	WARN(new_mode != CS_MODE_DISABLED && current_mode != CS_MODE_DISABLED &&
>  	     current_mode != new_mode, "Device already in use\n");
>  
> -	local_set(&csdev->mode, new_mode);
> +	atomic_set_release(&csdev->mode, new_mode);
>  }
>  
>  struct coresight_device *coresight_register(struct coresight_desc *desc);
> 

