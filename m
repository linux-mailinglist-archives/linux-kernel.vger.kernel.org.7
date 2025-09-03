Return-Path: <linux-kernel+bounces-798630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE981B42089
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567A4568543
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF9A2DCF78;
	Wed,  3 Sep 2025 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WGnbauOn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qdO/Xuid"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EBF2DEA71
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904838; cv=none; b=oN/HAprkkDEelm4hGpiJE1hs8eRZZkf7A6pUUQ8/b36po3jugvfy4CvKoCs5zcbJBttGASNzHTCxx4MComQL60y1xlOqKQTfh9kqo28YOo0ktBynhSE5pACAZBeS7eDl8+HGnADkwVvg1PdFmrj1ZWJ0H2DqW6+T/JaCyvC3Hz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904838; c=relaxed/simple;
	bh=MYbuolDC1cod6wE+09Bi+MhATrTdJ8q230g4dktRmt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNu8p3T93ozUtnRXnPa7rOZhEAttQTqcu2VvAvaQnECQYuDt+t5b3OcN7JK3sKnYoh0lQ2fEzBoisHfL/0sfi91fgwzlIMul/i0Xu5lY3bHJNS9diU/1vqzgBm/QzT0QcJRK0m+GueLd49xRGlxLAtUFpsaSWbNZRtKZPQAZUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WGnbauOn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qdO/Xuid; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 3 Sep 2025 15:07:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756904835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQinZod56c/fhPQe+BST6CxoA0rPRgZGI75m7pAgRDA=;
	b=WGnbauOnwGxoBvzQxBJu+amPK6zGHrmKpxwbmXWWuzDtLBS/EujsfZlvzixJ2593e8xLJP
	LhHw43fb2wFY8+5EjtQzMx1UOeOMPbN87W15c4oG7SwX1YJO/qWLTcH2nUiIdVDW974aze
	DO4DxBs7uFusBo1sZ9fJ/7AEzRSz/uP/Kj5av9JDdVnt/zeps6mse3r1pl9XVosWXH+SxT
	2hc1sGH/H2vvGTFmGfUXw4lcTKsOTJLvnyUZZLM+nUGMzhqdOFmkLrY/HUpUu7lVE69P4m
	uyn0Ygd+Wx9Bd/rPH7IL/jzlgA7MCLmY2L/LYuZxNQApAU+KFHo94sJAoUC6UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756904835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQinZod56c/fhPQe+BST6CxoA0rPRgZGI75m7pAgRDA=;
	b=qdO/Xuid05Yb0WJN+0MygqF5Zjku8OTCYolYNXSC2OJx0Zbfd2Z/ZoSAFRR+eXPw4PNXwf
	ubrmWFvkREskK3BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: syzbot <syzbot+034246a838a10d181e78@syzkaller.appspotmail.com>,
	andrealmeid@igalia.com, dave@stgolabs.net, dvhart@infradead.org,
	linux-kernel@vger.kernel.org, mingo@redhat.com,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [kernel?] general protection fault in try_to_wake_up (3)
Message-ID: <20250903130712.br0G6lOq@linutronix.de>
References: <68b75989.050a0220.3db4df.01dd.GAE@google.com>
 <20250902214628.GL4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250902214628.GL4067720@noisy.programming.kicks-ass.net>

+Jens

On 2025-09-02 23:46:28 [+0200], Peter Zijlstra wrote:
> When I build the provided .config with clang-20, that a58 offset is
> exactly task_struct::pi_lock::lockdep_map, which nicely corresponds with
> the below stacktrace, and seems to suggest someone did:
> try_to_wake_up(NULL).

correct.

> >  try_to_wake_up+0x67/0x12b0 kernel/sched/core.c:4216
> >  requeue_pi_wake_futex+0x24b/0x2f0 kernel/futex/requeue.c:249
>=20
> Trouble is, we've not changed the requeue bits in a fair while... So I'm
> somewhat confused on how this happens now ?!

This means syzkaller managed to invoke futex_wait_setup(=E2=80=A6, NULL) in
order to get futex_q::task assigned to NULL. All users use current
except for io_futex_wait().

The syz-reproducer lists only:
| timer_create(0x0, &(0x7f0000000080)=3D{0x0, 0x11, 0x0, @thr=3D{0x0, 0x0}}=
, &(0x7f0000000000))
| timer_settime(0x0, 0x0, &(0x7f0000000240)=3D{{0x0, 0x8}, {0x0, 0x9}}, 0x0)
| futex(&(0x7f000000cffc), 0x80000000000b, 0x0, 0x0, &(0x7f0000048000), 0x0)
| futex(&(0x7f000000cffc), 0xc, 0x1, 0x0, &(0x7f0000048000), 0x0)

and that is probably why it can't come up with C-reproducer.
The whole log has (filtered) the following lines:

| io_uring_setup(0x85a, &(0x7f0000000180)=3D{0x0, 0x58b9, 0x1, 0x2, 0x383})
| syz_io_uring_setup(0x88f, &(0x7f0000000300)=3D{0x0, 0xaedf, 0x0, 0x0, 0x2=
5d}, &(0x7f0000000140)=3D<r0=3D>0x0, &(0x7f0000000280)=3D<r1=3D>0x0)
| syz_memcpy_off$IO_URING_METADATA_GENERIC(r0, 0x4, &(0x7f0000000080)=3D0xf=
ffffffc, 0x0, 0x4)
| syz_io_uring_submit(r0, r1, &(0x7f00000001c0)=3D@IORING_OP_RECVMSG=3D{0xa=
, 0x8, 0x1, r2, 0x0, &(0x7f0000000440)=3D{0x0, 0x0, 0x0}, 0x0, 0x40000020, =
0x1, {0x2}})

This should explain the how the waiter got NULL. There is no private
flag so that is how they interact with each other.
Do we want this:

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index c716a66f86929..0c98256ebdcb7 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -312,6 +312,8 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct =
futex_hash_bucket *hb1,
 	if (!top_waiter->rt_waiter || top_waiter->pi_state)
 		return -EINVAL;
=20
+	if (!top_waiter->task)
+		-EINVAL;
 	/* Ensure we requeue to the expected futex. */
 	if (!futex_match(top_waiter->requeue_pi_key, key2))
 		return -EINVAL;

?

Sebastian

