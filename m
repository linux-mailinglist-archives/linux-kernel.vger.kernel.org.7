Return-Path: <linux-kernel+bounces-833551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A503BBA24CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575684C7FA8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AADE262FF6;
	Fri, 26 Sep 2025 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fboxPDgW"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B1A1FCFEF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758857378; cv=none; b=oiYOTnV6d+vE3+6OLkAexseq0eLvTOrNzsFp6d8Q6WVb/B934b7zPU2iO6rCEyo7vd2zCEBDjKCQKxGjAYbLhpi/ph6PxaxT97rSXtNUKfI1pNGiEd2i/7s9RYuMOF+VcGr2ePMgzw97eBprOFxkUm+yyUde0rNfvGMK1nhNttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758857378; c=relaxed/simple;
	bh=93ORO4+Rvirrx1p+pP2IK6SIpi+yz4WV6eVMAbWlBkA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kHI5OnPw/txSEM0OiFtO78sEzgBZsmE6T7Ps6xnrqhV2cyQNdq4aIycgdSL2N3oGKhXZFbZTCk84Z9fx4IO+BdWPrfIhGVtC2xP5NAnqKFUM6X4Q0/zgyX1PYvEZsS2V182gXyUrCnj6AkV15fdpPfIBic12tu2nYiPBYgz8MoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fboxPDgW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b557abaad02so2409864a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758857376; x=1759462176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+z25LMcS3qty+oH4HCsvUKa/CqiNOTrSb7frGaaP5s=;
        b=fboxPDgWczMbomRZwnwZALjJhF+Y9CrvGlhJpFXdvixrPfQzpg7jjHEsZKXNVw4P2I
         cQgis8xBJZMBp3O9xB2UZSjQq+Jo6gWxf7wDa2ylPyzkLVRSU0SW8niaSLM5EVoVdFRd
         aw62m50yblr5YTNFOVh7plpR4RZeMYGe+NF/2GNZqi+0RQEE7pckj56wc4CzrayvQMJI
         ekDC6bU5To8fxc/EuwpFcDU9ALU3NrmNvpRYpumgBUGlPMs5Q1KQzxEmD5VoKbm20m9K
         AyUDx4GrJhCxFuFiYg85hpAosooDE1x9HeZ12UoBwlb//RmOqPOJVhsHczwDHcVB1RGQ
         zSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758857376; x=1759462176;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+z25LMcS3qty+oH4HCsvUKa/CqiNOTrSb7frGaaP5s=;
        b=i6/sFJbuu7ygytM4CNxTc2ISkAZO3KgivKhS+S2RE1P2qa2brnw9JzHmomkcOigRxP
         yEsjZUWDKMSMNGwibbQh1/poxiUTFUhZC2FtYTvDk3hLC/2f9s2TFWoFZdXVzQdFgFGk
         OMTcV/tGnX+si83pNyPoN1dTYWU2aE4c6I4YZXZ1rZETy8OaqoCVW86z5OjzLb/lu0Ce
         cJonHZyofBjks4+dy9S3F245UHNIHPQTsGV1+vkYiNoTvd8KGDSf9gRC33+bmw0pes8H
         YezMIFOXOhgRQD5cqaOwEoVIQWp5+6OHV14VG3XxtNVXNIDtEkKBNxAZtVN/Y+9y5/R+
         LMTw==
X-Gm-Message-State: AOJu0Yz1fQ0Dc/wVGAbMS7fWMXpouepUYcsMs49jwgBoEYajiNnhBcws
	40hEypdcaS7KmlR/eyuic0lE+4akwZ44qUqO2cbR8dRYiWpgN33pEBX5vHTapGYaWJvj7bWojvq
	zuC3d3IX2ICy2xODS8j8dcni3ujYp/XJ5jzZa4QsLpOwsKQIrjJCnvvcZ0Ziy6Li3uEp9CJw6n5
	dfzhJwKSyBnjqghO+Pw3wONepXUe1SxkLmr7t3FITYFjbOLG7m
