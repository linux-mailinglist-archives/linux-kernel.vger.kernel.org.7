Return-Path: <linux-kernel+bounces-883666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63247C2E04D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 21:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA171896E6A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 20:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603C02BDC0F;
	Mon,  3 Nov 2025 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bdK4LEqz"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3A29D27A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762201588; cv=none; b=UA4C31XcnTJO4u+fgd9tf7chLyFOeakTwRikIdtym4PQ1+GH91T71QEtOVW8Nfco8SKXZ0bvLnQglG7YDE4gAVFpUySl1mLF/PEoOs1cI6tbt348rfsSN3Pz1lOJQiuWEG8etDKvZYhpF01aFjh9/7mEW5nblOTSpxRC6rX8QKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762201588; c=relaxed/simple;
	bh=8bUIMJOStP9rV3Xk9SfUGuARENmXHMT9+BvuhDyBXaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEJu+vcdLl00o4hCREAE/5bSngqZVNIbWRr6wgdD9Yyu5QZ2neerR0/yzmkv8OhlkZwg5L5G3lvcruEa8C97eR8o11KSZBnnBxkZVvBx8T2yNExoXL+mg0BUPKC7GoYddFwE13Z0PbIdwIcL8YWPm3er5Gf/zqUCEZsGlB145cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bdK4LEqz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zino7i7N9ADBOyAPDUrtAPUyNNIuGUXM+pQFgowPlnE=; b=bdK4LEqzS06aciTNtBPWXeoyVw
	b+ANSFIyyyonddVtSSKASFXxNUwp00uFGrKH9/7hw7TqVfDN+gtLiWaKnemdPIHMWp0gF/gZl8WsG
	piBlAmHzY2KiDoE+VeKo8+F8HPCjKnu0DySv0mP+sMvjUPsZFKl0AoecO3DLWFtrhKM8qBffYvBHH
	MCfebnt4DFk4Kfey3ara0asRp5qGeqGoz500fF7VMYYMqF8I1rBsfbFLTOndUrg8/DtLNAVVMCxZG
	EKdmhYjesDgJ71j3uMxM7ElygBbgSwogl6b/vmKz2DqqvcO4uhqbefkKdv5zuEKGnO2gZQi5GbPW6
	u2VXPMww==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG0GJ-0000000GFJk-0XwJ;
	Mon, 03 Nov 2025 19:30:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CC051300230; Mon, 03 Nov 2025 21:26:11 +0100 (CET)
Date: Mon, 3 Nov 2025 21:26:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	wulibin163@126.com, tanghui20@huawei.com, zhangqiao22@huawei.com,
	judy.chenhui@huawei.com
Subject: Re: [PATCH EEVDF NULL deref] sched/eevdf: Fix NULL deref when
 avg_vruntime nears overflow
Message-ID: <20251103202611.GE3245006@noisy.programming.kicks-ass.net>
References: <20251103130441.1013188-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103130441.1013188-1-quzicheng@huawei.com>

On Mon, Nov 03, 2025 at 01:04:41PM +0000, Zicheng Qu wrote:
> Fix a kernel NULL pointer dereference in pick_next_task_fair() caused by
> EEVDF scheduler arithmetic overflows when cfs_rq->avg_vruntime
> approaches the s64 low.
> 
> The issue occurs when:
> 1. cfs_rq->avg_vruntime is driven downward by dynamic reweight
>    operations on se->vruntime combined with frequent enqueue/dequeue of
> another sched_entity with large se->vlag values. Note that the presence
> of only one other sched_entity (besides the current one) is critical
> because having more would average out the effect and prevent the
> continuous and rapid decrease of cfs_rq->avg_vruntime.
> 2. These factors `reweight` and `frequent enqueue/dequeue` persistently
>    suppress cfs_rq->min_vruntime, causing cfs_rq->avg_vruntime to
> decrease rapidly toward S64_MIN.
> 3. In vruntime_eligible(), the calculation (int64_t)(vruntime -
>    cfs_rq->min_vruntime) * load may overflow downward, becoming a large
> positive value.

Right, so the problem is that min_vruntime doesn't follow (it only wants
to go up). I should have a patch for that, let me go find.

/me rummages in the patch drawer for a bit... 

Also, do you have a reproducer for this? Your crash output says it is
running something called 'sched_test_2'.

The below should work (unless you have CONFIG_SCHED_CORE=y), could you
please try? If it does work, I suppose I'll finally have to sit down
and work out the SCHED_CORE side of this.

