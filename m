Return-Path: <linux-kernel+bounces-817701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0EBB58581
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1898F208457
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275B6289340;
	Mon, 15 Sep 2025 19:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHuXKrik"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B742882B8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965945; cv=none; b=DJ2Kl/hlrgKyLMreD8VDgDBEXOwLMEdLT1CscNjwI5kT7PXpo4UV15CExka7uj4VXnneop+3yM6RUg8e2H7BBBMLiZlYCcWprqeaXl6RTqM+lPmqhVjqZZYw1NBlKzWmVOG3AeVrIk3YwrWv7OxI5j6o0mH/FN71It6P4EWVxHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965945; c=relaxed/simple;
	bh=3gg4p0LDgZ0ieUbl39w5am8jTt2SlSCj2wL15/ELYY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OymEQf7HeM/4C1oCHdwq0E1iMWjuweQis//L7PKC+2jPyR9CPfuTnZGRzkg3RTXNEwcyk161iJ6V2plyt0Ks1a3S8Bb1Ix89cbQs9UG5QfiBJXBJQOPktoiQaM7v4k5SWUsmP+eDOeEUxfGIlJ6rvnyrQbyVJZUf0CzJijyXA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OHuXKrik; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-25d21fddb85so63626655ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757965942; x=1758570742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCTw8mMhgOWN3pIIBb2gy+S0Zzj+AR1Jz+wSOMeCQlc=;
        b=OHuXKrikFPdHIJZJO3ZkVYNJ6zoycJlBKKri0/3fSIGdNzz+MzXcwSUCWoehUUPOTI
         qpsZkplJsBqbrqw9CvhHcAiHQ3yRsff/ts/ioAf6n6t2D82KyrOO1LAqgndWlZONRTjM
         EsMhpXLsFB4mQSpb3+clZSCyO/rMb+FvbhK3FcFcAPJBV13ngFHkHdXcnJcr1xriA00m
         l8VoM5eafsxngarcL/yQx3oXzu3h1lYcC0cthXUhfMK5bEkwJyc8F9KzC71CUsPCbFxU
         6ZPC8A+9YhFiuDUgo4eK6PV7UWwitxW+dZP7sT6uugyDNGDHtk1XneTJaNC2UYIhO1+g
         uymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965942; x=1758570742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCTw8mMhgOWN3pIIBb2gy+S0Zzj+AR1Jz+wSOMeCQlc=;
        b=K/91aI2280T/NYvxXreas1F/y/aKbDISrg1YABsxE1PjFGJTXIzZgZdv6kjD18y1qJ
         9u5pd4N0E2mCtzTjwXeAhuW6vuNgu3XCHP7Yj7MIkXoYQw3qHl9jlp/wwLewbR/fyBpP
         IzWuybURj76uh/A2F/O4ySwBt3am37aR3b6qe2RsFGgVx48VqPmfTOeWl6F/nDwP1aFJ
         KHW29NG5e0NIhsZ0kTQhd3QHZh6pvztlObcSIG+uPH4tf7FWWD6Bf3CAbVusbTycEDMw
         NuN8PDAWkH/2Mkc1zJrgyT06C6Kh1NBMnVi7LAIUt96ECcswih59FTcCVaMcDYL1kkec
         pTRA==
X-Forwarded-Encrypted: i=1; AJvYcCX2M5waBtBCSCjipA8NHU+vBAl/Smy2PvNXBgoLMpelTCIC6bMe0kKZdOEPiizhJim636Sk3KciK2SYHjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydLQjFvr7ifguPOX8z0qb2NYf5ZQFfKOuDYcOS2S4dHl9OSKtq
	cgDpKyF876m6koS7CoxrIU/VGhQntUCnB4R1ijjmdfGE7lzfQTNzDZ1KYbOuOGHBdMBaHemDLw=
	=
X-Google-Smtp-Source: AGHT+IGswRfPvIKTnjtI+zMkN8y9+vmlGysmny2W+PeHbqNy2QPIL4i0nZkeiDjM4ghnJMXDuajKx5Z0
X-Received: from pjbpd11.prod.google.com ([2002:a17:90b:1dcb:b0:32e:73f6:ef02])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b0c:b0:250:411d:fa83
 with SMTP id d9443c01a7336-25d248c991amr137402865ad.15.1757965942499; Mon, 15
 Sep 2025 12:52:22 -0700 (PDT)
