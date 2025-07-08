Return-Path: <linux-kernel+bounces-721606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B29AFCB92
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4228E1C20B2C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FCD2DFA3E;
	Tue,  8 Jul 2025 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2I+tFJTq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/IU70lHk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF52F2DF3F2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980182; cv=none; b=ji3xhZINnXU+al3rMzBz7Ep6BxKVTMJpYhHyorX8NpCtA3NJajkVqDnDpV3GSs7c5rtTxAAhaR6Me2BtyGh4NMX6mkDuOMwiu6aRcJDI31OyubGslZPIbg7ghyYJmVwXu0v+XJNFTaWcpcAH9uSEnP+FP6PG+Bn4a9NRaTHu1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980182; c=relaxed/simple;
	bh=ZC2kj2dH6J9HGW3ChdhdXDsA3/05TRGkB9XqPpYZHOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDhrbYQhebtpcNvcU62zvdHZVVZiL31Hn8V+sCbGuXLkh/C89DRoZZMUj93i2P0fu3hjH1FcspxSSxjDuXiyQiqVxnoD2F0T3aGNKAqxN+f4348Rpy9brzzMxb+FjQwzjo/1EKuXrkbX5bMBFOI1nzf3f58zokvG/q0PL5zmXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2I+tFJTq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/IU70lHk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Jul 2025 15:09:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751980172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gl9np3y9TcOZuvbO534nVVO6eiYPN+RPOsuMdHzACo=;
	b=2I+tFJTqvgachmqsi/MSDXJsfgKqAHTSHMUHyDVU5nIvWoOj9pNbteq/xo1PmsRSfOfKVs
	zzfj8oSSC/WqNq9VTa1PzkUTOgFh5hILoU/sC2FVNwb7inJCc9fvQTjJIKJfnPChILxbXm
	wpr5R8u2KpE/nK4p+CQiSjOTWn6IGR8fGrcmYovVNAkSrOPeTI75/RvIuYcACWc7WgA939
	fsl3RI1PJ3p4nc9N2mXEq7bnjkzvXifmMo8NptrrqHNnxgJG07AXWcYGcgn3+mKD2qcwDS
	caobJoNWV4yR87HT7pQWrjuV7lefOW78O4Bh5AvY7ehfKr5L5/9IMR+i3K+tyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751980172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gl9np3y9TcOZuvbO534nVVO6eiYPN+RPOsuMdHzACo=;
	b=/IU70lHk2yZQk1FwVOiLVqSw/imaS/Dzj3QguHoHLDcJUjrxgq/WSfDF2agAieJF4TMqE6
	yRtS85WjHj/Y52Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/3] futex: Use RCU-based per-CPU reference counting
 instead of rcuref_t
Message-ID: <20250708130930.k37I5UrI@linutronix.de>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
 <20250707143623.70325-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250707143623.70325-3-bigeasy@linutronix.de>

On 2025-07-07 16:36:22 [+0200], To linux-kernel@vger.kernel.org wrote:

so a box was doing innocent things and then this happened:

