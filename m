Return-Path: <linux-kernel+bounces-874292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDCBC15F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9DE34E0F45
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95693469FD;
	Tue, 28 Oct 2025 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LinaYz7K"
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42802346A07
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670293; cv=none; b=JjImUj6tOgp1eBf8CWXdN4gHcaoAasGC5U28v4jfGIqne0FrW5VR/DTMMi5dYA3Mtg/8xoiN8qCVtISvC55NUhKxboZNrAps4JGDKkcVfa0uhmT31WQre8K6HEI4h5MRqxDq055daV4IsImwjzkPPwSMTmPbjLDOVUZ6Ja9668U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670293; c=relaxed/simple;
	bh=OE90M9SHvSvA5l+RUGUmFGhl1wN6mpUlGaLpcv1TQ34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Th6vdE7SjEz0HDy22jfuc4Gr/0yrOOCRaCKasBHDr1qiR7/kF8O2Xgf1eVTzX3C0nsBR5nzn9e0wf6DshTQXsS0vDyPwvEM4OlWXNJTiOsRxbw2TwJ95TPSDYhw3AYJx/0BLkAmx+U44xe34clCz1O8QJKVRmO1AEnLHzVzpsV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LinaYz7K; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cwxGn4znYzlw64j;
	Tue, 28 Oct 2025 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1761670288; x=1764262289; bh=LRIWt
	bqd2ihm9tZ3zwb7WJ9jCre/CeGZGkQVe3N0vl8=; b=LinaYz7KOQaC0R/idTQjt
	YVU+VZRCk9PwvStRq1cadB+p651+1VJmelqxmEd9V88r2xaBC0RKv1weVHA/xQ1V
	DUtJ1r9tmM3MURwgqlLbJ00sSs3xqzkjGDoCvNaEYVen9g4SMreFTd1h3I43ieLX
	aOJPuKOpkxUOf8e32wO6JKVTR7JtFxwL3bpT80z5Jwe6cWlaKtMq9eJfY1uoyR6w
	g6Rkp5U7PqrkPpYpgAw1pQN4pybjxOfkB/Wt0zX0EIOFxP4+nYSVpLh1Jv9OD53g
	2vPkjr5NGVLpinXIJvGHFSBAaguIY5cvl83ICBDu9+RDpLfb4Lf7zJol9G3vnE8a
	A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tWl5qD0_qmiF; Tue, 28 Oct 2025 16:51:28 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cwxGf0dPczlvm7H;
	Tue, 28 Oct 2025 16:51:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/2] Fix SCHED_WARN_ON()
Date: Tue, 28 Oct 2025 09:50:58 -0700
Message-ID: <20251028165059.682306-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
In-Reply-To: <20251028165059.682306-1-bvanassche@acm.org>
References: <20251028165059.682306-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SCHED_WARN_ON() uses WARN_ONCE() and WARN_ONCE() uses printk(). Using
printk() from certain code paths in the process scheduler is not allowed
because printk() acquires the console_lock and this may cause printk()
to sleep. Sleeping is not allowed from many paths in the process
scheduler. Hence make sure that SCHED_WARN_ON() uses printk_deferred()
instead of printk().

Here is an example of a lockdep complaint fixed by this patch:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
------------------------------------------------------
swapper/4/0 is trying to acquire lock:
ffffffc082179768 (console_owner){-...}-{0:0}, at: console_lock_spinning_e=
nable+0x44/0x80

but task is already holding lock:
ffffff8b33d30a18 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x188/0x116c

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #5 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x50/0x70
       __task_rq_lock+0x74/0x154
       wake_up_new_task+0x110/0x40c
       kernel_clone+0x28c/0x508
       user_mode_thread+0x60/0x8c
       rest_init+0x28/0x1b8
       start_kernel+0x390/0x4b0

-> #4 (&p->pi_lock){-.-.}-{2:2}:
       _raw_spin_lock_irqsave+0x64/0xac
       try_to_wake_up+0x6c/0xa18
       default_wake_function+0x20/0x38
       autoremove_wake_function+0x1c/0x64
       __wake_up+0xac/0xfc
       rpm_suspend+0x484/0x668
       pm_runtime_work+0x8c/0xa8
       process_one_work+0x26c/0x65c
       worker_thread+0x33c/0x498
       kthread+0x110/0x134
       ret_from_fork+0x10/0x20

-> #3 (&dev->power.wait_queue){....}-{2:2}:
       _raw_spin_lock_irqsave+0x64/0xac
       __wake_up+0x34/0xfc
       rpm_resume+0x4e8/0x5c8
       __pm_runtime_resume+0x6c/0xb0
       dt_idle_attach_cpu+0x70/0x9c
       psci_cpuidle_probe+0x270/0x494
       platform_probe+0xa0/0xe0
       really_probe+0x114/0x454
       __driver_probe_device+0xa4/0x160
       driver_probe_device+0x44/0x23c
       __device_attach_driver+0x15c/0x1f4
       bus_for_each_drv+0x10c/0x168
       __device_attach+0xc0/0x1a0
       device_initial_probe+0x14/0x24
       bus_probe_device+0x94/0x120
       device_add+0x298/0x498
       platform_device_add+0x80/0x24c
       platform_device_register_full+0x144/0x154
       psci_idle_init+0x74/0xc4
       do_one_initcall+0x124/0x464
       do_initcall_level+0xa8/0xd4
       do_initcalls+0x74/0xf0
       do_basic_setup+0x1c/0x28
       kernel_init_freeable+0x154/0x204
       kernel_init+0x20/0x1ac

