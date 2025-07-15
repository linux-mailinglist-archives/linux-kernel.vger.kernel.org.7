Return-Path: <linux-kernel+bounces-731306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B515B0527B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99ECB3A947E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EEC26E6E6;
	Tue, 15 Jul 2025 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLEyAL8Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B126560D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563700; cv=none; b=bfD8FIwHnBsmkXK4L5AS0Ii6s5kx0ISbc2C8yWRWJzgJiEaSHAaGJZ6HLYHU3kNrnG7C6D/ZAgZhAxqxp7zNbeG+jIqhJ3VIxQLMWrH9W2tHlGHVXOiiaHbX7EnyyFICe6zgEcIctsM+3WaVi88OC7fsYZ0+scRtkJC+O4UJUf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563700; c=relaxed/simple;
	bh=y2TJbtDD35MqDLnSgvFB1Qm518YIME38oBGwkN9GunQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMWwsPouGvFJhJ7njaTpqTXDW672FHOc/HI9kVvfvlwFg/3JGfsl7FTVP7PolYrK1gou62+vy7yAYaNMpBOHD77l/t9+qcmganZ6ylQi+IoJM5gt46SDONpJdrnIXNUKNR4Rvb5Ut8M9BN+1Gj5Ag26TD9t2yS70oNpA04ZwKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLEyAL8Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752563697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NRO+yUPGIVQSR4laeBohZ2Ii8Yl1IGq9tVGefxhngOY=;
	b=KLEyAL8ZCGUaKR9qEG7QSac09mitJu+9cwoQ60cK1ii4pQsHwT9lvRbIukTnKIAdw0NZVI
	BYZWye/DghXk9TgCMb3jrNejtQRNrPqAtSt92WYb2El/BUfz6c/JpQE2NNq4EHOZhl99l+
	Haqa7byz/0umakxvnBoeSbMuIWiK75k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-CJydgR4YO8CTydbz5cFvMg-1; Tue,
 15 Jul 2025 03:14:53 -0400
X-MC-Unique: CJydgR4YO8CTydbz5cFvMg-1
X-Mimecast-MFC-AGG-ID: CJydgR4YO8CTydbz5cFvMg_1752563692
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FCED18089B8;
	Tue, 15 Jul 2025 07:14:52 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB68418046C6;
	Tue, 15 Jul 2025 07:14:46 +0000 (UTC)
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
Subject: [PATCH v3 00/17] rv: Add monitors to validate task switch
Date: Tue, 15 Jul 2025 09:14:17 +0200
Message-ID: <20250715071434.22508-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This series adds three monitors to the sched collection, extends and
replaces previously existing monitors:

tss => sts:
Not only prove that switches occur in scheduling context but also that
each call to the scheduler implies a switch (also a vain one) and
disables interrupts doing so.

sco:
The sched_set_state tracepoint can now be called from scheduling context
in a particular condition, that is when there is a pending signal. Adapt
the monitor to cover this scenario.

snroc:
Include sched_switch_vain as transition only possible in own context,
this model is also required to keep the following two models simple.

nrp (NEW):
* preemption requires need resched which is cleared by any switch
  (includes a non optimal workaround for /nested/ preemptions)

sssw (NEW):
* suspension requires setting the task to sleepable and, after the
  switch occurs, the task requires a wakeup to come back to runnable

opid (NEW):
* waking and need-resched operations occur with interrupts and
  preemption disabled or in IRQ without explicitly disabling preemption

Also include some minor cleanup patches (1-10) tracepoints (12) and
preparatory fixes (11) covering some corner cases:

The series is currently based on the trace/for-next tree [1] as it
requires some other patches on RV.

Patch 1 fixes the behaviour of the rv tool with -s and idle tasks.

Patch 2 allows the rv tool to gracefully terminate with SIGTERM

Patch 3 adds da_handle_start_run_event_ also to per-task monitors

Patch 4 removes a trailing whitespace from the rv tracepoint string

Patch 5 returns the registration error in all DA monitor instead of 0

Patch 6 fixes an out-of-bound memory access in DA tracepoints

Patch 7 adjusts monitors to have minimised Kconfig dependencies

Patch 8 properly orders nested monitors in the RV Kconfig file

Patch 9 adjusts dot2c not to create lines over 100 columns

Patch 10 adapts monitors headers based on patch 9

Patch 11 detects race conditions when rv monitors run concurrently and
retries applying the events

Patch 12 adds the need_resched and switch_vain tracepoints and adds a
parameter to the sched_set_state tracepoint

Patch 13 adapts the sco monitor to the new version of sched_set_state

Patch 14 extends the snroc model and adapts it to the new sched_set_state

Patch 15 adds the sts monitor to replace tss

Patch 16 adds the nrp and sssw monitors

Patch 17 adds the opid monitor

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
  but it makes the model weaker. In fact, we are not proving that:
   1. we don't miss any event setting need_resched
   2. we don't preempt when not required
  Future versions of the monitor may weaken assumptions only when we
  register an interrupt.

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

[1] - git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
[2] - https://lore.kernel.org/lkml/20250404084512.98552-11-gmonaco@redhat.com

To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>

Gabriele Monaco (16):
  tools/rv: Do not skip idle in trace
  tools/rv: Stop gracefully also on SIGTERM
  rv: Add da_handle_start_run_event_ to per-task monitors
  rv: Remove trailing whitespace from tracepoint string
  rv: Return init error when registering monitors
  rv: Use strings in da monitors tracepoints
  rv: Adjust monitor dependencies
  verification/rvgen: Organise Kconfig entries for nested monitors
  rv: Fix generated files going over 100 column limit
  rv: Retry when da monitor detects race conditions
  sched: Adapt sched tracepoints for RV task model
  rv: Adapt the sco monitor to the new set_state
  rv: Extend snroc model
  rv: Replace tss monitor with more complete sts
  rv: Add nrp and sssw per-task monitors
  rv: Add opid per-cpu monitor

