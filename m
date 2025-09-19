Return-Path: <linux-kernel+bounces-825004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF39B8AB00
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA621747F0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D4E3218DF;
	Fri, 19 Sep 2025 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="TbkCFF6l"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AFF2367AD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301464; cv=none; b=AdgAPHyiCFroombw/OJMj9BX8ekiMzybi2q6iBKef0ejbhwePK3AOK+hRYAy4dO9C4867K/8iXfvTa6QPpysvnoXQSQoTBmXUqRvV+9LVFLjagwTl/C42TXdTrvR9bUKA5vQjV1MGNmeu1KP0/LuVT3/8vnWQ2fDHtjlaEOAvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301464; c=relaxed/simple;
	bh=FX7txett8XWYYwZ4Z009gPqdx1Ustatq5+RH8RZ8Ir0=;
	h=Date:Message-ID:From:Subject:To:In-Reply-To:References; b=srmqZpbHTr0lZlVCTPembwdoRJoX7NI9AGTLusxwIwpwvYMiYST5lmfrG4T+Hk1mXV5z6YqNw9AzzVVrhOMZot6NCvoJx8v6E/ZQ69zuP+HzDTaZT5XHQn13byZXpE33nDurY/uaP/ct3PkMxXXrMCOYnziEku93PZDF8UwEnn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=TbkCFF6l; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:References:In-Reply-To:To:
	Subject:From:Message-ID:Date:Reply-To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+gnEkNVlV4Lbz6phGGwFh5ebGbtFcT0C2N8LIyl4yk8=; b=TbkCFF6lFqTMDnURZHAdt4+xlG
	s+GCIP5C+dbe9E0WivmJ/9NApe+z0XkpmkCiUBNW2+/xOIJoGuIt6HKwROfSUYzqgdLX7PMdPLKJr
	gct2+W5vHz511MgL8GfuN52xeLi2DHoj+W8esJgPcTapuA05P/2UajCGrWZcAl8GqG9js7vOgkLHp
	tt7QsqAEi1x/Buqa9reHz9S4WGhi7uujVzlgRfApd0NNfX6WU+7OX1FCcFY2Ki/FBudw3j4I4PLK3
	bqSGgf2dhOm48FyNxIAFl+QR5xs1etFLBc5gXGlXAKIQAWg9BYnMO4swBfVdaS1kwCGhVAGq57lSX
	EfDMq8+Q==;
Received: from [167.98.27.226] (helo=localhost)
	by imap4.hz.codethink.co.uk with utf8esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1uze6l-00GQ1Y-Rt; Fri, 19 Sep 2025 17:37:17 +0100
Date: Fri, 19 Sep 2025 18:37:15 +0200
Message-ID: <d6abff7f5f9ee5e41f19cb1f9d02de29@codethink.co.uk>
From: Matteo Martelli <matteo.martelli@codethink.co.uk>
Subject: Re: BUG/WARN issues in kernel/sched/rt.c under stress-ng with
 crgoup-v2
To: Ben Dooks <ben.dooks@codethink.co.uk>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Marcel Ziswiler
	<marcel.ziswiler@codethink.co.uk>, Matteo Martelli <matteo.martelli@codethink.co.uk>
In-Reply-To: <3308bca2-624e-42a3-8d98-48751acaa3b3@codethink.co.uk>
References: <3308bca2-624e-42a3-8d98-48751acaa3b3@codethink.co.uk>
Sender: matteo.martelli@codethink.co.uk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi all,

