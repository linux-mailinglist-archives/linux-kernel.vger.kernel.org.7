Return-Path: <linux-kernel+bounces-811323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0712DB52775
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3655683538
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E99322578A;
	Thu, 11 Sep 2025 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="n1IVZ1aF"
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208AC33D8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757563636; cv=none; b=b5nJQUjabmIdbsij4bP2tQyhPz59jyPFb9qUHM3PfDmAiTXh1WlX13sA/sl3S+A59MyykpHsxWU3h+KnjhjBaHYob16auZLFpbzQdq87CkDiCU93NGsLd3z6uDK3+EgAB+1RukPDKw0hqefOKbAdfEm/atJe/PxuOvJJu6eJbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757563636; c=relaxed/simple;
	bh=qCzaKRorJQePW/uhpqRSRFI0E9oF/wPtqDWBdpBhkNQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oUt8lmKmoxxlmddBvLav2Ch9FVUg9YIe+7Yi4d+L5ZjPnwsNkX6Y9oB5YExfjLnbxheNwJzjHPhYw50mUT+lEl1Lbf6Qv5a7MFmOQQXrtvJh9NcZgSLvbVSwatnX8lnDXwKCQbKditG9Sawnq+pB0VIWvroL7vvJy9r/c/Z12EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=n1IVZ1aF; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 58B3T6ZM017163
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:29:06 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 58B3Ski4015183;
	Thu, 11 Sep 2025 11:28:46 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4cMjfq6Y3Fz2K85Cv;
	Thu, 11 Sep 2025 11:27:31 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 11 Sep 2025 11:28:43 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <surenb@google.com>, <hannes@cmpxchg.org>,
        <mathieu.desnoyers@efficios.com>, <mhiramat@kernel.org>,
        <peterz@infradead.org>
CC: <rostedt@goodmis.org>, <mingo@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        <yuming.han@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [RFC PATCH V3] sched: psi: Add psi events trace point
Date: Thu, 11 Sep 2025 11:28:23 +0800
Message-ID: <20250911032823.19064-1-xuewen.yan@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 58B3Ski4015183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1757561338;
	bh=vUM8qbMYMuAVqYzJMiNpNcIBhZeou0MfXEpjzcgC13o=;
	h=From:To:CC:Subject:Date;
	b=n1IVZ1aFuTHcdswfK0xToD2rap5v73klslzto/+OsmK4vB+ucB/jjmgkRd76U6Vdb
	 +ADIsfdvtTkICSxkneXz4PCx/nBDRlhLni9hvVJpFQye/pESUJHI751Q8Gx0siQbex
	 VTVz8oG461S8wuG2vhvf4rCIUQPx/nB1PVhcl175iRf9hSDalvcTRRL9emArWT1K8+
	 2TU1IyV7CksYBj9//Jgqo5t9JzC6nF8RTwKsZkYeiimf9l6rZeJmvDmCIY9zEPvhPy
	 vQ+VyuLMDUGAXT/flDTupF1Mda+7L8BFjZZYJHjmNjwmC3AnMJGckTGXhTM+h5ENp3
	 kBm/4CB4itGPQ==

Add trace point to psi triggers. This is useful to
observe the psi events in the kernel space.

One use of this is to monitor memory pressure.
When the pressure is too high, we can kill the process
in the kernel space to prevent OOM.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
V3:
-export it in the tracefs;
---
v2:
-fix compilation error;
-export the tp;
-add more commit message;
---
 include/trace/events/sched.h | 27 +++++++++++++++++++++++++++
 kernel/sched/psi.c           |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..db8b8f25466e 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -826,6 +826,33 @@ TRACE_EVENT(sched_wake_idle_without_ipi,
 	TP_printk("cpu=%d", __entry->cpu)
 );
 
+#ifdef CONFIG_PSI
+TRACE_EVENT(psi_event,
+
+	TP_PROTO(int aggregator, int state, u64 threshold, u64 win_size),
+
+	TP_ARGS(aggregator, state, threshold, win_size),
+
+	TP_STRUCT__entry(
+		__field(int,	aggregator)
+		__field(int,	state)
+		__field(u64,	threshold)
+		__field(u64,	win_size)
+	),
+
+	TP_fast_assign(
+		__entry->aggregator	= aggregator;
+		__entry->state		= state;
+		__entry->threshold	= threshold;
+		__entry->win_size	= win_size;
+	),
+
+	TP_printk("aggregator=%d state=%d threshold=%llu window_size=%llu",
+		__entry->aggregator, __entry->state, __entry->threshold,
+		__entry->win_size)
+);
+#endif /* CONFIG_PSI */
+
 /*
  * Following tracepoints are not exported in tracefs and provide hooking
  * mechanisms only for testing and debugging purposes.
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 59fdb7ebbf22..5b7954b653ed 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -141,6 +141,8 @@
 #include <linux/psi.h>
 #include "sched.h"
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(psi_event);
+
 static int psi_bug __read_mostly;
 
 DEFINE_STATIC_KEY_FALSE(psi_disabled);
@@ -509,6 +511,8 @@ static void update_triggers(struct psi_group *group, u64 now,
 		if (now < t->last_event_time + t->win.size)
 			continue;
 
+		trace_psi_event(aggregator, t->state, t->threshold, t->win.size);
+
 		/* Generate an event */
 		if (cmpxchg(&t->event, 0, 1) == 0) {
 			if (t->of)
-- 
2.25.1


