Return-Path: <linux-kernel+bounces-817074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6CCB57DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DE43A2503
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297F8322DC0;
	Mon, 15 Sep 2025 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RumgNqet"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167B331D75F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943654; cv=none; b=tcWkfjIqp8TtAy02tbE79sPtxdI+1dhiyDEyuVx/0C1nZxSUxe4jbEtycb1niCsnSPlbE+247Dk3oYYenJBQeA12pobsBnmbyysHwXQAkNattfbhuqGbBo2cMDqiOit3RFRKJwfaI43XRZMU/z28IPcVEFbbR55KNeIjXC2AfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943654; c=relaxed/simple;
	bh=R22Tn1GxXynVgGcZZtmj6j+HXED5mHvsvsc3jdyA2XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbfufMbO1QSIGKU5qQCLmztwPMRSEPxc2XgOVAK2oD6H3clGCXCmPB5carDd2rE6kGU7N+3BOKvaSab/bi4VHax6s5lyREj89LIzIArxaU29/lGVlm446DlhJFrwKaDJKqSaUOSM3TpVxiFs2GVc5C7P+tYAJ7As0fGlXLJ+/68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RumgNqet; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5608b619cd8so5187127e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757943650; x=1758548450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cxhy1CjTE1SRKEDgpZBn3ZyvPt/a9+eTb0usq/BEmN4=;
        b=RumgNqetHI7lQll08UXRRRq9ZNz7FeCKHunzN7Z6fBTF3YNAKiPCEfym2hiUWJbYeE
         cZXhsXqPgJFVPZjs0fg5BFieVgVWl2zpUPPTtdlWZQyQSVJ++jLsEFxzs0wL/5IQdpjR
         BIZs6q9a311XFTgfIBrZza3p+CDdpf7Ds0jEOVrUOnKlHc72xyMaQXZmC+esGqUzCqjf
         iF3i1Hc4k01ntRVKhJxvBOmS7agoKRhldWHlbcjWRXqWH88lkN5msQF/cqqM0UX4QBvc
         Y2aLcjOu/CKPYNZ2A4QdfXl26mnK62W0ihTkyVRkmUuPpCOe2cMHTOhulS6+Ln6AYvCs
         mL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943650; x=1758548450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cxhy1CjTE1SRKEDgpZBn3ZyvPt/a9+eTb0usq/BEmN4=;
        b=tpvXMiwY3T54ZRIBA91MXuPDLdHZaKK9bs13kJ7Vbd7nLoG3KqTvrYLcEa2+X69FIf
         2pElHix7s4UvydgmEvJME+KZFCucmVOq54yLRHyWumkM6xRJZ6fOFP/gzxY5enUIFqZB
         Waa/PpFCIstt7u76C9XvmlEnFg53n7QaYNIMkQg3UcrBxCd5HFL673ad/rkCbTxsjpRk
         9Lp/CX17x3bQ2GXCXxYzfoAJxoN2R3mnx597/6NJY4AwykblLDg3H3y+BZgdg+gpPd3/
         k2Ts3rFrqHu+qJ8N0rG4NxQXXb9UuYgF21EUiJH8V45KXjy2nNDJ6JTOqFEp/M9cwtZx
         JeaA==
X-Forwarded-Encrypted: i=1; AJvYcCUe9UOdS9SZsw1aa4+juEwqUtV9Mf5wzw3Y0tJHceVWC7f8s9r2lTJ89aV1Lw/atm68s1hDrxOIIztyxOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhmDlEwD2ndcEV2gPTdQl6Sde8eGwEoCpQnHqbQ938qnPbqpRQ
	63JI7DVCdC0lsEizps/+qaTAL3GJuPuysbieCfKGPhnausK4xR/HRsmH
