Return-Path: <linux-kernel+bounces-817704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9165DB58584
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A9147B145A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BFB2874F1;
	Mon, 15 Sep 2025 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aoHn/lci"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D77C28727E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965949; cv=none; b=IG4wvhg0NkxFwdQgcH/fElotdImCIyukc0kNlmIdIV78Pf+597CJ8g/B+4OOias2P3E4KHJE1wna+S/vTUfnA/NKGg05M7H4EtBw2TfBPSPKIzoLt6Oa2UB8n8LjGUnSjDnvuoaKfir8wSTCmxMrIJxpiL7WZKQPOkmUCns/Uj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965949; c=relaxed/simple;
	bh=2cRPoohQ0MmOLZTf1mIp9HVeBlRdoTXyPcT7a1QwRos=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NDWqic7mmWJD8AEAPReiE4hC8scafItqrhk6pvu0MA8pgS9jqkTkhN+5uo9CGj1QTYL/GOb/hFpwZC55nBet6RHmVQAuo/NWuugXL3BQYZruiR5MFlYAw3x1ycZyqOhmgZihSXjb+C96cBA/kl2TiGuEZ66avyOy086D29uvG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aoHn/lci; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so4210206b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757965947; x=1758570747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8sdVCwgpzgSZpEZdIa2RxiH6JcLxFU2dfzzWpV7l6M=;
        b=aoHn/lciK1E0IpL6HkpUhkZXpQSn4JIJZgCuLGh8neIDD29SJpEScJf0Fqb5DYNsgP
         TFcVKH8WZsMLScRK8XyGvfSWPeuLRlJBQPE+heGSeii9xPF4RW4VqTxzoCGOFYWQuYbK
         gy0sXt2fNuXeHdXfDDTu3/gBiTALu+MGPrt43KABtPbhojYdhZRXLd727lv2mhi5xTno
         t2QzYTPJwWCmgxU3mDBnbZ4aNaF22KjojLjOcIZS5Lph28pA8MUIU4oIECnv3NA6jfu6
         4J4cYX9dieIz8Df0kz1zGxTVpmt+1JeaRVQrtw4o/gerL9AnuHs8fVkJQGxU29E9jVpw
         y4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965947; x=1758570747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8sdVCwgpzgSZpEZdIa2RxiH6JcLxFU2dfzzWpV7l6M=;
        b=LnSl0z1ZZfqSjQNceYoddu+5THb4W8TNw4jOQwOTjf4xEQznMDyZsEJYDZ4goiuiPF
         CSlmiOtmIkzJ7xEMKX6dAlZe9hLhH0SGbnLXSmhY0lDws3rCoOCdkbgCrIFvCN31Os0R
         F/I43ZKWkJ94hG6rW57EEoYADVz7KyLzC2V1aTrdYcZabLujYIPC5qa4SpM+k7UaR+Km
         M6GxukPgMPVl8+H0bWNSAKGDCOv/TjZ3L534USqxrISKF+hD/fWF4q6uFb1UjcIOkc56
         sVyYvIq/JGAwS/j6aknW7JMVCk5hmYZsPZ31JMo2zUbs4oiIH4q57VslH0B1ETU4kFCM
         DO2g==
X-Forwarded-Encrypted: i=1; AJvYcCU0J7ekzMM1Mdct/BXS10GMa493MgOuh8zEbZU+KpHQw80+56pDVSFeTOGcdNNBANIRURXJm0tFD7ka8bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCs4cVOWgW87TDvj+OexyZGOimPYbb+u2vYhLVBfmWmaYZpTa/
	wHHpopzmqcJSZXBZhV0DoXKfFP52sH2zYMT8YHIJw9gLmhfC8dZHIXxtQQ58120utnW7Kxnj+A=
	=
X-Google-Smtp-Source: AGHT+IHSrj8b6/0anPmsTtmAtpPpKBamD1vvncwaV7EMPgRBfcfV+2TtFZIJ4M8kZJb/oeTBgqjLyGgI
X-Received: from pfaq4.prod.google.com ([2002:a05:6a00:a884:b0:772:32b1:58f9])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17a1:b0:772:8694:1d71
 with SMTP id d2e1a72fcca58-77611f99ea8mr14148444b3a.0.1757965947238; Mon, 15
 Sep 2025 12:52:27 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:51:47 +0000
In-Reply-To: <20250915195153.462039-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915195153.462039-1-fvdl@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915195153.462039-7-fvdl@google.com>
Subject: [RFC PATCH 06/12] mm/cma: define and act on CMA_BALANCE flag
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

When the CMA_BALANCE flag is set for a CMA area, it means that
it opts in to CMA balancing. This means two things:

1) It allows movable allocations to be migrated in to it in
   the case of a CMA inbalance (too much free memory in CMA
   pageblocks as compared to other pageblocks).