On Fri, 19 Sep 2025 12:10:34 +0100, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> We are doing some testing with stress-ng and the cgroup-v2 enabled
> (CONFIG_RT_GROUP_SCHED) and are running into WARN/BUG within a minute
> related to user-space calling sched_setattr() and possibly other calls.
> 
> At the moment we're not sure if the WARN and BUG calls are entirely
> correct, we are considering there may be some sort of race condition
> which is causing incorrect assumptions in the code.
> 
> We are seeing this kernel bug in pick_next_rt_entity being triggered
> 
> 	idx = sched_find_first_bit(array->bitmap);
> 	BUG_ON(idx >= MAX_RT_PRIO);
> 
> Which suggests that the pick_task_rt() ran, thought there was something
> there to schedule and got into pick_next_rt_entity() which then found
> there was nothing. It does this by checking rq->rt.rt_queued before it
> bothers to try picking something to run.
> 
> (this BUG_ON() is triggered if there is no index in the array indicating
>   something there to run)
> 
> We added some debug to find out what the values in pick_next_rt_entity()
> with the current rt_queued and the value it was when pick_task_rt()
> looked, and we got:
> 
>     idx 100 bigger than MAX_RT_PRIO 100, queued = 0 (queued was 1)
> 
> This shows the code was entered with the rt_q showing something
> should have been queued and by the time the pick_next_rt_entity()
> was entered there seems to be nothing (assuming the array is in
> sync with the lists...)
> 
> I think the two questions we have are:
> 
> - Is the BUG_ON() here appropriate, should a WARN_ON_ONCE() and
>    return NULL be the best way of handling this? I am going to try
>    this and see if the system is still runnable with this.
> 
> - Are we seeing a race here, and if so where is the best place to
>    prevent it?
> 
> Note, we do have a few local backported cgroup-v2 patches.
> 
> Our systemd unit file to launch the test is here:
> 
> [Service]
> Type=simple
> Restart=always
> ExecStartPre=/bin/sh -c 'echo 500000 > 
> /sys/fs/cgroup/system.slice/cpu.rt_runtime_us'
> ExecStartPre=/bin/sh -c 'echo 500000 > 
> /sys/fs/cgroup/system.slice/stress-sched-long-system.service/cpu.rt_runtime_us'
> ExecStart=sandbox-run /usr/bin/stress-ng --temp-path /tmp/stress-ng 
> --timeout=0 --verify --oom-avoid --metrics --timestamp 
> --exclude=enosys,usersyscall --cpu-sched 0 --timeout 60 --verbose 
> --stressor-time
> Environment=SANDBOX_RO_BINDMOUNTS="/usr/share/stress-ng"
> Environment=SANDBOX_RW_BINDMOUNTS="/var/log /sys /proc /dev /tmp/stress-ng"
> Environment=SANDBOX_EXTRA_ARGS="--cwd /tmp/stress-ng --keep_caps 
> --disable_rlimits --disable_clone_newuser"
> Slice=system.slice
> OOMPolicy=continue
> 
> I added this to dump the array and confirm at-least the array-v-list
> was in sync at the point of the bug:
> 
> static inline void debug_pick_next(struct rt_rq *rt_rq, int idx, 
> unsigned qs)
> {
> 	struct rt_prio_array *array = &rt_rq->active;
> 	unsigned int nr;
> 
> 	pr_err("rt_q %px: idx %d bigger than MAX_RT_PRIO %d, queued = %d (was 
> %u)\n",
> 	       rt_rq, idx, MAX_RT_PRIO, rt_rq->rt_queued, qs );
> 
> 	for (nr = 0; nr < MAX_RT_PRIO; nr += sizeof(array->bitmap[0])*8) {
> 		pr_info("  bitmap idx %u: %lx\n", nr, 
> array->bitmap[nr/(sizeof(array->bitmap[0])*8)]);
> 	}
> 
> 	// check that the bitmap and array match
> 	for (nr = 0; nr < MAX_RT_PRIO; nr += 1) {
> 		bool l_empty = list_empty(array->queue + nr);
> 		bool a_empty = !test_bit(nr, array->bitmap);
> 
> 		if (l_empty != a_empty) {
> 			pr_err(" bitmap idx %u: array %s, bitmask %s\n", nr,
> 			       a_empty ? "empty" : "full",
> 			       l_empty ? "empty" : "full");
> 		}
> 	}
> }
> 	

Hi all,

To provide some more context, we have found out this issue while running
some tests with stress-ng scheduler stressor[1] and the RT throttling
feature after enabling the RT_GROUP_SCHED kernel option. Note that we
also have PREEMPT_RT enabled in our config.

I've just reproduced the issue on qemu-x86_64 with a debian image and kernel
v6.17-rc6. See below the steps to reproduce it.

cd linux
git reset --hard v6.17-rc6 && git clean -f -d

# Apply patch to expose RT_GROUP_SCHED interface to userspace with cgroupv2
b4 shazam --single-message https://lore.kernel.org/all/20250731105543.40832-17-yurand2000@gmail.com/

