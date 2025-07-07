Return-Path: <linux-kernel+bounces-720456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 590CEAFBC00
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AB517FAC2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9872676DE;
	Mon,  7 Jul 2025 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3cLbLUw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA301AB52D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918234; cv=none; b=JuEbcwDCYPiqEsz5YAOKuSefLEVPHt3PGecprretqFdSMlOSF1UbLX8udSnHQT5SeTV53ZybMd1fvy/wbldPMQNW+OYZJnbbjNrDLLKBAMEzfOE4DZNaPDjlYtGW588qNGz6MyjSldh33bGEoqB16dqx/f86SRRAld1TJky7uss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918234; c=relaxed/simple;
	bh=+9Fl38niE4an17KIiFQnWEUpMHUnB7lhMUjG3PPKoOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RP9WT7rmkcK7bjhEgqFCmKOSTvWTOF7wAYHjnTKto9HdlYTWBMolTbz1bbQZGJl/NTpofLa3qqoPiB8BLUA5SlgWAOoaS0ONvrKesxeCrvfKkXWugBaPh8w0JfhtrbI3q0QCLWZOTi8OEY8Uf+l05I1LdtbCb0m1KxSpqkc/O4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3cLbLUw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751918233; x=1783454233;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+9Fl38niE4an17KIiFQnWEUpMHUnB7lhMUjG3PPKoOg=;
  b=Q3cLbLUwAY3F1CuLa4GQ8VCG0c/KjXooo3vwMNXdMyYIF8YA6rg2XKEr
   LdTtuJ4UVgc9RTH34qp5t6zIw9ENfXjhII8/P5OMXCkSTY/RyeZQ03t9f
   tij5DGkgg7vbs9ggxvHWU/VtIn5Ce7XVMvvV+qG8cVSyuWQxUrbjUlpPm
   gIeUOI+Kr7l3Rrb+rF+t9PI60RJTEr0lczyf+6u5C7TXxA+NmY4w3o1Y3
   KN7tykTt3+LWkUhDElRxB7J4x0IQ7/0a831Y2fXfypOLPkR1yP73qsetP
   pmyQ1qPyvdDVkkeBzXkfZmw3sw8V4LD/B0KYUJz+BNbwPl8ffAQSHSRtI
   Q==;
X-CSE-ConnectionGUID: mR2j/9s5RgqKtQUOoIhsww==
X-CSE-MsgGUID: X34+7CNKRcCbRMxFI2m9/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79579359"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="79579359"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:57:12 -0700
X-CSE-ConnectionGUID: S4cso/MnR02ONIJezri54A==
X-CSE-MsgGUID: O/mOaFpDQG62wDlJF6EtWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="156037050"
Received: from mjruhl-desk.amr.corp.intel.com (HELO [10.124.220.88]) ([10.124.220.88])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:57:11 -0700
Message-ID: <007752e0d8318f21dae5d19d4a0a86dc15e73c2e.camel@linux.intel.com>
Subject: Re: [RFC patch v3 01/20] sched: Cache aware load-balancing
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Chen Yu <yu.c.chen@intel.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Libo Chen <libo.chen@oracle.com>,
 Abel Wu <wuyun.abel@bytedance.com>, Madadi Vineeth Reddy
 <vineethr@linux.ibm.com>,  Hillf Danton <hdanton@sina.com>, Len Brown
 <len.brown@intel.com>, linux-kernel@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Date: Mon, 07 Jul 2025 12:57:10 -0700
