Return-Path: <linux-kernel+bounces-794646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FF3B3E4B5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B66D3BCB1B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7A3188715;
	Mon,  1 Sep 2025 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m7vDXEsz"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38C322770
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732963; cv=none; b=nhJQMTvPlGfBG0wJBJ4VZp0fH0+mO0IpzW/RK8+Y3JSu3Yc71eEabcWb1Ocrbt389ZfHK6jxx6V9pTdLJkWVgGGgToRAMopOTXO27Q+3reIYQVZtSI7u61zUSic0TrtFmwANW28navuZnRmFfdbxHRb2svaUqYWaWe62StIrc5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732963; c=relaxed/simple;
	bh=ZgV83PemYvMOUnPBY2KY43SW4oEVqhBYicQz5B9Pf8U=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=BE1zo5vz4Ei26mIR+v4ByNAEBJ2yhf0NvXn54DGgPZQVmrVeFgA0c5ShBx7u4eLyswUBwbk1YbotHRZCKsCrtvPSf6inUNveWb5aU+/SOdbJYevKEfFxEQ3u9YYKrLr3DQCG2nI3lAylZ0z4lt8RH2ikcouG8Y7etC7SqKL5wzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m7vDXEsz; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756732957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOklPgt+xkpdrDxi5HQwoZG4a5Ueu9Z+VfTUlLGqvlM=;
	b=m7vDXEszobLgulb8irCS5L5pNrsPTiSOZ9FwfpGUovK8EjtY8rF2teAnCZI5SmXbE1Xe52
	cBGeNfDioFFFXD8M45vncnWWx4JEYjLlY9E/m73XpY/vL2BL+5/6I++N3GYbCLMLhJ8QgF
	ccbIcXlIV9/+DuKBeZ0990bj68hmDQc=
Date: Mon, 01 Sep 2025 13:22:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Zqiang" <qiang.zhang@linux.dev>
Message-ID: <aa7893d53dd90beb54e869b3c9cd45be7155db00@linux.dev>
Disposition-Notification-To: qiang.zhang@linux.dev
X-Confirm-Reading-To: qiang.zhang@linux.dev
TLS-Required: No
Subject: Re: [paulmckrcu:dev.2025.08.21a] [rcu] 8bd9383727:
 WARNING:possible_circular_locking_dependency_detected
To: paulmck@kernel.org
Cc: "kernel test robot" <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, "Andrii Nakryiko" <andrii@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <711fe3bf-0ac2-4ae9-9dda-97ba047eb64f@paulmck-laptop>
References: <202508261642.b15eefbb-lkp@intel.com>
 <2853a174-76e4-440b-bfc1-71ea30694822@paulmck-laptop>
 <eb1e5ab00253fdae5ba5aa4c97d60a79d357dbfd@linux.dev>
 <f58f7c75-46be-4ddd-be70-ee4f6a3370a9@paulmck-laptop>
 <aefc893f1b7c17049c2e6eb2256a97739a5e328d@linux.dev>
 <8f43f958-e3e6-44d5-9600-9e096c3a06b7@paulmck-laptop>
 <547f1b1d1b8615a634b352a268928771bb50d0f9@linux.dev>
 <711fe3bf-0ac2-4ae9-9dda-97ba047eb64f@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Sun, Aug 31, 2025 at 11:52:40PM +0000, Zqiang wrote:
>=20
>=20>=20
>=20> On Sun, Aug 31, 2025 at 02:22:56AM +0000, Zqiang wrote:
> >=20=20
>=20>  >=20
>=20>  > On Sat, Aug 30, 2025 at 02:38:35AM +0000, Zqiang wrote:
> >  >=20
>=20>  > >=20
>=20>  > > On Tue, Aug 26, 2025 at 04:47:22PM +0800, kernel test robot wr=
ote:
> >  > >=20
>=20>  > > >=20
>=20>  > > > hi, Paul,
> >  > > >=20
>=20>  > > > the similar issue still exists on this dev.2025.08.21a branc=
h.
> >  > > > again, if the issue is already fixed on later branches, please=
 just ignore.
