Return-Path: <linux-kernel+bounces-883735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AD3C2E36A
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 23:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854AE3AF9E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 22:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7722C324F;
	Mon,  3 Nov 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gY/WTYZi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B42535979
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 22:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762207671; cv=none; b=Oh3F/ghVGKvpRuP7r01x4qzy/mFX5DhueRakmi44Mk5tdUEBgFKBbG2svbql3hcH1+dALxDmq5gWmQfL/8HTV+T6Guq+kZ20HXKOL+anbX4lqFW9f+igIyMOiTOmKyfl7bae7sjE2MrvTJl+UFK1HWKux2+LB+IWREYiFzDTPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762207671; c=relaxed/simple;
	bh=c8uYm77U1w3uq2OlVJoVAYyCIjelcny4A8iuX8Cm0+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KED44fk43G2soh2V8K9/qosUo2zdBf1/GXRpQpzsMv6FXdR/hN+s8roH4Op388o3AIZlTiCUbczkRgGmt7HsP/9RKxhePEHii7VuuwK7LRMk4dgrxHwV3uywIj8iQFCBeEn+BZyJCOm5i7c+hrDBFTEL+m32HYlHOOQk3q49C3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gY/WTYZi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762207669; x=1793743669;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=c8uYm77U1w3uq2OlVJoVAYyCIjelcny4A8iuX8Cm0+k=;
  b=gY/WTYZikN522973Ason0jBmOHbHgbpIzyCL/hUDMuLhxStRpURk+w1N
   E0tAi/PlKAtbxrSlqWWxrtR9NVGnOX/VleIQbMOdb+KhUoJbdONvnW1jY
   hGGGVX/auMe4JuKwPe+DXAIcdDeyJeow3QAMHDdwtapnnWRTEhKTNordD
   7lqzhIPPx0KhrYrQdcBNAFjSLR7Z+d7YhVXSyfe7e3h6oCU4SZWbaVlhD
   Xr6Tx77zEB3orf/mH8oRqc9yql2MSTlYSwqajLHl0/E2TReaEDyNnPXrQ
   1UqEzRJngTp4LG8L70iss4muIrEnDYoIwPCX+8RHSLMUJAaZwagiZRxJ/
   g==;
X-CSE-ConnectionGUID: yDs8M+k4QSi4d5vrbj2XIQ==
X-CSE-MsgGUID: /uDcPaJdQ8Gc6Led+SDqDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64180310"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="64180310"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 14:07:47 -0800
X-CSE-ConnectionGUID: PBXsFZelTVGl7NDWoNVaLA==
X-CSE-MsgGUID: NGtTRIioTAusdhHMA9UPTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="187434622"
Received: from unknown (HELO [10.241.243.18]) ([10.241.243.18])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 14:07:47 -0800
Message-ID: <385f25226e647f85350d3b397fdde1204599dc3e.camel@linux.intel.com>
Subject: Re: [PATCH 15/19] sched/fair: Respect LLC preference in task
 migration and detach
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, "Chen, Yu C"
 <yu.c.chen@intel.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli	
 <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>,  Valentin Schneider	 <vschneid@redhat.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Hillf Danton
 <hdanton@sina.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Jianyong Wu	
 <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>, Tingyin Duan	
 <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len Brown	
 <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>, Zhao Liu	
 <zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, Adam Li	
 <adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar
 <mingo@redhat.com>
Date: Mon, 03 Nov 2025 14:07:46 -0800
In-Reply-To: <c67f70c5-1082-47e7-8270-f4b8ae05eace@amd.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
	 <d3afcff5622222523c843f5c1b023bfe43f9c67c.1760206683.git.tim.c.chen@linux.intel.com>
	 <5cdf379c-b663-424d-8505-d91046e63c20@amd.com>
	 <0a81b5be-6edd-4231-859b-0c6d06c61595@intel.com>
	 <2c57d76f-fb31-4e1b-a3ce-ca13713e1b86@amd.com>
	 <ebe994addb5624089db71df8fee402a664f8800a.camel@linux.intel.com>
	 <53f9a8dc-c215-405b-958b-9cdd326dbfe3@amd.com>
	 <c85e242d55da1f12419e2c2dc2bfa3fc942a848e.camel@linux.intel.com>
	 <c67f70c5-1082-47e7-8270-f4b8ae05eace@amd.com>
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