(Note the changelog doesn't talk about your problem, it was from a
previous issue and I just haven't bothered fixing it up)

---
Subject: sched/fair: Replace cfs_rq::min_vruntime

Basically, from the constraint that the sum of lag is zero, you can
infer that the 0-lag point is the weighted average of the individual
vruntime, which is what we're trying to compute:

        \Sum w_i * v_i
  avg = --------------
           \Sum w_i

Now, since vruntime takes the whole u64 (worse, it wraps), this
multiplication term in the numerator is not something we can compute;
instead we do the min_vruntime (v0 henceforth) thing like:

  v_i = (v_i - v0) + v0

(edit -- this does two things:
 - it keeps the key 'small';
 - it creates a relative 0-point in the modular space)

If you do that subtitution and work it all out, you end up with:

        \Sum w_i * (v_i - v0)
  avg = --------------------- + v0
              \Sum w_i

Since you cannot very well track a ratio like that (and not suffer
terrible numerical problems) we simpy track the numerator and
denominator individually and only perform the division when strictly
needed.

Notably, the numerator lives in cfs_rq->avg_vruntime and the denominator
lives in cfs_rq->avg_load.

The one extra 'funny' is that these numbers track the entities in the
tree, and current is typically outside of the tree, so avg_vruntime()
adds current when needed before doing the division.

(vruntime_eligible() elides the division by cross-wise multiplication)

Anyway... we got s64 to track avg_vruntime, that sum over weighted keys,
if you have a ton of entities and large keys and large weights (your
case) you can overflow and things go to shit.

Anyway, seeing how your min_vruntime is weird, let me ask you to try the
below; it removes the old min_vruntime and instead tracks zero vruntime
as the 'current' avg_vruntime. We don't need the monotinicity filter,
all we really need is something 'near' all the other vruntimes in order
to compute this relative key so we can preserve order across the wrap.

This *should* get us near minimal sized keys. If you can still
reproduce, you should probably add something like that patch I send you
privately earlier, that checks the overflows.

The below builds and boots (provided SCHED_CORE=n).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |  8 +++---
 kernel/sched/fair.c  | 75 +++++++++++-----------------------------------------
 kernel/sched/sched.h |  2 +-
 3 files changed, 20 insertions(+), 65 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 02e16b70a790..41caa22e0680 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -796,7 +796,7 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
 void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 {
-	s64 left_vruntime = -1, min_vruntime, right_vruntime = -1, left_deadline = -1, spread;
+	s64 left_vruntime = -1, zero_vruntime, right_vruntime = -1, left_deadline = -1, spread;
 	struct sched_entity *last, *first, *root;
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
@@ -819,15 +819,15 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	last = __pick_last_entity(cfs_rq);
 	if (last)
 		right_vruntime = last->vruntime;
-	min_vruntime = cfs_rq->min_vruntime;
+	zero_vruntime = cfs_rq->zero_vruntime;
 	raw_spin_rq_unlock_irqrestore(rq, flags);
 
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "left_deadline",
 			SPLIT_NS(left_deadline));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "left_vruntime",
 			SPLIT_NS(left_vruntime));
-	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "min_vruntime",
-			SPLIT_NS(min_vruntime));
+	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "zero_vruntime",
+			SPLIT_NS(zero_vruntime));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "avg_vruntime",
 			SPLIT_NS(avg_vruntime(cfs_rq)));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "right_vruntime",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb279..1e5552469146 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -554,7 +554,7 @@ static inline bool entity_before(const struct sched_entity *a,
 
 static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	return (s64)(se->vruntime - cfs_rq->min_vruntime);
+	return (s64)(se->vruntime - cfs_rq->zero_vruntime);
 }
 
 #define __node_2_se(node) \
@@ -606,13 +606,13 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
  *
  * Which we track using:
  *
- *                    v0 := cfs_rq->min_vruntime
+ *                    v0 := cfs_rq->zero_vruntime
  * \Sum (v_i - v0) * w_i := cfs_rq->avg_vruntime
  *              \Sum w_i := cfs_rq->avg_load
  *
- * Since min_vruntime is a monotonic increasing variable that closely tracks
- * the per-task service, these deltas: (v_i - v), will be in the order of the
- * maximal (virtual) lag induced in the system due to quantisation.
+ * Since zero_vruntime closely tracks the per-task service, these
+ * deltas: (v_i - v), will be in the order of the maximal (virtual) lag
+ * induced in the system due to quantisation.
  *
  * Also, we use scale_load_down() to reduce the size.
  *
