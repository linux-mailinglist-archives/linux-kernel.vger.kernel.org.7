Return-Path: <linux-kernel+bounces-851424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9327BD66A1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C08A18A8442
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0232FAC07;
	Mon, 13 Oct 2025 21:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnNFftwO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C42EDD76
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760392462; cv=none; b=kK0M7ogoaYbn5M/IMFiiz9/MueSK1zAqD/ms/JiTUOzHUPrfINzn5zVACWVPMLsCBy702t33RLB6oYCk1o1FBuETZbd20AN/0AqCuOxHMTXBp3H8ppCilafRN9qybarz6MC3OJWUmG7mPXwMHouDscnxIktJmT8rO2gV0oZsPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760392462; c=relaxed/simple;
	bh=kKxcNDa5j3MKMnbUlVm70ZZvkYzrm/CQLkrr0HAmE5k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=plDViuu98HgdvPSofjs15xlWUS/7jtDBnEdiTaEvD2wGNfqxvdzf4hmU4QkKsondXTmN5UcHfBJVFVXTQFL3xZ/E7KhhRKyWOyZwCwsCFTz0VF1eOxk0M0zjMBwwRCQ6lgIQo1ZcR+c/9071Wb9qXvuO/K+nr/FluL1uSeQ/fT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnNFftwO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760392461; x=1791928461;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kKxcNDa5j3MKMnbUlVm70ZZvkYzrm/CQLkrr0HAmE5k=;
  b=DnNFftwO//cNKU+FuqtKrQhhEWzGDMSqpS+E4NHpwVjJH+v1KSOqgqFy
   vp6w4tIvK3H44td+WwmNqcNqPW3oRjtAo/KV/OREl6OmDG2cTY+gBrs/g
   a928hB30WWyQa9rkyjisM7rfr89Ra1DZD4ad6eIn8Dzl2Mk0WBc2gSpaT
   a9COON735umbuAGRNiRNB1PltzFSPJiKXWi6eloJ9D8hk19Wb3YKFUoKA
   Z2LRR5ttqfN3tZiU1kmjc2UAjR4GDw1D5a/bcKFZXyUxBpD40SVYgo0Cz
   w/JJnU1RUWfzso9zCD3ft8kNqacUl1UGqRClmV7ac33P+LIoawZx6je3y
   w==;
X-CSE-ConnectionGUID: tN5RII4rRnW4nCwaJOQAbQ==
X-CSE-MsgGUID: 4A8c0EnkR/6iAwRGFF7RiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73224933"
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="73224933"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 14:54:20 -0700
X-CSE-ConnectionGUID: oAYbN0RAQQSpK/JAW5bHsQ==
X-CSE-MsgGUID: k1onz/7GRg6XwXud4b5f3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,226,1754982000"; 
   d="scan'208";a="185960646"
Received: from unknown (HELO [10.241.242.139]) ([10.241.242.139])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 14:54:20 -0700
Message-ID: <aa3d20e6d451e0d0b812fe16e9d403c1033feeaa.camel@linux.intel.com>
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Doug
 Nelson	 <doug.nelson@intel.com>, Mohini Narkhede
 <mohini.narkhede@intel.com>, 	linux-kernel@vger.kernel.org, Vincent Guittot
 <vincent.guittot@linaro.org>,  Shrikanth Hegde <sshegde@linux.ibm.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>
