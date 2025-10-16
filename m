Return-Path: <linux-kernel+bounces-856930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D43ABE5798
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4287581769
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CBA2E1742;
	Thu, 16 Oct 2025 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="GPud9RuW"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59171534EC
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648273; cv=none; b=jMaQLfqGW7Zmsru8uBX1o+/Kp8Hxb18I0+umOdL8Wxh0ujTCjTpvnXyxsKYFZNHjGHNUuEyKQNco7aGepjj2K7iqpAG0qkekN5IN478LiltL1zJl9TMEe6D2ceQvbITvhWkzS3FQYIzUpz2VM0vFO0oin/RBPKBgKFZLyk6kCzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648273; c=relaxed/simple;
	bh=uRhISYL3n3QE3AeFIzzdXnBIT58XDxcDzGu8M8mMX0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMGR73PinpHhzoY4XF7f0COo5H5El9jOCkTUFUiiKsaE197e/ZJqZuT528Vuaneioqx/XfGdKyduqKSubBatxyuTOe5oStLP6cIUG4D3mItuhM0mokG3ef1sOlwMn1vhcs8fgja8K2oynCq+y/SDR1QkplNTPukoDZy54X7vn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=GPud9RuW; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GH3GdS009939;
	Thu, 16 Oct 2025 20:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=IG7FiSEvgNzm4RES3MNSobFTWT
	004S/n8Il0NAT6yt0=; b=GPud9RuWGblQLBISVz/kA9V0+8jbLh7uQ2fzJ0f+Hp
	phpnyhT79VhTufv+/j1MhG3MX4xr7O52Hh82z0pb+8aV42UCi9jT7mPwvu6hzEkG
	VQVfckNo4Y0AoFTvEflgn30+FgAwzioon0prwlD0G8QtKDn2MDFJKnOBNhE0LmHe
	6z+R4K6Ut65G+/i1uikly71z+M4lVMhR+ysX3QQZfwMDY+UbWk5csgbakVEjf+j1
	wmr7D8J65+eRa/NT6npYU58X/cdsoa/PpQAZ6dHWNt+0cfkr3p2fTo99xBpYPCrw
	OtMdrT56FUerVgqwi940HFU9QM9Xc+txgow8wfspJF8w==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 49tshfftm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 20:57:15 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 6DF72800354;
	Thu, 16 Oct 2025 20:57:15 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 8A5FF80EECB;
	Thu, 16 Oct 2025 20:57:14 +0000 (UTC)
Date: Thu, 16 Oct 2025 15:57:12 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Steve Wahl <steve.wahl@hpe.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: Re: [PATCH] tick/sched: Use trylock for jiffies updates by
 non-timekeeper CPUs
Message-ID: <aPFcKDJIP4-maoqI@swahl-home.5wahls.com>
References: <20251013150959.298288-1-steve.wahl@hpe.com>
 <87a51q1uhg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a51q1uhg.ffs@tglx>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAyOSBTYWx0ZWRfX8k0dKlInkhSX
 rUDCh9vLwAhoSTOxMd8wDZdyiNsYPpFWM22rqQl5nkpokZdnwj+JpWUgQOCRBYthIhY2qtb7pt0
 k4aVCbcwHrM9GYlyBFiOKD6lMjlAK7GhHFTcS8zEZh1U68R57vwBhVy7uQmCDctHk2bXiK6zydZ
 kUp2jUpS8/A0gQZhlOALcEE1epYc5vEaejWrdApZQCjCeWFWJ0vJwHQ7TNiY20sZ/28136DRX7J
 mMyGXnyhV3D0vDfIcLZo1I69AWTfVZMyTCoLyj4Ex4BNCVykvl9ee2TADc5zREW84H3YuxN+c/L
 FRagUKSipSiGKPG+Ab+FWi7Dv9gt/2x7fHeSF/Qx11Qcv39z5Jwf0ngBkIBCTCYwveqoqxx9P/U
 JnepXVZJ5wzMVvtM0FOv0bMXZfVT8A==