In-Reply-To: <b4cce11c-5ed6-4366-92c6-9a6b34998295@linux.ibm.com>
References: <cover.1750268218.git.tim.c.chen@linux.intel.com>
	 <cbe56cb89cca4c3ddcbc9956a82bda23f5b81c57.1750268218.git.tim.c.chen@linux.intel.com>
	 <b4cce11c-5ed6-4366-92c6-9a6b34998295@linux.ibm.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQENBE6N6zwBCADFoM9QBP6fLqfYine5oPRtaUK2xQavcYT34CBnjTlhbvEVMTPlNNzE5v04Kagcvg5wYcGwr3gO8PcEKieftO+XrzAmR1t3PKxlMT1bsQdTOhKeziZxh23N+kmA7sO/jnu/X2AnfSBBw89VGLN5fw9DpjvU4681lTCjcMgY9KuqaC/6sMbAp8uzdlue7KEl3/D3mzsSl85S9Mk8KTLMLb01ILVisM6z4Ns/X0BajqdD0IEQ8vLdHODHuDMwV3veAfnK5G7zPYbQUsK4+te32ruooQFWd/iqRf815j6/sFXNVP/GY4EWT08UB129Kzcxgj2TEixe675Nr/hKTUVKM/NrABEBAAGJAS4EIAECABgFAk6ONYoRHQFLZXkgaXMgcmVwbGFjZWQACgkQHH3vaoxLv2UmbAgAsqa+EKk2yrDc1dEXbZBBGeCiVPXkP7iajI/FiMVZHFQpme4vpntWhg0BIKnF0OSyv0wgn3wzBWx0Zh3cve/PICIj268QvXkb0ykVcIoRnWwBeavO4dd304Mzhz5fBzJwjYx06oabgUmeGawVCEq7UfXy+PsdQdoTabsuD1jq0MbOL/4sB6CZc4V2mQbW4+Js670/sAZSMj0SQzK9CQyQdg6Wivz8GgTBjWwWsfMt4g2u0s6rtBo8NUZG/yw6fNdaoDaT/OCHuBopGmsmFXInigwOXsjyp15Yqs/de3S2Nu5NdjJUwmN1Qd1bXEc/ItvnrFB0RgoNt2gzf25aPifLabQlVGltIENoZW4gPHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tPokBOAQTAQIAIgUCTo3rPAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQHH3vaoxLv2XYdAf8DgRO4eIAtWZy4zLv0EZHWiJ35GYAQ5fPFWBoNURE0+vICrvLyfCKTlUTFxFxTiAWHUO7JM+uBHQSJVsE+ERmTPsiU
	O1m7SxZakGy9U2WOEiWMZMRp7HZE8vPUY5AM1OD0b38WBeUD3FPx5WRlQ0z6izF9aIHxoQhci0/WtmGLOPw3HUlCy1c4DDl6cInpy/JqUPcYlvsp+bWbdm7R5b33WW2CNVVr1eLj+1UP0Iow4jlLzNLW+jOpivLDs3G/bNC1Uu/SAzTvbaDBRRO9ToX5rlg3Zi8PmOUXWzEfO6N+L1gFCAdYEB4oSOghSbk2xCC4DRlUTlYoTJCRsjusXEy4bkBDQROjes8AQgAzuAQ5rF4/ZYaklzSXjXERiX0y1zBYmcYd2xVOKf50gh8IYv8allShkQ8mAalwIwyxTY+1k72GNCZIRVILSsuQY6fLmPUciuCk/X1y4oLNsF/Np8M9xxwYwqUibUwRdWwpSG2V0bcqjtUH1akaoY758wLONUmXrlfVonCfENd0aiP+ZLxYE1d1CRPv4KbAZ6z6seQCEQrappE4YXIC9yJUqT076DD1RhPmwNbNTTAauuwG+vX+jWsc5hUaHbKsAf/Rsw13+RA3dzWekbeIxO9qvQoQ26oqKEA31mxWhwNDnkTeo07+e2EGC2BV6s+sU1/m/lup5Bj34JLP7qYtd6EswARAQABiQEeBBgBAgAJBQJOjes8AhsMAAoJEBx972qMS79lYmQH+I4qdFm8wlkh/ZVWNJMSpfUfupuLPZ0g0hxNr3l2ZltEskVl5w+wJV+hBZ7zMmSxMYvMjJ+5aBDSZOfzhnK6+ETl4e/heDYiBLPYCtvU88cMRFb3jKcVxSfSzbBawEr7OFfCny3UtmYQ0PJmHFT6p+wlEHSyKxtyDDlLS/uPPR/llK94fOhvQlX8dir9b8r7JGuFTjtG2YbsTuapi3sFDmBhFZwYcNMt80FSIXGQjJzrsl1ZVSIwmqlF2191+F/Gr0Ld92dz1oEOjwKH1oRb/0MTsNU7udZv7L8iGKWCjHnA0dIoXKilf8EJyXGQ0wjQE3WBAdMecbvSKDRA7k
	9a75kCDQROjjboARAAtXPJWkNkK3s22BXrcK8w9L/Kzqmp4+V9Y5MkkK94Zv66lXAybnXH3UjL9ATQgo7dnaHxcVX0S9BvHkEeKqEoMwxg86Bb2tzY0yf9+E5SvTDKLi2O1+cd7F3Wba1eM4Shr90bdqLHwEXR90A6E1B7o4UMZXD5O3MI013uKN2hyBW3CAVJsYaj2s9wDH3Qqm4Xe7lnvTAGV+zPb5Oj26MjuD4GUQLOZVkaA+GX0TrUlYl+PShJDuwQwpWnFbDgyE6YmlrWVQ8ZGFF/w/TsRgJMZqqwsWccWRw0KLNUp0tPGig9ECE5vy1kLcMdctD+BhjF0ZSAEBOKyuvQQ780miweOaaTsADu5MPGkd3rv7FvKdNencd+G1BRU8GyCyRb2s6b0SJnY5mRnE3L0XfEIJoTVeSDchsLXwPLJy+Fdd2mTWQPXlnforgfKmX6BYsgHhzVsy1/zKIvIQey8RbhBp728WAckUvN47MYx9gXePW04lzrAGP2Mho+oJfCpI0myjpI9CEctvJy4rBXRgb4HkK72i2gNOlXsabZqy46dULcnrMOsyCXj6B1CJiZbYz4xb8n5LiD31SAfO5LpKQe/G4UkQOZgt+uS7C0Zfp61+0mrhKPG+zF9Km1vaYNH8LIsggitIqE05uCFi9sIgwez3oiUrFYgTkTSqMQNPdweNgVhSUAEQEAAbQ0VGltIENoZW4gKHdvcmsgcmVsYXRlZCkgPHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tPokCVQQTAQgAPwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQTRofI2lb24ozcpAhyiZ7WKota4SQUCYjOVvwUJF2fF1wAKCRCiZ7WKota4SeetD/4hztE+L/Z6oqIYlJJGgS9gjV7c08YH/jOsiX99yEmZC/BApyEpqCIs+RUYl12hwVUJc++sOm/p3d31iXvgddXGYxim00+DIhIu6sJ
	aDzohXRm8vuB/+M/Hulv+hTjSTLreAZ9w9eYyqffre5AlEk/hczLIsAsYRsqyYZgjfXLk5JN0L7ixsoDRQ5syZaY11zvo3LZJX9lTw0VPWlGeCxbjpoQK91CRXe9dx/xH/F/9F203ww3Ggt4VlV6ZNdl14YWGfhsiJU2rbeJ930sUDbMPJqV60aitI93LickNG8TOLG5QbN9FzrOkMyWcWW7FoXwTzxRYNcMqNVQbWjRMqUnN6PXCIvutFLjLF6FBe1jpk7ITlkS1FvA2rcDroRTU/FZRnM1k0K4GYYYPj11Zt3ZBcPoI0J3Jz6P5h6fJioqlhvZiaNhYneMmfvZAWJ0yv+2c5tp2aBmKsjmnWecqvHL5r/bXeziKRdcWyXqrEEj6OaJr3S4C0MIgGLteARvbMH+3tNTDIqFuyqdzHLKwEHuvKxHzYFyV7I5ZEQ2HGH5ZRZ2lRpVjSIlnD4L1PS6Bes+ALDrWqksbEuuk+ixFKKFyIsntIM+qsjkXseuMSIG5ADYfTla9Pc5fVpWBKX/j0MXxdQsxT6tiwE7P+osbOMwQ6Ja5Qi57hj8jBRF1znDjDZkBDQRcCwpgAQgAl12VXmQ1X9VBCMC+eTaB0EYZlzDFrW0GVmi1ii4UWLzPo0LqIMYksB23v5EHjPvLvW/su4HRqgSXgJmNwJbD4bm1olBeecIxXp6/S6VhD7jOfi4HACih6lnswXXwatzl13OrmK6i82bufaXFFIPmd7x7oz5Fuf9OQlLOnhbKXB/bBSHXRrMCzKUJKRia7XQx4gGe+AT6JxEj6YSvRT6Ik/RHpS/QpuOXcziNHhcRPD/ZfHqJSEa851yA1J3Qvx1KQK6t5I4hgp7zi3IRE0eiObycHJgT7nf/lrdAEs7wrSOqIx5/mZ5eoKlcaFXiKJ3E0Wox6bwiBQXrAQ/2yxBxVwARAQABtCVUaW0gQ2hlbiA8dGltLmMuY2hlbkBsaW51eC5pbnRlbC5jb20+
	iQFUBBMBCAA+FiEEEsKdz9s94XWwiuG96lQbuGeTCYsFAlwLCmACGwMFCQHhM4AFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQ6lQbuGeTCYuQiQf9G2lkrkRdLjXehwCl+k5zBkn8MfUPi2ItU2QDcBit/YyaZpNlSuh8h30gihp5Dlb9BnqBVKxooeIVKSKC1HFeG0AE28TvgCgEK8qP/LXaSzGvnudek2zxWtcsomqUftUWKvoDRi1AAWrPQmviNGZ4caMd4itKWf1sxzuH1qF5+me6eFaqhbIg4k+6C5fk3oDBhg0zr0gLm5GRxK/lJtTNGpwsSwIJLtTI3zEdmNjW8bb/XKszf1ufy19maGXB3h6tA9TTHOFnktmDoWJCq9/OgQS0s2D7W7f/Pw3sKQghazRy9NqeMbRfHrLq27+Eb3Nt5PyiQuTE8JeAima7w98quQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-04 at 00:59 +0530, Shrikanth Hegde wrote:
