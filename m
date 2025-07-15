Return-Path: <linux-kernel+bounces-731330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25725B052AD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B57997B1D53
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852E22D5C6B;
	Tue, 15 Jul 2025 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ob916dEN"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CECB26CE27
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563844; cv=none; b=hjdY7q9pcXhsmOUYPLNyYWsgY565rS4ZxBMHa6KTNdKJwhAH+VQk4O4ycmeYCLaltnmm7oy+iMEH87FlH2chwNqNXiLcnVbIAYkQZuKdujDNlPcv28ua+UonpI4jxJ3qG4s+eSlEz2GqFCBr+S7nZMKjEJYX8qxYaUlINQVgAyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563844; c=relaxed/simple;
	bh=ru1i/LPURJ6Lf5JGr6Er0NvlJIdtUWJDNSnBbX4t8cA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oYUeOlr4eJVjREQ6JhPo1jNdMb7FyD9gBjSGO1JwQcBx+T9F/IsEWAI8IpCWLdKTYZ0sVNJkN0nPUc37kDyeuY2ubwvIJU0Hl1Seb+hfqor0tNSgP+4Spx9RGLHkw62oK+ghNrHZVZYIo+0LeqgCt5yXZPLV+zZPrzv+dw7Lu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ob916dEN; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so2365878a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752563841; x=1753168641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSH5dX2SXMJpq5gzI6eVHCDlLttLnz9OGbAWQJxJlj4=;
        b=Ob916dENbiBXPs8ZHUPdnSQSNewUmXa0rbd3fxGq/eMiRrzxCw+xhw5uOEZrZzZH+z
         DkSdM0o8fq/4WLu6zDq1A9lkFhcLoeKI8a806VBU2Q/3dCtvEH5r+vPKBPzX4w8Z/BZF
         h2/UPFvKCcJqaRAqaMQYuvpYZD6aKZVbZuxOS4Bzz28lJtVH6xO/I0a6M2auB1C3JU44
         gEmkcCEWhL0+4PPwvQC6/8c8rpS8TSGqn+Kh5rj0YwNCQFyOFR6OYP+aLER/Uw3YfSHb
         Go73AQe9h44emfXE/DG4DZ9VZS5GwqbXlX95zM+8eqPTZ8+WDni5r/OBb7GMn+7Q4GqK
         UZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752563841; x=1753168641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSH5dX2SXMJpq5gzI6eVHCDlLttLnz9OGbAWQJxJlj4=;
        b=rgghSuBgJS6oHuZh4zBS09EmhV1nAL7/YRdOLDxmnS8RZlP0IJ6R1cPRKCtl0EYZE7
         p7yI9eiSGcisMpLj0i49/ccqFH6FXw1R1CckMbLeL24I8Ehf1llxlJt0UUg68PIXtHza
         TRTlVKQY/SttpQxCd1fr5uAyNqhw9ji6okYPUv4c6/PqTQQ1WPB2uiyUgzUntGmw1L9j
         QemOWV2vYn3HoBck1OMc7Fw9TbeTHaslDJcMBWasAW+HeMmDxP5vCpsokFQ26uyI3609
         jYaPlmkQ8Ih3jdCLSp8JQIWh66WfyIUaudV3pCrWCqyAHxm4WIXjALtBMLFDmDFQ3wnz
         aRTw==
X-Gm-Message-State: AOJu0YzPHPpycxwwSrKo73i2O7UGfSj+VfJNz2ZEWWz3noMFaUzPCWFp
	UL67uaUIytq+I4ol0FvaXBk5N+Iy/gLSdOYHxKnELaoj0RjZZgFB+T4N7ukYlH0r9Q==
