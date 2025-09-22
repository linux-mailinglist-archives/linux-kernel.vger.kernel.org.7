Return-Path: <linux-kernel+bounces-827209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C01B91287
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55AF3B859C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3461308F27;
	Mon, 22 Sep 2025 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YSucknLi"
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.176.194.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70166308F1A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.176.194.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544871; cv=none; b=lO/bhpw0hGbbl9bxEqk8ACeYLTHEwNziL024wf9Bq++KkFlVuyjJ6u8bleRrygg6TyV3jptEm+MihpUuzHmLwogMtVCD4zyxnQ3LWnT7yJlTJw5CyqDzJK7E0LdQuh5WISI0TTkc5UBgGHC/SvaHCKCf/UFaIdBhuTh6AE8hiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544871; c=relaxed/simple;
	bh=9k4asiHFcCuAOaOpFe1BOMBARruZk7/0jebnh+l4Mw0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PWX787qP314+wZvvK9mqU891LCfOn9CTOONr4hfZKWn8fXCqczNFXMgiteQp1y3pFeVevSO/ygNRi4WoHSKVkxs1OyxQvXUB1dDg/RMXsmgnq9RetizI/zc8MH/51AteucfNa0VTQChauxxCd3NfUS3sbxk6KD1m5xJvlJ673sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YSucknLi; arc=none smtp.client-ip=63.176.194.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758544868; x=1790080868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ZftVsvw9ECNftLFUV1PeW6Cl8JH9hXM5u/v1PG+AFI=;
  b=YSucknLicgKroa51JxxXb7WWkq7kOrQKfD12H4Q2r9Ewf2gKJ87/UwlS
   GAusd/cYTfcVcIUnO1Hvh3gwdiDXUh7/x/U+dvdliorWqNApp4jDDKMft
   jyuHPyT7erspZDPH72XXmLaP0Lzx8LdgyR2/0RO2OnR8re/y2AFGfqwFf
   EGSYTkA59UID8Ja59yf0sLOIAssnm2N7ZTZEkuFGUnidLcwCpoToI31VY
   CBtrQ4+tdowXZfj1AdKkEDZAbccqtP/7B16/KtZB5SP1Ec5EZrGPTuhdq
   3v42+Z8lLmgyRFFQX+PVr+NAangfxyOVWmyLH2DOsnotPdOvUu/Qgg+OD
   A==;
X-CSE-ConnectionGUID: tnYAuXy4S3yXcpkkX6a9eg==
X-CSE-MsgGUID: GXVDan9ASqufDS9Zzldorg==
X-IronPort-AV: E=Sophos;i="6.18,285,1751241600"; 
   d="scan'208";a="2484259"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 12:41:05 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:15731]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.23.230:2525] with esmtp (Farcaster)
 id 7e3dc8b9-c5d0-4925-9eb4-d7bf2020d9a6; Mon, 22 Sep 2025 12:41:05 +0000 (UTC)
X-Farcaster-Flow-ID: 7e3dc8b9-c5d0-4925-9eb4-d7bf2020d9a6
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 12:41:04 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.222) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 22 Sep 2025 12:40:57 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <mingo@redhat.com>, <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <dwmw@amazon.co.uk>,
	<jschoenh@amazon.de>, <liuyuxua@amazon.com>
Subject: [PATCH 4/4] sched/fair: Add more core cookie check in wake up fast path
Date: Mon, 22 Sep 2025 14:39:25 +0200
Message-ID: <a68bf0acdad9995fab15105cb26bd25f7d0edc8b.1758543008.git.sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758543008.git.sieberf@amazon.com>
References: <cover.1758543008.git.sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The fast path in select_idle_sibling() can place tasks on CPUs without
considering core scheduling constraints, potentially causing immediate
force idle when the sibling runs an incompatible task.

Add cookie compatibility checks before selecting a CPU in the fast path.
This prevents placing waking tasks on CPUs where the sibling is running
an incompatible task, reducing force idle occurrences.

Signed-off-by: Fernand Sieber <sieberf@amazon.com>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 78b36225a039..a9cbb0e9bb43 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7578,7 +7578,7 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 		 */
 		if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
 			continue;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+		if (__select_idle_cpu(cpu, p) != -1)
 			return cpu;
 	}
 
@@ -7771,7 +7771,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	lockdep_assert_irqs_disabled();
 
-	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
+	if ((__select_idle_cpu(target, p) != -1) &&
 	    asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
 
@@ -7779,7 +7779,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
 	if (prev != target && cpus_share_cache(prev, target) &&
-	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
+	    (__select_idle_cpu(prev, p) != -1) &&
 	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
 
 		if (!static_branch_unlikely(&sched_cluster_active) ||
@@ -7811,7 +7811,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
-	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
+	    (__select_idle_cpu(recent_used_cpu, p) != -1) &&
 	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
 
-- 
2.43.0




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


