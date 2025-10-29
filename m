Return-Path: <linux-kernel+bounces-877181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17041C1D616
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5EA188290D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0183161B9;
	Wed, 29 Oct 2025 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iq627on8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF932EA470
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772149; cv=none; b=nf3b+8rc8bIvORQzI0PZuqshPcY/6GL3voIMnk8l5jmgIzH+qhNWeGOz+EDTGw8wvfWE00tSwmJ5dso8RZ1o9OAGaZC3gTeZ8fk2Hk9AHiLNJA6rdFxS8IoWTqAVp5WTIhN2v73uuNAFdcwumtcM0dLH7YOMZjQrKHeh4cFJUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772149; c=relaxed/simple;
	bh=pJsxYRhXFPi762w8ANStIAerwKS3VhKif9rQMWThbRQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gKGljqYCAwPVvwOCdi9Xz19AbhNEm+2sfayTTKfYan9Y84zRm5x4M6rg4ZPCbNjVCIejmaO0nDnOlJukHWZQlAb1rYD2PxfZablh5Rbs1vC+Gt6DpdusO0HQHPXCrS6/Hhal9L0Fa2UYXk5RzOE6oUeAO64aGg+x9KTwFwdCzJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iq627on8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761772147; x=1793308147;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pJsxYRhXFPi762w8ANStIAerwKS3VhKif9rQMWThbRQ=;
  b=Iq627on853QBV0aG1Zgp7sgtTXqudVl0LTrYTEOhSLRXvOmd60UJGCeb
   mvnRSWSve5zFGxFui+VtejHvPrPLU2htY3B62TN1Qet3NCOjzheW8UFxj
   ZuGPRd+HYv6eafiWqrnYg+ljbuDTWRtbQ1wp0NHXNVhkVZ3nqzU+0jT1C
   kalQF1tDPsZwunZgz22K7CmefajIjd5Iguz08YWR0jPz+6/KrB/7InaRr
   I2WrK/ZKLso/YIoScnKMZu2RzSvkebJkBXO1aJouTnSMI3sUlQcfXlaRh
   WImGE7P4DmOoeQg+eCSDL+US/ZxcY7vz7s8kf0hCoLbCO7mBXEyhHYXG0
   A==;
X-CSE-ConnectionGUID: cnjAZkO1QuGuiFgarx+vcw==
X-CSE-MsgGUID: iuQgA+9KRySe121niTPBzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="75354413"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="75354413"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:09:07 -0700
X-CSE-ConnectionGUID: p2htDQpCRfaDYWqEbUrGRQ==
X-CSE-MsgGUID: 5e7e8m9uTACqMn1Q7s+haQ==
X-ExtLoop1: 1
Received: from unknown (HELO [10.241.243.18]) ([10.241.243.18])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:09:05 -0700
Message-ID: <ebe994addb5624089db71df8fee402a664f8800a.camel@linux.intel.com>
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
Date: Wed, 29 Oct 2025 14:09:04 -0700
In-Reply-To: <2c57d76f-fb31-4e1b-a3ce-ca13713e1b86@amd.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
	 <d3afcff5622222523c843f5c1b023bfe43f9c67c.1760206683.git.tim.c.chen@linux.intel.com>
	 <5cdf379c-b663-424d-8505-d91046e63c20@amd.com>
	 <0a81b5be-6edd-4231-859b-0c6d06c61595@intel.com>
	 <2c57d76f-fb31-4e1b-a3ce-ca13713e1b86@amd.com>
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

