Return-Path: <linux-kernel+bounces-758236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCABFB1CCD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6E43A788B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BE72D0C94;
	Wed,  6 Aug 2025 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TPqZJ7Ie"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9E2BF3CA
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510265; cv=none; b=V9loKhMM27Xa7c9oxnO6gDJcIUBEggYdolWLh39RO3wXOx8uxG2SlhZY+8+f1L+77nFJBjSt7N0RHkYNy9WmIPt6FFfvc6qWzEHyB8k1+LuRQO4HTMQJ+AVXRU25wEOGQULvvF+sGt8rV+XTuS0GXZH4gqbUVoEsnNNi2vJa/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510265; c=relaxed/simple;
	bh=qXNnxwAFJGaumhjqTu3EpzzvDhsbJFUwsj0x4yAhN4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Avj1vnROqpdi++JLG1GNexmeEdu3BMNuFl6gRl6m3VPrMz2MefgUDn20qphHrBtjwsG4WIllqpTvdsWX0SIpsG6QwCTR+m0CO0gFdTskTnZFPKZnG6J0A85ZR/EDBe0KMCJs7m5gLfdPwJo9vbXPSWT/rftE4mz/n7mZFp3elgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TPqZJ7Ie; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31f65d519d3so468655a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510260; x=1755115060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=u7P8yyV+9ZMI+BI4Iw55kZCbOndqPSIcTJXU+Tv7Czo=;
        b=TPqZJ7IeYpGSjV/Lz336x9Y7dRKRKQZyJCJjNUR9HkqxQRR/Sa4SBvc/WH0ZThEdNk
         KAoB5RqRlrsPh5T3paBJdvRjBp4xJnt/RKvO/tHlMJ0f0pEbH4XKBDtOJSkJ/jSquQoi
         6IqZxO5Mc/GuyHDHIDFgzuixUlfeCO4vQ0UaP6dXPhkzKgx4xJUxP5tDvJ46J1CibkOs
         uW6lLX7gXMbV/sBeYzc/cXYmcq+emp/H9Mrxpcu1GViFrVSGDkOD8Lm4/a1k8QYN5/u8
         6ZHjkEYDUVk4HMQ1gHQNdZJMOypmlasF7Q580ABOfh+FU8Y8ITBgvTD4U2uPuYRWr9NY
         9tnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510260; x=1755115060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7P8yyV+9ZMI+BI4Iw55kZCbOndqPSIcTJXU+Tv7Czo=;
        b=fyVrRpE2esm62OAkO2zlHJUlByfv5dOVHVsuFlttqqGVIrd8pFjEhm2gGN76t6bEcG
         7uxS6aZhHkCpAhEH1BbkEnuyKMXo5lD8Rg0vFSdjYW/waqSr4npS9oZFj+e5PKuJdYwV
         y3cIr8Jqdc2gwBxqJEV0kbM2mcP+NK3OWfzuepX0AoQnuvGEPncjl6YhUOJkcGTtk9U0
         YwX0DdpNX7WbZjG0g1+9eF2YSA5f3+DOAk7Fm9JvtYqzEzZZSChQBvJgA2sF/XraR5iM
         B4AruuYzmHhHZ1j7tG51ENp90bSn48xkk3nArs48u8ckcKMRwy1cOI9lCXmIKSFqnvv+
         pavg==
X-Forwarded-Encrypted: i=1; AJvYcCVaeGLh0NzMCWs4efeYqVJ9LZIXwbeSGyliZBNV6ofCqF4TaZSZM2W3TRrIBsfTNlwLnJD7x6pIjIKm73w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4DkCTqwEOHM5Es8ial4N6iFKl+FInbymrn03Ci+osms1NBOk4
	rnd3KmWIA3wCtyNz3SvUN3ao6pZsdqwA6/cWtLBD17VysfGgcnfdfEi4LiTtx3BhgWnWU+gGPQs
	P0nuRqA==
