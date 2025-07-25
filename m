Return-Path: <linux-kernel+bounces-745769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A43B11E4E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39ABB542C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC79210F4A;
	Fri, 25 Jul 2025 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="cLuxiEH1"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3691C6BE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445789; cv=none; b=UhHkmhrlkX4MWaUmlVm5CFoUbCR0BhBWbKi9wX/kye0XIk6ITCPMdqknudMLbblfeGSiPf5zrirf9phYfuUlrE+J7Fc8ilJ+N3w/VJBzWVpXtulGRWo339JKhGmDrGKFSGNYUJy80sxIe8V76sW4QG9L70hcGpdtid3mS/cQtoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445789; c=relaxed/simple;
	bh=BXC7y4ffioGnSpHQ+JRiU7/RE5dK67drmC/V7amArFA=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=iPoy1D8B0h5m3uTkAYovLD1ftjjUHf0tWRt3AwYoPNZ5y3EIYAbpEEDtQExsRfZErEJohg7DXFCvVZx6dyjhJJFx2/Vty7k9POURpGOj08NvZGkzKhP+HW9eZzio18KCcdu1VwQ8m7PbJ0xaoxZyGS83lBOB+89SPMZqvsNSasc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=cLuxiEH1; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:References:In-Reply-To:Cc:To:
	Subject:From:Message-ID:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rCQfBTi0r729FZxuUo8p4JGsOCheZGfbL80bi60RGYo=; b=cLuxiEH1I4B2BNm9Vga+qj/EOc
	fB1rIbW69oOvoL6LjVsuEgv52MCMZh5uck5YWOI9O9oq7ihJmSGP5U8UNl+XPAjgOPhpApqALK4DO
	pO9ZGhstAGeIUjJ1/21FcEdBQci5a4xwT5lu5MXUHM/RUQDP5X8nGUHVozaOu1C2eDtL4r+txIJ27
	W5KN41QChj8LTjnPPeT3NcEw2QJp1GiQ+xcwgG+DXOZxUp7MqhxsVawbqXpqn7nqIB2seE+mPquTQ
	gnwF9N32A9uaoy1wSdv13B0fe14+zP2b73ndNJ5JySbDljIr3e03NDMcKbMTK85kzlHtbdH1ww+kE
	en0YqkRQ==;
Received: from host-79-12-52-169.retail.telecomitalia.it ([79.12.52.169] helo=localhost)
	by imap4.hz.codethink.co.uk with utf8esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1ufGr7-002Acx-9b; Fri, 25 Jul 2025 12:44:53 +0100
Date: Fri, 25 Jul 2025 13:44:51 +0200
Message-ID: <86013fcc38e582ab89b9b7e4864cc1bd@codethink.co.uk>
From: Matteo Martelli <matteo.martelli@codethink.co.uk>
Subject: Re: [PATCH] sched/deadline: Remove fair-servers from real-time task's
 bandwidth accounting
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>
In-Reply-To: <20250721111131.309388-1-yurand2000@gmail.com>
References: <20250721111131.309388-1-yurand2000@gmail.com>
Sender: matteo.martelli@codethink.co.uk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Yuri,

On Mon, 21 Jul 2025 13:11:31 +0200, Yuri Andriaccio <yurand2000@gmail.com> wrote:
> Fair-servers are currently used in place of the old RT_THROTTLING mechanism to
> prevent the starvation of SCHED_OTHER (and other lower priority) tasks when
> real-time FIFO/RR processes are trying to fully utilize the CPU. To allow the
> RT_THROTTLING mechanism, the maximum allocatable bandwidth for real-time tasks
> has been limited to 95% of the CPU-time.
> 
> The RT_THROTTLING mechanism is now removed in favor of fair-servers, which are
> currently set to use, as expected, 5% of the CPU-time. Still, they share the
> same bandwidth that allows to run real-time tasks, and which is still set to 95%
> of the total CPU-time. This means that by removing the RT_THROTTLING mechanism,
> the bandwidth remaning for real-time SCHED_DEADLINE tasks and other dl-servers
> (FIFO/RR are not affected) is only 90%.
> ...

