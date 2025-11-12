Return-Path: <linux-kernel+bounces-898200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C14C548ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CB23B6059
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFBD2D97BD;
	Wed, 12 Nov 2025 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bi+12BAQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7129B22F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981818; cv=none; b=Ot0XgauEWagelEoUB6FGR3qW97UrOLv0Ol80En1WvI+t/Sx/I/WlkxHqsmMsZhevDIDEnQHAlTzFOWVFkC/WGozY/OPCBEaQ1Suy9wMYlsfyTKiccf2rcJTqqur3rSxct14z/5chr4XMpfE199T4Q5XSA887Zu9xlVyui9Oyx4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981818; c=relaxed/simple;
	bh=+TSxyVVPp8zfG/MM9qXJgfikIrCe/iQHqRmicfEhc64=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=exYYRAGJPgMEz7Q5H5iLocpTlg/MwSdafwATzpuaqWO78/3nAi+HyzO1L3KwymtcfXn487u5mthufL/7zYViwjgWs2zxuRcHhHCe3QSx04ZNX9fCWm+4Xe/zuFZ3NddmqgveyaX6zjmKTchN+NVLDaV2Ew+BXWL6RkQ1SfnMS5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bi+12BAQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762981816; x=1794517816;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+TSxyVVPp8zfG/MM9qXJgfikIrCe/iQHqRmicfEhc64=;
  b=bi+12BAQeWqUX531EYmdawI/MIlCjzXdfaju8FdoWkqRnq8WZBTsVo/j
   2urTrint7/hRSom4ySNY3wjpUgRXvFYdB3nb/Fq779mNWoMv44kHcirG+
   xN8oYn7ZGHllXxY4mTGzKQw5lnD3QMeV6bR7HpoAQ1W254ofiajdn0ak5
   TROK6oYDwbX2a3DPt7R4ACEvxt09jmRxUfOH499nSIMpyeXVJea3I5RxH
   JvVN76+59fEnP2dKC165tZG7jaypvXWiIxjfZXuQKy2/jaO9AqBIOC1QG
   W7+KLajVQEBSviArAB/Sh2MZlXr69VWPxIGZbuG5BRuRUDv0kMpd9vyT9
   A==;
X-CSE-ConnectionGUID: yt85N4unS3WkdlgqgWzYiQ==
X-CSE-MsgGUID: 8to+/bcMSJi/M+D+Hn6eXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="76403594"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="76403594"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 13:10:15 -0800
X-CSE-ConnectionGUID: eF8OQFEEQwuopAOz9L+BAg==
X-CSE-MsgGUID: Vh475kz5RLGJluRoOctI9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="193716136"
Received: from unknown (HELO [10.241.243.18]) ([10.241.243.18])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 13:10:15 -0800
Message-ID: <c6fe7ac0f6de4d51705bb2f24f82df2c3018804f.camel@linux.intel.com>
Subject: Re: [PATCH v4] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>, Shrikanth Hegde
	 <sshegde@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Doug
 Nelson	 <doug.nelson@intel.com>, Mohini Narkhede
 <mohini.narkhede@intel.com>, 	linux-kernel@vger.kernel.org, Vincent Guittot
 <vincent.guittot@linaro.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Srikar Dronamraju <srikar@linux.ibm.com>, Linus Torvalds	
 <torvalds@linux-foundation.org>
Date: Wed, 12 Nov 2025 13:10:15 -0800
In-Reply-To: <20251112112113.GO278048@noisy.programming.kicks-ass.net>
References: 
	<6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
	 <aRQ_D1vyNfGVo-xK@linux.ibm.com>
	 <20251112103740.GF4067720@noisy.programming.kicks-ass.net>
	 <20251112104555.GE4068168@noisy.programming.kicks-ass.net>
	 <55e02921-6477-4ed0-9ef6-16c3f34594a8@linux.ibm.com>
	 <20251112112113.GO278048@noisy.programming.kicks-ass.net>
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

On Wed, 2025-11-12 at 12:21 +0100, Peter Zijlstra wrote:
> On Wed, Nov 12, 2025 at 04:39:43PM +0530, Shrikanth Hegde wrote:
> >=20
> >=20
>=20
> > > So perhaps this is the better option -- or did I overlook something w=
ith
> > > should_we_balance? It doesn't look like that will make a different
> > > decision on the retry.
> > >=20
> >=20
> > I think in newidle balance, these checks are there in swb to bail of lo=
ad balance.
> > redo logic catches it right?
>=20
> Urgh, my brain still thinks we're not serializing on newidle. Perhaps I
> should make this 2 patches, one moving the serializing and one adding it
> to newidle.
>=20
> > env->dst_rq lock is taken only in attach_tasks, meanwhile, if the wakeu=
p happened,
> > pending would be set. is irq enabled or remote CPU can set ttwu_pending=
 on this rq?
> >=20
> >         if (env->idle =3D=3D CPU_NEWLY_IDLE) {
> >                 if (env->dst_rq->nr_running > 0 || env->dst_rq->ttwu_pe=
nding)
> >                         return 0;
> >                 return 1;
> >         }
>=20
> Right, that could get tickled.

How about something like the following on top of v4 patch?
This will avoid releasing the lock and take care of the NEWLY_IDLE case.

Tim

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 43c5ec039633..26179f4b77f6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11772,14 +11772,13 @@ static int sched_balance_rq(int this_cpu, struct =
rq *this_rq,
 		.fbq_type	=3D all,
 		.tasks		=3D LIST_HEAD_INIT(env.tasks),
 	};
-	bool need_unlock;
+	bool need_unlock =3D false;
=20
 	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
=20
 	schedstat_inc(sd->lb_count[idle]);
=20
 redo:
-	need_unlock =3D false;
 	if (!should_we_balance(&env)) {
 		*continue_balancing =3D 0;
 		goto out_balanced;
@@ -11916,9 +11915,9 @@ static int sched_balance_rq(int this_cpu, struct rq=
 *this_rq,
 			if (!cpumask_subset(cpus, env.dst_grpmask)) {
 				env.loop =3D 0;
 				env.loop_break =3D SCHED_NR_MIGRATE_BREAK;
-				if (need_unlock)
-					atomic_set_release(&sched_balance_running, 0);
-
+				if (env->idle =3D=3D CPU_NEWLY_IDLE &&
+				    (env->dst_running > 0 || env->dst_rq->ttwu_pending))
+					goto out;
 				goto redo;
 			}
 			goto out_all_pinned;