# Build kernel with defconfig + PREEMPT_RT=y and RT_GROUP_SCHED=y
make mrproper
make defconfig
scripts/config -k -e EXPERT
scripts/config -k -e PREEMPT_RT
scripts/config -k -e RT_GROUP_SCHED
make olddefconfig
make -j12

# Download a debian image and run qemu
wget https://cdimage.debian.org/images/cloud/sid/daily/20250919-2240/debian-sid-nocloud-amd64-daily-20250919-2240.qcow2
qemu-system-x86_64 \
    -m 2G -smp 4 \
    -nographic \
    -nic user,hostfwd=tcp::2222-:22 \
    -M q35,accel=kvm \
    -drive format=qcow2,file=debian-sid-nocloud-amd64-daily-20250919-2240.qcow2 \
    -virtfs local,path=.,mount_tag=shared,security_model=mapped-xattr \
    -monitor none \
    -append "root=/dev/sda1 console=ttyS0,115200 sysctl.kernel.panic_on_oops=1" \
    -kernel arch/x86/boot/bzImage

# Then inside guest machine
# Install stress-ng
apt-get update && apt-get install stress-ng

# Create the stress-ng service. It sets the group RT runtime to 500ms
# (50% BW) via the cgroupv2 interface then it starts the stress-ng
# scheduler stressor. Also note the cpu affinity set to a single CPU
# which seems to help the issue to be more reproducible.
echo "[Unit]
Description=Mixed stress with long in the system slice
After=basic.target

[Service]
AllowedCPUs=0
Type=simple
Restart=always
ExecStartPre=/bin/sh -c 'echo 500000 > /sys/fs/cgroup/system.slice/cpu.rt_runtime_us'
ExecStart=/usr/bin/stress-ng --timeout=0 --verify --oom-avoid --metrics --timestamp --exclude=enosys,usersyscall --cpu-sched 0 --timeout 60 --verbose --stressor-time
Slice=system.slice
OOMPolicy=continue" > /etc/systemd/system/stress-sched-long-system.service

systemctl start stress-sched-long-system.service

Then the BUG_ON is triggered within a few minutes. See the following logs.