X-Google-Smtp-Source: AGHT+IG1ZiDUo/Q9d3HEUVIEffrei/1g0+Hi4k9oLFsDUgDDE2+7uLClBEV/7iTHQOJOUOiDxrBymUDpBDM=
X-Received: from pjob20.prod.google.com ([2002:a17:90a:8c94:b0:31f:a0:fad4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d46:b0:31a:9004:899d
 with SMTP id 98e67ed59e1d1-32166ca4402mr6079864a91.18.1754510259792; Wed, 06
 Aug 2025 12:57:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:28 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-7-seanjc@google.com>
Subject: [PATCH v5 06/44] perf: Add a EVENT_GUEST flag
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Kan Liang <kan.liang@linux.intel.com>

Current perf doesn't explicitly schedule out all exclude_guest events
while the guest is running. There is no problem with the current
emulated vPMU. Because perf owns all the PMU counters. It can mask the
counter which is assigned to an exclude_guest event when a guest is
running (Intel way), or set the corresponding HOSTONLY bit in evsentsel
(AMD way). The counter doesn't count when a guest is running.

However, either way doesn't work with the introduced mediated vPMU.
A guest owns all the PMU counters when it's running. The host should not
mask any counters. The counter may be used by the guest. The evsentsel
may be overwritten.

Perf should explicitly schedule out all exclude_guest events to release
the PMU resources when entering a guest, and resume the counting when
exiting the guest.

It's possible that an exclude_guest event is created when a guest is
running. The new event should not be scheduled in as well.

The ctx time is shared among different PMUs. The time cannot be stopped
when a guest is running. It is required to calculate the time for events
from other PMUs, e.g., uncore events. Add timeguest to track the guest
run time. For an exclude_guest event, the elapsed time equals
the ctx time - guest time.
Cgroup has dedicated times. Use the same method to deduct the guest time
from the cgroup time as well.

Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
[sean: massage comments]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/perf_event.h |   6 +
 kernel/events/core.c       | 232 ++++++++++++++++++++++++++++---------
 2 files changed, 186 insertions(+), 52 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 186a026fb7fb..0958b6d0a61c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1044,6 +1044,11 @@ struct perf_event_context {
 	 */
 	struct perf_time_ctx		time;
 
+	/*
+	 * Context clock, runs when in the guest mode.
+	 */
+	struct perf_time_ctx		timeguest;
+
 	/*
 	 * These fields let us detect when two contexts have both
 	 * been cloned (inherited) from a common ancestor.
@@ -1176,6 +1181,7 @@ struct bpf_perf_event_data_kern {
  */
 struct perf_cgroup_info {
 	struct perf_time_ctx		time;
+	struct perf_time_ctx		timeguest;
 	int				active;
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2cf988bdabf0..6875b56ddd6b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -164,7 +164,19 @@ enum event_type_t {
 	/* see ctx_resched() for details */
 	EVENT_CPU	= 0x10,
 	EVENT_CGROUP	= 0x20,
-	EVENT_FLAGS	= EVENT_CGROUP,
+
+	/*
+	 * EVENT_GUEST is set when scheduling in/out events between the host
+	 * and a guest with a mediated vPMU.  Among other things, EVENT_GUEST
+	 * is used:
+	 *
+	 * - In for_each_epc() to skip PMUs that don't support events in a
+	 *   MEDIATED_VPMU guest, i.e. don't need to be context switched.
+	 * - To indicate the start/end point of the events in a guest.  Guest
+	 *   running time is deducted for host-only (exclude_guest) events.
+	 */
+	EVENT_GUEST	= 0x40,
+	EVENT_FLAGS	= EVENT_CGROUP | EVENT_GUEST,
 	/* compound helpers */
 	EVENT_ALL         = EVENT_FLEXIBLE | EVENT_PINNED,
 	EVENT_TIME_FROZEN = EVENT_TIME | EVENT_FROZEN,
@@ -457,6 +469,11 @@ static cpumask_var_t perf_online_pkg_mask;
 static cpumask_var_t perf_online_sys_mask;
 static struct kmem_cache *perf_event_cache;
 
+static __always_inline bool is_guest_mediated_pmu_loaded(void)
+{
+	return false;
+}
+
 /*
  * perf event paranoia level:
  *  -1 - not paranoid at all
@@ -783,6 +800,9 @@ static bool perf_skip_pmu_ctx(struct perf_event_pmu_context *pmu_ctx,
 {
 	if ((event_type & EVENT_CGROUP) && !pmu_ctx->nr_cgroups)
 		return true;
+	if ((event_type & EVENT_GUEST) &&
+	    !(pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU))
+		return true;
 	return false;
 }
 
@@ -833,6 +853,39 @@ static inline void update_perf_time_ctx(struct perf_time_ctx *time, u64 now, boo
 	WRITE_ONCE(time->offset, time->time - time->stamp);
 }
 
+static_assert(offsetof(struct perf_event_context, timeguest) -
+	      offsetof(struct perf_event_context, time) ==
+	      sizeof(struct perf_time_ctx));
+
+#define T_TOTAL		0
+#define T_GUEST		1
+
+static inline u64 __perf_event_time_ctx(struct perf_event *event,
+					struct perf_time_ctx *times)
+{
+	u64 time = times[T_TOTAL].time;
+
+	if (event->attr.exclude_guest)
+		time -= times[T_GUEST].time;
+
+	return time;
+}
+
+static inline u64 __perf_event_time_ctx_now(struct perf_event *event,
+					    struct perf_time_ctx *times,
+					    u64 now)
+{
+	if (is_guest_mediated_pmu_loaded() && event->attr.exclude_guest) {
+		/*
+		 * (now + times[total].offset) - (now + times[guest].offset) :=
+		 * times[total].offset - times[guest].offset
+		 */
+		return READ_ONCE(times[T_TOTAL].offset) - READ_ONCE(times[T_GUEST].offset);
+	}
+
+	return now + READ_ONCE(times[T_TOTAL].offset);
+}
+
 #ifdef CONFIG_CGROUP_PERF
 
 static inline bool
@@ -869,12 +922,16 @@ static inline int is_cgroup_event(struct perf_event *event)
 	return event->cgrp != NULL;
 }
 
+static_assert(offsetof(struct perf_cgroup_info, timeguest) -
+	      offsetof(struct perf_cgroup_info, time) ==
+	      sizeof(struct perf_time_ctx));
+
 static inline u64 perf_cgroup_event_time(struct perf_event *event)
 {
 	struct perf_cgroup_info *t;
 
 	t = per_cpu_ptr(event->cgrp->info, event->cpu);
-	return t->time.time;
+	return __perf_event_time_ctx(event, &t->time);
 }
 
 static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 now)
@@ -883,9 +940,21 @@ static inline u64 perf_cgroup_event_time_now(struct perf_event *event, u64 now)
 
 	t = per_cpu_ptr(event->cgrp->info, event->cpu);
 	if (!__load_acquire(&t->active))
-		return t->time.time;
-	now += READ_ONCE(t->time.offset);
-	return now;
+		return __perf_event_time_ctx(event, &t->time);
+
+	return __perf_event_time_ctx_now(event, &t->time, now);
+}
+
+static inline void __update_cgrp_guest_time(struct perf_cgroup_info *info, u64 now, bool adv)
+{
+	update_perf_time_ctx(&info->timeguest, now, adv);
+}
+
+static inline void update_cgrp_time(struct perf_cgroup_info *info, u64 now)
+{
+	update_perf_time_ctx(&info->time, now, true);
+	if (is_guest_mediated_pmu_loaded())
+		__update_cgrp_guest_time(info, now, true);
 }
 
 static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx, bool final)
