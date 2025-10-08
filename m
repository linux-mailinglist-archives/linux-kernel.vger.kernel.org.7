Return-Path: <linux-kernel+bounces-845762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6339FBC609D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B7BC4EA2CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528B62BDC09;
	Wed,  8 Oct 2025 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgniaLZb"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8952EB862
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941346; cv=none; b=WLhzfVi/IQrtok7f2Xlo/4r+E2mKGnXlyYYMf31XlDBWm9+kNPq4WBopOjpME7ypmzfrkSYaQJAf2en4eEejTNfiuND1uLoMNQoHMIe/8IEXRn1Ct/IjJ1erTYaAurD+dnUjuWH+59ZTIn68VbGm5W/HwnVWvn4cHLgH3h58/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941346; c=relaxed/simple;
	bh=CKRJGACJWHK8Hlud48RR8jl/VtJ79lLFYLx1AJc/+NA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRRUwAMniSgx1GfOaduCLXOLnQbx23qf+cejnDYs/RusF53igiSPDiTYahMvkvMdQ/BGnZZNWPSzF5ibUIC+JRId5bG16H9+7afzRdIExDY2CQRdXLub6mhodYp3XBySY3ZmPEeylD2R0mYbFKouu8Kd9ZqlztVnPQ0EMujEYDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgniaLZb; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-793021f348fso6062b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759941343; x=1760546143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISvkKKWDIq4+oW79gR956cg3AZDUxj8RaDon4KWZSA4=;
        b=HgniaLZbybMc7rK0hnoAY/a1aHoL+/qGncGdtzWVXpIJlUDMwkwv7ijv1EzYDAa+sy
         sjoE8KzRm5Mj7tSYbJ3/z5TYphIEIJjFGn8sM17n+r5JIwJXjrhXJ5mrOWo/j2v5VmKP
         2+noSX89FZ/ztYYapjLBa8c7zcvOjOHNzxCoKLoZ5Jbr0kaffm12FnG/myssJnMe3Cvz
         xfNjWZ8l0CUmyetcrxSSRRcp1J18+dhCUnHe72ybuVpBqum+A+tMhjQYuO0GqnFZs0iD
         RetA7SkMXROgo+IFJflXQWKCnPZe5hClwGYVLhfyK0s6MO/BIUcO0eA812y136o38Y0N
         Plcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759941343; x=1760546143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISvkKKWDIq4+oW79gR956cg3AZDUxj8RaDon4KWZSA4=;
        b=uF2rbniHDOwOGg0A7E9EKiDxdujLY0rt1bun/HBbF8NtyY32H2UWJ2BemY8oDF2lKq
         qnNtgKHxHfN9b3zWiKnyrvXhcRdH/NRyAvBh4itsSLemNd21JZP6MNjKYaNvla8FE1qG
         VFG9zQmGfWmIOtURRoPQ/NgS/gkyikit1FsB7vpJ3w/FIu0BYJG3kZ9AQRiYxFl+1QQZ
         dEb9aMLdlX/jFGO/+5vAg7G139Wqq7s0H5HBIPar0uhouEcdqfmWB0DVnVZWKQl78X24
         YfqJyI7nKA9ZIE1Wn40NLKwPRiadgHz+VK3wem7b/jKYS9h50gkmPrRA8wqWWa8F0oqu
         +6ew==
X-Forwarded-Encrypted: i=1; AJvYcCXyZmk+AfTaFKPwuu9IciH7RlzO/90YCxorAmI11HwtxkQITSOk+z/RsDn35OVzYpd+zxgjmBGUNoX35fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCIqKaVzgJSxMHuRTS/W3j5yX9+kXDlpY/cqAVlpRdrkzLfFBc
	SUgkQqUGtGDLerj01dLAJbu96ZQOa/KLLerYmzRNR42EkNClo03ttf9P
