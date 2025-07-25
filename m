Return-Path: <linux-kernel+bounces-745125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B27B5B11548
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC421C88672
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E8E13DB9F;
	Fri, 25 Jul 2025 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="sAekm3Uu"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6921C11CA9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403627; cv=none; b=W9WB5qrAyVidobjuvgnXDbCrhG8SCTwaDM8/qX9oJV18+VMzqLyVbl7R5fAbFdLw0GnfvBL3na3UG0MdUl6v9jCMN665qa1TD2j5bj0Ws6bJUZAF8iCYKHFM6ozcbMP3D7B5LERP3WUUL7eqeIykcg4RlTPQl/byvJ/4oyLxowc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403627; c=relaxed/simple;
	bh=a4c0ApW2bPLbyHss53ttFqHvo+PwQKpSfkHH57UnTdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPTpH/AL5BcbN8hIchnDAnuZsAR6x4Ygra+CC56SP84LCeEffgeJU9VHStIF7ZHSITOTNs6guYG8OaCNAC5m2JhE98OISPnIbGoyQg1OE22PQo5g62v6iIXLOAg6g+YAGt2INEVrfhP3uI+eYBnlLVKEirrFVsIlNCvLvWrtosg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=sAekm3Uu; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753403619;
	bh=5Ug6dk5Xc/ipr1LXVa486BlbyujKBDK5QEx7KJ1leng=;
	h=From:Subject:Date:Message-ID;
	b=sAekm3UuYdSruIXsmq91QJoG6c25xYueFzPgyQDQmBkclHNj/jxpIu9/U/irjW9LV
	 6k5R2qlkXQ/29zMssGTcugCun/PwK0NAWp46zyrLMJl8kQz5J4ggw4l9quadlKDle4
	 JA2QntlgQ9nErMRhl+khtHJ990rKgMwuaPSp8EzE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 6882D0D50000575B; Fri, 25 Jul 2025 08:33:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3135934456920
