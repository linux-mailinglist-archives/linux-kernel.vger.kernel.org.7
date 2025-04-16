Return-Path: <linux-kernel+bounces-606871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84513A8B4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 11:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090CC1901D96
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A507B235360;
	Wed, 16 Apr 2025 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl3+WYgm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE262238162
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794372; cv=none; b=dtPCQno1a1OstDQVUcttCSPd4g1Y0CQK3wPqD3HGrR6oxWyjz/qV+nHwCfpVDAUXH2bdTGkBpG7g31XbiOP1Njwdh2zQ6FnCJYAfsguah8W4rNWZ0avhfV7OqAh0Yiucbqu+twdTBiHzk+/Sy0XLshD0zlj6jF3nDLWFzGlxIzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794372; c=relaxed/simple;
	bh=Oz3Y3nAAMFIppzQALcsjAthE5P2AUJWhvlznY6W2UpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPmxu/LS3WuEqVFTfntVTbej7JRyQm5mJE+6fJhkFu4P8w7AdRmW04yzxLKRubO04C7on+cKJyybG0/mbpRsi/pnuKsJ0I09W5gPfNHUMh53BQ2eHWh/9REYUKGMrCCS9j5vaUOj5NX6Sex0OEI5jwz2cLTABC7b1lV/Nxi1EFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl3+WYgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2DFC4CEE2;
	Wed, 16 Apr 2025 09:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744794371;
	bh=Oz3Y3nAAMFIppzQALcsjAthE5P2AUJWhvlznY6W2UpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hl3+WYgmcg3LYwuOV1ktnrJxsi/AfyLttK2o8RfH/9igCOu7L9Lt89TnkMS7dYusk
	 UJ4d8D99SLcxCDB2OP+ebqdOg8v+fcsqOQzsByOzWu/0mnYK3hzqa+RICaRDoKYIrP
	 lMooB3LeJYjEhoyUsTU5W95/a3HkeFXhsfYoQs4/vtZi3cqsb5wuJZLg/ZDnJuFwZR
	 D3gA2Q1jstph+qryU7OvsK/e2EUHezqLTBw14zvY8R7Jrh88kUPIVt4t/OBpaVm4S4
	 X6dpsgNozIyqcu192HonX/cB9sLHXTLwhYbdlDHiDxM23oE5XfN9uOPeVDqQOGQQqM
	 r4oSyTrhy6pNQ==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 09/10] treewide, timers: Rename NEXT_TIMER_MAX_DELTA => TIMER_NEXT_MAX_DELTA
Date: Wed, 16 Apr 2025 11:05:43 +0200
Message-ID: <20250416090544.3311613-10-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250416090544.3311613-1-mingo@kernel.org>
References: <20250416090544.3311613-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move this macro to the canonical TIMER_* namespace.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/powerpc/kvm/booke.c |  8 ++++----
 include/linux/timer.h    |  2 +-
 kernel/time/timer.c      | 12 ++++++------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index e56f78b4760a..3401b96be475 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -572,7 +572,7 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
 
 /*
  * Return the number of jiffies until the next timeout.  If the timeout is
- * longer than the NEXT_TIMER_MAX_DELTA, then return NEXT_TIMER_MAX_DELTA
+ * longer than the TIMER_NEXT_MAX_DELTA, then return TIMER_NEXT_MAX_DELTA
  * because the larger value can break the timer APIs.
  */
 static unsigned long watchdog_next_timeout(struct kvm_vcpu *vcpu)
@@ -598,7 +598,7 @@ static unsigned long watchdog_next_timeout(struct kvm_vcpu *vcpu)
 	if (do_div(nr_jiffies, tb_ticks_per_jiffy))
 		nr_jiffies++;
 
-	return min_t(unsigned long long, nr_jiffies, NEXT_TIMER_MAX_DELTA);
+	return min_t(unsigned long long, nr_jiffies, TIMER_NEXT_MAX_DELTA);
 }
 
 static void arm_next_watchdog(struct kvm_vcpu *vcpu)
