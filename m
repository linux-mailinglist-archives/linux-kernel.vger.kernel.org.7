Return-Path: <linux-kernel+bounces-877335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB72AC1DE23
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E4B04E18B1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC07E1DF26E;
	Thu, 30 Oct 2025 00:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGk3xee5"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A021C84C6
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783548; cv=none; b=T0+DMe5pNTyLqnyOyMgTJwsob30qyOJn7R99ecE/j8RE1noVtMTGBvU2vOWYsGFfRF/DDcR2SPn3RYmhgGrFJ5RGobmz7bySBYeYzKinYqRAeY/VeHNdw2I7Xiuvu5S5CzM2BISPKJrj1vWqC6o32iW2/p2McNp9lOICZDEONM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783548; c=relaxed/simple;
	bh=4lKVWMzCVAA+UKev1Y/i+yoP3fT7r+NXsqiPCaMN3lc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dP/bzOyk2b7IybI0caHH83XJTSjlghvrzan3v0/6x+jldnH/hdvJZh5SaCPJhrx0cf43+C0FhkF3PUkc7t/IsEyDHU5EradfucaqITRjzEKsQr8XSugerS+Y8lFTSNlOHi8BoSFVvQ5Zyd4wOOCEcfibtXzEkDtv4e5nEt7TgRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGk3xee5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befc08so962101a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761783546; x=1762388346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3VbL2RLeOjLSUJQM2/KV7qhgh5vfmiQYmlgBlL4D9dM=;
        b=EGk3xee5J43B3C9oschtIjFyWGF5jLrh6Yhi9328YYYV55OJPpQFOIFKhcdFJNdaFf
         KKCoiEViIHU5E7OUsHLDZL0R5eeSiyUqYVeWnOlqsv02XEFgjSSwdV2q9hJSwpOd5Ghr
         eenADrwIkGlO49ficckSHQmBoP17HvSpsUqvoJukrSpXEarVrd056darpM1+l3Tm5tf5
         UxjPjNhfrq/zSXuKZ4mnYf3K3qSTr2efo8gTKuqZZ+H6z7RqE+MoXoDwev5ld9Ojc2wT
         W23YcDjZ02PlVAREeIjuqW7hwE2CiVbjLA15VUYMHv5fdtLWiV6p9fzzOJMBDXLYgkqm
         YDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783546; x=1762388346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VbL2RLeOjLSUJQM2/KV7qhgh5vfmiQYmlgBlL4D9dM=;
        b=BHq5IG17jSoOXqmqfU4liITpOVq7UX4W7x3c2WrYq08I37Hgx0ivnUgKnylmHhWB7p
         VnsxCPXGV1msaPr6yO+lGbWUNLBygfKpc8hGkJ8mHLIdft/gy2DD5f9ls2q2maudlmIA
         WW2bA9B8iJC1b9XFK0mwIyTAIWwjBYKA1swJe0xGIPe5zAyGq3Qtc7rqrJOx1KabOj9E
         s8MrOgnRVLxo4R+TkxE53q0FlbTY80ofKDs6u/qVNq4ZXLx62DbAmpMu+IyTjGjsvF7U
         QQCcS+RLiGEpLAaoi7+IAlsAveJrfYqpppwc4uRf9xdCZBjvuPshAmISmioahfwgbNgu
         lSBg==
X-Gm-Message-State: AOJu0YwXhFaJqVeaZWfs+WrA0v9Tn7X6/gwxg7B1FgIti5ocGoaxnTOk
	G6d5Urqu0kH//QRFC1Fst9R/rLR56OJSG23tMN1OlTTONZL+/wHibeeipWUPnNU6l8A/HmDaXbe
	IFDYhMAbr7b7jBDzAhvv3QUKXyh6gD6Sq2jOicD4TBP8YU9QtMWYa0/03SqQ+Bp4+kgcuhwpSgV
	KePAkUMbdjydhiNCBvdaQ87+KjBUZI3shLdQHjyjqolXYienv4
X-Google-Smtp-Source: AGHT+IHndj4sC7MtLZlEGmmYsTN8/RXGKmU2AvSH8/rsywj8lj1UvJt6NxKY1lyMEF82tNU0BNzXAYvD+MRB
X-Received: from pjrv16.prod.google.com ([2002:a17:90a:bb90:b0:33b:c59f:b015])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f44:b0:32d:90c7:c63b
 with SMTP id 98e67ed59e1d1-3403a2f218amr5354166a91.30.1761783545580; Wed, 29
 Oct 2025 17:19:05 -0700 (PDT)
Date: Thu, 30 Oct 2025 00:18:43 +0000
In-Reply-To: <20251030001857.681432-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030001857.681432-3-jstultz@google.com>
Subject: [PATCH v23 2/9] sched: Fix modifying donor->blocked on without proper locking
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

Introduce an action enum in find_proxy_task() which allows
us to handle work needed to be done outside the mutex.wait_lock
and task.blocked_lock guard scopes.

This ensures proper locking when we clear the donor's blocked_on
pointer in proxy_deactivate(), and the switch statement will be
useful as we add more cases to handle later in this series.

Signed-off-by: John Stultz <jstultz@google.com>
---
v23:
* Split out from earlier patch.

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
 kernel/sched/core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 517b26c515bc5..0533a14ce5935 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6591,7 +6591,7 @@ static struct task_struct *proxy_deactivate(struct rq *rq, struct task_struct *d
 		 * as unblocked, as we aren't doing proxy-migrations
 		 * yet (more logic will be needed then).
 		 */
-		donor->blocked_on = NULL;
+		clear_task_blocked_on(donor, NULL);
 	}
 	return NULL;
 }
@@ -6619,6 +6619,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 	int this_cpu = cpu_of(rq);
 	struct task_struct *p;
 	struct mutex *mutex;
+	enum { FOUND, DEACTIVATE_DONOR } action = FOUND;
 
 	/* Follow blocked_on chain. */
 	for (p = donor; task_is_blocked(p); p = owner) {
@@ -6652,12 +6653,14 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 
 		if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {
 			/* XXX Don't handle blocked owners/delayed dequeue yet */
-			return proxy_deactivate(rq, donor);
+			action = DEACTIVATE_DONOR;
+			break;
 		}
 
 		if (task_cpu(owner) != this_cpu) {
 			/* XXX Don't handle migrations yet */
-			return proxy_deactivate(rq, donor);
+			action = DEACTIVATE_DONOR;
+			break;
 		}
 
 		if (task_on_rq_migrating(owner)) {
@@ -6715,6 +6718,13 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		 */
 	}
 
+	/* Handle actions we need to do outside of the guard() scope */
+	switch (action) {
+	case DEACTIVATE_DONOR:
+		return proxy_deactivate(rq, donor);
+	case FOUND:
+		/* fallthrough */;
+	}
 	WARN_ON_ONCE(owner && !owner->on_rq);
 	return owner;
 }
-- 
2.51.1.930.gacf6e81ea2-goog


