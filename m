Return-Path: <linux-kernel+bounces-855267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB68BE0AB9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BFD84E05C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FF630C62B;
	Wed, 15 Oct 2025 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTEVvmOq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBECD32549B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560906; cv=none; b=eQEF85kaCeVmMpAqt4N1zKfeXFSYVP/BXBhNg3rWYAnCB9uQC3wo9J0Nf71z1fI/2sFDi67nWaX+l7F5M6Sfy+zGfdxcdaWT9kpvkNLT7beh570G/7lePfueXbIzP1ZC7E4UkW6Nc0dSG2rC1RdGP1lqcWYeytjwB+34UG5+0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560906; c=relaxed/simple;
	bh=qGnUlfgwdPtAtXjRLGy0QuLwRHAaDHr48qjb+wkQZcM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cN4bv2wJtDSgLiDIK5Hjoom5jUAGU0Vdnfjh4cSdbo7eonnE//vhaeZf9pqODelfrJayUWxz80oYhBtKFaH/BgCIyQDJxKZmt6dV+wtVPhOd/wI7QgUalO1/aWQs49aChdwkRYtSjFOYy8RF4yB47/IEhioZS4lD9qJFLUSdXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTEVvmOq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760560905; x=1792096905;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qGnUlfgwdPtAtXjRLGy0QuLwRHAaDHr48qjb+wkQZcM=;
  b=cTEVvmOqGKAFdB0sIzRfVnauMxd4L6Znn0lH8cWUDwX3UIcqY95VTPw9
   /H+sMIkWkDrCUNuPVrRA0pPk98LInUzCqXaLLzMcDdToU/q8Er3zPl180
   /XKBfTMmJ2SrwtTqomNXuqkj0vA8gk+4hCDOCSsdDZfZrNzh5oNCjQ10A
   rrD0eFFOZ6aX5DfIvARClTmX2lAhVRg1Js3XHwMn0K/ve2MBM6AQYcpy2
   nglHKz6/J9tUqqtcl2sMZcEGAZ+pD9oMeGaDZ+HlY5iNPhXWV0cb85l6S
   KYHAM3y113n4P1hJVuI7nbs+EBkSdAN0HstVZRMHUHva96+en4sZ6Sd5n
   Q==;
X-CSE-ConnectionGUID: 1dgKCe4zQhCfq7DN3Kl9kw==
X-CSE-MsgGUID: yeLDShk2R6yrim0yzFjG9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="74087666"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="74087666"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:41:44 -0700
X-CSE-ConnectionGUID: vrS1+5BQTSSd7L3TkBZdpA==
X-CSE-MsgGUID: 7wr2+GyDQKCkBdGwjF2MGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182681884"
Received: from unknown (HELO [10.241.242.248]) ([10.241.242.248])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 13:41:43 -0700
Message-ID: <782009c48dbde2cb2912f4d5dc573ecfbd2c1087.camel@linux.intel.com>
Subject: Re: [PATCH 08/19] sched/fair: Introduce per runqueue task LLC
 preference counter
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>,  "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli	
 <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>,  Valentin Schneider	 <vschneid@redhat.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Hillf Danton
 <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Jianyong Wu	
 <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>, Tingyin Duan	
 <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len Brown	
 <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu	
 <zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Chen Yu	
 <yu.c.chen@intel.com>, Libo Chen <libo.chen@oracle.com>, Adam Li	
 <adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>, 
	linux-kernel@vger.kernel.org
Date: Wed, 15 Oct 2025 13:41:42 -0700
In-Reply-To: <20251015122125.GU3289052@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
	 <a002ffc53c06bfa0ef0700631b0cb5413bdbf06c.1760206683.git.tim.c.chen@linux.intel.com>
	 <20251015122125.GU3289052@noisy.programming.kicks-ass.net>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
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

