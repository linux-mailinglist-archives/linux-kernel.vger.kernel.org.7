Return-Path: <linux-kernel+bounces-818177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2FCB58DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8A2484186
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7042D2C0F93;
	Tue, 16 Sep 2025 05:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4in03emM"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F43450FE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758000559; cv=none; b=fc7AIb1I512KKoC/PGw21THPWZxa6VvZZ2jVgOn1JF3aPMhVWfAc+0SufH4hQkoBGSKdncoQIvm1+z87PRF9WD/tfUOc2YPhVPnJKQTwI07cMWLp1jfmUkp7olUMaq4ygqPTS+XgwUIRAKm7KAnk6of9Zr3WiWE+uDuOVvmWzlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758000559; c=relaxed/simple;
	bh=GaZS/VpqznuFoj0yVp2cj2IVeejlfPxwR9QMsx6P4/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VKREmlVEWpq5ArGv3dy15srExy44wnCtffE6ZJ2MuFNJ5VBedcFTcKHKSDlWPY6ZrhpNATDZDUmplpkVyJgaHyI9H0loyrUigpjgIl6uCwyrAO7Xg0uOa/7wXJMGf9rau8NuVlD2dX6A9X3rudDKY3h8ssPeUWvKYbgxGhwyqEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4in03emM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-252afdfafe1so53303415ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758000555; x=1758605355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oc/sOKvvEyLnVdsFqJE9Br4DNR1GO1Iuj3m1tYjKDlI=;
        b=4in03emMoQ6vPJmZoj3O0xNuabKzOkZU6tt4brhhbX2jYAFc1foGvIa01g4/86i+kY
         0XMOVEUwLPHceQgEnbqHJb3hYi9n3i/EVM4MeBhNceMyC/3yjVufCGK+jxtJrDdATn3O
         u/Gxdz2BOclpcHuyUU0lCtsefDaRzqjcJGbY10qItd04pro8Gm4dL/mANaZtbahyVjF/
         lWYnX0A0wL/COu93TzYlMy4VNRpVOWz+AmfYIRIuGDHQlFf1hgj2lY6W+WKfVcLkaEkJ
         fvDwFM0ASBvBqBNMYGek4cDEggCqMRG58Og77WexsoTi2CU9OWcC4siqd5+4EBuiTOfw
         Oi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758000555; x=1758605355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oc/sOKvvEyLnVdsFqJE9Br4DNR1GO1Iuj3m1tYjKDlI=;
        b=slDwD2InhbM+apqxqcPJxWDCX6bu/cQ/CYnTdk8hI42I3RVCyMqmAwg119VCS1c7s1
         BLvnimiBa0xh4dgSCViYLQoZXr0vHGkFGSXGsWnXuURjg5jvCc8eYTejD8og/VQRRazi
         1mKlyd+3uCDWleGgMJS3kz0LnQGxq9BQbY6tjiT8H9h+9j4NiJBzuaGUdSXu+65YpfDb
         aUUBbk2dLrH7po3YF8Mu7BlUZr7ioD8cT9LHacWw4dnohQLkMUFIRBiFG81ffh1PNHFG
         BLqcM5QsIdxaY4CtSg06dNcU6zQAzp+lWN4wKuMp0YxAWOqSyPvhipyRYtLpIghRJp+/
         qtmA==
X-Gm-Message-State: AOJu0YziC3v7Xcl0o0ZLw9COep61b30/IwpHH+VALKiF4SrdwWAPxNo0
	6VIBjqQ3y/LQaXONcqXMYz52zTe1kHirFr4HIlJakiydnyyXAuTZnI+h0EwIxx72yD5lJECw3YS
	RsgWTQAP56db5U9hrfHpNty5h9+JeJcWK0bRhYRUUGlrw5yBY+49hbioFWYPeaQff9ikgqyoF4T
	CGHCbnpTvbYcPZwmCJJAa7VnNHNpRLwCNds2Go7Fx3IO9rkpfW
X-Google-Smtp-Source: AGHT+IFjajGzvkT8hFJRYWtEOMGpoWWsJS1eQvaW/ltr8HUagS35cqut04mfNzzgWSTwdPDZEWeTefVp2v6V
X-Received: from pjbsn7.prod.google.com ([2002:a17:90b:2e87:b0:325:220a:dd41])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebc5:b0:256:3dfa:1c98
 with SMTP id d9443c01a7336-25d23e13e2emr184133025ad.11.1758000555135; Mon, 15
 Sep 2025 22:29:15 -0700 (PDT)
