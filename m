Return-Path: <linux-kernel+bounces-740290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F8DB0D251
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E8C542321
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984AB28DEF8;
	Tue, 22 Jul 2025 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfQ7lD7A"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715428A41B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167983; cv=none; b=Cg8tEngnhnm8+Oi9iyMVBM8RLrPORZy9RG5sykyhZ+ydvyYG3bgO+YbfbYqURZdDSUHSH15J70iZ+L0QjOn4bhk22rR/Y5fnNH/72P5dqNHmJyH9hAbFKjHozyPp92OF1szGq5us+/o7PP+tbiTYbj7FeM3eFQortJRe3g+JhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167983; c=relaxed/simple;
	bh=ifgzLxc2uNLr/7PMK14b1aoZHMY9oz7cKqeDHbuOmtc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UUE8sxfydZQg9p6SIEDJW0WVCH8U0/3BUD8hKzAmRoN3s37Y9zYn1WjqOLEl4z7rcQy6Yvlb2rO3pFSp4qU4Ura1aN2adf4UJjO55M1Kpr6CDfM3Qvno7qG4h3jLXwTN/TLRIgMawQLcVpYNweY6I+VArtxmGgYCYtHc3/eZAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pfQ7lD7A; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313d346dc8dso7730982a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753167981; x=1753772781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo8EU3SOLEFStoaa1feXXRs7tRqvLQmkIjQYipgTzPQ=;
        b=pfQ7lD7AqGb7uL47qVm5mUKmo15zpJ8p9PPLbu/fH5iAYtHObxaV+YGhtYnBkaNUBE
         LxUBTjRNoTrKc5ZO5LS0al8BNu8QoYgucZVh5R/Fd2W8VYnzpKFHgDjj64B1+/R3ql50
         SKNbKCwekkm5EuiNHSYRgnAeCG6lQRGa1gfyTELAVyA+YQyDYtTU8oIFhTiw/VM+pXPM
         L/VOci4SrGdlmVvR5Uv7whD1ksj5sEuM0E55sOMDdwv0bfhhqo8S/x6A4uoiCUhoW3Wy
         CPFE/MMmXA4F+lVBmn7Y3mDxM0P/9lr+S05STOmaDNVvK1AUfMhoTqnIiUlwJz+c0SBZ
         9KXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753167981; x=1753772781;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo8EU3SOLEFStoaa1feXXRs7tRqvLQmkIjQYipgTzPQ=;
        b=AHpPJr6yh7jznS/ATXFryo0cgiVJpFqWiox6OtydG2LUwm+n2Ptwe6kvMlhi/4r1IB
         D2FXB453kN7hN7FjxO+D/zTVxVtK3tY15Rd1hyYNuETskyvzCM+c+3xhKSVn2UKpvs1z
         MJggQqn0775yzDDetVBft0pvQkX6bUtPNcul0NTphIgHjMAJkGu5+BzGrYQ8bj6IG0z/
         Zn1J5lhsnED0yE+DUoybgqmQgMOmRdWKbrR2sYdWn/drTG4saufJS9Hvpb/G+nu1NWmy
         ZCZyQWm7ASzYCkRrFlSpK1q5fF/6H+1pyYcDmayh8LmCHoJb+ds8mL9CU0NA7Yuzo27m
         rOqw==
X-Gm-Message-State: AOJu0Yyon4huZW+98z5mnijaB07FofmDqHuLUnJnL4iudpbg8HkCzoCv
	xVgi4YjaYhZUQzjyWtW1J+Wb5gxLaNThvQxBKC3KevlII+oW0hbCpUDJARSIvCWsgONSqlSLeG1
	vue7YKfSThPj3IBLjboKhmU8QVPmea5jWO2p8tYvGY5D8ZcII/SqEgvLNqnvSY7MTN768yqa3hd
	tHIM/UMqFb+2XnrRXSrX+gTVIlZFpXkpMh6BMLNWbWHglwSOOQ
X-Google-Smtp-Source: AGHT+IFa9l7Jd5FqOrBP9BOyh9V8kMkpk3rp/YP/+XMswcIG/Ojar5JjNcZMTFavkiI9lAyOgx52FhZUfnp9
X-Received: from pjkk15.prod.google.com ([2002:a17:90b:57ef:b0:31c:2fe4:33b8])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:390f:b0:313:1e60:584d
 with SMTP id 98e67ed59e1d1-31caf844db3mr30758249a91.11.1753167981170; Tue, 22
 Jul 2025 00:06:21 -0700 (PDT)
