Return-Path: <linux-kernel+bounces-734359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B72E9B08095
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E08A46FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2B82EE5FC;
	Wed, 16 Jul 2025 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FtjuzhFQ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068E528850E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752705570; cv=none; b=egaYgCGSnq5qYcmovQRl8v8OGmx8WzNUgtkytBrOZ9cExw80KgSI/WDqWwoG0h7L8pJzvRbkzXyYwJ5pEyb1anH5nfiaps9f5SRPN5xVOH7Ycv7KIZN1XQkQvmLSEmDCHawafYaHHFck4wG52i1sojwjk5RvVi1h/IyexMpj++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752705570; c=relaxed/simple;
	bh=smRXHyHwwqZImvJ5LKZCJWrgt2BtZvjk/sfkFid5R9Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=fVxu0Usj7OEgvESULjLFc6vAV+XxlhdsIzxdbG6OKr+6kloSd6AOHeejF1q/6HoGljVSN9Zk+m7czCf79xO2iayqh40Q2wxu7Cnv4INJyI3/oOGYOxLnA6wfo1ttSuWdtFph20lqlxcZPM66HJSgKblJ15LiCG9nvCFAu8KsNS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FtjuzhFQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so289140a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752705568; x=1753310368; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qgdp/Uda1fZWO/lz9uKNrP8iyMs5YMXbAT8dILtk/wo=;
        b=FtjuzhFQdiNXwt8QDH6oaE4FVAlrAL6D+BfXht3PN2u5CQf7r+X6IKJdowW9qBQYxl
         HOLpG1fKy6Mxhc81enLrgNfqTB2cUNoxXCQImU6xX2jeJoMx/mqfprM3BrtrnpIwEGOS
         NITacPilOGu/Pe2huw6o9Rc7zKw0wVkanCse4gtvsGf7HAgaK6vK7nPymxRZh6PYNExT
         4bBiUd0uhf44/VB264FRtlcOGSeev2hCmcmqJsHcjNgcmA1ZV7ijmU0lGsI8zv1UmLhk
         5DVoMs/4N5lMfuph0JQ4fioBmQ5fl06gRVqx4tNQwzgk1NtBqkCmXNu8igfTIZ3mg2QV
         7fVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752705568; x=1753310368;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qgdp/Uda1fZWO/lz9uKNrP8iyMs5YMXbAT8dILtk/wo=;
        b=niv/C3llOzVel75KN2xhF+f5dt3lLQyTNPzygapWv70zYlTwPE3dll1+jwMxREW8G5
         yZEH7Xcskt3W/x5rLEIP7P5OZaEdiEZ7bEmSCDgNO4EoCcjcgloN//YrsWLpEZHVcTBi
         znieEXZmRmBUjPLTUdyEp3/CpW7sm4QRYlz+vjqqIH3416bURCmfkcwRfxtllvhcYtgF
         zPW2kyCsjhy/JqaR9CINqfHCtUDoUoYUTtjJaEXZfRAugTTyJGCwKftI7ZKLg+Fda3ep
         ju/l3LegUy2gajtyHSmkB9DbIQOAXzjqP/MBwue7sCQ/caEIgmlueYaPhhy8sKGbFa3d
         nG6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMtqkMM4jNVc+gLxj7sy0oGzv5H7rJou7H9k4qAZeXqAE8tDRBHFrevPED1RjVmzkf66ppeZ700LriLCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6MITNd0j6eTAKQvfMWmFJypNqKfL6HPZoBv4Gj9j7LRJEwDtx
	iCz8YMhW3akOfNin+y6E5VDeitNzDR4SEgpFdkgLlG6xPuNE8GlQArD1JJIGugTcOobPtLVr3eW
	vPoJPLr7OIA==