Date: Mon, 13 Oct 2025 14:54:19 -0700
In-Reply-To: <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
References: 
	<e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
	 <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQENBE6N6zwBCADFoM9QBP6fLqfYine5oPRtaUK2xQavcYT34CBnjTlhbvEVMTPlNNzE5
 v04Kagcvg5wYcGwr3gO8PcEKieftO+XrzAmR1t3PKxlMT1bsQdTOhKeziZxh23N+kmA7sO/jnu/X2
 AnfSBBw89VGLN5fw9DpjvU4681lTCjcMgY9KuqaC/6sMbAp8uzdlue7KEl3/D3mzsSl85S9Mk8KTL
 MLb01ILVisM6z4Ns/X0BajqdD0IEQ8vLdHODHuDMwV3veAfnK5G7zPYbQUsK4+te32ruooQFWd/iq
 Rf815j6/sFXNVP/GY4EWT08UB129Kzcxgj2TEixe675Nr/hKTUVKM/NrABEBAAGJAS4EIAECABgFA
 k6ONYoRHQFLZXkgaXMgcmVwbGFjZWQACgkQHH3vaoxLv2UmbAgAsqa+EKk2yrDc1dEXbZBBGeCiVP
 XkP7iajI/FiMVZHFQpme4vpntWhg0BIKnF0OSyv0wgn3wzBWx0Zh3cve/PICIj268QvXkb0ykVcIo
 RnWwBeavO4dd304Mzhz5fBzJwjYx06oabgUmeGawVCEq7UfXy+PsdQdoTabsuD1jq0MbOL/4sB6CZ
 c4V2mQbW4+Js670/sAZSMj0SQzK9CQyQdg6Wivz8GgTBjWwWsfMt4g2u0s6rtBo8NUZG/yw6fNdao
 DaT/OCHuBopGmsmFXInigwOXsjyp15Yqs/de3S2Nu5NdjJUwmN1Qd1bXEc/ItvnrFB0RgoNt2gzf2
 5aPifLabQlVGltIENoZW4gPHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tPokBOAQTAQIAIgUCTo3
 rPAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQHH3vaoxLv2XYdAf8DgRO4eIAtWZy4zLv
 0EZHWiJ35GYAQ5fPFWBoNURE0+vICrvLyfCKTlUTFxFxTiAWHUO7JM+uBHQSJVsE+ERmTPsiUO1m7
 SxZakGy9U2WOEiWMZMRp7HZE8vPUY5AM1OD0b38WBeUD3FPx5WRlQ0z6izF9aIHxoQhci0/WtmGLO
 Pw3HUlCy1c4DDl6cInpy/JqUPcYlvsp+bWbdm7R5b33WW2CNVVr1eLj+1UP0Iow4jlLzNLW+jOpiv
 LDs3G/bNC1Uu/SAzTvbaDBRRO9ToX5rlg3Zi8PmOUXWzEfO6N+L1gFCAdYEB4oSOghSbk2xCC4DRl
 UTlYoTJCRsjusXEy4ZkCDQROjjboARAAtXPJWkNkK3s22BXrcK8w9L/Kzqmp4+V9Y5MkkK94Zv66l
 XAybnXH3UjL9ATQgo7dnaHxcVX0S9BvHkEeKqEoMwxg86Bb2tzY0yf9+E5SvTDKLi2O1+cd7F3Wba
 1eM4Shr90bdqLHwEXR90A6E1B7o4UMZXD5O3MI013uKN2hyBW3CAVJsYaj2s9wDH3Qqm4Xe7lnvTA
 GV+zPb5Oj26MjuD4GUQLOZVkaA+GX0TrUlYl+PShJDuwQwpWnFbDgyE6YmlrWVQ8ZGFF/w/TsRgJM
 ZqqwsWccWRw0KLNUp0tPGig9ECE5vy1kLcMdctD+BhjF0ZSAEBOKyuvQQ780miweOaaTsADu5MPGk
 d3rv7FvKdNencd+G1BRU8GyCyRb2s6b0SJnY5mRnE3L0XfEIJoTVeSDchsLXwPLJy+Fdd2mTWQPXl
 nforgfKmX6BYsgHhzVsy1/zKIvIQey8RbhBp728WAckUvN47MYx9gXePW04lzrAGP2Mho+oJfCpI0
 myjpI9CEctvJy4rBXRgb4HkK72i2gNOlXsabZqy46dULcnrMOsyCXj6B1CJiZbYz4xb8n5LiD31SA
 fO5LpKQe/G4UkQOZgt+uS7C0Zfp61+0mrhKPG+zF9Km1vaYNH8LIsggitIqE05uCFi9sIgwez3oiU
 rFYgTkTSqMQNPdweNgVhSUAEQEAAbQ0VGltIENoZW4gKHdvcmsgcmVsYXRlZCkgPHRpbS5jLmNoZW
 5AbGludXguaW50ZWwuY29tPokCVQQTAQgAPwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQT
 RofI2lb24ozcpAhyiZ7WKota4SQUCYjOVvwUJF2fF1wAKCRCiZ7WKota4SeetD/4hztE+L/Z6oqIY
 lJJGgS9gjV7c08YH/jOsiX99yEmZC/BApyEpqCIs+RUYl12hwVUJc++sOm/p3d31iXvgddXGYxim0
 0+DIhIu6sJaDzohXRm8vuB/+M/Hulv+hTjSTLreAZ9w9eYyqffre5AlEk/hczLIsAsYRsqyYZgjfX
 Lk5JN0L7ixsoDRQ5syZaY11zvo3LZJX9lTw0VPWlGeCxbjpoQK91CRXe9dx/xH/F/9F203ww3Ggt4
 VlV6ZNdl14YWGfhsiJU2rbeJ930sUDbMPJqV60aitI93LickNG8TOLG5QbN9FzrOkMyWcWW7FoXwT
 zxRYNcMqNVQbWjRMqUnN6PXCIvutFLjLF6FBe1jpk7ITlkS1FvA2rcDroRTU/FZRnM1k0K4GYYYPj
 11Zt3ZBcPoI0J3Jz6P5h6fJioqlhvZiaNhYneMmfvZAWJ0yv+2c5tp2aBmKsjmnWecqvHL5r/bXez
 iKRdcWyXqrEEj6OaJr3S4C0MIgGLteARvbMH+3tNTDIqFuyqdzHLKwEHuvKxHzYFyV7I5ZEQ2HGH5
 ZRZ2lRpVjSIlnD4L1PS6Bes+ALDrWqksbEuuk+ixFKKFyIsntIM+qsjkXseuMSIG5ADYfTla9Pc5f
 VpWBKX/j0MXxdQsxT6tiwE7P+osbOMwQ6Ja5Qi57hj8jBRF1znDjDZkBDQRcCwpgAQgAl12VXmQ1X
 9VBCMC+eTaB0EYZlzDFrW0GVmi1ii4UWLzPo0LqIMYksB23v5EHjPvLvW/su4HRqgSXgJmNwJbD4b
 m1olBeecIxXp6/S6VhD7jOfi4HACih6lnswXXwatzl13OrmK6i82bufaXFFIPmd7x7oz5Fuf9OQlL
 OnhbKXB/bBSHXRrMCzKUJKRia7XQx4gGe+AT6JxEj6YSvRT6Ik/RHpS/QpuOXcziNHhcRPD/ZfHqJ
 SEa851yA1J3Qvx1KQK6t5I4hgp7zi3IRE0eiObycHJgT7nf/lrdAEs7wrSOqIx5/mZ5eoKlcaFXiK
 J3E0Wox6bwiBQXrAQ/2yxBxVwARAQABtCVUaW0gQ2hlbiA8dGltLmMuY2hlbkBsaW51eC5pbnRlbC
 5jb20+iQFUBBMBCAA+FiEEEsKdz9s94XWwiuG96lQbuGeTCYsFAlwLCmACGwMFCQHhM4AFCwkIBwI
 GFQoJCAsCBBYCAwECHgECF4AACgkQ6lQbuGeTCYuQiQf9G2lkrkRdLjXehwCl+k5zBkn8MfUPi2It
 U2QDcBit/YyaZpNlSuh8h30gihp5Dlb9BnqBVKxooeIVKSKC1HFeG0AE28TvgCgEK8qP/LXaSzGvn
 udek2zxWtcsomqUftUWKvoDRi1AAWrPQmviNGZ4caMd4itKWf1sxzuH1qF5+me6eFaqhbIg4k+6C5
 fk3oDBhg0zr0gLm5GRxK/lJtTNGpwsSwIJLtTI3zEdmNjW8bb/XKszf1ufy19maGXB3h6tA9TTHOF
 nktmDoWJCq9/OgQS0s2D7W7f/Pw3sKQghazRy9NqeMbRfHrLq27+Eb3Nt5PyiQuTE8JeAima7w98q
 uQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-13 at 16:26 +0200, Peter Zijlstra wrote:
