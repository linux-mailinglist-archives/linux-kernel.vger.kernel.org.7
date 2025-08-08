Return-Path: <linux-kernel+bounces-760708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD862B1EF21
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A511B5682A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19D21C8606;
	Fri,  8 Aug 2025 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIGSu3gw"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B31EA91
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754683410; cv=none; b=TRYnCfwKa1maGzqpNF/nZJe8gXd8NfxJqT1463ofVSD3L4WzR4i7jbLmJN/3M5fDhre83xGK23fLcYApdwSEqNy2/vuopPONbZ1AWJweTFMX1KcQ+TRsV9c67P1m/YOMclm/t9iecXiiL6g0/MU1ZlPkUKMIu2e16+OdLCXhdxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754683410; c=relaxed/simple;
	bh=NHKe/Vqs2b/5BO3fMhPremSz1yI2Dr+53Ovzh4Nso6o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z/H1IvYB26JuDbH+VlltWBzPsW+FUqzMYC8oVjWiidEpIzk7MS964zuEGx/P5biayyS1uiq960co7/u8F55PsDjHRvkA/qGwqjQe2+7YPSPpixKcko2gno1CEdmVZuQoJJBftxkvHI+ikQiGcbDUSS9Aomx3t7xSMVb3U3tMp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIGSu3gw; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-458bb0e68c6so13823445e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754683407; x=1755288207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IgXysI8LsmH3AABVbzfVn9mr5dVDf9rIwsMR0XgbT1s=;
        b=dIGSu3gwrhCeI59JXy/KS5ushmO+5KG6DBN3XZLDL0RMpkB6SfSxIT9lnhSNkhNPli
         g4NUttSyziJZzmpYl2BAfnszW7RRGVr/mAadWVVh14Tio5VOXZ8VPO8NEhqC2cZMDGNa
         U8B/hg8inxqgvLrZ1h2VrxAny2OW7yP6d+bAuGCgJEC4FbC98dwjRPok0lnkpqfyipUU
         aqciK0PoEHN7XmtKT093LAWKbYRIkxZhGcnrget98lNMwCEepyzaEoQuiwp9fNOvqRzM
         BHx4iB8sOxxRe6I9VwZv3HhQi+w8fubHUnYl7DTqJarmlobOqK9sLZwUVfZfUbDCchLr
         6ZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754683407; x=1755288207;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgXysI8LsmH3AABVbzfVn9mr5dVDf9rIwsMR0XgbT1s=;
        b=joML5ZVaU2q/Ud49k3P8uhDTUN5mtZVjB4sER9B/saW9Bm7V96vu64p7c8eKfc0Gce
         k+HU5S1/XrOJuJkVRZ1EX+8mK5DtX6PpDFKpIL9vkcUlX641VZvWtKtwUeZYTWXhJZgX
         ATm48U6aS8SXQGEUHVXcOD88ill2NEd+7/prd9d7ChmSbZKZFlWwpy9Dyk/pxLBJEAWr
         KxrnhWraxk9V6qGdbT7H6O+bp7hQ4w9LgUp9ePFzqr8cwliIMEYxSdC+oGqt5DK4ST+f
         SIYZkjJng32ZnLU3qnVwm70iGUYIt5qAsMm3Usnb2Kk+WXQZMZpGbybcXWvIFlxHjoSD
         bB7Q==
X-Gm-Message-State: AOJu0Yz5UP7M94Q2j5eM5dQke57eqqtNqrD6iY59Rrp3AZEBG51kdQ6Z
	g4C8g01pguTnJt1pHjjfWG5have8RBKA/c7q9oeSqUuJqQu/bqZGGn6/BLw39LKraV2A3PKfqd4
	lWvyz+ZrO4cqMhQ==
X-Google-Smtp-Source: AGHT+IEenS/PToWIgfHKZcXJaOdrSeDnyl3dLubyWInIUkEO5p3TIPkXFgS37iXXEzozmq1VGfr8mk3yk4ypSw==
X-Received: from wmbhe13.prod.google.com ([2002:a05:600c:540d:b0:458:bf42:8343])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c9a:b0:456:1a87:a6cb with SMTP id 5b1f17b1804b1-459f59cf668mr38234365e9.19.1754683406939;
 Fri, 08 Aug 2025 13:03:26 -0700 (PDT)
