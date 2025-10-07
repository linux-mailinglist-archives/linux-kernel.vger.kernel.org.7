Return-Path: <linux-kernel+bounces-844239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0D7BC15B8
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B2619A187A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A482E0920;
	Tue,  7 Oct 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewOucYd8"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29772E03F2
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839652; cv=none; b=rueV2KD4IuTrKFurUwu1pGn+xWSJzbG521E8KgrCdpeaXWIAFkks5owjWSyyenEFsEUj5RzvKlEDZweT7Hv/Z0x69wuRtUxaxYogXBClyeg+hcwYg/Jl+Wd3hxHMHnmqfyZMjiQOIemw1zhK57EHPLdOkE4rDjJos0cOTMCLafQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839652; c=relaxed/simple;
	bh=6c2qdsekt/lCMkeMk65Hu+cWiGI0mmLXJB3D5AbXCc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsvyj/d01AWBnQLGIFlds8p2TJr31PM8IDPS5JG6OU+Y4Z3Pb1xvYMWP9aW70IUvD+WA3KK0BZXub8tW+sGh4Zo/+XtLAW4LkB61l9oddrBLhedSSPzZ0yaxGjXoRxZfHye/L/YSRipr0kq5QVVrNKfiVfGtx7u6WP1vFy3Xye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewOucYd8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5818de29d15so7671561e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839647; x=1760444447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynvmccn9zBZNQHviUDaoxb4f3kqsprve2CRTYJdnjMs=;
        b=ewOucYd8pLVdl7LNXWmufZOi0Z/1fWRhsZ9s5c6cXNZtj4UkDusccITiASWZ8Hn/T0
         nQ2tzOYvsquGQqQ4LcAsgAMg0OWpwL2FSKiQzxOaf2MNKQLtSoH4tuBpDpe5WpYS/Gi/
         yRcg7g18CrNAQ5XE5udgi3W5eeo86Ekz4JDBD+ciSasJtr3M1VSOfpYX6ZmdOJEHr5My
         bD2+yzKTJ/iGW+sFtTiG6lJcOslS64HA3ixrTKP5zUvn07IS5XgSaeI6NGzvVB4oFM3B
         VQoQcY8pbN23hKYTbsBg2Li6zRLOoMHOn1ef6j2nOAaqawQJsgt95+MU8lSTrFtr8zK8
         Czcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839647; x=1760444447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynvmccn9zBZNQHviUDaoxb4f3kqsprve2CRTYJdnjMs=;
        b=UXJwHe9LjwKgjXj0Wr0TMNbvXiCs1WY7zGj8oJZCEo8PA+usYHe5FoOIjxWdUJXMN3
         rxSTftvz3CEAMHdXGXCs5spesfXmGqYe5s04Ioys3iakPHtzbjs/DneLv5DbfnNSNRhu
         hSJrycsazHfvu5Gv5q037RCDVUBZV8W4fJGRfq5EAPPyiaFaxG3NK5+RZ8PBn55muSG1
         4Vyn9yusl/Xas4ocjhVv3x9co9F40GW9/mPrS0kYHGtpEkhEJOYqCI6TxTKnLm4XvACM
         2RMrtJcATa9/T69FzabUCw08TPcZRrAsBZSfZaTA461gLMRnhcDuFrLePiz16w9WXxx2
         SI/A==
X-Forwarded-Encrypted: i=1; AJvYcCUG2e4etT3jj4nH8V7RYCiJvEn7gQOjI5GkzZ8VYJBi35yl0oYS7hzwk1xCJkUcK0j5lmU3yK+SVsbCMeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJFRZcTPoLPktedf0caU7+oYsO3P3jmGONudHOddvt9czkwcfw
	i9o/LEXzYyIJFOeJDJO1lnOqowLD1WLnw6RZONEffqwmGG1srZo88duY
X-Gm-Gg: ASbGncvuOMRyc4DiCFUdL/l+0TrtKtZu449aZ1zNQxgX1TBEZdzp6ycGLUVhaLEzx1w
	jdlmbP6n8LS2fwL8IHaCHiQaOz1FGntO9xgsVDZdq8FS8flHjwtppv+hq4quS0QSrTJfv4Vvz+M
	2wfVHuKGOjOM/yK0GhFJlPLKRe6yhaFuSEDbEVwKF+Jhas4IjH3EaRRfTGERgmawubRZ7/CiC2m
	vzCB3vKRKihuPZuZ15ez/eJ9IPsttmwNyVOI7yjP3/DYSLOrwk0+0UpQU7BIbyKW0m4RXc2myfI
	9qcyRnEfL4u/XU//CicAcn3YkTBrW7UkVLA89M7dwziLUSjl1v5T7yzfVsw4ELUJfQngO9HUzDT
	zYpJhsIJrTNo/QxBjoWaUiLWTD0V4WAd56J5suzR7rK1gMoa/SIY=
X-Google-Smtp-Source: AGHT+IH105Fru7ZMF2Ka/VGHrM+Or9jg6datvNtRkYwVYlEhOQfeSumqPhNLqAFC6JxvJR07P3hoyQ==
X-Received: by 2002:a05:6512:3d10:b0:57b:234f:52ba with SMTP id 2adb3069b0e04-58cbbbee6d7mr4848584e87.39.1759839646916;
        Tue, 07 Oct 2025 05:20:46 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01141151sm6061947e87.59.2025.10.07.05.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:20:46 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>
Subject: [PATCH v4 07/10] kmsan: Remove hard-coded GFP_KERNEL flags
Date: Tue,  7 Oct 2025 14:20:32 +0200
Message-ID: <20251007122035.56347-8-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007122035.56347-1-urezki@gmail.com>
References: <20251007122035.56347-1-urezki@gmail.com>
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
index f2fd221107bb..7da9fd506b39 100644
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
@@ -347,7 +349,7 @@ static inline void kmsan_kfree_large(const void *ptr)
 
 static inline int __must_check kmsan_vmap_pages_range_noflush(
 	unsigned long start, unsigned long end, pgprot_t prot,
-	struct page **pages, unsigned int page_shift)
+	struct page **pages, unsigned int page_shift, gfp_t gfp_mask)
 {
 	return 0;
 }
diff --git a/mm/internal.h b/mm/internal.h
index 1561fc2ff5b8..e623c8103358 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1355,7 +1355,7 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 #ifdef CONFIG_MMU
 void __init vmalloc_init(void);
 int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-                pgprot_t prot, struct page **pages, unsigned int page_shift);
+	pgprot_t prot, struct page **pages, unsigned int page_shift, gfp_t gfp_mask);
 unsigned int get_vm_area_page_order(struct vm_struct *vm);
 #else
 static inline void vmalloc_init(void)
@@ -1364,7 +1364,7 @@ static inline void vmalloc_init(void)
 
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
index d8bcd87239b5..d7e7049e01f8 100644
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
@@ -3839,8 +3847,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
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


