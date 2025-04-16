Return-Path: <linux-kernel+bounces-606865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035F4A8B4BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 11:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5D3D7A8EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75F02356B6;
	Wed, 16 Apr 2025 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZHRrteu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE68235368
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794359; cv=none; b=Qv/7rhL6fBlUhZdhZxaijQYzrjKk40r6UMYvW3Jdu0ZZoQ06oOcYFsGc2J+pQ4T+wOFPXLgHCDFqTFks/jgBvMRNAkaQJPeFkgMdjLUzubUNC2fJ0zeTVhY6016XYkcWWvrLKxQub2RuzUwTjJLFzFzyEKPH4cOpHR01EB2SP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794359; c=relaxed/simple;
	bh=GM2lvG63aDQnKhf5nvfBhExF/cBPzxtOrz+DdyFBirY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElZ92pMLgTs2NUtAYi1SXg1FjUUB31JB4P/BQt/d4ehjTFeNbpwnY0vbubMdXsumNpdYWwfaWbPSIHyISSWoWRIBJl8F+yU6kEoE/pPa0DkHxxNKNj8yBLOZOkeq5S/LTgzvS/oM6A06TjLWLqkOtHPOgwEudCjsMDulDyqAUlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZHRrteu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C169BC4CEEE;
	Wed, 16 Apr 2025 09:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744794358;
	bh=GM2lvG63aDQnKhf5nvfBhExF/cBPzxtOrz+DdyFBirY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mZHRrteuSF24WlSCPjyPsVqS14o8gU7r5rL/p8upc64DrqLIzGmZ4c0oGrHdYs9bl
	 oK+6EW0n5UxohxILbvSoVmGC6WMqEuEYeH9ci/ICRQ7T2RdgE0OwbqEMH9aRda1+22
	 FkG/B8h0r+HmRDqDzG3oKcvC/EP8pLYnJln5NcHTDNzUSwlvM9b4sr4K+yZdc7Omfw
	 DDHBvHiRmMnoZKYqv4NbwiHvsAG/vOXSbB8e3QGB6vtRFx31ARkFB753GE8yM133yi
	 KgAUI3vWYvbRCvvU4cvyigGx12SNDyZZ2qJIWn8cmQuhkpuUhCItgk2Q00at4lqR6l
	 calcC3Cxf9PNw==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 03/10] treewide, timers: Rename try_to_del_timer_sync() => timer_delete_sync_try()
Date: Wed, 16 Apr 2025 11:05:37 +0200
Message-ID: <20250416090544.3311613-4-mingo@kernel.org>
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

Move this API to the canonical timer_*() namespace.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/apic/vector.c           |  2 +-
 drivers/char/random.c                   |  4 ++--
 drivers/irqchip/irq-riscv-imsic-state.c |  2 +-
 include/linux/timer.h                   |  2 +-
 kernel/time/timer.c                     |  6 +++---
 net/bridge/br_multicast.c               | 16 ++++++++--------
 sound/pci/ctxfi/cttimer.c               |  2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index fee42a73d64a..93069b13d3af 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -864,7 +864,7 @@ void lapic_offline(void)
 	__vector_cleanup(cl, false);
 
 	irq_matrix_offline(vector_matrix);
