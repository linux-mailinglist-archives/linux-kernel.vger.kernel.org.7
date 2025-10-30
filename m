Return-Path: <linux-kernel+bounces-877334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D4DC1DE38
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD47B3BC8E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FAA1ACEDE;
	Thu, 30 Oct 2025 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSf8VOlf"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6873A1C9
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783545; cv=none; b=japuSqJWrOIqxG/Cw0tVAiVD1e9VjsGMMp2hs5ZZDN6exZCJQH+fIBkfhFrJ3VZ7hmPy0N6wuVxK1xsdvbgkIsamkI9fJHdU9uT0dyaVPvwHYl1KORm/N+0nbbkwbAycxMFgXhWkRaNXKKgpa7w6l0KODQ+DUMuemJhN5zCVRsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783545; c=relaxed/simple;
	bh=vmspcd7Ij2VIvQlRS8VQYEC149ENX9efdCUtljEacrM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qjYhnmxnczy3auuX7OtvHn/CAmoQj6PFcYK+n00qL1wUqk9HEGzlvob7MSF41dtV6JRfVbnGPRtdIA63Rn1HLONzO9/x/TE56RW+5uccQwp3euuuBPVtFV+HICsSJRYFrKfaBCx3lEub/AiNmsHwp0m7x1O3yXJ5SITKzTIUbo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hSf8VOlf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3307af9b55eso346842a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761783543; x=1762388343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4tEKrNABIGeFVVT422qu110pYH8U1IpF85Kmq5rgfOg=;
        b=hSf8VOlf8f5qAQq0Sl6jG6Ct18aOLZwzZYuc49IcTQTNq24o+W8+UCJYI9lj80rXmB
         6yAR7i0cFopLorpXWrk4iWFkq0J3e7ggrQjH0oYwc5r3/0nz/9mlbWPMLcBqYrjNvXCX
         k8s3QmmQ645MtsifFbYvgJ+qedELuZnTE5zZMUM8Ezy0xzaFhirDqCffaA7Q8u2RMNWe
         jlXOXM64jjFtQwbK662AKhp+KJ3OgGev1TweURRvKP/oAhNWE5xrivq9NBlIb3Gwz22K
         AehIduwib0bHMWyhx+6CVBGWRoKOd/r8dHuCb98cdz4/DHotj5AHOilM4b2Ab4IQY6LV
         q+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783543; x=1762388343;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tEKrNABIGeFVVT422qu110pYH8U1IpF85Kmq5rgfOg=;
        b=kEbeTwbjmY6qYsTHbRslXoQvGW/qg3uP7j1t7gTbuVbYPmokObrhF4O944xaJ34qw9
         VddwqMgd3RC4iFZGWyQH8FHRgQKGK6YS+iudTTAEKeRHTCNjJ9etzAgf0HmeFxWYcWmp
         ZV9veoBc230NNWUpnfBbQQEj/8V+tZz7ctp3vHBI9sGd2mTuiX+gga0OStK9EO87rdQn
         60CK17Ay0FJP6UXNpXOArw2f0bfJKawjIAGK7N+g6Ob9TwP9O7h1Y7z1ruEyFjrvtHA/
         4m689UX9L39Swby458VkvW5Q2QXvUpKAJXwArYaOZOXaIRRVjP0w6G90NUbJSO5JWQjL
         3NaQ==
X-Gm-Message-State: AOJu0Yx5w6ACxgP0ywVazwBHfYJso8GwHPkdxaluV+7Ezn5w0MkSpX/1
	Ob3HjI2Ya95mnexZr3MTnOEqnJd6odoj2AepLMi8/hv6PyyAY0wnE4lgK5qQOhH2F30LR1oQ43j
	yinZIhaJ/QJWSaojsf2VW28eyNzwhCaiTfroDIKsPeJ3c+ZWwvGmxxvO6XrDHPmc8b3gQJD0EYu
	twoJ1fodsmYIly7lQRU3+jC4HfzQb/BTlfNH2BuQdVr/FwGIno
X-Google-Smtp-Source: AGHT+IEC5kXHRI5B0mykYKXGLyu1FYJwZhcuDoGpA2kslxxHbn5Ya59FrO/oZQUeJWAihVehvG5hlJZrj/iK
X-Received: from pjrv7.prod.google.com ([2002:a17:90a:bb87:b0:33b:51fe:1a7e])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38cb:b0:32e:389b:8762
 with SMTP id 98e67ed59e1d1-3403a0d852fmr4649337a91.0.1761783542591; Wed, 29
 Oct 2025 17:19:02 -0700 (PDT)
Date: Thu, 30 Oct 2025 00:18:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030001857.681432-1-jstultz@google.com>
Subject: [PATCH v23 0/9] Donor Migration for Proxy Execution (v23)
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

Just another iteration on the next chunk of the proxy-exec
series: Donor Migration

This is just the next step for Proxy Execution, to allow us to
migrate blocked donors across runqueues to boost remote lock
owners.