[  345.657737] ------------[ cut here ]------------
[  345.657741] kernel BUG at kernel/sched/rt.c:1673!
[  345.657746] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[  345.657749] CPU: 0 UID: 0 PID: 379 Comm: stress-ng-cpu-s Not tainted 6.17.0-rc6-00001-g6c9be1b0be15 #1 PREEMPT_{RT,(full)}
[  345.657750] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.17.0-1-1 04/01/2014
[  345.657751] RIP: 0010:pick_task_rt+0x6c/0x80
[  345.657762] Code: 85 c0 74 16 48 8b 78 40 48 85 ff 75 c6 48 2d 80 01 00 00 c3 cc cc cc cc 31 c0 c3 cc cc cc cc f3 48 0f bc c0 83 f8 63 7
[  345.657763] RSP: 0018:ffff95de8071bcf8 EFLAGS: 00010002
[  345.657765] RAX: 0000000000000064 RBX: ffff8bd585ab9e00 RCX: 0000000000000000
[  345.657765] RDX: 0000000000000000 RSI: ffff8bd585ab9e00 RDI: ffff8bd5fdc29400
[  345.657766] RBP: ffff95de8071bd70 R08: 0000000000000004 R09: ffff8bd5fdc29200
[  345.657766] R10: 0000000000000001 R11: 000000000000000a R12: ffff8bd585ab9e00
[  345.657767] R13: ffffffff97593180 R14: ffff8bd5fdc29200 R15: 0000000000000000
[  345.657770] FS:  00007f339538fb00(0000) GS:ffff8bd665a0f000(0000) knlGS:0000000000000000
[  345.657770] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  345.657771] CR2: 000056316fe06320 CR3: 0000000006f0e000 CR4: 00000000000006f0
[  345.657772] Call Trace:
[  345.657775]  <TASK>
[  345.657775]  __schedule+0x488/0xf30
[  345.657779]  preempt_schedule+0x2e/0x50
[  345.657780]  preempt_schedule_thunk+0x16/0x30
[  345.657782]  migrate_enable+0xbc/0xd0
[  345.657784]  rt_spin_unlock+0xd/0x40
[  345.657787]  get_signal+0x765/0x8d0
[  345.657789]  ? do_nanosleep+0xe9/0x170
[  345.657791]  arch_do_signal_or_restart+0x38/0x250
[  345.657793]  exit_to_user_mode_loop+0x6b/0xb0
[  345.657796]  do_syscall_64+0x221/0x290
[  345.657798]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  345.657800] RIP: 0033:0x7f3395c4f687
[  345.657801] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  345.657802] RSP: 002b:00007ffd2cbc0270 EFLAGS: 00000202 ORIG_RAX: 00000000000000e6
[  345.657803] RAX: 0000000000000000 RBX: 00007f339538fb00 RCX: 00007f3395c4f687
[  345.657803] RDX: 00007ffd2cbc02b0 RSI: 0000000000000000 RDI: 0000000000000000
[  345.657804] RBP: 000056316fe06320 R08: 0000000000000000 R09: 0000000000000000
[  345.657804] R10: 00007ffd2cbc02c0 R11: 0000000000000202 R12: 000000000000017b
[  345.657804] R13: 000056315f837030 R14: 0000000000000003 R15: 0000000000000001
[  345.657805]  </TASK>
[  345.657805] Modules linked in:
[  345.657807] ---[ end trace 0000000000000000 ]---
[  345.657807] RIP: 0010:pick_task_rt+0x6c/0x80
[  345.657809] Code: 85 c0 74 16 48 8b 78 40 48 85 ff 75 c6 48 2d 80 01 00 00 c3 cc cc cc cc 31 c0 c3 cc cc cc cc f3 48 0f bc c0 83 f8 63 7e c0 90 <0f> 0b 90 0f 0b 90 31 c0 c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90
[  345.657809] RSP: 0018:ffff95de8071bcf8 EFLAGS: 00010002
[  345.657810] RAX: 0000000000000064 RBX: ffff8bd585ab9e00 RCX: 0000000000000000
[  345.657810] RDX: 0000000000000000 RSI: ffff8bd585ab9e00 RDI: ffff8bd5fdc29400
[  345.657810] RBP: ffff95de8071bd70 R08: 0000000000000004 R09: ffff8bd5fdc29200
[  345.657811] R10: 0000000000000001 R11: 000000000000000a R12: ffff8bd585ab9e00
[  345.657811] R13: ffffffff97593180 R14: ffff8bd5fdc29200 R15: 0000000000000000
[  345.657814] FS:  00007f339538fb00(0000) GS:ffff8bd665a0f000(0000) knlGS:0000000000000000
[  345.657814] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  345.657815] CR2: 000056316fe06320 CR3: 0000000006f0e000 CR4: 00000000000006f0
[  345.657815] Kernel panic - not syncing: Fatal exception
[  345.657969] Kernel Offset: 0x14e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  345.685385] ---[ end Kernel panic - not syncing: Fatal exception ]---

Also the WARNING in __dequeue_rt_entity() is often being hit

