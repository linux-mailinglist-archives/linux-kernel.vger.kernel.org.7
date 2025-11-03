Return-Path: <linux-kernel+bounces-883716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFDCC2E2D7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBA83BC85D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D842BEC22;
	Mon,  3 Nov 2025 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyjzqCIT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577A52D5938
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206098; cv=none; b=nQnjxeR8kbV06/bq+o5U9hqFARqCGtJShhB9ktCZhZqzUgZ3bqa87Y59/S4tSs6gjga+sj5raUN0+cVykAJeoCG/g5WI+FQ0NsR5MijOWMXwHqhaSPMq2d7OrVaoF37U2VdPd3CwMBIjrrpnjbCXi61KmMmsPmDPZrx37wKWugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206098; c=relaxed/simple;
	bh=sCLsTKlEpxY8AiaUHlzddcMmymkNDrjLHZK8JZlIo0s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sh6Yv5r6HF+XTSsj1ASXmYooWwN8JD/BvrmemwpH0Pol0EAqpcUItui5w3OQUs2iKec0fKyidtQrFsDUeL/Kx+7YYAr87F8y8zpSkwxEwu94VqqKXP2YiGsTdNtEMGaQ2+7kv3asQ5Abk7/mR+CH153rJiH70MvJXl1VZs7HLbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyjzqCIT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762206096; x=1793742096;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=sCLsTKlEpxY8AiaUHlzddcMmymkNDrjLHZK8JZlIo0s=;
  b=AyjzqCITTLgQ6cI9VtU7RsHxnsmiOH0PPnFsa65idisUsvG8suuOuDdR
   Kkk63Dj9qtfJw3vPV9Wir/XiybZKpGnn9rQPTEjWr0lwoUaDwrIkufliG
   4hXiLUOq1V2G+zoKZunX/kriCosB3c8mU6kAo6e94l3H0eT7PLV8o6IPc
   iyoXnocHe2lfYslEXLROBN/Ifbf4urImYVHfrGymokMssj9XYhlZ98YD+
   tDGp4xGe052Qn3Ents7T+r67AAHTknAJ7ThwT38zh97G8YAstdOFQyp42
   bekqA9HuKtVD1IXU+yfppRXRVF9IPAL7w7XzxQiYRWmHcILVBfKtHATMp
   g==;
X-CSE-ConnectionGUID: uhw57eJHRxW1De7aasdQZA==
X-CSE-MsgGUID: fI3CwjpqQ5GiCloCMMhOfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="51862770"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="51862770"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 13:41:36 -0800
X-CSE-ConnectionGUID: 4nCC/ExiSuem0xBxtcxbCg==
X-CSE-MsgGUID: Y4whzGG0SMej2zlCX07CgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="187429551"
Received: from unknown (HELO [10.241.243.18]) ([10.241.243.18])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 13:41:35 -0800
Message-ID: <35424dcfef4caf32076b4bbece2dafddb495e730.camel@linux.intel.com>
Subject: Re: [PATCH 15/19] sched/fair: Respect LLC preference in task
 migration and detach
From: Tim Chen <tim.c.chen@linux.intel.com>
To: "Chen, Yu C" <yu.c.chen@intel.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>
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
Date: Mon, 03 Nov 2025 13:41:34 -0800
In-Reply-To: <76d1fe33-da20-47b3-9403-f3d6e664ad96@intel.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
	 <d3afcff5622222523c843f5c1b023bfe43f9c67c.1760206683.git.tim.c.chen@linux.intel.com>
	 <5cdf379c-b663-424d-8505-d91046e63c20@amd.com>
	 <0a81b5be-6edd-4231-859b-0c6d06c61595@intel.com>
	 <2c57d76f-fb31-4e1b-a3ce-ca13713e1b86@amd.com>
	 <ebe994addb5624089db71df8fee402a664f8800a.camel@linux.intel.com>
	 <53f9a8dc-c215-405b-958b-9cdd326dbfe3@amd.com>
	 <c85e242d55da1f12419e2c2dc2bfa3fc942a848e.camel@linux.intel.com>
	 <c67f70c5-1082-47e7-8270-f4b8ae05eace@amd.com>
	 <76d1fe33-da20-47b3-9403-f3d6e664ad96@intel.com>
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

On Fri, 2025-10-31 at 23:17 +0800, Chen, Yu C wrote:
> Hi Prateek,
>=20
> On 10/31/2025 11:32 AM, K Prateek Nayak wrote:
> > Hello Tim,
> >=20
> > On 10/31/2025 1:37 AM, Tim Chen wrote:
> > > On Thu, 2025-10-30 at 09:49 +0530, K Prateek Nayak wrote:
> > > > Hello Tim,
> > > >=20
> > > > On 10/30/2025 2:39 AM, Tim Chen wrote:
> > > > > > > I suppose you are suggesting that the threshold for stopping =
task detachment
> > > > > > > should be higher. With the above can_migrate_llc() check, I s=
uppose we have
> > > > > > > raised the threshold for stopping "task detachment"?
> > > > > >=20
> > > > > > Say the LLC is under heavy load and we only have overloaded gro=
ups.
> > > > > > can_migrate_llc() would return "mig_unrestricted" since
> > > > > > fits_llc_capacity() would return false.
> > > > > >=20
> > > > > > Since we are under "migrate_load", sched_balance_find_src_rq() =
has
> > > > > > returned the CPU with the highest load which could very well be=
 the
