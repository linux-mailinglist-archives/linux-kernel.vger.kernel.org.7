Return-Path: <linux-kernel+bounces-799593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E836AB42E0F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0671C224A8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF42B19F127;
	Thu,  4 Sep 2025 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ayh4m/so"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A3B22301
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945329; cv=none; b=ehWEXymIYfQM5A0OLm1KaTTCQHJXI5TONRa8OvwaU7xvFMcP+8AVd+1YHyQ01xEOFqnvxsYMek0cA85qEjuU+6RquIWTP1Wfudosw2xWZAcO7US3xxBa0ODCxn7WlfxMpsHghEZ5GXxcSalYKW3Nf8E/ILhza/avu5bN/N1xE8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945329; c=relaxed/simple;
	bh=LCdk3I2Q74ZIL4ELbJS5XlkPOeXrIZJt/RuK5HlZwMg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GdHAYQFm/K8moa7nnjmLwPYQSV/INIGrOmiSBfgCNgAzE/anU+wpy8cxu3PhE/pjullTvrz2YgR4YacW3d0qQ1vfsBOSoXtUWt83u5z/n6se5tUOryR/P7ha5AxzmJfx/BPytj0sM3Dh0u1btzumDUT/8tI6XOIFhaepP3dI9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ayh4m/so; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-329ee69e7f1so289321a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 17:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756945325; x=1757550125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=thtWK0kyMSL+2gdsE6SEJtYcPIxqdLFPNRv8DyZlsx8=;
        b=Ayh4m/socUNNt/El3t7NzNdJrqRcS1NMtV09b84WDUSKOfSmqPSAnWxTkU7Dxwrljw
         OMgJWs/0zVgC5gX8I13EcnOtIZgItIwBabR9hWp/XhE09Qzx/vTPDfhc1ozoyAfGOtYx
         mMhek9vzWlpgGF/8JRa+s7PyZ6oUUIxt8uasSuTcg0omSUvIjpnRcEcfXaWCHzT9T1Nb
         DzSvr+NtZIfk8jzUdMbelGJnnSb2ngtZmaa+rP7N133ex7lDQs78JIXn9Vo+4ix2Rz5k
         Ks/6uSzKCv9ULlu5LQppYH+cSIPY8PRIBt0VDS6JPjhLOR5j6O1KAdEc6HTYqZ9KsvK+
         0FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756945325; x=1757550125;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thtWK0kyMSL+2gdsE6SEJtYcPIxqdLFPNRv8DyZlsx8=;
        b=In9Xu8+tSm7h/Ydwd2OSUVXhJ/wsPts+C7xt8p5KedUj/Zwkh/EYmcILw9YzHAk2Tz
         fG9fr9VECmqE0zAB5UbEiwLUDcwbgNDRUzXhgiW7gHQWsSiyTqFE0CViC4QdbFEpseoG
         lbC6Xtb0hpcdT+8nVQFZ2Boyulefay9AexneZl7aIeXBMtmfAPWwtsC1gHtskHd9YOBZ
         fbjw12MMILHwCdXcPG3SJmQ+H6t5JTQPZHkiEdZ5TJ+4R+3B2dfaPwgpIj8YY6iJQZeo
         RCzms9/Did715Q5/4v27K8rRiWCpBPED0HUk5rdpEvqhQEkI6AEg0YBfBQLbre5EU9zk
         6sXw==
X-Gm-Message-State: AOJu0YyBAQFVsLvq+p/Ve0uIb4291rkWvJYQ/LqqLnSPe7CbG6R5SaDq
	1j4J7ZZRF/MNlNEEzgXqxr9p7+xTQt6yj3fpC0evT/JCMNXrRdPFB6qrM/JtnrogWdfVxBt+qv4
	d97E34Qb7KMu2/R+dgpUnjyOgLQxi0Q97xC7fRclhiYzrj4c58iuPEpIZbA0iUqdNdFs9Jcddm/
	MOGN2rsdfmac6MktGItbXcqL0fkrd2og0AsfZxtoYP4K8lYNxf
X-Google-Smtp-Source: AGHT+IFeUtCyKYDUHICkzQ1CwjtGCM1yxxr34wdtskPisbt4oHq4UWpPwmLUyeiT0F3/9W0j7KVuvO3lpEJ8
X-Received: from pjbnb3.prod.google.com ([2002:a17:90b:35c3:b0:327:7070:5b73])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48c3:b0:327:f216:4360
 with SMTP id 98e67ed59e1d1-3281541434dmr22272717a91.8.1756945324532; Wed, 03
 Sep 2025 17:22:04 -0700 (PDT)
Date: Thu,  4 Sep 2025 00:21:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904002201.971268-1-jstultz@google.com>
Subject: [RESEND][PATCH v21 0/6] Donor Migration for Proxy Execution (v21)
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey All,

I didn't get any feedback on the last iteration, so I wanted to
resend this next chunk of the series: Donor Migration=20

