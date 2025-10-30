Return-Path: <linux-kernel+bounces-877431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D65C1E17C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BB54037A4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 02:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFE82FF65C;
	Thu, 30 Oct 2025 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="l+XDWrmA"
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F262FC02F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761790043; cv=none; b=uMjsOsHKJYg3FAdJfvwhOMj/ZY9KGMrxnkZCnjUGaRyfy6aw0gX24Ntw3pl+MLuTnQZXmh3feqBH3w2yBi/Jumgbhsyts96/x8AOWDv/xW9Kg3Gyt+UlrpA0kClXDSVWzw/ku+UXf5FKQN9rWY8D3ugSvhQC2nNoOyWZwVTQcIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761790043; c=relaxed/simple;
	bh=+NPqMVrB2l1gWDAaWXGohZUXYcRy4anLZIaEBuvl7wI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyuJiA3KDQ8DmnEcQeRbd8Qxz0agRARWIJaVrm5MrLdr/w6e3xnvyRZZCsaDXyKZXKqjaVqzFUfHoYWLzDQ0yB1Q8No0jIuRPmusMhdBh8uZqNh9Gg5qFNjqZ1Bdnj+kJiCiQeMMybwMoRJzaYtM14wR5aK+KNIPDMsvkBzLoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=l+XDWrmA; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Fr+3CDNz64iBwWCR8OXL6QiRv6BkJHD6nWLy2Y5mJRg=;
	b=l+XDWrmA89J7sFLQjzNeZ5TUea1iYtJx18bPrE4Pn5sL5xmly5KhYipxZKWVsTS2f/ITQU7l2
	G3K/K2+vhp326P7vtkK2klRq4NxaIQ0Uilnfw+rz844UsH7YAwMqDFuX19fQrUf4J8cfoJ+AK/O
	pmL6gmdQODnoSeH4QJomBc4=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cxnXz4xzmzLlSH;
	Thu, 30 Oct 2025 10:06:43 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 02D901A016C;
	Thu, 30 Oct 2025 10:07:13 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 10:07:12 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH v2 1/2] mm/damon/stat: change last_refresh_jiffies to a global variable
Date: Thu, 30 Oct 2025 10:07:45 +0800
Message-ID: <20251030020746.967174-2-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030020746.967174-1-yanquanmin1@huawei.com>
References: <20251030020746.967174-1-yanquanmin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf200018.china.huawei.com (7.185.36.31)

In DAMON_STAT's damon_stat_damon_call_fn(), time_before_eq() is used to
avoid unnecessarily frequent stat update.

On 32-bit systems, the kernel initializes jiffies to "-5 minutes" to make
jiffies wrap bugs appear earlier. However, this causes time_before_eq()
in DAMON_STAT to unexpectedly return true during the first 5 minutes
after boot on 32-bit systems (see [1] for more explanation, which fixes
another jiffies-related issue before). As a result, DAMON_STAT does not
update any monitoring results during that period, which becomes more
confusing when DAMON_STAT_ENABLED_DEFAULT is enabled.

There is also an issue unrelated to the system’s word size[2]: if the
user stops DAMON_STAT just after last_refresh_jiffies is updated and
restarts it after 5 seconds or a longer delay, last_refresh_jiffies will
retain an older value, causing time_before_eq() to return false and the
update to happen earlier than expected.

Fix these issues by making last_refresh_jiffies a global variable and
initializing it each time DAMON_STAT is started.

[1] https://lkml.kernel.org/r/20250822025057.1740854-1-ekffu200098@gmail.com
[2] https://lore.kernel.org/all/20251028143250.50144-1-sj@kernel.org/

Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated memory bandwidth")
Suggested-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 mm/damon/stat.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 6c4503d2aee3..ed8e3629d31a 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -46,6 +46,8 @@ MODULE_PARM_DESC(aggr_interval_us,
 
 static struct damon_ctx *damon_stat_context;
 
+static unsigned long damon_stat_last_refresh_jiffies;
+
 static void damon_stat_set_estimated_memory_bandwidth(struct damon_ctx *c)
 {
 	struct damon_target *t;
@@ -130,13 +132,12 @@ static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
 static int damon_stat_damon_call_fn(void *data)
 {
 	struct damon_ctx *c = data;
-	static unsigned long last_refresh_jiffies;
 
 	/* avoid unnecessarily frequent stat update */
-	if (time_before_eq(jiffies, last_refresh_jiffies +
+	if (time_before_eq(jiffies, damon_stat_last_refresh_jiffies +
 				msecs_to_jiffies(5 * MSEC_PER_SEC)))
 		return 0;
-	last_refresh_jiffies = jiffies;
+	damon_stat_last_refresh_jiffies = jiffies;
 
 	aggr_interval_us = c->attrs.aggr_interval;
 	damon_stat_set_estimated_memory_bandwidth(c);
@@ -211,6 +212,8 @@ static int damon_stat_start(void)
 	err = damon_start(&damon_stat_context, 1, true);
 	if (err)
 		return err;
+
+	damon_stat_last_refresh_jiffies = jiffies;
 	call_control.data = damon_stat_context;
 	return damon_call(damon_stat_context, &call_control);
 }
-- 
2.43.0