[  117.550503] ------------[ cut here ]------------
[  117.550505] WARNING: CPU: 0 PID: 398 at kernel/sched/rt.c:1366 dequeue_rt_stack+0x311/0x330
[  117.550518] Modules linked in:
[  117.550521] CPU: 0 UID: 0 PID: 398 Comm: stress-ng-cpu-s Not tainted 6.17.0-rc6-00001-g6c9be1b0be15 #1 PREEMPT_{RT,(full)}
[  117.550523] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Arch Linux 1.17.0-1-1 04/01/2014
[  117.550524] RIP: 0010:dequeue_rt_stack+0x311/0x330
[  117.550526] Code: 06 00 00 e9 46 fe ff ff 90 0f 0b 90 85 c0 75 06 90 0f 0b 90 31 c0 b9 01 00 00 00 48 85 d2 0f 85 ce fd ff ff e9 cf fd f
[  117.550526] RSP: 0018:ffffb4af008cbce0 EFLAGS: 00010046
[  117.550528] RAX: 0000000000000000 RBX: ffff979604108120 RCX: ffff979601febc80
[  117.550528] RDX: ffff979604108120 RSI: 0000000000000006 RDI: ffff97967dc29400
[  117.550529] RBP: ffff979604108120 R08: 00000000000e7ef0 R09: ffff979601febc00
[  117.550529] R10: 0000000000000001 R11: 0000000000000002 R12: ffff97967dc29400
[  117.550530] R13: 0000000000000006 R14: 0000000000000002 R15: ffffffff97393180
[  117.550533] FS:  00007f2a872eeb00(0000) GS:ffff9796e5c0f000(0000) knlGS:0000000000000000
[  117.550534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  117.550534] CR2: 00005633eab27d00 CR3: 00000000041c6000 CR4: 00000000000006f0
[  117.550535] Call Trace:
[  117.550538]  <TASK>
[  117.550539]  dequeue_rt_entity+0x29/0x160
[  117.550541]  dequeue_task_rt+0x25/0x40
[  117.550542]  rt_mutex_setprio+0x356/0x520
[  117.550545]  rt_mutex_slowunlock+0x15c/0x290
[  117.550548]  ? __set_cpus_allowed_ptr+0x5f/0xa0
[  117.550549]  ? migrate_enable+0x6a/0xd0
[  117.550550]  do_send_sig_info+0x61/0xa0
[  117.550553]  kill_pid_info_type+0x8d/0xa0
[  117.550555]  kill_something_info+0x16b/0x1a0
[  117.550556]  __x64_sys_kill+0x88/0xb0
[  117.550557]  do_syscall_64+0xa4/0x290
[  117.550560]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  117.550561] RIP: 0033:0x7f2a87b5f007
[  117.550562] Code: 48 83 c4 08 c3 66 0f 1f 44 00 00 48 8b 15 e9 6d 1a 00 64 89 02 b8 ff ff ff ff eb e4 0f 1f 80 00 00 00 00 b8 3e 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c1 6d 1a 00 f7 d8 64 89 01 48
[  117.550563] RSP: 002b:00007ffefab861c8 EFLAGS: 00000202 ORIG_RAX: 000000000000003e
[  117.550564] RAX: ffffffffffffffda RBX: 00007f2a872d8a00 RCX: 00007f2a87b5f007
[  117.550565] RDX: 0000000000000003 RSI: 0000000000000012 RDI: 00000000000001af
[  117.550565] RBP: 0000000000000002 R08: 000acce4c998f093 R09: 0000000000000000
[  117.550565] R10: 00007f2a8909d000 R11: 0000000000000202 R12: 0000000000000004
[  117.550566] R13: 0000000000000001 R14: 00007ffefab86420 R15: 00000000000001af
[  117.550567]  </TASK>
[  117.550567] ---[ end trace 0000000000000000 ]---

and sometimes RCU stalls

[  453.738633] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  453.738636] rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-3): P853/3:b..l
[  453.738638] rcu:     (detected by 0, t=21002 jiffies, g=1477, q=122 ncpus=4)
[  453.738640] task:stress-ng-cpu-s state:R  running task     stack:14200 pid:853   tgid:853   ppid:849    task_flags:0x400140 flags:0x0000
[  453.738644] Call Trace:
[  453.738645]  <TASK>
[  453.738646]  __schedule+0x3c9/0xf30
[  453.738651]  schedule_rtlock+0x15/0x30
[  453.738652]  rtlock_slowlock_locked+0x1b6/0x1090
[  453.738654]  rt_spin_lock+0x79/0xd0
[  453.738656]  do_send_sig_info+0x31/0xa0
[  453.738659]  kill_pid_info_type+0x8d/0xa0
[  453.738661]  kill_something_info+0x16b/0x1a0
[  453.738662]  __x64_sys_kill+0x88/0xb0
[  453.738663]  do_syscall_64+0xa4/0x290
[  453.738665]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  453.738667] RIP: 0033:0x7f4df5aeb007
[  453.738669] RSP: 002b:00007ffffc9d8558 EFLAGS: 00000202 ORIG_RAX: 000000000000003e
[  453.738670] RAX: ffffffffffffffda RBX: 00007f4df5261b20 RCX: 00007f4df5aeb007
[  453.738671] RDX: 0000000000000012 RSI: 0000000000000012 RDI: 000000000000035e
[  453.738671] RBP: 0000000000000003 R08: 001053484f787e79 R09: 0000000000000000
[  453.738672] R10: 00007f4df7029000 R11: 0000000000000202 R12: 0000000000000004
[  453.738672] R13: 0000000000000001 R14: 00007ffffc9d8738 R15: 000000000000035e
[  453.738673]  </TASK>

[1]: https://github.com/ColinIanKing/stress-ng/blob/master/stress-cpu-sched.c

I hope the additional information is helpful.

Best regards,
Matteo Martelli

