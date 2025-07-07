Return-Path: <linux-kernel+bounces-720509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7CDAFBCB7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1231898F3C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570AD221561;
	Mon,  7 Jul 2025 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udXQWZTn"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892E2221299
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921058; cv=none; b=fUnEA0SfYpaFrmXckBjKErAr3Y5TmridbH+uaz0WRKUs/wb2tuSX2Q935Crn/iTDYuMon7j/3rOuxL1nV4WRu/1dmDqgu6ZNj+yQZKp4vrsgLioP6GhBj3vmlZ625jMJKWIQB3FY352LhkJzw057Lw8+DAm/LwC6tL7t6qR2HvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921058; c=relaxed/simple;
	bh=UPE9N4lSH1yMUdVj2cbI418iGwvhaRBNeW3aDELiqz4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ad8PqX+zF08NJWzEguENNYCG1WMCcJAfZZnuWvSUkNngkqysBFEzg6uE+7PvpFmKV/o/T4O6sMNhw7/Ccf6Z9wNs9aYes+0mlAJxkWf8Tmh2dhh1ygIitQytzudo23QF3k8qDdz+CFum9P8ubYeaHOuyE/8AC2EZZ9qdWb+npFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udXQWZTn; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b00e4358a34so2187854a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751921056; x=1752525856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2UurxE85yvWS6I01Q+xnYo0pCeIiyeCLfb7UnL5tuI=;
        b=udXQWZTnDVkiKE22KreTUJYn3udLz+8jbEzi+CXyl1+CP+66vqMo9TZrbtf2v095DV
         HMdTuKXP0PuIsemTd6Jquzs/5oEQryeOcBkMpsUtf5M4mTANUVFavsJgs3HGBRsrtfV0
         SiwHePYu8MHOPLhhF0e5ClvqMJG2cu9Nct3hmk4KaocKC8AXbF/xDdNFl//IFWjcdbdv
         hXMbg13LAacRvR+nIPIngnnQcf6ARYOauvQJ0RWzRt+o7yTDshwyrTIzfDfmj35JblAA
         seIrdbCKiRj3HEYYO50/8xeaZoeYaiifcYOrFA0wVd9UBEojdAEvIimHCNFKE/JfF1m6
         UC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921056; x=1752525856;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2UurxE85yvWS6I01Q+xnYo0pCeIiyeCLfb7UnL5tuI=;
        b=oLgCvQc2iizcB+Qrm+xnB9DNwDhJGRa/7Qh1BCpMoOKdyn+7Djwo4DUMFZjNR7KDvR
         6WCDW9IIR5KW2PW4yt+UdFvQ26ESP4ToyVR6VHKL810T2B5nXOExkHxhLKE4ybqai1Ba
         JKC+nIiCrCpKWrGaHy5AlutrxBHDn2b34tQ4SztNHBXhrNAoqqcyhr/8SvJvmKOxUD29
         KbnxQvM943yFqEjzHM/31IUaEmNv23TizO2ezlI0P5ZI3qtFBy1dxH74PerRrurbjetZ
         7z7XaaQonDZSwswnnn8ZdHYKmqnrqmRirndbsSikeYlF5ZdG8eKfJ+8x3fNf7t8hhFZr
         xrOQ==
X-Gm-Message-State: AOJu0Yx2FsSmr27ggcQpDNkOscBI+ypKIicEa3gwoadh8DbI1cIC+kBn
	Vxq7TgTjc8vIMwxFRLMkGlqPSZaOYvn+FAg1CyIMdq+ng+WXN8Figv4y5q4aPDbIOe5MLs6nx8F
	gynWnr4VLG94DwPY/WrzGlpXJKdFr+NQr20QhiYWjCsyxjdHSSpsNeDNDnPZaZoOQsJ70nN8WPC
	hCAVoObogaVa+HV6bxDRaQ4QSfu/yEEReNmtUghx55sEty7pAu
X-Google-Smtp-Source: AGHT+IEVg5ZF8z6y+0fpI1zhFhnWZ7jof8T/IYCrvi9jccCUNx3H7YH6JBmeZnnx75h06sAghcyJk6BGi8eX
X-Received: from pfix8.prod.google.com ([2002:aa7:9a88:0:b0:742:a99a:ec52])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:14d:b0:21a:ecf5:ea71
 with SMTP id adf61e73a8af0-2260998b942mr20388235637.15.1751921055651; Mon, 07
 Jul 2025 13:44:15 -0700 (PDT)
Date: Mon,  7 Jul 2025 20:43:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707204409.1028494-1-jstultz@google.com>
Subject: [RESEND][PATCH v18 0/8] Single RunQueue Proxy Execution (v18)
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

Just wanted to resend this v18 iteration of the Single
RunQueue Proxy-Execution series, as its been a bit quiet.
No changes from last time, though I did add K Prateek Nayak's
Tested-by tags.

