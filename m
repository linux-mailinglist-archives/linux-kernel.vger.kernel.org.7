Return-Path: <linux-kernel+bounces-892260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECE2C44B92
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FD0C345F42
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63525145B3E;
	Mon, 10 Nov 2025 01:26:33 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3116134D38F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762737993; cv=none; b=PaXv2nKXwDhCgGfHyq4/CitpWH2nbtszuLGyKQE8qbzMXIjju0RvS+Acvtpc3EvfpiDPuvQP8vpe5151dRcGNs2/rPZvZNgxGkXX3XAUHDLb2oUaC9UD77Ix6qSuG6s0z43sKL1KtsDaHMmOB5SK9x3hk6hcUvI9ENowUejAYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762737993; c=relaxed/simple;
	bh=BavP+TaIcTuP+MLnz4Ujbq9GTWMn7t2ikjORWgFFXjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pF4qeLN+UgJU9AA1c4/RK8GTqkn7NR5vR2922DKNFfx94GbQsbh7Nopw7H9CAHpuEKFUpgZ1712E1tJ9T3KF0NuAVAmBb6Ks5QKz6Haf8Wax563iFeX/xwdcl4jxYHd/FMJF1O9FChdttw98CS+DHzS5dB0+OqwwIACGhVuWjtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee569113f3a69c-c17c1;
	Mon, 10 Nov 2025 09:26:18 +0800 (CST)
X-RM-TRANSID:2ee569113f3a69c-c17c1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181454368174 (unknown[36.137.216.22])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee469113f36140-dae3b;
	Mon, 10 Nov 2025 09:26:18 +0800 (CST)
X-RM-TRANSID:2ee469113f36140-dae3b
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
	jiangshanlai@gmail.com,
	lkml@gmail.com,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] workqueue:  Remove unused assert_rcu_or_wq_mutex_or_pool_mutex
Date: Mon, 10 Nov 2025 09:26:07 +0800
Message-ID: <20251110012608.764-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

assert_rcu_or_wq_mutex_or_pool_mutex is never referenced in the code.
Just remove it.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 kernel/workqueue.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c6b79b3675c3..a86889d8218b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -539,12 +539,6 @@ static void show_one_worker_pool(struct worker_pool *pool);
 			 !lockdep_is_held(&wq_pool_mutex),		\
 			 "RCU or wq_pool_mutex should be held")
 
-#define assert_rcu_or_wq_mutex_or_pool_mutex(wq)			\
-	RCU_LOCKDEP_WARN(!rcu_read_lock_any_held() &&			\
-			 !lockdep_is_held(&wq->mutex) &&		\
-			 !lockdep_is_held(&wq_pool_mutex),		\
-			 "RCU, wq->mutex or wq_pool_mutex should be held")
-
 #define for_each_bh_worker_pool(pool, cpu)				\
 	for ((pool) = &per_cpu(bh_worker_pools, cpu)[0];		\
 	     (pool) < &per_cpu(bh_worker_pools, cpu)[NR_STD_WORKER_POOLS]; \
-- 
2.33.0