> >  > > > thanks
> >  > > >=20
>=20>  > > >=20
>=20>  > > > Hello,
> >  > > >=20
>=20>  > > > kernel test robot noticed "WARNING:possible_circular_locking=
_dependency_detected" on:
> >  > > >=20
>=20>  > > > commit: 8bd9383727068a5a18acfecefbdfa44a7d6bd838 ("rcu: Re-i=
mplement RCU Tasks Trace in terms of SRCU-fast")
> >  > > > https://github.com/paulmckrcu/linux dev.2025.08.21a
> >  > > >=20
>=20>  > > > in testcase: rcutorture
> >  > > > version:=20
>=20>  > > > with following parameters:
> >  > > >=20
>=20>  > > > runtime: 300s
> >  > > > test: default
> >  > > > torture_type: tasks-tracing
> >  > > >=20
>=20>  > > >=20
>=20>  > > >=20
>=20>  > > > config: x86_64-randconfig-003-20250824
> >  > > > compiler: clang-20
> >  > > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge =
-smp 2 -m 16G
> >  > > >=20
>=20>  > > > (please refer to attached dmesg/kmsg for entire log/backtrac=
e)
> >  > > >=20
>=20>  > > Again, apologies for being slow, and thank you for your testin=
g efforts.
> >  > >=20
>=20>  > > Idiot here forgot about Tiny SRCU, so please see the end of th=
is email
> >  > > for an alleged fix. Does it do the trick for you?
> >  > >=20
>=20>  > > Thanx, Paul
> >  > >=20
>=20>  > > >=20
>=20>  > > > If you fix the issue in a separate patch/commit (i.e. not ju=
st a new version of
> >  > > > the same patch/commit), kindly add following tags
> >  > > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> >  > > > | Closes: https://lore.kernel.org/oe-lkp/202508261642.b15eefbb=
-lkp@intel.com
> >  > > >=20
>=20>  > > >=20
>=20>  > > > [ 42.365933][ T393] WARNING: possible circular locking depen=
dency detected
> >  > > > [ 42.366428][ T393] 6.17.0-rc1-00035-g8bd938372706 #1 Tainted:=
 G T
> >  > > > [ 42.366985][ T393] ------------------------------------------=
------------
> >  > > > [ 42.367490][ T393] rcu_torture_rea/393 is trying to acquire l=
ock:
> >  > > > [ 42.367952][ T393] ffffffffad41dc88 (rcu_tasks_trace_srcu_str=
uct.srcu_wq.lock){....}-{2:2}, at: swake_up_one (kernel/sched/swait.c:52 =
(discriminator 1))=20
>=20>  > > > [ 42.368775][ T393]
> >  > > > [ 42.368775][ T393] but task is already holding lock:
> >  > > > [ 42.369278][ T393] ffff88813d1ff2e8 (&p->pi_lock){-.-.}-{2:2}=
, at: rcutorture_one_extend (kernel/rcu/rcutorture.c:?) rcutorture=20
>=20>  > > > [ 42.370043][ T393]
> >  > > > [ 42.370043][ T393] which lock already depends on the new lock=
.
> >  > > > [ 42.370043][ T393]
> >  > > > [ 42.370755][ T393]
> >  > > > [ 42.370755][ T393] the existing dependency chain (in reverse =
order) is:
> >  > > > [ 42.371388][ T393]
> >  > > > [ 42.371388][ T393] -> #1 (&p->pi_lock){-.-.}-{2:2}:
> >  > > > [ 42.371903][ T393] _raw_spin_lock_irqsave (include/linux/spin=
lock_api_smp.h:110 kernel/locking/spinlock.c:162)=20
>=20>  > > > [ 42.372309][ T393] try_to_wake_up (include/linux/spinlock.h=
:557 (discriminator 1) kernel/sched/core.c:4216 (discriminator 1))=20
>=20>  > > > [ 42.372669][ T393] swake_up_locked (include/linux/list.h:11=
1)=20
>=20>  > > > [ 42.373029][ T393] swake_up_one (kernel/sched/swait.c:54 (d=
iscriminator 1))=20
>=20>  > > > [ 42.373380][ T393] tasks_tracing_torture_read_unlock (inclu=
de/linux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (=
discriminator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutortu=
re=20
>=20>  > > > [ 42.373952][ T393] rcutorture_one_extend (kernel/rcu/rcutor=
ture.c:2141) rcutorture=20
>=20>  > > > [ 42.374452][ T393] rcu_torture_one_read_end (kernel/rcu/rcu=
torture.c:2357) rcutorture=20
>=20>  > > > [ 42.374976][ T393] rcu_torture_one_read (kernel/rcu/rcutort=
ure.c:?) rcutorture=20
>=20>  > > > [ 42.375460][ T393] rcu_torture_reader (kernel/rcu/rcutortur=
e.c:2443) rcutorture=20
>=20>  > > > [ 42.375920][ T393] kthread (kernel/kthread.c:465)=20
>=20>  > > > [ 42.376241][ T393] ret_from_fork (arch/x86/kernel/process.c=
:154)=20
>=20>  > > > [ 42.376603][ T393] ret_from_fork_asm (arch/x86/entry/entry_=
64.S:255)=20
>=20>  > > > [ 42.376973][ T393]
> >  > > > [ 42.376973][ T393] -> #0 (rcu_tasks_trace_srcu_struct.srcu_wq=
.lock){....}-{2:2}:
> >  > > > [ 42.377657][ T393] __lock_acquire (kernel/locking/lockdep.c:3=
166)=20
>=20>  > > > [ 42.378031][ T393] lock_acquire (kernel/locking/lockdep.c:5=
868)=20
>=20>  > > > [ 42.378378][ T393] _raw_spin_lock_irqsave (include/linux/sp=
inlock_api_smp.h:110 kernel/locking/spinlock.c:162)=20
>=20>  > > > [ 42.378794][ T393] swake_up_one (kernel/sched/swait.c:52 (d=
iscriminator 1))=20
>=20>  > > > [ 42.379152][ T393] tasks_tracing_torture_read_unlock (inclu=
de/linux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (=
discriminator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutortu=
re=20
>=20>  > > > [ 42.379714][ T393] rcutorture_one_extend (kernel/rcu/rcutor=
ture.c:2141) rcutorture=20
>=20>  > > > [ 42.380217][ T393] rcu_torture_one_read_end (kernel/rcu/rcu=
torture.c:2357) rcutorture=20
>=20>  > > > [ 42.380731][ T393] rcu_torture_one_read (kernel/rcu/rcutort=
ure.c:?) rcutorture=20
>=20>  > > > [ 42.381220][ T393] rcu_torture_reader (kernel/rcu/rcutortur=
e.c:2443) rcutorture=20
>=20>  > > > [ 42.381714][ T393] kthread (kernel/kthread.c:465)=20
>=20>  > > > [ 42.382060][ T393] ret_from_fork (arch/x86/kernel/process.c=
:154)=20
>=20>  > > > [ 42.382420][ T393] ret_from_fork_asm (arch/x86/entry/entry_=
64.S:255)=20
>=20>  > > > [ 42.382796][ T393]
> >  > > > [ 42.382796][ T393] other info that might help us debug this:
> >  > > > [ 42.382796][ T393]
> >  > > > [ 42.383515][ T393] Possible unsafe locking scenario:
> >  > > > [ 42.383515][ T393]
> >  > > > [ 42.384052][ T393] CPU0 CPU1
> >  > > > [ 42.384428][ T393] ---- ----
> >  > > > [ 42.384799][ T393] lock(&p->pi_lock);
> >  > > > [ 42.385083][ T393] lock(rcu_tasks_trace_srcu_struct.srcu_wq.l=
ock);
> >  > > > [ 42.385707][ T393] lock(&p->pi_lock);
> >  > > > [ 42.386180][ T393] lock(rcu_tasks_trace_srcu_struct.srcu_wq.l=
ock);
> >  > > > [ 42.386663][ T393]
> >  > > > [ 42.386663][ T393] *** DEADLOCK ***
> >  > > > [ 42.386663][ T393]
> >  > > > [ 42.387236][ T393] 1 lock held by rcu_torture_rea/393:
> >  > > > [ 42.387626][ T393] #0: ffff88813d1ff2e8 (&p->pi_lock){-.-.}-{=
2:2}, at: rcutorture_one_extend (kernel/rcu/rcutorture.c:?) rcutorture=20
>=20>  > > > [ 42.388419][ T393]
> >  > > > [ 42.388419][ T393] stack backtrace:
> >  > > > [ 42.388852][ T393] CPU: 0 UID: 0 PID: 393 Comm: rcu_torture_r=
ea Tainted: G T 6.17.0-rc1-00035-g8bd938372706 #1 PREEMPT(full)
> >  > > > [ 42.389758][ T393] Tainted: [T]=3DRANDSTRUCT
> >  > > > [ 42.390057][ T393] Hardware name: QEMU Standard PC (i440FX + =
PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> >  > > > [ 42.390786][ T393] Call Trace:
> >  > > > [ 42.391020][ T393] <TASK>
> >  > > > [ 42.391225][ T393] dump_stack_lvl (lib/dump_stack.c:123 (disc=
riminator 2))=20
>=20>  > > > [ 42.391544][ T393] print_circular_bug (kernel/locking/lockd=
ep.c:2045)=20
>=20>  > > > [ 42.391898][ T393] check_noncircular (kernel/locking/lockde=
p.c:?)=20
>=20>  > > > [ 42.392242][ T393] __lock_acquire (kernel/locking/lockdep.c=
:3166)=20
>=20>  > > > [ 42.392594][ T393] ? __schedule (kernel/sched/sched.h:1531 =
(discriminator 1) kernel/sched/core.c:6969 (discriminator 1))=20
>=20>  > > > [ 42.392930][ T393] ? lock_release (kernel/locking/lockdep.c=
:470 (discriminator 3))=20
>=20>  > > > [ 42.393272][ T393] ? swake_up_one (kernel/sched/swait.c:52 =
(discriminator 1))=20
>=20>  > > > [ 42.393610][ T393] lock_acquire (kernel/locking/lockdep.c:5=
868)=20
>=20>  > > > [ 42.393930][ T393] ? swake_up_one (kernel/sched/swait.c:52 =
(discriminator 1))=20
>=20>  > > > [ 42.394264][ T393] _raw_spin_lock_irqsave (include/linux/sp=
inlock_api_smp.h:110 kernel/locking/spinlock.c:162)=20
>=20>  > > > [ 42.394640][ T393] ? swake_up_one (kernel/sched/swait.c:52 =
(discriminator 1))=20
>=20>  >=20> > [ 42.394969][ T393] swake_up_one (kernel/sched/swait.c:52 =
(discriminator 1))=20
>=20>  > > > [ 42.395281][ T393] tasks_tracing_torture_read_unlock (inclu=
de/linux/srcu.h:408 (discriminator 1) include/linux/rcupdate_trace.h:81 (=
discriminator 1) kernel/rcu/rcutorture.c:1112 (discriminator 1)) rcutortu=
re=20
>=20>  > > > [ 42.395814][ T393] rcutorture_one_extend (kernel/rcu/rcutor=
ture.c:2141) rcutorture=20
>=20>  > > > [ 42.396276][ T393] rcu_torture_one_read_end (kernel/rcu/rcu=
torture.c:2357) rcutorture=20
>=20>  > > > [ 42.396756][ T393] rcu_torture_one_read (kernel/rcu/rcutort=
ure.c:?) rcutorture=20
>=20>  > > > [ 42.397219][ T393] ? __cfi_rcu_torture_reader (kernel/rcu/r=
cutorture.c:2426) rcutorture=20
>=20>  > > > [ 42.397690][ T393] rcu_torture_reader (kernel/rcu/rcutortur=
e.c:2443) rcutorture=20
>=20>  > > > [ 42.398126][ T393] ? __cfi_rcu_torture_timer (kernel/rcu/rc=
utorture.c:2405) rcutorture=20
>=20>  > > > [ 42.398565][ T393] kthread (kernel/kthread.c:465)=20
>=20>  > > > [ 42.398857][ T393] ? __cfi_kthread (kernel/kthread.c:412)=
=20
>=20>  > > > [ 42.399169][ T393] ret_from_fork (arch/x86/kernel/process.c=
:154)=20
>=20>  > > > [ 42.399491][ T393] ? __cfi_kthread (kernel/kthread.c:412)=
=20
>=20>  > > > [ 42.399815][ T393] ret_from_fork_asm (arch/x86/entry/entry_=
64.S:255)=20
>=20>  > > > [ 42.400151][ T393] </TASK>
> >  > > >=20
>=20>  > > >=20
>=20>  > > > The kernel config and materials to reproduce are available a=
t:
> >  > > > https://download.01.org/0day-ci/archive/20250826/202508261642.=
b15eefbb-lkp@intel.com
> >  > > >=20
>=20>  > > >=20
>=20>  > > >=20
>=20>  > > > --=20
>=20>  > > > 0-DAY CI Kernel Test Service
> >  > > > https://github.com/intel/lkp-tests/wiki
> >  > > >=20
>=20>  > > --------------------------------------------------------------=
----------
> >  > >=20
>=20>  > > diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> >  > > index 6e9fe2ce1075d5..db63378f062051 100644
> >  > > --- a/kernel/rcu/srcutiny.c
> >  > > +++ b/kernel/rcu/srcutiny.c
> >  > > @@ -106,7 +106,7 @@ void __srcu_read_unlock(struct srcu_struct *=
ssp, int idx)
> >  > > newval =3D READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
> >  > > WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
> >  > > preempt_enable();
> >  > > - if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task())
> >  > > + if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task() &&=
 !irqs_disabled())
> >  > >=20
>=20>  > >=20
>=20>  > > The fllowing case may exist:
> >  > >=20
>=20>  > >=20
>=20>  > > CPU0
> >  > >=20
>=20>  > > task1:
> >  > > __srcu_read_lock()
> >  > >=20
>=20>  > For mainline kernels, here we must have blocked, correct?
> >  >=20
>=20>  > In -rcu, there is of course:
> >  >=20
>=20>  > 740cda2fe1a9 ("EXP srcu: Enable Tiny SRCU On all CONFIG_SMP=3Dn =
kernels")
> >  >=20
>=20>  > And this means that in -rcu kernels built with CONFIG_PREEMPT_NO=
NE=3Dy,
> >  > we could be preempted.
> >  >=20
>=20>  > And maybe this is a reason to drop this commit. Or...
> >  >=20
>=20>  >=20
>=20>  > For tiny srcu, even if the preempt schedule not happend in
> >  > srcu read ctrical section, we can still do voluntary
> >  > scheduling in srcu_read ctrical section, this case is
> >  > also still happend.
> >  >=20
>=20>  > >=20
>=20>  > > ....
> >  > >=20
>=20>  > >=20
>=20>  > > task2 preempt run:
> >  > >=20
>=20>  > > srcu_drive_gp()
> >  > > ->swait_event_exclusive()
> >  > >=20
>=20>  > >=20
>=20>  > > ....
> >  > > task1 continue run:
> >  > > ....
> >  > > raw_spin_lock_irqsave
> >  > > __srcu_read_unlock()
> >  > > ->find all previours condition are met
> >  > > but the irqs_disable() return true,
> >  > > not invoke swake_up_one().
> >  > >=20
>=20>  > > task2 maybe always hung.
> >  > >=20
>=20>  > The bug that kernel test robot reported existed for a long time.
> >  > The offending commit simply introduced the use case that exercised
> >  > this bug. So we do need a fix.
> >  >=20
>=20>  > One approach would be to impose a rule like we used to have for =
RCU,
> >  > namely that if interrupts were disabled across srcu_read_unlock(),
> >  > then they must have been disabled since the matching srcu_read_loc=
k().
> >  > Another would be to make the current swait_event_exclusive() in
> >  > srcu_drive_gp() instead be a loop around wait_event_timeout_exclus=
ive()
> >  > that checks ssp->srcu_lock_nesting[].
> >  >=20
>=20>  > But is there a better way?
> >  >=20
>=20>  > I think the second approach is enough :)
> >  >=20
>=20>  Hmmm... OK, how about the incremental patch below?
> >=20=20
>=20>  Thanx, Paul
> >=20=20
>=20>  ------------------------------------------------------------------=
------
> >=20=20
>=20>  commit a543d73eeaa491021040a02bdf0e8a9148b5c186
> >  Author: Paul E. McKenney <paulmck@kernel.org>
> >  Date: Sun Aug 31 09:38:44 2025 -0700
> >=20=20
>=20>  squash! rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast
> >=20=20
>=20>  [ paulmck: Apply Zqiang feedback. ]
> >=20=20
>=20>  Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >=20=20
>=20>  Should the previous fix that added irqs_disabled() also be
> >  added to this patch? or can we use preemptible() instead of
> >  in_tasks() && irqs_disabled()?
> >=20
>=20Yes, both this fix and the addition of the !irqw_disabled() check
> are to be squashed into the original commit:
>=20
>=20f56bf5dd7ffc ("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fas=
t")
>=20
>=20But I do not immediately see how checking preemptible() would help,
> especially in (say) CONFIG_PREEMPT_NONE=3Dy kernels in which this funct=
ion
> always returns zero. What am I missing here?

You are right, I miss CONFIG_PREEMPT_NONE=3Dy kernels is always return ze=
ro.

Thanks
Zqiang

>=20
>=20 Thanx, Paul
>=20
>=20>=20
>=20> Thanks
> >  Zqiang
> >=20=20
>=20>=20=20
>=20>=20=20
>=20>  diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> >  index db63378f062051..b52ec45698e85b 100644
> >  --- a/kernel/rcu/srcutiny.c
> >  +++ b/kernel/rcu/srcutiny.c
> >  @@ -113,8 +113,8 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
> >=20=20
>=20>  /*
> >  * Workqueue handler to drive one grace period and invoke any callbac=
ks
> >  - * that become ready as a result. Single-CPU and !PREEMPTION operat=
ion
> >  - * means that we get away with murder on synchronization. ;-)
> >  + * that become ready as a result. Single-CPU operation and preempti=
on
> >  + * disabling mean that we get away with murder on synchronization. =
;-)
> >  */
> >  void srcu_drive_gp(struct work_struct *wp)
> >  {
> >  @@ -141,7 +141,12 @@ void srcu_drive_gp(struct work_struct *wp)
> >  WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
> >  WRITE_ONCE(ssp->srcu_gp_waiting, true); /* srcu_read_unlock() wakes!=
 */
> >  preempt_enable();
> >  - swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nest=
ing[idx]));
> >  + do {
> >  + // Deadlock issues prevent __srcu_read_unlock() from
> >  + // doing an unconditional wakeup, so polling is required.
> >  + swait_event_timeout_exclusive(ssp->srcu_wq,
> >  + !READ_ONCE(ssp->srcu_lock_nesting[idx]), HZ / 10);
> >  + } while (READ_ONCE(ssp->srcu_lock_nesting[idx]));
> >  preempt_disable(); // Needed for PREEMPT_LAZY
> >  WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap=
. */
> >  WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
> >
>

