Return-Path: <linux-kernel+bounces-791421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAC6B3B696
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669EC7C096A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794482E228D;
	Fri, 29 Aug 2025 09:01:52 +0000 (UTC)
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A6C264A60
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458112; cv=none; b=KLUhudIsMeGRmgT6Gc/GRXpBdW3BKCymLCXAhJDrjRtrmESg2Tb/TgR/Ho5g45sdIMYUGq2gL7/7cT8VWrTWjrldKxcRWFYjk/JU+T2+7XGCd7XRSQQXS+iLHH2PFeQ/yjSDg9xdQeXdlpA/0fLcWXz2KMMVRuMd1fKxZOq6aFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458112; c=relaxed/simple;
	bh=tsN0Gjb2FB8ir57daA8GWR6Jz5giPbprLb7jYQkC4dQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WbEAcpyY66ChXe5TlT23t21keUIxh5jWAgXmMnzOkWDbYVbXWEsQNurxr4Raqz0DXsm8frpRuv8Zlta6chgt78fn29ZcFhlWeThN+mlszEmabhK9QnGkHdgV/Tcx7qAbXs6OAe8PmWAaGhi7IZtdRpX8u8tSQ001J3F0/hVK4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4cCsh95fQbz1YQpnK;
	Fri, 29 Aug 2025 17:01:29 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4cCsh92Ldrz1YQpnK;
	Fri, 29 Aug 2025 17:01:29 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 3D5861659;
	Fri, 29 Aug 2025 17:01:20 +0800 (CST)
Received: from jianyong.hygon.cn (172.19.22.175) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Fri, 29 Aug
 2025 17:01:27 +0800
From: Jianyong Wu <wujianyong@hygon.cn>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <wujianyong@hygon.cn>
CC: <jianyong.wu@outlook.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/fair: fix task_numa_migrate to consider both task and group benefits
Date: Fri, 29 Aug 2025 16:57:17 +0800
Message-ID: <20250829085717.15737-1-wujianyong@hygon.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
 (172.23.18.114)

The comment indicates that when searching for a suitable NUMA node, we
should ensure that the selected node benefits both the task and its NUMA
group. However, the current implementation can only guarantee that either
the task or the group benefits, but not necessarily both.

Signed-off-by: Jianyong Wu <wujianyong@hygon.cn>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..58c899738399 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2568,7 +2568,7 @@ static int task_numa_migrate(struct task_struct *p)
 			/* Only consider nodes where both task and groups benefit */
 			taskimp = task_weight(p, nid, dist) - taskweight;
 			groupimp = group_weight(p, nid, dist) - groupweight;
-			if (taskimp < 0 && groupimp < 0)
+			if (taskimp < 0 || groupimp < 0)
 				continue;
 
 			env.dist = dist;
-- 
2.43.0



