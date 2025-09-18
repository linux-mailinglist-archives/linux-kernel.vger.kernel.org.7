Return-Path: <linux-kernel+bounces-768074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1F8B25CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848ED582F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9902625A659;
	Thu, 14 Aug 2025 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="Ibr372lp"
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB0576026
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155276; cv=none; b=CVNqJ2/z6Cr+iZcoZr23v5T5eScuZvxUMyUHq0Z6NRB5el9CAHNUMkubnCPg4s9rW8YQoVOmo5lbFrrrxWHj1TVhhiFq/UeF7wKv7kpPQbQJAWqQaZVPLP0jpAv83axxnXLbsvR/rL3JPwQ1ypKhViJLaKnj0PXQpudPMHhNb7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155276; c=relaxed/simple;
	bh=HyBSVP9vaW+zxs8yUs65KBf1dFoj9lJNktmuMf6kBsw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FK+gGDRnqFynpNnONFvUzmMSvE8GSCFeTr32NIBHE8NOHzhCOfFnmXKFigBTKOcceqJBPAe+Uch838n2Ys3bmynEOESlJIOo873vHoqbIuVSXXFgUp4vfyFtCZsYYxkmvGtArxDrpljAgZXHig3Ll1Fh2NEZtBKm/U3m06JHpdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=Ibr372lp; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 57E77SQA095728;
	Thu, 14 Aug 2025 15:07:28 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4c2bsB66Lpz2L4ry1;
	Thu, 14 Aug 2025 15:07:10 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 14 Aug 2025 15:07:25 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <rostedt@goodmis.org>, <surenb@google.com>, <hannes@cmpxchg.org>,
        <peterz@infradead.org>, <mingo@redhat.com>
CC: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>, <andrii@kernel.org>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <yuming.han@unisoc.com>,
        <ke.wang@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [RFC PATCH] sched: psi: Add psi events trace point
Date: Thu, 14 Aug 2025 15:07:19 +0800
Message-ID: <20250814070719.865-1-xuewen.yan@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 57E77SQA095728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1755155261;
	bh=CUVJOspjeTissTdOFBExc/EBuLf29IJX1c9mooiSAas=;
	h=From:To:CC:Subject:Date;
	b=Ibr372lp6cWBsXFN0OI1YVMyDpxSu6HP0F+zRzybeYAPc+BtVUGnjaWgDmfbGtS9d
	 nLo9PVkeKduMonh05kZ8F+PdqRrXNtpG2dTtD2Ck6mnlZYGlqcyFbEIQ2tlC42inLR
	 3QEvcxjpaDGvKhMJ3lMCdblMikHWqQbRQCqOxiS9onZcxVJujx2je1m93uDC1oY9TZ
	 nwNH8gMoGXl/A8CSTVhcCjNSAsgqLKL95lVrABhO0+QOKt0XPZdGirdmiHdjBLDmpK
	 Ing4uonbCJK1Br8NLQ5qsqhGHX39DzJoscNtSnwJT3hmc+lIwjiO6688cr7wNNnMhM
	 OsLAx1VRH1gSQ==

Add trace point to psi triggers. This is useful to
observe the psi events in the kernel space.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 include/trace/events/sched.h | 5 +++++
 kernel/sched/psi.c           | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..c23cb2bc76fd 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -896,6 +896,11 @@ DECLARE_TRACE(sched_set_need_resched,
 	TP_PROTO(struct task_struct *tsk, int cpu, int tif),
 	TP_ARGS(tsk, cpu, tif));
 
+struct psi_trigger *t
+DECLARE_TRACE(psi_event,
+	TP_PROTO(struct psi_trigger *t),
+	TP_ARGS(t));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 59fdb7ebbf22..268fc1b9cf1d 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -509,6 +509,8 @@ static void update_triggers(struct psi_group *group, u64 now,
 		if (now < t->last_event_time + t->win.size)
 			continue;
 
+		trace_psi_event_tp(t);
+
 		/* Generate an event */
 		if (cmpxchg(&t->event, 0, 1) == 0) {
 			if (t->of)
-- 
2.25.1