I noticed the same issue while recently addressing a stress-ng bug [1].

> This patch reclaims the 5% lost SCHED_DEADLINE CPU-time (FIFO/RR are not
> affected, there is no admission test there to perform), by accounting the
> fair-server's bandwidth separately. After this patch, the above script runs
> successfully also when allocating 95% bw per task/cpu.
> ...

I've tested your patch on top of 6.16.0-rc7-00091-gdd9c17322a6c,
x86 defconfig, on qemu with 4 virtual CPUs with a debian sid image [2].
I used stress-ng at latest master commit (35e617844) so that it includes
the fix to run the stress workers at full deadline bandwidth. The patch
seems to work properly but I encountered some kernel warnings while
testing. See the details below.


Checked default settings after boot (95% global BW, 5% fair_server BW):
----------
root@localhost:~# cat /proc/sys/kernel/sched_rt_period_us
1000000
root@localhost:~# cat /proc/sys/kernel/sched_rt_runtime_us
950000
root@localhost:~# cat /sys/kernel/debug/sched/fair_server/cpu*/period
1000000000
1000000000
1000000000
1000000000
root@localhost:~# cat /sys/kernel/debug/sched/fair_server/cpu*/runtime
50000000
50000000
50000000
50000000
----------

Launched stress-ng command using 95% BW: 95ms runtime, 100ms period, 100ms
deadline. All 4 stress processes ran properly:
----------
root@localhost:~# ./stress-ng/stress-ng --sched deadline --sched-runtime 95000000 --sched-period 100000000 --sched-deadline 100000000 --cpu 0 --verbose --metrics --timeout 10s
stress-ng: debug: [351] invoked with './stress-ng/stress-ng --sched deadline --sched-runtime 95000000 --sched-period 100000000 --sched-deadline 100000000 --cpu 0 --verbose --metrics --timeout 10s' by user 0 'root'
stress-ng: debug: [351] stress-ng 0.19.02 g35e617844d9b
stress-ng: debug: [351] system: Linux localhost 6.16.0-rc7-00364-gfe48072cc20f #1 SMP PREEMPT_DYNAMIC Thu Jul 24 18:44:39 CEST 2025 x86_64, gcc 14.2.0, glibc 2.41, little endian
stress-ng: debug: [351] RAM total: 1.9G, RAM free: 1.8G, swap free: 0.0
stress-ng: debug: [351] temporary file path: '/root', filesystem type: ext4 (187735 blocks available, QEMU HARDDISK)
stress-ng: debug: [351] 4 processors online, 4 processors configured
stress-ng: info:  [351] setting to a 10 secs run per stressor
stress-ng: debug: [351] CPU data cache: L1: 64K, L2: 512K, L3: 16384K
stress-ng: debug: [351] cache allocate: shared cache buffer size: 16384K
stress-ng: info:  [351] dispatching hogs: 4 cpu
stress-ng: debug: [351] starting stressors
stress-ng: debug: [352] deadline: setting scheduler class 'sched' (period=100000000, runtime=95000000, deadline=100000000)
stress-ng: debug: [353] deadline: setting scheduler class 'sched' (period=100000000, runtime=95000000, deadline=100000000)
stress-ng: debug: [352] cpu: [352] started (instance 0 on CPU 3)
stress-ng: debug: [353] cpu: [353] started (instance 1 on CPU 2)
stress-ng: debug: [354] deadline: setting scheduler class 'sched' (period=100000000, runtime=95000000, deadline=100000000)
stress-ng: debug: [354] cpu: [354] started (instance 2 on CPU 1)
stress-ng: debug: [351] 4 stressors started
stress-ng: debug: [355] deadline: setting scheduler class 'sched' (period=100000000, runtime=95000000, deadline=100000000)
stress-ng: debug: [355] cpu: [355] started (instance 3 on CPU 3)
stress-ng: debug: [352] cpu: using method 'all'
stress-ng: debug: [355] cpu: [355] exited (instance 3 on CPU 0)
stress-ng: debug: [354] cpu: [354] exited (instance 2 on CPU 1)
stress-ng: debug: [353] cpu: [353] exited (instance 1 on CPU 2)
stress-ng: debug: [352] cpu: [352] exited (instance 0 on CPU 3)
stress-ng: debug: [351] cpu: [352] terminated (success)
stress-ng: debug: [351] cpu: [353] terminated (success)
stress-ng: debug: [351] cpu: [354] terminated (success)
stress-ng: debug: [351] cpu: [355] terminated (success)
stress-ng: debug: [351] metrics-check: all stressor metrics validated and sane
stress-ng: metrc: [351] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [351]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [351] cpu               75655     10.00     38.01      0.00      7564.01        1990.31        95.01          8460
stress-ng: info:  [351] skipped: 0
stress-ng: info:  [351] passed: 4: cpu (4)
stress-ng: info:  [351] failed: 0
stress-ng: info:  [351] metrics untrustworthy: 0
stress-ng: info:  [351] successful run completed in 10.10 secs
----------

