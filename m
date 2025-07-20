Return-Path: <linux-kernel+bounces-738120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCEEB0B49B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3572317BF64
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56481E32D6;
	Sun, 20 Jul 2025 09:38:53 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912824CE08
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753004333; cv=none; b=HSN6Zv/YZQPQGtOLzNJM5mMRMPIEWnqnEDOAJVo1AypxOlAMixxLuSxDrIHU8lMVx9Sc5AL/pifmKSmCKgDj/+K0hsIa7iROZ8kpe4CaGyL3hcR0s/w9KE2Vgqe8dxA+UFV8dyRDdQFzCOIjIJGwoyxq4b71nr04PmhesEnyRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753004333; c=relaxed/simple;
	bh=4GvYpmG6HNnAgt70jwTSAyHms4SjtLPXPX0bzx//lHU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rqcTY6FUNIs+ByXlH0PCsQW+PTmqUhej5KsAcw8eJFjc5UW9pPItOALeWFJHz7I1MDwdfN+QoGTytHSv5rEnpBXpmTkXb5i9UVdmxFNkadj1H3Pl4mR+Cc3reoAPnFD3nRvAMfkG4CvoHQsrviOB2d+saVvRyIpjN6Gga4LeKTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4blHxW48YLzYkxwW;
	Sun, 20 Jul 2025 17:17:51 +0800 (CST)
Received: from a007.hihonor.com (10.68.22.31) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 20 Jul
 2025 17:20:26 +0800
Received: from a008.hihonor.com (10.68.30.56) by a007.hihonor.com
 (10.68.22.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 20 Jul
 2025 17:20:26 +0800
Received: from a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9]) by
 a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9%6]) with mapi id 15.02.1544.011;
 Sun, 20 Jul 2025 17:20:23 +0800
From: liuwenfang <liuwenfang@honor.com>
To: 'Tejun Heo' <tj@kernel.org>
CC: 'David Vernet' <void@manifault.com>, 'Andrea Righi' <arighi@nvidia.com>,
	'Changwoo Min' <changwoo@igalia.com>, 'Ingo Molnar' <mingo@redhat.com>,
	'Peter Zijlstra' <peterz@infradead.org>, 'Juri Lelli'
	<juri.lelli@redhat.com>, 'Vincent Guittot' <vincent.guittot@linaro.org>,
	'Dietmar Eggemann' <dietmar.eggemann@arm.com>, 'Steven Rostedt'
	<rostedt@goodmis.org>, 'Ben Segall' <bsegall@google.com>, 'Mel Gorman'
	<mgorman@suse.de>, 'Valentin Schneider' <vschneid@redhat.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] sched_ext: Fix cpu_released while RT task and SCX
 task are scheduled concurrently
Thread-Topic: [PATCH v2 1/2] sched_ext: Fix cpu_released while RT task and SCX
 task are scheduled concurrently
Thread-Index: AQHb5/jx8N0T8swIHEO5GPUnf7Kp9LQ2cCaAgAPkSGA=
Date: Sun, 20 Jul 2025 09:20:22 +0000
Message-ID: <0144ab66963248cf8587c47bf900aabb@honor.com>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <ced96acd54644325b77c2d8f9fcda658@honor.com>
 <aHltRzhQjwPsGovj@slm.duckdns.org>
In-Reply-To: <aHltRzhQjwPsGovj@slm.duckdns.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks for your feedback.

