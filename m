Return-Path: <linux-kernel+bounces-753504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79047B183CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C6B07B330E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB64248F5E;
	Fri,  1 Aug 2025 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="XxtH1UEt"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24A715530C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058720; cv=none; b=cgEWSWKyAmD1MfYR3RZvbAdI/WtpRiUWWkaGExdCFfj9nkT4KLtt9noHZromVg4X1iw77e2ill5z59jPLY7p64CzAjaj9F3PgCVpeLFJ9AmD2axzCVYYvrXwNtbnoWet37iZvHGigMGRJhgbYe/3J9ue9JfLI5bYsb+2di2iWkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058720; c=relaxed/simple;
	bh=f4zlQ8hjQSsz0piGRxtd/QDDlEAMpqSGYSxVj8a0vGo=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=f40Ber9/d4dEL+8XkfYvtDiyZ3QsGfY1FLAtVHeld0TQR1sf/W7BBfKUhiurbuOZTp8PmlU5oHgxaimZ6PeZNgGX4Stv+NP5isifAeUw+Nb0LeDG0nh7aR65uZ7K9+hf4O4mXZ9QN/qMV4/SgZReCQ4m/SeYRBdgM7/Rv+AIwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=XxtH1UEt; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:References:In-Reply-To:Cc:To:
	Subject:From:Message-ID:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Lw53zPIiHtdUdIYoXYqnASM0vfXFovxFpMdknuhaGvY=; b=XxtH1UEtmjS76834vhi3tuAyz7
	KWLp6jXisGjh81X8CbwdRk7O+/VYv9nuqI7xJE0d/u/vzu3uFI4iRbZN+7+9QqCs3njsk4zeqSp61
	/WpAAYT+Lxjl0aTRiaMlop/6eD0JMv9DV1wpYt6MqYsDlvXL3j2wzn3//7Ubr0x3gyh5z/2ZLnrjw
	oBH7MUvhByA6Ke3yIGBr4dU0fL1iQClQmA2zVwnm8RweKCpjHt6XyjNopDtBUUFdrdeCak+HT8WMG
	WMxRYUShcyapusUEIvAYu2w50OTfiK3AhLxnpJ5V9fhfXw1i4p6ayt7oETHhoaSohV9BDxOPB29fR
	rcmTbLPg==;
Received: from [95.75.6.188] (helo=localhost)
	by imap4.hz.codethink.co.uk with utf8esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1uhqn8-006DuM-6v; Fri, 01 Aug 2025 15:31:26 +0100
Date: Fri, 01 Aug 2025 16:31:25 +0200
Message-ID: <a3b3eefb208f06b0c55f889495376248@codethink.co.uk>
From: Matteo Martelli <matteo.martelli@codethink.co.uk>
Subject: Re: [PATCH v3 0/5] Defer throttle when task exits to user
To: Aaron Lu <ziqianlu@bytedance.com>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>,
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>, Matteo Martelli <matteo.martelli@codethink.co.uk>
In-Reply-To: <20250715071658.267-1-ziqianlu@bytedance.com>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
Sender: matteo.martelli@codethink.co.uk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Aaron,