Launched stress-ng command using 96% BW: 96ms runtime, 100ms period, 100ms
deadline. The last spawn stress process failed to execute:
"stress-ng: warn: [357] cpu: [361] aborted early, out of system resources"
(without the patch, stress-ng produced the same error but with BW > 90%):
----------
root@localhost:~# ./stress-ng/stress-ng --sched deadline --sched-runtime 96000000 --sched-period 100000000 --sched-deadline 100000000 --cpu 0 --verbose --metrics --timeout 10s
stress-ng: debug: [357] invoked with './stress-ng/stress-ng --sched deadline --sched-runtime 96000000 --sched-period 100000000 --sched-deadline 100000000 --cpu 0 --verbose --metrics --timeout 10s' by user 0 'root'
stress-ng: debug: [357] stress-ng 0.19.02 g35e617844d9b
stress-ng: debug: [357] system: Linux localhost 6.16.0-rc7-00364-gfe48072cc20f #1 SMP PREEMPT_DYNAMIC Thu Jul 24 18:44:39 CEST 2025 x86_64, gcc 14.2.0, glibc 2.41, little endian
stress-ng: debug: [357] RAM total: 1.9G, RAM free: 1.8G, swap free: 0.0
stress-ng: debug: [357] temporary file path: '/root', filesystem type: ext4 (187735 blocks available, QEMU HARDDISK)
stress-ng: debug: [357] 4 processors online, 4 processors configured
stress-ng: info:  [357] setting to a 10 secs run per stressor
stress-ng: debug: [357] CPU data cache: L1: 64K, L2: 512K, L3: 16384K
stress-ng: debug: [357] cache allocate: shared cache buffer size: 16384K
stress-ng: info:  [357] dispatching hogs: 4 cpu
stress-ng: debug: [357] starting stressors
stress-ng: debug: [358] deadline: setting scheduler class 'sched' (period=100000000, runtime=96000000, deadline=100000000)
stress-ng: debug: [359] deadline: setting scheduler class 'sched' (period=100000000, runtime=96000000, deadline=100000000)
stress-ng: debug: [360] deadline: setting scheduler class 'sched' (period=100000000, runtime=96000000, deadline=100000000)
stress-ng: debug: [358] cpu: [358] started (instance 0 on CPU 1)
stress-ng: debug: [359] cpu: [359] started (instance 1 on CPU 2)
stress-ng: debug: [360] cpu: [360] started (instance 2 on CPU 0)
stress-ng: debug: [357] 4 stressors started
stress-ng: debug: [361] deadline: setting scheduler class 'sched' (period=100000000, runtime=96000000, deadline=100000000)
stress-ng: debug: [358] cpu: using method 'all'
stress-ng: debug: [359] cpu: [359] exited (instance 1 on CPU 3)
stress-ng: debug: [360] cpu: [360] exited (instance 2 on CPU 2)
stress-ng: debug: [358] cpu: [358] exited (instance 0 on CPU 0)
stress-ng: debug: [357] cpu: [358] terminated (success)
stress-ng: debug: [357] cpu: [359] terminated (success)
stress-ng: debug: [357] cpu: [360] terminated (success)
stress-ng: warn:  [357] cpu: [361] aborted early, out of system resources
stress-ng: debug: [357] cpu: [361] terminated (no resources)
stress-ng: debug: [357] metrics-check: all stressor metrics validated and sane
stress-ng: metrc: [357] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [357]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [357] cpu               58940     10.00     28.80      0.00      5892.97        2046.02        96.01          8444
stress-ng: info:  [357] skipped: 1: cpu (1)
stress-ng: info:  [357] passed: 3: cpu (3)
stress-ng: info:  [357] failed: 0
stress-ng: info:  [357] metrics untrustworthy: 0
stress-ng: info:  [357] successful run completed in 10.10 secs
----------