@@ -616,10 +616,10 @@ static void arm_next_watchdog(struct kvm_vcpu *vcpu)
 	spin_lock_irqsave(&vcpu->arch.wdt_lock, flags);
 	nr_jiffies = watchdog_next_timeout(vcpu);
 	/*
-	 * If the number of jiffies of watchdog timer >= NEXT_TIMER_MAX_DELTA
+	 * If the number of jiffies of watchdog timer >= TIMER_NEXT_MAX_DELTA
 	 * then do not run the watchdog timer as this can break timer APIs.
 	 */
-	if (nr_jiffies < NEXT_TIMER_MAX_DELTA)
+	if (nr_jiffies < TIMER_NEXT_MAX_DELTA)
 		mod_timer(&vcpu->arch.wdt_timer, jiffies + nr_jiffies);
 	else
 		timer_delete(&vcpu->arch.wdt_timer);
diff --git a/include/linux/timer.h b/include/linux/timer.h
index fedd9f3d5dbc..ab025aa7cce1 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -156,7 +156,7 @@ extern int timer_reduce(struct timer_list *timer, unsigned long expires);
  * The jiffies value which is added to now, when there is no timer
  * in the timer wheel:
  */
-#define NEXT_TIMER_MAX_DELTA	((1UL << 30) - 1)
+#define TIMER_NEXT_MAX_DELTA	((1UL << 30) - 1)
 
 extern void add_timer(struct timer_list *timer);
 extern void add_timer_local(struct timer_list *timer);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9d918c8b4990..fa2782eb6931 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1900,7 +1900,7 @@ static void timer_recalc_next_expiry(struct timer_base *base)
 	unsigned long clk, next, adj;
 	unsigned lvl, offset = 0;
 
-	next = base->clk + NEXT_TIMER_MAX_DELTA;
+	next = base->clk + TIMER_NEXT_MAX_DELTA;
 	clk = base->clk;
 	for (lvl = 0; lvl < LVL_DEPTH; lvl++, offset += LVL_SIZE) {
 		int pos = next_pending_bucket(base, offset, clk & LVL_MASK);
@@ -1963,7 +1963,7 @@ static void timer_recalc_next_expiry(struct timer_base *base)
 
 	WRITE_ONCE(base->next_expiry, next);
 	base->next_expiry_recalc = false;
-	base->timers_pending = !(next == base->clk + NEXT_TIMER_MAX_DELTA);
+	base->timers_pending = !(next == base->clk + TIMER_NEXT_MAX_DELTA);
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -2015,7 +2015,7 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 	 * easy comparable to find out which base holds the first pending timer.
 	 */
 	if (!base->timers_pending)
-		WRITE_ONCE(base->next_expiry, basej + NEXT_TIMER_MAX_DELTA);
+		WRITE_ONCE(base->next_expiry, basej + TIMER_NEXT_MAX_DELTA);
 
 	return base->next_expiry;
 }
@@ -2399,7 +2399,7 @@ static inline void __run_timers(struct timer_base *base)
 		 * timer at this clk are that all matching timers have been
 		 * dequeued or no timer has been queued since
 		 * base::next_expiry was set to base::clk +
-		 * NEXT_TIMER_MAX_DELTA.
+		 * TIMER_NEXT_MAX_DELTA.
 		 */
 		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
 			     && base->timers_pending);
@@ -2544,7 +2544,7 @@ int timers_prepare_cpu(unsigned int cpu)
 	for (b = 0; b < NR_BASES; b++) {
 		base = per_cpu_ptr(&timer_bases[b], cpu);
 		base->clk = jiffies;
-		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
+		base->next_expiry = base->clk + TIMER_NEXT_MAX_DELTA;
 		base->next_expiry_recalc = false;
 		base->timers_pending = false;
 		base->is_idle = false;
@@ -2599,7 +2599,7 @@ static void __init init_timer_cpu(int cpu)
 		base->cpu = cpu;
 		raw_spin_lock_init(&base->lock);
 		base->clk = jiffies;
-		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
+		base->next_expiry = base->clk + TIMER_NEXT_MAX_DELTA;
 		timer_base_init_expiry_lock(base);
 	}
 }
-- 
2.45.2