2) It is allocated top-down, so that compaction will end up
   migrating pages in to it. Doing this will make sure that
   compaction doesn't aggrevate a CMA imbalance, and that it
   won't fight with CMA balance migration from non-CMA to
   CMA.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 include/linux/cma.h |  4 +++-
 mm/cma.c            | 33 ++++++++++++++++++++++++++-------
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 0504580d61d0..6e98a516b336 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -26,6 +26,7 @@ enum cma_flags {
 	__CMA_ZONES_INVALID,
 	__CMA_ACTIVATED,
 	__CMA_FIXED,
+	__CMA_BALANCE,
 };
 
 #define CMA_RESERVE_PAGES_ON_ERROR	BIT(__CMA_RESERVE_PAGES_ON_ERROR)
@@ -33,8 +34,9 @@ enum cma_flags {
 #define CMA_ZONES_INVALID		BIT(__CMA_ZONES_INVALID)
 #define CMA_ACTIVATED			BIT(__CMA_ACTIVATED)
 #define CMA_FIXED			BIT(__CMA_FIXED)
+#define CMA_BALANCE			BIT(__CMA_BALANCE)
 
-#define CMA_INIT_FLAGS (CMA_FIXED|CMA_RESERVE_PAGES_ON_ERROR)
+#define CMA_INIT_FLAGS (CMA_FIXED|CMA_RESERVE_PAGES_ON_ERROR|CMA_BALANCE)
 
 struct cma;
 struct zone;
diff --git a/mm/cma.c b/mm/cma.c
index 53cb1833407b..6050d57f3c2e 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -272,6 +272,9 @@ static bool cma_next_free_range(struct cma_memrange *cmr,
 static inline bool cma_should_balance_range(struct zone *zone,
 				      struct cma_memrange *cmr)
 {
+	if (!(cmr->cma->flags & CMA_BALANCE))
+		return false;
+
 	if (page_zone(pfn_to_page(cmr->base_pfn)) != zone)
 		return false;
 
@@ -527,6 +530,12 @@ static bool __init basecmp(struct cma_init_memrange *mlp,
 	return mlp->base < mrp->base;
 }
 
+static bool __init revbasecmp(struct cma_init_memrange *mlp,
+			   struct cma_init_memrange *mrp)
+{
+	return mlp->base > mrp->base;
+}
+
 /*
  * Helper function to create sorted lists.
  */
@@ -575,7 +584,8 @@ static int __init cma_fixed_reserve(phys_addr_t base, phys_addr_t size)
 }
 
 static phys_addr_t __init cma_alloc_mem(phys_addr_t base, phys_addr_t size,
-			phys_addr_t align, phys_addr_t limit, int nid)
+			phys_addr_t align, phys_addr_t limit, int nid,
+			unsigned long flags)
 {
 	phys_addr_t addr = 0;
 
@@ -588,7 +598,8 @@ static phys_addr_t __init cma_alloc_mem(phys_addr_t base, phys_addr_t size,
 	 * like DMA/DMA32.
 	 */
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
-	if (!memblock_bottom_up() && limit >= SZ_4G + size) {
+	if (!(flags & CMA_BALANCE) && !memblock_bottom_up()
+			&& limit >= SZ_4G + size) {
 		memblock_set_bottom_up(true);
 		addr = memblock_alloc_range_nid(size, align, SZ_4G, limit,
 						nid, true);
@@ -695,7 +706,7 @@ static int __init __cma_declare_contiguous_nid(phys_addr_t *basep,
 		if (ret)
 			return ret;
 	} else {
-		base = cma_alloc_mem(base, size, alignment, limit, nid);
+		base = cma_alloc_mem(base, size, alignment, limit, nid, flags);
 		if (!base)
 			return -ENOMEM;
 
@@ -851,7 +862,10 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 	list_for_each_safe(mp, next, &ranges) {
 		mlp = list_entry(mp, struct cma_init_memrange, list);
 		list_del(mp);
-		list_insert_sorted(&final_ranges, mlp, basecmp);
+		if (flags & CMA_BALANCE)
+			list_insert_sorted(&final_ranges, mlp, revbasecmp);
+		else
+			list_insert_sorted(&final_ranges, mlp, basecmp);
 		sizesum += mlp->size;
 		if (sizesum >= total_size)
 			break;
@@ -866,7 +880,12 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 	list_for_each(mp, &final_ranges) {
 		mlp = list_entry(mp, struct cma_init_memrange, list);
 		size = min(sizeleft, mlp->size);
-		if (memblock_reserve(mlp->base, size)) {
+		if (flags & CMA_BALANCE)
+			start = (mlp->base + mlp->size - size);
+		else
+			start = mlp->base;
+
+		if (memblock_reserve(start, size)) {
 			/*
 			 * Unexpected error. Could go on to
 			 * the next one, but just abort to
@@ -877,9 +896,9 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 		}
 
 		pr_debug("created region %d: %016llx - %016llx\n",
-		    nr, (u64)mlp->base, (u64)mlp->base + size);
+		    nr, (u64)start, (u64)start + size);
 		cmrp = &cma->ranges[nr++];
-		cmrp->base_pfn = PHYS_PFN(mlp->base);
+		cmrp->base_pfn = PHYS_PFN(start);
 		cmrp->early_pfn = cmrp->base_pfn;
 		cmrp->count = size >> PAGE_SHIFT;
 		cmrp->cma = cma;
-- 
2.51.0.384.g4c02a37b29-goog


