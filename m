Return-Path: <linux-kernel+bounces-859162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F286BECEB4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 13:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3819B4E6EE0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01E91E00A0;
	Sat, 18 Oct 2025 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8LcK6J+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A401891AB
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760787302; cv=none; b=eSwpy/tI4sOvR+dh4Rt4HEoQxrk2MR5PS4lyEH0mrx3cl98e+HqAqxIOq3C3+4FTZPtszeANwzFjP2INf3bF4QmAhEFFU670XYKU6wV4cVQZjdpJkb7dsDavcHK05msZE2Ic1vS04urL3XCuDaeMEIe3N3lpskSokgYwfCZRLMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760787302; c=relaxed/simple;
	bh=2HOj/xzKhcO8s4sqeEqwsRiLEwIcFjk5Y3X2Ol/ZICk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Wz8w6Eke3fFjHB1r9Gj+NlzSj8QCsPKmka5+VRTtcmHdU24Hgjxsb4PNI0te0MimEZggL5kJrwnX4W+ASB/5vFqdvfrprMg+9ZcbdoA7BSsH9TkFxDYaDH+2EEewy/4BZXrIzpLS1O29zhuBrSjvwaZ/fCdlxT923hcSMrBNsBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S8LcK6J+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760787298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=G9/JHrzXmAgdFgKt0xgGfmf/DuE+Fs6aLIAKhwVZ77E=;
	b=S8LcK6J+GMilfWnhG3FwAVlwY7AQ7LInMyXlYHYp17shBN9slzUUKLv1zJBj40N+xiJZ+j
	z556dS41n/1JrUQ1V/dU0Li5IuKdx8yOLcwtdQmAeXjwulozj/9PbYdu+TBaMXamla3Sv3
	KItv/b0DIb6DaJPL+RJ+nAIbH7QnkCs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-ZcRzIoybNWCaXpmV_1ZKfg-1; Sat,
 18 Oct 2025 07:34:57 -0400
X-MC-Unique: ZcRzIoybNWCaXpmV_1ZKfg-1
X-Mimecast-MFC-AGG-ID: ZcRzIoybNWCaXpmV_1ZKfg_1760787295
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13A541800245;
	Sat, 18 Oct 2025 11:34:55 +0000 (UTC)
Received: from localhost (unknown [10.22.88.15])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 982A31800446;
	Sat, 18 Oct 2025 11:34:53 +0000 (UTC)
Date: Sat, 18 Oct 2025 08:34:52 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Phil Auld <pauld@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Shizhao Chen <shichen@redhat.com>, linux-kernel@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>, Xuewen Yan <xuewen.yan@unisoc.com>
Subject: sched: update_entity_lag does not handle corner case with task in PI
 chain
Message-ID: <aPN7XBJbGhdWJDb2@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello!

The underlying question here is what is the expected behavior of
update_entity_lag() in the context explained below...