|  slab mm_struct start ffff888549a50580 pointer offset 280 size 1352
| BUG: kernel NULL pointer dereference, address: 0000000000000000
| #PF: supervisor instruction fetch in kernel mode
| #PF: error_code(0x0010) - not-present page
| PGD 0 P4D 0
| Oops: Oops: 0010 [#1] SMP
| CPU: 11 UID: 1001 PID: 125007 Comm: clang Not tainted 6.16.0-rc5+ #262 PR=
EEMPT(lazy)  3bf8bc6327fe388c2a27e778516b456f280aa854
| Hardware name: Intel Corporation S2600CP/S2600CP, BIOS SE5C600.86B.02.03.=
0003.041920141333 04/19/2014
| RIP: 0010:0x0
| Code: Unable to access opcode bytes at 0xffffffffffffffd6.
| RSP: 0000:ffffc90020317e60 EFLAGS: 00010282
| RAX: 0000000000000001 RBX: 0000000000000006 RCX: 0000000000000000
| RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888549a50698
| RBP: ffff888a3faeab00 R08: 0000000000000000 R09: ffffc90020317bc8
| R10: ffffffff8296bdc8 R11: 0000000000000003 R12: ffff8881b6f80000
| R13: ffffc90020317e98 R14: 0000000000000005 R15: 0000000000000000
| FS:  00007fd37b766c40(0000) GS:ffff888abc9ef000(0000) knlGS:0000000000000=
000
| CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
| CR2: ffffffffffffffd6 CR3: 00000005c3d5f001 CR4: 00000000000626f0
| Call Trace:
|  <TASK>
|  rcu_core+0x27c/0x720
|  ? rcu_core+0x21c/0x720
|  handle_softirqs+0xc5/0x260
|  irq_exit_rcu+0x85/0xa0
|  sysvec_apic_timer_interrupt+0x3d/0x90
|  asm_sysvec_apic_timer_interrupt+0x1a/0x20
| RIP: 0033:0x7fd3862e1190
| Code: 41 56 53 48 89 d3 49 89 f6 49 89 ff 48 c7 47 08 00 00 00 00 8b 47 1=
0 48 85 c0 74 52 49 8b 0f 48 c1 e0 04 31 d2 0f 1f 44 00 00 <48> c7 04 11 00=
 f0 ff ff 48 83 c2  10 48 39 d0 75 ef eb 31 4d 85 c9
| RSP: 002b:00007fff1e519aa0 EFLAGS: 00010202
| RAX: 0000000000040000 RBX: 00007fd37b71f010 RCX: 00007fd37b5c3010
| RDX: 000000000000fff0 RSI: 00007fd37b6ff010 RDI: 000055836a11e290
| RBP: 0000000000150050 R08: 00000000ffffffff R09: 0000000000000000
| R10: 0000000000000022 R11: 0000000000000246 R12: 000055836a597420
| R13: 000055836a593030 R14: 00007fd37b6ff010 R15: 000055836a11e290
|  </TASK>
| Modules linked in:
| Dumping ftrace buffer:
=E2=80=A6
| CR2: 0000000000000000
| ---[ end trace 0000000000000000 ]---
| RIP: 0010:0x0
| Code: Unable to access opcode bytes at 0xffffffffffffffd6.
| RSP: 0000:ffffc90020317e60 EFLAGS: 00010282
| RAX: 0000000000000001 RBX: 0000000000000006 RCX: 0000000000000000
| RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888549a50698

on the plus side there is no evidence that this could be futex related
:)

However, I was wondering could this be because nothing ensures that the
mm stays around after the RCU callback has been enqueued.

What about this:

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index b13474825130f..2201da0afecc5 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -140,7 +140,7 @@ static inline bool mmget_not_zero(struct mm_struct *mm)
=20
 /* mmput gets rid of the mappings and all user-space */
 extern void mmput(struct mm_struct *);
-#ifdef CONFIG_MMU
+#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH)
 /* same as above but performs the slow path from the async context. Can
  * be called from the atomic context as well
  */
diff --git a/kernel/fork.c b/kernel/fork.c
index 66c4d4cc2340b..0b885dcbde9af 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1149,7 +1149,7 @@ void mmput(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(mmput);
=20
-#ifdef CONFIG_MMU
+#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH)
 static void mmput_async_fn(struct work_struct *work)
 {
 	struct mm_struct *mm =3D container_of(work, struct mm_struct,
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index d1877abbb7147..cd8463f3d1026 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1602,6 +1602,7 @@ static void __futex_ref_atomic_end(struct futex_priva=
te_hash *fph)
 		wake_up_var(mm);
=20
 	WARN_ON_ONCE(ret < 0);
+	mmput_async(mm);
 }
=20
 static void futex_ref_rcu(struct rcu_head *head)
@@ -1637,6 +1638,11 @@ static void futex_ref_drop(struct futex_private_hash=
 *fph)
 	 * Can only transition the current fph;
 	 */
 	WARN_ON_ONCE(rcu_dereference_raw(mm->futex_phash) !=3D fph);
+	/*
+	 * We enqueue at least one RCU callback. Ensure mm stays if the task
+	 * exits before the transition is completed.
+	 */
+	mmget(mm);
=20
 	/*
 	 * In order to avoid the following scenario:
--=20
2.50.0

Sebastian

