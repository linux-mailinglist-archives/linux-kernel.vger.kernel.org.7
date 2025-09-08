Return-Path: <linux-kernel+bounces-805107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2FDB48415
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4F17A24F7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 06:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85FC224AF0;
	Mon,  8 Sep 2025 06:24:08 +0000 (UTC)
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E444A21
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312648; cv=none; b=jHQXP2BTkROVTqwWOTI7vLtUZtcl4L0uqBDMfjqEfb3HdzAjzWoOwDWCJukAhKxtd70sN2ZI0eORx0MtGEJKu4YMI7O+IeUTXzMao0omn3Cqn63DXq76ra3CJaPu/GFzjJiuV5aanR+h/lro6ucdx3ECQ7qP0T9ycwJwul4ThiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312648; c=relaxed/simple;
	bh=2CsGKd+uS1XuJkWBhCZWelSANVTQcTDnvxcj7hQzP1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U/X37hBShx3/zzDNhVpkZdSCzVc7rKElj93pUHckA2NIKzC02zNiC9bY9QmQEXS0Q93p/DCFy2HuO2XBsJ3lgJIjbObPNQGhx4Nd7YW+rEjj7K0zevc5sobxismoG+rTk06SdgljFeVZIhaboXD0kLZcvAIdiBfaoDTuZjc4Jrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4cKxjP55m3z55pFD;
	Mon,  8 Sep 2025 14:23:37 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4cKxjL5vDfz55pFD;
	Mon,  8 Sep 2025 14:23:34 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 71C36597C;
	Mon,  8 Sep 2025 14:23:32 +0800 (CST)
Received: from jianyong.hygon.cn (172.19.22.175) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 8 Sep
 2025 14:23:34 +0800
From: Jianyong Wu <wujianyong@hygon.cn>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<riel@surriel.com>, <vincent.guittot@linaro.org>, <jianyong.wu@outlook.com>,
	<wujianyong@hygon.cn>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/fair: Correct misleading comment in task_numa_migrate()
Date: Mon, 8 Sep 2025 14:19:23 +0800
Message-ID: <20250908061923.543081-1-wujianyong@hygon.cn>
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

The current comment implies that both the task and the group must get
benefit for a node to be considered. However, the actual code allows
a node to pass if *either* the task *or* the group meets the criteria.

As established in the previous discussion [1], the code logic is correct.
Update the comment to accurately reflect that either condition is
sufficient.

Signed-off-by: Jianyong Wu <wujianyong@hygon.cn>

[1] Link: https://lore.kernel.org/lkml/55806A24.7030403@redhat.com/
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..9069ea4c71f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2565,7 +2565,7 @@ static int task_numa_migrate(struct task_struct *p)
 				groupweight = group_weight(p, env.src_nid, dist);
 			}
 
-			/* Only consider nodes where both task and groups benefit */
+			/* Consider nodes where either task or groups benefit */
 			taskimp = task_weight(p, nid, dist) - taskweight;
 			groupimp = group_weight(p, nid, dist) - groupweight;
 			if (taskimp < 0 && groupimp < 0)
-- 
2.43.0