Trying to increase fair_server BW without reducing the global BW, failed as
expected:
----------
root@localhost:~# echo 60000000 > /sys/kernel/debug/sched/fair_server/cpu0/runtime
-bash: echo: write error: Device or resource busy
----------


Trying to increase fair_server BW after reducing the global BW, succeeded:
----------
root@localhost:~# echo 940000 > /proc/sys/kernel/sched_rt_runtime_us
root@localhost:~# echo 60000000 > /sys/kernel/debug/sched/fair_server/cpu0/runtime
root@localhost:~# echo 60000000 > /sys/kernel/debug/sched/fair_server/cpu1/runtime
root@localhost:~# echo 60000000 > /sys/kernel/debug/sched/fair_server/cpu2/runtime
root@localhost:~# echo 60000000 > /sys/kernel/debug/sched/fair_server/cpu3/runtime
root@localhost:~#
----------


Checked that settings had been applied correctly:
----------
root@localhost:~# cat /proc/sys/kernel/sched_rt_runtime_us
940000
root@localhost:~# cat /sys/kernel/debug/sched/fair_server/cpu*/runtime
60000000
60000000
60000000
60000000
----------

NOTE: After setting fair_server runtime for cpu2, I've encointered the
following warning, however it also happened after setting the runtime
for cpu0 during another instance of the same test:
----------
[  196.647897] ------------[ cut here ]------------
[  196.649198] WARNING: kernel/sched/deadline.c:284 at dl_rq_change_utilization+0x5f/0x1d0, CPU#1: bash/249
[  196.650244] Modules linked in:
[  196.650613] CPU: 1 UID: 0 PID: 249 Comm: bash Not tainted 6.16.0-rc7-00364-gfe48072cc20f #1 PREEMPT(voluntary)
[  196.651698] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.17.0-1-1 04/01/2014
[  196.652834] RIP: 0010:dl_rq_change_utilization+0x5f/0x1d0
[  196.653747] Code: 01 00 00 4d 89 88 d0 08 00 00 48 83 c4 18 c3 cc cc cc cc 90 0f 0b 90 49 c7 80 d0 08 00 00 00 00 00 00 48 85 d2 74 dc 31 c0 90 <0f> 0b 90 49 39 c1 73 d1 e9 04 01 00 00 f6 46 53 10 75 73 48 8b 87
[  196.655791] RSP: 0018:ffffa47b003e3d60 EFLAGS: 00010093
[  196.656328] RAX: 0000000000000000 RBX: 000000003b9aca00 RCX: ffff9f25bdd292b0
[  196.657031] RDX: 000000000000cccc RSI: ffff9f25bdd292b0 RDI: ffff9f25bdd289c0
[  196.657742] RBP: ffff9f25bdd289c0 R08: ffff9f25bdd289c0 R09: 000000000000f5c2
[  196.658453] R10: 000000000000000a R11: 0fffffffffffffff R12: ffff9f25bdd292b0
[  196.659077] R13: 0000000000001000 R14: ffff9f25411a3840 R15: ffff9f25411a3800
[  196.659752] FS:  00007f3c521c4740(0000) GS:ffff9f26249cb000(0000) knlGS:0000000000000000
[  196.660321] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  196.660740] CR2: 000055d43eae1a58 CR3: 0000000005281000 CR4: 00000000000006f0
[  196.661210] Call Trace:
[  196.661383]  <TASK>
[  196.661605]  ? dl_bw_cpus+0x74/0x80
[  196.661840]  dl_server_apply_params+0x1b3/0x1e0
[  196.662142]  sched_fair_server_write.isra.0+0x10a/0x1a0
[  196.662523]  full_proxy_write+0x54/0x90
[  196.662780]  vfs_write+0xc9/0x480
[  196.663006]  ksys_write+0x6e/0xe0
[  196.663229]  do_syscall_64+0xa4/0x260
[  196.663513]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  196.663845] RIP: 0033:0x7f3c52256687
[  196.664084] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  196.666102] RSP: 002b:00007ffde87d9720 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  196.666631] RAX: ffffffffffffffda RBX: 00007f3c521c4740 RCX: 00007f3c52256687
[  196.667099] RDX: 0000000000000009 RSI: 000055d43eb74a50 RDI: 0000000000000001
[  196.667596] RBP: 000055d43eb74a50 R08: 0000000000000000 R09: 0000000000000000
[  196.668057] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000009
[  196.668562] R13: 00007f3c523af5c0 R14: 00007f3c523ace80 R15: 0000000000000000
[  196.669448]  </TASK>
[  196.669795] ---[ end trace 0000000000000000 ]---
----------

