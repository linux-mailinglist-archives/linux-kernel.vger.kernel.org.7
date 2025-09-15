Return-Path: <linux-kernel+bounces-817708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A87EB58587
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AEA91AA778F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC9829993E;
	Mon, 15 Sep 2025 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Me5i/rrw"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8CB28C5DE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965956; cv=none; b=M4DclcDvEZ5lsvBd78QjukRaoyLDdMmCcQGNDrHJ8AKSAlBOs3ye7/mePjyAce/IfoZi/TbK7WrJW0YVrpSUZR/S+NE29xFlidT/8cdDdpfVN4P99t24B3znCs2yGFNzEd5W0nJ7n2IXds07s02E+g5Gv4tEDebEV0uXjLEIZ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965956; c=relaxed/simple;
	bh=gb0XDeyjnwh5CMarnGIWP/LYrRFNSf8Mf19XOje2tfE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hJstyFDBkWFP9rN+13NFKo2NPzm+/k0t8NS2gL0Hq1CRHj0FFyvXBCQZSGp9S5YfkOIqONrQp7+gAXsg9IAQkt/4E3kr+fRrnd9pM2b4yxlap3kduCTOp12uhQv8YdmC3EQMR8/pKx7kgnbYsUU/TGh/6hc7G5Kq7qkzQoUKLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Me5i/rrw; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4f87c691a7so7285550a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757965954; x=1758570754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MjOcVaMGZCYXnwmJQZ57Yx+f6ZupaH/8SoD2+GME4k=;
        b=Me5i/rrwA6TXI6P7eAbSOvlWuCHZjptlnXd8vVmEVYntTwyjmuzzBHXB0BAnM+PrCv
         3cCte+Yw7dMS8PifLG6IZug/VlKUCuAU970di78+OteRS56aqh8meir21ici78+81Yeo
         g08raB2K+0f4FVDlHPZmNepMEoVFd9+a7x/NIHRPGn3A6uZOUQn5FFIbDvv5nWVzQpDH
         TU79u1EqSg4rIvXUP36GAOMR1JvEB+UkvAP1GUUKXMaGcWXJeAi587d1JSbIpbYRa3qZ
         z82PTViy4DFBd5iQ9W1FOw3OIXK1K09iimdRi+K7mKxwssQu3tY6bkytgIyhWy036GOA
         WI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965954; x=1758570754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MjOcVaMGZCYXnwmJQZ57Yx+f6ZupaH/8SoD2+GME4k=;
        b=FbGPikzPZXOfeeuY8L91YpoXxE+4WFUMa/gcOZOqWoA3GAhTypmzkyZ8LLsHbjGmGP
         msNd3PGezXwIv99tyowLzNScjVLSzkwMahsfrmCwfXL4PB0gEf5F+dhLP3qxQBWsMLGV
         wpzDCSOcr678BSM1Vbf3T3W0mR5WYeZfdE381WnwwaaWCRrZlLbJ2rsnCMWqKdoBXdNX
         BOiTgVlfPJMRpYAA0sCIuZoZkFo+jzmtFjbMD2bWIpCsKSGi38bZmzdUQBuLvWhdjStd
         UVMA95In3DPsxGIQ83mZ6twxZYxArH5PfQ1emZIiMGiqMPJuWNJlRFINy+Sl9v2tMuPh
         VMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbx+lPZTTrggBCulpsTHtOXQ5FjE5+AEqq7otRPZV7twpeHvstrR1gOoiB4MbzlLOVyWQN1hfqMetg4pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys9R2E/4zvZciImFybujoNYcetr/Ke7xYfy72qDUKjJHn1gLfL
	ctmGWb1qPYjawWAfAfVY3XjQ9t07cmiE3pUL60F/Fbx4RTyJKOJSF8iE6WSJJfU3vB7jZMX57A=
	=
X-Google-Smtp-Source: AGHT+IG992kJ91SBgyRztXEp8ayRWD1xxYpYbjOHc4swJ2FjbvDWoErXzOXlzWzoeDsx/LEygczXUUjX
X-Received: from pjbqd5.prod.google.com ([2002:a17:90b:3cc5:b0:32e:6866:664])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f86:b0:32e:18b2:5a45
 with SMTP id 98e67ed59e1d1-32e18b25f33mr9160181a91.5.1757965953984; Mon, 15
 Sep 2025 12:52:33 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:51:51 +0000