On Tue, 15 Jul 2025 15:16:53 +0800, Aaron Lu <ziqianlu@bytedance.com> wrote:
> v3:
> - Keep throttled cfs_rq's PELT clock running as long as it still has
>   entity queued, suggested by Benjamin Segall. I've folded this change
>   into patch3;
> - Rebased on top of tip/sched/core, commit 2885daf47081
>   ("lib/smp_processor_id: Make migration check unconditional of SMP").
> 
> Hi Prateek,
> I've kept your tested-by tag(Thanks!) for v2 since I believe this pelt
> clock change should not affect things much, but let me know if you don't
> think that is appropriate.
> 
> Tests I've done:
> - Jan's rt deadlock reproducer[1]. Without this series, I saw rcu-stalls
>   within 2 minutes and with this series, I do not see rcu-stalls after
>   10 minutes.
> - A stress test that creates a lot of pressure on fork/exit path and
>   cgroup_threadgroup_rwsem. Without this series, the test will cause
>   task hung in about 5 minutes and with this series, no problem found
>   after several hours. Songtang wrote this test script and I've used it
>   to verify the patches, thanks Songtang.
> 
> [1]: https://lore.kernel.org/all/7483d3ae-5846-4067-b9f7-390a614ba408@siemens.com/
> 
> v2:
> - Re-org the patchset to use a single patch to implement throttle
>   related changes, suggested by Chengming;
> - Use check_cfs_rq_runtime()'s return value in pick_task_fair() to
>   decide if throttle task work is needed instead of checking
>   throttled_hierarchy(), suggested by Peter;
> - Simplify throttle_count check in tg_throtthe_down() and
>   tg_unthrottle_up(), suggested by Peter;
> - Add enqueue_throttled_task() to speed up enqueuing a throttled task to
>   a throttled cfs_rq, suggested by Peter;
> - Address the missing of detach_task_cfs_rq() for throttled tasks that
>   get migrated to a new rq, pointed out by Chengming;
> - Remove cond_resched_tasks_rcu_qs() in throttle_cfs_rq_work() as
>   cond_resched*() is going away, pointed out by Peter.
> I hope I didn't miss any comments and suggestions for v1 and if I do,
> please kindly let me know, thanks!
> 
> Base: tip/sched/core commit dabe1be4e84c("sched/smp: Use the SMP version
> of double_rq_clock_clear_update()")
> 
> cover letter of v1:
> 
> This is a continuous work based on Valentin Schneider's posting here:
> Subject: [RFC PATCH v3 00/10] sched/fair: Defer CFS throttle to user entry
> https://lore.kernel.org/lkml/20240711130004.2157737-1-vschneid@redhat.com/
> 
> Valentin has described the problem very well in the above link and I
> quote:
> "
> CFS tasks can end up throttled while holding locks that other,
> non-throttled tasks are blocking on.
> 
> For !PREEMPT_RT, this can be a source of latency due to the throttling
> causing a resource acquisition denial.
> 
> For PREEMPT_RT, this is worse and can lead to a deadlock:
> o A CFS task p0 gets throttled while holding read_lock(&lock)
> o A task p1 blocks on write_lock(&lock), making further readers enter
> the slowpath
> o A ktimers or ksoftirqd task blocks on read_lock(&lock)
> 
> If the cfs_bandwidth.period_timer to replenish p0's runtime is enqueued
> on the same CPU as one where ktimers/ksoftirqd is blocked on
> read_lock(&lock), this creates a circular dependency.
> 
> This has been observed to happen with:
> o fs/eventpoll.c::ep->lock
> o net/netlink/af_netlink.c::nl_table_lock (after hand-fixing the above)
> but can trigger with any rwlock that can be acquired in both process and
> softirq contexts.
> 
> The linux-rt tree has had
>   1ea50f9636f0 ("softirq: Use a dedicated thread for timer wakeups.")
> which helped this scenario for non-rwlock locks by ensuring the throttled
> task would get PI'd to FIFO1 (ktimers' default priority). Unfortunately,
> rwlocks cannot sanely do PI as they allow multiple readers.
> "
> 
> Jan Kiszka has posted an reproducer regarding this PREEMPT_RT problem :
> https://lore.kernel.org/r/7483d3ae-5846-4067-b9f7-390a614ba408@siemens.com/
> and K Prateek Nayak has an detailed analysis of how deadlock happened:
> https://lore.kernel.org/r/e65a32af-271b-4de6-937a-1a1049bbf511@amd.com/
> 
> To fix this issue for PREEMPT_RT and improve latency situation for
> !PREEMPT_RT, change the throttle model to task based, i.e. when a cfs_rq
> is throttled, mark its throttled status but do not remove it from cpu's
> rq. Instead, for tasks that belong to this cfs_rq, when they get picked,
> add a task work to them so that when they return to user, they can be
> dequeued. In this way, tasks throttled will not hold any kernel resources.
> When cfs_rq gets unthrottled, enqueue back those throttled tasks.
> 
> There are consequences because of this new throttle model, e.g. for a
> cfs_rq that has 3 tasks attached, when 2 tasks are throttled on their
> return2user path, one task still running in kernel mode, this cfs_rq is
> in a partial throttled state:
> - Should its pelt clock be frozen?
> - Should this state be accounted into throttled_time?
> 
> For pelt clock, I chose to keep the current behavior to freeze it on
> cfs_rq's throttle time. The assumption is that tasks running in kernel
> mode should not last too long, freezing the cfs_rq's pelt clock can keep
> its load and its corresponding sched_entity's weight. Hopefully, this can
> result in a stable situation for the remaining running tasks to quickly
> finish their jobs in kernel mode.
> 
> For throttle time accounting, according to RFC v2's feedback, rework
> throttle time accounting for a cfs_rq as follows:
> - start accounting when the first task gets throttled in its
>   hierarchy;
> - stop accounting on unthrottle.
> 
> There is also the concern of increased duration of (un)throttle operations
> in RFC v1. I've done some tests and with a 2000 cgroups/20K runnable tasks
> setup on a 2sockets/384cpus AMD server, the longest duration of
> distribute_cfs_runtime() is in the 2ms-4ms range. For details, please see:
> https://lore.kernel.org/lkml/20250324085822.GA732629@bytedance/
> For throttle path, with Chengming's suggestion to move "task work setup"
> from throttle time to pick time, it's not an issue anymore.
> 
> Aaron Lu (2):
>   sched/fair: Task based throttle time accounting
>   sched/fair: Get rid of throttled_lb_pair()
> 
> Valentin Schneider (3):
>   sched/fair: Add related data structure for task based throttle
>   sched/fair: Implement throttle task work and related helpers
>   sched/fair: Switch to task based throttle model
> 
>  include/linux/sched.h |   5 +
>  kernel/sched/core.c   |   3 +
>  kernel/sched/fair.c   | 451 ++++++++++++++++++++++++------------------
>  kernel/sched/pelt.h   |   4 +-
>  kernel/sched/sched.h  |   7 +-
>  5 files changed, 274 insertions(+), 196 deletions(-)
> 
> -- 
> 2.39.5
> 
> 

I encountered this issue on a test image with both PREEMPT_RT and
CFS_BANDWIDTH kernel options enabled. The test image is based on
freedesktop-sdk (v24.08.10) [1] with custom system configurations on
top, and it was being run on qemu x86_64 with 4 virtual CPU cores. One
notable system configuration is having most of system services running
on a systemd slice, restricted on a single CPU core (with AllowedCPUs
systemd option) and using CFS throttling (with CPUQuota systemd option).
With this configuration I encountered RCU stalls during boots, I think
because of the increased probability given by multiple processes being
spawned simultaneously on the same core. After the first RCU stall, the
system becomes unresponsive and successive RCU stalls are detected
periodically. This seems to match with the deadlock situation described
in your cover letter. I could only reproduce RCU stalls with the
combination of both PREEMPT_RT and CFS_BANDWIDTH enabled.

