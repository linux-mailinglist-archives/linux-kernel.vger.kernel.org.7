Return-Path: <linux-kernel+bounces-758603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C1AB1D147
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69AD04E00E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2E91D63DF;
	Thu,  7 Aug 2025 03:41:14 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B3186A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 03:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754538073; cv=none; b=HxF0buRf3iX3Qam4jTRt1COQUZ/9MV+pMSytD2AJKCPgBlWxL+si+PgAkfvKvl1EzXj2RqhIMdZ5ZWwAyf1JaXTw4JFvZK3ydYeYDD3FaIijT6HMTmo6LyoitaLWmcevnW0iv2VXOgC4ggfvqY2/5P8K+pObbDKcCxYGGy4i8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754538073; c=relaxed/simple;
	bh=L6KxEvG5lOVP433M86bmaTj0Hl38+7lXdnO528Lf2Xs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tfNhXFvis5FoMBMgHOLBGLUrfnkc4WHIsLYLPKTUVMpHQL58aSI71CFN532Zu2v8GRdWgh4LlhJc3qcTBXjl4v3jxxZyRg6XPQ5J4g/exG/YXE3MaGdLc627BOUyOz8J6FchocUCTtuQ6o+mceBSg7ySpkROwFDtAlC1XScFsd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <linux-kernel@vger.kernel.org>
CC: <vschneid@redhat.com>, <mgorman@suse.de>, <bsegall@google.com>,
	<rostedt@goodmis.org>, <dietmar.eggemann@arm.com>,
	<vincent.guittot@linaro.org>, <juri.lelli@redhat.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, Fushuai Wang
	<wangfushuai@baidu.com>
Subject: [PATCH] sched: remove unnecessary check in sched_{debug_}start()
Date: Thu, 7 Aug 2025 11:40:16 +0800
Message-ID: <20250807034016.43446-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc4.internal.baidu.com (172.31.3.14) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

-1 is a legal argument for cpumask_next(), and cpumask_next(-1, mask) is
equivalent to cpumask_first(mask). The explicit check and separate branch
are unnecessary.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 kernel/sched/debug.c | 5 +----
 kernel/sched/stats.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3f06ab84d53f..1b3592bac62b 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1080,10 +1080,7 @@ static void *sched_debug_start(struct seq_file *file, loff_t *offset)
 
 	n--;
 
-	if (n > 0)
-		n = cpumask_next(n - 1, cpu_online_mask);
-	else
-		n = cpumask_first(cpu_online_mask);
+	n = cpumask_next(n - 1, cpu_online_mask);
 
 	*offset = n + 1;
 
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index d1c9429a4ac5..f93b1c87c538 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -181,10 +181,7 @@ static void *schedstat_start(struct seq_file *file, loff_t *offset)
 
 	n--;
 
-	if (n > 0)
-		n = cpumask_next(n - 1, cpu_online_mask);
-	else
-		n = cpumask_first(cpu_online_mask);
+	n = cpumask_next(n - 1, cpu_online_mask);
 
 	*offset = n + 1;
 
-- 
2.36.1


