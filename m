Return-Path: <linux-kernel+bounces-836240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7456EBA914A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DE01920260
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0F1301713;
	Mon, 29 Sep 2025 11:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c78aQZ6R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE4301715
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146165; cv=none; b=kOHCWKkdug4/DSVYTi6QbZBkrBX2iaFBeOLPGBTNxMEfbgymcp3N0/ab354z0GIebRc/IeHMuTFVSCOF/QJfF0MD0oesfGSn6E+ltVUoIvS5iN2Shijcf+6bvmv26lhPkBpxxy0ypi3aJo2BMHogMiuHsCOojvdzhkbP4cvpUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146165; c=relaxed/simple;
	bh=qr/trcihkG+XrW9xDQRtoLcrPWFzaIqNEFnGLgE07M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2evARRLZKYAcHvT/FSaJ89KBdEfwL5LIYsP0bix0MQPPF1pCexNI6ByzvCs+c/+YR0o79mvAuGBGunJOlX13Smse34BxwRFZr+Vt/dQEIBquJ871KuXwYkTJP94e6hqnd2598K64D+vGYgsNEGhJefOtgZqx+rNh6cud0C8IzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c78aQZ6R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759146162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7CDCxarxuDZf7gpcfd/wrLBO5nbTQ99uYCOatcpUvM=;
	b=c78aQZ6R3yig9Bw8UWgSdDSnDCATmXQoMQr8yY7DbT7pt++kT32CD+/LLwoc/fT3FQINNn
	mZe7AIDhQjewakhqwWCWw9ig2WB8f9/DF+DSxW6vzS/rgWLTaR1w+nM/UfXRWarHWvNN05
	P3vcNdK6eqd2kMRpKwhqjTumnTNoO70=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-MfkUXi85OjOTAJLLwQbfAQ-1; Mon,
 29 Sep 2025 07:42:39 -0400
X-MC-Unique: MfkUXi85OjOTAJLLwQbfAQ-1
X-Mimecast-MFC-AGG-ID: MfkUXi85OjOTAJLLwQbfAQ_1759146158
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A13AA1800370;
	Mon, 29 Sep 2025 11:42:37 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C227E19560A2;
	Mon, 29 Sep 2025 11:42:33 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	sched-ext@lists.linux.dev
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v3 1/4] sched: Add prev_sum_exec_runtime support for RT, DL and SCX classes
Date: Mon, 29 Sep 2025 13:42:22 +0200
Message-ID: <20250929114225.36172-2-gmonaco@redhat.com>
In-Reply-To: <20250929114225.36172-1-gmonaco@redhat.com>
References: <20250929114225.36172-1-gmonaco@redhat.com>
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
index e2d51f4306b3..212d6bf5a732 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2342,6 +2342,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_dl_rq(&p->dl))
 		update_stats_wait_end_dl(dl_rq, dl_se);
+	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
 
 	/* You can't push away the running task */
 	dequeue_pushable_dl_task(rq, p);
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7dedc9a16281..7c2d23e6d0df 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3257,6 +3257,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
+	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(sch, running) && (p->scx.flags & SCX_TASK_QUEUED))
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7936d4333731..8c713d74672a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1644,6 +1644,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_rt_rq(&p->rt))
 		update_stats_wait_end_rt(rt_rq, rt_se);
+	p->se.prev_sum_exec_runtime = p->se.sum_exec_runtime;
 
 	/* The running task is never eligible for pushing */
 	dequeue_pushable_task(rq, p);
-- 
2.51.0