X-Proofpoint-ORIG-GUID: tc8sYpf_6b8BvGO1LKUmmZwn7YW0FHrZ
X-Proofpoint-GUID: tc8sYpf_6b8BvGO1LKUmmZwn7YW0FHrZ
X-Authority-Analysis: v=2.4 cv=O/E0fR9W c=1 sm=1 tr=0 ts=68f15c2b cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=PxzMMrfhGef9sE1I89YA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160029

On Thu, Oct 16, 2025 at 10:07:07PM +0200, Thomas Gleixner wrote:
> On Mon, Oct 13 2025 at 10:09, Steve Wahl wrote:
> > -static void tick_do_update_jiffies64(ktime_t now)
> > +static bool _tick_do_update_jiffies64(ktime_t now, bool trylock)
> >  {
> >  	unsigned long ticks = 1;
> >  	ktime_t delta, nextp;
> > @@ -70,7 +70,7 @@ static void tick_do_update_jiffies64(ktime_t now)
> >  	 */
> >  	if (IS_ENABLED(CONFIG_64BIT)) {
> >  		if (ktime_before(now, smp_load_acquire(&tick_next_period)))
> > -			return;
> > +			return true;
> >  	} else {
> >  		unsigned int seq;
> >  
> > @@ -84,18 +84,24 @@ static void tick_do_update_jiffies64(ktime_t now)
> >  		} while (read_seqcount_retry(&jiffies_seq, seq));
> >  
> >  		if (ktime_before(now, nextp))
> > -			return;
> > +			return true;
> >  	}
> >  
> >  	/* Quick check failed, i.e. update is required. */
> > -	raw_spin_lock(&jiffies_lock);
> > +	if (trylock) {
> > +		/* The cpu holding the lock will do the update. */
> > +		if (!raw_spin_trylock(&jiffies_lock))
> > +			return false;
> > +	} else {
> > +		raw_spin_lock(&jiffies_lock);
> > +	}
> 
> Why inflicting this horrible conditional locking scheme into the main
> path? This can be solved without all this churn completely independent
> from this function.

Why? Because my first crack at the problem was just change to a
trylock at all times.  But I saw some callers might depend on time
being updated before return.  And I would say I didn't "zoom out" far
enough from the simple fix when trying to accomodate that.

> Something like the uncompiled below. You get the idea.

I like this approach.

The reason I'm getting in to this situation seems to be that the
designated timekeeper is actually doing the jiffies update work;
holding the lock, hasn't finished processing yet.  Under those
conditions, this approach will have one extra CPU stuck waiting on the
jiffies lock.

But that's far better than thousands, and I think would be acceptable
tradeoff for code readability.  I will make it compile and see how it
tests, and proceed to make it become patch v2 if it seems OK.

> Thanks,
>
>         tglx

Thank you!

--> Steve Wahl

> ---
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -203,6 +203,21 @@ static inline void tick_sched_flag_clear
>  
>  #define MAX_STALLED_JIFFIES 5
>  
> +static bool tick_try_update_jiffies64(struct tick_sched *ts, ktime_t now)
> +{
> +	static atomic_t in_progress;
> +	int inp;
> +
> +	inp = atomic_read(&in_progress);
> +	if (inp || !atomic_try_cmpxchg(&in_progress, &inp, 1))
> +		return false;
> +
> +	if (ts->last_tick_jiffies == jiffies)
> +		tick_do_update_jiffies64(now);
> +	atomic_set(&in_progress, 0);
> +	return true;
> +}
> +
>  static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
>  {
>  	int tick_cpu, cpu = smp_processor_id();
> @@ -239,10 +254,11 @@ static void tick_sched_do_timer(struct t
>  		ts->stalled_jiffies = 0;
>  		ts->last_tick_jiffies = READ_ONCE(jiffies);
>  	} else {
> -		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
> -			tick_do_update_jiffies64(now);
> -			ts->stalled_jiffies = 0;
> -			ts->last_tick_jiffies = READ_ONCE(jiffies);
> +		if (++ts->stalled_jiffies >= MAX_STALLED_JIFFIES) {
> +			if (tick_try_update_jiffies64(ts, now)) {
> +				ts->stalled_jiffies = 0;
> +				ts->last_tick_jiffies = READ_ONCE(jiffies);
> +			}
>  		}
>  	}
>  

-- 
Steve Wahl, Hewlett Packard Enterprise