I've also encountered this other warning after setting cpu4 during
another instance of the same test:
----------
[  177.452335] ------------[ cut here ]------------
[  177.453820] WARNING: kernel/sched/deadline.c:257 at task_non_contending+0x259/0x3b0, CPU#1: swapper/1/0
[  177.455214] Modules linked in:
[  177.455555] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G        W           6.16.0-rc7-00364-gfe48072cc20f #1 PREEMPT(voluntary)
[  177.456841] Tainted: [W]=WARN
[  177.457192] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.17.0-1-1 04/01/2014
[  177.458202] RIP: 0010:task_non_contending+0x259/0x3b0
[  177.458751] Code: 4c 89 0c 24 e8 b8 46 49 00 4c 8b 0c 24 e9 6b fe ff ff f6 43 53 10 0f 85 57 ff ff ff 49 8b 80 c8 08 00 00 48 2b 43 30 73 06 90 <0f> 0b 90 31 c0 49 63 90 28 0b 00 00 49 89 80 c8 08 00 00 48 c7 c0
[  177.460760] RSP: 0018:ffffa88f400e8ea0 EFLAGS: 00010087
[  177.461352] RAX: ffffffffffffd70a RBX: ffff8c8b7dca92b0 RCX: 0000000000000001
[  177.462121] RDX: fffffffffffdf33f RSI: 0000000003938700 RDI: ffff8c8b7dca92b0
[  177.462884] RBP: ffff8c8b7dca89c0 R08: ffff8c8b7dca89c0 R09: 0000000000000002
[  177.463655] R10: ffff8c8b7dca89c0 R11: 0000000000000000 R12: ffffffffa7b55050
[  177.464403] R13: 0000000000000002 R14: ffff8c8b7dca92b0 R15: ffff8c8b7dc9bb00
[  177.465124] FS:  0000000000000000(0000) GS:ffff8c8bd3dcb000(0000) knlGS:0000000000000000
[  177.465775] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  177.466231] CR2: 000055c7394fa93c CR3: 0000000006855000 CR4: 00000000000006f0
[  177.466757] Call Trace:
[  177.466952]  <IRQ>
[  177.467104]  dl_task_timer+0x3ca/0x830
[  177.467373]  __hrtimer_run_queues+0x12e/0x2a0
[  177.467686]  hrtimer_interrupt+0xf7/0x220
[  177.468000]  __sysvec_apic_timer_interrupt+0x53/0x100
[  177.468358]  sysvec_apic_timer_interrupt+0x66/0x80
[  177.468701]  </IRQ>
[  177.468866]  <TASK>
[  177.469047]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  177.469413] RIP: 0010:pv_native_safe_halt+0xf/0x20
[  177.469759] Code: 06 86 00 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d f5 97 1f 00 fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
[  177.471123] RSP: 0018:ffffa88f400a3ed8 EFLAGS: 00000212
[  177.471491] RAX: ffff8c8bd3dcb000 RBX: ffff8c8b01249d80 RCX: ffff8c8b02399701
[  177.472013] RDX: 4000000000000000 RSI: 0000000000000083 RDI: 000000000000bc4c
[  177.472511] RBP: 0000000000000001 R08: 000000000000bc4c R09: ffff8c8b7dca49d0
[  177.473021] R10: 0000002954e5b780 R11: 0000000000000002 R12: 0000000000000000
[  177.473518] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  177.474058]  ? ct_kernel_exit.constprop.0+0x63/0xf0
[  177.474404]  default_idle+0x9/0x10
[  177.474649]  default_idle_call+0x2b/0x100
[  177.474952]  do_idle+0x1d0/0x230
[  177.475186]  cpu_startup_entry+0x24/0x30
[  177.475466]  start_secondary+0xf3/0x100
[  177.475745]  common_startup_64+0x13e/0x148
[  177.476079]  </TASK>
[  177.476241] ---[ end trace 0000000000000000 ]---
----------

