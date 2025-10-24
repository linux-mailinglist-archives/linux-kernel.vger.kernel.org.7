Return-Path: <linux-kernel+bounces-869271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9EBC0778D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB3819A7672
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7502D3226;
	Fri, 24 Oct 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEfJ11fc"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8428032E74C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325553; cv=none; b=sBwCxMPLZLIpuBIR39e1YBmBFofkgl5IYWXHltpW8iV9CC8MfiKEZqQED2npO8Zxzot7MUo735HizS9ZY/JKD7+cHfgju3vVKu7jzz+sPGeNgh/fRXnaEYu+Rmgbe/y1XlRiGLJaEdl2vOmIj1K9JBg/gnMyxaDfCBzm1Fmmz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325553; c=relaxed/simple;
	bh=ywL2XffooPaoJtOW52uoNolWTfO4L1cPqhwxEZrSkdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mh6Pl86kKDAsInZsiPBuMaCiys2ZZMGOm1Yt6TXs7OAPO9d+Fi7ZmNcP4NhwWrZJIn83B/DygCYYD0PVsFmQ6Sqjz7rhCbrGxngcNdHvVWfvqemnUGa5k18tSN+7C9EkTgT0gjcP5Ji4pkDxNpgeELI8EB9Tdh1ZthUrORtOrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEfJ11fc; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7930132f59aso3021354b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761325551; x=1761930351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FlJMjioQT5hFyjTQfgGib/nn3aRlpyKPcJRzd9y5r+E=;
        b=QEfJ11fcA01RRFgcatosxDl+0Ay1YD1NiIUGslkFEcUesOPHG2gKNfyA1z8t87BhrF
         LnXmtGQhOTOPbugy6iv3QweOLAerAYFkT+fJYGUM6nDV0O7Zq9QaQZkt3CJw6QwP+pzJ
         3LZ15Txa6gzxgI12YCS/bDKxfol5a9rSBnX0osK/h99gAfDmGsW0S4BbQ9IobeTY7oyO
         OBCfmmpEhgcIE6XYE9sg+EHPaPX41fsPAkQzqdr/1oYeyhw2MNLlG06VQ9grZAncgHlc
         5I8qXn7PmPU8N0oFQBMVY6ApdGQzPgGrdnrtDxk/tG1dPTqqYBXtFnnSQNhZxQHMA/xu
         mAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761325551; x=1761930351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlJMjioQT5hFyjTQfgGib/nn3aRlpyKPcJRzd9y5r+E=;
        b=hXSqw1E5z2SeSwNj3XaTg5k9mJE7XXeGn4y5VFu2J2ZXv3BtjtqalAUyEkN0mQGxgz
         MGnJfqBqQgrf6PEMjIhqBmrI2ED49E5gjbhVkbRpgTJF8xFxmnH+Y5JrqL4Xvb6426zn
         3bk0q8mSCG6SGSqgcP3xJ0wUSyvC1/msy2FIRfW7MYajgEyAGmXC9sGShAS5UvBSFHu9
         nwl5R9xYEXnzpnMCjG3AwstRSziw5XUcajRpmA0p5WNMajoX0paHXIL3fFZAl8qaSJAm
         GxnNMTsMBWBypSG4xZkKjhrNh0gvwLsjLsqQYjsG8isnxGHXb59U2BpTlnL85z2ugw5n
         NWWw==
X-Forwarded-Encrypted: i=1; AJvYcCXNIvnpNB/8AaAumavuq7dwBi2Z7HF0rU3ipEqBsRJCnOw/0GMYsepMNhNQH1+3bdczzwfZVrdUoOjgxCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySkIseo9Ijw23Gbe15AVImqU9jO2iXj36CB8/O6G+AEdzBReBj
	VWA9ccwpYpp4j5EJpKatjjqg6nEJcG/nKnV3XIF2NKDQBzF/hzbPhZoO
X-Gm-Gg: ASbGncsKs0ENupRPlShioDmbY8K2Q7xmLYnEGjctkKKRzpJ5BSn23BbXNwopRbdiOVq
	pC0iGslL7mHhhFVeT7ExU63+qdNMeFdFfGcsfIrWBKUR2iFmzIMKis+Klrz2mDCnOf2XHWlHaMQ
	ROEFDqWb/XMXYdgw4tZbDjse6ZcVfnlUObEPUXB3QMoYcfBdRDQfPLdSNtPgdbSz069Iv545OLy
	0awG6OzC+oRlJQtsDnoLhvbxofA4E4Tzq92LHR3SdVr7ZipIughdr2oviiVhujgtrb7w4uYwOA0
	4qyCkDXybeXyDpzRxXdiTS/hpMDZExVdS7SgginVnHgCbK1ZAz50sMvg7JGLS/u70SnOaqqXHkL
	+9je2JFOrpgu2jU6zr1uqoTSI+c5OgIp/BFMAx+9ALKh1rgn0PbFU8nXbRFolzumfnxokvKeAHD
	FiAsCKLA==