I previously already tested this patch set at v2 (RFC) [2] on top of
kernel v6.14 and v6.15. I've now retested it at v3 on top of kernel
v6.16-rc7. I could no longer reproduce RCU stalls in all cases with the
patch set applied. More specifically, in the last test I ran, without
patch set applied, I could reproduce 32 RCU stalls in 24 hours, about 1
or 2 every hour. In this test the system was rebooting just after the
first RCU stall occurrence (through panic_on_rcu_stall=1 and panic=5
kernel cmdline arguments) or after 100 seconds if no RCU stall occurred.
This means the system rebooted 854 times in 24 hours (about 3.7%
reproducibility). You can see below two RCU stall instances. I could not
reproduce any RCU stall with the same test after applying the patch set.
I obtained similar results while testing the patch set at v2 (RFC)[1].
Another possibly interesting note is that the original custom
configuration was with the slice CPUQuota=150%, then I retested it with
CPUQuota=80%. The issue was reproducible in both configurations, notably
even with CPUQuota=150% that to my understanding should correspond to no
CFS throttling due to the CPU affinity set to 1 core only.

I also ran some quick tests with stress-ng and systemd CPUQuota parameter to
verify that CFS throttling was behaving as expected. See details below after
RCU stall logs.

I hope this is helpful information and I can provide additional details if
needed.

Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>

[1]: https://gitlab.com/freedesktop-sdk/freedesktop-sdk/-/releases/freedesktop-sdk-24.08.10
[2]: https://lore.kernel.org/all/20250409120746.635476-1-ziqianlu@bytedance.com/


- RCU stall instances:

