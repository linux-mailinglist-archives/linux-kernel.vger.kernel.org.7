Return-Path: <linux-kernel+bounces-765850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BB0B23F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85203BC09F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB442BE044;
	Wed, 13 Aug 2025 03:52:38 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245311E9919
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057158; cv=none; b=iElTZi0YwxmDpTv52uTXJ2cMaBtl8L/BAZuv/SYGoFCVp4bxXuGw2rgFWfWPcfxTqDE16ZoTj98BnA/tSa9uSW679joX+g3m/YAB0GaeCXBA0rQRjfvWU7mtNBI9dxMTYRCJSOiyBPUTYqKtiwYJqn8z71KGvU6jMacP0/21GMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057158; c=relaxed/simple;
	bh=YyfkuuZ1Ujm+PMhnwJcHFUQkjzkuSC17Isp2jorE/mk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzvsORLNcuDWaExZlonUvHI3qudcPS8SUthpFKqv5OwCHVUAch/j/zQ149LNLjo6K9MbC6Q/BXgL+8uAUokvwUrPjgPvWyLkn5T9AwQt/zObRMf99SpX2QhqeYrnFDmkEk9OYV5nPbhoGT6szxCoYVGayWauKyArmhgtq84Dr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c1vTK4X9Vz14MRH;
	Wed, 13 Aug 2025 11:47:33 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id E88C3140202;
	Wed, 13 Aug 2025 11:52:32 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 13 Aug
 2025 11:52:32 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [RFC PATCH -next 05/16] mm/damon/paddr: support addr_unit for MIGRATE_{HOT,COLD}
Date: Wed, 13 Aug 2025 13:06:55 +0800
Message-ID: <20250813050706.1564229-6-yanquanmin1@huawei.com>
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

Add support of addr_unit for DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD
action handling from the DAMOS operation implementation for the physical
address space.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b8a7f462967b..76e1ee82b441 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -245,15 +245,17 @@ static unsigned long damon_pa_deactivate_pages(struct damon_region *r,
 			sz_filter_passed);
 }
 
-static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
+static unsigned long damon_pa_migrate(struct damon_region *r,
+		unsigned long addr_unit, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
-	unsigned long addr, applied;
+	phys_addr_t addr;
+	unsigned long applied;
 	LIST_HEAD(folio_list);
 	struct folio *folio;
 
-	addr = r->ar.start;
-	while (addr < r->ar.end) {
+	addr = damon_pa_phys_addr(r->ar.start, addr_unit);
+	while (addr < damon_pa_phys_addr(r->ar.end, addr_unit)) {
 		folio = damon_get_folio(PHYS_PFN(addr));
 		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
@@ -330,7 +332,7 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 				sz_filter_passed);
 	case DAMOS_MIGRATE_HOT:
 	case DAMOS_MIGRATE_COLD:
-		return damon_pa_migrate(r, scheme, sz_filter_passed);
+		return damon_pa_migrate(r, aunit, scheme, sz_filter_passed);
 	case DAMOS_STAT:
 		return damon_pa_stat(r, scheme, sz_filter_passed);
 	default:
-- 
2.34.1


