Return-Path: <linux-kernel+bounces-888334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A090C3A8BC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90689424B2A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3771530DEC8;
	Thu,  6 Nov 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="recwIZj8"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E06230DECD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427819; cv=none; b=mU+2U8ULi0vv769a8S4GAYxkIrvkqKSPUy2fjjUNoKEozLX7OGu/8DgTjXtZdpMbG+cci51JM+FE9dDl4PA/i1U3pQPqxmx5i5n3pHm9lLfoCEJIJ+Al529h1avkl9bllysTvOGVaHUneNu9zs9pF44K3F55BG1v8ALmCQeXD3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427819; c=relaxed/simple;
	bh=iOnSHttlHxEBz59SQ4jdgNgo9JFu8A4IXT8SBBlJsi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMdHAiZko28JF0pJi2teXmcp8i9XiiQY9er8baJomI4A+tlfhyT3K2gJ6gCITDKX3lg0Iy8Do4nfCRniIM65DuEdDYIfF/88kMowoJh83WQ8ezlOIylfdsabyM4/CPmdPFnJXvEDeWrIzbyleaagrmx5KYUcWd3lJ9o8jdFPAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=recwIZj8; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=589L1lurVHR6xC2CRnq4RoM0AJNLqs3DJRM3s81Rbxo=; b=recwIZj81kfbYLFpqD1l71U502
	nqsQMVwkgFRkfAjJ7SnU2t0D47agFSTZiYY71mF/iiPzZYULDmJfFJa6clMJfbDX7uozXwBQL9pBu
	XGDSx/xpnMPbsNhp6JUQePqivmjWIKLyxluWmgRmj3EropuXLQZOBAh4nq3xK5m44VH9Blp23JMVD
	GHNkdfimbnfeS51QoLTorua9wWkzWcVeDOUi4zuWbrm0VheqhrAswZkn0lkAC8iUccqEH2EBEPTi3
	5hiHZLs8YaJ9EUBK2MIhuivbDuqur2Pyis4ryS8I3QnBgM58LCZf9CXP8Jbi5H3iQqeTk87WpjxN7
	CwhkpGOA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGx6Z-000000046br-1eMQ;
	Thu, 06 Nov 2025 10:20:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0C203300265; Thu, 06 Nov 2025 12:16:03 +0100 (CET)
Date: Thu, 6 Nov 2025 12:16:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Zicheng Qu <quzicheng@huawei.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	wulibin163@126.com, tanghui20@huawei.com, zhangqiao22@huawei.com,
	judy.chenhui@huawei.com
Subject: Re: [PATCH EEVDF NULL deref] sched/eevdf: Fix NULL deref when
 avg_vruntime nears overflow
Message-ID: <20251106111603.GB4068168@noisy.programming.kicks-ass.net>
References: <20251103130441.1013188-1-quzicheng@huawei.com>
 <20251103202611.GE3245006@noisy.programming.kicks-ass.net>
 <7cdcc98e-990e-4408-ba75-57dd0229316e@huawei.com>
 <20251105123954.GM3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105123954.GM3245006@noisy.programming.kicks-ass.net>

On Wed, Nov 05, 2025 at 01:39:54PM +0100, Peter Zijlstra wrote:

> > As for the zero_vruntime patch, after applying it, we have not
> > observed any crashes over than 24 hours.
> 
> Excellent, I'll go think about the SCHED_CORE case and make it a proper
> patch then.

---
Subject: sched/core: Add comment explaining force-idle vruntime snapshots
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Nov 6 10:50:49 CET 2025