@@ -901,7 +970,7 @@ static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx,
 			cgrp = container_of(css, struct perf_cgroup, css);
 			info = this_cpu_ptr(cgrp->info);
 
-			update_perf_time_ctx(&info->time, now, true);
+			update_cgrp_time(info, now);
 			if (final)
 				__store_release(&info->active, 0);
 		}
@@ -924,11 +993,11 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 	 * Do not update time when cgroup is not active
 	 */
 	if (info->active)
-		update_perf_time_ctx(&info->time, perf_clock(), true);
+		update_cgrp_time(info, perf_clock());
 }
 
 static inline void
-perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
+perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx, bool guest)
 {
 	struct perf_event_context *ctx = &cpuctx->ctx;
 	struct perf_cgroup *cgrp = cpuctx->cgrp;
@@ -948,8 +1017,12 @@ perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
 	for (css = &cgrp->css; css; css = css->parent) {
 		cgrp = container_of(css, struct perf_cgroup, css);
 		info = this_cpu_ptr(cgrp->info);
-		update_perf_time_ctx(&info->time, ctx->time.stamp, false);
-		__store_release(&info->active, 1);
+		if (guest) {
+			__update_cgrp_guest_time(info, ctx->time.stamp, false);
+		} else {
+			update_perf_time_ctx(&info->time, ctx->time.stamp, false);
+			__store_release(&info->active, 1);
+		}
 	}
 }
 