X-Google-Smtp-Source: AGHT+IExua3dMYM93WI63kVoLB1ezY8ACB3uGWerHLQ/BYa95yakjzwEiF/6ciNCo0irFA7QCTI3ZVftJXqS
X-Received: from pjbhl7.prod.google.com ([2002:a17:90b:1347:b0:330:a006:a384])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:582f:b0:32e:749d:fcb6
 with SMTP id 98e67ed59e1d1-3342a26b3acmr7602710a91.12.1758857376214; Thu, 25
 Sep 2025 20:29:36 -0700 (PDT)
Date: Fri, 26 Sep 2025 03:29:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926032931.27663-1-jstultz@google.com>
Subject: [PATCH v22 0/6] Donor Migration for Proxy Execution (v22)
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

My last version got a lot of great feedback from K Prateek Nayak,
which while not significantly changing behavior, did have me
reworking and reorganizing quite a bit of code in this series:

* Reworking find_proxy_task() to avoid mixing gotos with guard()
  usage. Instead break and switch() on a set action enum.
* Zap callbacks when we resched idle
* Remove unjustified curr !=3D donor check in pick_next_task_fair()
* Simplifications around put_prev_set_next() in the migration
  logic
* Reorder functions for readability
* Move a few task_struct elements under #ifdef
  CONFIG_SCHED_PROXY_EXEC
* Switch to one-line stubs and other white space and spelling
  cleanups.

I=E2=80=99d love to get further feedback on any place where these patches
are confusing, or could use additional clarifications.

Also Suleiman Souhlal and I have been working on some
enhancements to the full Proxy Execution series:
* Suleiman has implemented a first pass at enabling Proxy Exec
  on rw_sems! Rw_sems have been another common source of PI
  inversion problems, so I=E2=80=99m excited to be able to have the
  Proxy Exec approach be able to help solve those issues as
  well. More work and validation are required, but it=E2=80=99s very
  exciting!
* I=E2=80=99ve been working to allow Proxy Exec to work with sched_ext.
  Currently I=E2=80=99ve worked out the crashers I was initially
  seeing. However, I find my stress tests tend to eventually
  cause problems, though this seems unfortunately the case
  without proxy-exec as well, and seems to be due to the missing
  dl_server for sched_ext. I need to try to test with Andrea
  Righi=E2=80=99s series here:
     https://lore.kernel.org/lkml/20250903095008.162049-1-arighi@nvidia.com=
/=20
  I still have further work to better understand if Proxy
  switching the selected task breaks bpf scheduler assumptions
  and what might be done about it.

Also you can find the full proxy-exec series here:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v22-6.17-=
rc6
  https://github.com/johnstultz-work/linux-dev.git proxy-exec-v22-6.17-rc6

Issues still to address with the full series:
* Continue working to get sched_ext to be ok with
  proxy-execution enabled.
* K Prateek Nayak re-did some performance testing with both this
  set and the full series, and while the set I=E2=80=99m submitting here
  looked ok, the full series did see regressions. I=E2=80=99m working to
  reproduce this so I can narrow the issue down.
* The chain migration functionality needs further iterations and
  better validation to ensure it truly maintains the RT/DL load
  balancing invariants (despite this being broken in vanilla
  upstream with RT_PUSH_IPI currently)

Future work:
* Expand to more locking primitives: Figuring out pi-futexes
  would be good too.
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

First described in a paper[2] by Watkins, Straub, Niehaus, then
from patches from Peter Zijlstra, extended with lots of work by
Juri Lelli, Valentin Schneider, and Connor O'Brien. (and thank
you to Steven Rostedt for providing additional details here!)

So again, many thanks to those above, as all the credit for this
series really is due to them - while the mistakes are likely
mine.

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

 include/linux/sched.h        | 130 ++++++++++----
 init/init_task.c             |   6 +
 kernel/fork.c                |   7 +-
 kernel/locking/mutex-debug.c |   4 +-
 kernel/locking/mutex.c       |  86 +++++++--
 kernel/locking/ww_mutex.h    |  20 +--
 kernel/sched/core.c          | 339 ++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h         |   6 +-
 8 files changed, 507 insertions(+), 91 deletions(-)

--=20
2.51.0.536.g15c5d4f767-goog


