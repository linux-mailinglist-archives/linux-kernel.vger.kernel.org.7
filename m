Return-Path: <linux-kernel+bounces-847257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781DABCA5E4
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D40427A1E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A7245010;
	Thu,  9 Oct 2025 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To0Hy5Lm"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A36524113D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030705; cv=none; b=HZ69xtpSn4Hd7la634DIm9cTUG/2tlgj8q/YGzi7uKbWfCQ205lM/rkEQ7DJIa+a6xPasyxIVPJ79abC+2hCpHMoMCqBfVEb7g7hGs2H/Un13PlbmK1lJBwTX3otW/KUR1Oe2V9QU0U4Hd4dgnASj0rwDckdpfKqnFq1IfNpQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030705; c=relaxed/simple;
	bh=NxknUC5bb5aOnfsjShzCKdTKU/map0GkiS0cxBoG2Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hAkAB1BhaoHSHzJlrGH/QR0wohbPXszDho5MEA8a7GvjgCzC5mXPcAp09IcASw3uKCBBSqJR1TTaF0Cm5n4R0qbo3QKYuVb2MQh1Kuws2ujKOvYnCwGAaHyGY/UzPLT1Vp1Qt2paU0/8yygvPaQVN/nIbJzWbg9fcLSARfuRxOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To0Hy5Lm; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-73b4e3d0756so14876607b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760030700; x=1760635500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GDbuLJWcV0DP64SCpKYdu9KRYGqMQUurSvhwqHHtxbw=;
        b=To0Hy5LmxjOcJ3rg6j7RgRBRx8uIgy5bZHyYLkS8enYNFdSiKTTSeIQepDdDwzgZzy
         S+PGrevsCoCiaO8YIX2EYrcrt9ecV+GZywIPny0qgjKi3P5JWTfn8oyedugxs5YHEabo
         3kyohq+qOutoLGXCspjiBy34+z+80hGxCF6dBN6/GYnhz+t7qfggwcbsZ/M2/+f5mCt9
         7zmzQ8qAyeWJPxL7odCaWLpQxm414DN/37+ZzzWqwoRNKddP3FyGu0IWPTMAnVmaVEFV
         DQGIegWUWU+6cHpsbgVvsG43NSIl764VXyocd2XfyjIIhi4QwTmR5c7S02BiKqhVNg3Z
         XO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760030700; x=1760635500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GDbuLJWcV0DP64SCpKYdu9KRYGqMQUurSvhwqHHtxbw=;
        b=La5KP9/g6H3pEHgvCVwWMufMfaqPnB9BWGoYlHnW4nCc0oq8p9ihhpHPXXXgV75Hgo
         frauHA4VcZavQ4EJtNuMdRyvYBgJ93ajkwzyZRU/9vAhccrIpDPYafcbpi/Fx5vs9iN1
         z21XFWXVmCH72zK9dvWAhcteem1bt3CT7SdExBEdvywO3pROhqPIPTKfBcnTaN1ri1aM
         L9G27zM2Mdq3icl5HE+FzEz/wt4O/4Erg6u+kPRSVCAkGS2vagb/TeiGEDxkkadyzaF5
         1eMfhtfV27/UwNjJPMtFAm8gvhu/uc1uc5o09sc0mLctfWAlN3qIRuCjOTlQ/pu6o0Uh
         eNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY1XuDs3YDesztLFvLQalHDuQgpO7Psxr6LCQjepQfVemJUjNaeO1KVJWWt62GgIyJIIPWbg5nhsVb2PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT8MaZQIJ42MXjaY50rH5kLKg+MLeRjsoofF9Yc5jy66zBQ7cR
	87btpX1kx6gv+HpTaAeLlFPeBXLYRWBfTlziHmPRkR7ZEDsGDOKnYDpP