> On Thu, Oct 02, 2025 at 04:00:12PM -0700, Tim Chen wrote:
>=20
> > During load balancing, balancing at the LLC level and above must be
> > serialized.=20
>=20
> I would argue the wording here, there is no *must*, they *are*. Per the
> current rules SD_NUMA and up get SD_SERIALIZE.
>=20
> This is a *very* old thing, done by Christoph Lameter back when he was
> at SGI. I'm not sure this default is still valid or not. Someone would
> have to investigate. An alternative would be moving it into
> node_reclaim_distance or somesuch.
>=20
> > The scheduler currently checks the atomic
> > `sched_balance_running` flag before verifying whether a balance is
> > actually due. This causes high contention, as multiple CPUs may attempt
> > to acquire the flag concurrently.
>=20
> Right.
>=20
> > On a 2-socket Granite Rapids system with sub-NUMA clustering enabled
> > and running OLTP workloads, 7.6% of CPU cycles were spent on cmpxchg
> > operations for `sched_balance_running`. In most cases, the attempt
> > aborts immediately after acquisition because the load balance time is
> > not yet due.
>=20
> So I'm not sure I understand the situation, @continue_balancing should
> limit this concurrency to however many groups are on this domain -- your
> granite thing with SNC on would have something like 6 groups?

That's a good point.  But I think the contention is worse than
6 CPUs.

The hierarchy would be