Beside the warnings the new max BW it was applied correctly, and re-running
stress-ng with 95% BW it failed (last spawn process aborted), while re-running
stress-ng with 94% BW it passed (all processes ran).

Trying to reset global BW to 95% before decreasing fair_server BW failed as
expected:
----------
root@localhost:~# echo 950000 > /proc/sys/kernel/sched_rt_runtime_us
-bash: echo: write error: Device or resource busy
----------

Setting back global BW to 95% after decreasing fair_server BW back to 5%
succeeded:
----------
root@localhost:~# echo 50000000 > /sys/kernel/debug/sched/fair_server/cpu0/runtime
root@localhost:~# echo 50000000 > /sys/kernel/debug/sched/fair_server/cpu1/runtime
root@localhost:~# echo 50000000 > /sys/kernel/debug/sched/fair_server/cpu2/runtime
root@localhost:~# echo 50000000 > /sys/kernel/debug/sched/fair_server/cpu3/runtime
root@localhost:~# echo 950000 > /proc/sys/kernel/sched_rt_runtime_us
root@localhost:~#
----------

Checked that settings had been applied correctly:
----------
root@localhost:~# cat /proc/sys/kernel/sched_rt_runtime_us
950000
root@localhost:~# cat /sys/kernel/debug/sched/fair_server/cpu*/runtime
50000000
50000000
50000000
50000000
----------

