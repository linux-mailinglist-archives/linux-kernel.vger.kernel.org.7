Return-Path: <linux-kernel+bounces-855306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2DABE0D09
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEC1188A02E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3F42FF66A;
	Wed, 15 Oct 2025 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAvEdUwX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700B2FCC1E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563732; cv=none; b=tuGBuj7OTduUpFILMFrnq1p3zJq8mGuX7I47OyW5hWu/XU+XiMgwHKtZMEiRNOmoi+mHaWw85++U8kJ//qmYCdToHZW7NZSCQrEkdE7tB3L8PunfEZzhpFUxWA9N7Y3qZfHG7yPbkFN4Gqh7lIHAGkdeL+Xd+FO6ZwxCPixgBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563732; c=relaxed/simple;
	bh=R9vohPS2BBtOxX3RpJ4qxrYpZ/2/ANHFYVGLcZzfodc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qm97FYFIrBzwRgABXbsO3iEyEhQ74eiFxoi0WQo1F1OzrTJanTCQNo4p1CJUWY9j0EvSWZCoka2DWCCvLipfAjPAlrfz0rQhhsX5p+xuLzlpgMU9QTTWXM2kSKBG5ubJMNvQxM3Eqcr6jFyz3PyYibN+NsRV/6kbdDa6XouTs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAvEdUwX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760563731; x=1792099731;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=R9vohPS2BBtOxX3RpJ4qxrYpZ/2/ANHFYVGLcZzfodc=;
  b=KAvEdUwXQ4as0cwv12KiwuZzCYrbVb39Z25mnySE6k0XJMssQ+DqiQVO
   X/QRPwlLmZoNZKWkayO+vox45calecvpvLAZsl5lI1sHdS7ZUzoeaaJ06
   4dMda/k8Hu9cXUPLro+WZLnREsJIgoud/rueD7KdeON9korFsrHa5NgSU
   TxAyExVOv9fhi739M7MZNRVYQio7n02B6ETu2xnsogCcBq5cqArEH3xba
   uaoKUG5U10xI7w/xmhGY7kLc14UIhG27tR/flI0dhwXexu7fZ+l1kSxYk
   nrtCOm+JenP5sOkxjEcHUgVyCYksTgiuAEt5KyG9ndQl0pFuwwoF5Up8/
   w==;
X-CSE-ConnectionGUID: S9Nlg5jkT2GBvrU/3jF2RQ==
X-CSE-MsgGUID: 09ehyJy0SduLFoVHehwMWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="80190342"
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="80190342"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 14:28:50 -0700
X-CSE-ConnectionGUID: el/pq+I7RuCIycDgXejBfQ==
X-CSE-MsgGUID: fidZC/UWRQaskikhwdT0mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="182266913"
Received: from unknown (HELO [10.241.242.248]) ([10.241.242.248])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 14:28:49 -0700
Message-ID: <69796d7945578a89da6d682a2478f9e238659a79.camel@linux.intel.com>
Subject: Re: [PATCH 10/19] sched/fair: Prioritize tasks preferring
 destination LLC during balancing
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
Date: Wed, 15 Oct 2025 14:28:49 -0700
In-Reply-To: <20251015150846.GB3168635@noisy.programming.kicks-ass.net>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
	 <ca1946de63ad9f0ae99e079a74d70c55879cc0b6.1760206683.git.tim.c.chen@linux.intel.com>
	 <20251015150846.GB3168635@noisy.programming.kicks-ass.net>
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

On Wed, 2025-10-15 at 17:08 +0200, Peter Zijlstra wrote:
> On Sat, Oct 11, 2025 at 11:24:47AM -0700, Tim Chen wrote:
> > During LLC load balancing, first check for tasks that prefer the
> > destination LLC and balance them to it before others.
> >=20
> > Mark source sched groups containing tasks preferring non local LLCs
> > with the group_llc_balance flag. This ensures the load balancer later
> > pulls or pushes these tasks toward their preferred LLCs.
> >=20
> > Co-developed-by: Chen Yu <yu.c.chen@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
>=20
> For me this patch is cut too fine; it only sets group_llc_balance but
> then we don't see how it is used.

