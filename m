Return-Path: <linux-kernel+bounces-708269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C01AECE5F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 17:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23423173154
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA38230BE4;
	Sun, 29 Jun 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v+kESv11"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B02713790B
	for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751212186; cv=none; b=khN34T2Txb5kGZ3G9qSM+TVbvJJ6W8LlSNf2cqUbogOutor9i1eUDjbSwnpM3/3d9hVSVrEgDv/LtmSdMCbGiIgCO+2uxOarppep0zGUX0VHrvi99MXEthd3Y4MlPIqe0umV2NLHHvj6Bo203decdGZwTdukRAcYK57KfWOLMww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751212186; c=relaxed/simple;
	bh=GQLr7xchKK1viEfYMHygrCDLhlsEOMPIMYaTzu19GIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhSn9xROZExIN4KvGhUW8siJkIkYAL85U2LDoiXFYALsFW7qP2FVp1VUEVpFbO0n1JCZGwkmgu539m1hZqUXQNX7DnaKTnIaj3815ki/ULGClUbiHyJschfzAY/6BU/7KdvBb824CHxE6PCpy/QbHayOgSBS7W2HSX2aajxpp+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v+kESv11; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <745fd720-4cf5-42c4-9cb6-a4932c6f68ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751212172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imiGuD/gOJUll+b4BS//Yom8mQki/dKUk35+LdByEn4=;
	b=v+kESv11z0HGmpL45RAXvRBHnh0k134yrqjPIbNq6jgueBGrKJlRUqj053Ydn7zDBUIx9d
	9sBG+0wB4Ao6K09Gb2WFe1SXSgLFLMWla+z/bCKfvP9XL6RN9KjVeA/d4ObLuYSLKC/TlJ
	zA/fIOpGMm7LU8m87fp4tcsrKAo887I=
Date: Sun, 29 Jun 2025 16:49:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch 1/3] timekeeping: Provide ktime_get_clock_ts64()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 John Stultz <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 Antoine Tenart <atenart@kernel.org>
References: <20250626124327.667087805@linutronix.de>
 <20250626131708.419101339@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250626131708.419101339@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/06/2025 14:27, Thomas Gleixner wrote:
> PTP implements an inline switch case for taking timestamps from various
> POSIX clock IDs, which already consumes quite some text space. Expanding it
> for auxiliary clocks really becomes too big for inlining.
> 
> Provide a out of line version.
> 
> The function invalidates the timestamp in case the clock is invalid. The
> invalidation allows to implement a validation check without the need to
> propagate a return value through deep existing call chains.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/timekeeping.h |    1 +
>   kernel/time/timekeeping.c   |   34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 
> --- a/include/linux/timekeeping.h
> +++ b/include/linux/timekeeping.h
> @@ -44,6 +44,7 @@ extern void ktime_get_ts64(struct timesp
>   extern void ktime_get_real_ts64(struct timespec64 *tv);
>   extern void ktime_get_coarse_ts64(struct timespec64 *ts);
>   extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
> +extern void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts);
>   
>   /* Multigrain timestamp interfaces */
>   extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1636,6 +1636,40 @@ void ktime_get_raw_ts64(struct timespec6
>   EXPORT_SYMBOL(ktime_get_raw_ts64);
>   
>   /**
> + * ktime_get_clock_ts64 - Returns time of a clock in a timespec
> + * @id:		POSIX clock ID of the clock to read
> + * @ts:		Pointer to the timespec64 to be set
> + *
> + * The timestamp is invalidated (@ts->sec is set to -1) if the
> + * clock @id is not available.
> + */
> +void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts)
> +{
> +	/* Invalidate time stamp */
> +	ts->tv_sec = -1;
> +	ts->tv_nsec = 0;
> +
> +	switch (id) {
> +	case CLOCK_REALTIME:
> +		ktime_get_real_ts64(ts);
> +		return;
> +	case CLOCK_MONOTONIC:
> +		ktime_get_ts64(ts);
> +		return;
> +	case CLOCK_MONOTONIC_RAW:
> +		ktime_get_raw_ts64(ts);
> +		return;
> +	case CLOCK_AUX ... CLOCK_AUX_LAST:
> +		if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
> +			ktime_get_aux_ts64(id, ts);
> +		return;
> +	default:
> +		WARN_ON_ONCE(1);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(ktime_get_clock_ts64);
> +
> +/**
>    * timekeeping_valid_for_hres - Check if timekeeping is suitable for hres
>    */
>   int timekeeping_valid_for_hres(void)
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

