Return-Path: <linux-kernel+bounces-765860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BCBB23F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E0C721A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7EC2C17A0;
	Wed, 13 Aug 2025 03:52:44 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D525A2C0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057163; cv=none; b=LXIeFu/81xD65hhURly/vleZqKKTnXO95gJwNtq/rUIoJygRplreSlOhhB3AFPBPmdso9kfGtg+tewvSOT6nR5R3NKDgkIk4ziihB17UaZV4LS9L07B1Ud+k/Uw2Ui0HdQqZOzNZnlf2krF4kig1mGrb1zwclsNuMJ2p0bIIoVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057163; c=relaxed/simple;
	bh=3wd0t2c2+VJKodUzDTdYTGuKzZ2NWATSOKx9NCa2o/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eI+9ceyfgv/JzQR6GZWrn51rf7xyGFEWTmoalmM/Xl3RS8L+sNEiIZ//lJkCEH8LnDPsV7QIdxMqXzahFG9cDAZAKB/VC1tQ1rzzWluj7hzGcU8PSuzke0JYEf0Fd3EeIVrE3AegZJlaIXrvctyPuWrhWCSZe7ZrebBirJHBtMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c1vWq69vzz1R91D;
	Wed, 13 Aug 2025 11:49:43 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id B40CA1402C1;
	Wed, 13 Aug 2025 11:52:33 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 11:52:32 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH -next 06/16] mm/damon/paddr: support addr_unit for DAMOS_STAT
Date: Wed, 13 Aug 2025 13:06:56 +0800
Message-ID: <20250813050706.1564229-7-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813050706.1564229-1-yanquanmin1@huawei.com>
References: <20250813050706.1564229-1-yanquanmin1@huawei.com>
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

From: SeongJae Park <sj@kernel.org>

Add support of addr_unit for DAMOS_STAT action handling from the DAMOS
operation implementation for the physical address space.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 76e1ee82b441..530bc9d3ce3b 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -289,17 +289,18 @@ static bool damon_pa_scheme_has_filter(struct damos *s)
 	return false;
 }
 
-static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
+static unsigned long damon_pa_stat(struct damon_region *r,
+		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	unsigned long addr;
+	phys_addr_t addr;
 	struct folio *folio;
 
 	if (!damon_pa_scheme_has_filter(s))
 		return 0;
 
-	addr = r->ar.start;
-	while (addr < r->ar.end) {
+	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
+	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
@@ -334,7 +335,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_MIGRATE_COLD:
 		return damon_pa_migrate(r, aunit, scheme, sz_filter_passed);
 	case DAMOS_STAT:
-		return damon_pa_stat(r, scheme, sz_filter_passed);
+		return damon_pa_stat(r, aunit, scheme, sz_filter_passed);
 	default:
 		/* DAMOS actions that not yet supported by 'paddr'. */
 		break;
-- 
2.34.1