X-SMAIL-UIID: 9FE19377F2654EB2A20B8F5FBD5B758F-20250725-083327-1
From: Hillf Danton <hdanton@sina.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	LKML <linux-kernel@vger.kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <jogness@linutronix.de>,
	Tejun Heo <tj@kernel.org>
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too often on thinkpad X220
Date: Fri, 25 Jul 2025 08:33:14 +0800
Message-ID: <20250725003315.3163-1-hdanton@sina.com>
In-Reply-To: <877bzxqo39.ffs@tglx>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz> <aIEC4t2EICdgomZV@duo.ucw.cz> <874iv2stk3.ffs@tglx> <87zfcurexx.ffs@tglx> <aIJqC/0ZPhgaNdkf@duo.ucw.cz> <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com> <dd50a074-0988-4a4d-a78f-7862e87dbab0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 24 Jul 2025 23:24:26 +0200 Thomas Gleixner wrote:
>On Thu, Jul 24 2025 at 13:55, Waiman Long wrote:
>> On 7/24/25 1:51 PM, Waiman Long wrote:
>>>> [   54.284095] ================================
>>>> [   54.284097] WARNING: inconsistent lock state
>>>> [   54.284100] 6.16.0-rc7+ #305 Tainted: G S
>>>> [   54.284104] --------------------------------
>>>> [   54.284105] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
>>>> [   54.284108] wpa_supplicant/2940 [HC0[0]:SC0[0]:HE0:SE1] takes:
>>>> [   54.284114] ffffffff86263fe0 (console_owner){+.?.}-{0:0}, at: 
>>>> console_lock_spinning_enable+0x3d/0x60
>>>
>>> The lockdep warning just means that console_owner_lock is acquired 
>>> both in softirq context and in task context with interrupt enabled. 
>>> That can leads to deadlock. So the remedy is to always take 
>>> console_owner_lock with interrupt disabled, i.e. with 
>>> raw_spin_lock_irqsave/raw_spin_lock_irqrestore.
>>
>> I suppose that this lock can also be acquired in hardirq context. So a 
>> similar HARDIRQ warning can be printed if that happens first.
>
> None of this makes any sense whatsoever.
> 
> Both invocations of console_lock_spinning_enable() are within a hard
> interrupt disabled section.
> 
> 		printk_safe_enter_irqsave(flags);
> 		console_lock_spinning_enable();
> 
> The lockdep map which is printed here is not console_owner_lock,
> it's console_owner, which is a software managed lockdep_map:
> 
> static struct lockdep_map console_owner_dep_map = {
> 	.name = "console_owner"
> };
> 
> It's touched in console_lock_spinning_enable(),
> console_lock_spinning_disable_and_check() and console_trylock_spinning().
> 
> In all cases with interrupts disabled and all sites use
> printk_safe_enter_irqsave() which internally uses local_irq_save().
> 
> Now lets go back to the initial report, which is further down:
> 
> [   54.285777] raw_local_irq_restore() called with IRQs enabled
> [   54.285788] WARNING: CPU: 3 PID: 2940 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x25/0x30
> [   54.285801] Modules linked in:
> [   54.285807] CPU: 3 UID: 0 PID: 2940 Comm: wpa_supplicant Tainted: G S                  6.16.0-rc7+ #305 PREEMPT(voluntary) 
> [   54.285814] Tainted: [S]=CPU_OUT_OF_SPEC
> [   54.285817] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.43 ) 10/12/2016
> [   54.285820] RIP: 0010:warn_bogus_irq_restore+0x25/0x30
> [   54.285828] Code: 90 90 90 90 90 80 3d c2 5f e3 00 00 74 05 c3 cc cc cc cc 55 48 c7 c7 98 2f fa 85 c6 05 ac 5f e3 00 01 48 89 e5 e8 db 23 be fe <0f> 0b
> 5d c3 cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90
> [   54.285834] RSP: 0018:ffffc90001acb690 EFLAGS: 00010282
> [   54.285839] RAX: 0000000000000000 RBX: ffffffff863ed460 RCX: 0000000000000000
> [   54.285843] RDX: 0000000000000003 RSI: 0000000000000027 RDI: 00000000ffffffff
> [   54.285847] RBP: ffffc90001acb690 R08: 0000000000000000 R09: 0000000000000000
> [   54.285850] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> [   54.285853] R13: ffffc90001acb72b R14: 0000000000000200 R15: 0000000000000000
> [   54.285857] FS:  00007f79e08da1c0(0000) GS:ffff88828fcf5000(0000) knlGS:0000000000000000
> [   54.285862] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   54.285865] CR2: 000055b73b455000 CR3: 000000010b07e005 CR4: 00000000000606b0
> [   54.285869] Call Trace:
> [   54.285872]  <TASK>
> [   54.285874]  console_flush_all+0x47d/0x4d0
> [   54.285880]  ? console_flush_all+0x43/0x4d0
> [   54.285885]  ? console_flush_all+0x2d2/0x4d0
> [   54.285892]  console_unlock+0x55/0x100
> [   54.285924]  ieee80211_mgd_auth+0x2a3/0x5e0
> [   54.285934]  ? __this_cpu_preempt_check+0x13/0x20
> [   54.285940]  ieee80211_auth+0x13/0x20
> 
> I asked for decoding that console_flush_all+0x47d/0x4d0 line, but I'm
> 100% sure now that it is line 3128 in console_emit_next_record() which
> is inlined into console_flush_all()
> 
>      printk_safe_exit_irqrestore(flags);
> 
> Pavel, can you confirm that?
> 
> But let's look at the other stack trace in the lockdep splat which is
> way more interesting:
> 
> 	       stack backtrace:
> [   54.284433] CPU: 3 UID: 0 PID: 2940 Comm: wpa_supplicant Tainted: G S                  6.16.0-rc7+ #305 PREEMPT(voluntary) 
> [   54.284441] Tainted: [S]=CPU_OUT_OF_SPEC
> [   54.284443] Hardware name: LENOVO 4291W3B/4291W3B, BIOS 8DET73WW (1.43 ) 10/12/2016
> [   54.284446] Call Trace:
> [   54.284448]  <TASK>
> [   54.284450]  dump_stack_lvl+0x88/0xd0
> [   54.284458]  dump_stack+0x10/0x20
> [   54.284463]  print_usage_bug.part.0+0x237/0x2d0
> [   54.284470]  mark_lock.part.0+0xa9c/0xfb0
> [   54.284479]  mark_held_locks+0x4d/0x80
> [   54.284486]  lockdep_hardirqs_on_prepare+0xff/0x1c0
> [   54.284493]  trace_hardirqs_on+0x5a/0xe0
> [   54.284500]  _raw_spin_unlock_irq+0x23/0x60
> [   54.284505]  __flush_work+0x3b4/0x550
> [   54.284513]  ? __timer_delete+0x2f/0xd0
> [   54.284519]  ? timer_delete+0xb/0x20
> [   54.284524]  ? try_to_grab_pending+0x12a/0x320
> [   54.284534]  cancel_delayed_work_sync+0x65/0x70
> [   54.284539]  fbcon_cursor+0xbe/0x160
> [   54.284548]  hide_cursor+0x2c/0xc0
> [   54.284553]  vt_console_print+0x45e/0x470
> [   54.284560]  console_flush_all+0x301/0x4d0
> [   54.284565]  ? console_flush_all+0x2d2/0x4d0
> [   54.284569]  ? console_flush_all+0x43/0x4d0
> [   54.284572]  ? console_flush_all+0x2d2/0x4d0
> [   54.284579]  console_unlock+0x55/0x100
> [   54.284584]  vprintk_emit+0x15b/0x3a0
> [   54.284590]  vprintk_default+0x18/0x20
> [   54.284595]  vprintk+0x9/0x10
> [   54.284600]  _printk+0x52/0x70
> [   54.284608]  ieee80211_mgd_auth+0x2a3/0x5e0
> [   54.284619]  ? __this_cpu_preempt_check+0x13/0x20
> [   54.284625]  ieee80211_auth+0x13/0x20
> 
> That's the same call chain as the above which complains about the
> already enabled interrupt.
> 
> So the lockdep splat is telling us that the raw_spin_unlock_irq() in the
> workqueue code is making console_owner unsafe.
> 
Point A