Nam Cao (1):
  tools/dot2c: Fix generated files going over 100 column limit

 Documentation/trace/rv/monitor_sched.rst      | 354 +++++++++++++++---
 include/linux/rv.h                            |   3 +-
 include/linux/sched.h                         |   7 +-
 include/rv/da_monitor.h                       | 115 +++---
 include/trace/events/sched.h                  |  17 +-
 kernel/sched/core.c                           |  10 +-
 kernel/trace/rv/Kconfig                       |  10 +-
 kernel/trace/rv/Makefile                      |   5 +-
 kernel/trace/rv/monitors/{tss => nrp}/Kconfig |  10 +-
 kernel/trace/rv/monitors/nrp/nrp.c            | 146 ++++++++
 kernel/trace/rv/monitors/nrp/nrp.h            |  87 +++++
 kernel/trace/rv/monitors/nrp/nrp_trace.h      |  15 +
 kernel/trace/rv/monitors/opid/Kconfig         |  17 +
 kernel/trace/rv/monitors/opid/opid.c          | 169 +++++++++
 kernel/trace/rv/monitors/opid/opid.h          | 104 +++++
 kernel/trace/rv/monitors/opid/opid_trace.h    |  15 +
 kernel/trace/rv/monitors/sched/Kconfig        |   1 +
 kernel/trace/rv/monitors/sched/sched.c        |   3 +-
 kernel/trace/rv/monitors/sco/sco.c            |  11 +-
 kernel/trace/rv/monitors/sco/sco.h            |  16 +-
 kernel/trace/rv/monitors/scpd/Kconfig         |   2 +-
 kernel/trace/rv/monitors/scpd/scpd.c          |   3 +-
 kernel/trace/rv/monitors/sleep/sleep.c        |   3 +-
 kernel/trace/rv/monitors/sncid/Kconfig        |   2 +-
 kernel/trace/rv/monitors/sncid/sncid.c        |   3 +-
 kernel/trace/rv/monitors/snep/Kconfig         |   2 +-
 kernel/trace/rv/monitors/snep/snep.c          |   3 +-
 kernel/trace/rv/monitors/snep/snep.h          |  14 +-
 kernel/trace/rv/monitors/snroc/snroc.c        |  15 +-
 kernel/trace/rv/monitors/snroc/snroc.h        |  18 +-
 kernel/trace/rv/monitors/sssw/Kconfig         |  15 +
 kernel/trace/rv/monitors/sssw/sssw.c          | 115 ++++++
 kernel/trace/rv/monitors/sssw/sssw.h          |  97 +++++
 kernel/trace/rv/monitors/sssw/sssw_trace.h    |  15 +
 kernel/trace/rv/monitors/sts/Kconfig          |  18 +
 kernel/trace/rv/monitors/sts/sts.c            | 117 ++++++
 kernel/trace/rv/monitors/sts/sts.h            |  97 +++++
 .../{tss/tss_trace.h => sts/sts_trace.h}      |   8 +-
 kernel/trace/rv/monitors/tss/tss.c            |  91 -----
 kernel/trace/rv/monitors/tss/tss.h            |  47 ---
 kernel/trace/rv/monitors/wip/Kconfig          |   2 +-
 kernel/trace/rv/monitors/wip/wip.c            |   3 +-
 kernel/trace/rv/monitors/wwnr/wwnr.c          |   3 +-
 kernel/trace/rv/rv_trace.h                    |  89 ++---
 tools/verification/models/sched/nrp.dot       |  29 ++
 tools/verification/models/sched/opid.dot      |  35 ++
 tools/verification/models/sched/sco.dot       |   1 +
 tools/verification/models/sched/snroc.dot     |   2 +-
 tools/verification/models/sched/sssw.dot      |  24 ++
 tools/verification/models/sched/sts.dot       |  29 ++
 tools/verification/models/sched/tss.dot       |  18 -
 tools/verification/rv/src/in_kernel.c         |   2 +-
 tools/verification/rv/src/rv.c                |   1 +
 tools/verification/rvgen/rvgen/container.py   |  13 +
 tools/verification/rvgen/rvgen/dot2c.py       |  19 +-
 tools/verification/rvgen/rvgen/generator.py   |  13 +-
 56 files changed, 1730 insertions(+), 353 deletions(-)
 rename kernel/trace/rv/monitors/{tss => nrp}/Kconfig (60%)
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp.c
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp.h
 create mode 100644 kernel/trace/rv/monitors/nrp/nrp_trace.h
 create mode 100644 kernel/trace/rv/monitors/opid/Kconfig
 create mode 100644 kernel/trace/rv/monitors/opid/opid.c
 create mode 100644 kernel/trace/rv/monitors/opid/opid.h
 create mode 100644 kernel/trace/rv/monitors/opid/opid_trace.h
 create mode 100644 kernel/trace/rv/monitors/sssw/Kconfig
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
 create mode 100644 tools/verification/models/sched/sssw.dot
 create mode 100644 tools/verification/models/sched/sts.dot
 delete mode 100644 tools/verification/models/sched/tss.dot


base-commit: 76604f9ce795edc8c134a6c60b76eb2999ecb739
-- 
2.50.1