On Wed, 2025-10-15 at 14:21 +0200, Peter Zijlstra wrote:
> On Sat, Oct 11, 2025 at 11:24:45AM -0700, Tim Chen wrote:
> > Each runqueue is assigned a static array where each element tracks
> > the number of tasks preferring a given LLC, indexed from 0 to
> > NR_LLCS.
> >=20
> > For example, rq->nr_pref_llc[3] =3D 2 signifies that there are 2 tasks =
on
> > this runqueue which prefer to run within LLC3 (indexed from 0 to NR_LLC=
S
> >=20
> > The load balancer can use this information to identify busy runqueues
> > and migrate tasks to their preferred LLC domains.
> >=20
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >  kernel/sched/fair.c  | 35 +++++++++++++++++++++++++++++++++++
> >  kernel/sched/sched.h |  1 +
> >  2 files changed, 36 insertions(+)
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index fd315937c0cf..b7a68fe7601b 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1235,22 +1235,51 @@ static inline int llc_idx(int cpu)
> >  	return per_cpu(sd_llc_idx, cpu);
> >  }
> > =20
> > +static inline int pref_llc_idx(struct task_struct *p)
> > +{
> > +	return llc_idx(p->preferred_llc);
> > +}
> > +
> >  static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
> >  {
> > +	int pref_llc;
> > +
> >  	if (!sched_cache_enabled())
> >  		return;
> > =20
> >  	rq->nr_llc_running +=3D (p->preferred_llc !=3D -1);
> >  	rq->nr_pref_llc_running +=3D (p->preferred_llc =3D=3D task_llc(p));
> > +
> > +	if (p->preferred_llc < 0)
> > +		return;
> > +
> > +	pref_llc =3D pref_llc_idx(p);
> > +	if (pref_llc < 0)
> > +		return;
> > +
> > +	++rq->nr_pref_llc[pref_llc];
> >  }
> > =20
> >  static void account_llc_dequeue(struct rq *rq, struct task_struct *p)
> >  {
> > +	int pref_llc;
> > +
> >  	if (!sched_cache_enabled())
> >  		return;
> > =20
> >  	rq->nr_llc_running -=3D (p->preferred_llc !=3D -1);
> >  	rq->nr_pref_llc_running -=3D (p->preferred_llc =3D=3D task_llc(p));
> > +
> > +	if (p->preferred_llc < 0)
> > +		return;
> > +
> > +	pref_llc =3D pref_llc_idx(p);
> > +	if (pref_llc < 0)
> > +		return;
> > +
> > +	/* avoid negative counter */
> > +	if (rq->nr_pref_llc[pref_llc] > 0)
> > +		--rq->nr_pref_llc[pref_llc];
>=20
> How!? Also, please use post increment/decrement operators.

Will change the rq->nr_pref_llc[pref_llc] <=3D 0 to a warning instead,
and update the decrement to post operator.

>=20
> >  }
> > =20
> >  void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *_pc=
pu_sched)
> > @@ -1524,10 +1553,16 @@ void init_sched_mm(struct task_struct *p)
> > =20
> >  void reset_llc_stats(struct rq *rq)
> >  {
> > +	int i =3D 0;
> > +
> >  	if (!sched_cache_enabled())
> >  		return;
> > =20
> >  	rq->nr_llc_running =3D 0;
> > +
> > +	for (i =3D 0; i < max_llcs; ++i)
> > +		rq->nr_pref_llc[i] =3D 0;
> > +
> >  	rq->nr_pref_llc_running =3D 0;
> >  }
>=20
> Still don't understand why this thing exists..

Will remove this or change this to a debug
warning for the case when rq has no fair task.

>=20
> > =20
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 3ab64067acc6..b801d32d5fba 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -1101,6 +1101,7 @@ struct rq {
> >  #ifdef CONFIG_SCHED_CACHE
> >  	unsigned int		nr_pref_llc_running;
> >  	unsigned int		nr_llc_running;
> > +	unsigned int		nr_pref_llc[NR_LLCS];
>=20
> Gah, yeah, lets not do this. Just (re)alloc the thing on topology
> changes or something.

Will have to think about how to keep the tasks' preference
consistent with nr_pref_llc with the new array.  Perhaps
make it size of NR_CPUS so we will allocate
once and don't have to resize and reallocate it, and
fill it back up with the right data.

Tim

