Return-Path: <linux-kernel+bounces-758789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52097B1D3D7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25843BEFD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490A925A328;
	Thu,  7 Aug 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSHeT49/"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45615246BB7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553502; cv=none; b=NH3E2CpalOTk8NNo+QnylO05jzIpeR+NxvjQr2PbTGC7ScNoFhxbETMPBsTr3741O8rldjzRljRntgWXHY4+p61kdjjJEs2XSJCC5uqZVn0gVkofREVXzcETuTmyN7hRbITqAuA7b421H2rDFKEBc3yqqrNJmUGcejwWIwpY18g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553502; c=relaxed/simple;
	bh=iwzm1rWbMoRMdcFTGyRH0r5rvyQg7QrGglf0vOGkaxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cs491JAdtF2PUtEI1ASFMNXT4FqJMdAsDKgNnTywrEE0jezKpPpfkVXv/6cVsW10p//+yrpt2+AkoNW+IgxOyQml7yVBegR43/Qp7rFZJUnsXzI9K2aVFhyIczNiFMERa3qjmb998vYzzZMhdoif7RzGnYjXzRyT12NSQqkZL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSHeT49/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55cb8ab1010so394293e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754553497; x=1755158297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nREQflrvBwfL+UFGeEdIo3dbjJ3DgqekWYe03XUGftA=;
        b=BSHeT49/JzvvpFbKws8WhYPND5vw19pBK6D+SN7zqnRmCmmE+G+UMvh/rqHEapNfNU
         1mbqUK5nk22Td6BUVdlmtXFhnB6otMVLF7o2TptRY79m5dzIV9B3h+RmFDKs/d22xsNr
         QOYRmOum10LuLsvgWHk5RsGNTcqHfsjgsdvA1zg1uuzCPKoOaJKn+QpmAhsPWTwBdmvw
         WEcANIV49pr0A3d/DWyGzVkfLVXPRb0/wrYb39wUQbxVqW5k8Jh1oB6a1au2tMw0BPuU
         TkezHLlY7ucEuCIsvN+Gjki/lOsIpFcmVJk09KITjkB3nxNjpReF7AfhZJV5a8KlhAO7
         iNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553497; x=1755158297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nREQflrvBwfL+UFGeEdIo3dbjJ3DgqekWYe03XUGftA=;
        b=N8JIJ22xDZxRqVXAkrmf6rLbPKFc/4yFhpOtgq8H7Fj5VAEcRdbxibGBpnDbyEmfGJ
         +bx5/aF3l83va8s3cKHNTLcwckbU6HTn+sxHFAIsQLua9GsDa/DPASbseWZH16YMAOEb
         aC91rEMUjIWrP4S+2RFnLZW/BKELF7Xs6wIIpT+1NS78IZmJhEfYflo0nr3zSwqNb5Jc
         Sf9TthXG280KdA5Uh4C6MA9rqNIghTfyjLLYzPV8x31KdoNJfhJurOrMqFiUeIok+Jw1
         qyhJRHqzCy9te2J2yhv1TOZQ1LkKcC2Wwje+9IU7al6v6Uxfb1xbmb9XJ1NXhC10CHi2
         RK0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7w++BMC28ES/BNchDrZakv85KKwUtVT1dLaQh4UsV2IL+/Y3P2q4Y6MfpG+H471P7X0BFh+Fr/F2u+Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Y1S1Uqc21J1Xr3XS0tMZBkVEUN8yRpMYh3u0oWi5DgUUmxii
	aYeG4l/QJY5GqJSHGo677pwyibhxC1o+5MVpGSmGN2sxgdVzT0VDlvB6
X-Gm-Gg: ASbGncszCG8mvQi495zALP7/tWVDTtTU8mcwhISJxx8IboZyCEH7BFbme2hCu2u1CG1
	KSeCQ0GjPn7UiO7VdUVicVAaPOT/wMWC9vr1ldTcdHfKhHJRlL9wJP6nGaqdi6mrXGYPHnUf0Mr
	MIVWx/jOgS7I4MVVePet1zHkbaYLwJioc5BOxeyfLpLGl123EwNTJbnkEC1y54QHFb3fr6SKA4z
	156/xGUQ/hgoYcOkID/5gfJF6fEyP8EHOKJPrR4Ck/ksSw5oX8Ogcsjpm1JKlb0+rebMlTLZvjv
	4ipPy9cNvmMfN6sWXi04sy0JVeMlc+8XK6s03qM+Tg6xIO59H9IVMHvI/GyTN9qJOqoSnk6MNSD
	HtZFO8NXkkxai6rHhiA==
X-Google-Smtp-Source: AGHT+IEryJXst4JidWIfvCd2S+GQhQQ4EbuRxqM5PE7+ha8NOwjYhUIEtdfSHTFFaWpE24CuJ3mL4w==
X-Received: by 2002:ac2:4c55:0:b0:55b:9406:17fd with SMTP id 2adb3069b0e04-55caf37acc0mr1578133e87.13.1754553496896;
        Thu, 07 Aug 2025 00:58:16 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c9b1fesm2501995e87.96.2025.08.07.00.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 00:58:16 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: [PATCH 5/8] mm/kasan, mm/vmalloc: Respect GFP flags in kasan_populate_vmalloc()