...
[   40.083057] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   40.083067] rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-3): P1075/4:b..l
[   40.083070] rcu:     (detected by 0, t=21002 jiffies, g=2637, q=547 ncpus=4)
[   40.083073] task:podman          state:R  running task     stack:13568 pid:1075  tgid:1062  ppid:1021   task_flags:0x40014c flags:0x00004002
[   40.083081] Call Trace:
[   40.083082]  <TASK>
[   40.083084]  __schedule+0x3d4/0xf10
[   40.083100]  preempt_schedule+0x2e/0x50
[   40.083102]  preempt_schedule_thunk+0x16/0x30
[   40.083107]  try_to_wake_up+0x2fc/0x630
[   40.083111]  ep_autoremove_wake_function+0xd/0x40
[   40.083115]  __wake_up_common+0x6d/0x90
[   40.083117]  __wake_up+0x2c/0x50
[   40.083119]  ep_poll_callback+0x17b/0x230
[   40.083121]  __wake_up_common+0x6d/0x90
[   40.083122]  __wake_up+0x2c/0x50
[   40.083123]  sock_def_wakeup+0x3a/0x40
[   40.083128]  unix_release_sock+0x2a7/0x4a0
[   40.083134]  unix_release+0x2d/0x40
[   40.083137]  __sock_release+0x44/0xb0
[   40.083141]  sock_close+0x13/0x20
[   40.083142]  __fput+0xe1/0x2a0
[   40.083146]  task_work_run+0x58/0x90
[   40.083149]  do_exit+0x270/0xac0
[   40.083152]  do_group_exit+0x2b/0xc0
[   40.083153]  __x64_sys_exit_group+0x13/0x20
[   40.083154]  x64_sys_call+0xfdb/0x14f0
[   40.083156]  do_syscall_64+0xa4/0x260
[   40.083160]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   40.083165] RIP: 0033:0x48638b
[   40.083167] RSP: 002b:000000c00004fde0 EFLAGS: 00000216 ORIG_RAX: 00000000000000e7
[   40.083169] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000048638b
[   40.083171] RDX: 000000c00004fdb0 RSI: 0000000000000001 RDI: 0000000000000000
[   40.083171] RBP: 000000c00004fdf0 R08: 4bad2e33de989e9a R09: 0000000002d79c40
[   40.083173] R10: 000000c0005eaa08 R11: 0000000000000216 R12: 0000000000000000
[   40.083173] R13: 0000000000000001 R14: 000000c0000061c0 R15: 000000c0000f27e0
[   40.083175]  </TASK>
[   40.083176] rcu: rcu_preempt kthread timer wakeup didn't happen for 20975 jiffies! g2637 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[   40.083179] rcu:     Possible timer handling issue on cpu=0 timer-softirq=1708
[   40.083180] rcu: rcu_preempt kthread starved for 20978 jiffies! g2637 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
[   40.083182] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[   40.083183] rcu: RCU grace-period kthread stack dump:
[   40.083183] task:rcu_preempt     state:I stack:14800 pid:17    tgid:17    ppid:2      task_flags:0x208040 flags:0x00004000
[   40.083187] Call Trace:
[   40.083188]  <TASK>
[   40.083189]  __schedule+0x3d4/0xf10
[   40.083192]  schedule+0x22/0xd0
[   40.083194]  schedule_timeout+0x7e/0x100
[   40.083199]  ? __pfx_process_timeout+0x10/0x10
[   40.083202]  rcu_gp_fqs_loop+0x103/0x6b0
[   40.083206]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   40.083207]  rcu_gp_kthread+0x191/0x230
[   40.083208]  kthread+0xf6/0x1f0
[   40.083210]  ? __pfx_kthread+0x10/0x10
[   40.083212]  ret_from_fork+0x80/0xd0
[   40.083215]  ? __pfx_kthread+0x10/0x10
[   40.083217]  ret_from_fork_asm+0x1a/0x30
[   40.083219]  </TASK>
[   40.083220] rcu: Stack dump where RCU GP kthread last ran:
[   40.083225] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-rc7 #1 PREEMPT_{RT,(full)}
[   40.083227] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
[   40.083227] RIP: 0010:pv_native_safe_halt+0xf/0x20
[   40.083229] Code: 76 79 00 e9 83 f5 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 35 68 21 00 fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
[   40.083230] RSP: 0018:ffffffff9a003e80 EFLAGS: 00000216
[   40.083231] RAX: ffff9034a1221000 RBX: ffffffff9a018900 RCX: 0000000000000001
[   40.083231] RDX: 4000000000000000 RSI: 0000000000000000 RDI: 000000000007507c
[   40.083232] RBP: 0000000000000000 R08: 000000000007507c R09: ffff90343bc24d90
[   40.083233] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   40.083233] R13: 0000000000000000 R14: ffffffff9a018038 R15: 000000007e0c1000
[   40.083237] FS:  0000000000000000(0000) GS:ffff9034a1221000(0000) knlGS:0000000000000000
[   40.083237] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.083238] CR2: 00007f72d6c58000 CR3: 0000000007722000 CR4: 00000000000006f0
[   40.083239] Call Trace:
[   40.083239]  <TASK>
[   40.083240]  default_idle+0x9/0x10
[   40.083241]  default_idle_call+0x2b/0x100
[   40.083243]  do_idle+0x1d0/0x230
[   40.083244]  cpu_startup_entry+0x24/0x30
[   40.083245]  rest_init+0xbc/0xc0
[   40.083247]  start_kernel+0x6ca/0x6d0
[   40.083252]  x86_64_start_reservations+0x24/0x30
[   40.083255]  x86_64_start_kernel+0xc5/0xd0
[   40.083256]  common_startup_64+0x13e/0x148
[   40.083258]  </TASK>
[   40.083260] Kernel panic - not syncing: RCU Stall
[   40.083261] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-rc7 #1 PREEMPT_{RT,(full)}
[   40.083263] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
[   40.083263] Call Trace:
[   40.083267]  <IRQ>
[   40.083268]  dump_stack_lvl+0x4d/0x70
[   40.083269]  panic+0x10a/0x2b9
[   40.083271]  ? try_to_wake_up+0x2f2/0x630
[   40.083273]  panic_on_rcu_stall.cold+0xc/0xc
[   40.083275]  rcu_sched_clock_irq.cold+0x15f/0x3db
[   40.083277]  ? __pfx_tick_nohz_handler+0x10/0x10
[   40.083279]  update_process_times+0x70/0xb0
[   40.083281]  tick_nohz_handler+0x8c/0x150
[   40.083284]  __hrtimer_run_queues+0x148/0x2e0
[   40.083292]  hrtimer_interrupt+0xf2/0x210
[   40.083294]  __sysvec_apic_timer_interrupt+0x53/0x100
[   40.083296]  sysvec_apic_timer_interrupt+0x66/0x80
[   40.083298]  </IRQ>
[   40.083298]  <TASK>
[   40.083299]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   40.083300] RIP: 0010:pv_native_safe_halt+0xf/0x20
[   40.083301] Code: 76 79 00 e9 83 f5 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 35 68 21 00 fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
[   40.083302] RSP: 0018:ffffffff9a003e80 EFLAGS: 00000216
[   40.083303] RAX: ffff9034a1221000 RBX: ffffffff9a018900 RCX: 0000000000000001
[   40.083303] RDX: 4000000000000000 RSI: 0000000000000000 RDI: 000000000007507c
[   40.083304] RBP: 0000000000000000 R08: 000000000007507c R09: ffff90343bc24d90
[   40.083304] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   40.083305] R13: 0000000000000000 R14: ffffffff9a018038 R15: 000000007e0c1000
[   40.083306]  default_idle+0x9/0x10
[   40.083307]  default_idle_call+0x2b/0x100
[   40.083309]  do_idle+0x1d0/0x230
[   40.083310]  cpu_startup_entry+0x24/0x30
[   40.083311]  rest_init+0xbc/0xc0
[   40.083312]  start_kernel+0x6ca/0x6d0
[   40.083313]  x86_64_start_reservations+0x24/0x30
[   40.083315]  x86_64_start_kernel+0xc5/0xd0
[   40.083316]  common_startup_64+0x13e/0x148
[   40.083317]  </TASK>
[   40.083440] Kernel Offset: 0x17600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
...