Date: Mon, 15 Sep 2025 19:51:44 +0000
In-Reply-To: <20250915195153.462039-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915195153.462039-1-fvdl@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915195153.462039-4-fvdl@google.com>
Subject: [RFC PATCH 03/12] mm/cma: add flags argument to init functions
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a flags argument to the various CMA init functions, as
there will be a need to pass in more flags to control init
and runtime behavior other than just the current 'fixed'
argument.

Replace the fixed argument with a flags argument, and adapt
callers.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 arch/powerpc/kernel/fadump.c         |  2 +-
 arch/powerpc/kvm/book3s_hv_builtin.c |  2 +-
 drivers/s390/char/vmcp.c             |  2 +-
 include/linux/cma.h                  | 20 ++++++++++------
 kernel/dma/contiguous.c              | 10 ++++----
 mm/cma.c                             | 36 ++++++++++++++++++----------
 mm/hugetlb_cma.c                     |  2 +-
 7 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 5782e743fd27..a763419bd1bc 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -112,7 +112,7 @@ void __init fadump_cma_init(void)
 		return;
 	}
 
-	rc = cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump_cma);
+	rc = cma_init_reserved_mem(base, size, 0, 0, "fadump_cma", &fadump_cma);
 	if (rc) {
 		pr_err("Failed to init cma area for firmware-assisted dump,%d\n", rc);
 		/*
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index fa0e3a22cac0..23dcb67e797a 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -95,7 +95,7 @@ void __init kvm_cma_reserve(void)
 			 (unsigned long)selected_size / SZ_1M);
 		align_size = HPT_ALIGN_PAGES << PAGE_SHIFT;
 		cma_declare_contiguous(0, selected_size, 0, align_size,
-			KVM_CMA_CHUNK_ORDER - PAGE_SHIFT, false, "kvm_cma",
+			KVM_CMA_CHUNK_ORDER - PAGE_SHIFT, 0, "kvm_cma",
 			&kvm_cma);
 	}
 }
diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index 69899bb86b3e..cd0c0edc496b 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -54,7 +54,7 @@ void __init vmcp_cma_reserve(void)
 {
 	if (!machine_is_vm())
 		return;
-	cma_declare_contiguous(0, vmcp_cma_size, 0, 0, 0, false, "vmcp", &vmcp_cma);
+	cma_declare_contiguous(0, vmcp_cma_size, 0, 0, 0, 0, "vmcp", &vmcp_cma);
 }
 
 static void vmcp_response_alloc(struct vmcp_session *session)
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 5c3fdc5da908..ec48f2a11f1d 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -25,12 +25,16 @@ enum cma_flags {
 	__CMA_ZONES_VALID,
 	__CMA_ZONES_INVALID,
 	__CMA_ACTIVATED,
+	__CMA_FIXED,
 };
 
 #define CMA_RESERVE_PAGES_ON_ERROR	BIT(__CMA_RESERVE_PAGES_ON_ERROR)
 #define CMA_ZONES_VALID			BIT(__CMA_ZONES_VALID)
 #define CMA_ZONES_INVALID		BIT(__CMA_ZONES_INVALID)
 #define CMA_ACTIVATED			BIT(__CMA_ACTIVATED)
+#define CMA_FIXED			BIT(__CMA_FIXED)
+
+#define CMA_INIT_FLAGS (CMA_FIXED|CMA_RESERVE_PAGES_ON_ERROR)
 
 struct cma;
 
@@ -42,23 +46,25 @@ extern const char *cma_get_name(const struct cma *cma);
 extern int __init cma_declare_contiguous_nid(phys_addr_t base,
 			phys_addr_t size, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
-			bool fixed, const char *name, struct cma **res_cma,
-			int nid);
+			unsigned long flags, const char *name,
+			struct cma **res_cma, int nid);
 static inline int __init cma_declare_contiguous(phys_addr_t base,
 			phys_addr_t size, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
-			bool fixed, const char *name, struct cma **res_cma)
+			unsigned long flags, const char *name,
+			struct cma **res_cma)
 {
 	return cma_declare_contiguous_nid(base, size, limit, alignment,
-			order_per_bit, fixed, name, res_cma, NUMA_NO_NODE);
+			order_per_bit, flags, name, res_cma, NUMA_NO_NODE);
 }
 extern int __init cma_declare_contiguous_multi(phys_addr_t size,
 			phys_addr_t align, unsigned int order_per_bit,
-			const char *name, struct cma **res_cma, int nid);
+			unsigned long flags, const char *name,
+			struct cma **res_cma, int nid);
 extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					unsigned int order_per_bit,
-					const char *name,
-					struct cma **res_cma);
+					unsigned long flags,
+					const char *name, struct cma **res_cma);
 extern struct page *cma_alloc(struct cma *cma, unsigned long count, unsigned int align,
 			      bool no_warn);
 extern bool cma_pages_valid(struct cma *cma, const struct page *pages, unsigned long count);
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index d9b9dcba6ff7..7f2eed3b7cc5 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -175,7 +175,7 @@ static void __init dma_numa_cma_reserve(void)
 			cma = &dma_contiguous_pernuma_area[nid];
 			snprintf(name, sizeof(name), "pernuma%d", nid);
 			ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
-							 0, false, name, cma, nid);
+							 0, 0, name, cma, nid);
 			if (ret)
 				pr_warn("%s: reservation failed: err %d, node %d", __func__,
 					ret, nid);
@@ -185,7 +185,7 @@ static void __init dma_numa_cma_reserve(void)
 
 			cma = &dma_contiguous_numa_area[nid];
 			snprintf(name, sizeof(name), "numa%d", nid);
-			ret = cma_declare_contiguous_nid(0, numa_cma_size[nid], 0, 0, 0, false,
+			ret = cma_declare_contiguous_nid(0, numa_cma_size[nid], 0, 0, 0, 0,
 							 name, cma, nid);
 			if (ret)
 				pr_warn("%s: reservation failed: err %d, node %d", __func__,
@@ -279,7 +279,8 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 {
 	int ret;
 
-	ret = cma_declare_contiguous(base, size, limit, 0, 0, fixed,
+	ret = cma_declare_contiguous(base, size, limit, 0, 0,
+					fixed ? CMA_FIXED : 0,
 					"reserved", res_cma);
 	if (ret)
 		return ret;
@@ -478,7 +479,8 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 		return -EINVAL;
 	}
 
-	err = cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name, &cma);
+	err = cma_init_reserved_mem(rmem->base, rmem->size, 0, 0, rmem->name,
+				    &cma);
 	if (err) {
 		pr_err("Reserved memory: unable to setup CMA region\n");
 		return err;
diff --git a/mm/cma.c b/mm/cma.c
index 549d85b2e3a3..00d8d365f0b5 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -35,6 +35,7 @@
 
 struct cma cma_areas[MAX_CMA_AREAS];
 unsigned int cma_area_count;
+static DEFINE_MUTEX(cma_mutex);
 
 phys_addr_t cma_get_base(const struct cma *cma)
 {
@@ -215,7 +216,7 @@ void __init cma_reserve_pages_on_error(struct cma *cma)
 }
 
 static int __init cma_new_area(const char *name, phys_addr_t size,
-			       unsigned int order_per_bit,
+			       unsigned int order_per_bit, unsigned long flags,
 			       struct cma **res_cma)
 {
 	struct cma *cma;
@@ -239,6 +240,7 @@ static int __init cma_new_area(const char *name, phys_addr_t size,
 
 	cma->available_count = cma->count = size >> PAGE_SHIFT;
 	cma->order_per_bit = order_per_bit;
+	cma->flags = flags;
 	*res_cma = cma;
 	totalcma_pages += cma->count;
 
@@ -265,7 +267,7 @@ static void __init cma_drop_area(struct cma *cma)
  */
 int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 				 unsigned int order_per_bit,
-				 const char *name,
+				 unsigned long flags, const char *name,
 				 struct cma **res_cma)
 {
 	struct cma *cma;
@@ -288,7 +290,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
 		return -EINVAL;
 
-	ret = cma_new_area(name, size, order_per_bit, &cma);
+	ret = cma_new_area(name, size, order_per_bit, flags, &cma);
 	if (ret != 0)
 		return ret;
 
@@ -429,12 +431,18 @@ static phys_addr_t __init cma_alloc_mem(phys_addr_t base, phys_addr_t size,
 static int __init __cma_declare_contiguous_nid(phys_addr_t *basep,
 			phys_addr_t size, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
-			bool fixed, const char *name, struct cma **res_cma,
-			int nid)
+			unsigned long flags, const char *name,
+			struct cma **res_cma, int nid)
 {
 	phys_addr_t memblock_end = memblock_end_of_DRAM();
 	phys_addr_t base = *basep;
 	int ret;
+	bool fixed;
+
+	if (flags & ~CMA_INIT_FLAGS)
+		return -EINVAL;
+
+	fixed = (flags & CMA_FIXED);
 
 	pr_debug("%s(size %pa, base %pa, limit %pa alignment %pa)\n",
 		__func__, &size, &base, &limit, &alignment);
@@ -503,7 +511,8 @@ static int __init __cma_declare_contiguous_nid(phys_addr_t *basep,
 		kmemleak_ignore_phys(base);
 	}
 
-	ret = cma_init_reserved_mem(base, size, order_per_bit, name, res_cma);
+	ret = cma_init_reserved_mem(base, size, order_per_bit, flags,
+				    name, res_cma);
 	if (ret) {
 		memblock_phys_free(base, size);
 		return ret;
@@ -526,7 +535,8 @@ static int __init __cma_declare_contiguous_nid(phys_addr_t *basep,
  */
 int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 			phys_addr_t align, unsigned int order_per_bit,
-			const char *name, struct cma **res_cma, int nid)
+			unsigned long flags, const char *name,
+			struct cma **res_cma, int nid)
 {
 	phys_addr_t start = 0, end;
 	phys_addr_t size, sizesum, sizeleft;
@@ -543,7 +553,7 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 	 * First, try it the normal way, producing just one range.
 	 */
 	ret = __cma_declare_contiguous_nid(&start, total_size, 0, align,
-			order_per_bit, false, name, res_cma, nid);
+			order_per_bit, flags, name, res_cma, nid);
 	if (ret != -ENOMEM)
 		goto out;
 
@@ -567,7 +577,7 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 	sizesum = 0;
 	failed = NULL;
 
-	ret = cma_new_area(name, total_size, order_per_bit, &cma);
+	ret = cma_new_area(name, total_size, order_per_bit, flags, &cma);
 	if (ret != 0)
 		goto out;
 
@@ -716,7 +726,7 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
  * @limit: End address of the reserved memory (optional, 0 for any).
  * @alignment: Alignment for the CMA area, should be power of 2 or zero
  * @order_per_bit: Order of pages represented by one bit on bitmap.
- * @fixed: hint about where to place the reserved area
+ * @flags: flags controlling various aspects of the area
  * @name: The name of the area. See function cma_init_reserved_mem()
  * @res_cma: Pointer to store the created cma region.
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
@@ -732,13 +742,13 @@ int __init cma_declare_contiguous_multi(phys_addr_t total_size,
 int __init cma_declare_contiguous_nid(phys_addr_t base,
 			phys_addr_t size, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
-			bool fixed, const char *name, struct cma **res_cma,
-			int nid)
+			unsigned long flags, const char *name,
+			struct cma **res_cma, int nid)
 {
 	int ret;
 
 	ret = __cma_declare_contiguous_nid(&base, size, limit, alignment,
-			order_per_bit, fixed, name, res_cma, nid);
+			order_per_bit, flags, name, res_cma, nid);
 	if (ret != 0)
 		pr_err("Failed to reserve %ld MiB\n",
 				(unsigned long)size / SZ_1M);
diff --git a/mm/hugetlb_cma.c b/mm/hugetlb_cma.c
index f58ef4969e7a..71d0e9a048d4 100644
--- a/mm/hugetlb_cma.c
+++ b/mm/hugetlb_cma.c
@@ -221,7 +221,7 @@ void __init hugetlb_cma_reserve(int order)
 		 * huge page demotion.
 		 */
 		res = cma_declare_contiguous_multi(size, PAGE_SIZE << order,
-					HUGETLB_PAGE_ORDER, name,
+					HUGETLB_PAGE_ORDER, 0, name,
 					&hugetlb_cma[nid], nid);
 		if (res) {
 			pr_warn("hugetlb_cma: reservation failed: err %d, node %d",
-- 
2.51.0.384.g4c02a37b29-goog