Date: Thu,  7 Aug 2025 09:58:07 +0200
Message-Id: <20250807075810.358714-6-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807075810.358714-1-urezki@gmail.com>
References: <20250807075810.358714-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function kasan_populate_vmalloc() internally allocates a page using
a hardcoded GFP_KERNEL flag. This is not safe in contexts where non-blocking
allocation flags are required, such as GFP_ATOMIC or GFP_NOWAIT, for example
during atomic vmalloc paths.

This patch modifies kasan_populate_vmalloc() and its helpers to accept a
gfp_mask argument to use it for a page allocation. It allows the caller to
specify the correct allocation context.

Also, when non-blocking flags are used, memalloc_noreclaim_save/restore()
is used around apply_to_page_range() to suppress potential reclaim behavior
that may otherwise violate atomic constraints.

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/kasan.h |  6 +++---
 mm/kasan/shadow.c     | 22 +++++++++++++++-------
 mm/vmalloc.c          |  4 ++--
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 890011071f2b..fe5ce9215821 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -562,7 +562,7 @@ static inline void kasan_init_hw_tags(void) { }
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
-int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
+int kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp_t gfp_mask);
 void kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end,
@@ -574,7 +574,7 @@ static inline void kasan_populate_early_vm_area_shadow(void *start,
 						       unsigned long size)
 { }
 static inline int kasan_populate_vmalloc(unsigned long start,
-					unsigned long size)
+					unsigned long size, gfp_t gfp_mask)
 {
 	return 0;
 }
@@ -610,7 +610,7 @@ static __always_inline void kasan_poison_vmalloc(const void *start,
 static inline void kasan_populate_early_vm_area_shadow(void *start,
 						       unsigned long size) { }
 static inline int kasan_populate_vmalloc(unsigned long start,
-					unsigned long size)
+					unsigned long size, gfp_t gfp_mask)
 {
 	return 0;
 }
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d2c70cd2afb1..5edfc1f6b53e 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -335,13 +335,13 @@ static void ___free_pages_bulk(struct page **pages, int nr_pages)
 	}
 }
 
-static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
+static int ___alloc_pages_bulk(struct page **pages, int nr_pages, gfp_t gfp_mask)
 {
 	unsigned long nr_populated, nr_total = nr_pages;
 	struct page **page_array = pages;
 
 	while (nr_pages) {
-		nr_populated = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
+		nr_populated = alloc_pages_bulk(gfp_mask, nr_pages, pages);
 		if (!nr_populated) {
 			___free_pages_bulk(page_array, nr_total - nr_pages);
 			return -ENOMEM;
@@ -353,25 +353,33 @@ static int ___alloc_pages_bulk(struct page **pages, int nr_pages)
 	return 0;
 }
 
-static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
+static int __kasan_populate_vmalloc(unsigned long start, unsigned long end, gfp_t gfp_mask)
 {
 	unsigned long nr_pages, nr_total = PFN_UP(end - start);
+	bool noblock = !gfpflags_allow_blocking(gfp_mask);
 	struct vmalloc_populate_data data;
+	unsigned int flags;
 	int ret = 0;
 
-	data.pages = (struct page **)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	data.pages = (struct page **)__get_free_page(gfp_mask | __GFP_ZERO);
 	if (!data.pages)
 		return -ENOMEM;
 
 	while (nr_total) {
 		nr_pages = min(nr_total, PAGE_SIZE / sizeof(data.pages[0]));
-		ret = ___alloc_pages_bulk(data.pages, nr_pages);
+		ret = ___alloc_pages_bulk(data.pages, nr_pages, gfp_mask);
 		if (ret)
 			break;
 
 		data.start = start;
+		if (noblock)
+			flags = memalloc_noreclaim_save();
+
 		ret = apply_to_page_range(&init_mm, start, nr_pages * PAGE_SIZE,
 					  kasan_populate_vmalloc_pte, &data);
+		if (noblock)
+			memalloc_noreclaim_restore(flags);
+
 		___free_pages_bulk(data.pages, nr_pages);
 		if (ret)
 			break;
@@ -385,7 +393,7 @@ static int __kasan_populate_vmalloc(unsigned long start, unsigned long end)
 	return ret;
 }
 
-int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
+int kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp_t gfp_mask)
 {
 	unsigned long shadow_start, shadow_end;
 	int ret;
@@ -414,7 +422,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 	shadow_start = PAGE_ALIGN_DOWN(shadow_start);
 	shadow_end = PAGE_ALIGN(shadow_end);
 
-	ret = __kasan_populate_vmalloc(shadow_start, shadow_end);
+	ret = __kasan_populate_vmalloc(shadow_start, shadow_end, gfp_mask);
 	if (ret)
 		return ret;
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b0255e0c74b3..7f48a54ec108 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2099,7 +2099,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	BUG_ON(va->va_start < vstart);
 	BUG_ON(va->va_end > vend);
 
-	ret = kasan_populate_vmalloc(addr, size);
+	ret = kasan_populate_vmalloc(addr, size, gfp_mask);
 	if (ret) {
 		free_vmap_area(va);
 		return ERR_PTR(ret);
@@ -4835,7 +4835,7 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 
 	/* populate the kasan shadow space */
 	for (area = 0; area < nr_vms; area++) {
-		if (kasan_populate_vmalloc(vas[area]->va_start, sizes[area]))
+		if (kasan_populate_vmalloc(vas[area]->va_start, sizes[area], GFP_KERNEL))
 			goto err_free_shadow;
 	}
 
-- 
2.39.5


