Return-Path: <linux-kernel+bounces-816740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03450B577D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8081E3B3A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1F2FE593;
	Mon, 15 Sep 2025 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYRbKVaK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F114207A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934930; cv=none; b=Rfcq11QDG3TRwK6JUnEuEBq3TWX2E4hfm3nAbh+Rer3UE2yh6G0WpDNP1H7oa0CTR7ITdFDegYorNp1IAhb5JAdx1JwUOSxEkdQFcJqmkr7+mReZhCAckwfmpBPAhkMjP36JFkilU0iUAUbOzHtPtjrIRyoUEJd8PC0Z/S+rsS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934930; c=relaxed/simple;
	bh=whqycwxgm/yIVd+t1RpvhrVyMjsrVcJBz5qVDseaEqY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dQ3XBkFcjC8e8ubcWzvZKbSSoGwTQeJ0cOhrPYYwu1UiM6k4DF0OeOb1uKTjwRNl3qGOckQGg7Xgrue+5JnKUXC7RK5u4FJkJUrpH+JHK3ZHhusGqaZ79nfAPhfwDYUoW1NV6Uu36wsPoW8dDrAKDxz7i4PFNT/5RfUfen4L4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IYRbKVaK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757934928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=RXByJ4CfA0alHA8kHGbzYj3Hws4Ij2be1qg3KmmWQTQ=;
	b=IYRbKVaKasOEaZlTP72yb6cDDl2WSUcKv34gx9m795uEzHm7qrjt4coyHXyDpB9vF9lx6y
	dnnJxpC+FT3Dzup/CUmod9KtxGHMMxMANa6szYIEgCTHYg14f+uu6snPQiedS3ponD40iw
	EMNXbGu7MWiqb7RMPneX/xCjSLHlfq8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-Ir3v-6qKMr-8X3Qp2_F5PQ-1; Mon,
 15 Sep 2025 07:15:25 -0400
X-MC-Unique: Ir3v-6qKMr-8X3Qp2_F5PQ-1
X-Mimecast-MFC-AGG-ID: Ir3v-6qKMr-8X3Qp2_F5PQ_1757934923
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1CF61800371;
	Mon, 15 Sep 2025 11:15:22 +0000 (UTC)
Received: from localhost (unknown [10.22.88.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 624FA19560A2;
	Mon, 15 Sep 2025 11:15:20 +0000 (UTC)
Date: Mon, 15 Sep 2025 08:15:19 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
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
Message-ID: <aMf1RzZHjdoPNOv_@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

  Note: This patch is a fix motivated by Oleg Nesterov's question at
  https://lore.kernel.org/linux-rt-devel/20250728201441.GA4690@redhat.com/

  Also, the kernel test robot reported a problem found in a x86 (32 bit) VM
  test that was bisected to the original fix being amended here:

    https://lkml.org/lkml/2025/9/5/147

  Though I was not able the reproduce the reported problem, this patch here
  would minimize the problem by isolating the behavior to PREEMPT_RT-enabled
  kernels.

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




