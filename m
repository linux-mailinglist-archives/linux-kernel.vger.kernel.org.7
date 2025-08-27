Return-Path: <linux-kernel+bounces-788251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB376B381D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C6E6869C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A175B301010;
	Wed, 27 Aug 2025 11:58:43 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B229D297
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756295923; cv=none; b=RagkkU6m5mGZcH/mofEmZztIp5N06ElnOT5ZR14q1po3qOjNA7mlYxuiLMIdHpUK3kKzG+fIgFX+sGYzqc/ZjqPfsf5BTC41s7SALehKMs9IxOh8dxU3PU5v2Z1pVggoP3WhKxTNU1/O2GQwb3iA5Ra3coE+qyLWWPybGybItV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756295923; c=relaxed/simple;
	bh=z9InhMwxlHrlpWLJoWGYpX26uQyPWRXLYtpQgRNMZog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpqBzdGSWVLP0xoBKbQBWcHzeob+hhKf0ucoiK61VdjoLvxMgXzPktOiVbkiNSHh1VTGYWnClXV3IU4E9S5Q/+kVJB75rNS1CLz//XIJ6DlDJL/15TEOwWBmxwmGN3mdJ7EGuVp2TYLYwZrl8xuIDOEAwgzNruJTaVNUS3Z/370=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cBjf354Fyz2VRVq;
	Wed, 27 Aug 2025 19:55:39 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id D64011A016C;
	Wed, 27 Aug 2025 19:58:37 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 27 Aug
 2025 19:58:37 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH 2/2] mm/damon/reclaim: avoid divide-by-zero in damon_reclaim_apply_parameters()
Date: Wed, 27 Aug 2025 19:58:58 +0800
Message-ID: <20250827115858.1186261-3-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827115858.1186261-1-yanquanmin1@huawei.com>
References: <20250827115858.1186261-1-yanquanmin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf200018.china.huawei.com (7.185.36.31)

When creating a new scheme of DAMON_RECLAIM, the calculation
of 'min_age_region' uses 'aggr_interval' as the divisor, which
may lead to division-by-zero errors. Fix it by directly returning
-EINVAL when such a case occurs.

Fixes: f5a79d7c0c87 ("mm/damon: introduce struct damos_access_pattern")
Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 3c71b4596676..fb7c982a0018 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -194,6 +194,11 @@ static int damon_reclaim_apply_parameters(void)
 	if (err)
 		return err;
 
+	if (!damon_reclaim_mon_attrs.aggr_interval) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = damon_set_attrs(param_ctx, &damon_reclaim_mon_attrs);
 	if (err)
 		goto out;
-- 
2.43.0