...
[   40.057080] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   40.057091] rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-3): P1035/4:b..l P981/4:b..l
[   40.057096] rcu:     (detected by 0, t=21002 jiffies, g=2965, q=707 ncpus=4)
[   40.057100] task:systemd         state:R  running task     stack:12856 pid:981   tgid:981   ppid:1      task_flags:0x400100 flags:0x0000
[   40.057109] Call Trace:
[   40.057110]  <TASK>
[   40.057114]  __schedule+0x3d4/0xf10
[   40.057132]  preempt_schedule+0x2e/0x50
[   40.057134]  preempt_schedule_thunk+0x16/0x30
[   40.057140]  try_to_wake_up+0x2fc/0x630
[   40.057145]  ep_autoremove_wake_function+0xd/0x40
[   40.057150]  __wake_up_common+0x6d/0x90
[   40.057152]  __wake_up_sync+0x33/0x50
[   40.057154]  ep_poll_callback+0xcd/0x230
[   40.057156]  __wake_up_common+0x6d/0x90
[   40.057158]  __wake_up_sync_key+0x3a/0x50
[   40.057160]  sock_def_readable+0x3d/0xb0
[   40.057166]  unix_dgram_sendmsg+0x454/0x800
[   40.057174]  ____sys_sendmsg+0x317/0x350
[   40.057179]  ___sys_sendmsg+0x94/0xe0
[   40.057182]  __sys_sendmsg+0x85/0xe0
[   40.057187]  do_syscall_64+0xa4/0x260
[   40.057192]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   40.057197] RIP: 0033:0x7f356c320d94
[   40.057198] RSP: 002b:00007ffc4a68a438 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[   40.057200] RAX: ffffffffffffffda RBX: 000000000000001f RCX: 00007f356c320d94
[   40.057202] RDX: 0000000000004000 RSI: 00007ffc4a68a490 RDI: 000000000000001f
[   40.057203] RBP: 00007ffc4a68a620 R08: 0000000000000080 R09: 0000000000000007
[   40.057204] R10: 00007ffc4a68a3f4 R11: 0000000000000202 R12: 0000000000000000
[   40.057205] R13: 00007ffc4a68a490 R14: 0000000000000000 R15: 0000000000000002
[   40.057207]  </TASK>
[   40.057207] task:(sd-close)      state:D stack:14576 pid:1035  tgid:1035  ppid:1      task_flags:0x40004c flags:0x00004002
[   40.057211] Call Trace:
[   40.057212]  <TASK>
[   40.057212]  __schedule+0x3d4/0xf10
[   40.057215]  schedule_rtlock+0x15/0x30
[   40.057218]  rtlock_slowlock_locked+0x314/0xea0
[   40.057224]  rt_spin_lock+0x79/0xd0
[   40.057226]  __wake_up+0x1a/0x50
[   40.057227]  ep_poll_callback+0x17b/0x230
[   40.057230]  __wake_up_common+0x6d/0x90
[   40.057232]  __wake_up+0x2c/0x50
[   40.057233]  __send_signal_locked+0x417/0x430
[   40.057237]  ? rt_spin_unlock+0x12/0x40
[   40.057239]  ? rt_spin_lock+0x33/0xd0
[   40.057242]  do_notify_parent+0x24a/0x2a0
[   40.057244]  do_exit+0x7cc/0xac0
[   40.057247]  __x64_sys_exit+0x16/0x20
[   40.057249]  x64_sys_call+0xfe9/0x14f0
[   40.057251]  do_syscall_64+0xa4/0x260
[   40.057253]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   40.057254] RIP: 0033:0x7fb2358f97de
[   40.057255] RSP: 002b:00007fffd71b3000 EFLAGS: 00000246 ORIG_RAX: 000000000000003c
[   40.057257] RAX: ffffffffffffffda RBX: 00007fb235adb6e0 RCX: 00007fb2358f97de
[   40.057258] RDX: 000055a50e51881b RSI: 00007fb235d70293 RDI: 0000000000000000
[   40.057259] RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000007
[   40.057260] R10: 00007fb2358f97c6 R11: 0000000000000246 R12: 0000000000000019
[   40.057261] R13: 0000000000000411 R14: 000000000000003d R15: 000055a05454c3a0
[   40.057263]  </TASK>
[   40.057264] rcu: rcu_preempt kthread timer wakeup didn't happen for 20963 jiffies! g2965 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[   40.057266] rcu:     Possible timer handling issue on cpu=0 timer-softirq=1618
[   40.057267] rcu: rcu_preempt kthread starved for 20966 jiffies! g2965 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
[   40.057269] rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[   40.057269] rcu: RCU grace-period kthread stack dump:
[   40.057270] task:rcu_preempt     state:I stack:14800 pid:17    tgid:17    ppid:2      task_flags:0x208040 flags:0x00004000
[   40.057274] Call Trace:
[   40.057274]  <TASK>
[   40.057275]  __schedule+0x3d4/0xf10
[   40.057278]  schedule+0x22/0xd0
[   40.057280]  schedule_timeout+0x7e/0x100
[   40.057282]  ? __pfx_process_timeout+0x10/0x10
[   40.057285]  rcu_gp_fqs_loop+0x103/0x6b0
[   40.057291]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   40.057292]  rcu_gp_kthread+0x191/0x230
[   40.057294]  kthread+0xf6/0x1f0
[   40.057296]  ? __pfx_kthread+0x10/0x10
[   40.057298]  ret_from_fork+0x80/0xd0
[   40.057303]  ? __pfx_kthread+0x10/0x10
[   40.057305]  ret_from_fork_asm+0x1a/0x30
[   40.057308]  </TASK>
[   40.057308] rcu: Stack dump where RCU GP kthread last ran:
[   40.057314] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-rc7 #1 PREEMPT_{RT,(full)}
[   40.057316] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
[   40.057317] RIP: 0010:pv_native_safe_halt+0xf/0x20
[   40.057319] Code: 76 79 00 e9 83 f5 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 35 68 21 00 fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
[   40.057321] RSP: 0018:ffffffff97a03e80 EFLAGS: 00000212
[   40.057322] RAX: ffff9269a3821000 RBX: ffffffff97a18900 RCX: 0000000000000001
[   40.057323] RDX: 4000000000000000 RSI: 0000000000000000 RDI: 00000000000759bc
[   40.057324] RBP: 0000000000000000 R08: 00000000000759bc R09: ffff92693bc24d90
[   40.057325] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   40.057326] R13: 0000000000000000 R14: ffffffff97a18038 R15: 000000007e0c1000
[   40.057330] FS:  0000000000000000(0000) GS:ffff9269a3821000(0000) knlGS:0000000000000000
[   40.057331] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.057332] CR2: 00007f0546942030 CR3: 000000000746c000 CR4: 00000000000006f0
[   40.057333] Call Trace:
[   40.057334]  <TASK>
[   40.057334]  default_idle+0x9/0x10
[   40.057336]  default_idle_call+0x2b/0x100
[   40.057338]  do_idle+0x1d0/0x230
[   40.057341]  cpu_startup_entry+0x24/0x30
[   40.057342]  rest_init+0xbc/0xc0
[   40.057344]  start_kernel+0x6ca/0x6d0
[   40.057350]  x86_64_start_reservations+0x24/0x30
[   40.057354]  x86_64_start_kernel+0xc5/0xd0
[   40.057355]  common_startup_64+0x13e/0x148
[   40.057358]  </TASK>
[   40.057361] Kernel panic - not syncing: RCU Stall
[   40.057362] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.16.0-rc7 #1 PREEMPT_{RT,(full)}
[   40.057364] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
[   40.057364] Call Trace:
[   40.057369]  <IRQ>
[   40.057370]  dump_stack_lvl+0x4d/0x70
[   40.057372]  panic+0x10a/0x2b9
[   40.057375]  ? try_to_wake_up+0x2f2/0x630
[   40.057377]  panic_on_rcu_stall.cold+0xc/0xc
[   40.057379]  rcu_sched_clock_irq.cold+0x15f/0x3db
[   40.057383]  ? __pfx_tick_nohz_handler+0x10/0x10
[   40.057385]  update_process_times+0x70/0xb0
[   40.057387]  tick_nohz_handler+0x8c/0x150
[   40.057391]  __hrtimer_run_queues+0x148/0x2e0
[   40.057394]  hrtimer_interrupt+0xf2/0x210
[   40.057397]  __sysvec_apic_timer_interrupt+0x53/0x100
[   40.057400]  sysvec_apic_timer_interrupt+0x66/0x80
[   40.057402]  </IRQ>
[   40.057403]  <TASK>
[   40.057403]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   40.057405] RIP: 0010:pv_native_safe_halt+0xf/0x20
[   40.057407] Code: 76 79 00 e9 83 f5 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 35 68 21 00 fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
[   40.057408] RSP: 0018:ffffffff97a03e80 EFLAGS: 00000212
[   40.057409] RAX: ffff9269a3821000 RBX: ffffffff97a18900 RCX: 0000000000000001
[   40.057410] RDX: 4000000000000000 RSI: 0000000000000000 RDI: 00000000000759bc
[   40.057411] RBP: 0000000000000000 R08: 00000000000759bc R09: ffff92693bc24d90
[   40.057412] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   40.057413] R13: 0000000000000000 R14: ffffffff97a18038 R15: 000000007e0c1000
[   40.057415]  default_idle+0x9/0x10
[   40.057417]  default_idle_call+0x2b/0x100
[   40.057419]  do_idle+0x1d0/0x230
[   40.057420]  cpu_startup_entry+0x24/0x30
[   40.057422]  rest_init+0xbc/0xc0
[   40.057424]  start_kernel+0x6ca/0x6d0
[   40.057426]  x86_64_start_reservations+0x24/0x30
[   40.057428]  x86_64_start_kernel+0xc5/0xd0
[   40.057429]  common_startup_64+0x13e/0x148
[   40.057432]  </TASK>
[   40.057586] Kernel Offset: 0x15000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
...


