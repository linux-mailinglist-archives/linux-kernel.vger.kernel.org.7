Return-Path: <linux-kernel+bounces-779834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F099EB2F988
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E32DE4E5F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858A23218AC;
	Thu, 21 Aug 2025 13:09:47 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C613A41F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781787; cv=none; b=s64YcemlZQvKHw4jrxSFY1h/MGd/mPuPaCbAk7tqC0vJgjoNwGI8EW/VV7djj2IyToJ1OhQcuTo/BfBQdp3N0rrDp0B/HQBOGOMh3nZlvSWCDpeB/Ok6m6zHhqj44N9u+FS/yb9DoXPYdQWMjK7++2Hz8HmMcKVydnG+sHkr7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781787; c=relaxed/simple;
	bh=eRKJxjY+hu42snqIEcrqCtyGtXKpWtzJWTzuArrTnPE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IFwD6p0NaeoSGPO+mNliDG4YckI+VBt2lqNIdJtbuYaENkMNrq1IGdQGddLTBjbVMrs+evLOtSIUy6211hTSmo2svW0BW9kJnFxJH5uEy/Bydp6BcxiIewqGuLik41b1KAB60Yk8zciHBwEctxdaAmfSlzoSfYcW7T+ts6nUOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c73T74K8Yz2CgDF;
	Thu, 21 Aug 2025 21:05:15 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id DCE4C1A0188;
	Thu, 21 Aug 2025 21:09:38 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 21 Aug
 2025 21:09:38 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>,
	<apanyaki@amazon.com>
Subject: [PATCH] mm/damon/core: prevent unnecessary overflow in damos_set_effective_quota()
Date: Thu, 21 Aug 2025 20:55:55 +0800
Message-ID: <20250821125555.3020951-1-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)

On 32-bit systems, the throughput calculation in function
damos_set_effective_quota() is prone to unnecessary multiplication
overflow. Using mult_frac() to fix it.

Andrew Paniakin also recently found and privately reported this
issue, on 64 bit systems. This can also happen on 64-bit systems,
once the charged size exceeds ~17 TiB. On systems running for long
time in production, this issue can actually happen.

More specifically, when a DAMOS scheme having the time quota run
for longtime, throughput calculation can overflow and set esz too
small. As a result, speed of the scheme get unexpectedly slow.

Fixes: 1cd243030059 ("mm/damon/schemes: implement time quota")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reported-by: Andrew Paniakin <apanyaki@amazon.com>
Closes: N/A # privately reported
---
 mm/damon/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 831a9afc6cf6..fe1c19307ddd 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2103,8 +2103,8 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 
 	if (quota->ms) {
 		if (quota->total_charged_ns)
-			throughput = quota->total_charged_sz * 1000000 /
-				quota->total_charged_ns;
+			throughput = mult_frac(quota->total_charged_sz, 1000000,
+							quota->total_charged_ns);
 		else
 			throughput = PAGE_SIZE * 1024;
 		esz = min(throughput * quota->ms, esz);
-- 
2.43.0