@@ -1153,7 +1226,7 @@ static inline int perf_cgroup_connect(pid_t pid, struct perf_event *event,
 }
 
 static inline void
-perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx)
+perf_cgroup_set_timestamp(struct perf_cpu_context *cpuctx, bool guest)
 {
 }
 
@@ -1565,16 +1638,24 @@ static void perf_unpin_context(struct perf_event_context *ctx)
  */
 static void __update_context_time(struct perf_event_context *ctx, bool adv)
 {
-	u64 now = perf_clock();
+	lockdep_assert_held(&ctx->lock);
+
+	update_perf_time_ctx(&ctx->time, perf_clock(), adv);
+}
 
+static void __update_context_guest_time(struct perf_event_context *ctx, bool adv)
+{
 	lockdep_assert_held(&ctx->lock);
 
-	update_perf_time_ctx(&ctx->time, now, adv);
+	/* must be called after __update_context_time(); */
+	update_perf_time_ctx(&ctx->timeguest, ctx->time.stamp, adv);
 }
 
 static void update_context_time(struct perf_event_context *ctx)
 {
 	__update_context_time(ctx, true);
+	if (is_guest_mediated_pmu_loaded())
+		__update_context_guest_time(ctx, true);
 }
 
 static u64 perf_event_time(struct perf_event *event)
@@ -1587,7 +1668,7 @@ static u64 perf_event_time(struct perf_event *event)
 	if (is_cgroup_event(event))
 		return perf_cgroup_event_time(event);
 
-	return ctx->time.time;
+	return __perf_event_time_ctx(event, &ctx->time);
 }
 
 static u64 perf_event_time_now(struct perf_event *event, u64 now)
@@ -1601,10 +1682,9 @@ static u64 perf_event_time_now(struct perf_event *event, u64 now)
 		return perf_cgroup_event_time_now(event, now);
 
 	if (!(__load_acquire(&ctx->is_active) & EVENT_TIME))
-		return ctx->time.time;
+		return __perf_event_time_ctx(event, &ctx->time);
 
-	now += READ_ONCE(ctx->time.offset);
-	return now;
+	return __perf_event_time_ctx_now(event, &ctx->time, now);
 }
 
 static enum event_type_t get_event_type(struct perf_event *event)
@@ -2427,20 +2507,23 @@ group_sched_out(struct perf_event *group_event, struct perf_event_context *ctx)
 }
 
 static inline void
-__ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx, bool final)
+__ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx,
+		  bool final, enum event_type_t event_type)
 {
 	if (ctx->is_active & EVENT_TIME) {
 		if (ctx->is_active & EVENT_FROZEN)
 			return;
+
 		update_context_time(ctx);
-		update_cgrp_time_from_cpuctx(cpuctx, final);
+		/* vPMU should not stop time */
+		update_cgrp_time_from_cpuctx(cpuctx, !(event_type & EVENT_GUEST) && final);
 	}
 }
 
 static inline void
 ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
 {
-	__ctx_time_update(cpuctx, ctx, false);
+	__ctx_time_update(cpuctx, ctx, false, 0);
 }
 
 /*
@@ -3506,7 +3589,7 @@ ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 	 *
 	 * would only update time for the pinned events.
 	 */
