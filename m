Return-Path: <linux-kernel+bounces-835624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C6BA7A12
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 02:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A010D1893148
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 00:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C9E1A239A;
	Mon, 29 Sep 2025 00:42:35 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A833D8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759106555; cv=none; b=S5U97++9UeVk1rUW3mtYKWjEiiMr8ePVU/HSi6qux5E7SproJMu0dMJn+meVh6VFZVqVS7mmffZb/qO74MR/sfUAdOS7QM/3XXDvXezeCPHnaz9nlghQpm7nSMKEDVlsH+NAoI+SrsN6OXHSs9Wch7CSACjRLnKWFBBgw+xP3WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759106555; c=relaxed/simple;
	bh=RYxybwhNDgm6M7oi3KdEGlfEHCdXh/YqRrZaP9GbCxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d58K0v7gKzIZJdsbZGHpPc/LmxpbIC+BBHkG7nwopZukgjd3OLm/Ru3Gj312ujTqJlb8kvkW0DFdCArSiHI2Wec90MwbRlJafZjqqeo1IHLne2dIUE+Hb0bHDnCxSwoyyd4i0T5prtjvovwFdSdpn7PTJr5wpy5vOG4ElFGlOBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Oleg Nesterov <oleg@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "David
 Howells" <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Waiman Long <longman@redhat.com>, Will Deacon
	<will@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [????] [RFC 2/1] seqlock: make the read_seqbegin_or_lock() API
 more simple and less error-prone ?
Thread-Topic: [????] [RFC 2/1] seqlock: make the read_seqbegin_or_lock() API
 more simple and less error-prone ?
Thread-Index: AQHcMJQYZWumUK1TbEeXu704+RTQIbSpTiww
Date: Mon, 29 Sep 2025 00:41:15 +0000
Message-ID: <8edee550f50647218787cac1016de97a@baidu.com>
References: <20250928161953.GA3112@redhat.com>
 <20250928162054.GB3121@redhat.com>
In-Reply-To: <20250928162054.GB3121@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
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
X-FEAS-Client-IP: 172.31.3.13
X-FE-Policy-ID: 52:10:53:SYSTEM



> Another problem is that this API is error prone. Two years ago half of th=
e
> read_seqbegin_or_lock() users were buggy (they followed the wrong example
> from Documentation/locking/seqlock.rst). And even if the code is mostly
> correct it is very easy to add a hard-to-detect mistake, see for example
>=20
> 	[PATCH][v3] afs: Remove erroneous seq |=3D 1 in volume lookup loop
> 	https://lore.kernel.org/all/20250910084235.2630-1-lirongqing@baidu.co
> m/
>=20
> Can we improve this API?
>=20
> -------------------------------------------------------------------------=
------
> To simplify, suppose we add the new helper
>=20
> 	static inline int need_seqretry_xxx(seqlock_t *lock, int *seq)
> 	{
> 		int ret =3D !(*seq & 1) && read_seqretry(lock, *seq);
>=20
> 		if (ret)
> 			++*seq;	/* make this counter odd */
>=20
> 		return ret;
> 	}
>=20
> which can be used instead of need_seqretry(). This way the users do not n=
eed
> to modify "seq" in the main loop. For example, we can simplify
> thread_group_cputime() as follows:
>=20
> 	--- a/kernel/sched/cputime.c
> 	+++ b/kernel/sched/cputime.c
> 	@@ -314,7 +314,7 @@ void thread_group_cputime(struct task_struct
> *tsk, struct task_cputime *times)
> 		struct signal_struct *sig =3D tsk->signal;
> 		u64 utime, stime;
> 		struct task_struct *t;
> 	-	unsigned int seq, nextseq;
> 	+	unsigned int seq;
> 		unsigned long flags;
>=20
> 		/*
> 	@@ -330,9 +330,8 @@ void thread_group_cputime(struct task_struct
> *tsk, struct task_cputime *times)
>=20
> 		rcu_read_lock();
> 		/* Attempt a lockless read on the first round. */
> 	-	nextseq =3D 0;
> 	+	seq =3D 0;
> 		do {
> 	-		seq =3D nextseq;
> 			flags =3D read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
> 			times->utime =3D sig->utime;
> 			times->stime =3D sig->stime;
> 	@@ -344,9 +343,7 @@ void thread_group_cputime(struct task_struct
> *tsk, struct task_cputime *times)
> 				times->stime +=3D stime;
> 				times->sum_exec_runtime +=3D read_sum_exec_runtime(t);
> 			}
> 	-		/* If lockless access failed, take the lock. */
> 	-		nextseq =3D 1;
> 	-	} while (need_seqretry(&sig->stats_lock, seq));
> 	+	} while (need_seqretry_xxx(&sig->stats_lock, &seq));
> 		done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
> 		rcu_read_unlock();
> 	 }
>=20

If this API can be simplified, it should prevent future errors;

I submitted a patch, inspired by inspired by your previous patch, and hope =
that all places use a fixed syntax, to prevent future errors;=20

https://lkml.org/lkml/2025/7/31/616

thanks

-Li

> most (if not all) of other users can be changed the same way.
>=20
> -------------------------------------------------------------------------=
------
> Or perhaps we can even add a helper that hides all the details, something=
 like
>=20
> 	int xxx(seqlock_t *lock, int *seq, int lockless)
> 	{
> 		if (lockless) {
> 			*seq =3D read_seqbegin(lock);
> 			return 1;
> 		}
>=20
> 		if (*seq & 1) {
> 			read_sequnlock_excl(lock);
> 			return 0;
> 		}
>=20
> 		if (read_seqretry(lock, *seq)) {
> 			read_seqlock_excl(lock);
> 			*seq =3D 1;
> 			return 1;
> 		}
>=20
> 		return 0;
>=20
> 	}
>=20
> 	#define __XXX(lock, seq, lockless)	\
> 		for (int lockless =3D 1, seq; xxx(lock, &seq, lockless); lockless =3D 0=
)
>=20
> 	#define XXX(lock)	\
> 		__XXX(lock, __UNIQUE_ID(seq), __UNIQUE_ID(lockless))
>=20
>=20
> ?
>=20
> This way the users can simply do:
>=20
> 	seqlock_t sl;
>=20
> 	void func(void)
> 	{
> 		XXX(&sl) {
> 			... read-side critical section ...
> 		}
> 	}
>=20
> using only the new XXX() helper. No need to declare/initialize seq, no ne=
ed for
> need_seqretry/done_seqretry.
>=20
> What do you think?
>=20
> Oleg.