--[ Short Description:

While running sched_group_migration test from CKI repository[1], which
migrates tasks between cpusets, Shizhao Chen reports hitting the warning
in update_entity_lag():

    WARN_ON_ONCE(!se->on_rq);

In short, update_entity_lag() is acting on a task that is waiting on a lock,
sleeping, with both on_rq and se->on_rq equal to zero.

When a stalled RCU grace period occurs, rcu_boost_kthread() is called. If an
rt_mutex is involved in the process, rt_mutex_setprio() is called and may
eventually walk down a Priority Inheritance chain, adjusting the priorities
of the waiters in the chain. In such cases update_entity_lag() may be called.

What is the expected behavior for this case, to bail out of update_entity_lag()
or avoid calling the function entirely?


--[ Additional Notes:

Reproducing the Problem:

  - Install sched_group_migration[1] and run it on a loop.
    (while : ;  do runtest.sh; done)
  - In my experience, running the test with 4 CPUs reproduces the problem
    within 15 minutes. Setting "nr_cpus=4 max_cpus=4" on boot does the trick.


The scenario below is a simplification of the cases I observed while
investigating the problem:

    CPUn					CPUx

    task01 has rcu-state lock
    contends on another lock		
    (goes to sleep)
    --> on_rq=0 se.on_rq=0
					rcub/x contends on rcu-state lock
					  rcu_boost_kthread()
					    rt_set_prio()
					      update_entity_lag(task01->se)
					        WARNING()


It could be that task01 and the task holding the lock wanted by task01 are
being migrated from one cpuset to another at that point. In any case, that
is not an error, so the problem seems to be update_entity_lag() being called
to work on a task that hurts a basic requirement (!se->on_rq).


The resulting backtrace is:

[ 1805.450470] ------------[ cut here ]------------
[ 1805.450474] WARNING: CPU: 2 PID: 19 at kernel/sched/fair.c:697 update_entity_lag+0x5b/0x70
[ 1805.463366] Modules linked in: intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common skx_edac skx_edac_common nfit libnvdimm x86_pkg_temp_th
ermal intel_powerclamp coretemp kvm_intel kvm platform_profile dell_wmi sparse_keymap rfkill irqbypass iTCO_wdt video mgag200 rapl iTCO_vendor_support dell_smbios ipmi_ssif in
tel_cstate vfat dcdbas wmi_bmof intel_uncore dell_wmi_descriptor pcspkr fat i2c_algo_bit lpc_ich mei_me i2c_i801 i2c_smbus mei intel_pch_thermal ipmi_si acpi_power_meter acpi_
ipmi ipmi_devintf ipmi_msghandler sg fuse loop xfs sd_mod i40e ghash_clmulni_intel libie libie_adminq ahci libahci tg3 libata wmi sunrpc dm_mirror dm_region_hash dm_log dm_mod
 nfnetlink
[ 1805.525160] CPU: 2 UID: 0 PID: 19 Comm: rcub/0 Kdump: loaded Not tainted 6.17.1-rt5 #1 PREEMPT_RT 
[ 1805.534113] Hardware name: Dell Inc. PowerEdge R440/0WKGTH, BIOS 2.21.1 03/07/2024
[ 1805.541678] RIP: 0010:update_entity_lag+0x5b/0x70
[ 1805.546385] Code: 42 f8 48 81 3b 00 00 10 00 75 23 48 89 fa 48 f7 da 48 39 ea 48 0f 4c d5 48 39 fd 48 0f 4d d7 48 89 53 78 5b 5d c3 cc cc cc cc <0f> 0b eb b1 48 89 de e8 b9
 8c ff ff 48 89 c7 eb d0 0f 1f 40 00 90
[ 1805.565130] RSP: 0000:ffffcc9e802f7b90 EFLAGS: 00010046
[ 1805.570358] RAX: 0000000000000000 RBX: ffff8959080c0080 RCX: 0000000000000000
[ 1805.577488] RDX: 0000000000000000 RSI: ffff8959080c0080 RDI: ffff895592cc1c00
[ 1805.584622] RBP: ffff895592cc1c00 R08: 0000000000008800 R09: 0000000000000000
[ 1805.591756] R10: 0000000000000001 R11: 0000000000200b20 R12: 000000000000000e
[ 1805.598886] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1805.606020] FS:  0000000000000000(0000) GS:ffff895947da2000(0000) knlGS:0000000000000000
[ 1805.614107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1805.619853] CR2: 00007f655816ed40 CR3: 00000004ab854006 CR4: 00000000007726f0
[ 1805.626985] PKRU: 55555554
[ 1805.629696] Call Trace:
[ 1805.632150]  <TASK>
[ 1805.634258]  dequeue_entity+0x90/0x4f0
[ 1805.638012]  dequeue_entities+0xc9/0x6b0
[ 1805.641935]  dequeue_task_fair+0x8a/0x190
[ 1805.645949]  ? sched_clock+0x10/0x30
[ 1805.649527]  rt_mutex_setprio+0x318/0x4b0
[ 1805.653541]  rt_mutex_adjust_prio_chain+0x71c/0xa40
[ 1805.658421]  task_blocks_on_rt_mutex.constprop.0+0x20c/0x4a0
[ 1805.664081]  __rt_mutex_slowlock.constprop.0+0x53/0x1d0
[ 1805.669305]  __rt_mutex_slowlock_locked.constprop.0+0x48/0x70
[ 1805.675051]  rt_mutex_slowlock.constprop.0+0x4d/0xd0
[ 1805.680016]  rcu_boost_kthread+0xd5/0x2d0
[ 1805.684030]  ? __pfx_rcu_boost_kthread+0x10/0x10
[ 1805.688646]  kthread+0x108/0x250
[ 1805.691880]  ? migrate_enable+0xd1/0xf0
[ 1805.695719]  ? __pfx_kthread+0x10/0x10
[ 1805.699473]  ret_from_fork+0x116/0x130
[ 1805.703226]  ? __pfx_kthread+0x10/0x10
[ 1805.706978]  ret_from_fork_asm+0x1a/0x30
[ 1805.710908]  </TASK>


Please let me know if what I reported above is enough to understand the problem
and design/suggest a solution. I tried to organize the scattered information
bits as well as possible.

Best regards,
Luis

[1] https://gitlab.com/cki-project/kernel-tests/-/archive/main/kernel-tests-main.zip#general/scheduler/sched_group_migration/


