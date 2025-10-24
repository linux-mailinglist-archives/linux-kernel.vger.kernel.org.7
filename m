Return-Path: <linux-kernel+bounces-869350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C84A1C07A32
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 324704E9FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA9B32E74C;
	Fri, 24 Oct 2025 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="naGWsj3+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBD5346797
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329221; cv=none; b=XPooYEVeV5okpOU/93xUH4kR9xiJU16+Yn/xFXQMuYfX28z4h/GAxKmQRwAsUX/yOzQqG3s2VnT9ycCCrx8XDnNLHy1iX1kxpCLlaNW4MfUwwMg/EhVvegmhMB6UtKriJDt/ki+BZsTNZW1diaINT4142SNQUhroD7SIvWImYw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329221; c=relaxed/simple;
	bh=4dbeHNED4eGp+XjYHhOa88PwB2OMU1F++ozd+8RTeKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WGyQhwqr0On4WgfFNiOCTpJfIRnfTXINGvxtSv99Apqb+REI8xTmS0LGhqvrDwcXVp8GUxQxKYLCMJoiIiQ0RoPkhmBon2K7kkHyhGjsTBYh3g+d67E1lJB5d8NzJESunXzRgYQAnecJou5Ug8SgvUWICEmLbQijqWyzuvKmJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=naGWsj3+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=iQ1SGm86ECP9CqwUjHOLXwQcPijFjY3Wpo2Cxq+1YU8=; b=naGWsj3+JQNNpNhxNzapcJxmRR
	dSzwKPjc+ZT9tKAK12EgSvNHxtoY6XUVe9mVUDiZGGhVV09mmWaJEX/K4wi0Nl6KpWtQ9itRHWiDy
	tTH1JmJkNN0Oi+BL9pHmmzuFMV57xVLaFUSXeLxaMxUgRMg941i/Av4CRHC/ls4H7nopptKtJ4l4L
	FNWyNQQvUP60ZLVMkeS+BU/Wg/bSK71PGUPGeLnkvH2ASqA2Szc+qp+5FN8PHdfj4/dAnKztv0bzy
	4WL6RnvE3s87Jw/Q9M2u4QAJjL2cWyju8cFC+4Pr5U8jj6UrktoUKCmQix34OQHv638zMLsN3Nv0c
	F6rdEUdw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCMBk-0000000761B-0mgX;
	Fri, 24 Oct 2025 18:06:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Remove in_irq()
Date: Fri, 24 Oct 2025 19:06:51 +0100
Message-ID: <20251024180654.1691095-1-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This old alias for in_hardirq() has been marked as deprecated since
2020; remove the stragglers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/bus/fsl-mc/mc-sys.c | 2 +-
 drivers/md/dm-vdo/logger.c  | 2 +-
 include/linux/lockdep.h     | 2 +-
 include/linux/preempt.h     | 2 --
 kernel/bpf/syscall.c        | 4 ++--
 kernel/time/timer.c         | 2 +-
 lib/locking-selftest.c      | 4 ++--
 7 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/fsl-mc/mc-sys.c b/drivers/bus/fsl-mc/mc-sys.c
index b22c59d57c8f..31037f41893e 100644
--- a/drivers/bus/fsl-mc/mc-sys.c
+++ b/drivers/bus/fsl-mc/mc-sys.c
@@ -248,7 +248,7 @@ int mc_send_command(struct fsl_mc_io *mc_io, struct fsl_mc_command *cmd)
 	enum mc_cmd_status status;
 	unsigned long irq_flags = 0;
 
-	if (in_irq() && !(mc_io->flags & FSL_MC_IO_ATOMIC_CONTEXT_PORTAL))
+	if (in_hardirq() && !(mc_io->flags & FSL_MC_IO_ATOMIC_CONTEXT_PORTAL))
 		return -EINVAL;
 
 	if (mc_io->flags & FSL_MC_IO_ATOMIC_CONTEXT_PORTAL)
diff --git a/drivers/md/dm-vdo/logger.c b/drivers/md/dm-vdo/logger.c
index 3f7dc2cb6b98..76a987ccf926 100644
--- a/drivers/md/dm-vdo/logger.c
+++ b/drivers/md/dm-vdo/logger.c
@@ -34,7 +34,7 @@ static const char *get_current_interrupt_type(void)
 	if (in_nmi())
 		return "NMI";
 
-	if (in_irq())
+	if (in_hardirq())
 		return "HI";
 
 	if (in_softirq())
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 67964dc4db95..dd634103b014 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -616,7 +616,7 @@ do {									\
 #define lockdep_assert_in_softirq()					\
 do {									\
 	WARN_ON_ONCE(__lockdep_enabled			&&		\
-		     (!in_softirq() || in_irq() || in_nmi()));		\
+		     (!in_softirq() || in_hardirq() || in_nmi()));	\
 } while (0)
 
 extern void lockdep_assert_in_softirq_func(void);
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 102202185d7a..d964f965c8ff 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -134,11 +134,9 @@ static __always_inline unsigned char interrupt_context_level(void)
 
 /*
  * The following macros are deprecated and should not be used in new code:
- * in_irq()       - Obsolete version of in_hardirq()
  * in_softirq()   - We have BH disabled, or are processing softirqs
  * in_interrupt() - We're in NMI,IRQ,SoftIRQ context or have BH disabled
  */
-#define in_irq()		(hardirq_count())
 #define in_softirq()		(softirq_count())
 #define in_interrupt()		(irq_count())
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a129746bd6c..6cde6a46babf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2330,7 +2330,7 @@ static void bpf_audit_prog(const struct bpf_prog *prog, unsigned int op)
 		return;
 	if (audit_enabled == AUDIT_OFF)
 		return;
-	if (!in_irq() && !irqs_disabled())
+	if (!in_hardirq() && !irqs_disabled())
 		ctx = audit_context();
 	ab = audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
 	if (unlikely(!ab))
@@ -2428,7 +2428,7 @@ static void __bpf_prog_put(struct bpf_prog *prog)
 	struct bpf_prog_aux *aux = prog->aux;
 
 	if (atomic64_dec_and_test(&aux->refcnt)) {
-		if (in_irq() || irqs_disabled()) {
+		if (in_hardirq() || irqs_disabled()) {
 			INIT_WORK(&aux->work, bpf_prog_put_deferred);
 			schedule_work(&aux->work);
 		} else {
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 553fa469d7cc..282a8e5c05f8 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2472,7 +2472,7 @@ void update_process_times(int user_tick)
 	run_local_timers();
 	rcu_sched_clock_irq(user_tick);
 #ifdef CONFIG_IRQ_WORK
-	if (in_irq())
+	if (in_hardirq())
 		irq_work_tick();
 #endif
 	sched_tick();
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index ed99344317f5..d939403331b5 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -202,7 +202,7 @@ static void init_shared_classes(void)
 	local_irq_disable();			\
 	__irq_enter();				\
 	lockdep_hardirq_threaded();		\
-	WARN_ON(!in_irq());
+	WARN_ON(!in_hardirq());
 
 #define HARDIRQ_EXIT()				\
 	__irq_exit();				\
@@ -2512,7 +2512,7 @@ DEFINE_LOCK_GUARD_0(NOTTHREADED_HARDIRQ,
 	do {
 		local_irq_disable();
 		__irq_enter();
-		WARN_ON(!in_irq());
+		WARN_ON(!in_hardirq());
 	} while(0), HARDIRQ_EXIT())
 DEFINE_LOCK_GUARD_0(SOFTIRQ, SOFTIRQ_ENTER(), SOFTIRQ_EXIT())
 
-- 
2.47.2