>=20
> Hello,
>=20
> My aplogies for really late reply. I've been off work and ended up a lot =
more
> offline than I expected.
>=20
> On Sat, Jun 28, 2025 at 06:50:32AM +0000, liuwenfang wrote:
> > Supposed RT task(RT1) is running on CPU0 and RT task(RT2) is awakened
> > on CPU1,
> > RT1 becomes sleep and SCX task(SCX1) will be dispatched to CPU0, RT2
> > will be placed on CPU0:
> >
> > CPU0(schedule)
> CPU1(try_to_wake_up)
> > set_current_state(TASK_INTERRUPTIBLE)              try_to_wake_up #
> RT2
> > __schedule
> select_task_rq # CPU0 is selected
> > LOCK rq(0)->lock # lock CPU0 rq                        ttwu_queue
> >   deactivate_task # RT1                                  LOCK
> rq(0)->lock # busy waiting
> >     pick_next_task # no more RT tasks on rq                 |
> >       prev_balance                                          |
> >         balance_scx                                         |
> >           balance_one                                       |
> >             rq->scx.cpu_released =3D false;                   |
> >               consume_global_dsq                            |
> >                 consume_dispatch_q                          |
> >                   consume_remote_task                       |
> >                     UNLOCK rq(0)->lock                      V
> >                                                          LOCK
> rq(0)->lock # succ
> >                     deactivate_task # SCX1
> ttwu_do_activate
> >                     LOCK rq(0)->lock # busy waiting      activate_task
> # RT2 equeued
> >                        |
> UNLOCK rq(0)->lock
> >                        V
> >                     LOCK rq(0)->lock # succ
> >                     activate_task # SCX1
> >       pick_task # RT2 is picked
> >       put_prev_set_next_task # prev is RT1, next is RT2,
> > rq->scx.cpu_released =3D false; UNLOCK rq(0)->lock
> >
> > At last, RT2 will be running on CPU0 with rq->scx.cpu_released being fa=
lse!
> >
> > So, Add the scx_next_task_picked () and check sched class again to fix
> > the value of rq->scx.cpu_released.
>=20
> Yeah, the problem and diagnosis look correct to me. It'd be nice if we do=
n't have
> to add an explicit hook but ops.cpu_acquire() needs to be called before
> dispatching to the CPU and then we can lose while doing ops.pick_task().
>=20
> > Signed-off-by: l00013971 <l00013971@hihonor.com>
>=20
> Can you please use "FIRST_NAME LAST_NAME <EMAIL>" when signing off?
>=20
> > -static void switch_class(struct rq *rq, struct task_struct *next)
> > +static void switch_class(struct rq *rq, struct task_struct *next,
> > +bool prev_on_scx)
> >  {
> >  	const struct sched_class *next_class =3D next->sched_class;
> >
> > @@ -3197,7 +3197,8 @@ static void switch_class(struct rq *rq, struct
> task_struct *next)
> >  	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
> >  	 * resched.
> >  	 */
> > -	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
> > +	if (prev_on_scx)
> > +		smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
>=20
> It's currently obviously broken as the seq is currently only incremented =
on scx
> -> !scx transitions but it should be called on all transitions. This is a=
 breakage
> introduced by b999e365c298 ("sched, sched_ext: Replace
> scx_next_task_picked() with sched_class->switch_class()").
Thanks for the suggestion.
>=20
> > +void scx_next_task_picked(struct rq *rq, struct task_struct *prev,
> > +			  struct task_struct *next)
> > +{
> > +	bool prev_on_scx =3D prev && (prev->sched_class =3D=3D &ext_sched_cla=
ss);
>=20
> I don't think @prev or @next can ever be NULL, can they?
@prev always has valid value in core scheduler routine.
>=20
> > +
> > +	if (!scx_enabled() ||
>=20
> Let's make this an inline function in ext.h. The pnt_seq update should be=
 moved
> here after scx_enabled() test, I think. This probably should be a separat=
e patch.
Makes sense.  Thanks for the suggestion.
>=20
> > +	    !next ||
> > +	    next->sched_class =3D=3D &ext_sched_class)
> > +		return;
> > +
> > +	switch_class(rq, next, prev_on_scx); }
> >
> >  static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
> >  			      struct task_struct *next)
> >  {
> > @@ -3253,7 +3267,7 @@ static void put_prev_task_scx(struct rq *rq, stru=
ct
> task_struct *p,
> >  		 */
> >  		if (p->scx.slice && !scx_rq_bypassing(rq)) {
> >  			dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
> > -			goto switch_class;
> > +			return;
> ...
> > @@ -2465,6 +2468,8 @@ static inline void put_prev_set_next_task(struct
> > rq *rq,
> >
> >  	__put_prev_set_next_dl_server(rq, prev, next);
> >
> > +	scx_next_task_picked(rq, prev, next);
>=20
> It's a bit unfortunate that we need to add this hook but I can't see anot=
her way
> around it for both the problem you're reporting and the pnt_seq issue.
> Maybe name it scx_put_prev_set_next(rq, prev, next) for consistency?
Makes sense.  Thanks for the suggestion.
>=20
> Thanks.
>=20
> --
> Tejun
--=20
Regards.
wenfang