After a few seconds I've enountered yet another warning:
----------
[  749.612165] ------------[ cut here ]------------
[  749.613416] WARNING: kernel/sched/deadline.c:245 at task_contending+0x167/0x190, CPU#3: swapper/3/0
[  749.614406] Modules linked in:
[  749.614783] CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Tainted: G        W           6.16.0-rc7-00364-gfe48072cc20f #1 PREEMPT(voluntary)
[  749.616070] Tainted: [W]=WARN
[  749.616398] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.17.0-1-1 04/01/2014
[  749.617383] RIP: 0010:task_contending+0x167/0x190
[  749.617913] Code: 48 83 c4 08 e9 1a 56 49 00 83 e1 04 0f 85 7a ff ff ff c3 cc cc cc cc 90 0f 0b 90 e9 39 ff ff ff 90 0f 0b 90 e9 f5 fe ff ff 90 <0f> 0b 90 e9 f9 fe ff ff 90 0f 0b 90 eb 91 48 c7 c6 50 4c ef 96 48
[  749.621091] RSP: 0018:ffffa47b00140de8 EFLAGS: 00010087
[  749.621685] RAX: ffff9f25bdda89c0 RBX: ffff9f25bdda92b0 RCX: 000000000000f5c2
[  749.622470] RDX: 000000000000f5c2 RSI: 0000000000000001 RDI: 0000000000000000
[  749.623243] RBP: 0000000000000001 R08: 00000000041d4a50 R09: 0000000000000002
[  749.623935] R10: 0000000000000001 R11: ffff9f2541e28010 R12: 0000000000000001
[  749.624526] R13: ffff9f25bdda8a40 R14: 0000000000000000 R15: 0000000000200b20
[  749.625066] FS:  0000000000000000(0000) GS:ffff9f2624acb000(0000) knlGS:0000000000000000
[  749.625676] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  749.626090] CR2: 00007f3c523df18c CR3: 00000000050c8000 CR4: 00000000000006f0
[  749.626639] Call Trace:
[  749.626825]  <IRQ>
[  749.626980]  enqueue_dl_entity+0x401/0x730
[  749.627281]  dl_server_start+0x35/0x80
[  749.627588]  enqueue_task_fair+0x20c/0x820
[  749.627891]  enqueue_task+0x2c/0x70
[  749.628150]  ttwu_do_activate+0x6e/0x210
[  749.628439]  try_to_wake_up+0x249/0x630
[  749.628741]  ? __pfx_hrtimer_wakeup+0x10/0x10
[  749.629062]  hrtimer_wakeup+0x1d/0x30
[  749.629332]  __hrtimer_run_queues+0x12e/0x2a0
[  749.629712]  hrtimer_interrupt+0xf7/0x220
[  749.630005]  __sysvec_apic_timer_interrupt+0x53/0x100
[  749.630373]  sysvec_apic_timer_interrupt+0x66/0x80
[  749.630810]  </IRQ>
[  749.630971]  <TASK>
[  749.631131]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  749.631500] RIP: 0010:pv_native_safe_halt+0xf/0x20
[  749.631821] Code: 06 86 00 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d f5 97 1f 00 fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
[  749.633041] RSP: 0018:ffffa47b000b3ed8 EFLAGS: 00000202
[  749.633490] RAX: ffff9f2624acb000 RBX: ffff9f254124bb00 RCX: ffffa47b0056fe30
[  749.633996] RDX: 4000000000000000 RSI: 0000000000000083 RDI: 000000000006ae44
[  749.634482] RBP: 0000000000000003 R08: 000000000006ae44 R09: ffff9f25bdda49d0
[  749.634952] R10: 000000ae900bc540 R11: 0000000000000008 R12: 0000000000000000
[  749.635437] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  749.637635]  ? ct_kernel_exit.constprop.0+0x63/0xf0
[  749.638053]  default_idle+0x9/0x10
[  749.638349]  default_idle_call+0x2b/0x100
[  749.638682]  do_idle+0x1d0/0x230
[  749.638903]  cpu_startup_entry+0x24/0x30
[  749.639163]  start_secondary+0xf3/0x100
[  749.639420]  common_startup_64+0x13e/0x148
[  749.639718]  </TASK>
[  749.639870] ---[ end trace 0000000000000000 ]---
----------

I then reduced fair_server runtime to 40000000 (for all CPUs), raised global
sched_rt_runtime_us to 960000, and re-run stress-ng at 96% BW (passed) and at
97% BW (failed: one process aborted). During this last test I've got again the
two warnings mentioned above (kernel/sched/deadline.c:284 at dequeue_task_dl
and WARNING: kernel/sched/deadline.c:245 at task_contending+0x167/0x190), this
while setting the fair_server runtime but also while running stress-ng.

I couldn't reproduce the warning on the same kernel without the patch applied,
by trying different configurations of fair_server BW and global BW, while they
seem very reproducible with the patch applied.

[1]: https://github.com/ColinIanKing/stress-ng/issues/549
[2]: https://cloud.debian.org/images/cloud/sid/daily/20250606-2135/debian-sid-nocloud-amd64-daily-20250606-2135.qcow2

I hope this is helpful.

Best regards,
Matteo Martelli