X-Gm-Gg: ASbGncurppEqcBLOkgVoSxSVE98NiYl8dzjrxUl3UOBVs1TT89O/cN6lL3vx5lv/y6+
	zyCGbyEwJo6tdoEU5/TMcEvQwCzAKtGusJl5gGNT4zGyg5pO2kW0/cFGhzSP24NvwL2lCl7yP+P
	HvqZkNyEMKuqVM4ZbEBHjt6IeZPcll1+vm8ikkTMfnUAIlpGoSHIa9asS4DikcTMjTPWu5SYQu0
	2nyaTi4B3qFxkLefcxM0y1lG61QaWde3eDA/jL0FkYMu5JQYt8SFJ/gYv8X+HKaawU+VNkKKuUs
	V7Ec+vB0pXcOupROHwWt0IYpeKHUPZ8DIFJLPmEQizIe0nitL2UsvMss9b1m6aIm4BJX3ntg1Or
	WkGTPzLnX1IhvgaHPhLKrxjTL4xQ=
X-Google-Smtp-Source: AGHT+IGmRNj1PuGI3ccv6PqCAdUWydP8EuQ817wuW4eDhXwFm+h94+/q66fitzQ60Lp8WCMHShUitw==
X-Received: by 2002:ac2:4ca9:0:b0:55f:53fd:e2fe with SMTP id 2adb3069b0e04-5704aa9fff7mr3152235e87.3.1757943649990;
        Mon, 15 Sep 2025 06:40:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-573c8330e54sm1150719e87.63.2025.09.15.06.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 06:40:49 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>
Subject: [PATCH v2 08/10] kmsan: Remove hard-coded GFP_KERNEL flags
Date: Mon, 15 Sep 2025 15:40:38 +0200
Message-ID: <20250915134041.151462-9-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250915134041.151462-1-urezki@gmail.com>
References: <20250915134041.151462-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmsan_vmap_pages_range_noflush() allocates its temp s_pages/o_pages
arrays with GFP_KERNEL, which may sleep. This is inconsistent with
vmalloc() as it will support non-blocking requests later.

Plumb gfp_mask through the kmsan_vmap_pages_range_noflush(), so it
can use it internally for its demand.

Please note, the subsequent __vmap_pages_range_noflush() still uses
GFP_KERNEL and can sleep. If a caller runs under reclaim constraints,
sleeping is forbidden, it must establish the appropriate memalloc
scope API.

Cc: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/kmsan.h |  6 ++++--
 mm/internal.h         |  4 ++--
 mm/kmsan/shadow.c     |  6 +++---
 mm/percpu-vm.c        |  2 +-
 mm/vmalloc.c          | 26 +++++++++++++++++---------
 5 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index 2b1432cc16d5..e4b34e7a3b11 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -133,6 +133,7 @@ void kmsan_kfree_large(const void *ptr);
  * @prot:	page protection flags used for vmap.
  * @pages:	array of pages.
  * @page_shift:	page_shift passed to vmap_range_noflush().
+ * @gfp_mask:	gfp_mask to use internally.
  *
  * KMSAN maps shadow and origin pages of @pages into contiguous ranges in
  * vmalloc metadata address range. Returns 0 on success, callers must check