I always end up having to re-read these emails every time I look at
this code. And a future patch is going to change this story a little.
This means it is past time to stick them in a comment so it can be
modified and stay current.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200506143506.GH5298@hirez.programming.kicks-ass.net
Link: https://lkml.kernel.org/r/20200515103844.GG2978@hirez.programming.kicks-ass.net
---
 kernel/sched/fair.c |  181 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13015,6 +13015,187 @@ static inline void task_tick_core(struct
 }
 
 /*
+ * Consider any infeasible weight scenario. Take for instance two tasks,
+ * each bound to their respective sibling, one with weight 1 and one with
+ * weight 2. Then the lower weight task will run ahead of the higher weight
+ * task without bound.
+ *
+ * This utterly destroys the concept of a shared time base.
+ *
+ * Remember; all this is about a proportionally fair scheduling, where each
+ * tasks receives:
+ *
+ *              w_i
+ *   dt_i = ---------- dt                                     (1)
+ *          \Sum_j w_j
+ *
+ * which we do by tracking a virtual time, s_i:
+ *
+ *          1
+ *   s_i = --- d[t]_i                                         (2)
+ *         w_i
+ *
+ * Where d[t] is a delta of discrete time, while dt is an infinitesimal.
+ * The immediate corollary is that the ideal schedule S, where (2) to use
+ * an infinitesimal delta, is:
+ *
+ *           1
+ *   S = ---------- dt                                        (3)
+ *       \Sum_i w_i
+ *
+ * From which we can define the lag, or deviation from the ideal, as:
+ *
+ *   lag(i) = S - s_i                                         (4)
+ *
+ * And since the one and only purpose is to approximate S, we get that:
+ *
+ *   \Sum_i w_i lag(i) := 0                                   (5)
+ *
+ * If this were not so, we no longer converge to S, and we can no longer
+ * claim our scheduler has any of the properties we derive from S. This is
+ * exactly what you did above, you broke it!
+ *
+ *
+ * Let's continue for a while though; to see if there is anything useful to
+ * be learned. We can combine (1)-(3) or (4)-(5) and express S in s_i:
+ *
+ *       \Sum_i w_i s_i
+ *   S = --------------                                       (6)
+ *         \Sum_i w_i
+ *
+ * Which gives us a way to compute S, given our s_i. Now, if you've read
+ * our code, you know that we do not in fact do this, the reason for this
+ * is two-fold. Firstly, computing S in that way requires a 64bit division
+ * for every time we'd use it (see 12), and secondly, this only describes
+ * the steady-state, it doesn't handle dynamics.
+ *
+ * Anyway, in (6):  s_i -> x + (s_i - x), to get:
+ *
+ *           \Sum_i w_i (s_i - x)
+ *   S - x = --------------------                             (7)
+ *              \Sum_i w_i
+ *
+ * Which shows that S and s_i transform alike (which makes perfect sense
+ * given that S is basically the (weighted) average of s_i).
+ *
+ * Then:
+ *
+ *   x -> s_min := min{s_i}                                   (8)
+ *
+ * to obtain:
+ *
+ *               \Sum_i w_i (s_i - s_min)
+ *   S = s_min + ------------------------                     (9)
+ *                     \Sum_i w_i
+ *
+ * Which already looks familiar, and is the basis for our current
+ * approximation:
+ *
+ *   S ~= s_min                                              (10)
+ *
+ * Now, obviously, (10) is absolute crap :-), but it sorta works.
+ *
+ * So the thing to remember is that the above is strictly UP. It is
+ * possible to generalize to multiple runqueues -- however it gets really
+ * yuck when you have to add affinity support, as illustrated by our very
+ * first counter-example.
+ *
+ * Luckily I think we can avoid needing a full multi-queue variant for
+ * core-scheduling (or load-balancing). The crucial observation is that we
+ * only actually need this comparison in the presence of forced-idle; only
+ * then do we need to tell if the stalled rq has higher priority over the
+ * other.
+ *
+ * [XXX assumes SMT2; better consider the more general case, I suspect
+ * it'll work out because our comparison is always between 2 rqs and the
+ * answer is only interesting if one of them is forced-idle]
+ *
+ * And (under assumption of SMT2) when there is forced-idle, there is only
+ * a single queue, so everything works like normal.
+ *
+ * Let, for our runqueue 'k':
+ *
+ *   T_k = \Sum_i w_i s_i
+ *   W_k = \Sum_i w_i      ; for all i of k                  (11)
+ *
+ * Then we can write (6) like:
+ *
+ *         T_k
+ *   S_k = ---                                               (12)
+ *         W_k
+ *
+ * From which immediately follows that:
+ *
+ *           T_k + T_l
+ *   S_k+l = ---------                                       (13)
+ *           W_k + W_l
+ *
+ * On which we can define a combined lag:
+ *
+ *   lag_k+l(i) := S_k+l - s_i                               (14)
+ *
+ * And that gives us the tools to compare tasks across a combined runqueue.
+ *
+ *
+ * Combined this gives the following:
+ *
+ *  a) when a runqueue enters force-idle, sync it against it's sibling rq(s)
+ *     using (7); this only requires storing single 'time'-stamps.
+ *
+ *  b) when comparing tasks between 2 runqueues of which one is forced-idle,
+ *     compare the combined lag, per (14).
+ *
+ * Now, of course cgroups (I so hate them) make this more interesting in
+ * that a) seems to suggest we need to iterate all cgroup on a CPU at such
+ * boundaries, but I think we can avoid that. The force-idle is for the
+ * whole CPU, all it's rqs. So we can mark it in the root and lazily
+ * propagate downward on demand.
+ */
+
+/*
+ * So this sync is basically a relative reset of S to 0.
+ *
+ * So with 2 queues, when one goes idle, we drop them both to 0 and one
+ * then increases due to not being idle, and the idle one builds up lag to
+ * get re-elected. So far so simple, right?
+ *
+ * When there's 3, we can have the situation where 2 run and one is idle,
+ * we sync to 0 and let the idle one build up lag to get re-election. Now
+ * suppose another one also drops idle. At this point dropping all to 0
+ * again would destroy the built-up lag from the queue that was already
+ * idle, not good.
+ *
+ * So instead of syncing everything, we can:
+ *
+ *   less := !((s64)(s_a - s_b) <= 0)
+ *
+ *   (v_a - S_a) - (v_b - S_b) == v_a - v_b - S_a + S_b
+ *                             == v_a - (v_b - S_a + S_b)
+ *
+ * IOW, we can recast the (lag) comparison to a one-sided difference.
+ * So if then, instead of syncing the whole queue, sync the idle queue
+ * against the active queue with S_a + S_b at the point where we sync.
+ *
+ * (XXX consider the implication of living in a cyclic group: N / 2^n N)
+ *
+ * This gives us means of syncing single queues against the active queue,
+ * and for already idle queues to preserve their build-up lag.
+ *
+ * Of course, then we get the situation where there's 2 active and one
+ * going idle, who do we pick to sync against? Theory would have us sync
+ * against the combined S, but as we've already demonstrated, there is no
+ * such thing in infeasible weight scenarios.
+ *
+ * One thing I've considered; and this is where that core_active rudiment
+ * came from, is having active queues sync up between themselves after
+ * every tick. This limits the observed divergence due to the work
+ * conservancy.
+ *
+ * On top of that, we can improve upon things by moving away from our
+ * horrible (10) hack and moving to (9) and employing (13) here.
+ */
+
+/*
  * se_fi_update - Update the cfs_rq->min_vruntime_fi in a CFS hierarchy if needed.
  */
 static void se_fi_update(const struct sched_entity *se, unsigned int fi_seq,