As always, I=E2=80=99m trying to submit this larger work in smallish
digestible pieces, so in this portion of the series, I=E2=80=99m only
submitting for review and consideration the logic that allows us
to do donor(blocked waiter) migration, which requires some
additional changes to locking and extra state tracking to ensure
we don=E2=80=99t accidentally run a migrated donor on a cpu it isn=E2=80=99=
t
affined to, as well as some extra handling to deal with balance
callback state that needs to be reset when we decide to pick a
different task after doing donor migration.

Peter provided some very helpful review and feedback on the last
iteration, and I=E2=80=99ve tried to address his concerns and suggestions
here. However, the rework ended up being fairly significant (and
I think I stepped on just about every rake possible in the
process :P), so stabilizing the changes took much longer than I
had hoped for. I suspect Peter will have further suggestions
for changes.

New in this iteration:
* Folded the blocked_on_state into the blocked_on ptr, by
  introducing a special PROXY_WAKING value. This slight
  =E2=80=9Ccompression=E2=80=9D of state tracking had some subtle implicati=
ons,
  especially in the find_proxy_task() chain walking, but I think
  I=E2=80=99ve got it worked out.

* Split the donor migration patch into a few smaller patches,
  handling manual return migration from find_proxy_task() first,
  and then adding the return migration logic in try_to_wakeup()
  in a separate patch, as requested by Peter. This also
  uncovered quite a few subtleties and required majorly
  reworking the proxy_force_return() logic.

* Pulled out balance_callback WARN_ON into its own helper
  function so we can check it at the top of the pick_again loop,
  as Peter suggested

I=E2=80=99d love to get further feedback on any place where these
patches are confusing, or could use additional clarifications.

In the full series, I don=E2=80=99t have much new as this rework took
up much of my time. But I=E2=80=99d still appreciate any testing or
comments that folks have:

Also you can find the full proxy-exec series here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v23-6.18-=
rc3
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v23-6.18-rc3

Issues still to address with the full series:
* Continue working to get sched_ext to be ok with
  proxy-execution enabled.

* I=E2=80=99ve reproduced the performance regression K Prateek Nayak
  found with the full series. I=E2=80=99m hoping to work to
  understand and narrow the issue down soon.

* Polish Suleiman=E2=80=99s rwsem patches some, as the PROXY_WAKING
  rework added some atomicity complications to traversing and
  locking the blocked_on structure and my initial fixups aren=E2=80=99t
  super elegant.

* The chain migration functionality needs further iterations and
  better validation to ensure it truly maintains the RT/DL load
  balancing invariants (despite this being broken in vanilla
  upstream with RT_PUSH_IPI currently)

Future work:
* Expand to more locking primitives: Figuring out pi-futexes
  would be good, using proxy for Binder PI is something else
  we=E2=80=99re exploring.
* Eventually: Work to replace rt_mutexes and get things happy
  with PREEMPT_RT

I=E2=80=99d really appreciate any feedback or review thoughts on the
full series as well. I=E2=80=99m trying to keep the chunks small,
reviewable and iteratively testable, but if you have any
suggestions on how to improve the larger series, I=E2=80=99m all ears.

Credit/Disclaimer:
=E2=80=94--------------------
As always, this Proxy Execution series has a long history with
lots of developers that deserve credit:=20

First described in a paper[1] by Watkins, Straub, Niehaus, then
from patches from Peter Zijlstra, extended with lots of work by
Juri Lelli, Valentin Schneider, and Connor O'Brien. (and thank
you to Steven Rostedt for providing additional details here!).

Thanks also to Joel Fernandes, Dietmar Eggemann, Metin Kaya,
K Prateek Nayak and Suleiman Souhlal for their substantial
review, suggestion, and patch contributions.

So again, many thanks to those above, as all the credit for
this series really is due to them - while the mistakes are
surely mine.

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

John Stultz (8):
  locking: Add task::blocked_lock to serialize blocked_on state
  sched: Fix modifying donor->blocked on without proper locking
  sched/locking: Add special p->blocked_on=3D=3DPROXY_WAKING value for prox=
y
    return-migration
  sched: Add assert_balance_callbacks_empty helper
  sched: Add logic to zap balance callbacks if we pick again
  sched: Handle blocked-waiter migration (and return migration)
  sched: Have try_to_wake_up() handle return-migration for PROXY_WAKING
    case
  sched: Migrate whole chain in proxy_migrate_task()

Peter Zijlstra (1):
  sched: Add blocked_donor link to task for smarter mutex handoffs

 include/linux/sched.h        |  95 ++++++---
 init/init_task.c             |   5 +
 kernel/fork.c                |   5 +
 kernel/locking/mutex-debug.c |   4 +-
 kernel/locking/mutex.c       |  82 ++++++--
 kernel/locking/mutex.h       |   6 +
 kernel/locking/ww_mutex.h    |  16 +-
 kernel/sched/core.c          | 372 +++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h         |  11 +-
 9 files changed, 519 insertions(+), 77 deletions(-)

--=20
2.51.1.930.gacf6e81ea2-goog


