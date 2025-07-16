Return-Path: <linux-kernel+bounces-733918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC66B07AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FAC1C24C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145652F5467;
	Wed, 16 Jul 2025 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJ8A84mw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F81A238C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682011; cv=none; b=nmjXQj2qaAKJ78iYJm1KyH9H/r3ad6Y/H8QJItx8FrB7k0cJviG/8mxhMr39Bxx2gJgJ8a718cOqJelqOcw+COyPaYy41DUh944NBWuBtGzrGUlg91iDDSh5Q5BrXm5AV+R+lZqulHF3M/lXV6KTKJ2Cz4rAhU9J/iVMSuONThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682011; c=relaxed/simple;
	bh=edSYU/bBIK5jUtlJoKdM/Esaxbt7uRjtsFTqe0jDFKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=du7ShCeIxG+dPZIa67dHgzDaVVLryikzNUBA4WHB9cxVUFEat3vDyGckwATqTEetdKJvyo9CeN6ARxG3bUABiFghS7N2JUfNBqc+R4fWMoVDUojOO3Lqz+j3rwn2bOAtjsk0gBRU+LW4bce9o86N9KPiA8TQAHWyww2NvXd4NKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJ8A84mw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752682008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUMR6AgLLIFcwMdK2r2Cw5KLluDgtRgYt1YiW6x37yA=;
	b=CJ8A84mwhgN4XHGJjFOK47yehMBJGlWalNI1gqCX+0JKZMUgcBL5qMFmLs1DwYzWhreSUc
	fOZpYm2sQgXLvzMlt1Wwx56WXiil1DVOBlNELcpbJ73QJPeeXbI4kYuwAtabEEVJhfWMpH
	XdGFvFXm4VdngQUVv54YsF6tLG7ZsYQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-_l-FqFHJO2OE8CwW5JxQEQ-1; Wed,
 16 Jul 2025 12:06:45 -0400
X-MC-Unique: _l-FqFHJO2OE8CwW5JxQEQ-1
X-Mimecast-MFC-AGG-ID: _l-FqFHJO2OE8CwW5JxQEQ_1752682004
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0002F19560A5;
	Wed, 16 Jul 2025 16:06:43 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.33.144])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE7DA19560AB;
	Wed, 16 Jul 2025 16:06:40 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	sched-ext@lists.linux.dev
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.org>
Subject: [PATCH v2 1/4] sched: Add prev_sum_exec_runtime support for RT, DL and SCX classes
Date: Wed, 16 Jul 2025 18:06:05 +0200
Message-ID: <20250716160603.138385-7-gmonaco@redhat.com>
In-Reply-To: <20250716160603.138385-6-gmonaco@redhat.com>
References: <20250716160603.138385-6-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The fair scheduling class relies on prev_sum_exec_runtime to compute the
duration of the task's runtime since it was last scheduled. This value
is currently not required by other scheduling classes but can be useful
to understand long running tasks and take certain actions (e.g. during a
scheduler tick).

Add support for prev_sum_exec_runtime to the RT, deadline and sched_ext
classes by simply assigning the sum_exec_runtime at each set_next_task.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/sched/deadline.c | 1 +
 kernel/sched/ext.c      | 1 +
 kernel/sched/rt.c       | 1 +
 3 files changed, 3 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 89019a1408264..65ecd86bae37d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2389,6 +2389,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_dl_rq(&p->dl))
 		update_stats_wait_end_dl(dl_rq, dl_se);
+	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
 
 	/* You can't push away the running task */
 	dequeue_pushable_dl_task(rq, p);
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d867ba210..a4ac4386b9795 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3255,6 +3255,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
+	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e40422c370335..2c70ff2042ee9 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1693,6 +1693,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_rt_rq(&p->rt))
 		update_stats_wait_end_rt(rt_rq, rt_se);
+	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
 
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
-- 
2.50.1