X-Gm-Gg: ASbGncv+XONJpd6zzu2W12D7dk2aJDwgvgPMfMxT2FV+YuB4VbPp+tuLCZdgG7DifOQ
	k0bztbz4vUVhTwiq2pTTVh3mVaoKdzOVoK8bvOfS4V1QY1gftZvigjTF6Ca22ffhfqXQm/14Ug4
	FWYubTrYRezEHT3n78lAQL8C5mf9YNbomUtQSM+K+nnicrkB0RlHw6fvNoFhCeGOHq0FjV0xwYM
	FQPgbpvpOt/nuO8y8PE/SVKppFbWTZF6GdNFJP5QwZcPXS54TMfa833n9rJsDu8+5FZJNMp4LJF
	CuuSVh+WNAWAp2sBLp8KQVHqMFyh12hoDoRq9tNwt/EgkkWuzuhQXq7lwDU/gdmeMSku/0P5x7G
	ROyEojxy5DZG5HU+SIh6lL0grNJ4iiT6Evb/kzEuFHzQn0x95zy+G
X-Google-Smtp-Source: AGHT+IFyKxDK1EEywFovdigzvcCH96/bCa684gE/Uzd317/7l8f5ukh49kZ2qABtvV1h3v3zrAOoBw==
X-Received: by 2002:a05:6a00:c8c:b0:781:15b0:bea9 with SMTP id d2e1a72fcca58-79387c16f18mr4659168b3a.22.1759941342575;
        Wed, 08 Oct 2025 09:35:42 -0700 (PDT)