X-Google-Smtp-Source: AGHT+IG4XfOYYNzUXM+7Yx0Buo4o5e56GVlMcvjrf3CpNTQnLFTr/XojsAx61GxG2MZlMHY8rXL4JQ==
X-Received: by 2002:a05:6a20:12ce:b0:2e3:a914:aa93 with SMTP id adf61e73a8af0-33dec02dd8cmr3977713637.30.1761325550625;
        Fri, 24 Oct 2025 10:05:50 -0700 (PDT)
Received: from nixos ([115.192.189.58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e158fdsm5568972a12.19.2025.10.24.10.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 10:05:50 -0700 (PDT)
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
Subject: [PATCH v3] perf/core: Fix missing read event generation on task exit
Date: Sat, 25 Oct 2025 01:05:43 +0800
Message-ID: <20251024170543.11201-1-thaumy.love@gmail.com>
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

To fix that, let sync_child_event read task from argument and move the
call to the only place it should be triggered to avoid the effect of
setting ctx->task to TASK_TOMESTONE, and add a task parameter to
perf_event_exit_event to trigger the sync_child_event properly when
needed.

This bug can be reproduced by running "perf record -s" and attaching to
any program that generates perf events in its child tasks. If we check
the result with "perf report -T", the last line of the report will leave
an empty table like "# PID  TID", which is expected to contain the
per-task event counts by design.

Fixes: ef54c1a476ae ("perf: Rework perf_event_exit_event()")
Signed-off-by: Thaumy Cheng <thaumy.love@gmail.com>
---
Changes in v3:
- Fix the bug in a more direct way by moving the call to
  sync_child_event and bring back the task param to
  perf_event_exit_event.
  This approach avoids the event unscheduling issue in v2.

Changes in v2:
- Only trigger read event on task exit.
- Rename perf_event_exit_event to perf_event_detach_event.
- Link to v2: https://lore.kernel.org/all/20250817132742.85154-1-thaumy.love@gmail.com/

Changes in v1:
- Set TASK_TOMBSTONE after the read event is tirggered.
- Link to v1: https://lore.kernel.org/all/20250720000424.12572-1-thaumy.love@gmail.com/

 kernel/events/core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 177e57c1a362..618e7947c358 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2316,7 +2316,8 @@ static void perf_group_detach(struct perf_event *event)
 	perf_event__header_size(leader);
 }

-static void sync_child_event(struct perf_event *child_event);
+static void sync_child_event(struct perf_event *child_event,
+			     struct task_struct *task);

 static void perf_child_detach(struct perf_event *event)
 {
@@ -2336,7 +2337,6 @@ static void perf_child_detach(struct perf_event *event)
 	lockdep_assert_held(&parent_event->child_mutex);
 	 */

-	sync_child_event(event);
 	list_del_init(&event->child_list);
 }

@@ -4587,6 +4587,7 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
 static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *event,
 				  struct perf_event_context *ctx,
+				  struct task_struct *task,
 				  bool revoke);

 /*
@@ -4614,7 +4615,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)

 		modified = true;

-		perf_event_exit_event(event, ctx, false);
+		perf_event_exit_event(event, ctx, ctx->task, false);
 	}

 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -12437,7 +12438,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
 	/*
 	 * De-schedule the event and mark it REVOKED.
 	 */
-	perf_event_exit_event(event, ctx, true);
+	perf_event_exit_event(event, ctx, ctx->task, true);

 	/*
 	 * All _free_event() bits that rely on event->pmu:
@@ -13994,14 +13995,13 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 }
 EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);

-static void sync_child_event(struct perf_event *child_event)
+static void sync_child_event(struct perf_event *child_event,
+			     struct task_struct *task)
 {
 	struct perf_event *parent_event = child_event->parent;
 	u64 child_val;

 	if (child_event->attr.inherit_stat) {
-		struct task_struct *task = child_event->ctx->task;
-
 		if (task && task != TASK_TOMBSTONE)
 			perf_event_read_event(child_event, task);
 	}
@@ -14020,7 +14020,9 @@ static void sync_child_event(struct perf_event *child_event)

 static void
 perf_event_exit_event(struct perf_event *event,
-		      struct perf_event_context *ctx, bool revoke)
+		      struct perf_event_context *ctx,
+		      struct task_struct *task,
+		      bool revoke)
 {
 	struct perf_event *parent_event = event->parent;
 	unsigned long detach_flags = DETACH_EXIT;
@@ -14043,6 +14045,9 @@ perf_event_exit_event(struct perf_event *event,
 		mutex_lock(&parent_event->child_mutex);
 		/* PERF_ATTACH_ITRACE might be set concurrently */
 		attach_state = READ_ONCE(event->attach_state);
+
+		if (attach_state & PERF_ATTACH_CHILD)
+			sync_child_event(event, task);
 	}

 	if (revoke)
@@ -14134,7 +14139,7 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 		perf_event_task(task, ctx, 0);

 	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, ctx, false);
+		perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);

 	mutex_unlock(&ctx->mutex);

--
2.51.0

