Return-Path: <linux-kernel+bounces-886744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B3448C36561
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5FDF734EF4A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D88332ECF;
	Wed,  5 Nov 2025 15:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="jUpOxv5H"
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97FF332EA8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.28.197.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356388; cv=none; b=SDWgAmpfUIUHxzDUzpo33Nd0sL1ztasd7a98PQKnGXzbeYVbphFrUgCwwE5h4ARYsdUmx5BYJSDkqCfldXFnm00lMdl6rSs9iEbccru8ctgPuX6m/7XSody5peUbB9xRKWtn7T/JP3DVO5LooZQqyDmuPvAhO1UhtKy2shtv1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356388; c=relaxed/simple;
	bh=SSQ7q/QVWOhMCqpgLPKrZUWF3IclLZF5T6er0kRCaAw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HnrkNkg5FFaUUf0McTjLic6LMpZmouNdHlB6EOZ2tCY1cUAGqvR8hL3wd6jgItA9NL3a6ljTjo8v4+qMaNmD/3GbpyyMDj8c0wh7B789pKdrPLFK3Js8GW5Un0txa4iiRzAMeFrrFhCH+dtoCZdzCDu5oyCIIWV6thRYtoefRlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=jUpOxv5H; arc=none smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1762356387; x=1793892387;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xkbNmLVUT1dr514xflNSoO0g3w/dEBmsveNAP0bT4u0=;
  b=jUpOxv5Hr7to7G4ueIXY5ui9TfCeAzQlW3X0mjtZ1p6AUcX8iL27+LYs
   g2gi6yXz4u18qjjL0T8lta8pkhJDBBOx5FIrgI/MJB1VP26IWK2Hn3+Go
   2yycruyklAp7UeTu1jCuMW4kscCXqdkm/Nfq2RYoRCw/xPpeeB1iWRarX
   mqCdCizWjMrpK7tmbEKK9ywpXXtm46CU4qqWaRwllz6mupz4qbl0xn1tP
   ljkJyzzty+cZA6bxMvDdombsZvA95M0yD0fAzTspH+EFrgQWjs6di7jep
   fOFCOrsvBoG4AWy2mVZicDoUuGc0MbOfhrx6sS6UE2+ePOB/aAoZmqUTD
   g==;
X-CSE-ConnectionGUID: 8oqogEt5TvOBDtmyKHXB+A==
X-CSE-MsgGUID: rhlpQdHxSTK1bEi/8kqXnQ==
X-IronPort-AV: E=Sophos;i="6.19,282,1754956800"; 
   d="scan'208";a="4618646"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 15:26:06 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:6235]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.3.67:2525] with esmtp (Farcaster)
 id fd38830e-8cbe-47e2-a4e8-8e3521145a32; Wed, 5 Nov 2025 15:26:06 +0000 (UTC)
X-Farcaster-Flow-ID: fd38830e-8cbe-47e2-a4e8-8e3521145a32
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 5 Nov 2025 15:26:06 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.223) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 5 Nov 2025 15:25:59 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <kprateek.nayak@amd.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>,
	<linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <dwmw@amazon.co.uk>,
	<jschoenh@amazon.de>, <liuyuxua@amazon.com>
Subject: [PATCH] sched: Optimize core cookie matching check
Date: Wed, 5 Nov 2025 17:25:37 +0200
Message-ID: <20251105152538.470586-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Early return true if the core cookie matches. This avoids the SMT mask
loop to check for an idle core, which might be more expensive on wide
platforms.

Signed-off-by: Fernand Sieber <sieberf@amazon.com>
---
 kernel/sched/sched.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index adfb6e3409d7..381cd561e99b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1432,6 +1432,9 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
 	if (!sched_core_enabled(rq))
 		return true;
 
+	if (rq->core->core_cookie == p->core_cookie)
+		return true;
+
 	for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
 		if (!available_idle_cpu(cpu)) {
 			idle_core = false;
@@ -1443,7 +1446,7 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
 	 * A CPU in an idle core is always the best choice for tasks with
 	 * cookies.
 	 */
-	return idle_core || rq->core->core_cookie == p->core_cookie;
+	return idle_core;
 }
 
 static inline bool sched_group_cookie_match(struct rq *rq,
-- 
2.43.0




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