Received: from nixos ([115.192.189.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794d4b3d6a6sm204653b3a.7.2025.10.08.09.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:35:42 -0700 (PDT)
From: Thaumy Cheng <thaumy.love@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thaumy Cheng <thaumy.love@gmail.com>
Subject: [PATCH v2 RESEND] perf/core: Fix missing read event generation on task exit
Date: Thu,  9 Oct 2025 00:35:30 +0800
Message-ID: <20251008163530.810407-1-thaumy.love@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For events with inherit_stat enabled, a "read" event will be generated
to collect per task event counts on task exit.

The call chain is as follows:

do_exit
  -> perf_event_exit_task
    -> perf_event_exit_task_context
      -> perf_event_exit_event
        -> perf_remove_from_context
          -> perf_child_detach
            -> sync_child_event
              -> perf_event_read_event

However, the child event context detaches the task too early in
perf_event_exit_task_context, which causes sync_child_event to never
generate the read event in this case, since child_event->ctx->task is
always set to TASK_TOMBSTONE. Fix that by moving context lock section
backward to ensure ctx->task is not set to TASK_TOMBSTONE before
generating the read event.

Because perf_event_free_task calls perf_event_exit_task_context with
exit = false to tear down all child events from the context, and the
task never lived, accessing the task PID can lead to a use-after-free.

To address that, need an extra exit parameter for perf_event_exit_event
to teach it to distinguish callers. Only the caller that needs to exit
the task will trigger the read event, which will set the newly added
sync_child parameter of perf_child_detach.

Since now perf_event_exit_event may not carry DETACH_EXIT, rename it to
a more appropriate name "perf_event_detach_event".

This bug can be reproduced by running "perf record -s" and attaching to
any program that generates perf events in its child tasks. If we check
the result with "perf report -T", the last line of the report will leave
an empty table like "# PID  TID", which is expected to contain the
per-task event counts by design.

Fixes: ef54c1a476ae ("perf: Rework perf_event_exit_event()")
Signed-off-by: Thaumy Cheng <thaumy.love@gmail.com>
---
Changes in v2:
- Only trigger read event on task exit.
- Rename perf_event_exit_event to perf_event_detach_event.

Changes in v1:
- Set TASK_TOMBSTONE after the read event is tirggered.
- Link to v1: https://lore.kernel.org/all/20250720000424.12572-1-thaumy.love@gmail.com/

 kernel/events/core.c | 53 ++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8060c2857bb2..2e17883f2439 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1306,7 +1306,7 @@ static void put_ctx(struct perf_event_context *ctx)
  * perf_event_context::mutex nests and those are:
  *
  *  - perf_event_exit_task_context()	[ child , 0 ]
- *      perf_event_exit_event()
+ *      perf_event_detach_event()
  *        put_event()			[ parent, 1 ]
  *
  *  - perf_event_init_context()		[ parent, 0 ]
@@ -2318,7 +2318,7 @@ static void perf_group_detach(struct perf_event *event)

 static void sync_child_event(struct perf_event *child_event);

-static void perf_child_detach(struct perf_event *event)
+static void perf_child_detach(struct perf_event *event, bool sync_child)
 {
 	struct perf_event *parent_event = event->parent;

@@ -2336,7 +2336,9 @@ static void perf_child_detach(struct perf_event *event)
 	lockdep_assert_held(&parent_event->child_mutex);
 	 */

-	sync_child_event(event);
+	if (sync_child)
+		sync_child_event(event);
+
 	list_del_init(&event->child_list);
 }

@@ -2507,7 +2509,7 @@ __perf_remove_from_context(struct perf_event *event,
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
-		perf_child_detach(event);
+		perf_child_detach(event, (flags & DETACH_EXIT) != 0);
 	list_del_event(event, ctx);

 	if (!pmu_ctx->nr_events) {
@@ -2613,7 +2615,7 @@ static void __perf_event_disable(struct perf_event *event,
  * remains valid.  This condition is satisfied when called through
  * perf_event_for_each_child or perf_event_for_each because they
  * hold the top-level event's child_mutex, so any descendant that
- * goes to exit will block in perf_event_exit_event().
+ * goes to exit will block in perf_event_detach_event().
  *
  * When called from perf_pending_disable it's OK because event->ctx
  * is the current context on this CPU and preemption is disabled,
@@ -4579,9 +4581,9 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 }

 static void perf_remove_from_owner(struct perf_event *event);
-static void perf_event_exit_event(struct perf_event *event,
+static void perf_event_detach_event(struct perf_event *event,
 				  struct perf_event_context *ctx,
-				  bool revoke);
+				  bool revoke, bool exit);

 /*
  * Removes all events from the current task that have been marked
@@ -4608,7 +4610,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)

 		modified = true;

-		perf_event_exit_event(event, ctx, false);
+		perf_event_detach_event(event, ctx, false, true);
 	}

 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -6178,7 +6180,7 @@ EXPORT_SYMBOL_GPL(perf_event_pause);
 /*
  * Holding the top-level event's child_mutex means that any
  * descendant process that has inherited this event will block
- * in perf_event_exit_event() if it goes to exit, thus satisfying the
+ * in perf_event_detach_event() if it goes to exit, thus satisfying the
  * task existence requirements of perf_event_enable/disable.
  */
 static void perf_event_for_each_child(struct perf_event *event,
@@ -12413,7 +12415,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
 	/*
 	 * De-schedule the event and mark it REVOKED.
 	 */
-	perf_event_exit_event(event, ctx, true);
+	perf_event_detach_event(event, ctx, true, true);

 	/*
 	 * All _free_event() bits that rely on event->pmu:
@@ -13995,13 +13997,16 @@ static void sync_child_event(struct perf_event *child_event)
 }

 static void
-perf_event_exit_event(struct perf_event *event,
-		      struct perf_event_context *ctx, bool revoke)
+perf_event_detach_event(struct perf_event *event,
+		      struct perf_event_context *ctx, bool revoke, bool exit)
 {
 	struct perf_event *parent_event = event->parent;
-	unsigned long detach_flags = DETACH_EXIT;
+	unsigned long detach_flags = 0;
 	unsigned int attach_state;

+	if (exit)
+		detach_flags |= DETACH_EXIT;
+
 	if (parent_event) {
 		/*
 		 * Do not destroy the 'original' grouping; because of the
@@ -14077,6 +14082,17 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 	 */
 	mutex_lock(&ctx->mutex);

+	/*
+	 * Report the task dead after unscheduling the events so that we
+	 * won't get any samples after PERF_RECORD_EXIT. We can however still
+	 * get a few PERF_RECORD_READ events.
+	 */
+	if (exit)
+		perf_event_task(task, ctx, 0);
+
+	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
+		perf_event_detach_event(child_event, ctx, false, exit);
+
 	/*
 	 * In a single ctx::lock section, de-schedule the events and detach the
 	 * context from the task such that we cannot ever get it scheduled back
@@ -14101,17 +14117,6 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 	if (clone_ctx)
 		put_ctx(clone_ctx);

-	/*
-	 * Report the task dead after unscheduling the events so that we
-	 * won't get any samples after PERF_RECORD_EXIT. We can however still
-	 * get a few PERF_RECORD_READ events.
-	 */
-	if (exit)
-		perf_event_task(task, ctx, 0);
-
-	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, ctx, false);
-
 	mutex_unlock(&ctx->mutex);

 	if (!exit) {
--
2.50.1