- Tested stress-ng with 1 worker process with group CPU limit set to 20%.
stress-ng metrics showed 20% CPU usage for the worker process and top showed
20% CPU usage increase for CPU 0, where the worker process was running.

[root@localhost ~]# systemd-run -p CPUQuota=20% stress-ng --cpu 1 --timeout 10s --metrics
Running as unit: run-rb98f1ee55a4e4c9dacb29774213a399c.service; invocation ID: 77c93909960347e09e916fac907f87c6
[root@localhost ~]# journalctl -f -u run-rb98f1ee55a4e4c9dacb29774213a399c.service
Jul 28 16:19:31 localhost stress-ng[1310]: stress-ng: metrc: [1310] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
Jul 28 16:19:31 localhost stress-ng[1310]: stress-ng: metrc: [1310]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
Jul 28 16:19:31 localhost stress-ng[1310]: stress-ng: metrc: [1310] cpu                3181     10.02      2.01      0.01       317.50        1581.53        20.08          7504
Jul 28 16:19:31 localhost stress-ng[1310]: stress-ng: info:  [1310] skipped: 0
Jul 28 16:19:31 localhost stress-ng[1310]: stress-ng: info:  [1310] passed: 1: cpu (1)
Jul 28 16:19:31 localhost stress-ng[1310]: stress-ng: info:  [1310] failed: 0
Jul 28 16:19:31 localhost stress-ng[1310]: stress-ng: info:  [1310] metrics untrustworthy: 0
Jul 28 16:19:31 localhost stress-ng[1310]: stress-ng: info:  [1310] successful run completed in 10.02 secs
Jul 28 16:19:31 localhost systemd[1]: run-rb98f1ee55a4e4c9dacb29774213a399c.service: Deactivated successfully.
Jul 28 16:19:31 localhost systemd[1]: run-rb98f1ee55a4e4c9dacb29774213a399c.service: Consumed 2.026s CPU time.