X-Gm-Gg: ASbGncvqzwZfA0VHVor3jbrHbyKl2PX5NkEmg8P9QysoYMU+mQaSbG9d6nvf8cxz49d
	ObprDkrUqgjcl6Xa+Obj5AZytx2mUyw6tbNHXH+k2AYZ1aY0vgurYaB1KUdlIMWnNVcnsXWtg1V
	NVLRH6QC1tJ6I9DTMH1I9TsEP9OkhrTD5Ja9wnPqkmQeeoI3cmItRTW24w8+pBcpDVej9g+HJwc
	X6v6Xhgp2H/CzC1EdaT2N4albVZlDCajp1kbsNWsx6buMHMREmiB6eQNQ9Ja09nK7DKGE3BKxLG
	FDJ3hal1WFV4lIqRo47PaMQj6eiMgw38f6YxIvGA5uqlE0F7hyupAU+GwPedyVCxuYKjsXM8rRK
	4K/wOEMLcv+rCTQ6AUL79fpALUtENRkj/Q3pZhKh/Y4582bWyAZgYq6I6isKf9uvkOhzg
X-Google-Smtp-Source: AGHT+IGU4Lrvwm89T8/ili8Gbf+xUUtj5a6O4mbCRU1RitwKnN8Qsg85rYM37G6ypD288hDhxLP4hA==
X-Received: by 2002:a17:90b:57c5:b0:311:b3e7:fb38 with SMTP id 98e67ed59e1d1-31c50e17631mr20694497a91.19.1752563841385;
        Tue, 15 Jul 2025 00:17:21 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017c9dasm15013418a91.25.2025.07.15.00.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 00:17:20 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>
Subject: [PATCH v3 0/5] Defer throttle when task exits to user
Date: Tue, 15 Jul 2025 15:16:53 +0800
Message-Id: <20250715071658.267-1-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
- Keep throttled cfs_rq's PELT clock running as long as it still has
  entity queued, suggested by Benjamin Segall. I've folded this change
  into patch3;
- Rebased on top of tip/sched/core, commit 2885daf47081
  ("lib/smp_processor_id: Make migration check unconditional of SMP").

Hi Prateek,
I've kept your tested-by tag(Thanks!) for v2 since I believe this pelt
clock change should not affect things much, but let me know if you don't
think that is appropriate.

Tests I've done:
- Jan's rt deadlock reproducer[1]. Without this series, I saw rcu-stalls
  within 2 minutes and with this series, I do not see rcu-stalls after
  10 minutes.
- A stress test that creates a lot of pressure on fork/exit path and
  cgroup_threadgroup_rwsem. Without this series, the test will cause
  task hung in about 5 minutes and with this series, no problem found
  after several hours. Songtang wrote this test script and I've used it
  to verify the patches, thanks Songtang.

[1]: https://lore.kernel.org/all/7483d3ae-5846-4067-b9f7-390a614ba408@siemens.com/

v2:
- Re-org the patchset to use a single patch to implement throttle
  related changes, suggested by Chengming;
- Use check_cfs_rq_runtime()'s return value in pick_task_fair() to
  decide if throttle task work is needed instead of checking
  throttled_hierarchy(), suggested by Peter;
- Simplify throttle_count check in tg_throtthe_down() and
  tg_unthrottle_up(), suggested by Peter;
- Add enqueue_throttled_task() to speed up enqueuing a throttled task to
  a throttled cfs_rq, suggested by Peter;
- Address the missing of detach_task_cfs_rq() for throttled tasks that
  get migrated to a new rq, pointed out by Chengming;
- Remove cond_resched_tasks_rcu_qs() in throttle_cfs_rq_work() as
  cond_resched*() is going away, pointed out by Peter.
I hope I didn't miss any comments and suggestions for v1 and if I do,
please kindly let me know, thanks!

