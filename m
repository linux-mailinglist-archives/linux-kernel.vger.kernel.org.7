Return-Path: <linux-kernel+bounces-723226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D8AFE4A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94A71BC56F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24732877FD;
	Wed,  9 Jul 2025 09:54:53 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6807239E9B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054893; cv=none; b=LGW4tTKmoOkYGKiq0Ni7zyvb40lAtM7nFQdwkf2UyRo3LteQRLYGE5K1vFX2p9RgjUKwdEI+mF0M8ZYkc1puDQOGtW7cI/F1SgbUdls/6Ai3h5z5CtArRHl2TrPtTE/26FxKblNhUJc3F1To07XPTKwfy+SQS/gnh7/ufa83fyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054893; c=relaxed/simple;
	bh=xuPuYBZ+KRg7XrT2/jK4jMxIrNtVMPFzgki/el8xaOU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A6zWjv15Lu4ApZ7sFVpTjtc6dNpNbaoTFU4lmS9yZWLFsTefIntmPjvdY7ou/H2d8VT3VYcqrK6rlZCT9zJQOGvmKwZYmnf60B2ss0TefQ7R5OE4mTH5iBxAQm9RVw/yj039EXuNYyB+YWQ0PgMPxc5hhFI5fwkmebcZcwkQZxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bcYB45HHvzWg1h;
	Wed,  9 Jul 2025 17:50:20 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 86842140203;
	Wed,  9 Jul 2025 17:54:46 +0800 (CST)
Received: from kwepemq100012.china.huawei.com (7.202.195.195) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 17:54:46 +0800
Received: from huawei.com (10.67.175.84) by kwepemq100012.china.huawei.com
 (7.202.195.195) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 9 Jul
 2025 17:54:45 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH] sched/fair: Fix overflow in vruntime_eligible() causing NULL return
Date: Wed, 9 Jul 2025 09:38:29 +0000
Message-ID: <20250709093829.3213647-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq100012.china.huawei.com (7.202.195.195)

In the vruntime_eligible() function, the original comparison:
	return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
could produce incorrect results due to integer overflow in the 'avg' or
s64 part.

This overflow causes the comparison to return false even when the
mathematical result should be true, leading all tasks to be falsely
deemed ineligible. Consequently, pick_eevdf() returns NULL, triggering a
kernel crash.

The best approach should be to dig deep into why overflow occurs, which
attributes lead to the overflow, whether it is normal, and how to avoid
it. Not pretty sure if this part of the modification will introduce new
issues, but it may be incorrect to simply spot a potentially
overflowing integer type and directly use the >= sign for comparison.
Therefore, drawing on the enqueue method in the rb tree, to avoid the
impact of overflow, the method of first performing subtraction and then
comparing with 0 is also adopted.

The following are the relevant attributes that cause the return of NULL:
crash> struct cfs_rq.avg_vruntime,avg_load,min_vruntime
ffff9ea77ecb4280
  avg_vruntime = -4392414779907141680,
  avg_load = 28644,
  min_vruntime = 239776551994501,

sched_entity: curr
crash> struct sched_entity.deadline,min_vruntime,vruntime,load,vlag
0xffff9ea74510d800
  deadline = 86432035728535,
  min_vruntime = 86431486021988,
  vruntime = 86431531134184,
  load = {
    weight = 6066,
    inv_weight = 0
  },
  vlag = 86431823023195,

the sched_entity mapping to the root node in the cfs_rq
crash> struct sched_entity.deadline,min_vruntime,vruntime,load,vlag -l
sched_entity.run_node 0xffff9ea849fbc350
  deadline = 18446615868453340281,
  min_vruntime = 18446615868452621390,
  vruntime = 18446615868453018539,
  load = {
    weight = 9777152,
    inv_weight = 449829
  },
  vlag = -5599,

the sched_entity mapping to the leftmost node in the csf_rq, also the
left child of root node.
crash> struct sched_entity.deadline,min_vruntime,vruntime,load,vlag -l
sched_entity.run_node 0xffff9ea78d0280d0
  deadline = 18446615868452943132,
  min_vruntime = 18446615868452621390,
  vruntime = 18446615868452621390,
  load = {
    weight = 9777152,
    inv_weight = 449829
  },
  vlag = 444143,

the sched_entity mapping to the rightmost node in the csf_rq, also the
right child of root node.
crash> struct sched_entity.deadline,min_vruntime,vruntime,load,vlag -l
sched_entity.run_node 0xffff9ea783144350
  deadline = 515705106937888,
  min_vruntime = 515705106616146,
  vruntime = 515705106616146,
  load = {
    weight = 9777152,
    inv_weight = 449829
  },
  vlag = -260493,

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a14da5396fb..bfa4090cef93 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -734,7 +734,7 @@ static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 vruntime)
 		load += weight;
 	}
 
-	return avg >= (s64)(vruntime - cfs_rq->min_vruntime) * load;
+	return avg - (s64)(vruntime - cfs_rq->min_vruntime) * load >= 0;
 }
 
 int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
-- 
2.34.1


