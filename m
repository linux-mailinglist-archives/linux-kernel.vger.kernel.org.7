Return-Path: <linux-kernel+bounces-738886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07E2B0BEBA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC34E17AD91
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E02286D62;
	Mon, 21 Jul 2025 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAp3ii8d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4EE2868B3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086229; cv=none; b=hSruo0qHXDY7SeMoJXDTvL3clU+5BkKimeg67RVwN2IsMd8EOmEhF0jhHcH1S6eCptHBqYOvMUyIRBsDpLatipqZBEPJ2ZcMdgusCf9cVwVXa6XhVHU/3TuKHoMGqMo86hB5YhJP6dvYCM5q61e5qZeMQa5gogBRnr3xw50+NBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086229; c=relaxed/simple;
	bh=o1ZVe76ZyfRtJEfq2kmQlixLF+NBPgzDF2tM6nR4GvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVjLyFHK/JpZnuA2jQYvzkv4FYZM1AriX0L7cvVPLRyRl5RHjiGiPzZg2tQZYk2GbLupbqdSVInCF9S5RYaV0vj4dQ+PYc+rmdaNGPkLTEc61ubAhmjSgnNYkfWP9KVVUvqs4uQ38F6aJLT5Trli/L/2smmBCSaFvkmHW3WjDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAp3ii8d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753086225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8x9BgD3tGK/B/BtL4ZwgBbDT5/k2ft0nNFrrHLC+VWM=;
	b=NAp3ii8da0CGxGopjA72/KAKkqdeunQooBZNjsvuoyVk7q5SgS69YduJXIt8mzI2zwUu9w
	NB5HvzikHowIAavTk+EzvpqysvLZUlj6SVDvgIU92tDbmPsroC1T9PHo++p4NkOHkKuEQ/
	qxYDUCLSE4OxIwfOIGj9RQNkxdgYWP0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-2k8bqMZzMLOD6OH11Ti1sA-1; Mon,
 21 Jul 2025 04:23:44 -0400
X-MC-Unique: 2k8bqMZzMLOD6OH11Ti1sA-1
X-Mimecast-MFC-AGG-ID: 2k8bqMZzMLOD6OH11Ti1sA_1753086223
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 978811800292;
	Mon, 21 Jul 2025 08:23:42 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2234195608D;
	Mon, 21 Jul 2025 08:23:37 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v4 00/14] rv: Add monitors to validate task switch
Date: Mon, 21 Jul 2025 10:23:10 +0200
Message-ID: <20250721082325.71554-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This series adds three monitors to the sched collection, extends and
replaces previously existing monitors:

{tss,snroc} => sts:
Not only prove that switches occur in scheduling context and scheduling
needs interrupt disabled but also that each call to the scheduler
disables interrupts to (optionally) switch.

nrp (NEW):
* preemption requires need resched which is cleared by any switch
  (includes a non optimal workaround for /nested/ preemptions)

sssw (NEW):
* suspension requires setting the task to sleepable and, after the
  switch occurs, the task requires a wakeup to come back to runnable

opid (NEW):
* waking and need-resched operations occur with interrupts and
  preemption disabled or in IRQ without explicitly disabling preemption

Also include some minor cleanup patches (1-9) tracepoints (11) and
preparatory fixes (10) covering some corner cases:

The series is currently based on the next tree.

Patch 1 fixes the behaviour of the rv tool with -s and idle tasks.

Patch 2 allows the rv tool to gracefully terminate with SIGTERM

Patch 3 adds da_handle_start_run_event_ also to per-task monitors

Patch 4 removes a trailing whitespace from the rv tracepoint string

Patch 5 returns the registration error in all DA monitor instead of 0

Patch 6 fixes an out-of-bound memory access in DA tracepoints

Patch 7 adjusts monitors to have minimised Kconfig dependencies

Patch 8 properly orders nested monitors in the RV Kconfig file

Patch 9 adjusts dot2c not to create lines over 100 columns

Patch 10 detects race conditions when rv monitors run concurrently and
retries applying the events

Patch 11 adds the need_resched and removes unused arguments from
schedule entry/exit tracepoints

Patch 12 adds the sts monitor to replace tss and sncid

Patch 13 adds the nrp and sssw monitors

Patch 14 adds the opid monitor

NOTES

The nrp and sssw monitors include workarounds for racy conditions:

