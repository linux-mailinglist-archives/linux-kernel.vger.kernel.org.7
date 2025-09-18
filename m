Return-Path: <linux-kernel+bounces-822277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD6EB8370F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D7E1C82543
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F2B2F28F9;
	Thu, 18 Sep 2025 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JK00hdel"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A382E9746
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182817; cv=none; b=f5E2rKTWUjZ80PH288HqI/hJs40ghLol9Kj/Q0R3oCUzCqYNV9jhQ9nGINJCF4xrVHIrmMvUsDcDoNUbj6zhdw0JZLEo6hJjRzenlTjIBiCgSw6PSGwzoYtdLh+A+KwYmCTWHTMcgkc1vVQh/NQo8a8WbnWXa9FXGvGHFV2vams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182817; c=relaxed/simple;
	bh=hqtAxj4Qr3+FMgaGa6Yi/VBeDgiyWZo+kDAH6v7C9SQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RcsIuW3gbLbEmw/vPfxWzdDE0EPPKdg/IaOv/MuHeiJMS5BV6vGWLyN2fcH0/PgpBPjujaydg5LBExT7dRd96VwnOAWvpeLBOMMzqH5/CTl3m+8cxTjGRoYN4raWBbF3U4eKQ0C2yK0cWfXdWMuGdemg230tvqb/IGmSb1aNyoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JK00hdel; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=g7pmX4SB9lVXDbhwfM+ZH5mANed4a5N6NuoCNhx0Q44=; b=JK00hdelnc73SIJ3z9SK+jpKAg
	kbRRElBhZvUPaUC5e5Zexk9SfX5EImAnRgHEdu1RCl4Prwmi26G0bsQs6hDTSB1nrk3UIkL3ofICR
	ABgXFnNFyZjpUA4M1FCEnWGs2v3ovYv6rqoT7lch1GnTxknIuvm8/+XcgcQ74t42rvAzfWXZ3uK6J
	faYWyHMcviziYIutShSEiOnrVbNaksfqFh6I/VDQqpo72eOyfuwS5xO7MtTuq1woXSOCLje8l/ls9
	hRFLmhSWhNxuD4DyhQv0BkT45lgIkCb0n73Ciq5TAhNNQXW+3dBwrGQHMe+C3S3i3l60tQ+UDl57V
	iBCgRI0g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9fC-0000000FbrP-2D2c;
	Thu, 18 Sep 2025 08:06:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 1F132302E34; Thu, 18 Sep 2025 10:06:46 +0200 (CEST)
Message-ID: <20250918080205.716937764@infradead.org>
User-Agent: quilt/0.68
Date: Thu, 18 Sep 2025 09:52:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: arnd@arndb.de,
 anna-maria@linutronix.de,
 frederic@kernel.org,
 peterz@infradead.org,
 luto@kernel.org,
 mingo@redhat.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 oliver.sang@intel.com
Subject: [PATCH 3/8] sched/eevdf: Fix HRTICK duration
References: <20250918075219.091828500@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The nominal duration for an EEVDF task to run is until its deadline.
At which point the deadline is moved ahead and a new task selection is
done.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6775,21 +6775,39 @@ static inline void sched_fair_update_sto
 static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
+	unsigned long scale = 1024;
+	unsigned long util = 0;
+	u64 vdelta;
+	u64 delta;
 
 	WARN_ON_ONCE(task_rq(p) != rq);
 
-	if (rq->cfs.h_nr_queued > 1) {
-		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
-		u64 slice = se->slice;
-		s64 delta = slice - ran;
-
-		if (delta < 0) {
-			if (task_current_donor(rq, p))
-				resched_curr(rq);
-			return;
-		}
-		hrtick_start(rq, delta);
+	if (rq->cfs.h_nr_queued <= 1)
+		return;
+
+	/*
+	 * Compute time until virtual deadline
+	 */
+	vdelta = se->deadline - se->vruntime;
+	if ((s64)vdelta < 0) {
+		if (task_current_donor(rq, p))
+			resched_curr(rq);
+		return;
+	}
+	delta = (se->load.weight * vdelta) / NICE_0_LOAD;
+
+	/*
+	 * Correct for instantaneous load of other classes.
+	 */
+	util += cpu_util_dl(rq);
+	util += cpu_util_rt(rq);
+	util += cpu_util_irq(rq);
+	if (util && util < 1024) {
+		scale *= 1024;
+		scale /= (1024 - util);
 	}
+
+	hrtick_start(rq, (scale * delta) / 1024);
 }
 
 /*



