Return-Path: <linux-kernel+bounces-868195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8732EC049FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D3B834B12B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B651D798E;
	Fri, 24 Oct 2025 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i9GfFIAu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bKKw5f2M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB05729BDBC
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289699; cv=none; b=JZZiYERhDsp9bBSlqkNM5LK5K9rqmjAKMxa6k50c2CF3Ht9DJI6R3sUgo+u5XB8gPLfJ9eF9aTm43i4pZ/8EwdLqP8sFdxwfBaYnc9Ab9WS4oLqvAMnRmi8zscVJjuFdjc/gMm9NrX0+7CbBMgFRvawrqZwTIncfk6OSq3yLsZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289699; c=relaxed/simple;
	bh=tSccEiZ5nbcLVRXslMFim6mY9G38GT+vZyoKau0M7sw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j6cX09VxRQvsB8vt/Jr5szi28en47LTaRbArA9zzuQYR4gzYZgQDoH5dyLVafxq8xNc8K7gB2C/zgr/v9t90vNOxzKhofCmVGwVxoL3JD9cQtutR61NHBNI7nzPLIRORAIA0rbOI1WUyzn/K+id2IIrBDU2kmqN7pyQhfLwLVp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i9GfFIAu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bKKw5f2M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761289695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MBNjp43Jyd8UoA0/6AaO22zNRc1efCcF7IhiqPfmZQU=;
	b=i9GfFIAudcqYb78QOGvWmGBj4M1giX+ySkag9ZIKb/k6UxafVP79lpKofjzp8mo3dhTr/3
	hhRhT6k1LljXXlMFGKUY3/RrQmgbeSfEmrO5bhm/cC67A2d+MqyjuWY8rhEz1PNHH8B1dq
	EtKBL0sSdv7egBHOaRJwLZZ57MnM3Y9SwNlI/0H9YUClWupasDE6J8HEnOQA9779V+0Cz5
	CnVVoiCvfQCt5fLGAecVPUVuWDghhplWFvnqpeKOorbJhVoDcHim1f1Z38cAkRhOW3a6N7
	cNdMIQg+t8XBYvq26LcDMcfP0VDnLQdAAWoUsuUYdakOIXNERQephNCjd0VssQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761289695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MBNjp43Jyd8UoA0/6AaO22zNRc1efCcF7IhiqPfmZQU=;
	b=bKKw5f2MiTaPQMDFNXdNZv3o+cuPvgCLMN+S48XcA7/Msk3N1mTjjd80kZuALwlQyotzDk
	qaYZJUveEq7vwnAw==
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Mel Gorman <mgorman@suse.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH] smp: Suppress false DEBUG_PREEMPT warning in smp_call_on_cpu()
Date: Fri, 24 Oct 2025 09:07:14 +0200
Message-Id: <20251024070714.4047816-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While booting UP (uniprocessor) kernel with CONFIG_DEBUG_PREEMPT=3Dy, the
following warning is observed:

BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
caller is debug_smp_processor_id+0x1c/0x28
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-rc2-00012-g002733e9=
53a7 #111 PREEMPT_RT
Hardware name: MangoPi MQ Pro (DT)
Call Trace:
    dump_backtrace
    show_stack
    dump_stack_lvl
    dump_stack
    check_preemption_disabled.isra.0
    debug_smp_processor_id
    check_unaligned_access
    smp_call_on_cpu
    check_unaligned_access_all_cpus
    do_one_initcall
    kernel_init_freeable
    kernel_init
    ret_from_fork_kernel
    ret_from_fork_kernel_asm

This is a false warning. The UP-variant of smp_call_on_cpu() simply calls
the callback, and thus debug_smp_processor_id() thinks the context is
unsafe for smp_processor_id(), which is obviously false because this is UP
kernel.

This appears after commit 06ddd17521bf ("sched/smp: Always define
is_percpu_thread() and scheduler_ipi()"). Before this commit,
is_percpu_thread() always returns true on UP kernel and thus
debug_smp_processor_id() always sees a per-cpu thread and never warns. But
now is_percpu_thread() returns false for this case.

Suppress this warning with a migrate_disable()+migrate_enable() pair.

Fixes: 06ddd17521bf ("sched/smp: Always define is_percpu_thread() and sched=
uler_ipi()")
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
grep shows me that the followings also have the same false warning:

    arch/arm64/kernel/watchdog_hld.c
    drivers/hwmon/dell-smm-hwmon.c
    drivers/platform/x86/dell/dcdbas.c
    kernel/watchdog.c
---
 kernel/up.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/up.c b/kernel/up.c
index df50828cc2f0..37c9f0d39b36 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -64,7 +64,14 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *=
), void *par, bool phys)
=20
 	if (phys)
 		hypervisor_pin_vcpu(0);
+
+	/* suppress warnings from debug_smp_processor_id() */
+	migrate_disable();
+
 	ret =3D func(par);
+
+	migrate_enable();
+
 	if (phys)
 		hypervisor_pin_vcpu(-1);
=20
--=20
2.39.5