-	__ctx_time_update(cpuctx, ctx, ctx == &cpuctx->ctx);
+	__ctx_time_update(cpuctx, ctx, ctx == &cpuctx->ctx, event_type);
 
 	/*
 	 * CPU-release for the below ->is_active store,
@@ -3532,7 +3615,18 @@ ctx_sched_out(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 			cpuctx->task_ctx = NULL;
 	}
 
-	is_active ^= ctx->is_active; /* changed bits */
+	if (event_type & EVENT_GUEST) {
+		/*
+		 * Schedule out all exclude_guest events of PMU
+		 * with PERF_PMU_CAP_MEDIATED_VPMU.
+		 */
+		is_active = EVENT_ALL;
+		__update_context_guest_time(ctx, false);
+		perf_cgroup_set_timestamp(cpuctx, true);
+		barrier();
+	} else {
+		is_active ^= ctx->is_active; /* changed bits */
+	}
 
 	for_each_epc(pmu_ctx, ctx, pmu, event_type)
 		__pmu_ctx_sched_out(pmu_ctx, is_active);
@@ -3991,10 +4085,15 @@ static inline void group_update_userpage(struct perf_event *group_event)
 		event_update_userpage(event);
 }
 
+struct merge_sched_data {
+	int can_add_hw;
+	enum event_type_t event_type;
+};
+
 static int merge_sched_in(struct perf_event *event, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
-	int *can_add_hw = data;
+	struct merge_sched_data *msd = data;
 
 	if (event->state <= PERF_EVENT_STATE_OFF)
 		return 0;
@@ -4002,13 +4101,22 @@ static int merge_sched_in(struct perf_event *event, void *data)
 	if (!event_filter_match(event))
 		return 0;
 
-	if (group_can_go_on(event, *can_add_hw)) {
+	/*
+	 * Don't schedule in any host events from PMU with
+	 * PERF_PMU_CAP_MEDIATED_VPMU, while a guest is running.
+	 */
+	if (is_guest_mediated_pmu_loaded() &&
+	    event->pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU &&
+	    !(msd->event_type & EVENT_GUEST))
+		return 0;
+
+	if (group_can_go_on(event, msd->can_add_hw)) {
 		if (!group_sched_in(event, ctx))
 			list_add_tail(&event->active_list, get_event_list(event));
 	}
 
 	if (event->state == PERF_EVENT_STATE_INACTIVE) {
-		*can_add_hw = 0;
+		msd->can_add_hw = 0;
 		if (event->attr.pinned) {
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
@@ -4031,11 +4139,15 @@ static int merge_sched_in(struct perf_event *event, void *data)
 
 static void pmu_groups_sched_in(struct perf_event_context *ctx,
 				struct perf_event_groups *groups,
-				struct pmu *pmu)
+				struct pmu *pmu,
+				enum event_type_t event_type)
 {
-	int can_add_hw = 1;
+	struct merge_sched_data msd = {
+		.can_add_hw = 1,
+		.event_type = event_type,
+	};
 	visit_groups_merge(ctx, groups, smp_processor_id(), pmu,
-			   merge_sched_in, &can_add_hw);
+			   merge_sched_in, &msd);
 }
 
 static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
@@ -4044,9 +4156,9 @@ static void __pmu_ctx_sched_in(struct perf_event_pmu_context *pmu_ctx,
 	struct perf_event_context *ctx = pmu_ctx->ctx;
 
 	if (event_type & EVENT_PINNED)
-		pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pmu);
+		pmu_groups_sched_in(ctx, &ctx->pinned_groups, pmu_ctx->pmu, event_type);
 	if (event_type & EVENT_FLEXIBLE)
-		pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->pmu);
+		pmu_groups_sched_in(ctx, &ctx->flexible_groups, pmu_ctx->pmu, event_type);
 }
 
 static void