- Tested stress-ng with 2 worker processes with group CPU limit set to 20%.
Both processes ran on the same CPU core due to the systemd slice CPU affinity
settings (AllowedCPUs=0). stress-ng metrics showed 10% CPU usage per worker
process and top showed 20% usage increase for CPU 0, where both worker
processes were running.

[root@localhost ~]# systemd-run -p CPUQuota=20% stress-ng --cpu 2 --timeout 10s --metrics
Running as unit: run-rd616594713434ac9bb346faa92f7110a.service; invocation ID: f45acc85d19944cbbdf633f0c95091bb
[root@localhost ~]# journalctl -f -u run-rd616594713434ac9bb346faa92f7110a.service
Jul 28 16:24:08 localhost stress-ng[1373]: stress-ng: metrc: [1373] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
Jul 28 16:24:08 localhost stress-ng[1373]: stress-ng: metrc: [1373]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
Jul 28 16:24:08 localhost stress-ng[1373]: stress-ng: metrc: [1373] cpu                3275     10.06      2.00      0.01       325.53        1630.74         9.98          7476
Jul 28 16:24:08 localhost stress-ng[1373]: stress-ng: info:  [1373] skipped: 0
Jul 28 16:24:08 localhost stress-ng[1373]: stress-ng: info:  [1373] passed: 2: cpu (2)
Jul 28 16:24:08 localhost stress-ng[1373]: stress-ng: info:  [1373] failed: 0
Jul 28 16:24:08 localhost stress-ng[1373]: stress-ng: info:  [1373] metrics untrustworthy: 0
Jul 28 16:24:08 localhost stress-ng[1373]: stress-ng: info:  [1373] successful run completed in 10.06 secs
Jul 28 16:24:08 localhost systemd[1]: run-rd616594713434ac9bb346faa92f7110a.service: Deactivated successfully.
Jul 28 16:24:08 localhost systemd[1]: run-rd616594713434ac9bb346faa92f7110a.service: Consumed 2.023s CPU time.


- Tested stress-ng with 3 worker processes with group CPU limit set to 60%.
This time without CPU affinity settings, so each process ran on a different CPU
core. stress-ng metrics showed 20% CPU usage per worker process and top showed
20% usage increase per each CPU.

[root@localhost ~]# systemd-run -p CPUQuota=60% stress-ng --cpu 3 --timeout 10s --metrics
Running as unit: run-r19417007568a4c55a02817588bd2b32f.service; invocation ID: c09e104a497c4fdfb467c6744bf3923b
[root@localhost ~]# journalctl -f -u run-r19417007568a4c55a02817588bd2b32f.service
Jul 28 16:55:46 localhost stress-ng[1386]: stress-ng: metrc: [1386] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
Jul 28 16:55:46 localhost stress-ng[1386]: stress-ng: metrc: [1386]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
Jul 28 16:55:46 localhost stress-ng[1386]: stress-ng: metrc: [1386] cpu                1974     10.08      6.04      0.01       195.93         326.04        20.03          6856
Jul 28 16:55:46 localhost stress-ng[1386]: stress-ng: info:  [1386] skipped: 0
Jul 28 16:55:46 localhost stress-ng[1386]: stress-ng: info:  [1386] passed: 3: cpu (3)
Jul 28 16:55:46 localhost stress-ng[1386]: stress-ng: info:  [1386] failed: 0
Jul 28 16:55:46 localhost stress-ng[1386]: stress-ng: info:  [1386] metrics untrustworthy: 0
Jul 28 16:55:46 localhost stress-ng[1386]: stress-ng: info:  [1386] successful run completed in 10.08 secs
Jul 28 16:55:46 localhost systemd[1]: run-r19417007568a4c55a02817588bd2b32f.service: Deactivated successfully.
Jul 28 16:55:46 localhost systemd[1]: run-r19417007568a4c55a02817588bd2b32f.service: Consumed 6.096s CPU time.


- Tested stress-ng with 4 worker processes with group CPU limit set to 40%.
Also this time without CPU affinity settings, so each process ran on a
different CPU core. stress-ng metrics showed 10% CPU usage per worker process
and top showed 10% usage increase per each CPU.