Date: Fri,  8 Aug 2025 20:02:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250808200250.2016584-1-jpiecuch@google.com>
Subject: [RFC PATCH 0/3] sched: add ability to throttle sched_yield() calls to
 reduce contention
From: Kuba Piecuch <jpiecuch@google.com>
To: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, joshdon@google.com
Cc: linux-kernel@vger.kernel.org, Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

Problem statement
=================

Calls to sched_yield() can touch data shared with other threads.
Because of this, userspace threads could generate high levels of contention
by calling sched_yield() in a tight loop from multiple cores.

For example, if cputimer is enabled for a process (e.g. through
setitimer(ITIMER_PROF, ...)), all threads of that process
will do an atomic add on the per-process field
p->signal->cputimer->cputime_atomic.sum_exec_runtime inside
account_group_exec_runtime(), which is called inside update_curr().

Currently, calling sched_yield() will always call update_curr() at least
once in schedule(), and potentially one more time in yield_task_fair().
Thus, userspace threads can generate quite a lot of contention for the
cacheline containing cputime_atomic.sum_exec_runtime if multiple threads of
a process call sched_yield() in a tight loop.

At Google, we suspect that this contention led to a full machine lockup in
at least one instance, with ~50% of CPU cycles spent in the atomic add
inside account_group_exec_runtime() according to
`perf record -a -e cycles`.


Proposed solution
=================

To alleviate the contention, this patchset introduces the ability to limit
how frequently a thread is allowed to yield. It adds a new sched debugfs
knob called yield_interval_ns. A thread is allowed to yield at most once
every yield_interval_ns nanoseconds. Subsequent calls to sched_yield()
within the interval simply return without calling schedule().

The default value of the knob is 0, meaning the throttling feature is
disabled by default.


Performance
===========

To test the impact on performance and contention, we used a benchmark
consisting of a process with a profiling timer enabled and N threads
sequentially assigned to logical cores, with 2 threads per core. Each
thread calls sched_yield() in a tight loop. We measured the total number
of unthrottled sched_yield() calls made by all threads within a fixed time.
In addition, we recorded the benchmark runs with
`perf record -a -g -e cycles`. We used the perf data to determine the
percentage of CPU time spent in the problematic atomic add instruction and
used that as a measure of contention.
We ran the benchmark on an Intel Emerald Rapids CPU with 60 physical cores.

With throttling disabled, there was no measurable performance impact to
sched_yield().
Setting the interval to 1ns, which enables the throttling code but doesn't
actually throttle any calls to sched_yield(), results in a 1-3% penalty
for sched_yield() with low thread counts, but disappears quickly as the
thread count gets higher and contention becomes more of a factor.

With throttling disabled, CPU time spent in the atomic add instruction
for N=80 threads is roughly 80%.
By setting yield_interval_ns to 10000, the percentage decreases to 1-2%,
but the total number of unthrottled sched_yield() calls decreases by ~60%.


Alternatives considered
=======================

An alternative we considered was to make the cputime accounting more
scalable by accumulating a thread's cputime locally in task_struct and
flushing it to the process-wide cputime when it reaches some threshold
value or when the thread is taken off the CPU. However, we determined that
the implementation is too intrusive compared to the benefit it provided.
It also wouldn't address other potential points of contention on the
sched_yield() path.


Kuba Piecuch (3):
  sched: add bool return value to sched_class::yield_task()
  sched/fair: don't schedule() in yield if nr_running == 1
  sched/fair: add debugfs knob for yield throttling

 include/linux/sched.h    |  2 ++
 kernel/sched/core.c      |  1 +
 kernel/sched/deadline.c  |  4 +++-
 kernel/sched/debug.c     |  2 ++
 kernel/sched/ext.c       |  4 +++-
 kernel/sched/fair.c      | 35 +++++++++++++++++++++++++++++++++--
 kernel/sched/rt.c        |  3 ++-
 kernel/sched/sched.h     |  4 +++-
 kernel/sched/stop_task.c |  2 +-
 kernel/sched/syscalls.c  |  9 ++++++++-
 10 files changed, 58 insertions(+), 8 deletions(-)

-- 
2.51.0.rc0.155.g4a0f42376b-goog


