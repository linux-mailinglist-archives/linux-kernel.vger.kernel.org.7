Return-Path: <linux-kernel+bounces-728504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC70AB02921
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 05:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DB3585A9B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 03:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0921E7C32;
	Sat, 12 Jul 2025 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhYVhjxO"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E007374F1
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752291256; cv=none; b=nvWOZsimvQk7Dq0CvlaV5l7cgreFMYNg6RwsSIl8yxTWObm8FOKZYWkXrzblaeVli5GMIPT7QVXly3WzTv6wb1/kE+PzR3eTvbaF9qGq4snwuzkjj7T3wVF+RugdzvmtJq+ihqe5ersgv488rGhXJ5BIOp3JN1/8oBDHUPcUwCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752291256; c=relaxed/simple;
	bh=jhlUOPJp3KduayDJ5YSChPnp3uxgWXrn4D/RMEuREdQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=chcJvOZWUlY+ilBGHsR2BcfN8Fu9yFL9fWYCqEsuFTTLw3CzWmjC4dZIpBCB8Nby37DwQDAVbPy3ZqX1PydoXNWgmLoEQzdot1duiBD7NSoxj0ssmEcnl2P7PVtsmzVhQLJeAabiEIfr9dlpMvs2i2qltZLNzNNHzdXKG/X5b8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhYVhjxO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so2124676a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 20:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752291254; x=1752896054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9vTyowfl21IuFUQUW///0/c8ZYGnMrpk9d6D9CODcOI=;
        b=rhYVhjxO7/V/bfr2yLgHBDgglzRL3vXjSkua0+K9vZZyuyb9QrKNzqiOstq1xaovHU
         Uyyv8NM4uUkzw5l8XA17s2a4uyXvFT37WWLPYaFvm0UUo2jgrni3fUYYcng0ZNVTCN1o
         BZVIa5yRnSCy2G7c1NDffXxkPbRS/4Yos5l6seGllfQhTWYDyqfPYKp4Hdt42DOmOZeI
         tUSfljmMEVelWq+nDPqtvj70bVO8bgy7jHnaUMPVIeBLt33txEUFF1tW1YJPtmFOTEZh
         xsp6z5HRhPmW1hkrHJeJMcyUe9fhw4zBjsv3Z/S9qqowgCQnhOxc5DwHvBJMCpNE4iGt
         fqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752291254; x=1752896054;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vTyowfl21IuFUQUW///0/c8ZYGnMrpk9d6D9CODcOI=;
        b=P96MxE3Fe118rvWc6CtK6yvslAXWaJtMMHBtDd5wcT58S9AK4TFtLA8wsYu03zd0Iw
         yhg2OME6Rou7B5m2dNOQBXzxvLuUVqr7hbymLZwbrlow4pqsHr2nCxOKW+XPSu0zI6eO
         NJCup/uoIwVHWYjXzv44WYC1Wood6mXJrOFzN4Q/w1rXRlITqOtbvlOFzcIHgNNxQNWD
         AHcDhkbZEQlZ9ZgNEPddv3WUi5bkTTgZAOsgR19kFnDzG2i5dQDvlM+mtlZJo5GiLM1r
         9gxgTti3EJZp+EORFi3BWL8Bn16MXzlfR1nFbTu73TMZHOAkaQnvNFqQcbkOTCnCEHKO
         ap1A==
X-Gm-Message-State: AOJu0YzTyMRGPZB2+/PPEUS0oFBylb1HYYaKej/wLQibIYLCcApQvACj
	crXs0QmVfyhMe1+Ibv+I0C6VXeFsFOXfkEb+FgwznIYwP7gZKqE9PrL4WESdwV5rSf34U6UyL+k
	DHkZXec9nd2NL/D7xXBgIva31B9c54hA2XcAQ/WexEZE0TQuA4JNuiydHhaKs29Idmur9oeuZB9
	rJl6wvAEEOp74QeU1zfldRUFsMhSl0aLZaHZbMnhgeWn4duc/s