Date: Tue, 22 Jul 2025 07:05:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722070600.3267819-1-jstultz@google.com>
Subject: [RFC][PATCH v20 0/6] Donor Migration for Proxy Execution (v20)
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

As Peter just queued the Single-RQ portion of the Proxy
Execution series, I wanted to start getting some initial review
feedback for the next chunk of the series: Donor Migration

v20 is not very different from v19 of the whole series that
I=E2=80=99ve shared previously, I=E2=80=99ve only rebased it upon Peter=E2=
=80=99s
sched/core branch, dropping the queued changes, resolving
trivial conflicts and making some small tweaks to drop
CONFIG_SMP conditionals that have been removed in -tip tree,
along with a few minor cleanups.

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

I=E2=80=99d love to get some initial feedback on any place where these
patches are confusing, or could use additional clarifications.

Also you can find the full proxy-exec series here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v20-peter=
z-sched-core/
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v20-peterz-sc=
hed-core

Issues still to address with the full series:
* There=E2=80=99s a new quirk from recent changes for dl_server that
  is causing the ksched_football test in the full series to hang
  at boot. I=E2=80=99ve bisected and reverted the change for now, but I
  need to better understand what=E2=80=99s going wrong.

* I spent some more time thinking about Peter=E2=80=99s suggestion to
  avoid using the blocked_on_state =3D=3D BO_WAKING check to protect
  against running proxy-migrated tasks on cpus out of their
  affinity mask. His suggestion to just dequeue the task prior
  to the wakeup in the unlock-wakeup path is more elegant, but
  this would be insufficient to protect from other wakeup paths
  that don=E2=80=99t dequeue. I=E2=80=99m still thinking if there is a clea=
n way
  around this, but I=E2=80=99ve not yet found it.

* Need to sort out what is needed for sched_ext to be ok with
  proxy-execution enabled.

* K Prateek Nayak did some testing about a bit over a year ago
  with an earlier version of the series and saw ~3-5%
  regressions in some cases. Need to re-evaluate this with the
  proxy-migration avoidance optimization Suleiman suggested now
  implemented.

* The chain migration functionality needs further iterations and
  better validation to ensure it truly maintains the RT/DL load
  balancing invariants (despite this being broken in vanilla
  upstream with RT_PUSH_IPI currently)

I=E2=80=99d really appreciate any feedback or review thoughts on the
full series as well. I=E2=80=99m trying to keep the chunks small,
reviewable and iteratively testable, but if you have any
suggestions on how to improve the series, I=E2=80=99m all ears.

Credit/Disclaimer:
--------------------
As always, this Proxy Execution series has a long history with
lots of developers that deserve credit:=20

First described in a paper[1] by Watkins, Straub, Niehaus, then
from patches from Peter Zijlstra, extended with lots of work by
Juri Lelli, Valentin Schneider, and Connor O'Brien. (and thank
you to Steven Rostedt for providing additional details here!)

So again, many thanks to those above, as all the credit for this
series really is due to them - while the mistakes are likely
mine.

Thanks so much!
-john

[1] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf

Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Qais Yousef <qyousef@layalina.io>=20
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
  kernel/locking: Add blocked_on_state to provide necessary tri-state
    for return migration
  sched: Add logic to zap balance callbacks if we pick again
  sched: Handle blocked-waiter migration (and return migration)
  sched: Migrate whole chain in proxy_migrate_task()

Peter Zijlstra (1):
  sched: Add blocked_donor link to task for smarter mutex handoffs

 include/linux/sched.h     | 107 ++++++++-----
 init/init_task.c          |   4 +
 kernel/fork.c             |   4 +
 kernel/locking/mutex.c    |  80 +++++++--
 kernel/locking/ww_mutex.h |  17 +-
 kernel/sched/core.c       | 329 +++++++++++++++++++++++++++++++++++---
 kernel/sched/fair.c       |   3 +-
 kernel/sched/sched.h      |   2 +-
 8 files changed, 459 insertions(+), 87 deletions(-)

--=20
2.50.0.727.gbf7dc18ff4-goog