On Wed, 2025-10-29 at 09:24 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
>=20
> On 10/28/2025 5:28 PM, Chen, Yu C wrote:
> > Hi Prateek,
> >=20
> > On 10/28/2025 2:02 PM, K Prateek Nayak wrote:
> > > Hello Tim,
> > >=20
> > > On 10/11/2025 11:54 PM, Tim Chen wrote:
> > > > @@ -9969,6 +9969,12 @@ int can_migrate_task(struct task_struct *p, =
struct lb_env *env)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->flags & LBF_ACTIVE_LB)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
> > > > =C2=A0 +#ifdef CONFIG_SCHED_CACHE
> > > > +=C2=A0=C2=A0=C2=A0 if (sched_cache_enabled() &&
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can_migrate_llc_task(en=
v->src_cpu, env->dst_cpu, p) =3D=3D mig_forbid)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > +#endif
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 degrades =3D migrate_degrades_locali=
ty(p, env);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!degrades)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hot =3D task=
_hot(p, env);
> > >=20
> > > Should we care for task_hot() w.r.t. migration cost if a task is bein=
g
> > > moved to a preferred LLC?
> > >=20
> >=20
> > This is a good question. The decision not to migrate a task when its
> > LLC preference is violated takes priority over the check in task_hot().
> >=20
> > The main reason is that we want cache aware aggregation to be more
> > aggressive than generic migration; otherwise, cache-aware migration
> > =C2=A0might not take effect according to our previous test. This seems =
to
> > be a trade-off. Another consideration might be: should we consider
> > the occupancy of a single thread or that of the entire process?
> > For example, suppose t0, t1, and t2 belong to the same process. t0
> > and t1 are running on the process's preferred LLC0, while t2 is
> > running on the non-preferred LLC1. Even though t2 has high occupancy
> > on LLC1 (making it cache-hot on LLC1), we might still want to move t2
> > to LLC0 if t0, t1, and t2 read from and write to each other - since we =
don't want to generate cross-LLC access.
>=20
> Makes sense. That would need some heuristics based on the avg_running
> to know which LLC can be be a potential target with fewest migrations.
> But then again, in a dynamic system things change so quickly - what
> you have now seems to be a good start to further optimize on top of.
>=20
> >=20
> > > Also, should we leave out tasks under core scheduling from the llc
> > > aware lb? Even discount them when calculating "mm->nr_running_avg"?
> > >=20
> > Yes, it seems that the cookie match check case was missed, which is
> > embedded in task_hot(). I suppose you are referring to the p->core_cook=
ie
> > check; I'll look into this direction.
>=20
> Yup! I think if user has opted into core scheduling, they should ideally
> not bother about cache aware scheduling.
>=20
> >=20
> > > > @@ -10227,6 +10233,20 @@ static int detach_tasks(struct lb_env *env=
)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->imb=
alance <=3D 0)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 break;
> > > > =C2=A0 +#ifdef CONFIG_SCHED_CACHE
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Don't detach mo=
re tasks if the remaining tasks want
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to stay. We kno=
w the remaining tasks all prefer the
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * current LLC, be=
cause after order_tasks_by_llc(), the
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * tasks that pref=
er the current LLC are at the tail of
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the list. The i=
nhibition of detachment is to avoid too
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * many tasks bein=
g migrated out of the preferred LLC.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sched_cache_enabled=
() && detached && p->preferred_llc !=3D -1 &&
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 llc_id(env->src_cpu) =3D=3D p->preferred_llc)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 break;
> > >=20
> > > In all cases?=C2=A0
> > >=20

Not in all cases, but only when we know that the remaining tasks prefer to
stay in current LLC and not be moved to an LLC it doesn't like.

I think we need to add the check that
llc_id(env->dst_cpu) !=3D p->preferred_llc in the above condition=20

> > > Should we check can_migrate_llc() wrt to util migrated and
> > > then make a call if we should move the preferred LLC tasks or not?
> > >=20
> >=20
> > Prior to this "stop of detaching tasks", we performed a can_migrate_tas=
k(p)
> > to determine if the detached p is dequeued from its preferred LLC, and =
in
> > can_migrate_task(), we use can_migrate_llc_task() -> can_migrate_llc() =
to
> > carry out the check. That is to say, only when certain tasks have been
> > detached, will we stop further detaching.
> >=20
> > > Perhaps disallow it the first time if "nr_balance_failed" is 0 but
> > > subsequent failed attempts should perhaps explore breaking the prefer=
red
> > > llc restriction if there is an imbalance and we are under
> > > "mig_unrestricted" conditions.
> > >=20
> >=20
> > I suppose you are suggesting that the threshold for stopping task detac=
hment
> > should be higher. With the above can_migrate_llc() check, I suppose we =
have
> > raised the threshold for stopping "task detachment"?
>=20
> Say the LLC is under heavy load and we only have overloaded groups.
> can_migrate_llc() would return "mig_unrestricted" since
> fits_llc_capacity() would return false.
>=20
> Since we are under "migrate_load", sched_balance_find_src_rq() has
> returned the CPU with the highest load which could very well be the
> CPU with with a large number of preferred LLC tasks.
>=20
> sched_cache_enabled() is still true and when detach_tasks() reaches
> one of these preferred llc tasks (which comes at the very end of the
> tasks list),=C2=A0
> we break out even if env->imbalance > 0 leaving

Yes, but at least one task has been removed to even the load (making forwar=
d progress) and
the remaining tasks all wish to stay in the current LLC and will
preferred not to be moved. My thought was to not even all the load out
in one shot and pull more tasks out of their preferred LLC.
If the imbalance still remain, we'll come to that in the next load balance.

Pulling tasks more slowly when we come to tasks that preferred to stay (if =
possible)
would also help to prevent tasks bouncing between LLC.

Tim

> potential imbalance for the "migrate_load" case.
>=20
> Instead, we can account for the util moved out of the src_llc and
> after accounting for it, check if can_migrate_llc() would return
> "mig_forbid" for the src llc.