X-Google-Smtp-Source: AGHT+IHWg1jr6P7wgVfA4NPp3PYwGK5rCY4B4De/dqr5zq79HDIhs6SaD7PexcC+9iNETDJKjeBQ7AgWEGNE
X-Received: from plblh3.prod.google.com ([2002:a17:903:2903:b0:23d:dd69:dd14])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f70a:b0:23d:e2fc:6fe5
 with SMTP id d9443c01a7336-23dee0ded57mr89999035ad.49.1752291253573; Fri, 11
 Jul 2025 20:34:13 -0700 (PDT)
Date: Sat, 12 Jul 2025 03:33:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712033407.2383110-1-jstultz@google.com>
Subject: [PATCH v19 0/8] Single RunQueue Proxy Execution (v19)
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

This is just a quick update to the v18 series, to address some
smaller nits Peter had as well as a few build issues uncovered
with !SMP and PREEMPT_RT that K Prateek Nayak highlighted.

So here is v19 of the Proxy Execution series, a generalized form
of priority inheritance.

As I=E2=80=99m trying to submit this work in smallish digestible pieces,
in this series, I=E2=80=99m only submitting for review the logic that
allows us to do the proxying if the lock owner is on the same
runqueue as the blocked waiter. Introducing the
CONFIG_SCHED_PROXY_EXEC option and boot-argument, reworking the
task_struct::blocked_on pointer and wrapper functions, the
initial sketch of the find_proxy_task() logic, some fixes for
using split contexts, and finally same-runqueue proxying.=20

As I mentioned above, for the series I=E2=80=99m submitting here, it has
only minor changes from v18. With the majority of the change
being slight reworks to address build issues with different
configs.

Specifically:
* Build fixup for PREEMPT_RT suggested by K Prateek Nayak
* Slight re-arrangement of functions to clean up later patches
* Slight tweak further simplifying update_curr_common()
  suggested by Peter
* Rename try_to_block_task() arguments and add additional
  comments suggested by Peter
* Push proxy_resched_idle() returning rq->idle to a later
  patch in the series, as suggested by Peter.

In the full series, some of the slight reworks for build issues
propagated and needed to be tweaked, as well as some fixes for
!CONFIG_SMP were needed.

You can find the full series here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v19-6.16-=
rc5/
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v19-6.16-rc5

Issues still to address with the full series:
* I spent some more time thinking about Peter=E2=80=99s suggestion to
  avoid using the blocked_on_state =3D=3D BO_WAKING check to protect
  against running proxy-migrated tasks on cpus out of their
  affinity mask. His suggestion to just dequeue the task prior
  to the wakeup in the unlock-wakeup path is more elegant, but
  this would be insufficient to protect from other wakeup paths
  that don=E2=80=99t dequeue. I=E2=80=99m still thinking if there is a clea=
n
  way around this, but I=E2=80=99ve not yet found it.
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
=E2=80=94--------------------
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

John Stultz (4):
  sched: Add CONFIG_SCHED_PROXY_EXEC & boot argument to enable/disable
  sched: Move update_curr_task logic into update_curr_se
  sched: Fix runtime accounting w/ split exec & sched contexts
  sched: Add an initial sketch of the find_proxy_task() function

Peter Zijlstra (2):
  locking/mutex: Rework task_struct::blocked_on
  sched: Start blocked_on chain processing in find_proxy_task()

Valentin Schneider (2):
  locking/mutex: Add p->blocked_on wrappers for correctness checks
  sched: Fix proxy/current (push,pull)ability

 .../admin-guide/kernel-parameters.txt         |   5 +
 include/linux/sched.h                         |  82 +++++-
 init/Kconfig                                  |  12 +
 kernel/fork.c                                 |   3 +-
 kernel/locking/mutex-debug.c                  |   9 +-
 kernel/locking/mutex.c                        |  18 ++
 kernel/locking/mutex.h                        |   3 +-
 kernel/locking/ww_mutex.h                     |  16 +-
 kernel/sched/core.c                           | 275 +++++++++++++++++-
 kernel/sched/deadline.c                       |   7 +
 kernel/sched/fair.c                           |  68 +++--
 kernel/sched/rt.c                             |   5 +
 kernel/sched/sched.h                          |  22 +-
 13 files changed, 475 insertions(+), 50 deletions(-)

--=20
2.50.0.727.gbf7dc18ff4-goog