[root@localhost ~]# systemd-run -p CPUQuota=40% stress-ng --cpu 4 --timeout 10s --metrics
Running as unit: run-r70a53f5333b948029f9739e80454648d.service; invocation ID: be510cc4c4e74676a9749c1758e65226
[root@localhost ~]# journalctl -f -u run-r70a53f5333b948029f9739e80454648d.service
Jul 28 16:58:33 localhost systemd[1]: Started /usr/bin/stress-ng --cpu 4 --timeout 10s --metrics.
Jul 28 16:58:33 localhost stress-ng[1420]: invoked with '/usr/bin/stress-ng --cpu 4 --timeout 10s --metrics' by user 0 'root'
Jul 28 16:58:33 localhost stress-ng[1420]: system: 'localhost' Linux 6.16.0-rc7-00005-g3113c41a2959 #1 SMP PREEMPT_RT Wed Jul 23 18:00:56 CEST 2025 x86_64
Jul 28 16:58:33 localhost stress-ng[1420]: stress-ng: info:  [1420] setting to a 10 secs run per stressor
Jul 28 16:58:33 localhost stress-ng[1420]: memory (MB): total 1973.16, free 1749.38, shared 10.99, buffer 7.56, swap 0.00, free swap 0.00
Jul 28 16:58:33 localhost stress-ng[1420]: stress-ng: info:  [1420] dispatching hogs: 4 cpu
Jul 28 16:58:43 localhost stress-ng[1420]: stress-ng: metrc: [1420] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
Jul 28 16:58:43 localhost stress-ng[1420]: stress-ng: metrc: [1420]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
Jul 28 16:58:43 localhost stress-ng[1420]: stress-ng: metrc: [1420] cpu                1062     10.08      4.01      0.02       105.41         263.63        10.00          7276
Jul 28 16:58:43 localhost stress-ng[1420]: stress-ng: info:  [1420] skipped: 0
Jul 28 16:58:43 localhost stress-ng[1420]: stress-ng: info:  [1420] passed: 4: cpu (4)
Jul 28 16:58:43 localhost stress-ng[1420]: stress-ng: info:  [1420] failed: 0
Jul 28 16:58:43 localhost stress-ng[1420]: stress-ng: info:  [1420] metrics untrustworthy: 0
Jul 28 16:58:43 localhost stress-ng[1420]: stress-ng: info:  [1420] successful run completed in 10.08 secs
Jul 28 16:58:43 localhost systemd[1]: run-r70a53f5333b948029f9739e80454648d.service: Deactivated successfully.
Jul 28 16:58:43 localhost systemd[1]: run-r70a53f5333b948029f9739e80454648d.service: Consumed 4.047s CPU time.


- Tested stress-ng with 4 worker processes with group CPU limit set to 200%.
Also this time without CPU affinity settings, so each process ran on a
different CPU core. stress-ng metrics showed 50% CPU usage per worker process
and top showed 50% usage increase per each CPU.

[root@localhost ~]# systemd-run -p CPUQuota=200% stress-ng --cpu 4 --timeout 10s --metrics
Running as unit: run-r887083cd168e4b3fa07672b09c3bb72d.service; invocation ID: 224b6544b79e449db43b42455700fddd
[root@localhost ~]# journalctl -f -u run-r887083cd168e4b3fa07672b09c3bb72d.service
Jul 28 17:03:44 localhost systemd[1]: Started /usr/bin/stress-ng --cpu 4 --timeout 10s --metrics.
Jul 28 17:03:44 localhost stress-ng[1169]: invoked with '/usr/bin/stress-ng --cpu 4 --timeout 10s --metrics' by user 0 'root'
Jul 28 17:03:44 localhost stress-ng[1169]: system: 'localhost' Linux 6.16.0-rc7-00005-g3113c41a2959 #1 SMP PREEMPT_RT Wed Jul 23 18:00:56 CEST 2025 x86_64
Jul 28 17:03:44 localhost stress-ng[1169]: stress-ng: info:  [1169] setting to a 10 secs run per stressor
Jul 28 17:03:44 localhost stress-ng[1169]: memory (MB): total 1973.15, free 1722.16, shared 10.26, buffer 7.33, swap 0.00, free swap 0.00
Jul 28 17:03:44 localhost stress-ng[1169]: stress-ng: info:  [1169] dispatching hogs: 4 cpu
Jul 28 17:03:54 localhost stress-ng[1169]: stress-ng: metrc: [1169] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
Jul 28 17:03:54 localhost stress-ng[1169]: stress-ng: metrc: [1169]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
Jul 28 17:03:54 localhost stress-ng[1169]: stress-ng: metrc: [1169] cpu               21605     10.00     20.11      0.01      2160.25        1073.95        50.29          7424
Jul 28 17:03:54 localhost stress-ng[1169]: stress-ng: info:  [1169] skipped: 0
Jul 28 17:03:54 localhost stress-ng[1169]: stress-ng: info:  [1169] passed: 4: cpu (4)
Jul 28 17:03:54 localhost stress-ng[1169]: stress-ng: info:  [1169] failed: 0
Jul 28 17:03:54 localhost stress-ng[1169]: stress-ng: info:  [1169] metrics untrustworthy: 0
Jul 28 17:03:54 localhost stress-ng[1169]: stress-ng: info:  [1169] successful run completed in 10.00 secs
Jul 28 17:03:54 localhost systemd[1]: run-r887083cd168e4b3fa07672b09c3bb72d.service: Deactivated successfully.
Jul 28 17:03:54 localhost systemd[1]: run-r887083cd168e4b3fa07672b09c3bb72d.service: Consumed 20.133s CPU time.

Best regards,
Matteo Martelli