X-Gm-Gg: ASbGncsOTmVAT65F6ln/9nNjbJoSkwLo7gnC9dOpVK2P5rmEjanFa6j9wAnIc3p0lrv
	Tuj+C3BteX/rof4uO7LuumjPv9Po7XzgsiFgL6xGqWZ5WxEEZ/Sis72UyWek4ckAbKlW9Bd/yPY
	sNkDPsNocFYq3Aa0fagJNZ/bjWK+ZIrlE4gMGhvt00bOGvg96dvZliAditEwjrnWeIvOv8bDp3K
	+jcG67tSlk44gJnWWhLgA5kFqwZxUMhb7Q9MMaswMm4PvOz2jp0CQWzHXaebyv8zDPSExEuWoGB
	HDFO6qLwx+J/Se5Fa13dLysIHio2+7cuqJaI9fslXzKRZ5l49n+oAfk7xtVlwLyMygbhVvzGWCT
	GneNpzu8SHq2LkWPysSkEtDSBccF4VhfN+ci6B2FBb9moWS0cO5Zd0IjDjEjySoeH+9U=
X-Google-Smtp-Source: AGHT+IE0HeRkcSWt/qNt+REpafTXmTS86WuRWboi7HnZzYqvTb7JpaI32/8qMbasmYlxV/NiCrYEFA==
X-Received: by 2002:a53:dd01:0:b0:63b:9ebe:faec with SMTP id 956f58d0204a3-63ccb90ae68mr5781162d50.26.1760030699978;
        Thu, 09 Oct 2025 10:24:59 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7810724444bsm181727b3.43.2025.10.09.10.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:24:59 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>
Cc: shakeel.butt@linux.dev,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	kas@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 1/2] mm/hugetlb: create hstate_is_gigantic_no_runtime helper
Date: Thu,  9 Oct 2025 18:24:30 +0100
Message-ID: <20251009172433.4158118-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a common condition used to skip operations that cannot
be performed on gigantic pages when runtime support is disabled.
This helper is introduced as the condition will exist even more
when allowing "overcommit" of gigantic hugepages.
No functional change intended with this patch.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 mm/hugetlb.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c07b7192aff26..e74e41386b100 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -134,6 +134,17 @@ static void hugetlb_free_folio(struct folio *folio)
 	folio_put(folio);
 }
 
+/*
+ * Check if the hstate represents gigantic pages but gigantic page
+ * runtime support is not available. This is a common condition used to
+ * skip operations that cannot be performed on gigantic pages when runtime
+ * support is disabled.
+ */
+static inline bool hstate_is_gigantic_no_runtime(struct hstate *h)
+{
+	return hstate_is_gigantic(h) && !gigantic_page_runtime_supported();
+}
+
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
 	if (spool->count)
@@ -1555,7 +1566,7 @@ static void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
 
 	lockdep_assert_held(&hugetlb_lock);
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return;
 
 	list_del(&folio->lru);
@@ -1617,7 +1628,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 {
 	bool clear_flag = folio_test_hugetlb_vmemmap_optimized(folio);
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return;
 
 	/*
@@ -2511,7 +2522,7 @@ static void return_unused_surplus_pages(struct hstate *h,
 	/* Uncommit the reservation */
 	h->resv_huge_pages -= unused_resv_pages;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		goto out;
 
 	/*
@@ -3725,7 +3736,7 @@ static void __init hugetlb_init_hstates(void)
 		 * - If CMA allocation is possible, we can not demote
 		 *   HUGETLB_PAGE_ORDER or smaller size pages.
 		 */
-		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+		if (hstate_is_gigantic_no_runtime(h))
 			continue;
 		if (hugetlb_cma_total_size() && h->order <= HUGETLB_PAGE_ORDER)
 			continue;
@@ -4202,7 +4213,7 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
 	int err;
 	nodemask_t nodes_allowed, *n_mask;
 
-	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
+	if (hstate_is_gigantic_no_runtime(h))
 		return -EINVAL;
 
 	if (nid == NUMA_NO_NODE) {
-- 
2.47.3