X-Google-Smtp-Source: AGHT+IH9dmq//m1YlzRrKfR9Wf0NtkxmXnzHMM/7SmxQmVskyqQxsAwYcQbAN26Kh6jOhpeI8C9Kndw4O+JD
X-Received: from pja3.prod.google.com ([2002:a17:90b:5483:b0:312:1af5:98c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:548d:b0:313:31ca:a74
 with SMTP id 98e67ed59e1d1-31c9e759b27mr7887982a91.16.1752705568365; Wed, 16
 Jul 2025 15:39:28 -0700 (PDT)
Date: Wed, 16 Jul 2025 15:39:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716223924.825772-1-irogers@google.com>
Subject: [RFC PATCH v1] perf/core: [Untested] Perf event state changes to fix
 enable time
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Andi Kleen <ak@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Perf events (and the event_filter_match) may mean that an event is
inactive, and wanting to be active from sched_in, but this doesn't
happen due to the filter. As the event is inactive the enabled time
will accrue but the event's running time won't increase. The ratio of
enabled to running time is used to scale event counts as it is
incorrectly assumed in tools that an event is only not accruing
running time in relation enabled time due to multiplexing (a filter
may mean it doesn't accrue too).

For hybrid systems with a task p-core event, the filter will mean the
enabled time will increase on the e-cores making it look like the
event is multiplexing on p-cores. This is reported here:
https://lore.kernel.org/lkml/20250627192417.1157736-13-irogers@google.com/

For a perf event opened on both a task and a CPU, the event is only
active when on the matching CPU due to the filter. This leads to the
enabled time increasing but not the running time, again looking like
multiplexing and causing massive incorrect scaling within tools.

This patch proposes a solution by adding a new PERF_EVENT_STATE_ON
that replaces PERF_EVENT_STATE_INACTIVE. PERF_EVENT_STATE_INACTIVE is
now used for flexible events that failed to be scheduled due to
insufficient counters.

This patch is to highlight the problem and the changes to perf event
states and their associated state machine. It is uncompiled/untested
and intended for discussion purposed only.
---
 include/linux/perf_event.h | 50 ++++++++++++++++++++++----------------
 kernel/events/core.c       | 34 ++++++++++++++------------
 2 files changed, 47 insertions(+), 37 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ec9d96025683..8c4ffd7e2a02 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -638,29 +638,36 @@ struct perf_addr_filter_range {
 /*
  * The normal states are:
  *
- *            ACTIVE    --.
- *               ^        |
- *               |        |
- *       sched_{in,out}() |
- *               |        |
- *               v        |
- *      ,---> INACTIVE  --+ <-.
- *      |                 |   |
- *      |                {dis,en}able()
- *   sched_in()           |   |
- *      |       OFF    <--' --+
- *      |                     |
- *      `--->  ERROR    ------'
+ *    .-- disable() -----> OFF <----disable()-------.
+ *    |                     |         ^             |
+ *    +-----------------> enable()    |             |
+ *    |                     |  .------.             |
+ *    |                     v /                     |
+ *  ERROR      .---------> ON <-----------.         |
+ *    ^        |            |             |         |
+ *    |      filter <-- sched_in()  sched_out()     |
+ *    |                     |             |         |
+ *    +-(lack of counters)--+             |         |
+ *    v                     v             |         |
+ *  INACTIVE              ACTIVE          |         |
+ *    |                     |             |         |
+ *    .---------------------+-------------+---------.
  *
  * That is:
  *
- * sched_in:       INACTIVE          -> {ACTIVE,ERROR}
- * sched_out:      ACTIVE            -> INACTIVE
- * disable:        {ACTIVE,INACTIVE} -> OFF
- * enable:         {OFF,ERROR}       -> INACTIVE
+ * sched_in:       ON                         -> {ON,ERROR,INACTIVE,ACTIVE}
+ * sched_out:      {INACTIVE,ACTIVE}          -> ON
+ * disable:        {ON,ERROR,INACTIVE,ACTIVE} -> OFF
+ * enable:         {OFF,ERROR}                -> ON
  *
- * Where {OFF,ERROR} are disabled states.
+ * Where {ON,INACTIVE,ACTIVE} are enabled states and {OFF,ERROR} are disabled
+ * states.
  *
+ * ON differs from INACTIVE as enabled time only increases for INACTIVE and
+ * ACTIVE events, running time only increases for ACTIVE events. A filter, such
+ * as the task or CPU an event should be scheduled on, can cause an event during
+ * sched_in to remain in the ON state.
+
  * Then we have the {EXIT,REVOKED,DEAD} states which are various shades of
  * defunct events:
  *
@@ -681,9 +688,10 @@ enum perf_event_state {
 	PERF_EVENT_STATE_REVOKED	= -4, /* pmu gone, must not touch */
 	PERF_EVENT_STATE_EXIT		= -3, /* task died, still inherit */
 	PERF_EVENT_STATE_ERROR		= -2, /* scheduling error, can enable */
-	PERF_EVENT_STATE_OFF		= -1,
-	PERF_EVENT_STATE_INACTIVE	=  0,
-	PERF_EVENT_STATE_ACTIVE		=  1,
+	PERF_EVENT_STATE_OFF		= -1, /* regular disabled event */
+	PERF_EVENT_STATE_ON		=  0, /* enabled but not scheduled */
+	PERF_EVENT_STATE_INACTIVE	=  1, /* not scheduled due to lack of counters */
+	PERF_EVENT_STATE_ACTIVE		=  2, /* scheduled and counting */
 };
 
 struct file;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f746469fda5..ef76c3887f71 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1920,7 +1920,7 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 static inline void perf_event__state_init(struct perf_event *event)
 {
 	event->state = event->attr.disabled ? PERF_EVENT_STATE_OFF :
-					      PERF_EVENT_STATE_INACTIVE;
+					      PERF_EVENT_STATE_ON;
 }
 
 static int __perf_event_read_size(u64 read_format, int nr_siblings)
@@ -2362,14 +2362,14 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 {
 	struct perf_event_pmu_context *epc = event->pmu_ctx;
 	struct perf_cpu_pmu_context *cpc = this_cpc(epc->pmu);
-	enum perf_event_state state = PERF_EVENT_STATE_INACTIVE;
+	enum perf_event_state state = PERF_EVENT_STATE_ON;
 
 	// XXX cpc serialization, probably per-cpu IRQ disabled
 
 	WARN_ON_ONCE(event->ctx != ctx);
 	lockdep_assert_held(&ctx->lock);
 
-	if (event->state != PERF_EVENT_STATE_ACTIVE)
+	if (event->state < PERF_EVENT_STATE_INACTIVE)
 		return;
 
 	/*
@@ -2409,7 +2409,7 @@ group_sched_out(struct perf_event *group_event, struct perf_event_context *ctx)
 {
 	struct perf_event *event;
 
-	if (group_event->state != PERF_EVENT_STATE_ACTIVE)
+	if (group_event->state < PERF_EVENT_STATE_INACTIVE)
 		return;
 
 	perf_assert_pmu_disabled(group_event->pmu_ctx->pmu);
@@ -2583,7 +2583,7 @@ static void __perf_event_disable(struct perf_event *event,
 				 struct perf_event_context *ctx,
 				 void *info)
 {
-	if (event->state < PERF_EVENT_STATE_INACTIVE)
+	if (event->state < PERF_EVENT_STATE_ON)
 		return;
 
 	perf_pmu_disable(event->pmu_ctx->pmu);
@@ -3135,13 +3135,13 @@ static void __perf_event_enable(struct perf_event *event,
 	struct perf_event *leader = event->group_leader;
 	struct perf_event_context *task_ctx;
 
-	if (event->state >= PERF_EVENT_STATE_INACTIVE ||
+	if (event->state >= PERF_EVENT_STATE_ON ||
 	    event->state <= PERF_EVENT_STATE_ERROR)
 		return;
 
 	ctx_time_freeze(cpuctx, ctx);
 
-	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
+	perf_event_set_state(event, PERF_EVENT_STATE_ON);
 	perf_cgroup_event_enable(event, ctx);
 
 	if (!ctx->is_active)
@@ -3150,6 +3150,8 @@ static void __perf_event_enable(struct perf_event *event,
 	if (!event_filter_match(event))
 		return;
 
+	perf_event_set_state(event, PERF_EVENT_STATE_ACTIVE);
+
 	/*
 	 * If the event is in a group and isn't the group leader,
 	 * then don't put it on unless the group is on.
@@ -3178,7 +3180,7 @@ static void _perf_event_enable(struct perf_event *event)
 	struct perf_event_context *ctx = event->ctx;
 
 	raw_spin_lock_irq(&ctx->lock);
-	if (event->state >= PERF_EVENT_STATE_INACTIVE ||
+	if (event->state >= PERF_EVENT_STATE_ON ||
 	    event->state <  PERF_EVENT_STATE_ERROR) {
 out:
 		raw_spin_unlock_irq(&ctx->lock);
@@ -4525,10 +4527,10 @@ static int event_enable_on_exec(struct perf_event *event,
 		return 0;
 
 	event->attr.enable_on_exec = 0;
-	if (event->state >= PERF_EVENT_STATE_INACTIVE)
+	if (event->state >= PERF_EVENT_STATE_ON)
 		return 0;
 
-	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
+	perf_event_set_state(event, PERF_EVENT_STATE_ON);
 
 	return 1;
 }
@@ -8544,7 +8546,7 @@ perf_iterate_ctx(struct perf_event_context *ctx,
 
 	list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
 		if (!all) {
-			if (event->state < PERF_EVENT_STATE_INACTIVE)
+			if (event->state < PERF_EVENT_STATE_ON)
 				continue;
 			if (!event_filter_match(event))
 				continue;
@@ -8568,7 +8570,7 @@ static void perf_iterate_sb_cpu(perf_iterate_f output, void *data)
 		if (!smp_load_acquire(&event->ctx))
 			continue;
 
-		if (event->state < PERF_EVENT_STATE_INACTIVE)
+		if (event->state < PERF_EVENT_STATE_ON)
 			continue;
 		if (!event_filter_match(event))
 			continue;
@@ -12864,7 +12866,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	event->ns		= get_pid_ns(task_active_pid_ns(current));
 	event->id		= atomic64_inc_return(&perf_event_id);
 
-	event->state		= PERF_EVENT_STATE_INACTIVE;
+	event->state		= PERF_EVENT_STATE_ON;
 
 	if (parent_event)
 		event->event_caps = parent_event->event_caps;
@@ -13875,7 +13877,7 @@ static void __perf_pmu_install_event(struct pmu *pmu,
 	event->pmu_ctx = epc;
 
 	if (event->state >= PERF_EVENT_STATE_OFF)
-		event->state = PERF_EVENT_STATE_INACTIVE;
+		event->state = PERF_EVENT_STATE_ON;
 	perf_install_in_context(ctx, event, cpu);
 
 	/*
@@ -14288,8 +14290,8 @@ inherit_event(struct perf_event *parent_event,
 	 * not its attr.disabled bit.  We hold the parent's mutex,
 	 * so we won't race with perf_event_{en, dis}able_family.
 	 */
-	if (parent_state >= PERF_EVENT_STATE_INACTIVE)
-		child_event->state = PERF_EVENT_STATE_INACTIVE;
+	if (parent_state >= PERF_EVENT_STATE_ON)
+		child_event->state = PERF_EVENT_STATE_ON;
 	else
 		child_event->state = PERF_EVENT_STATE_OFF;
 
-- 
2.50.0.727.gbf7dc18ff4-goog


