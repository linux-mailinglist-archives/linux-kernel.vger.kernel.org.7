Return-Path: <linux-kernel+bounces-827207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB2FB91278
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E80E189E701
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDFD308F27;
	Mon, 22 Sep 2025 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="CmqLbo2f"
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF403308F08
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544827; cv=none; b=k6MVEXEgs5twX94wXD1z/8RiQ2KU+5JS+iNCdOEMPrXkk28C0Mj6E2tLJ4XOMRHArhl8G4MokGlS2FHprrz55yJLVnwI/qIrYOoXi1WzECCnu8a6NrRZfbdoN48wVXdZEToHLO2sFdVLCZoWcfuqdiHqW8LA7VOKI6gt0uKeMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544827; c=relaxed/simple;
	bh=/lGoL1yFTeaAJo+p/08Px2KgHWPnnxEGStFVGbqonfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n31Ele5gGMY3bw6Zn3C8lH6VeywaEgJGeoQp5BKtSzhar4swYloTDWbhH/699pMT7Goi4D+/S8yaR/stXYil9GMwe5+kn/nbPNC+QkIFoYwzjOW1DGAbxh9HyU/8MZJnvY5ch7MFCR1OQeRJhh3f5LQm/XnviNTvLaT5u0CjLk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=CmqLbo2f; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758544826; x=1790080826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=onGsTLIeK7VNe4TI9Csjky6vfaTM2IQytblGmkdw2ww=;
  b=CmqLbo2fgvzSkW8UzK+NFkkOr82HMeAZxA1O7/b25WNx7U59XgeBm8IR
   zXxPM0EJ+neZ/802OzybLj1qci1rNggy28FrbzeOcz+K/S44yfZ2L8QMl
   2T5k/MdIH/S3quc3StOlwGbn4Y3H0/lttI9KFf9yyJR8mdBpxTYValeOM
   l67a9CRBLRMZXh10pAAxwH0KJ2RO1cAu7VupUehPSrxBOENFHZOjpanBF
   gytlThpOd/nQwzBj2cTR/8U5dffO+FF6HdZ5LZ3HGkfNp/h+Jo3U5dGoh
   wq7ZrPD9zGPMT1d66vZtbX3c81fGm6uJb+QCnC49OianarzK71yMovEVj
   Q==;
X-CSE-ConnectionGUID: ZkHR7wrxSZ6nVcaAuxVzyA==
X-CSE-MsgGUID: wlrGUOg+RayN14vjkVhcQw==
X-IronPort-AV: E=Sophos;i="6.18,285,1751241600"; 
   d="scan'208";a="2483909"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 12:40:14 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:2157]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.38.97:2525] with esmtp (Farcaster)
 id cd3a0e7f-5359-42d6-9b31-8ff496d17386; Mon, 22 Sep 2025 12:40:14 +0000 (UTC)
X-Farcaster-Flow-ID: cd3a0e7f-5359-42d6-9b31-8ff496d17386
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 12:40:14 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.222) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 12:40:07 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <mingo@redhat.com>, <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <dwmw@amazon.co.uk>,
	<jschoenh@amazon.de>, <liuyuxua@amazon.com>
Subject: [PATCH 2/4] sched/fair: Still look for the idlest cpu with no matching cookie
Date: Mon, 22 Sep 2025 14:39:23 +0200
Message-ID: <beefbc1474a94868c22b0351dedc0d7398b79c33.1758543008.git.sieberf@amazon.com>
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

The slow path for waking tasks currently discards all potential targets
when no cookie-matching CPU is found, leading to suboptimal task placement.

Fall back to selecting the idlest CPU when no cookie-matching target is
available, ensuring better CPU utilization while maintaining the preference
for cookie-compatible placements.

Signed-off-by: Fernand Sieber <sieberf@amazon.com>
---
 kernel/sched/fair.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 43ddfc25af99..67746899809e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7335,7 +7335,8 @@ sched_balance_find_dst_group(struct sched_domain *sd, struct task_struct *p, int
  * sched_balance_find_dst_group_cpu - find the idlest CPU among the CPUs in the group.
  */
 static int
-sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
+__sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *p,
+				   int this_cpu, bool cookie_match)
 {
 	unsigned long load, min_load = ULONG_MAX;
 	unsigned int min_exit_latency = UINT_MAX;
@@ -7352,7 +7353,8 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
 		struct rq *rq = cpu_rq(i);
 
-		if (!sched_core_cookie_match(rq, p))
+		/* Only matching tasks if cookie_match, else only unmatching tasks */
+		if (cookie_match ^ sched_core_cookie_match(rq, p))
 			continue;
 
 		if (sched_idle_cpu(i))
@@ -7391,6 +7393,17 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 	return shallowest_idle_cpu != -1 ? shallowest_idle_cpu : least_loaded_cpu;
 }
 
+/*
+ * sched_balance_find_dst_group_cpu - find the idlest CPU among the CPUs in the group.
+ */
+static inline int
+sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *p, int this_cpu)
+{
+	int cpu = __sched_balance_find_dst_group_cpu(group, p, this_cpu, true);
+
+	return cpu >= 0 ? cpu : __sched_balance_find_dst_group_cpu(group, p, this_cpu, false);
+}
+
 static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct task_struct *p,
 				  int cpu, int prev_cpu, int sd_flag)
 {
-- 
2.43.0




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