@@ -4063,9 +4175,11 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 		return;
 
 	if (!(is_active & EVENT_TIME)) {
+		/* EVENT_TIME should be active while the guest runs */
+		WARN_ON_ONCE(event_type & EVENT_GUEST);
 		/* start ctx time */
 		__update_context_time(ctx, false);
-		perf_cgroup_set_timestamp(cpuctx);
+		perf_cgroup_set_timestamp(cpuctx, false);
 		/*
 		 * CPU-release for the below ->is_active store,
 		 * see __load_acquire() in perf_event_time_now()
@@ -4081,7 +4195,23 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
 	}
 
-	is_active ^= ctx->is_active; /* changed bits */
+	if (event_type & EVENT_GUEST) {
+		/*
+		 * Schedule in the required exclude_guest events of PMU
+		 * with PERF_PMU_CAP_MEDIATED_VPMU.
+		 */
+		is_active = event_type & EVENT_ALL;
+
+		/*
+		 * Update ctx time to set the new start time for
+		 * the exclude_guest events.
+		 */
+		update_context_time(ctx);
+		update_cgrp_time_from_cpuctx(cpuctx, false);
+		barrier();
+	} else {
+		is_active ^= ctx->is_active; /* changed bits */
+	}
 
 	/*
 	 * First go through the list and put on any pinned groups
@@ -4089,13 +4219,13 @@ ctx_sched_in(struct perf_event_context *ctx, struct pmu *pmu, enum event_type_t
 	 */
 	if (is_active & EVENT_PINNED) {
 		for_each_epc(pmu_ctx, ctx, pmu, event_type)
-			__pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED);
+			__pmu_ctx_sched_in(pmu_ctx, EVENT_PINNED | (event_type & EVENT_GUEST));
 	}
 
 	/* Then walk through the lower prio flexible groups */
 	if (is_active & EVENT_FLEXIBLE) {
 		for_each_epc(pmu_ctx, ctx, pmu, event_type)
-			__pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE);
+			__pmu_ctx_sched_in(pmu_ctx, EVENT_FLEXIBLE | (event_type & EVENT_GUEST));
 	}
 }
 
@@ -6621,23 +6751,23 @@ void perf_event_update_userpage(struct perf_event *event)
 	if (!rb)
 		goto unlock;
 
-	/*
-	 * compute total_time_enabled, total_time_running
-	 * based on snapshot values taken when the event
-	 * was last scheduled in.
-	 *
-	 * we cannot simply called update_context_time()
-	 * because of locking issue as we can be called in
-	 * NMI context
-	 */
-	calc_timer_values(event, &now, &enabled, &running);
-
-	userpg = rb->user_page;
 	/*
 	 * Disable preemption to guarantee consistent time stamps are stored to
 	 * the user page.
 	 */
 	preempt_disable();
+
+	/*
+	 * Compute total_time_enabled, total_time_running based on snapshot
+	 * values taken when the event was last scheduled in.
+	 *
+	 * We cannot simply call update_context_time() because doing so would
+	 * lead to deadlock when called from NMI context.
+	 */
+	calc_timer_values(event, &now, &enabled, &running);
+
+	userpg = rb->user_page;
+
 	++userpg->lock;
 	barrier();
 	userpg->index = perf_event_index(event);
@@ -7902,13 +8032,11 @@ static void perf_output_read(struct perf_output_handle *handle,
 	u64 read_format = event->attr.read_format;
 
 	/*
-	 * compute total_time_enabled, total_time_running
-	 * based on snapshot values taken when the event
-	 * was last scheduled in.
+	 * Compute total_time_enabled, total_time_running based on snapshot
+	 * values taken when the event was last scheduled in.
 	 *
-	 * we cannot simply called update_context_time()
-	 * because of locking issue as we are called in
-	 * NMI context
+	 * We cannot simply call update_context_time() because doing so would
+	 * lead to deadlock when called from NMI context.
 	 */
 	if (read_format & PERF_FORMAT_TOTAL_TIMES)
 		calc_timer_values(event, &now, &enabled, &running);
-- 
2.50.1.565.gc32cd1483b-goog