>=20
> Hi Tim, Chen,
> skimming through the series and will try to go through in coming days.
>=20
> >=20

Thanks for taking a look.  Some further comments on top of Chen Yu's respon=
se.

[snip]
> >  =20
> > +#ifdef CONFIG_SCHED_CACHE
> > +	struct callback_head		cache_work;
> > +#endif
> > +
> >   #ifdef CONFIG_RSEQ
> >   	struct rseq __user *rseq;
> >   	u32 rseq_len;
> > diff --git a/init/Kconfig b/init/Kconfig
> > index bf3a920064be..e2509127b6f9 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -953,6 +953,10 @@ config NUMA_BALANCING
> >  =20
> >   	  This system will be inactive on UMA systems.
> >  =20
> > +config SCHED_CACHE
> > +	bool "Cache aware scheduler"
> > +	default y
> > +
>=20
> Should it depend on EXPERT?
> IMO this could add quite a bit of overhead and maybe n by default?
>=20

We do have a SCHED_CACHE scheduler feature in the later patches. =20
So the feature could be turned on/off at run time by admin who don't want
to incur this overhead.

> >   config NUMA_BALANCING_DEFAULT_ENABLED
> >   	bool "Automatically enable NUMA aware memory/task placement"
> >   	default y
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 168681fc4b25..da1387823b9e 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -1332,6 +1332,9 @@ static struct mm_struct *mm_init(struct mm_struct=
 *mm, struct task_struct *p,
> >   	if (mm_alloc_cid(mm, p))
> >   		goto fail_cid;
> >  =20

[snip]
>=20
> > +
> > +static inline void __update_mm_sched(struct rq *rq, struct mm_sched *p=
cpu_sched)
> > +{
> > +	lockdep_assert_held(&rq->cpu_epoch_lock);
> > +
> > +	unsigned long n, now =3D jiffies;
> > +	long delta =3D now - rq->cpu_epoch_next;
> > +
> > +	if (delta > 0) {
> > +		n =3D (delta + EPOCH_PERIOD - 1) / EPOCH_PERIOD;
> > +		rq->cpu_epoch +=3D n;
> > +		rq->cpu_epoch_next +=3D n * EPOCH_PERIOD;
> > +		__shr_u64(&rq->cpu_runtime, n);
>=20
> Another doubt i had, does this occupancy works when there is CPU bandwidt=
h controller running?
> A 50% occupancy may have different meaning when CPU bandwidth is set to 5=
0%?

The occupancy is used to compare tasks occupancy within a process.  With ba=
ndwidth
controller set to 50%, it just mean that all tasks in the process will run =
50% less,
but the relative occupancy ratio between tasks should still remain the same=
.

[snip]
>=20
> > +	}
> >=20
> > +
> > +static void task_cache_work(struct callback_head *work)
> > +{
> > +	struct task_struct *p =3D current;
> > +	struct mm_struct *mm =3D p->mm;
> > +	unsigned long m_a_occ =3D 0;
> > +	int cpu, m_a_cpu =3D -1;
> > +	cpumask_var_t cpus;
> > +
> > +	WARN_ON_ONCE(work !=3D &p->cache_work);
> > +
> > +	work->next =3D work;
> > +
> > +	if (p->flags & PF_EXITING)
> > +		return;
> > +
> > +	if (!alloc_cpumask_var(&cpus, GFP_KERNEL))
> > +		return;
> > +
> > +	scoped_guard (cpus_read_lock) {
> > +		cpumask_copy(cpus, cpu_online_mask);
> > +
>=20
> As pointed out already, this is going to be costly in multi NUMA systems.=
 Any cross NUMA access of
> CPUs data is going to add overhead to system bus bandwidth and this happe=
ning at tick could be costly.
>=20

We'll consider restricting the scan on preferred NUMA node (if numa balanci=
ng is running), which
should greatly reduce the overhead.=20

> Also, taking cpu_read_lock does preempt_disable, this could add to large =
preemptoff?
> We need to measure the time it takes on large system. Will try and get ba=
ck with that number

Tim

