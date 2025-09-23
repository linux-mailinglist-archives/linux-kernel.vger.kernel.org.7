Return-Path: <linux-kernel+bounces-828965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DBDB95F04
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8282D19C329D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453C324B32;
	Tue, 23 Sep 2025 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="icM2mtLc"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209E324B21
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632768; cv=none; b=H09DLO2Ev0GNip5I5qvGDRl/3HisDhgekSAIOoQtCYLKzQaN4Sm8fwcTT5uLCYvq/zUp0rqae60KtIoUJnRLF+z2UdmTf4G7z7Bxgc40s98xiH4wcGuDPUZfrPI6heAcwerFbkacXuIPeJpkyajV/oV08oo+NORqrfocVjoxivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632768; c=relaxed/simple;
	bh=sGRuMOSLTCQEZwMX2otVVWehj83+PLNz4oC0H4iPmug=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=YMp53StxMcAR98k7zB/iLBKaQo2/LKkgbhwklvCv5vdjTQoRSgQUV4jjkQVmagtkrmEQXmj0DpPzSXrVysgeHeGN9nchi4KKqK4fIIPLo95w9+HoEo3ukAMRkXVtJ4M90xUYp3gtNS7O9Ep+nh2EFtvKnwAOD6L86sxsVxSOzus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=icM2mtLc; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:References:In-Reply-To:Cc:To:
	Subject:From:Message-ID:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Yuk/X7YWdvwxPvsMtejQy0ukKw6DwbJQ5LPO8m+gWK8=; b=icM2mtLc8xUWMQaLXIkq6G7N+S
	gUWaJUqbR6tgRPc7oINYOGYDLUWtq8TNXZd86LwRR8+1VYL2Pum50WaChozHmPLAft0fYwgPWUpLT
	r4Gs5M+MYIfF9JNnr1r27TBoaTdCMuEY875thkEpFEp+lCcB38kfvs9/WEv9oWmOApbXmC32WiNCg
	4im7MDu0E0dZHpYWNzRL5rNX2UrxWrOg8lSQZmwCjDz94/bjC/jdo8/cODtUe2MCUtHDsJbTiuRJL
	j9toQsDRnfim6pLJAxsMcqhT70FwwzpmGqROsYtY6pixvuHZkzBrFTfnLnWiuHAhmXeOxiIWB78pn
	YgZ7Fz+w==;
Received: from host-79-47-48-17.retail.telecomitalia.it ([79.47.48.17] helo=localhost)
	by imap4.hz.codethink.co.uk with utf8esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1v12i0-000pgQ-V9; Tue, 23 Sep 2025 14:05:30 +0100
Date: Tue, 23 Sep 2025 15:05:29 +0200
Message-ID: <58a587d694f33c2ea487c700b0d046fa@codethink.co.uk>
From: Matteo Martelli <matteo.martelli@codethink.co.uk>
Subject: Re: [PATCH 1/4] sched/fair: Propagate load for throttled cfs_rq
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
	<liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>,
	Michal =?iso-8859-1?q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>
In-Reply-To: <20250910095044.278-2-ziqianlu@bytedance.com>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
	<20250910095044.278-2-ziqianlu@bytedance.com>
Sender: matteo.martelli@codethink.co.uk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Aaron,

On Wed, 10 Sep 2025 17:50:41 +0800, Aaron Lu <ziqianlu@bytedance.com> wrote:
> Before task based throttle model, propagating load will stop at a
> throttled cfs_rq and that propagate will happen on unthrottle time by
> update_load_avg().
> 
> Now that there is no update_load_avg() on unthrottle for throttled
> cfs_rq and all load tracking is done by task related operations, let the
> propagate happen immediately.
> 
> While at it, add a comment to explain why cfs_rqs that are not affected
> by throttle have to be added to leaf cfs_rq list in
> propagate_entity_cfs_rq() per my understanding of commit 0258bdfaff5b
> ("sched/fair: Fix unfairness caused by missing load decay").
> 
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> ---

