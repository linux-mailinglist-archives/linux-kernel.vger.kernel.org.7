Return-Path: <linux-kernel+bounces-773404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3802AB29F60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B18E167464
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF06F258EFD;
	Mon, 18 Aug 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="CgKCo4F3"
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E39742A9D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513961; cv=none; b=AYdjvksYe24e2poQ+Y7DE1npQiCGxMjSD6KD4RdLCHFrbAbp8CzZC/ysLl9hAjP7gPLx0mzxz8v2IhtQOLobFM2GyocqYDHRC7BdS7igO52r8EfWP9C3W853hM9J4Z5UvBoV9oe5Sf+a2b8Z9GfAo+vaxKUYazLGZx6DLQmFhw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513961; c=relaxed/simple;
	bh=EwlvrNsrMitT/xR00pxMzniHGAvlmyS23+YHAHRFCLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cttQCD+cgEqMQ/NCchqRVMO3OlM4H8EZm3qV/wpUHokmKWAwJPAuJ/2xGu8YUnfAzpOOmpTqThBoBvdT7KkkdBGkvNMN2gvgKkBzbV3+BsCzXyqk4n5jWG5nUj7Oo4hWGQibok4pFqGry7ltw3Rps3qwH61HHLHPE3V+PZt0HbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=CgKCo4F3; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=2SPTdWEKzka/YphNEI7Bpnrx82zNR6q20EPxl5Ww6lA=;
	b=CgKCo4F398GSp3PispnLk9cYiKCXLMHmWWkpFdNRL0KhLOAXFEPords+3V3UOlpSAdBYSJ0YF
	ZAkQ8yCnVx0gX+YQjhCHlxqyy4Sxz10ZBg0L+UyrQQzHZTTxgcEjqnLGQcKo/MD975tvuYQv+iN
	jMMfHn+InmIat72yQMCSuJY=
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4c58Wb62vRzYm6BF;
	Mon, 18 Aug 2025 18:45:47 +0800 (CST)
Received: from a003.hihonor.com (10.68.18.8) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 18:45:55 +0800
Received: from a008.hihonor.com (10.68.30.56) by a003.hihonor.com (10.68.18.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 18:45:55 +0800
Received: from a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9]) by
 a008.hihonor.com ([fe80::aed1:4fa1:46bd:7de9%6]) with mapi id 15.02.1544.011;
 Mon, 18 Aug 2025 18:45:55 +0800
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
Subject: RE: [PATCH v3 1/3] sched_ext: Fix pnt_seq calculation
Thread-Topic: [PATCH v3 1/3] sched_ext: Fix pnt_seq calculation
Thread-Index: AQHb+VnBbe5K4qfqzkuJHukI3dznUrRdwDEAgAAHtgCAChnUHA==
Date: Mon, 18 Aug 2025 10:45:55 +0000
Message-ID: <b1898ea1365d460e89b64989304ea0f7@honor.com>
References: <fca528bb34394de3a7e87a873fadd9df@honor.com>
 <aFmwHzO2AKFXO_YS@slm.duckdns.org>
 <7ae16e02aba64a318d8e67be9e3b7f8e@honor.com>
 <aHlvpRIcymNPPWh9@slm.duckdns.org>
 <46cef95e02d64b35a9d9d51d5debee22@honor.com>
 <6ccd5ef5752d4cc1818e152f6b3458b0@honor.com>
 <aJqExL-CjemhWfqB@slm.duckdns.org> <aJqLPLxpNgKWbFmu@slm.duckdns.org>
In-Reply-To: <aJqLPLxpNgKWbFmu@slm.duckdns.org>
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

> Hello,
>=20
> On Mon, Aug 11, 2025 at 02:03:16PM -1000, 'Tejun Heo' wrote:
> ...
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c index
> > > 0fb9bf995..50d757e92 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -8887,6 +8887,9 @@ pick_next_task_fair(struct rq *rq, struct
> > > task_struct *prev, struct rq_flags *rf
> > >
> > >  	__put_prev_set_next_dl_server(rq, prev, p);
> > >
> > > +	if (scx_enabled())
> > > +		scx_put_prev_set_next(rq, prev, p);
> > > +
> > >  	/*
> > >  	 * Because of the set_next_buddy() in dequeue_task_fair() it is rat=
her
> > >  	 * likely that a next task is from the same cgroup as the current.
> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h index
> > > 47972f34e..bcb7f175c 100644 @@ -2465,6 +2470,9 @@ static inline void
> > > put_prev_set_next_task(struct rq *rq,
> > >
> > >  	__put_prev_set_next_dl_server(rq, prev, next);
> > >
> > > +	if (scx_enabled())
> > > +		scx_put_prev_set_next(rq, prev, next);
> > > +
> > >  	if (next =3D=3D prev)
> > >  		return;
> >
> > I'm not sure these are the best spots to call this function. How about
> > putting it in the CONFIG_SCHED_CLASS_EXT section in prev_balance()?
> > The goal of the seq counter is to wait for scheduler path to be
> > entered, so that's good enough a spot and there already is scx
> > specific section, so it doesn't add too much noise.
>=20
> Strike that. I see that we need a hook after task is picked to resolve th=
e bug
> around cpu_released. Can you please move scx_enabled() test into
> scx_put_prev_set_next() and add a helper which calls both
> __put_prev_set_next_dl_server() and scx_put_prev_set_next() so that the c=
all
> doesn't have to be added to two places?
Thanks for your feedback.

__put_prev_set_next is added here as the helper, the fixed function is:

+void scx_put_prev_set_next(struct rq *rq, struct task_struct *prev,
+                          struct task_struct *next)
+{
+       if (!scx_enabled())
+               return;
+
+#ifdef CONFIG_SMP
+       /*
+        * Pairs with the smp_load_acquire() issued by a CPU in
+        * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
+        * resched.
+        */
+       smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
+#endif
+}

+static inline void __put_prev_set_next(struct rq *rq,
+                                      struct task_struct *prev,
+                                      struct task_struct *next)
+{
+       __put_prev_set_next_dl_server(rq, prev, next);
+       scx_put_prev_set_next(rq, prev, next);
+}
+
 static inline void put_prev_set_next_task(struct rq *rq,
                                          struct task_struct *prev,
                                          struct task_struct *next)
 {
        WARN_ON_ONCE(rq->curr !=3D prev);

-       __put_prev_set_next_dl_server(rq, prev, next);
+       __put_prev_set_next(rq, prev, next);

        if (next =3D=3D prev)

pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flag=
s *rf
        if (prev->sched_class !=3D &fair_sched_class)
                goto simple;

-       __put_prev_set_next_dl_server(rq, prev, p);
+       __put_prev_set_next(rq, prev, p);

Any suggestions will be appreciated and a formal patch will be sent out lat=
er.
>=20
> Thanks.
>=20
> --
> Tejun
Thanks.

Wenfang

