Return-Path: <linux-kernel+bounces-886025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD3CC3489B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3BC467F88
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB742D8DD0;
	Wed,  5 Nov 2025 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="THc8Rkoe"
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7B92D8DA4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.153.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332264; cv=none; b=D1u0qT7aVsxWo0ReGF+AiWIHQATMXTLs5cqLeubXIZQh2+so4YHMPFL/ZGdeV5TbSJjHIM9YuQ+uwhsnpUAlEae1lNyr/6X2t8NaGZ4tNzzO0Pphy2flXpePnjg8qbRK0VgFdaXb1exa7HO7ReIAWw+Ea+evsCfXEP7ETDDHiu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332264; c=relaxed/simple;
	bh=ApELpbZUQySCYHgG/SY1HXXRiPlespAoItf9AGXPzNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFiHLhiMHk8bDcEjy696NPgIs5woz2h2Iooadi3myVZvCqO9yIu9z6dalyS/jAG0Nh/Zun4dR8ySSXwag0gL/rwiqKlkT4Js+iwii/Gge9Aq/WzZbrFOugJ8xrGj2Dtvqg4/u73xIp48uDlVii/UEHhHiy/esD+EcKpfVcLhm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=THc8Rkoe; arc=none smtp.client-ip=18.158.153.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1762332263; x=1793868263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OETOZaEKELLo2yX31GL8gno5Xhyn+WEg6KkFHfb4Yns=;
  b=THc8RkoeiuJMZgesgNvG9svqbdb7x3efvAfVUzltQ1Vd6Wc7FU41WEcP
   ZfCTjTKeVM8sHl3XaVRzx+QULA8UOvTp8JGcd9yzmls2+QJUQJ3vvlZQp
   K6r/Gh8bYbMaDjKT/VM4XsntFO7KTynjhiSLOBuea0hYKRG2akm52/E/W
   0mrW1Wr7aaBBOsacIS1wC8TxCr7AASoq3Nt+lq6KBqHz577M0bkGjFT8J
   BgeHbJCKgIbW46xvzsBJvFcjPbns5h6J82Z3Bw/yMffSt/jqW6nCNnLjz
   jzwgLkYcSBr4u3eZDLKyM5NBbX5gW5/5w6H45Ryg0ZxcXwihYVIhMrNEA
   Q==;
X-CSE-ConnectionGUID: u5r0VUocRai4fanS9l/zWw==
X-CSE-MsgGUID: OOBmpqnESMSAkQm4+vEnvw==
X-IronPort-AV: E=Sophos;i="6.19,281,1754956800"; 
   d="scan'208";a="4579819"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 08:43:56 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:15557]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.28.253:2525] with esmtp (Farcaster)
 id dd7f7493-43e4-439f-ac89-48832ad343c0; Wed, 5 Nov 2025 08:43:56 +0000 (UTC)
X-Farcaster-Flow-ID: dd7f7493-43e4-439f-ac89-48832ad343c0
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 5 Nov 2025 08:43:55 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.109) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 5 Nov 2025 08:43:51 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: kernel test robot <oliver.sang@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4: BUG:kernel_NULL_pointer_dereference,address
Date: Wed, 5 Nov 2025 10:43:33 +0200
Message-ID: <20251105084335.121098-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104210456.652800-1-sieberf@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Peter,

I have done more code analysis and I think the following code is a better 
approach to handle proxy tasks:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 00f9d6c05d4cf..65eb98a779f91 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8983,9 +8983,10 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
  */
 static void yield_task_fair(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
-	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
-	struct sched_entity *se = &curr->se;
+	struct task_struct *rq_curr = rq->curr;
+	struct cfs_rq *cfs_rq = task_cfs_rq(rq_curr);
+	struct sched_entity *se = &rq_curr->se;
+	bool curr = cfs_rq->curr == se;
 
 	/*
 	 * Are we the only task in the tree?
@@ -9016,8 +9017,12 @@ static void yield_task_fair(struct rq *rq)
 	 * ends up quickly running away.
 	 */
 	if (entity_eligible(cfs_rq, se)) {
+		if (!curr)
+			__dequeue_entity(cfs_rq, se);
 		se->vruntime = se->deadline;
 		se->deadline += calc_delta_fair(se->slice, se);
+		if (!curr)
+			__enqueue_entity(cfs_rq, se);
 		update_min_vruntime(cfs_rq);
 	}
 }

I'll prepare rev4 of the patch accordingly.

--Fernand



Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