* A sleeping task requires to set the state to sleepable, but in case of
  a task sleeping on an rtlock, the set sleepable and wakeup events race
  and we don't always see the right order:

 5d..2. 107.488369: event: 639: sleepable x set_sleepable -> sleepable
 4d..5. 107.488369: event: 639: sleepable x wakeup -> running (final)
 5d..3. 107.488385: error: 639: switch_suspend not expected in the state running

    wakeup()                    set_state()
        state=RUNNING
                                    trace_set_state()
        trace_wakeup()
                                    state=SLEEPING

  I added a special event (switch_block) but there may be a better way.
  Taking a pi_lock in rtlock_slowlock_locked when setting the state to
  TASK_RTLOCK_WAIT avoids this race, although this is likely not
  something we want to do.

* I consider preemption any scheduling with preempt==true and assume
  this can happen only if need resched is set.
  In practice, however, we may see a preemption where the flag
  is not set. This can happen in one specific condition:

  need_resched
                  preempt_schedule()
                                        preempt_schedule_irq()
                                            __schedule()
  !need_resched
                      __schedule()

  We start a standard preemption (e.g. from preempt_enable when the flag
  is set), an interrupts occurs before we schedule and, on its exit path,
  it schedules, which clears the need_resched flag.
  When the preempted task runs again, we continue the standard
  preemption started earlier, although the flag is no longer set.

  I added a workaround to allow the model not to fail in this condition,
  by allowing a preemption without need_resched if an interrupt is
  received. This might catch false negatives too.

Changes since V3 [1]:
* Fix condition for lines shorter than 100 columns in dot2c.
* Fix Kconfig tooltip for container monitors in rvgen.
* Improve condition not to skip pid-0 in userspace tool.
* Rearrange monitors to reduce needed tracepoints and arguments.
* Separately track errors when DAs run out of retries due to races.
* Fix issue in opid with multiple handlers in the same interrupt.
* Cleanup patches by removing, squashing and reordering.

Changes since RFC2:
 * Arrange commits to prevent failed build while bisecting.
 * Avoid dot2k generated files to reach the column limit. (Nam Cao)
 * Rearrange and simplify da_monitor retry on racing events.
 * Improve nrp monitor to handle /nested/ preemption on IRQ.
 * Added minor patches (6-10).
 * Cleanup and rearrange order.
Changes since RFC [2]:
 * Remove wakeup tracepoint in try_to_block_task and use a different
   flavour of sched_set_state
 * Split the large srs monitor in two separate monitors for preemption
   and sleep. These no longer have a concept of running task, they just
   enforce the requirements for the different types of sched out.
 * Restore the snroc monitor to describe the relationship between
   generic sched out and sched in.
 * Add opid monitor.
 * Fix some build errors and cleanup.

[1] - https://lore.kernel.org/lkml/20250715071434.22508-1-gmonaco@redhat.com
[2] - https://lore.kernel.org/lkml/20250404084512.98552-11-gmonaco@redhat.com

To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>

