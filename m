Return-Path: <linux-kernel+bounces-595074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B228FA819D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 02:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9769C4614BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 00:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC16134BD;
	Wed,  9 Apr 2025 00:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3Yp7ld9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AABAEC5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 00:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744158468; cv=none; b=bk1F4XYG/0exDQxNpyv86xoLa36Tkm9HussQx+OFt8yRXHvJi4RXvVTQrcT/9bsqe2NynEFP8CE3OmHZL/O28Pzy+VAQq4j3owdBe2T2lmMHIq8KgVa+UQjEr6jPs5dYsbsDXw5/w6HhgWjBfV/z8ta9PuD6FgweAfEm8bjSGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744158468; c=relaxed/simple;
	bh=QFeojmhh2AL7Qwg/Q1CkKXHym/lsrMa9DzqucyYU17c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ptq6T3PEl75iKcG844PyT8tnR/aI7u9AQGw/UiNQE9eDzHQEZMoZJZJBNH7SxIhGuSSnGHZj7m9KqtaSDZVAUUmXpmWUPYCRqv8KdM/Uje+vyLZmA4YKBRAHI5OxKCk4MuQdu15EgHpiFKO/BF8sANfZT6H6jQ/PmTOqeYVjlWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3Yp7ld9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744158465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=FCwHFlrik8lCs4etyT6GX5kQRWLhEIHfgiAg7N6D9M0=;
	b=Y3Yp7ld9uSdWFlhuNhwGLC4VczL84OstnuDCctTC2DZwokc5/iAF1moeIjSRhFOjO258By
	TecQNW14esCq7Mo4RES4vJYEAjffQp1nSsPPypVG3MYJPRZY7IrPzdBVUSHZ9kcHjqN/E4
	orWf6F0WtmbAC8pdCv4V9W1Pv9o8KKk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-DOq1MXvtNwa92qIolvi2eQ-1; Tue,
 08 Apr 2025 20:27:41 -0400
X-MC-Unique: DOq1MXvtNwa92qIolvi2eQ-1
X-Mimecast-MFC-AGG-ID: DOq1MXvtNwa92qIolvi2eQ_1744158460
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4240E1800259;
	Wed,  9 Apr 2025 00:27:40 +0000 (UTC)
Received: from localhost (unknown [10.22.88.189])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45C8B180175B;
	Wed,  9 Apr 2025 00:27:39 +0000 (UTC)
Date: Tue, 8 Apr 2025 21:27:37 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, lclaudio00@gmail.com
Subject: [PATCH] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <Z_W-i-ya0Q6fkXRh@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
from rt_mutex_adjust_prio_chain() could happen in preemptible context and
with a mutex enqueued. That could lead to this sequence:

	rt_mutex_adjust_prio_chain()
	  put_task_struct()
	    __put_task_struct()
	      sched_ext_free()
	        spin_lock_irqsave()
	          rtlock_lock() --->  TRIGGERS
	                              lockdep_assert(!current->pi_blocked_on);

Adjust the check in put_task_struct() to also consider pi_blocked_on before
calling __put_task_struct(), resorting to the deferred call in case it is
set.

Suggested-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 include/linux/sched/task.h |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0f2aeb37bbb04..638114f66a4d7 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -130,14 +130,22 @@ extern void __put_task_struct_rcu_cb(struct rcu_head *rhp);
 
 static inline void put_task_struct(struct task_struct *t)
 {
+	bool defer = false;
+
 	if (!refcount_dec_and_test(&t->usage))
 		return;
 
 	/*
 	 * In !RT, it is always safe to call __put_task_struct().
-	 * Under RT, we can only call it in preemptible context.
+	 * Under RT, we can only call it in preemptible context,
+	 * when not blocked on a PI chain.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+#ifdef CONFIG_PREEMPT_RT
+	if (!preemptible() || current->pi_blocked_on)
+		defer = true;
+#endif
+
+	if (!defer) {
 		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
 
 		lock_map_acquire_try(&put_task_map);
@@ -149,7 +156,9 @@ static inline void put_task_struct(struct task_struct *t)
 	/*
 	 * under PREEMPT_RT, we can't call put_task_struct
 	 * in atomic context because it will indirectly
-	 * acquire sleeping locks.
+	 * acquire sleeping locks. The same is true if the
+	 * current process has a mutex enqueued (blocked on
+	 * a PI chain).
 	 *
 	 * call_rcu() will schedule delayed_put_task_struct_rcu()
 	 * to be called in process context.
-- 
2.49.0