Okay, will combine this patch with the following one.

>=20
> >  kernel/sched/fair.c | 43 +++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 41 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index cbd1e97bca4b..af7b578eaa06 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9822,8 +9822,7 @@ static __maybe_unused enum llc_mig can_migrate_ll=
c_task(int src_cpu, int dst_cpu
> >  	else
> >  		return mig_unrestricted;
> > =20
> > -	return can_migrate_llc(src_cpu, dst_cpu,
> > -			       task_util(p), to_pref);
> > +	return can_migrate_llc(src_cpu, dst_cpu, task_util(p), to_pref);
> >  }
> > =20
> >  #else
> > @@ -10394,6 +10393,7 @@ struct sg_lb_stats {
> >  	enum group_type group_type;
> >  	unsigned int group_asym_packing;	/* Tasks should be moved to preferre=
d CPU */
> >  	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
> > +	unsigned int group_llc_balance;		/* Tasks should be moved to preferre=
d LLC */
> >  	unsigned long group_misfit_task_load;	/* A CPU has a task too big for=
 its capacity */
> >  #ifdef CONFIG_NUMA_BALANCING
> >  	unsigned int nr_numa_running;
> > @@ -10849,11 +10849,45 @@ static void record_sg_llc_stats(struct lb_env=
 *env,
> >  	if (unlikely(READ_ONCE(sd_share->capacity) !=3D sgs->group_capacity))
> >  		WRITE_ONCE(sd_share->capacity, sgs->group_capacity);
> >  }
> > +
> > +/*
> > + * Do LLC balance on sched group that contains LLC, and have tasks pre=
ferring
> > + * to run on LLC in idle dst_cpu.
> > + */
> > +static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats =
*sgs,
> > +			       struct sched_group *group)
> > +{
> > +	struct sched_domain *child =3D env->sd->child;
> > +	int llc;
> > +
> > +	if (!sched_cache_enabled())
> > +		return false;
> > +
> > +	if (env->sd->flags & SD_SHARE_LLC)
> > +		return false;
> > +
> > +	/* only care about task migration among LLCs */
> > +	if (child && !(child->flags & SD_SHARE_LLC))
> > +		return false;
> > +
> > +	llc =3D llc_idx(env->dst_cpu);
> > +	if (sgs->nr_pref_llc[llc] > 0 &&
>=20
> Nit: s/> 0// would be the same, right?

Sure.

>=20
> > +	    can_migrate_llc(env->src_cpu, env->dst_cpu, 0, true) =3D=3D mig_l=
lc)
> > +		return true;
> > +
> > +	return false;
> > +}
> >  #else
> >  static inline void record_sg_llc_stats(struct lb_env *env, struct sg_l=
b_stats *sgs,
> >  				       struct sched_group *group)
> >  {
> >  }
> > +
> > +static inline bool llc_balance(struct lb_env *env, struct sg_lb_stats =
*sgs,
> > +			       struct sched_group *group)
> > +{
> > +	return false;
> > +}
> >  #endif
> > =20
> >  /**
> > @@ -10954,6 +10988,11 @@ static inline void update_sg_lb_stats(struct l=
b_env *env,
> >  	sgs->group_type =3D group_classify(env->sd->imbalance_pct, group, sgs=
);
> > =20
> >  	record_sg_llc_stats(env, sgs, group);
> > +
> > +	/* Check for tasks in this group can be moved to their preferred LLC =
*/
> > +	if (!local_group && llc_balance(env, sgs, group))
> > +		sgs->group_llc_balance =3D 1;
>=20
> We now have 3 (or so) branches that start with:
>=20
> 	if (!local_group &&
>=20
> perhaps collate that some?

Sure.

>=20
> > +
> >  	/* Computing avg_load makes sense only when group is overloaded */
> >  	if (sgs->group_type =3D=3D group_overloaded)
> >  		sgs->avg_load =3D (sgs->group_load * SCHED_CAPACITY_SCALE) /
> > --=20
> > 2.32.0
> >=20