Gabriele Monaco (14):
  tools/rv: Do not skip idle in trace
  tools/rv: Stop gracefully also on SIGTERM
  rv: Add da_handle_start_run_event_ to per-task monitors
  rv: Remove trailing whitespace from tracepoint string
  rv: Return init error when registering monitors
  rv: Use strings in da monitors tracepoints
  rv: Adjust monitor dependencies
  verification/rvgen: Organise Kconfig entries for nested monitors
  tools/dot2c: Fix generated files going over 100 column limit
  rv: Retry when da monitor detects race conditions
  sched: Adapt sched tracepoints for RV task model
  rv: Replace tss and sncid monitors with more complete sts
  rv: Add nrp and sssw per-task monitors
  rv: Add opid per-cpu monitor

 Documentation/trace/rv/monitor_sched.rst      | 307 +++++++++++++++---
 include/linux/rv.h                            |   3 +-
 include/linux/sched.h                         |   7 +-
 include/rv/da_monitor.h                       | 129 +++++---
 include/trace/events/sched.h                  |  12 +-
 kernel/sched/core.c                           |  13 +-
 kernel/trace/rv/Kconfig                       |  16 +-
 kernel/trace/rv/Makefile                      |   6 +-
 kernel/trace/rv/monitors/{tss => nrp}/Kconfig |  12 +-
 kernel/trace/rv/monitors/nrp/nrp.c            | 138 ++++++++
 kernel/trace/rv/monitors/nrp/nrp.h            |  75 +++++
 kernel/trace/rv/monitors/nrp/nrp_trace.h      |  15 +
 kernel/trace/rv/monitors/opid/Kconfig         |  19 ++
 kernel/trace/rv/monitors/opid/opid.c          | 169 ++++++++++
 kernel/trace/rv/monitors/opid/opid.h          | 104 ++++++
 .../sncid_trace.h => opid/opid_trace.h}       |   8 +-
 kernel/trace/rv/monitors/sched/Kconfig        |   1 +
 kernel/trace/rv/monitors/sched/sched.c        |   3 +-
 kernel/trace/rv/monitors/sco/sco.c            |   7 +-
 kernel/trace/rv/monitors/scpd/Kconfig         |   2 +-
 kernel/trace/rv/monitors/scpd/scpd.c          |   7 +-
 kernel/trace/rv/monitors/sncid/sncid.c        |  96 ------
 kernel/trace/rv/monitors/sncid/sncid.h        |  49 ---
 kernel/trace/rv/monitors/snep/Kconfig         |   2 +-
 kernel/trace/rv/monitors/snep/snep.c          |   7 +-
 kernel/trace/rv/monitors/snep/snep.h          |  14 +-
 kernel/trace/rv/monitors/snroc/snroc.c        |   3 +-
 .../trace/rv/monitors/{sncid => sssw}/Kconfig |  10 +-
 kernel/trace/rv/monitors/sssw/sssw.c          | 116 +++++++
 kernel/trace/rv/monitors/sssw/sssw.h          | 105 ++++++
 kernel/trace/rv/monitors/sssw/sssw_trace.h    |  15 +
 kernel/trace/rv/monitors/sts/Kconfig          |  19 ++
 kernel/trace/rv/monitors/sts/sts.c            | 156 +++++++++
 kernel/trace/rv/monitors/sts/sts.h            | 117 +++++++
 .../{tss/tss_trace.h => sts/sts_trace.h}      |   8 +-
 kernel/trace/rv/monitors/tss/tss.c            |  91 ------
 kernel/trace/rv/monitors/tss/tss.h            |  47 ---
 kernel/trace/rv/monitors/wip/Kconfig          |   2 +-
 kernel/trace/rv/monitors/wip/wip.c            |   3 +-
 kernel/trace/rv/monitors/wwnr/wwnr.c          |   3 +-
 kernel/trace/rv/rv_trace.h                    | 114 ++++---
 tools/verification/models/sched/nrp.dot       |  29 ++
 tools/verification/models/sched/opid.dot      |  35 ++
 tools/verification/models/sched/sncid.dot     |  18 -
 tools/verification/models/sched/sssw.dot      |  30 ++
 tools/verification/models/sched/sts.dot       |  38 +++
 tools/verification/models/sched/tss.dot       |  18 -
 tools/verification/rv/src/in_kernel.c         |   4 +-
 tools/verification/rv/src/rv.c                |   1 +
 tools/verification/rvgen/rvgen/container.py   |  10 +
 tools/verification/rvgen/rvgen/dot2c.py       |  20 +-
 tools/verification/rvgen/rvgen/generator.py   |  16 +-
 52 files changed, 1723 insertions(+), 526 deletions(-)
 rename kernel/trace/rv/monitors/{tss => nrp}/Kconfig (51%)
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp.c
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp.h
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp_trace.h
 create mode 100644 kernel/trace/rv/monitors/opid/Kconfig
 create mode 100644 kernel/trace/rv/monitors/opid/opid.c
 create mode 100644 kernel/trace/rv/monitors/opid/opid.h
 rename kernel/trace/rv/monitors/{sncid/sncid_trace.h => opid/opid_trace.h} (66%)
 delete mode 100644 kernel/trace/rv/monitors/sncid/sncid.c
 delete mode 100644 kernel/trace/rv/monitors/sncid/sncid.h
 rename kernel/trace/rv/monitors/{sncid => sssw}/Kconfig (58%)
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw.c
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw.h
 create mode 100644 kernel/trace/rv/monitors/sssw/sssw_trace.h
 create mode 100644 kernel/trace/rv/monitors/sts/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sts/sts.c
 create mode 100644 kernel/trace/rv/monitors/sts/sts.h
 rename kernel/trace/rv/monitors/{tss/tss_trace.h => sts/sts_trace.h} (67%)
 delete mode 100644 kernel/trace/rv/monitors/tss/tss.c
 delete mode 100644 kernel/trace/rv/monitors/tss/tss.h
 create mode 100644 tools/verification/models/sched/nrp.dot
 create mode 100644 tools/verification/models/sched/opid.dot
 delete mode 100644 tools/verification/models/sched/sncid.dot
 create mode 100644 tools/verification/models/sched/sssw.dot
 create mode 100644 tools/verification/models/sched/sts.dot
 delete mode 100644 tools/verification/models/sched/tss.dot


base-commit: d086c886ceb9f59dea6c3a9dae7eb89e780a20c9
-- 
2.50.1