So here is v18 of the Proxy Execution series, a generalized form
of priority inheritance.

As I=E2=80=99m trying to submit this work in smallish digestible pieces,
in this series, I=E2=80=99m only submitting for review the logic that
allows us to do the proxying if the lock owner is on the same
runqueue as the blocked waiter: Introducing the
CONFIG_SCHED_PROXY_EXEC option and boot-argument, reworking the
task_struct::blocked_on pointer and wrapper functions, the
initial sketch of the find_proxy_task() logic, some fixes for
using split contexts, and finally same-runqueue proxying.=20

As I mentioned earlier, for the series I=E2=80=99m submitting here, it has
only barely changed from v17. With the main difference being
slightly different order of checks for cases where we don=E2=80=99t
actually do anything yet (more on why below), and use of
READ_ONCE for the on_rq reads to avoid the compiler fusing
loads, which I was bitten by with the full series.

However for the full proxy-exec series, there are a few
differences:
* Suleiman Souhlal noticed an inefficiency in that we evaluate
  if the lock owner=E2=80=99s task_cpu() is the current cpu, before we
  look to see if the lock owner is on_rq at all. With v17 this
  would result in us proxy-migrating a donor to a remote cpu,
  only to then realize the task wasn=E2=80=99t even on the runqueue,
  and doing the sleeping owner enqueuing. Suleiman suggested
  instead that we evaluate on_rq first, so we can immediately do
  sleeping owner enqueueing. Then only if the owner is on a
  runqueue do we proxy-migrate the donor (which requires the
  more costly lock juggling). While not a huge logical change,
  it did uncover other problems, which needed to be resolved.

* One issue found was there was a race where if
  do_activate_blocked_waiter() from the sleeping owner wakeup
  was delayed and the task had already been woken up elsewhere.
  It=E2=80=99s possible if that task was running and called into
  schedule() to be blocked, it would be dequeued from the
  runqueue, but before we switched to the new task,
  do_activate_blocked_waiter() might try to activate it on a
  different cpu. Clearly the do_activate_blocked_waiter() needed
  to check the task on_cpu value as well.

* I found that we still can hit wakeups that end up skipping the
  BO_WAKING -> BO_RUNNALBE transition (causing find_proxy_task()
  to end up spinning waiting for that transition), so I re-added
  the logic to handle doing return migrations from
  find_proxy_task() if we hit that case.

* Hupu suggested a tweak in ttwu_runnable() to evaluate
  proxy_needs_return() slightly earlier.

* Kuyo Chang reported and isolated a fix for a problem with
  __task_is_pushable() in the !sched_proxy_exec case, which was
  folded into the =E2=80=9Csched: Fix rt/dl load balancing via chain
  level balance=E2=80=9D patch

* Reworked some of the logic around releasing the rq->donor
  reference on migrations, using rq->idle directly.

* Sueliman also pointed out that some added task_struct elements
  were not being initialized in the init_task code path, so that
  was good to fix.

You can find the full series here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v18-6.16-=
rc3/
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v18-6.16-rc3

Issues still to address with the full series (not the patches
submitted here):
* Peter suggested an idea that instead of when tasks become
  unblocked, using (blocked_on_state =3D=3D BO_WAKING) to protect
  against running proxy-migrated tasks on cpu=E2=80=99s they are not
  affined to, we could dequeue tasks first and then wake them.
  This does look to be cleaner in many ways, but the locking
  rework is significant and I=E2=80=99ve not worked out all the kinks
  with it yet. I am also a little worried that we may trip
  other wakeup paths that might not do the dequeue first.
  However, I have adopted this approach for the
  find_proxy_task() forced return migration, and it=E2=80=99s working
  well.

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
series really is due to them - while the mistakes are likely mine.

Thanks so much!
-john

[1] https://static.lwn.net/images/conf/rtlws11/papers/proc/p38.pdf

Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Qais Yousef <qyousef@layalina.io> =20
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
 include/linux/sched.h                         |  72 ++++-
 init/Kconfig                                  |  12 +
 kernel/fork.c                                 |   3 +-
 kernel/locking/mutex-debug.c                  |   9 +-
 kernel/locking/mutex.c                        |  18 ++
 kernel/locking/mutex.h                        |   3 +-
 kernel/locking/ww_mutex.h                     |  16 +-
 kernel/sched/core.c                           | 257 +++++++++++++++++-
 kernel/sched/deadline.c                       |   7 +
 kernel/sched/fair.c                           |  65 +++--
 kernel/sched/rt.c                             |   5 +
 kernel/sched/sched.h                          |  22 +-
 13 files changed, 448 insertions(+), 46 deletions(-)

--=20
2.50.0.727.gbf7dc18ff4-goog


