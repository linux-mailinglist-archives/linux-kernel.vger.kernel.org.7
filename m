Return-Path: <linux-kernel+bounces-899365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEE1C577E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C494D4E2BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631A634FF67;
	Thu, 13 Nov 2025 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="OU/cg4z0"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087B2FE58F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038494; cv=none; b=FXC2d90RD20/QfkbHKSIgkhL2fhX5DYYs3HkBwed1utKAeToS5MX2gTrUhdBJ3Q9faCycvn4rxDBOYKiy4ukeb6SrmoxvfFJ8sCIegYX8FfJO+IDNk3LMXQ2AtfcNTU0u9vARIOjRHI0Vo92noyjBCsev22WSa1HAX8uS2Nwvp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038494; c=relaxed/simple;
	bh=inMuMW2OtqRUfQ7VZG+edIgj9nDRzVyBr+EwN2nBIrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=prLWCCuMvGAHMYHDc7Vv2qgE7LqpCgtIgcLHMGIsayQRi1n7G0mY/zoCsmwwC6aaVN08IMJOEVwbNL9mETozDhv9nTbF1ny48VlyF00vqC7qfrxFSVbnhh/5MmjBilKHJiG9wVkmxa5nleESSaNRlm3UaZBACXx1A9jXZ05QSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=OU/cg4z0; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ra
	Fevk6H2Bk/ffRHdozuP35Zfc9D2yMlTPJd1mpdixc=; b=OU/cg4z0ZeD7I4wjiY
	e0fQTLA5vL7zFLBFEZnvRs0c0nc+/Vdf/o2pgpnOzr0yfBlzC7AICZoIPYVtJWH2
	CQBt6/bEj+FI/be53lkhkw1lcoIzu25FKXYm5cXdvxCcSQWqVN1JbKJXLDJP61fV
	XY5rrsTRRnl21vOPlX0MXoX+c=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgCnT8Fv0hVpD537BQ--.46139S2;
	Thu, 13 Nov 2025 20:43:28 +0800 (CST)
From: Honglei Wang <jameshongleiwang@126.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched/stats: correct the wait_start calculation logic
Date: Thu, 13 Nov 2025 20:43:26 +0800
Message-Id: <20251113124326.27588-1-jameshongleiwang@126.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgCnT8Fv0hVpD537BQ--.46139S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFWDtFy5Gw47try5CF4Durg_yoWfGrb_ta
	yYvF1jkryUKrZxtFyrWw4xX3sYyw4DtF1DAa4DAF4UAFy5Jr98Jas8WF15XrnFgrsagF9r
	GrsxXFWkKFnFvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUBMNUUUUUU==
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbirxgFrWkV0akMfwAAso

It's not necessary to do the delta-related subtraction if the task
is not on rq migrating. Add the migrating related judgment back.

Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
---
 kernel/sched/stats.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index d1c9429a4ac5..60560fb31e63 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -12,7 +12,8 @@ void __update_stats_wait_start(struct rq *rq, struct task_struct *p,
 	wait_start = rq_clock(rq);
 	prev_wait_start = schedstat_val(stats->wait_start);
 
-	if (p && likely(wait_start > prev_wait_start))
+	if (p && task_on_rq_migrating(p) &&
+	    likely(wait_start > prev_wait_start))
 		wait_start -= prev_wait_start;
 
 	__schedstat_set(stats->wait_start, wait_start);
-- 
2.33.0


