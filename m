Return-Path: <linux-kernel+bounces-779584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EACDB2F5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A8F3A15BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4456530E0D9;
	Thu, 21 Aug 2025 11:06:18 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DB530F555
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774377; cv=none; b=qEcktalLm55kOjwuY4XP/3H52uBR6L8pympPdFFsKBRHqaU3UfftqtLWUn4RPjnIXyPGpIikaeHdXn0T9awV2V1t/08VOrnv8G78yTrmb3zNwY78iFGrOBrLyq1L0KDFdwYAr0ZS/zLGOk4nqXIkAqTVAJtvWe5IfMN0NeKkamo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774377; c=relaxed/simple;
	bh=+VT3qcPTdQYv7Btq06E7aQ9Y8JOxL5JGYeobA8Aa3iM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfhhfHFX49j/vb32lsuz5NpZph9O2zSEadIEJDgXfaQCeSkT8+Ta7dB4tJYvwko8JZ1XcW/0lJ57GUcHJN/KzcPiHPme/4Jot6nBeCoicOemJ3vizxZ31a84Uws3UUWr7sGdqWWIh/P2/mj6Jphbv3536IUXUbD8mIyu89f4Wk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c70qB47mtz14MXK;
	Thu, 21 Aug 2025 19:05:42 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id D71A41402C4;
	Thu, 21 Aug 2025 19:05:46 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 21 Aug
 2025 19:05:46 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH 06/11] mm/damon/paddr: support addr_unit for DAMOS_STAT
Date: Thu, 21 Aug 2025 18:51:54 +0800
Message-ID: <20250821105159.2503894-7-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821105159.2503894-1-yanquanmin1@huawei.com>
References: <20250821105159.2503894-1-yanquanmin1@huawei.com>
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

From: SeongJae Park <sj@kernel.org>

Add support of addr_unit for DAMOS_STAT action handling from the DAMOS
operation implementation for the physical address space.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
---
 mm/damon/paddr.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 0305e59818da..5fad2f9a99a0 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -277,17 +277,18 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 	return applied * PAGE_SIZE / addr_unit;
 }
 
-static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
+static unsigned long damon_pa_stat(struct damon_region *r,
+		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	unsigned long addr;
+	phys_addr_t addr;
 	struct folio *folio;
 
 	if (!damos_ops_has_filter(s))
 		return 0;
 
-	addr = r->ar.start;
-	while (addr < r->ar.end) {
+	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
+	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
@@ -295,7 +296,7 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 		}
 
 		if (!damos_pa_filter_out(s, folio))
-			*sz_filter_passed += folio_size(folio);
+			*sz_filter_passed += folio_size(folio) / addr_unit;
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
@@ -322,7 +323,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 	case DAMOS_MIGRATE_COLD:
 		return damon_pa_migrate(r, aunit, scheme, sz_filter_passed);
 	case DAMOS_STAT:
-		return damon_pa_stat(r, scheme, sz_filter_passed);
+		return damon_pa_stat(r, aunit, scheme, sz_filter_passed);
 	default:
 		/* DAMOS actions that not yet supported by 'paddr'. */
 		break;
-- 
2.43.0