> Now let's look where this comes from:
> 
>         console_flush_all+0x301/0x4d0
> 
> invokes
> 
>         vt_console_print+0x45e/0x470
> 
> via
> 
>         console_emit_next_record()
>         ...
>            printk_safe_enter_irqsave(flags);
>            ...
>            con->write(con, outbuf, pmsg.outbuf_len);
> 
> Again decoding console_flush_all+0x301/0x4d0 should confirm that.
> 
> Now that ends up in cancel_delayed_work_sync() via hide_cursor() ->
> fbcon_cursor().
> 
> cancel_delayed_work_sync() has a might_sleep() in it _and_
> __flush_work() uses raw_spin_[un]lock_irq() as it requires to be invoked
> in thread or in some cases in BH context.
> 
> vt_console_print() is the write() callback of the VT console driver. As
> that is a legacy console, it can't do that.
> 
> Only the new NBCON variants are allowed to sleep in their write()
> callbacks because they are running in their own printer thread
> context. For atomic printouts in case of emergency they can have a
> write_atomic() callback. If they don't then printing is not attempted,
> but that's not relevant for vt_console_print() obviously.
> 
> So lets look at that call chain further
> 
>    vt_console_print()
>      hide_cursor()
>       vc->vc_sw->con_cursor(vc, false); --> fbcon_cursor()
> 
>       fbcon_cursor()
>         if (vc->vc_cursor_type & CUR_SW)
>            fbcon_del_cursor_work(info)
>              cancel_delayed_work_sync(&ops->cursor_work);
> 
    cancel_delayed_work_sync(&ops->cursor_work);
      __cancel_work_sync()
	__cancel_work()
	  local_irq_save()
	  ...
	  local_irq_restore() // Point B
	__flush_work()
	  start_flush_work()
	    raw_spin_lock_irq(&pool->lock);
	    ...
	    raw_spin_unlock_irq(&pool->lock); // Point C

The difference between Point B and C wrt irq creates Point A.

> Here we are.
> 
> Now I checked whether this is a recent change, but I have to say it has
> been that way for a long time. It's a very interesting question why this
> never popped up before.
> 
> The only explanation I have so far is that the code path in
> cancel_delayed_work_sync() which uses [un]lock_irq() is only reached,
> when the works is executed at that point.
> 
> Unfortunatly the might_sleep() check in __cancel_work_sync() is after
> the point which determines that.
> 
> So it's a matter of debug options being enabled and the probability of
> hitting a work which is actually executed to trip over this problem.
> 
No, debug makes no sense. Nor does a running work.

> I have no fix for that, but at least there should be some clues now
> where to tackle this.
> 
Yes

> It's definitely not a printk bug. The culprit was hiding in plain sight
> for a long time in the fbcon_console code.
> 
Nope because of Point A.

Hillf

> Thanks,
> 
>         tglx

