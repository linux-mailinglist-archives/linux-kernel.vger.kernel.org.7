Return-Path: <linux-kernel+bounces-836052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B34BA89E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1701881C91
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7202C1586;
	Mon, 29 Sep 2025 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tFjodEZ6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gcblH3pm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660662C11C7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138147; cv=none; b=eZoXaigPObM8Xa4GUL7kb/VJUDQgXSoBjHj2W/294EQqsT+n87aMhXhto1wQZlhNAwsTqIl3CidoFxQhvvuGwB7dWBidUzcX2xrrlU8iuU1RudpgI1wU3DgwmFfAONciHoIIBYlsv7gcm79u39ssTYykNNDLgaCmdl3YugZIKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138147; c=relaxed/simple;
	bh=BPjzs6etbNRqqSXfN03Q+MeOiC54Vw8AQfJ/WuqQZME=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=qaV+KqhyAZg6KsNVkolxVpeDIcrHfUpaMKk9T5iPHr9avzfRR45aDGDN9aiBoKm8bmMrTQo8+breFeM7obdjQraZ/gEyqNyr5NH2MtbgHbZZ2YJSuETIHEFiQWuo1UXUSn79HQ0KHWIFDdEC9lkf278N94qZIeG+Uam064gJg2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tFjodEZ6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gcblH3pm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759138137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=gy1nxRQ3kwMakASaiPdwQomXgKynGZ1XYDsk71oeyL0=;
	b=tFjodEZ6xvTiwVKmNdQrobCU1pBI9lvGSsWnK6GiKl9pDrpLbe49z7w4KD4J2E8uKGIKjR
	5n6vY6mH1nnLSaM7Sa0LSV2emCoPwHnNGaiZhiIPBLvpaymR9gsXRubbipODCBA+uK841s
	qqkfktnsBRUqheT/qOEhd50BVMOUgF3bqfxdwjgHW2kacB+sqjfuRSMjPO5fx0u23K3y+2
	T20c82zpGQsmbVBdKwUN6eUfJLyOWWjdR6gsdFilSwJiKneRyZSo8A0GYgsfanr/KefZnL
	Dzt/jDAruOjUVnI/u/R4A2PbANUZGNFcWioQFmJ1kH6AqoxRw50YHIdVDygEzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759138137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=gy1nxRQ3kwMakASaiPdwQomXgKynGZ1XYDsk71oeyL0=;
	b=gcblH3pm+yseS4uJJMBhfcM0zhuuO0LFnDyZVA3hX5o3LjhYUyO6W4fuUmHUUS90FuR19I
	XyahxbRWrKQyleCg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/rseq for v6.18-rc1
References: <175913807599.495041.10251515322736195577.tglx@xen13>
Message-ID: <175913807782.495041.6352778133429960068.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Sep 2025 11:28:56 +0200 (CEST)

Linus,

please pull the latest core/rseq branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rseq-2025-0=
9-29

up to:  a001cd248ab2: rseq/selftests: Use weak symbol reference, not definiti=
on, to link with glibc

Two fixes for RSEQ:

  1) Protect the event mask modification against the membarrier() IPI as
     otherwise the RmW operation is unprotected and events might be lost.

  2) Fix the weak symbol reference in rseq selftests

     The current weak RSEQ symbols definitions which were added to allow
     static linkage are not working correctly as the effectively re-define
     the glibc symbols leading to multiple versions of the symbols when
     compiled with -fno-common. Mark them as 'extern' to convert them from
     weak symbol definitions to weak symbol references. That works with
     static and dynamic linkage independent of -fcommon and -fno-common.

Thanks,

	tglx

------------------>
Sean Christopherson (1):
      rseq/selftests: Use weak symbol reference, not definition, to link with=
 glibc

Thomas Gleixner (1):
      rseq: Protect event mask against membarrier IPI


 include/linux/rseq.h                | 11 ++++++++---
 kernel/rseq.c                       | 10 +++++-----
 tools/testing/selftests/rseq/rseq.c |  8 ++++----
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index bc8af3eb5598..1fbeb61babeb 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -7,6 +7,12 @@
 #include <linux/preempt.h>
 #include <linux/sched.h>
=20
+#ifdef CONFIG_MEMBARRIER
+# define RSEQ_EVENT_GUARD	irq
+#else
+# define RSEQ_EVENT_GUARD	preempt
+#endif
+
 /*
  * Map the event mask on the user-space ABI enum rseq_cs_flags
  * for direct mask checks.
@@ -41,9 +47,8 @@ static inline void rseq_handle_notify_resume(struct ksignal=
 *ksig,
 static inline void rseq_signal_deliver(struct ksignal *ksig,
 				       struct pt_regs *regs)
 {
-	preempt_disable();
-	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
-	preempt_enable();
+	scoped_guard(RSEQ_EVENT_GUARD)
+		__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
 	rseq_handle_notify_resume(ksig, regs);
 }
=20
diff --git a/kernel/rseq.c b/kernel/rseq.c
index b7a1ec327e81..2452b7366b00 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -342,12 +342,12 @@ static int rseq_need_restart(struct task_struct *t, u32=
 cs_flags)
=20
 	/*
 	 * Load and clear event mask atomically with respect to
-	 * scheduler preemption.
+	 * scheduler preemption and membarrier IPIs.
 	 */
-	preempt_disable();
-	event_mask =3D t->rseq_event_mask;
-	t->rseq_event_mask =3D 0;
-	preempt_enable();
+	scoped_guard(RSEQ_EVENT_GUARD) {
+		event_mask =3D t->rseq_event_mask;
+		t->rseq_event_mask =3D 0;
+	}
=20
 	return !!event_mask;
 }
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rs=
eq/rseq.c
index 663a9cef1952..dcac5cbe7933 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -40,9 +40,9 @@
  * Define weak versions to play nice with binaries that are statically linked
  * against a libc that doesn't support registering its own rseq.
  */
-__weak ptrdiff_t __rseq_offset;
-__weak unsigned int __rseq_size;
-__weak unsigned int __rseq_flags;
+extern __weak ptrdiff_t __rseq_offset;
+extern __weak unsigned int __rseq_size;
+extern __weak unsigned int __rseq_flags;
=20
 static const ptrdiff_t *libc_rseq_offset_p =3D &__rseq_offset;
 static const unsigned int *libc_rseq_size_p =3D &__rseq_size;
@@ -209,7 +209,7 @@ void rseq_init(void)
 	 * libc not having registered a restartable sequence.  Try to find the
 	 * symbols if that's the case.
 	 */
-	if (!*libc_rseq_size_p) {
+	if (!libc_rseq_size_p || !*libc_rseq_size_p) {
 		libc_rseq_offset_p =3D dlsym(RTLD_NEXT, "__rseq_offset");
 		libc_rseq_size_p =3D dlsym(RTLD_NEXT, "__rseq_size");
 		libc_rseq_flags_p =3D dlsym(RTLD_NEXT, "__rseq_flags");


