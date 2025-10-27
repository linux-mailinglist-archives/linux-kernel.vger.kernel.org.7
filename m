Return-Path: <linux-kernel+bounces-871758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C351C0E39E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED96519A1A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C6F307AF7;
	Mon, 27 Oct 2025 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KKes2zCN"
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A39307494
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573782; cv=none; b=MFjU/BeEHlNbNCZF8TJosHEHsEERL+/t469BByHvwqdxy1Os5MlraDIFqgfyudY9+9n9p80/1ojAwuzTtjbDZPOw2byolAKBfrU8gSSOvJM52jtiTO8ZeMwExPz8tmqN+Wv8uYGXOGVNtmO8QenIHMgg+p9fVlksXFcoPdosuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573782; c=relaxed/simple;
	bh=B1tFRoWkEZMN4Yq5KyI7RmsxDfm0yEeONm5qj33yRdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlF0CdW8txh8DIb9x5zvIzpvjh8OTu1/N49pkNsL5VvW4SoPU53syzeQKm/+YVgtc6VTHzMtYhJNtvs0wecaE2qSprxPyAL/byN2LHJ8LefjOl7eyDjdHv1Rf4riRVnLqDbWroOJqXZ4SzTxFrbzU7i1N03YeYOuWj4KwpAE5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KKes2zCN; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=skT01swcwscnrABmfNzvfcVy552sDhR1HXvQJoW73Zc=;
	b=KKes2zCNnXquaxMSEaw4Qt+Vor+rZlmTdwMNmSWUFbYdgpEHaW3K0x3f7xGQhmEiG7vAdHI2r
	YcGWXVqxQmHSsmylD3DWdBgRZqto3seOnIv1RYYOpdkhrLCOcXF7QlY8Iv3hBswtq2TtB6hx3AR
	xwHbnOhLykF15V72hPpdP58=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cwFZ23xt8z12LKJ;
	Mon, 27 Oct 2025 22:02:18 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (unknown [7.185.36.8])
	by mail.maildlp.com (Postfix) with ESMTPS id C9CBF140203;
	Mon, 27 Oct 2025 22:02:56 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf500012.china.huawei.com
 (7.185.36.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 27 Oct
 2025 22:02:56 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<jannh@google.com>, <pfalcato@suse.de>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [RFC PATCH 2/3] mm/mincore: Use can_pte_batch_count() in mincore_pte_range() for pte batch mincore_pte_range()
Date: Mon, 27 Oct 2025 22:03:14 +0800
Message-ID: <20251027140315.907864-3-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027140315.907864-1-zhangqilong3@huawei.com>
References: <20251027140315.907864-1-zhangqilong3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500012.china.huawei.com (7.185.36.8)

In current mincore_pte_range(), if pte_batch_hint() return one
pte, it's not efficient, just call new added can_pte_batch_count().

In ARM64 qemu, with 8 CPUs, 32G memory, a simple test demo like:
1. mmap 1G anon memory
2. write 1G data by 4k step
3. mincore the mmaped 1G memory
4. get the time consumed by mincore

Tested the following cases:
 - 4k, disabled all hugepage setting.
 - 64k mTHP, only enable 64k hugepage setting.

Before

Case status | Consumed time (us)  |
----------------------------------|
4k          | 7356                |
64k mTHP    | 3670                |

Pathed:

Case status | Consumed time (us)  |
----------------------------------|
4k          | 4419                |
64k mTHP    | 3061                |

The result is evident and demonstrate a significant improvement in
the pte batch. While verification within a single environment may
have inherent randomness. there is a high probability of achieving
positive effects.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 mm/mincore.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/mm/mincore.c b/mm/mincore.c
index 8ec4719370e1..2cc5d276d1cd 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -178,18 +178,14 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 		/* We need to do cache lookup too for pte markers */
 		if (pte_none_mostly(pte))
 			__mincore_unmapped_range(addr, addr + PAGE_SIZE,
 						 vma, vec);
 		else if (pte_present(pte)) {
-			unsigned int batch = pte_batch_hint(ptep, pte);
-
-			if (batch > 1) {
-				unsigned int max_nr = (end - addr) >> PAGE_SHIFT;
-
-				step = min_t(unsigned int, batch, max_nr);
-			}
+			unsigned int max_nr = (end - addr) >> PAGE_SHIFT;
 
+			step = can_pte_batch_count(vma, ptep, &pte,
+						   max_nr, 0);
 			for (i = 0; i < step; i++)
 				vec[i] = 1;
 		} else { /* pte is a swap entry */
 			*vec = mincore_swap(pte_to_swp_entry(pte), false);
 		}
-- 
2.43.0