Base: tip/sched/core commit dabe1be4e84c("sched/smp: Use the SMP version
of double_rq_clock_clear_update()")

cover letter of v1:

This is a continuous work based on Valentin Schneider's posting here:
Subject: [RFC PATCH v3 00/10] sched/fair: Defer CFS throttle to user entry
https://lore.kernel.org/lkml/20240711130004.2157737-1-vschneid@redhat.com/

Valentin has described the problem very well in the above link and I
quote:
"
CFS tasks can end up throttled while holding locks that other,
non-throttled tasks are blocking on.

For !PREEMPT_RT, this can be a source of latency due to the throttling
causing a resource acquisition denial.

For PREEMPT_RT, this is worse and can lead to a deadlock:
o A CFS task p0 gets throttled while holding read_lock(&lock)
o A task p1 blocks on write_lock(&lock), making further readers enter
the slowpath
o A ktimers or ksoftirqd task blocks on read_lock(&lock)

If the cfs_bandwidth.period_timer to replenish p0's runtime is enqueued
on the same CPU as one where ktimers/ksoftirqd is blocked on
read_lock(&lock), this creates a circular dependency.

This has been observed to happen with:
o fs/eventpoll.c::ep->lock
o net/netlink/af_netlink.c::nl_table_lock (after hand-fixing the above)
but can trigger with any rwlock that can be acquired in both process and
softirq contexts.

The linux-rt tree has had
  1ea50f9636f0 ("softirq: Use a dedicated thread for timer wakeups.")
which helped this scenario for non-rwlock locks by ensuring the throttled
task would get PI'd to FIFO1 (ktimers' default priority). Unfortunately,
rwlocks cannot sanely do PI as they allow multiple readers.
"

Jan Kiszka has posted an reproducer regarding this PREEMPT_RT problem :
https://lore.kernel.org/r/7483d3ae-5846-4067-b9f7-390a614ba408@siemens.com/
and K Prateek Nayak has an detailed analysis of how deadlock happened:
https://lore.kernel.org/r/e65a32af-271b-4de6-937a-1a1049bbf511@amd.com/

To fix this issue for PREEMPT_RT and improve latency situation for
!PREEMPT_RT, change the throttle model to task based, i.e. when a cfs_rq
is throttled, mark its throttled status but do not remove it from cpu's
rq. Instead, for tasks that belong to this cfs_rq, when they get picked,
add a task work to them so that when they return to user, they can be
dequeued. In this way, tasks throttled will not hold any kernel resources.
When cfs_rq gets unthrottled, enqueue back those throttled tasks.

There are consequences because of this new throttle model, e.g. for a
cfs_rq that has 3 tasks attached, when 2 tasks are throttled on their
return2user path, one task still running in kernel mode, this cfs_rq is
in a partial throttled state:
- Should its pelt clock be frozen?
- Should this state be accounted into throttled_time?

For pelt clock, I chose to keep the current behavior to freeze it on
cfs_rq's throttle time. The assumption is that tasks running in kernel
mode should not last too long, freezing the cfs_rq's pelt clock can keep
its load and its corresponding sched_entity's weight. Hopefully, this can
result in a stable situation for the remaining running tasks to quickly
finish their jobs in kernel mode.

For throttle time accounting, according to RFC v2's feedback, rework
throttle time accounting for a cfs_rq as follows:
- start accounting when the first task gets throttled in its
  hierarchy;
- stop accounting on unthrottle.

There is also the concern of increased duration of (un)throttle operations
in RFC v1. I've done some tests and with a 2000 cgroups/20K runnable tasks
setup on a 2sockets/384cpus AMD server, the longest duration of
distribute_cfs_runtime() is in the 2ms-4ms range. For details, please see:
https://lore.kernel.org/lkml/20250324085822.GA732629@bytedance/
For throttle path, with Chengming's suggestion to move "task work setup"
from throttle time to pick time, it's not an issue anymore.

Aaron Lu (2):
  sched/fair: Task based throttle time accounting
  sched/fair: Get rid of throttled_lb_pair()

Valentin Schneider (3):
  sched/fair: Add related data structure for task based throttle
  sched/fair: Implement throttle task work and related helpers
  sched/fair: Switch to task based throttle model

 include/linux/sched.h |   5 +
 kernel/sched/core.c   |   3 +
 kernel/sched/fair.c   | 451 ++++++++++++++++++++++++------------------
 kernel/sched/pelt.h   |   4 +-
 kernel/sched/sched.h  |   7 +-
 5 files changed, 274 insertions(+), 196 deletions(-)

-- 
2.39.5


