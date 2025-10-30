Return-Path: <linux-kernel+bounces-877337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9529C1DE29
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0F084E480F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BE81D5ADE;
	Thu, 30 Oct 2025 00:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Be1VxWX2"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697C21DF965
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783551; cv=none; b=pC4/7cKdDUwtfVm9kccCCPEpXrAUUHdEmD0G4erreUJAMQDO3Sxw+Wj0BtUOuR/bBd/dGhgQkjSGgL0Q/6DT8++sCc+9B79+MhoCG8tiO58qnU4MhgxREUjYX0H8svHRd6c1HOQtpuCM1IbuM2STR9IlMROu6JmX4uiOONBROqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783551; c=relaxed/simple;
	bh=lTBxW1HlNCLzxH9SuLV42ILabS6ahfvA6GNjyJLMQxg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UygH2mIHCHzNd/6L3mAR0nSObuM0k4ldpXQaux3Ze05owX9mIBloMWGKIJaDOsv7ze42OCdNDyNwhbWWc78+zFVjz6puXhvYWgSCrdj5YyHcZn5R711gUzifAHB/dTHjIpeaT6CAWfosq2rzUc7XPRrTEVhrDisHPE7+byhr8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Be1VxWX2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340299fd99dso422686a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761783548; x=1762388348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VbCif3+L3fhPCreoYN0y9QZ8Sz89Lq8flwVG+2/PNww=;
        b=Be1VxWX2ooDF4beoFUqu5tp/8+b6fdm+e+in2sK+e4w3EnNefIYRcQ/G2nI8tdFJpJ
         prKIt4/yyObhr7IsM5WZqaMvK4kze+6yPFQ7OQxt4ohidbalRMVitfM9psF7M6VhgsH2
         Pqhodkmd9Mfuez21wms/m2WVKJpzsVwtTQBo6qGB/Yaj+nXmhhY+fjcHk2VxAfgAmxGx
         JlsF0OINVO9uzt/jH16JKxZENjOklGyIKkUaR2+iI3klaRGwr36LcHZJ2+aUU2nnQGI9
         OBCThGbuUGh1//OKcJJbgcdwjoT6EOMl6t1D36fKaSyc2zsqSdTxLstxb9M3q0r+rFEG
         QRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783548; x=1762388348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbCif3+L3fhPCreoYN0y9QZ8Sz89Lq8flwVG+2/PNww=;
        b=fT33+f4zOlFhpC2cooiMXOryYYr45a+mHJIBUV8ly+13vN20DfKHiSKj7JQqkAVC/+
         tMpCrdD4WE+TSiasfsyFWrP7/zelIb8OmgpCtXol4cN8B/MRrI6qp5Sdhe1Be3RSKGbd
         Cg6uo+rCfTcBgLzMuGv0N+QSG7CgKW0ih3AnVC+8GSiV5AzWDu1SckFojXLZtbQGRxfz
         ePyBIu7eiRw8Vjmu/9pDnONgLnDn1s3OHw4yj82Dz6ieOI3vtI62wTWlb6cbFdFuS4/l
         akhyl0CJITFmudzRRqpTBSgKvdryHwnTzd1dbqwtfcvUXsAhTTwkHA2l+w+LKjq4lwci
         Lb8Q==
X-Gm-Message-State: AOJu0YzxbSagRmP2gC/lTCff7IVXEa1PWSFw+UwVSniRwYauKiIkAq0Q
	coC+WKou4p2KFgUOXzQ1HbhZXBES6d21GNNPqV5ok6IudP6Bzs7wnafHZs7qpg/Qd3DWqexgfRF
	EqvQDE975O6Lvm3+ykn3lZOMP9Do/ZpH14ksLQe7pPP4LP5ocJGl+QF8SgbP+mHB3O5if9fMaHM
	0fNi+aqbdSyiioyNR0U6K/BtskXja8swe5BV9OABVjqOCCoOzj
X-Google-Smtp-Source: AGHT+IGOOl1ihJXIneDYdfhpBDL/gY0wE3Xxrxs0wUzt2nvDzQs5ucb1uOt2xcHmbuJM9m5n5T0D9x6NF/Tl
X-Received: from pjbmr1.prod.google.com ([2002:a17:90b:2381:b0:33e:3117:f86])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b4f:b0:340:54a1:d6fe
 with SMTP id 98e67ed59e1d1-34054a1d8f9mr523111a91.15.1761783548459; Wed, 29
 Oct 2025 17:19:08 -0700 (PDT)
Date: Thu, 30 Oct 2025 00:18:45 +0000
In-Reply-To: <20251030001857.681432-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030001857.681432-5-jstultz@google.com>
Subject: [PATCH v23 4/9] sched: Add assert_balance_callbacks_empty helper
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
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

With proxy-exec utilizing pick-again logic, we can end up having
balance callbacks set by the preivous pick_next_task() call left
on the list.

So pull the warning out into a helper function, and make sure we
check it when we pick again.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: John Stultz <jstultz@google.com>
---
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Qais Yousef <qyousef@layalina.io>
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
---
 kernel/sched/core.c  |  1 +
 kernel/sched/sched.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da6dd2fc8e705..680ff147d270d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6896,6 +6896,7 @@ static void __sched notrace __schedule(int sched_mode)
 	}
 
 pick_again:
+	assert_balance_callbacks_empty(rq);
 	next = pick_next_task(rq, rq->donor, &rf);
 	rq_set_donor(rq, next);
 	if (unlikely(task_is_blocked(next))) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 361f9101cef97..de77b3313ab18 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1779,6 +1779,15 @@ static inline void scx_rq_clock_update(struct rq *rq, u64 clock) {}
 static inline void scx_rq_clock_invalidate(struct rq *rq) {}
 #endif /* !CONFIG_SCHED_CLASS_EXT */
 
+#ifdef CONFIG_PROVE_LOCKING
+static inline void assert_balance_callbacks_empty(struct rq *rq)
+{
+	WARN_ON_ONCE(rq->balance_callback && rq->balance_callback != &balance_push_callback);
+}
+#else
+static inline void assert_balance_callbacks_empty(struct rq *rq) {}
+#endif
+
 /*
  * Lockdep annotation that avoids accidental unlocks; it's like a
  * sticky/continuous lockdep_assert_held().
@@ -1795,7 +1804,7 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
-	WARN_ON_ONCE(rq->balance_callback && rq->balance_callback != &balance_push_callback);
+	assert_balance_callbacks_empty(rq);
 }
 
 static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
-- 
2.51.1.930.gacf6e81ea2-goog