The main change from v20 before it, is that I previously had
logic where the ww_mutex paths took the blocked_lock of the task
it was waking (either the lock waiter->task or owner), but in a
context from __mutex_lock_common() where we already held the
current->block_lock. This required using the spin_lock_nested()
annotation to keep lockdep happy, and I was leaning on the logic
that there is an implied order between running current and the
existing not-running lock waiters, which should avoid loops. In
the wound case, there is also an order used if the owners
context is younger, which sounded likely to avoid loops.

However, after thinking more about the wound case where we are
wounding a lock owner, since that owner is not waiting and could
be trying to acquire a mutex current owns, I couldn=E2=80=99t quite
convince myself we couldn=E2=80=99t get into a ABBA style deadlock with
the nested blocked_lock accesses (though, I=E2=80=99ve not been able to
contrive it to happen, but that doesn=E2=80=99t prove anything).

So the main difference in v21 is reworking of how we hold the
blocked_lock in the mutex_lock_common() code, reducing it so we
don=E2=80=99t call into ww_mutex paths while holding it. The
lock->waiter_lock still serializes things at top level, but the
blocked_lock isn=E2=80=99t held completely in parallel under that, and
is focused on its purpose of protecting the blocked_on,
blocked_on_state and similar proxy-related values in the task
struct.

I also did some cleanups to be more consistent in how the
blocked_on_state is handled. I had a few spots previously where
I was cheating and just set the value instead of going through
the helpers. And sure enough, in fixing those I realized there
were a few spots where I wasn=E2=80=99t always holding the right
blocked_lock, so some minor rework helped clean that up.

I=E2=80=99m trying to submit this larger work in smallish digestible
pieces, so in this portion of the series, I=E2=80=99m only submitting
for review and consideration the logic that allows us to do
donor(blocked waiter) migration, allowing us to proxy-execute
lock owners that might be on other cpu runqueues. This requires
some additional changes to locking and extra state tracking to
ensure we don=E2=80=99t accidentally run a migrated donor on a cpu it
isn=E2=80=99t affined to, as well as some extra handling to deal with
balance callback state that needs to be reset when we decide to
pick a different task after doing donor migration.

I=E2=80=99d love to get some feedback on any place where these patches
are confusing, or could use additional clarifications.

Also you can find the full proxy-exec series here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v21-6.17-=
rc4/
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v21-6.17-rc4

Issues still to address with the full series:
* Need to sort out what is needed for sched_ext to be ok with
  proxy-execution enabled. This is my next priority.

* K Prateek Nayak did some testing about a bit over a year ago
  with an earlier version of the full series and saw ~3-5%
  regressions in some cases. Need to re-evaluate this with the
  proxy-migration avoidance optimization Suleiman suggested
  having now been implemented.

* The chain migration functionality needs further iterations and
  better validation to ensure it truly maintains the RT/DL load
  balancing invariants (despite this being broken in vanilla
  upstream with RT_PUSH_IPI currently)

Future work:
* Expand to other locking primitives: Suleiman is looking at
  rw_semaphores, as that is another common source of priority
  inversion. Figuring out pi-futexes would be good too.
* Eventually: Work to replace rt_mutexes and get things happy
  with PREEMPT_RT

I=E2=80=99d really appreciate any feedback or review thoughts on the
full series as well. I=E2=80=99m trying to keep the chunks small,
reviewable and iteratively testable, but if you have any
suggestions on how to improve the series, I=E2=80=99m all ears.

Credit/Disclaimer:
=E2=80=94--------------------
As always, this Proxy Execution series has a long history with
lots of developers that deserve credit:=20

First described in a paper[1] by Watkins, Straub, Niehaus, then
from patches from Peter Zijlstra, extended with lots of work by
Juri Lelli, Valentin Schneider, and Connor O'Brien. (and thank
you to Steven Rostedt for providing additional details here!)

So again, many thanks to those above, as all the credit for this
series really is due to them - while the mistakes are likely mine.

Thanks so much!
-john

[1] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf

Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Qais Yousef <qyousef@layalina.io>  =20
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: kuyo chang <kuyo.chang@mediatek.com>
Cc: hupu <hupu.gm@gmail.com>
Cc: kernel-team@android.com


John Stultz (5):
  locking: Add task::blocked_lock to serialize blocked_on state
  sched/locking: Add blocked_on_state to provide necessary tri-state for
    proxy return-migration
  sched: Add logic to zap balance callbacks if we pick again
  sched: Handle blocked-waiter migration (and return migration)
  sched: Migrate whole chain in proxy_migrate_task()

Peter Zijlstra (1):
  sched: Add blocked_donor link to task for smarter mutex handoffs

 include/linux/sched.h        | 120 ++++++++-----
 init/init_task.c             |   4 +
 kernel/fork.c                |   4 +
 kernel/locking/mutex-debug.c |   4 +-
 kernel/locking/mutex.c       |  83 +++++++--
 kernel/locking/ww_mutex.h    |  20 +--
 kernel/sched/core.c          | 329 +++++++++++++++++++++++++++++++++--
 kernel/sched/fair.c          |   3 +-
 kernel/sched/sched.h         |   2 +-
 9 files changed, 473 insertions(+), 96 deletions(-)

--=20
2.51.0.338.gd7d06c2dae-goog