On Fri, 2025-10-31 at 09:02 +0530, K Prateek Nayak wrote:
> Hello Tim,
>=20
> On 10/31/2025 1:37 AM, Tim Chen wrote:
> > On Thu, 2025-10-30 at 09:49 +0530, K Prateek Nayak wrote:
> > > Hello Tim,
> > >=20
> > > On 10/30/2025 2:39 AM, Tim Chen wrote:
> > > > > > I suppose you are suggesting that the threshold for stopping ta=
sk detachment
> > > > > > should be higher. With the above can_migrate_llc() check, I sup=
pose we have
> > > > > > raised the threshold for stopping "task detachment"?
> > > > >=20
> > > > > Say the LLC is under heavy load and we only have overloaded group=
s.
> > > > > can_migrate_llc() would return "mig_unrestricted" since
> > > > > fits_llc_capacity() would return false.
> > > > >=20
> > > > > Since we are under "migrate_load", sched_balance_find_src_rq() ha=
s
> > > > > returned the CPU with the highest load which could very well be t=
he
> > > > > CPU with with a large number of preferred LLC tasks.
> > > > >=20
> > > > > sched_cache_enabled() is still true and when detach_tasks() reach=
es
> > > > > one of these preferred llc tasks (which comes at the very end of =
the
> > > > > tasks list),=C2=A0
> > > > > we break out even if env->imbalance > 0 leaving
> > > >=20
> > > > Yes, but at least one task has been removed to even the load (makin=
g forward progress) and
> > > > the remaining tasks all wish to stay in the current LLC and will
> > > > preferred not to be moved. My thought was to not even all the load =
out
> > > > in one shot and pull more tasks out of their preferred LLC.
> > > > If the imbalance still remain, we'll come to that in the next load =
balance.
> > >=20
> > > In that case, can we spoof a LBF_ALL_PINNED for the case where we sta=
rt
> >=20
> > In the code chunk (with fix I mentioned in last reply):
> >=20
> > +#ifdef CONFIG_SCHED_CACHE
> > +		/*
> > +		 * Don't detach more tasks if the remaining tasks want
> > +		 * to stay. We know the remaining tasks all prefer the
> > +		 * current LLC, because after order_tasks_by_llc(), the
> > +		 * tasks that prefer the current LLC are at the tail of
> > +		 * the list. The inhibition of detachment is to avoid too
> > +		 * many tasks being migrated out of the preferred LLC.
> > +		 */
> > +		if (sched_cache_enabled() && detached && p->preferred_llc !=3D -1 &&
> > +		    llc_id(env->src_cpu) =3D=3D p->preferred_llc &&
> > 		    llc_id(env->dst_cpu) !=3D p->preferred_llc)
> > +			break;
> >=20
> > We have already pulled at least one task when we stop detaching because=
 we
> > know that all the remaining tasks want to stay in it current LLC.
> > "detached" is non zero when we break. So LBF_ALL_PINNED would be cleare=
d.
> > We will only exit the detach_tasks loop when there are truly no tasks
> > that can be moved and it is truly a LBF_ALL_PINNED case.
>=20
> So what I was suggesting is something like:
>=20
> @@ -10251,6 +10252,7 @@ static int detach_tasks(struct lb_env *env)
>  	unsigned long util, load;
>  	struct task_struct *p;
>  	int detached =3D 0;
> +	bool preserve_preferred;
> =20
>  	lockdep_assert_rq_held(env->src_rq);
> =20
> @@ -10268,6 +10270,10 @@ static int detach_tasks(struct lb_env *env)
> =20
>  	tasks =3D order_tasks_by_llc(env, &env->src_rq->cfs_tasks);
> =20
> +	preserve_preferred =3D sched_cache_enabled() &&
> +			     !(env->sd->flags & SD_SHARE_LLC) &&
> +			     !sd->nr_balance_failed;
> +
>  	while (!list_empty(tasks)) {
>  		/*
>  		 * We don't want to steal all, otherwise we may be treated likewise,
> @@ -10370,16 +10376,15 @@ static int detach_tasks(struct lb_env *env)
> =20
>  #ifdef CONFIG_SCHED_CACHE
>  		/*
> -		 * Don't detach more tasks if the remaining tasks want
> -		 * to stay. We know the remaining tasks all prefer the
> -		 * current LLC, because after order_tasks_by_llc(), the
> -		 * tasks that prefer the current LLC are at the tail of
> -		 * the list. The inhibition of detachment is to avoid too
> -		 * many tasks being migrated out of the preferred LLC.
> +		 * We've hit tasks that prefer src LLC while balancing between LLCs.
> +		 * If previous balances have been successful, pretend the rest of the
> +		 * tasks on this CPU are pinned and let the main load balancing loop
> +		 * find another target CPU to pull from if imbalance exists.
>  		 */
> -		if (sched_cache_enabled() && detached && p->preferred_llc !=3D -1 &&
> -		    llc_id(env->src_cpu) =3D=3D p->preferred_llc)
> +		if (preserve_preferred && detached && llc_id(env->src_cpu) =3D=3D p->p=
referred_llc) {
> +			env->flags |=3D LBF_ALL_PINNED;
>  			break;
> +		}
>  #endif
> =20

You have a good point.  If all the remaining tasks on the rq prefer src_llc=
,
we should find an alternative rq to pull tasks from by specifying LBF_ALL_P=
INNED.

This policy makes sense for the migrate_task and migrate_llc_task case.
I have to think about the migrate_util case, where the source group is over=
loaded
and dst group has spare capacity, and tasks in the source group are in thei=
r
preferred LLC.

Tim