I have been testing again the patch set "[PATCH v4 0/5] Defer throttle
when task exits to user" [1] together with these follow up patches. I
found out that with this patch the kernel sometimes produces the warning
WARN_ON_ONCE(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list); in
assert_list_leaf_cfs_rq() called by enqueue_task_fair(). I could
reproduce this systematically by applying both [1] and this patch on top
of tag v6.17-rc6 and also by directly testing at commit fe8d238e646e
from sched/core branch of tip tree. I couldn't reproduce the warning by
testing at commmit 5b726e9bf954 ("sched/fair: Get rid of
throttled_lb_pair()").

The test setup is the same used in my previous testing for v3 [2], where
the CFS throttling events are mostly triggered by the first ssh logins
into the system as the systemd user slice is configured with CPUQuota of
25%. Also note that the same systemd user slice is configured with CPU
affinity set to only one core. I added some tracing to trace functions
throttle_cfs_rq, tg_throttle_down, unthrottle_cfs_rq, tg_unthrottle_up,
and it looks like the warning is triggered after the last unthrottle
event, however I'm not sure the warning is actually related to the
printed trace below or not. See the following logs that contains both
the traced function events and the kernel warning.

[   17.859264]  systemd-xdg-aut-1006    [000] dN.2.    17.865040: throttle_cfs_rq <-pick_task_fair
[   17.859264]  systemd-xdg-aut-1006    [000] dN.2.    17.865042: tg_throttle_down <-walk_tg_tree_from
[   17.859264]  systemd-xdg-aut-1006    [000] dN.2.    17.865042: tg_throttle_down <-walk_tg_tree_from
[   17.859264]  systemd-xdg-aut-1006    [000] dN.2.    17.865043: tg_throttle_down <-walk_tg_tree_from
[   17.876999]        ktimers/0-15      [000] d.s13    17.882601: unthrottle_cfs_rq <-distribute_cfs_runtime
[   17.876999]        ktimers/0-15      [000] d.s13    17.882603: tg_unthrottle_up <-walk_tg_tree_from
[   17.876999]        ktimers/0-15      [000] d.s13    17.882605: tg_unthrottle_up <-walk_tg_tree_from
[   17.876999]        ktimers/0-15      [000] d.s13    17.882605: tg_unthrottle_up <-walk_tg_tree_from
[   17.910250]          systemd-999     [000] dN.2.    17.916019: throttle_cfs_rq <-put_prev_entity
[   17.910250]          systemd-999     [000] dN.2.    17.916025: tg_throttle_down <-walk_tg_tree_from
[   17.910250]          systemd-999     [000] dN.2.    17.916025: tg_throttle_down <-walk_tg_tree_from
[   17.910250]          systemd-999     [000] dN.2.    17.916025: tg_throttle_down <-walk_tg_tree_from
[   17.977245]        ktimers/0-15      [000] d.s13    17.982575: unthrottle_cfs_rq <-distribute_cfs_runtime
[   17.977245]        ktimers/0-15      [000] d.s13    17.982578: tg_unthrottle_up <-walk_tg_tree_from
[   17.977245]        ktimers/0-15      [000] d.s13    17.982579: tg_unthrottle_up <-walk_tg_tree_from
[   17.977245]        ktimers/0-15      [000] d.s13    17.982580: tg_unthrottle_up <-walk_tg_tree_from
[   18.009244]          systemd-999     [000] dN.2.    18.015030: throttle_cfs_rq <-pick_task_fair
[   18.009244]          systemd-999     [000] dN.2.    18.015033: tg_throttle_down <-walk_tg_tree_from
[   18.009244]          systemd-999     [000] dN.2.    18.015033: tg_throttle_down <-walk_tg_tree_from
[   18.009244]          systemd-999     [000] dN.2.    18.015033: tg_throttle_down <-walk_tg_tree_from
[   18.076822]        ktimers/0-15      [000] d.s13    18.082607: unthrottle_cfs_rq <-distribute_cfs_runtime
[   18.076822]        ktimers/0-15      [000] d.s13    18.082609: tg_unthrottle_up <-walk_tg_tree_from
[   18.076822]        ktimers/0-15      [000] d.s13    18.082611: tg_unthrottle_up <-walk_tg_tree_from
[   18.076822]        ktimers/0-15      [000] d.s13    18.082611: tg_unthrottle_up <-walk_tg_tree_from
[   18.109820]          systemd-999     [000] dN.2.    18.115604: throttle_cfs_rq <-put_prev_entity
[   18.109820]          systemd-999     [000] dN.2.    18.115609: tg_throttle_down <-walk_tg_tree_from
[   18.109820]          systemd-999     [000] dN.2.    18.115609: tg_throttle_down <-walk_tg_tree_from
[   18.109820]          systemd-999     [000] dN.2.    18.115609: tg_throttle_down <-walk_tg_tree_from
[   18.177167]        ktimers/0-15      [000] d.s13    18.182630: unthrottle_cfs_rq <-distribute_cfs_runtime
[   18.177167]        ktimers/0-15      [000] d.s13    18.182632: tg_unthrottle_up <-walk_tg_tree_from
[   18.177167]        ktimers/0-15      [000] d.s13    18.182633: tg_unthrottle_up <-walk_tg_tree_from
[   18.177167]        ktimers/0-15      [000] d.s13    18.182634: tg_unthrottle_up <-walk_tg_tree_from
[   18.220827]          systemd-999     [000] dN.2.    18.226594: throttle_cfs_rq <-pick_task_fair
[   18.220827]          systemd-999     [000] dN.2.    18.226597: tg_throttle_down <-walk_tg_tree_from
[   18.220827]          systemd-999     [000] dN.2.    18.226597: tg_throttle_down <-walk_tg_tree_from
[   18.220827]          systemd-999     [000] dN.2.    18.226597: tg_throttle_down <-walk_tg_tree_from
[   18.220827]          systemd-999     [000] dN.2.    18.226598: tg_throttle_down <-walk_tg_tree_from
[   18.220827]          systemd-999     [000] dN.2.    18.226598: tg_throttle_down <-walk_tg_tree_from
[   18.220827]          systemd-999     [000] dN.2.    18.226598: tg_throttle_down <-walk_tg_tree_from
[   18.220827]          systemd-999     [000] dN.2.    18.226598: tg_throttle_down <-walk_tg_tree_from
[   18.276886]        ktimers/0-15      [000] d.s13    18.282606: unthrottle_cfs_rq <-distribute_cfs_runtime
[   18.276886]        ktimers/0-15      [000] d.s13    18.282608: tg_unthrottle_up <-walk_tg_tree_from
[   18.276886]        ktimers/0-15      [000] d.s13    18.282610: tg_unthrottle_up <-walk_tg_tree_from
[   18.276886]        ktimers/0-15      [000] d.s13    18.282610: tg_unthrottle_up <-walk_tg_tree_from
[   18.276886]        ktimers/0-15      [000] d.s13    18.282611: tg_unthrottle_up <-walk_tg_tree_from
[   18.276886]        ktimers/0-15      [000] d.s13    18.282611: tg_unthrottle_up <-walk_tg_tree_from
[   18.276886]        ktimers/0-15      [000] d.s13    18.282611: tg_unthrottle_up <-walk_tg_tree_from
[   18.276886]        ktimers/0-15      [000] d.s13    18.282611: tg_unthrottle_up <-walk_tg_tree_from
[   18.421349] ------------[ cut here ]------------
[   18.421350] WARNING: CPU: 0 PID: 1 at kernel/sched/fair.c:400 enqueue_task_fair+0x925/0x980
[   18.421355] Modules linked in: efivarfs
[   18.421360] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.17.0-rc4-00010-gfe8d238e646e #2 PREEMPT_{RT,(full)}
[   18.421362] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
[   18.421364] RIP: 0010:enqueue_task_fair+0x925/0x980
[   18.421366] Code: b5 48 01 00 00 49 89 95 48 01 00 00 49 89 bd 50 01 00 00 48 89 37 48 89 b0 70 0a 00 00 48 89 90 78 0a 00 00 e9 49 fa ff ff 90 <0f> 0b 90 e9 1c f9 ff ff 90 0f 0b 90 e9 59 fa ff ff 48 8b b0 88 0a
[   18.421367] RSP: 0018:ffff9c7c8001fa20 EFLAGS: 00010087
[   18.421369] RAX: ffff9358fdc29da8 RBX: 0000000000000003 RCX: ffff9358fdc29340
[   18.421370] RDX: ffff935881a89000 RSI: 0000000000000000 RDI: 0000000000000003
[   18.421371] RBP: ffff9358fdc293c0 R08: 0000000000000000 R09: 00000000b808a33f
[   18.421371] R10: 0000000000200b20 R11: 0000000011659969 R12: 0000000000000001
[   18.421372] R13: ffff93588214fe00 R14: 0000000000000000 R15: 0000000000200b20
[   18.421375] FS:  00007fb07deddd80(0000) GS:ffff935945f6d000(0000) knlGS:0000000000000000
[   18.421376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.421377] CR2: 00005571bafe12a0 CR3: 00000000024e6000 CR4: 00000000000006f0
[   18.421377] Call Trace:
[   18.421383]  <TASK>
[   18.421387]  enqueue_task+0x31/0x70
[   18.421389]  ttwu_do_activate+0x73/0x220
[   18.421391]  try_to_wake_up+0x2b1/0x7a0
[   18.421393]  ? kmem_cache_alloc_node_noprof+0x7f/0x210
[   18.421396]  ep_autoremove_wake_function+0x12/0x40
[   18.421400]  __wake_up_common+0x72/0xa0
[   18.421402]  __wake_up_sync+0x38/0x50
[   18.421404]  ep_poll_callback+0xd2/0x240
[   18.421406]  __wake_up_common+0x72/0xa0
[   18.421407]  __wake_up_sync_key+0x3f/0x60
[   18.421409]  sock_def_readable+0x42/0xc0
[   18.421414]  unix_dgram_sendmsg+0x48f/0x840
[   18.421420]  ____sys_sendmsg+0x31c/0x350
[   18.421423]  ___sys_sendmsg+0x99/0xe0
[   18.421425]  __sys_sendmsg+0x8a/0xf0
[   18.421429]  do_syscall_64+0xa4/0x260
[   18.421434]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   18.421438] RIP: 0033:0x7fb07e8d4d94
[   18.421439] Code: 15 91 10 0d 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00 f3 0f 1e fa 80 3d d5 92 0d 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
[   18.421440] RSP: 002b:00007ffff30e4d08 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[   18.421442] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb07e8d4d94
[   18.421442] RDX: 0000000000004000 RSI: 00007ffff30e4e80 RDI: 0000000000000031
[   18.421443] RBP: 00007ffff30e5ff0 R08: 00000000000000c0 R09: 0000000000000000
[   18.421443] R10: 00007fb07deddc08 R11: 0000000000000202 R12: 00007ffff30e6070
[   18.421444] R13: 00007ffff30e4f00 R14: 00007ffff30e4d10 R15: 000000000000000f
[   18.421445]  </TASK>
[   18.421446] ---[ end trace 0000000000000000 ]---

[1]: https://lore-kernel.gnuweeb.org/lkml/20250829081120.806-1-ziqianlu@bytedance.com/
[2]: https://lore.kernel.org/lkml/d37fcac575ee94c3fe605e08e6297986@codethink.co.uk/

I hope this is helpful. I'm happy to provide more information or run
additional tests if needed.

Best regards,
Matteo Martelli