@@ -142,7 +143,8 @@ int __must_check kmsan_vmap_pages_range_noflush(unsigned long start,
 						unsigned long end,
 						pgprot_t prot,
 						struct page **pages,
-						unsigned int page_shift);
+						unsigned int page_shift,
+						gfp_t gfp_mask);
 
 /**
  * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
@@ -348,7 +350,7 @@ static inline void kmsan_kfree_large(const void *ptr)
 
 static inline int __must_check kmsan_vmap_pages_range_noflush(
 	unsigned long start, unsigned long end, pgprot_t prot,
-	struct page **pages, unsigned int page_shift)
+	struct page **pages, unsigned int page_shift, gfp_t gfp_mask)
 {
 	return 0;
 }
diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc03..5f3486c1cb83 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1359,7 +1359,7 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 #ifdef CONFIG_MMU
 void __init vmalloc_init(void);
 int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-                pgprot_t prot, struct page **pages, unsigned int page_shift);
+	pgprot_t prot, struct page **pages, unsigned int page_shift, gfp_t gfp_mask);
 unsigned int get_vm_area_page_order(struct vm_struct *vm);
 #else
 static inline void vmalloc_init(void)
@@ -1368,7 +1368,7 @@ static inline void vmalloc_init(void)
 
 static inline
 int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-                pgprot_t prot, struct page **pages, unsigned int page_shift)
+	pgprot_t prot, struct page **pages, unsigned int page_shift, gfp_t gfp_mask)
 {
 	return -EINVAL;
 }
diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 54f3c3c962f0..3cd733663100 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -215,7 +215,7 @@ void kmsan_free_page(struct page *page, unsigned int order)
 
 int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
 				   pgprot_t prot, struct page **pages,
-				   unsigned int page_shift)
+				   unsigned int page_shift, gfp_t gfp_mask)
 {
 	unsigned long shadow_start, origin_start, shadow_end, origin_end;
 	struct page **s_pages, **o_pages;
@@ -230,8 +230,8 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
 		return 0;
 
 	nr = (end - start) / PAGE_SIZE;
-	s_pages = kcalloc(nr, sizeof(*s_pages), GFP_KERNEL);
-	o_pages = kcalloc(nr, sizeof(*o_pages), GFP_KERNEL);
+	s_pages = kcalloc(nr, sizeof(*s_pages), gfp_mask);
+	o_pages = kcalloc(nr, sizeof(*o_pages), gfp_mask);
 	if (!s_pages || !o_pages) {
 		err = -ENOMEM;
 		goto ret;
diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index cd69caf6aa8d..4f5937090590 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -194,7 +194,7 @@ static int __pcpu_map_pages(unsigned long addr, struct page **pages,
 			    int nr_pages)
 {
 	return vmap_pages_range_noflush(addr, addr + (nr_pages << PAGE_SHIFT),
-					PAGE_KERNEL, pages, PAGE_SHIFT);
+			PAGE_KERNEL, pages, PAGE_SHIFT, GFP_KERNEL);
 }
 
 /**
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5e01c6ac4aca..2d4e22dd04f7 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -671,16 +671,28 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 }
 
 int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-		pgprot_t prot, struct page **pages, unsigned int page_shift)
+		pgprot_t prot, struct page **pages, unsigned int page_shift,
+		gfp_t gfp_mask)
 {
 	int ret = kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
-						 page_shift);
+						page_shift, gfp_mask);
 
 	if (ret)
 		return ret;
 	return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
 }
 
+static int __vmap_pages_range(unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, unsigned int page_shift,
+		gfp_t gfp_mask)
+{
+	int err;
+
+	err = vmap_pages_range_noflush(addr, end, prot, pages, page_shift, gfp_mask);
+	flush_cache_vmap(addr, end);
+	return err;
+}
+
 /**
  * vmap_pages_range - map pages to a kernel virtual address
  * @addr: start of the VM area to map
@@ -696,11 +708,7 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 int vmap_pages_range(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
-	int err;
-
-	err = vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
-	flush_cache_vmap(addr, end);
-	return err;
+	return __vmap_pages_range(addr, end, prot, pages, page_shift, GFP_KERNEL);
 }
 
 static int check_sparse_vm_area(struct vm_struct *area, unsigned long start,
@@ -3838,8 +3846,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	 */
 	flags = memalloc_apply_gfp_scope(gfp_mask);
 	do {
-		ret = vmap_pages_range(addr, addr + size, prot, area->pages,
-			page_shift);
+		ret = __vmap_pages_range(addr, addr + size, prot, area->pages,
+				page_shift, nested_gfp);
 		if (nofail && (ret < 0))
 			schedule_timeout_uninterruptible(1);
 	} while (nofail && (ret < 0));
-- 
2.47.3


