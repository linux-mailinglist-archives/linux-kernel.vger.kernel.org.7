Return-Path: <linux-kernel+bounces-777564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F77B2DAED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0BA173761
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4B32E3AEE;
	Wed, 20 Aug 2025 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="eV/RzVBm"
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2E5353371
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689219; cv=none; b=XImvwDlF8b3m6g1k4fKTKFYp+EbAgCJo8FdoHHkxL2lzBGXEUMQwUSGAUule5q6I4UCpqikJknwsP6023rXu5CLU0/ACz0n2rmHg2fzf9Qa/q0/aSgrYIiwQXTqAGx32pfOAwA12+S+XxPbb39sABPYRePdcFXzzAuaW9ZOnyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689219; c=relaxed/simple;
	bh=T5FvkqWOXad4x0y8AzXJoCUnNRNy9Ko6IXABOeQg53w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u57xlcxLPo3ZfjTAthwVzzW5e8yUKYkAWHGxotySgxgigkuqU5QWV9t9EFtapmtaDjkK5k+0VMGh0UjQEzujyuQEb/mBIWhdAUxnkMPkCzxRWGsSDEaioVokXl3sPPA8rymr3mReaTKKVhZ8sX/KjmAIuBn/6wdzWpATtVBWApw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=eV/RzVBm; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 57KBQa2i021503;
	Wed, 20 Aug 2025 19:26:36 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4c6PKB1H8Nz2LGccR;
	Wed, 20 Aug 2025 19:26:06 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Wed, 20 Aug 2025 19:26:33 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <hannes@cmpxchg.org>, <surenb@google.com>, <peterz@infradead.org>,
        <mathieu.desnoyers@efficios.com>, <mhiramat@kernel.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>
CC: <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <yuming.han@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [RFC PATCH V2] sched: psi: Add psi events trace point
Date: Wed, 20 Aug 2025 19:26:21 +0800
Message-ID: <20250820112621.4045-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 57KBQa2i021503
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1755689202;
	bh=CYYb5kpRQZSLKYpYw4o6JXQoxBGPulNHrelKWKt6GvE=;
	h=From:To:CC:Subject:Date;
	b=eV/RzVBmwFXmiG/DR2lEH+voNk41Bv8PmU5yk4+hGzFvyFfYJXBVhgTIkmPkvxH9c
	 M5eac89AF0PWLQfCX82IgWkSrdskCifhoMbgBCpsFgw5gerYcOLaO//V1TYF5J3yDp
	 hi/vQbDJbwM87PH+YRJGphrAxapL1byVaHJRt2FY6e6qnotm8rZoxazrTDWSLDFaE1
	 S5FjjWuW8WenstjplG2ybAnX0CRaf1F1SL2xFA6eJB7kCbmYd7O6mR5+mleakBBhSd
	 0IirhnIqyQPAFKFb8nmLE4Y9suYvYNqxYe0bqCKFsuTz7N6eGsSR7pHu6UZ3Mj+PCE
	 x7I8ScwFiphhA==

Add trace point to psi triggers. This is useful to
observe the psi events in the kernel space.

One use of this is to monitor memory pressure.
When the pressure is too high, we can kill the process
in the kernel space to prevent OOM.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
v2:
-fix compilation error;
-export the tp;
-add more commit message;
---
 include/trace/events/sched.h | 5 +++++
 kernel/sched/psi.c           | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..d54db5fcbca2 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -896,6 +896,11 @@ DECLARE_TRACE(sched_set_need_resched,
 	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
 	TP_ARGS(tsk, cpu, tif));
 
+struct psi_trigger;
+DECLARE_TRACE(psi_event,
+	TP_PROTO(struct psi_trigger *t),
+	TP_ARGS(t));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 59fdb7ebbf22..f06eb91a1250 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -141,6 +141,8 @@
 #include <linux/psi.h>
 #include "sched.h"
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(psi_event_tp);
+
 static int psi_bug __read_mostly;
 
 DEFINE_STATIC_KEY_FALSE(psi_disabled);
@@ -509,6 +511,8 @@ static void update_triggers(struct psi_group *group, u64 now,
 		if (now < t->last_event_time + t->win.size)
 			continue;
 
+		trace_psi_event_tp(t);
+
 		/* Generate an event */
 		if (cmpxchg(&t->event, 0, 1) == 0) {
 			if (t->of)
-- 
2.25.1


