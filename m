Return-Path: <linux-kernel+bounces-874143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3720DC159D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A9E3A43B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74A43491D4;
	Tue, 28 Oct 2025 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6Q5cKk5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B3344025
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666371; cv=none; b=XlwMtofsFOqYvZZ1pJ8OuccLKOnQKXsCsFyX7sWBB9MBThNPjC9l9KrmWhMI8ieZjuttoPEMhXAvm2usqvIieGT61nnvMf4cl3iUCOW8Qub37uDVvhGydZxM9T5oFPh2+0lFfCfaXDPsB+9fsbOsUwdMVNZ/BjvKIBQRjPNB+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666371; c=relaxed/simple;
	bh=vudeAFdG/TweTfpCxpKZnI09ZoHlayFDbzLAnUlNrM8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bba3cdquursOZadp9Y1S4E47LS0ujmwt1E08GfT5qhFX7l9bzody4WoeuKb8+/Vu9o5BUjgnYLEl8oalGOPmQmu+1gCFpZNfZWBmYxAMjCpX1mTcCLiyLRuRsm0JxjlhSPMdQGABK0x8rZMlKpLACLp1igUbWBByFj2V70NRJ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6Q5cKk5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761666369; x=1793202369;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=vudeAFdG/TweTfpCxpKZnI09ZoHlayFDbzLAnUlNrM8=;
  b=l6Q5cKk59Yoby1qoAQ5ZLodKkoaNCO7kWzg9QyE1TnIzoDL4dKumX3he
   8WZExMsIj4gbrpzg14jEOkwJbpeJ9O+WxVmvdTpGKb0bZEDpidcB01st5
   7bL/2SVYMydgvbJm6PyPVdeUQ8JSfaI4n0exF3n5tCWQi7m8k4jGY7wEV
   htp9GLdHVqBd7VTGl7RcGd/1g9ICZgh8XPYAuxBDXBmPHNgTqz4X7FzfF
   5NnJ8ggryWY6YzEsZK5jM/okgdRTjJSNo1YOrRyK+VtjVd+jsPMOTBSDe
   eFl43u43cC9TR8aTyd80J8JvgCUK4eS9PI992Xfio44KgFdbvT6BHKpnM
   A==;
X-CSE-ConnectionGUID: ZlE2h5zPQeyD0J8vX3gfvg==
X-CSE-MsgGUID: SPr+R4yIRmq/L32/IZQ5ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75114036"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="75114036"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 08:46:09 -0700
X-CSE-ConnectionGUID: 90yFm0WrQye2V8wWzV0WkA==
X-CSE-MsgGUID: EA8cVz2rSO6DMYmusTtJxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="190506694"
Received: from schen9-mobl4.amr.corp.intel.com (HELO [10.125.109.151]) ([10.125.109.151])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 08:46:06 -0700
Message-ID: <094de5bd4f1b5cd4552ae024f9254df26c9e47be.camel@linux.intel.com>
Subject: Re: [PATCH 07/19] sched/fair: Track LLC-preferred tasks per runqueue
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
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar	 <mingo@redhat.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Date: Tue, 28 Oct 2025 08:46:06 -0700
In-Reply-To: <ab01cb87-71f6-4893-833e-136e7acd777d@intel.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
	 <ccbfda37200b66177a1c1add4715a49b863ac84d.1760206683.git.tim.c.chen@linux.intel.com>
	 <fe5eeffc-ff8f-4bfb-b0a1-5b25731afb88@amd.com>
	 <ab01cb87-71f6-4893-833e-136e7acd777d@intel.com>
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

On Tue, 2025-10-28 at 23:15 +0800, Chen, Yu C wrote:
> On 10/27/2025 2:04 PM, K Prateek Nayak wrote:
> > Hello Tim,
> >=20
> > On 10/11/2025 11:54 PM, Tim Chen wrote:
> > > @@ -3999,6 +4038,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, s=
truct sched_entity *se)
> > >   		struct rq *rq =3D rq_of(cfs_rq);
> > >  =20
> > >   		account_numa_enqueue(rq, task_of(se));
> > > +		account_llc_enqueue(rq, task_of(se));
> > >   		list_add(&se->group_node, &rq->cfs_tasks);
> > >   	}
> > >   	cfs_rq->nr_queued++;
> > > @@ -4010,9 +4050,14 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, =
struct sched_entity *se)
> > >   	update_load_sub(&cfs_rq->load, se->load.weight);
> > >   	if (entity_is_task(se)) {
> > >   		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
> > > +		account_llc_dequeue(rq_of(cfs_rq), task_of(se));
> > >   		list_del_init(&se->group_node);
> > >   	}
> > >   	cfs_rq->nr_queued--;
> > > +
> > > +	/* safeguard to clear the cache aware data */
> > > +	if (!parent_entity(se) && !cfs_rq->nr_queued)
> > > +		reset_llc_stats(rq_of(cfs_rq));
> >=20
> > Instead of relying on reset_llc_stats() hack, I think a better approach
> > would be to have a "p->se.llc_sched_active" flag similar to how uclamp
> > has "uc_se->active" and we set this in account_llc_enqueue() which will
> > still check for sched_cache_enabled() but account_llc_dequeue() would
> > only check for "p->se.llc_sched_active" to decrement the stats and then
> > unset the flag.
> >=20
> > That way, we cannot have an imbalanced accounting. Thoughts?
> >=20
>=20
> I suppose what you mean is to avoid the race condition between
> enabling sched_cache and EQ/DE_LLC, similar to uclamp:
>=20
>          enqueue(taskA)
>          // sched_cache gets enabled
>          enqueue(taskB)
>          dequeue(taskA)
>          // Must not decrement rq->llc_pref for taskA

For this case, task A is already on rq when sched cache get
enabled. But task A's preferred_llc is still -1.=20

If we dequeue it while its preferred_llc is still -1, it won't
affect rq->llc_pref.

If we change its preferred_llc to llc_i before we dequeue it,
then rq->llc_pref[llc_i] will be incremented first.

Then when we dequeue task A, we will decrement it. We are
still accounting rq->llc_pref[llc_i] correctly with current
code.

The trickier case is if we need to dynamically resize
rq->llc_pref[]. We need to make sure that we lock the rq
to prevent enqueue/dequeue, switch it to a larger size
rq->llc_pref[], copy the old data over, then switch over
to the larger sized rq->llc_pref[] and unlock rq to keep
the accounting straight.

Tim=20

>          dequeue(taskB)
>=20
> We'll think more about this.




>=20
> thanks,
> Chenyu

