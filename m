Return-Path: <linux-kernel+bounces-774539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAB1B2B3FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4031B26E47
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F95327B332;
	Mon, 18 Aug 2025 22:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y42c7njj"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0172427AC4B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555185; cv=none; b=kTT5e45eOLz4GjdR0EMMDk8qVEWbx2NT2YjaU4TJUdsNCYZCcew6T+9lykJZBvGO2JHdTXAcaatBM5vZjXmoG/W1KocbrExnjWk1R0GX5+8aE5FXnCfIdz31WCu2pFMQy7dpazcqe7tAXmM4A+I8lS9pOHZa/w/Iy2Nk1tQ05q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555185; c=relaxed/simple;
	bh=kLNoRdKf2p+HyJuRVX9+04DCtv3+0SZTOEUxOM+vFRo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CIUR0NtcbBWeFWODnnT7I6xla47GyIGjdoAgwHvDSoAIFYHhphuvksKtsY5O1oPvZM04ZdoJM5BV/hzzaTZne3jW2S5dMBd9pqXMRgiY98ruC4/ttkV9SLYXK33mAi+Ms4i5HYD9tx78tSVKC0rKWIcL/f6STiMerVMJvRO/Ixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y42c7njj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323266c83f6so5152032a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755555183; x=1756159983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIcN67n9gb+lbRprqr46Am+gUgIgfXFCQ1Tee2/wQWA=;
        b=y42c7njjx5w6rOhvUwbxtYufqdG+FPAvc+l/YC4lUW//0HYX9l9n9Jq7mVCs9tQYj5
         SutxgJzqlOHWWr7lMj6IkQSPLGkqLU+/VaV8Ebrbe7HaaSIpW897udV+rti9g/2xec6K
         t83AiV22vhK0hR5szcjNBCwUoMBlJqsgX55szL1hC2+KCCHkvQ9Qj7pLxWuXt60mYuLP
         kE5x0JJhF+XoRtmudoyIAU07njT1sVK7xgXBDF8ar1A8wgvhtj2KKNYEstJDbXCuPAFt
         pbMId+OZM1jjQPWlKj/8IIGDWzy9GdmqDk5ExMqVpw1SU4ycp7Qy/PQVfNZg+0xPiBAf
         SgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755555183; x=1756159983;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIcN67n9gb+lbRprqr46Am+gUgIgfXFCQ1Tee2/wQWA=;
        b=w9vugLAFVOmkMM1Qj3jQw1SYaf/CiXsHkORCqGn+w9hra1K0RjOZY1xJ0fnqWuULdj
         UBtRzEss+T79OTR6eJIZXzsZregkfwQa1OfgWLHfzC8YOCF6vxCYBJWDeTl3UxDpocl5
         R72WOT+9DHXard6QkptZ8gBn6fdGpWKoc92mATY63RU4P34vCzM3559d1cIH38oRYdBA
         UTJoj343Uwp8KOgf1mWvTEyUnx6D5yf9ahnN2mkLPx6wXHC9rh5duy15Tln0/Cv2FKVF
         Q96VQs/7e+pu0icHrZKAvBFM9eodwV7XqYUPXgFhn3gl3OcCmJX/FONmHwRtf/xUR4Mo
         FOUA==
X-Gm-Message-State: AOJu0YwLmEZtDIzIGCSvm5ckTox/PQwWo4chPhdTsvHR7dJn7VtswJ6r
	P3kDGDOyf5L1ETSwnoGKy+bz1eW3d+wwUi3J00agE2UYT32B+USUgxdCOq4ZftYoZ4nOkzK1cU5
	DStuuaWQe7dz63ALGRt4UdVD6GOcbLOS1PioNl5CBZXQOTG9nIxwXTwFmcI8ojZB2yKs+4Op7w6
	k0EWe79gQKToKtOjn8GtxKtkdqR6ENachGq0Khe5dSpD9oTqkx
X-Google-Smtp-Source: AGHT+IFIkLTMwpb3AN+t47OGKgEy3hoMuy6bjhjC/IdFj0SowqptZU4/9h0ZFNx2K8l+5ewvEviyI9u01QRt
X-Received: from pjk12.prod.google.com ([2002:a17:90b:558c:b0:311:c5d3:c7d0])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17cc:b0:323:7df8:6eec
 with SMTP id 98e67ed59e1d1-324d356d64emr125752a91.18.1755555182685; Mon, 18
 Aug 2025 15:13:02 -0700 (PDT)
Date: Mon, 18 Aug 2025 22:12:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250818221300.2948078-1-jstultz@google.com>
Subject: [PATCH v21 0/6] Donor Migration for Proxy Execution (v21)
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

I wanted to continue pushing for feedback on the next chunk of
the series: Donor Migration

I had initially planned to resend v20 last week, but in working
up the fix[1] for the warning issue that cropped up after single
rq proxying landed in 6.17-rc, it got me thinking a bit more
about the ww_mutex paths.

As part of this chunk, I previously had logic where the ww_mutex
paths took the blocked_lock of the task it was waking (either
the lock waiter->task or owner), but in a context from
__mutex_lock_common() where we already held the
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
rc2/
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v21-6.17-rc2

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

First described in a paper[2] by Watkins, Straub, Niehaus, then
from patches from Peter Zijlstra, extended with lots of work by
Juri Lelli, Valentin Schneider, and Connor O'Brien. (and thank
you to Steven Rostedt for providing additional details here!)

So again, many thanks to those above, as all the credit for this
series really is due to them - while the mistakes are likely mine.

Thanks so much!
-john

[1] https://lore.kernel.org/lkml/20250805001026.2247040-1-jstultz@google.co=
m/
[2] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf

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
2.51.0.rc1.167.g924127e9c0-goog


