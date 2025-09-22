Return-Path: <linux-kernel+bounces-827206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A537B9126C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031C216AE52
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FCB308F01;
	Mon, 22 Sep 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PO8kMW9h"
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E733074BD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.199.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544820; cv=none; b=mkQaMn1fcx3reCsRh2hVQTVKcfImho3De1UtNxOqoWHYZ74M/k9kUwkHdpjgvFIIVTn6KxCuCC2G56fmyr94tI/IcaQD1u6s4yKVfuY9de3tX/bmauyxYNUtBtIrtlBdnTxIeqsV3L3JyvDsnMx8XZE65AMNpo1J10rY8wLMhqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544820; c=relaxed/simple;
	bh=39eC2m8LomvJUbPd0x6YvKOxV7n7FU1/dvMN0kt6RNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJG150hHFaYy6eFFpwcw7SbeCU7rQwPhvkZN9fJHXVJ1BL3iaXbLW28oleToPbcv1lybqOD6focb9261CjmeOj0qCLqY9H1BvGfgtsiIsuZDG6GP/qKGjoMiY2AddRPEX1e1gWwO/5WJXlrqb0/U4kLVoAx8fMht2D2bERZmCqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PO8kMW9h; arc=none smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758544819; x=1790080819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RLJmOk9CHgieXzTT5gl1bkuWDqTXwImg9yrbL4Lw1WA=;
  b=PO8kMW9h3oJIzabrZ532mY0eM/10WfJ6MmNBtgjuW5IlkCeVHBeFB9Pe
   AslUMV8/7BdDp23M4LXOi/WIVBGTxFF0qVbeINYlZNl+zxLazuEnsjeYb
   oZKY4hEYnBDO6lovLPfRhycZRIulPixF0f0v43akRXNW+DPsyIorkuAzc
   7GdeLvApk745bbDLeFSZC6vXGYvZz2QJ7abS4Y6QDtaQNj2SNv1/CYUHY
   SnwiTxz6LMIOdisspGGXbM5GDd9zlThtryPybzImGJgLXRN0OQUp61gg1
   wEjSlHV6FrO+om2i9dcoway5mdzt7IAA4no8PTjXycF7FfUqUGGfPXhDz
   w==;
X-CSE-ConnectionGUID: KcywKFZBQuCrVC8ld1TY5g==
X-CSE-MsgGUID: 1SnE9fZpTF+uR5e8YD2SpQ==
X-IronPort-AV: E=Sophos;i="6.18,285,1751241600"; 
   d="scan'208";a="2379604"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 12:40:08 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:31291]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.33.43:2525] with esmtp (Farcaster)
 id cc76c455-72b7-44b5-8a43-38c608c38c7a; Mon, 22 Sep 2025 12:40:08 +0000 (UTC)
X-Farcaster-Flow-ID: cc76c455-72b7-44b5-8a43-38c608c38c7a
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 12:40:06 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.222) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 12:40:00 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <mingo@redhat.com>, <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <dwmw@amazon.co.uk>,
	<jschoenh@amazon.de>, <liuyuxua@amazon.com>
Subject: [PATCH 1/4] sched/fair: Fix cookie check on __select_idle_cpu()
Date: Mon, 22 Sep 2025 14:39:22 +0200
Message-ID: <64ca6d7f73625cc63fa0bc1800c9b199462a5ef3.1758543008.git.sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758543008.git.sieberf@amazon.com>
References: <cover.1758543008.git.sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The __select_idle_cpu() function uses sched_cpu_cookie_match() to determine
if a task can be placed on an idle CPU. This function incorrectly returns
false when the whole core is idle but the task has a cookie, preventing
proper task placement.

Replace sched_cpu_cookie_match() with sched_core_cookie_match() which
correctly handles the idle core case. Refactor select_idle_smt() to avoid
duplicate work by checking core cookie compatibility only once in the SMT
mask.

Fixes: 97886d9dcd868 ("sched: Migration changes for core scheduling")
Signed-off-by: Fernand Sieber <sieberf@amazon.com>
---
 kernel/sched/fair.c  |  5 ++++-
 kernel/sched/sched.h | 14 --------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..43ddfc25af99 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7447,7 +7447,7 @@ static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct tas
 static inline int __select_idle_cpu(int cpu, struct task_struct *p)
 {
 	if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
-	    sched_cpu_cookie_match(cpu_rq(cpu), p))
+	    sched_core_cookie_match(cpu_rq(cpu), p))
 		return cpu;
 
 	return -1;
@@ -7546,6 +7546,9 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 {
 	int cpu;
 
+	if (!sched_core_cookie_match(cpu_rq(target), p))
+		return -1;
+
 	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
 		if (cpu == target)
 			continue;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f7..4e7080123a4c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1386,15 +1386,6 @@ extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_f
  * A special case is that the task's cookie always matches with CPU's core
  * cookie if the CPU is in an idle core.
  */
-static inline bool sched_cpu_cookie_match(struct rq *rq, struct task_struct *p)
-{
-	/* Ignore cookie match if core scheduler is not enabled on the CPU. */
-	if (!sched_core_enabled(rq))
-		return true;
-
-	return rq->core->core_cookie == p->core_cookie;
-}
-
 static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
 {
 	bool idle_core = true;
@@ -1468,11 +1459,6 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
-static inline bool sched_cpu_cookie_match(struct rq *rq, struct task_struct *p)
-{
-	return true;
-}
-
 static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
 {
 	return true;
-- 
2.43.0




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