In-Reply-To: <20250915195153.462039-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915195153.462039-1-fvdl@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915195153.462039-11-fvdl@google.com>
Subject: [RFC PATCH 10/12] mm/hugetlb: do explicit CMA balancing
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

CMA areas are normally not very large, but HugeTLB CMA is an
exception. hugetlb_cma, used for 'gigantic' pages (usually
1G), can take up many gigabytes of memory.

As such, it is potentially the largest source of 'false OOM'
conditions, situations where the kernel runs out of space
for unmovable allocations, because it can't allocate from
CMA pageblocks, and non-CMA memory has been tied up by
other movable allocations.

The normal use case of hugetlb_cma is a system where 1G
hugetlb pages are sometimes, but not always, needed, so
they need to be created and freed dynamically. As such,
the best time to address CMA memory imbalances is when CMA
hugetlb pages are freed, making multiples of 1G available
as buddy managed CMA pageblocks. That is a good time to
check if movable allocations fron non-CMA pageblocks should
be moved to CMA pageblocks to give the kernel more breathing
space.

Do this by calling balance_node_cma on either the hugetlb
CMA area for the node that just had its number of hugetlb
pages reduced, or for all hugetlb CMA areas if the reduction
was not node-specific.

To have the CMA balancing code act on the hugetlb CMA areas,
set the CMA_BALANCE flag when creating them.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/hugetlb.c     | 14 ++++++++------
 mm/hugetlb_cma.c | 16 ++++++++++++++++
 mm/hugetlb_cma.h |  5 +++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index eed59cfb5d21..611655876f60 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3971,12 +3971,14 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 
 		list_add(&folio->lru, &page_list);
 	}
-	/* free the pages after dropping lock */
-	spin_unlock_irq(&hugetlb_lock);
-	update_and_free_pages_bulk(h, &page_list);
-	flush_free_hpage_work(h);
-	spin_lock_irq(&hugetlb_lock);
-
+	if (!list_empty(&page_list)) {
+		/* free the pages after dropping lock */
+		spin_unlock_irq(&hugetlb_lock);
+		update_and_free_pages_bulk(h, &page_list);
+		flush_free_hpage_work(h);
+		hugetlb_cma_balance(nid);
+		spin_lock_irq(&hugetlb_lock);
+	}
 	while (count < persistent_huge_pages(h)) {
 		if (!adjust_pool_surplus(h, nodes_allowed, 1))
 			break;
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index 71d0e9a048d4..c0396d35b5bf 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -276,3 +276,19 @@ bool __init hugetlb_early_cma(struct hstate *h)
 
 	return hstate_is_gigantic(h) && hugetlb_cma_only;
 }
+
+void hugetlb_cma_balance(int nid)
+{
+	int node;
+
+	if (nid != NUMA_NO_NODE) {
+		if (hugetlb_cma[nid])
+			balance_node_cma(nid, hugetlb_cma[nid]);
+	} else {
+		for_each_online_node(node) {
+			if (hugetlb_cma[node])
+				balance_node_cma(node,
+						 hugetlb_cma[node]);
+		}
+	}
+}
diff --git a/mm/hugetlb_cma.h b/mm/hugetlb_cma.h
index f7d7fb9880a2..2f2a35b56d8a 100644
--- a/mm/hugetlb_cma.h
+++ b/mm/hugetlb_cma.h
@@ -13,6 +13,7 @@ bool hugetlb_cma_exclusive_alloc(void);
 unsigned long hugetlb_cma_total_size(void);
 void hugetlb_cma_validate_params(void);
 bool hugetlb_early_cma(struct hstate *h);
+void hugetlb_cma_balance(int nid);
 #else
 static inline void hugetlb_cma_free_folio(struct folio *folio)
 {
@@ -53,5 +54,9 @@ static inline bool hugetlb_early_cma(struct hstate *h)
 {
 	return false;
 }
+
+static inline void hugetlb_cma_balance(int nid)
+{
+}
 #endif
 #endif
-- 
2.51.0.384.g4c02a37b29-goog