-> #2 (&dev->power.lock){-.-.}-{2:2}:
       _raw_spin_lock_irqsave+0x64/0xac
       __pm_runtime_resume+0x5c/0xb0
       __uart_start+0x4c/0x120
       uart_write+0xe8/0x304
       n_tty_write+0x310/0x4c8
       file_tty_write+0x154/0x32c
       redirected_tty_write+0x94/0xe0
       vfs_write+0x2e8/0x3ac
       ksys_write+0x78/0xe8
       __arm64_sys_write+0x1c/0x2c
       invoke_syscall+0x58/0x10c
       el0_svc_common+0xa8/0xdc
       do_el0_svc+0x1c/0x28
       el0_svc+0x50/0xd4

-> #1 (&port_lock_key){-...}-{2:2}:
       _raw_spin_lock_irqsave+0x64/0xac
       google_serial8250_console_write+0xe0/0x8f0 [google_8250_base]
       univ8250_console_write+0x2c/0x40 [google_8250]
       console_flush_all+0x210/0x420
       console_unlock+0x84/0x12c
       vprintk_emit+0x12c/0x1b8
       vprintk_default+0x44/0x70
       vprintk+0xe4/0x164
       _printk+0x54/0x80
       register_console+0x428/0x524
       serial_core_register_port+0x664/0x8b8
       serial_ctrl_register_port+0x10/0x20
       uart_add_one_port+0x10/0x20
       google_serial8250_register_8250_port+0x834/0xa1c [google_8250]
       dw8250_probe+0x550/0x5f0 [google_8250_dw]
       platform_probe+0xa0/0xe0
       really_probe+0x114/0x454
       __driver_probe_device+0xa4/0x160
       driver_probe_device+0x44/0x23c
       __driver_attach+0x124/0x278
       bus_for_each_dev+0x104/0x160
       driver_attach+0x24/0x34
       bus_add_driver+0x144/0x2d4
       driver_register+0x68/0x104
       __platform_driver_register+0x20/0x30
       do_one_initcall+0x124/0x464
       do_init_module+0x58/0x2f4
       load_module+0x12c8/0x14b0
       __arm64_sys_finit_module+0x238/0x33c
       invoke_syscall+0x58/0x10c
       el0_svc_common+0xa8/0xdc
       do_el0_svc+0x1c/0x28
       el0_svc+0x50/0xd4

-> #0 (console_owner){-...}-{0:0}:
       __lock_acquire+0x150c/0x2e24
       lock_acquire+0x13c/0x2f0
       console_lock_spinning_enable+0x6c/0x80
       console_flush_all+0x1dc/0x420
       console_unlock+0x84/0x12c
       vprintk_emit+0x12c/0x1b8
       vprintk_default+0x44/0x70
       vprintk+0xe4/0x164
       _printk+0x54/0x80
       __warn_printk+0x10c/0x1d4
       sub_running_bw+0x164/0x1a8
       task_non_contending+0x29c/0x4b0
       dequeue_dl_entity+0x1f0/0x260
       pick_task_dl+0x7c/0x1c4
       __schedule+0x554/0x116c
       schedule_idle+0x24/0x48
       do_idle+0x2f0/0x338
       cpu_startup_entry+0x34/0x3c

other info that might help us debug this:

Chain exists of:
  console_owner --> &p->pi_lock --> &rq->__lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rq->__lock);
                               lock(&p->pi_lock);
                               lock(&rq->__lock);
  lock(console_owner);

 *** DEADLOCK ***

3 locks held by swapper/4/0:
 #0: ffffff8b33d30a18 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0x188/0x1=
16c
 #1: ffffffc082179790 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0x124/=
0x1b8
 #2: ffffffc082109238 (console_srcu){....}-{0:0}, at: rcu_try_lock_acquir=
e+0x0/0x40

stack backtrace:
Call trace:
 dump_backtrace+0xfc/0x17c
 show_stack+0x18/0x28
 dump_stack_lvl+0x40/0x104
 dump_stack+0x18/0x3c
 print_circular_bug+0x32c/0x334
 check_noncircular+0x158/0x178
 __lock_acquire+0x150c/0x2e24
 lock_acquire+0x13c/0x2f0
 console_lock_spinning_enable+0x6c/0x80
 console_flush_all+0x1dc/0x420
 console_unlock+0x84/0x12c
 vprintk_emit+0x12c/0x1b8
 vprintk_default+0x44/0x70
 vprintk+0xe4/0x164
 _printk+0x54/0x80
 __warn_printk+0x10c/0x1d4
 sub_running_bw+0x164/0x1a8
 task_non_contending+0x29c/0x4b0
 dequeue_dl_entity+0x1f0/0x260
 pick_task_dl+0x7c/0x1c4
 __schedule+0x554/0x116c
 schedule_idle+0x24/0x48
 do_idle+0x2f0/0x338
 cpu_startup_entry+0x34/0x3c
 secondary_start_kernel+0x138/0x1a8
 __secondary_switched+0xc0/0xc4

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/sched/sched.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e289d364459e..34a9c473104a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -91,7 +91,21 @@ struct cpuidle_state;
 #include "cpupri.h"
 #include "cpudeadline.h"
=20
-#define SCHED_WARN_ON(x) WARN_ONCE(x, #x)
+#define SCHED_WARN_ON(x)				\
+	({						\
+		bool __ret =3D (x);			\
+							\
+		if (unlikely(__ret)) {			\
+			unsigned long __flags;		\
+							\
+			local_irq_save(__flags);	\
+			printk_deferred_enter();	\
+			WARN_ONCE(__ret, #x);		\
+			printk_deferred_exit();		\
+			local_irq_restore(__flags);	\
+		}					\
+		unlikely(__ret);			\
+	})
=20
 /* task_struct::on_rq states: */
 #define TASK_ON_RQ_QUEUED	1

