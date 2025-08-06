Return-Path: <linux-kernel+bounces-758214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57547B1CC94
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B65C623AD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B660F29E115;
	Wed,  6 Aug 2025 19:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drG2ce1P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD90A24BCE8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754509448; cv=none; b=qH53wdBaJRaxswm3o48pq7E3rudejqPG57bQ70zdBwmRtZw/o6bvBhvsN/lpnG0EPFeEvNiWLzY8JyLr6+Ox9X/v4l9rHGAv0Yj9Z6CQnPYACQ7sBTdX2SvqvchOeX6NwZKZjMb/uf1aMtNzCBnqjWjgIX+LMxIgnmD6wa4Uly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754509448; c=relaxed/simple;
	bh=jeo7QCPQKOw+GmDQcDoNbUwbP4YWYbMmHOdqRewcV7o=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tsTvX0rHUS5nUBLIx5rTTSk9Qid84fHqmC6zYrironRRye9bI+nkME7dXcIHA7dY1uWVakWrx3/FTYCUAEdGqwaqdOOm2yXC40ADKn4rH5cq6ms2P9ZdvLhf8qBVD6ADBflITAs9z/u97hcilbbUvmutLkYTQhqRCvYE7Z2dwio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drG2ce1P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754509445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=pBlXLdMVS9+42WdjrfWhCvpkY35dKzexiVfH6Ml4CIM=;
	b=drG2ce1PJt0qzoHozg2xngzDsSEYhqi5CRf2aZa5htEvYtQ73AjhGWO/PgcdpD9TLhoxP4
	DC1HxDkuRcSH9eh2MISvZSDsh9U6do1o9DCdGoLNzVBcjs6NIYYwumK0T8Ptrq8GRAlVTy
	8OUXKjM9UdUkinPjEbRpv/nPvOCy9EA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-5BoV10lpNOu-eFPFIfLZug-1; Wed,
 06 Aug 2025 15:44:01 -0400
X-MC-Unique: 5BoV10lpNOu-eFPFIfLZug-1
X-Mimecast-MFC-AGG-ID: 5BoV10lpNOu-eFPFIfLZug_1754509439
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2011119560AF;
	Wed,  6 Aug 2025 19:43:59 +0000 (UTC)
Received: from localhost (unknown [10.22.80.109])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C7961800281;
	Wed,  6 Aug 2025 19:43:56 +0000 (UTC)
Date: Wed, 6 Aug 2025 16:43:55 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: [RESEND PATCH] sched: restore the behavior of put_task_struct() for
 non-rt
Message-ID: <aJOwe_ZS5rHXMrsO@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Commit 8671bad873eb ("sched: Do not call __put_task_struct() on rt
if pi_blocked_on is set") changed the behavior of put_task_struct()
unconditionally, even when PREEMPT_RT was not enabled, in clear mismatch
with the commit description.

Restore the previous behavior of put_task_struct() for the PREEMPT_RT
disabled case.

Fixes: 8671bad873eb ("sched: Do not call __put_task_struct() on rt if pi_blocked_on is set")
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ea41795a352b..51678a541477 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -130,6 +133,16 @@ static inline void put_task_struct(struct task_struct *t)
 	if (!refcount_dec_and_test(&t->usage))
 		return;
 
+	/* In !RT, it is always safe to call __put_task_struct(). */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
+
+		lock_map_acquire_try(&put_task_map);
+		__put_task_struct(t);
+		lock_map_release(&put_task_map);
+		return;
+	}
+
 	/*
 	 * Under PREEMPT_RT, we can't call __put_task_struct
 	 * in atomic context because it will indirectly
@@ -137,10 +150,6 @@ static inline void put_task_struct(struct task_struct *t)
 	 * current process has a mutex enqueued (blocked on
 	 * a PI chain).
 	 *
-	 * In !RT, it is always safe to call __put_task_struct().
-	 * Though, in order to simplify the code, resort to the
-	 * deferred call too.
-	 *
 	 * call_rcu() will schedule __put_task_struct_rcu_cb()
 	 * to be called in process context.
 	 *