Date: Tue, 16 Sep 2025 05:28:09 +0000
In-Reply-To: <CANDhNCreD8f6pPjUa--UzXicJr=xnEGGbKdZhmJCeVPgkEV-Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CANDhNCreD8f6pPjUa--UzXicJr=xnEGGbKdZhmJCeVPgkEV-Ag@mail.gmail.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916052904.937276-1-jstultz@google.com>
Subject: [RFC][PATCH] sched/deadline: Fix dl_server getting stuck, allowing
 cpu starvation
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Suleiman Souhlal <suleiman@google.com>, Qais Yousef <qyousef@layalina.io>, 
	Joel Fernandes <joelagnelf@nvidia.com>, kuyo chang <kuyo.chang@mediatek.com>, 
	hupu <hupu.gm@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

With 6.17-rc6, I found when running with locktorture enabled, on
a two core qemu VM, I could easily hit some lockup warnings:

[   92.301253] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 42s!
[   92.305170] Showing busy workqueues and worker pools:
[   92.307434] workqueue events_power_efficient: flags=0x80
[   92.309796]   pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
[   92.309834]     pending: neigh_managed_work
[   92.314565]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=4 refcnt=5
[   92.314604]     pending: crda_timeout_work, neigh_managed_work, neigh_periodic_work, gc_worker
[   92.321151] workqueue mm_percpu_wq: flags=0x8
[   92.323124]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
[   92.323161]     pending: vmstat_update
[   92.327638] workqueue kblockd: flags=0x18
[   92.329429]   pwq 7: cpus=1 node=0 flags=0x0 nice=-20 active=1 refcnt=2
[   92.329467]     pending: blk_mq_timeout_work
[   92.334259] Showing backtraces of running workers in stalled CPU-bound worker pools:

I bisected it down to commit cccb45d7c429 ("sched/deadline: Less
agressive dl_server handling"), and in debugging it seems there
is a chance where we end up with the dl_server dequeued, with
dl_se->dl_server_active. This causes dl_server_start() to
return without enqueueing the dl_server, thus it fails to run
when RT tasks starve the cpu.

I found when this happens, the dl_timer hrtimer is set and calls
 dl_server_timer(), which catches on the
  `if (!dl_se->server_has_tasks(dl_se))`
case, which then calls replenish_dl_entity() and
dl_server_stopped() and finally returns HRTIMER_NORESTART.

The problem being, dl_server_stopped() will set
dl_se->dl_server_idle before returning false (and notably not
calling dl_server_stop() which would clear dl_server_active).

After this, we end up in a situation where the timer doesn't
fire again. And nothing enqueues the dl_server entity back onto
the runqueue, so it never picks from the fair sched and we see
the starvation on that core.

So in dl_server_timer() call dl_server_stop() instead of
dl_server_stopped(), as that will ensure dl_server_active
gets cleared when we are dequeued.

Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
Signed-off-by: John Stultz <jstultz@google.com>
---
NOTE: I'm not confident this is the right fix, but I wanted
to share for feedback and testing.

Also, this resolves the lockup warnings and problematic behavior
I see with locktorture, but does *not* resolve the behavior
change I hit with my ksched_football test (which intentionally
causes RT starvation) that I bisected down to the same
problematic change and mentioned here:
  https://lore.kernel.org/lkml/20250722070600.3267819-1-jstultz@google.com/
This may be just a problem with my test, but I'm still a bit
wary that this behavior change may bite folks.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: kuyo chang <kuyo.chang@mediatek.com>
Cc: hupu <hupu.gm@gmail.com>
Cc: kernel-team@android.com
---
 kernel/sched/deadline.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f25301267e471..215c3e2cee370 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1152,8 +1152,6 @@ static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
 /* a defer timer will not be reset if the runtime consumed was < dl_server_min_res */
 static const u64 dl_server_min_res = 1 * NSEC_PER_MSEC;
 
-static bool dl_server_stopped(struct sched_dl_entity *dl_se);
-
 static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = rq_of_dl_se(dl_se);
@@ -1173,7 +1171,7 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 
 		if (!dl_se->server_has_tasks(dl_se)) {
 			replenish_dl_entity(dl_se);
-			dl_server_stopped(dl_se);
+			dl_server_stop(dl_se);
 			return HRTIMER_NORESTART;
 		}
 
-- 
2.51.0.384.g4c02a37b29-goog


