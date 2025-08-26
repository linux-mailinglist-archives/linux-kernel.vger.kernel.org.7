Return-Path: <linux-kernel+bounces-785894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF23DB3523E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4361A861AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743E02D3725;
	Tue, 26 Aug 2025 03:36:33 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28052D29C8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756179393; cv=none; b=r3+0agcFpwfomMc5BixIie6coeq2h2+He/0767vlLRhaTK+8P4BhJDURdyhGtPkwQfQOf1wZFWpP/tuDGmHVF8ZbqKFpv5fLfdPwoawJm4E41b/qNPdLjI4x6pbakLZmiNyWNieAWCxqDufuadeMFhl5FjROI1S2vPSyMIsvuhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756179393; c=relaxed/simple;
	bh=fQqrBtdhSpQesP30VUp+LFZpGKiZXFY+jZ6QkzMGEY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsZTXecyEmjUhOVvW9PbIJsrKCPjmtQVaaFoXUk0DH8z+K9mauj4QBV4Tg9Tfxkanr7zb10TlKkvPOdYC2Yt9HlwtERmjLiJ1qE/JcHBnDH4DP82RsfKk+f9eb37Ue/5fegwo34EvtOOZHxFKKBS9RN+A9zJCxIIq9ykDM8KmzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c9tY76lHXz2VRMw;
	Tue, 26 Aug 2025 11:33:31 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 6029A1A016C;
	Tue, 26 Aug 2025 11:36:28 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Aug
 2025 11:36:27 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH 1/2] mm/damon/lru_sort: avoid divide-by-zero in damon_lru_sort_apply_parameters()
Date: Tue, 26 Aug 2025 11:36:52 +0800
Message-ID: <20250826033653.1208227-2-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826033653.1208227-1-yanquanmin1@huawei.com>
References: <20250826033653.1208227-1-yanquanmin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf200018.china.huawei.com (7.185.36.31)

During the calculation of 'hot_thres' and 'cold_thres', either
'sample_interval' or 'aggr_interval' is used as the divisor,
which may lead to division-by-zero errors. Fix it by directly
returning -EINVAL when such a case occurs. Additionally, since
'aggr_interval' is already required to be set no smaller than
'sample_interval' in damon_set_attrs(), only the case where
'sample_interval' is zero needs to be checked.

Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 mm/damon/lru_sort.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 151a9de5ad8b..b5a5ed16a7a5 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -198,6 +198,11 @@ static int damon_lru_sort_apply_parameters(void)
 	if (err)
 		return err;
 
+	if (!damon_lru_sort_mon_attrs.sample_interval) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = damon_set_attrs(ctx, &damon_lru_sort_mon_attrs);
 	if (err)
 		goto out;
-- 
2.43.0