@@ -671,7 +671,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 		avg = div_s64(avg, load);
 	}
 
-	return cfs_rq->min_vruntime + avg;
+	return cfs_rq->zero_vruntime + avg;
 }
 
 /*
@@ -732,7 +732,7 @@ static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 vruntime)
 		load += weight;
 	}
 
-	return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
+	return avg >= (s64)(vruntime - cfs_rq->zero_vruntime) * load;
 }
 
 int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -740,42 +740,14 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return vruntime_eligible(cfs_rq, se->vruntime);
 }
 
-static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
+static void update_zero_vruntime(struct cfs_rq *cfs_rq)
 {
-	u64 min_vruntime = cfs_rq->min_vruntime;
-	/*
-	 * open coded max_vruntime() to allow updating avg_vruntime
-	 */
-	s64 delta = (s64)(vruntime - min_vruntime);
-	if (delta > 0) {
-		avg_vruntime_update(cfs_rq, delta);
-		min_vruntime = vruntime;
-	}
-	return min_vruntime;
-}
+	u64 vruntime = avg_vruntime(cfs_rq);
+	s64 delta = (s64)(vruntime - cfs_rq->zero_vruntime);
 
-static void update_min_vruntime(struct cfs_rq *cfs_rq)
-{
-	struct sched_entity *se = __pick_root_entity(cfs_rq);
-	struct sched_entity *curr = cfs_rq->curr;
-	u64 vruntime = cfs_rq->min_vruntime;
+	avg_vruntime_update(cfs_rq, delta);
 
-	if (curr) {
-		if (curr->on_rq)
-			vruntime = curr->vruntime;
-		else
-			curr = NULL;
-	}
-
-	if (se) {
-		if (!curr)
-			vruntime = se->min_vruntime;
-		else
-			vruntime = min_vruntime(vruntime, se->min_vruntime);
-	}
-
-	/* ensure we never gain time by being placed backwards. */
-	cfs_rq->min_vruntime = __update_min_vruntime(cfs_rq, vruntime);
+	cfs_rq->zero_vruntime = vruntime;
 }
 
 static inline u64 cfs_rq_min_slice(struct cfs_rq *cfs_rq)
@@ -848,6 +820,7 @@ RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	avg_vruntime_add(cfs_rq, se);
+	update_zero_vruntime(cfs_rq);
 	se->min_vruntime = se->vruntime;
 	se->min_slice = se->slice;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
@@ -859,6 +832,7 @@ static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_vruntime_cb);
 	avg_vruntime_sub(cfs_rq, se);
+	update_zero_vruntime(cfs_rq);
 }
 
 struct sched_entity *__pick_root_entity(struct cfs_rq *cfs_rq)
@@ -1226,7 +1200,6 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
 	resched = update_deadline(cfs_rq, curr);
-	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
 		/*
@@ -3808,15 +3781,6 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);
 		cfs_rq->nr_queued++;
-
-		/*
-		 * The entity's vruntime has been adjusted, so let's check
-		 * whether the rq-wide min_vruntime needs updated too. Since
-		 * the calculations above require stable min_vruntime rather
-		 * than up-to-date one, we do the update at the end of the
-		 * reweight process.
-		 */
-		update_min_vruntime(cfs_rq);
 	}
 }
 
@@ -5429,15 +5393,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	update_cfs_group(se);
 
-	/*
-	 * Now advance min_vruntime if @se was the entity holding it back,
-	 * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
-	 * put back on, and if we advance min_vruntime, we'll be placed back
-	 * further than we started -- i.e. we'll be penalized.
-	 */
-	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
-		update_min_vruntime(cfs_rq);
-
 	if (flags & DEQUEUE_DELAYED)
 		finish_delayed_dequeue_entity(se);
 
@@ -13322,7 +13277,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
-	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
+	cfs_rq->zero_vruntime = (u64)(-(1LL << 20));
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4838dda75b10..5e657f89d4ea 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -682,7 +682,7 @@ struct cfs_rq {
 	s64			avg_vruntime;
 	u64			avg_load;
 
-	u64			min_vruntime;
+	u64			zero_vruntime;
 #ifdef CONFIG_SCHED_CORE
 	unsigned int		forceidle_seq;
 	u64			min_vruntime_fi;

