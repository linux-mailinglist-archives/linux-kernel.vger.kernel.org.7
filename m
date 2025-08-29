Return-Path: <linux-kernel+bounces-791334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0E7B3B595
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078AA563FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB385286D66;
	Fri, 29 Aug 2025 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Nssw6Ra7"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB20262FC7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455109; cv=none; b=u4D5aAGcHknay+3WmKLQBADYtr3MDaJ7yOZHLCk5i2CcCuGgyDlQgegZqsqQ2C/6PmvUmCH+JAETGi3Sormto1dZ3uNDHdEF7JeJHkfM1HrZ4OH/R00oRaZIJ6+f4SntHaJfGhfS/Cg3sXfmMaXG4SBRjPfzMW5E8gc+3snWfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455109; c=relaxed/simple;
	bh=zCQNH4BaPyBqGMdV3nBlmP+DVxgOOo7vm3MMkIdKiLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SywRMP8Lq1UNKmz1EEPn6rr9WH1xhRvvCABcJt05RaXB2TkvJj//6qKNz/s9qBIpatUXAB9bskiV7mu9up20ry5tw3ZclSbLqwcf6TRNDqIy1tQ2U608VStRdJXacYMX2/03tUMTVPPSvYBUa08UXyV8T6l3jYL6jhzaCp/kfmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Nssw6Ra7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7722bcb989aso469705b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756455107; x=1757059907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pEbfSaBfjchfdJ7NFoKvsnY+rm5fzrc9wpWffuZATUQ=;
        b=Nssw6Ra7aW3W10w40/mSgjauB35vhORSutL6PEtYFrLI9Zw1m5gsU64VpJ1iEcRqAo
         Sw4nj9MAkxbP3TgJaoJVMMZ8LbmxSyfg9tRoljamxNlDIJZO6v9EztU3y5O3KWnAin2m
         Z26425g2VRAz0HpKfiUOQWa+wnQz1nhB/Yzpyhnoki3dFVjfqraLqkDX1lUsAyxRDOnm
         kBa6lU5DAV9Cr6cj6o42y5tX9ZGfG36gG9I8L7+Ot+GzpchB3nCl+91fcvTUYSWBW9Oo
         wH5XC2pkywhM+v4WtpMef+v58E+9vzNEVPSwciru6OmGq5MQcalkXlXy7sH2Qu5X5wjs
         3RsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756455107; x=1757059907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEbfSaBfjchfdJ7NFoKvsnY+rm5fzrc9wpWffuZATUQ=;
        b=iip9iw1j/Nl/u1SN1bFvy/qB9EYwAWYKyczJ0FuBNEiEkRa65+VV/M/1xLeiaGdAw0
         zw2Vc+Br9Hxu19eq5NMShxX/AbvQKurV1p5a9jdmYP702z69dPNx7w6SnAlh+p0ZY1q5
         PinxsP+AEe/ApMPnaG0rl4Av9HS0Ztu1uUx2OEq+Rhcxj/znA0ZlJcVJ034OR59j4k1v
         zXVDCmIRnT9TPGi13qCl9rO3RROY9YtdE4glFwCKkQcH9GyU41l13KsH+lvLgr37rJLO
         7prfamVtRiBZH5qkCh4gochLpCV20A7ET9sT+V8hhHVZ5Wryht7BTLUxRMMTMM4rOdsb
         hGbw==
X-Gm-Message-State: AOJu0Yyy2ZwDQycvxz5Hl2gHKKp/e6TTRAJWdaxzbn9HrFb6oYmk4C/1
	fxeJX/i7RVvqzemadE544dxaSj1VUsfoeuWOQsLgAQoKWWESDNYzctBZoKXNx7PWAw==
X-Gm-Gg: ASbGncsx9fBAQbbRHthbwDq98lzZ2SoIWoOedwPgGdBQLFjYIVi7VbUCzaHGyy/j9cr
	9XEUwzwD4CTHUKp2a5G/YYM/Mw8wB/tXvmXpxHZZTIXwIsE9GtCU0Jv1HnkJBxZWcF7Tf2eqYNf
	TompS9CxP92q6Qxrke183pLbDMvhUCFFl04x5PcL+fb8OOi971lGkw/ycgxcIxMs07H7k2H5+r3
	nwpPNWDHXZ5Y2sq811hgnx4gbdalVeO6bMYN8dwv+QTcSgCzb7c7dsJqus8NvL9jSLMGUxLGCWz
	qMi+A/CI3X9R8ltbqTctPRXRyhuFQEjFXjZ6XXTTc4PUMrIFEo5X0Mf2RgFVI2dv7TUYUMICiUn
	BgqkG8VrnqNmzWX1gGxJAquJjGXrpBZQ7q5bQeZ5u2gUkwAsUrdyUUIsz73O+581rsBZriZq6Lp
	5VH+s=
X-Google-Smtp-Source: AGHT+IG306jMTmeTZo1H5yp0x7w9unfYixS0fxAixXPsE7iNgqGlOSVWOFQj2uOznIdNoxkjJvFf+Q==
X-Received: by 2002:a05:6a00:18a9:b0:772:553:934b with SMTP id d2e1a72fcca58-77205539ac5mr12488658b3a.31.1756455107120;
        Fri, 29 Aug 2025 01:11:47 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2da9c6sm1601419b3a.42.2025.08.29.01.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:11:46 -0700 (PDT)
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
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 0/5] Defer throttle when task exits to user
Date: Fri, 29 Aug 2025 16:11:15 +0800
Message-Id: <20250829081120.806-1-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
- Add cfs_bandwidth_used() in task_is_throttled() and remove unlikely
  for task_is_throttled(), suggested by Valetin Schneider;
- Add a warn for non empty throttle_node in enqueue_throttled_task(),
  suggested by Valetin Schneider;
- Improve comments in enqueue_throttled_task() by Valetin Schneider;
- Clear throttled for to-be-unthrottled tasks in tg_unthrottle_up();
- Change throttled and pelt_clock_throttled fields in cfs_rq from int to
  bool, reported by LKP;
- Improve changelog for patch4 by Valetin Schneider.

Thanks a lot for all the reviews and tests, I hope I didn't miss any of
them but if I do, please let me know. I've also run Jan's rt reproducer
and songtang's stress test and didn't notice any problem.

Apply on top of sched/core, head commit 1b5f1454091e("sched/idle: Remove
play_idle()").

v3:
- Keep throttled cfs_rq's PELT clock run as long as it still has entity
  queued, suggested by Benjamin Segall; I've folded this change into
  patch3;
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

Below is previous changelogs:

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
 kernel/sched/fair.c   | 458 ++++++++++++++++++++++++------------------
 kernel/sched/pelt.h   |   4 +-
 kernel/sched/sched.h  |   7 +-
 5 files changed, 280 insertions(+), 197 deletions(-)


base-commit: 1b5f1454091e9e9fb5c944b3161acf4ec0894d0d
-- 
2.39.5


