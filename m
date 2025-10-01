Return-Path: <linux-kernel+bounces-839425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2859CBB197A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EDDB7B17D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD71D303C9E;
	Wed,  1 Oct 2025 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aThPFWWJ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048652FDC59
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346818; cv=none; b=rp/nt4xWnIlc5VZ0DXeVbOr4/zVZbaFVNnQ+kLSIGo5uMyo7mOgCAFMRTiqIrCai057YOwfqIGR+YppWEN9t9klhgCnDiEjQXV3/rDXDS1M6BZHUSvglzF5u2GeNAgUIdoMpqUrHn+PzZpIQHYtvD8jyMwj9stM05rlRw8rLQmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346818; c=relaxed/simple;
	bh=6c2qdsekt/lCMkeMk65Hu+cWiGI0mmLXJB3D5AbXCc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U14neCg74vwNQY893x6vsgyB6ZtJ6n4TkQYu9jbuk2nQnt15WbBfr9bBuwmqcqxLjk2iXReluVfrfNds7Obo0I2mQysppR5AZdGQgwQL6MnbOwB0Fr/gI0WiS/tS7TSpOCm7fFYkk/GJzaEdGadi2BcOmWYmJ0tufwP4D+nLFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aThPFWWJ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57da66e0dc9so225508e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759346815; x=1759951615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynvmccn9zBZNQHviUDaoxb4f3kqsprve2CRTYJdnjMs=;
        b=aThPFWWJ0TtS/rJuTTDvg70HPpGwThNq+hs8BgGxyItCzqqIIyjer/5++9c4hy2y6D
         2Q6C1Muk6DsBM7lrB1zgolDQpbf7+WGYcgtXp8xWmJ6tBkxeGXY5jYRib6kc2x1I+u12
         o7s+PoXbnPni/Vuq/hw44IERX4Qvgy1ZGdHu1qz0T68VCfz87lxi/CpxMXRErJoPJOcd
         +0e5gjcOeiFnmzoh2iH1Tq3qq94rmmXSGiDNhWsAgR7SGx1GYAiLoMOpnKPr5UIWjtV7
         y4KEV81noh/Tu/qQWSzfmqQYLm3aqy4fBc7BQrCIIHQ029Na+C4jGIe8xPC69qzhQYUq
         jEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346815; x=1759951615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynvmccn9zBZNQHviUDaoxb4f3kqsprve2CRTYJdnjMs=;
        b=HZatfvGqnBiy2CJGYXxc/8LYsIiXGKi6k0CNWRPcw7sW+26OGOueJzsoj5U+J9ECu8
         9ZzzAkFD8ZSGFtkVdBks3ktF+qlVFlxUS0TgkcariLjGonZNwTbhtLnLteg1VcF3HKJ6
         jMjatL2kzTNh1Bxy4jYTALeVn2pWI98o4DFGb+7m827qfRqjClOchYtKTi3yG5nBbvud
         RTyf+8KMQBffMoP1bKZBUuTzVbMuNb0e3ShoLIqvGlPqa/XcISYmi2H0wRh3qOyZeu9G
         r3RCYBTx4NI6NlqJtXoH0TuBHg3O6en0k/eo17lrm0qpAgdtBJoHVtD8s5LppHz8Cfzy
         eJvw==
X-Forwarded-Encrypted: i=1; AJvYcCXimfAF62Ej3ideGD+Vy8vau97NFoHnh+j5hcReWomA9BCk/0RTfEum8GMyaJ99glClMrH6dEEbCV4d/xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNQnnf5xTpKaAu7iPApeGk4rITudXsx+egyUZDDDf3MO+PyOQk
	dA5bzqkpRQB6ThQAd6h+NuJA4U7SJ1mn/xtjmnH3AAeto05AJoD4MEPe
X-Gm-Gg: ASbGnctEsJ664/MOceVRqd6AtvbERqUX+zTokhF/MU69BvKwnO6cwaWrisZvMDJV/cV
	h5q80e0u1v/hiwd11bZecosDNvKBsOfj/n/y6cLeaby3apc1nmuIjbNsVb6vuqJ2ks11gZDlDIC
	OkAkAuYJnltgYh2tSKS0ydUDqtOjMNl7uwFf7S4JaDcGndSMLin6JSCiDJaHEP+cnSuPgoN8LVi
	NdguYXoxIBlKWsRQVT47hJpkegkDgTG5M6R2ud8ql3N8axJexDDbwf/W0t0XIQD0qwuCh3rwk2y
	J89n4Nh/SGDAmMUqHGdlFVPwL0hPtjKadegk7vqslUexH/uLZ1TizrP3EsomCIB9YHDjxTr9PDr
	Yac/ltJYVFPboHhAj++OKbFwlyb+bLlsquiGzbz6v
X-Google-Smtp-Source: AGHT+IEdomr7Qvfls97HYRBk5Mx/YGp7v9+/XeOoVOqM7iGX9Gve8C9BG6twnSsknG3MVOR88kGX0g==
X-Received: by 2002:a05:6512:31d4:b0:578:9b92:75c7 with SMTP id 2adb3069b0e04-58af9ebced0mr1554547e87.7.1759346815008;
        Wed, 01 Oct 2025 12:26:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112414fsm136627e87.28.2025.10.01.12.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:26:54 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>
Subject: [PATCH v3 07/10] kmsan: Remove hard-coded GFP_KERNEL flags
Date: Wed,  1 Oct 2025 21:26:43 +0200
Message-ID: <20251001192647.195204-8-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001192647.195204-1-urezki@gmail.com>
References: <20251001192647.195204-1-urezki@gmail.com>
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