> > > > > > CPU with with a large number of preferred LLC tasks.
> > > > > >=20
> > > > > > sched_cache_enabled() is still true and when detach_tasks() rea=
ches
> > > > > > one of these preferred llc tasks (which comes at the very end o=
f the
> > > > > > tasks list),
> > > > > > we break out even if env->imbalance > 0 leaving
> > > > >=20
> > > > > Yes, but at least one task has been removed to even the load (mak=
ing forward progress) and
> > > > > the remaining tasks all wish to stay in the current LLC and will
> > > > > preferred not to be moved. My thought was to not even all the loa=
d out
> > > > > in one shot and pull more tasks out of their preferred LLC.
> > > > > If the imbalance still remain, we'll come to that in the next loa=
d balance.
> > > >=20
> > > > In that case, can we spoof a LBF_ALL_PINNED for the case where we s=
tart
> > >=20
> > > In the code chunk (with fix I mentioned in last reply):
> > >=20
> > > +#ifdef CONFIG_SCHED_CACHE
> > > +		/*
> > > +		 * Don't detach more tasks if the remaining tasks want
> > > +		 * to stay. We know the remaining tasks all prefer the
> > > +		 * current LLC, because after order_tasks_by_llc(), the
> > > +		 * tasks that prefer the current LLC are at the tail of
> > > +		 * the list. The inhibition of detachment is to avoid too
> > > +		 * many tasks being migrated out of the preferred LLC.
> > > +		 */
> > > +		if (sched_cache_enabled() && detached && p->preferred_llc !=3D -1 =
&&
> > > +		    llc_id(env->src_cpu) =3D=3D p->preferred_llc &&
> > > 		    llc_id(env->dst_cpu) !=3D p->preferred_llc)
> > > +			break;
> > >=20
> > > We have already pulled at least one task when we stop detaching becau=
se we
> > > know that all the remaining tasks want to stay in it current LLC.
> > > "detached" is non zero when we break. So LBF_ALL_PINNED would be clea=
red.
> > > We will only exit the detach_tasks loop when there are truly no tasks
> > > that can be moved and it is truly a LBF_ALL_PINNED case.
> >=20
> > So what I was suggesting is something like:
> >=20
> > @@ -10251,6 +10252,7 @@ static int detach_tasks(struct lb_env *env)
> >   	unsigned long util, load;
> >   	struct task_struct *p;
> >   	int detached =3D 0;
> > +	bool preserve_preferred;
> >  =20
> >   	lockdep_assert_rq_held(env->src_rq);
> >  =20
> > @@ -10268,6 +10270,10 @@ static int detach_tasks(struct lb_env *env)
> >  =20
> >   	tasks =3D order_tasks_by_llc(env, &env->src_rq->cfs_tasks);
> >  =20
> > +	preserve_preferred =3D sched_cache_enabled() &&
> > +			     !(env->sd->flags & SD_SHARE_LLC) &&
>=20
> Maybe also check (env->sd->child->flag & SD_SHARE_LLC) because we only
> care about the domain that is the parent of a LLC domain.
>=20
> > +			     !sd->nr_balance_failed;
>  > +
> >   	while (!list_empty(tasks)) {
> >   		/*
> >   		 * We don't want to steal all, otherwise we may be treated likewise=
,
> > @@ -10370,16 +10376,15 @@ static int detach_tasks(struct lb_env *env)
> >  =20
> >   #ifdef CONFIG_SCHED_CACHE
> >   		/*
> > -		 * Don't detach more tasks if the remaining tasks want
> > -		 * to stay. We know the remaining tasks all prefer the
> > -		 * current LLC, because after order_tasks_by_llc(), the
> > -		 * tasks that prefer the current LLC are at the tail of
> > -		 * the list. The inhibition of detachment is to avoid too
> > -		 * many tasks being migrated out of the preferred LLC.
> > +		 * We've hit tasks that prefer src LLC while balancing between LLCs.
> > +		 * If previous balances have been successful, pretend the rest of th=
e
> > +		 * tasks on this CPU are pinned and let the main load balancing loop
> > +		 * find another target CPU to pull from if imbalance exists.
> >   		 */
> > -		if (sched_cache_enabled() && detached && p->preferred_llc !=3D -1 &&
> > -		    llc_id(env->src_cpu) =3D=3D p->preferred_llc)
> > +		if (preserve_preferred && detached && llc_id(env->src_cpu) =3D=3D p-=
>preferred_llc) {
> > +			env->flags |=3D LBF_ALL_PINNED;
>=20
> Let me try to understand this strategy: if all previous migrations
> on this sched_domain have succeeded, it means that even if we stop
> migrating tasks out of this busiest CPU from now on, it won=E2=80=99t
> matter because the imbalance has already been mitigated. If we stop
> the migration, we should look for other busy CPUs to pull some tasks
> from. One concern is that setting LBF_ALL_PINNED and only clearing
> env->dst_cpu will trigger a full re-scan of the entire sched_domain,
> which might be costly-especially on large LLCs. We can try this to
> see if it has any impact on the benchmark.

I think it does cause update_sd_lb_stats() to be called again with
the previous rq taken out.  So we are spending more CPU cycles
to find an alternative task to balance to try to preserve LLC preference.

Tim

>=20
> thanks,
> Chenyu
>=20
> >   			break;
> > +		}
> >   #endif
> >  =20
> >=20