-	WARN_ON_ONCE(try_to_del_timer_sync(&cl->timer) < 0);
+	WARN_ON_ONCE(timer_delete_sync_try(&cl->timer) < 0);
 	WARN_ON_ONCE(!hlist_empty(&cl->head));
 
 	unlock_vector_lock();
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38f2fab29c56..4ea4dccc7c46 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1311,9 +1311,9 @@ static void __cold try_to_generate_entropy(void)
 	while (!crng_ready() && !signal_pending(current)) {
 		/*
 		 * Check !timer_pending() and then ensure that any previous callback has finished
-		 * executing by checking try_to_del_timer_sync(), before queueing the next one.
+		 * executing by checking timer_delete_sync_try(), before queueing the next one.
 		 */
-		if (!timer_pending(&stack->timer) && try_to_del_timer_sync(&stack->timer) >= 0) {
+		if (!timer_pending(&stack->timer) && timer_delete_sync_try(&stack->timer) >= 0) {
 			struct cpumask timer_cpus;
 			unsigned int num_cpus;
 
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index bdf5cd2037f2..c39e573825d4 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -564,7 +564,7 @@ void imsic_state_offline(void)
 	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
 
 	raw_spin_lock_irqsave(&lpriv->lock, flags);
-	WARN_ON_ONCE(try_to_del_timer_sync(&lpriv->timer) < 0);
+	WARN_ON_ONCE(timer_delete_sync_try(&lpriv->timer) < 0);
 	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
 #endif
 }
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 8ead870b57d0..6e249ef81e59 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -162,7 +162,7 @@ extern void add_timer(struct timer_list *timer);
 extern void add_timer_local(struct timer_list *timer);
 extern void add_timer_global(struct timer_list *timer);
 
-extern int try_to_del_timer_sync(struct timer_list *timer);
+extern int timer_delete_sync_try(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
 extern int timer_delete(struct timer_list *timer);
 extern int timer_shutdown_sync(struct timer_list *timer);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4d915c0a263c..827fa262093f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1511,7 +1511,7 @@ static int __try_to_del_timer_sync(struct timer_list *timer, bool shutdown)
 }
 
 /**
- * try_to_del_timer_sync - Try to deactivate a timer
+ * timer_delete_sync_try - Try to deactivate a timer
  * @timer:	Timer to deactivate
  *
  * This function tries to deactivate a timer. On success the timer is not
@@ -1526,11 +1526,11 @@ static int __try_to_del_timer_sync(struct timer_list *timer, bool shutdown)
  * * %1  - The timer was pending and deactivated
  * * %-1 - The timer callback function is running on a different CPU
  */
-int try_to_del_timer_sync(struct timer_list *timer)
+int timer_delete_sync_try(struct timer_list *timer)
 {
 	return __try_to_del_timer_sync(timer, false);
 }
-EXPORT_SYMBOL(try_to_del_timer_sync);
+EXPORT_SYMBOL(timer_delete_sync_try);
 
 #ifdef CONFIG_PREEMPT_RT
 static __init void timer_base_init_expiry_lock(struct timer_base *base)
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 3e61a2798d63..bf7e52b2bb13 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2061,7 +2061,7 @@ static void br_multicast_enable(struct bridge_mcast_own_query *query)
 {
 	query->startup_sent = 0;
 
-	if (try_to_del_timer_sync(&query->timer) >= 0 ||
+	if (timer_delete_sync_try(&query->timer) >= 0 ||
 	    timer_delete(&query->timer))
 		mod_timer(&query->timer, jiffies);
 }
@@ -3480,7 +3480,7 @@ static void br_ip4_multicast_query(struct net_bridge_mcast *brmctx,
 	if (mp->host_joined &&
 	    (timer_pending(&mp->timer) ?
 	     time_after(mp->timer.expires, now + max_delay) :
-	     try_to_del_timer_sync(&mp->timer) >= 0))
+	     timer_delete_sync_try(&mp->timer) >= 0))
 		mod_timer(&mp->timer, now + max_delay);
 
 	for (pp = &mp->ports;
@@ -3488,7 +3488,7 @@ static void br_ip4_multicast_query(struct net_bridge_mcast *brmctx,
 	     pp = &p->next) {
 		if (timer_pending(&p->timer) ?
 		    time_after(p->timer.expires, now + max_delay) :
-		    try_to_del_timer_sync(&p->timer) >= 0 &&
+		    timer_delete_sync_try(&p->timer) >= 0 &&
 		    (brmctx->multicast_igmp_version == 2 ||
 		     p->filter_mode == MCAST_EXCLUDE))
 			mod_timer(&p->timer, now + max_delay);
@@ -3569,7 +3569,7 @@ static int br_ip6_multicast_query(struct net_bridge_mcast *brmctx,
 	if (mp->host_joined &&
 	    (timer_pending(&mp->timer) ?
 	     time_after(mp->timer.expires, now + max_delay) :
-	     try_to_del_timer_sync(&mp->timer) >= 0))
+	     timer_delete_sync_try(&mp->timer) >= 0))
 		mod_timer(&mp->timer, now + max_delay);
 
 	for (pp = &mp->ports;
@@ -3577,7 +3577,7 @@ static int br_ip6_multicast_query(struct net_bridge_mcast *brmctx,
 	     pp = &p->next) {
 		if (timer_pending(&p->timer) ?
 		    time_after(p->timer.expires, now + max_delay) :
-		    try_to_del_timer_sync(&p->timer) >= 0 &&
+		    timer_delete_sync_try(&p->timer) >= 0 &&
 		    (brmctx->multicast_mld_version == 1 ||
 		     p->filter_mode == MCAST_EXCLUDE))
 			mod_timer(&p->timer, now + max_delay);
@@ -3649,7 +3649,7 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
 			if (!hlist_unhashed(&p->mglist) &&
 			    (timer_pending(&p->timer) ?
 			     time_after(p->timer.expires, time) :
-			     try_to_del_timer_sync(&p->timer) >= 0)) {
+			     timer_delete_sync_try(&p->timer) >= 0)) {
 				mod_timer(&p->timer, time);
 			}
 
@@ -3665,7 +3665,7 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
 		if (mp->host_joined &&
 		    (timer_pending(&mp->timer) ?
 		     time_after(mp->timer.expires, time) :
-		     try_to_del_timer_sync(&mp->timer) >= 0)) {
+		     timer_delete_sync_try(&mp->timer) >= 0)) {
 			mod_timer(&mp->timer, time);
 		}
 
@@ -3681,7 +3681,7 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
 		if (!hlist_unhashed(&p->mglist) &&
 		    (timer_pending(&p->timer) ?
 		     time_after(p->timer.expires, time) :
-		     try_to_del_timer_sync(&p->timer) >= 0)) {
+		     timer_delete_sync_try(&p->timer) >= 0)) {
 			mod_timer(&p->timer, time);
 		}
 
diff --git a/sound/pci/ctxfi/cttimer.c b/sound/pci/ctxfi/cttimer.c
index 56bf567d98b1..fa6867adb42b 100644
--- a/sound/pci/ctxfi/cttimer.c
+++ b/sound/pci/ctxfi/cttimer.c
@@ -119,7 +119,7 @@ static void ct_systimer_stop(struct ct_timer_instance *ti)
 static void ct_systimer_prepare(struct ct_timer_instance *ti)
 {
 	ct_systimer_stop(ti);
-	try_to_del_timer_sync(&ti->timer);
+	timer_delete_sync_try(&ti->timer);
 }
 
 #define ct_systimer_free	ct_systimer_prepare
-- 
2.45.2


