Return-Path: <linux-kernel+bounces-748054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182E6B13C00
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12CC817E9AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F7D26B75C;
	Mon, 28 Jul 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqJiKs02"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E936326B2CE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710645; cv=none; b=FDbHFalcfkwR9LL6hqTj+22gyu9X9VCEi2l27CcEzBQbz+P0+i2BfZtfpkUSgUrpqTik4n8BdPUyFLrG6ValeveIQwsm4iTZy/3XeviXKs2T8eSvxVBVcbY5yK7THVOsCO+ProJWzCwlA1qWsjiu0wz3hHOImlmRerdJcMEBVrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710645; c=relaxed/simple;
	bh=bieLIgNd+EOZuwwUucuKU2Sg8hOtmNS6ilIE4ELil9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OegrPIkSGj+GRVlzM/N1+AEUiztfl3Zdf620vsVM9mE2Fq05LYk5pCABpuy0iv7gcCRvVlJ7juV+H13KEXWM7IttCZL45Z1Buf2GbIjsgkfWHvR1zYyZynJAYSP6a+kCQQD8k817b9ZhcnbepHrbTOcAuZQ56UX6PdSP3H01mSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqJiKs02; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753710642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BFZRIjcU10MaHofI5gsqySR5reNOh0P7ysmeezziIFE=;
	b=FqJiKs021UULQaoNNzC5pyCmE7G86fMeOgQLGWoKrsS7sy/dZIZCgErYf8AD7orX4CrsJI
	J2h2N0sxdd0bVzj8M9fuO7TJTzN3LTpuxcSdzPOxxDc+9FNk2+e0V9kWubSJD6MSJZAyku
	BQWUa4IZKlzEIRqHDneENir1Y35rjwk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-117-rodV-21BMWGS2kmYRoaiOg-1; Mon,
 28 Jul 2025 09:50:39 -0400
X-MC-Unique: rodV-21BMWGS2kmYRoaiOg-1
X-Mimecast-MFC-AGG-ID: rodV-21BMWGS2kmYRoaiOg_1753710638
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EB541956096;
	Mon, 28 Jul 2025 13:50:38 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.215])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8AE781800285;
	Mon, 28 Jul 2025 13:50:33 +0000 (UTC)
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
Subject: [PATCH v5 0/9] rv: Add monitors to validate task switch
Date: Mon, 28 Jul 2025 15:50:12 +0200
Message-ID: <20250728135022.255578-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

Also include some minor cleanup patches (1-4) tracepoints (6) and
preparatory fixes (5) covering some corner cases:

The series is currently based on the tracing rv/for-next tree.

Patch 1 adds da_handle_start_run_event_ also to per-task monitors

Patch 2 removes a trailing whitespace from the rv tracepoint string

Patch 3 fixes an out-of-bound memory access in DA tracepoints

Patch 4 adjusts monitors to have minimised Kconfig dependencies

Patch 5 detects race conditions when rv monitors run concurrently and
retries applying the events

Patch 6 adds the need_resched and removes unused arguments from
schedule entry/exit tracepoints

Patch 7 adds the sts monitor to replace tss and sncid

Patch 8 adds the nrp and sssw monitors

Patch 9 adds the opid monitor

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

Changes since V4:
* Drop already applied patches for the tools/ directory
* Avoid using smp_processor_id() from tracepoint context

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

Gabriele Monaco (9):
  rv: Add da_handle_start_run_event_ to per-task monitors
  rv: Remove trailing whitespace from tracepoint string
  rv: Use strings in da monitors tracepoints
  rv: Adjust monitor dependencies
  rv: Retry when da monitor detects race conditions
  sched: Adapt sched tracepoints for RV task model
  rv: Replace tss and sncid monitors with more complete sts
  rv: Add nrp and sssw per-task monitors
  rv: Add opid per-cpu monitor

 Documentation/trace/rv/monitor_sched.rst      | 307 +++++++++++++++---
 include/linux/rv.h                            |   3 +-
 include/linux/sched.h                         |   7 +-
 include/rv/da_monitor.h                       | 131 +++++---
 include/trace/events/sched.h                  |  12 +-
 kernel/sched/core.c                           |  13 +-
 kernel/trace/rv/Kconfig                       |  11 +-
 kernel/trace/rv/Makefile                      |   6 +-
 kernel/trace/rv/monitors/{tss => nrp}/Kconfig |  12 +-
 kernel/trace/rv/monitors/nrp/nrp.c            | 138 ++++++++
 kernel/trace/rv/monitors/nrp/nrp.h            |  75 +++++
 kernel/trace/rv/monitors/nrp/nrp_trace.h      |  15 +
 kernel/trace/rv/monitors/opid/Kconfig         |  19 ++
 kernel/trace/rv/monitors/opid/opid.c          | 168 ++++++++++
 kernel/trace/rv/monitors/opid/opid.h          | 104 ++++++
 .../sncid_trace.h => opid/opid_trace.h}       |   8 +-
 kernel/trace/rv/monitors/sched/Kconfig        |   1 +
 kernel/trace/rv/monitors/sco/sco.c            |   4 +-
 kernel/trace/rv/monitors/scpd/Kconfig         |   2 +-
 kernel/trace/rv/monitors/scpd/scpd.c          |   4 +-
 kernel/trace/rv/monitors/sncid/sncid.c        |  95 ------
 kernel/trace/rv/monitors/sncid/sncid.h        |  49 ---
 kernel/trace/rv/monitors/snep/Kconfig         |   2 +-
 kernel/trace/rv/monitors/snep/snep.c          |   4 +-
 .../trace/rv/monitors/{sncid => sssw}/Kconfig |  10 +-
 kernel/trace/rv/monitors/sssw/sssw.c          | 116 +++++++
 kernel/trace/rv/monitors/sssw/sssw.h          | 105 ++++++
 kernel/trace/rv/monitors/sssw/sssw_trace.h    |  15 +
 kernel/trace/rv/monitors/sts/Kconfig          |  19 ++
 kernel/trace/rv/monitors/sts/sts.c            | 156 +++++++++
 kernel/trace/rv/monitors/sts/sts.h            | 117 +++++++
 .../{tss/tss_trace.h => sts/sts_trace.h}      |   8 +-
 kernel/trace/rv/monitors/tss/tss.c            |  90 -----
 kernel/trace/rv/monitors/tss/tss.h            |  47 ---
 kernel/trace/rv/monitors/wip/Kconfig          |   2 +-
 kernel/trace/rv/rv_trace.h                    | 114 ++++---
 tools/verification/models/sched/nrp.dot       |  29 ++
 tools/verification/models/sched/opid.dot      |  35 ++
 tools/verification/models/sched/sncid.dot     |  18 -
 tools/verification/models/sched/sssw.dot      |  30 ++
 tools/verification/models/sched/sts.dot       |  38 +++
 tools/verification/models/sched/tss.dot       |  18 -
 42 files changed, 1665 insertions(+), 492 deletions(-)
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


base-commit: b8a7fba39cd49eab343bfe561d85bb5dc57541af
-- 
2.50.1