SMT
NUMA-level1
NUMA-level2
NUMA-level3
NUMA-level4

There would be multiple CPUs in that are first in the SMT group
with continue_balancing=3D1 going up in the hierachy and
attempting the cmpxchg in the first NUMA domain level,
before calling should_we_balance() and finding that they are
not the first in the NUMA domain and set continue_balancing=3D0
and abort. Those CPUS are in same L3.
But at the same time, there could be CPUs in other sockets
cmpxchg on sched_balance_running.

In our experiment, we have not applied
NUMA hierarchy fix [1]. The system can have up to 4 NUMA domains,
with 3 NUMA levels spanning different sockets.
That means there can be up to three concurrent cmpxchg attempts
per level from CPUs in separate sockets. So that would make
things worse.

[1] https://lore.kernel.org/lkml/cover.1759515405.git.tim.c.chen@linux.inte=
l.com/

>=20
> > Fix this by checking whether a balance is due *before* trying to
> > acquire `sched_balance_running`. This avoids many wasted acquisitions
> > and reduces the cmpxchg overhead in `sched_balance_domain()` from 7.6%
> > to 0.05%. As a result, OLTP throughput improves by 11%.
>=20
> Yeah, I see no harm flipping this, but the Changelog needs help.
>=20
> > Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >  kernel/sched/fair.c | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8ce56a8d507f..bedd785c4a39 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -12126,13 +12126,13 @@ static void sched_balance_domains(struct rq *=
rq, enum cpu_idle_type idle)
> > =20
> >  		interval =3D get_sd_balance_interval(sd, busy);
> > =20
> > -		need_serialize =3D sd->flags & SD_SERIALIZE;
> > -		if (need_serialize) {
> > -			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
> > -				goto out;
> > -		}
> > -
> >  		if (time_after_eq(jiffies, sd->last_balance + interval)) {
> > +			need_serialize =3D sd->flags & SD_SERIALIZE;
> > +			if (need_serialize) {
> > +				if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
> > +					goto out;
> > +			}
> > +
> >  			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
> >  				/*
> >  				 * The LBF_DST_PINNED logic could have changed
> > @@ -12144,9 +12144,9 @@ static void sched_balance_domains(struct rq *rq=
, enum cpu_idle_type idle)
> >  			}
> >  			sd->last_balance =3D jiffies;
> >  			interval =3D get_sd_balance_interval(sd, busy);
> > +			if (need_serialize)
> > +				atomic_set_release(&sched_balance_running, 0);
> >  		}
> > -		if (need_serialize)
> > -			atomic_set_release(&sched_balance_running, 0);
> >  out:
> >  		if (time_after(next_balance, sd->last_balance + interval)) {
> >  			next_balance =3D sd->last_balance + interval;
>=20
> Instead of making the indenting worse, could we make it better?

Yes, this is much better.  Thanks.

Tim

>=20
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e743d9d0576c..6318834ff42a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12215,6 +12215,8 @@ static void sched_balance_domains(struct rq *rq, =
enum cpu_idle_type idle)
>  		}
> =20
>  		interval =3D get_sd_balance_interval(sd, busy);
> +		if (time_before(jiffies, sd->last_balance + interval))
> +			goto out;
> =20
>  		need_serialize =3D sd->flags & SD_SERIALIZE;
>  		if (need_serialize) {
> @@ -12222,19 +12224,18 @@ static void sched_balance_domains(struct rq *rq=
, enum cpu_idle_type idle)
>  				goto out;
>  		}
> =20
> -		if (time_after_eq(jiffies, sd->last_balance + interval)) {
> -			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
> -				/*
> -				 * The LBF_DST_PINNED logic could have changed
> -				 * env->dst_cpu, so we can't know our idle
> -				 * state even if we migrated tasks. Update it.
> -				 */
> -				idle =3D idle_cpu(cpu);
> -				busy =3D !idle && !sched_idle_cpu(cpu);
> -			}
> -			sd->last_balance =3D jiffies;
> -			interval =3D get_sd_balance_interval(sd, busy);
> +		if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
> +			/*
> +			 * The LBF_DST_PINNED logic could have changed
> +			 * env->dst_cpu, so we can't know our idle
> +			 * state even if we migrated tasks. Update it.
> +			 */
> +			idle =3D idle_cpu(cpu);
> +			busy =3D !idle && !sched_idle_cpu(cpu);
>  		}
> +		sd->last_balance =3D jiffies;
> +		interval =3D get_sd_balance_interval(sd, busy);
> +
>  		if (need_serialize)
>  			atomic_set_release(&sched_balance_running, 0);
>  out:

