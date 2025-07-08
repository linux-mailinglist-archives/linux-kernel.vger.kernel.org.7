Return-Path: <linux-kernel+bounces-722426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EDDAFDA4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A663754013C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE7A1B4257;
	Tue,  8 Jul 2025 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUjgpIsq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECD924678C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752011996; cv=none; b=KoDopaOw6ghf7pWWb1/SsOU6yWKvicD23kuEEyNIhblYnXMH+gHdvwEkbAaFCJPPx9sYxnPpXp04Lm2SAGdTTEkSKu1uXaJJV/0Vz5WBuethZcB612dSMr7eCP/3erK6sxZQDOWtj7C+zM0LQjB7QwGWb/vtyOtDEMtlfEkVBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752011996; c=relaxed/simple;
	bh=8t6AIcoGGRyuhnWNpkjLmLn7GypVfvggJC1THX5FHTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OSozuJcMLMDHmofoaTr81tkbTNRSnFI1/as1H/OS5u1PKP+mv+65m7FE3v3DgNv2enErs7tnY6V/y8SZNOTyQPn9CfwFuzlK2tzr8+VfUt+SKFcUD095L144CLanPqqeDnwxZjUgkDvst2dy63b7zpkJYOOGiUKkbWWGJku6brY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUjgpIsq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752011994; x=1783547994;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=8t6AIcoGGRyuhnWNpkjLmLn7GypVfvggJC1THX5FHTo=;
  b=nUjgpIsqx3u+bgBbIsbf7EGRTvQsrrhPFIIehiAAqtE5JVg3HyZox9om
   z68my93kiSNaCB1uIGsdAUMrFl5MsMV0NBLJDCq6NyCzIDiV98pEVjinu
   nrKej7RN8uouSH34CMk5M4ttv+yV9CoUrTEUBfG7DznMH1P9L+ASM/mzB
   IJ2KleKoW8+HPt9CK3ZvhT03Ff8G8Rl/xM+BI6IjKWknq4mNd3u+6XDfP
   sGkj4P8fzMs0z8trP+ZCD3hpxtjXeN6eKaVwl8ex1586jjVZB0JV8UL1b
   AftltywjEmrwMVxbPXwc2i+lhpbmLvylo3+yd4efe9jUMgSX/nwBnADT5
   g==;
X-CSE-ConnectionGUID: dM1IIMCgQy2DezBGO3/RIg==
X-CSE-MsgGUID: 5aAgjkWOSYmHBJlM7JD2qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54122276"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54122276"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 14:59:53 -0700
X-CSE-ConnectionGUID: 9fm62UAOTCSzoo7XqG0eiQ==
X-CSE-MsgGUID: y+8aGWUkQQyowxhk+o1evA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155337693"
Received: from jjgreens-desk20.amr.corp.intel.com (HELO [10.124.220.243]) ([10.124.220.243])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 14:59:52 -0700
Message-ID: <1ece810c6fc291357f4fca3b2c087e2d73c0dc64.camel@linux.intel.com>
Subject: Re: [RFC patch v3 07/20] sched: Add helper function to decide
 whether to allow cache aware scheduling
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Libo Chen <libo.chen@oracle.com>, Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, Tim Chen <tim.c.chen@intel.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Abel Wu <wuyun.abel@bytedance.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Hillf Danton
 <hdanton@sina.com>, Len Brown <len.brown@intel.com>, 
 linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Date: Tue, 08 Jul 2025 14:59:51 -0700
In-Reply-To: <7f4f1684-fbe6-4148-bbe4-fc2e138abb98@oracle.com>
References: <cover.1750268218.git.tim.c.chen@linux.intel.com>
	 <abb433c3345587d068e5381c65e9d0b3f50828d9.1750268218.git.tim.c.chen@linux.intel.com>
	 <7f4f1684-fbe6-4148-bbe4-fc2e138abb98@oracle.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-07 at 17:41 -0700, Libo Chen wrote:
> Hi Tim and Chenyu,
>=20
>=20
> On 6/18/25 11:27, Tim Chen wrote:
> > Cache-aware scheduling is designed to aggregate threads into their
> > preferred LLC, either via the task wake up path or the load balancing
> > path. One side effect is that when the preferred LLC is saturated,
> > more threads will continue to be stacked on it, degrading the workload'=
s
> > latency. A strategy is needed to prevent this aggregation from going to=
o
> > far such that the preferred LLC is too overloaded.
> >=20
> > Introduce helper function _get_migrate_hint() to implement the LLC
> > migration policy:
> >=20
> > 1) A task is aggregated to its preferred LLC if both source/dest LLC
> >    are not too busy (<50% utilization, tunable), or the preferred
> >    LLC will not be too out of balanced from the non preferred LLC
> >    (>20% utilization, tunable, close to imbalance_pct of the LLC
> >    domain).
> > 2) Allow a task to be moved from the preferred LLC to the
> >    non-preferred one if the non-preferred LLC will not be too out
> >    of balanced from the preferred prompting an aggregation task
> >    migration later.  We are still experimenting with the aggregation
> >    and migration policy. Some other possibilities are policy based
> >    on LLC's load or average number of tasks running.  Those could
> >    be tried out by tweaking _get_migrate_hint().
> >=20
> > The function _get_migrate_hint() returns migration suggestions for the =
upper-le
> > +__read_mostly unsigned int sysctl_llc_aggr_cap       =3D 50;
> > +__read_mostly unsigned int sysctl_llc_aggr_imb       =3D 20;
> > +
>=20
>=20
> I think this patch has a great potential.
>=20

Thanks for taking a look.

> Since _get_migrate_hint() is tied to an individual task anyway, why not a=
dd a
> per-task llc_aggr_imb which defaults to the sysctl one?=C2=A0
>=20

_get_migrate_hint() could also be called from llc_balance(). At that time
we make a determination of whether we should do llc_balance() without knowi=
ng
which exact task we're going to move, but still observe the migration polic=
y
that shouldn't cause too much imbalance.  So it may not be strictly tied to=
 a task
in the current implementation.

> Tasks have different
> preferences for llc stacking, they can all be running in the same system =
at the
> same time. This way you can offer a greater deal of optimization without =
much
> burden to others.

You're thinking of something like a prctl knob that will bias aggregation f=
or
some process?  Wonder if Peter has some opinion on this.

>=20
> Also with sysctl_llc_aggr_imb, do we really need SCHED_CACHE_WAKE?
>=20

Actually we think that we can do without SCHED_CACHE_WAKE feature and rely =
only
on load balance SCHED_CACHE_LB.  But still keeping=20

>  Does setting
> sysctl_llc_aggr_imb to 0 basically say no preference for either LLC, no?

Aggregation will tend to make utilization on the preferred LLC to be more
than the non-preferred one.  Parameter "sysctl_llc_aggr_imb" is the imbalan=
ce
allowed.  If we set this to 0, as long as the preferred LLC is not utilized
more than the source LLC, we could still aggregate towards the preferred LL=
C
and a preference could still be there. =20

Tim

>=20
> Thanks,
> Libo
>=20
> > +static enum llc_mig_hint _get_migrate_hint(int src_cpu, int dst_cpu,
> > +					   unsigned long tsk_util,
> > +					   bool to_pref)
> > +{
> > +	unsigned long src_util, dst_util, src_cap, dst_cap;
> > +
> > +	if (cpus_share_cache(src_cpu, dst_cpu))
> > +		return mig_allow;
> > +
> > +	if (!get_llc_stats(src_cpu, &src_util, &src_cap) ||
> > +	    !get_llc_stats(dst_cpu, &dst_util, &dst_cap))
> > +		return mig_allow;
> > +
> > +	if (!fits_llc_capacity(dst_util, dst_cap) &&
> > +	    !fits_llc_capacity(src_util, src_cap))
> > +		return mig_ignore;
> > +
> > +	src_util =3D src_util < tsk_util ? 0 : src_util - tsk_util;
> > +	dst_util =3D dst_util + tsk_util;
> > +	if (to_pref) {
> > +		/*
> > +		 * sysctl_llc_aggr_imb is the imbalance allowed between
> > +		 * preferred LLC and non-preferred LLC.
> > +		 * Don't migrate if we will get preferred LLC too
> > +		 * heavily loaded and if the dest is much busier
> > +		 * than the src, in which case migration will
> > +		 * increase the imbalance too much.
> > +		 */
> > +		if (!fits_llc_capacity(dst_util, dst_cap) &&
> > +		    util_greater(dst_util, src_util))
> > +			return mig_forbid;
> > +	} else {
> > +		/*
> > +		 * Don't migrate if we will leave preferred LLC
> > +		 * too idle, or if this migration leads to the
> > +		 * non-preferred LLC falls within sysctl_aggr_imb percent
> > +		 * of preferred LLC, leading to migration again
> > +		 * back to preferred LLC.
> > +		 */
> > +		if (fits_llc_capacity(src_util, src_cap) ||
> > +		    !util_greater(src_util, dst_util))
> > +			return mig_forbid;
> > +	}
> > +	return mig_allow;
> > +}
>=20
>=20


