Return-Path: <linux-kernel+bounces-782980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C8B327F4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA34567E7B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E60238C04;
	Sat, 23 Aug 2025 09:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3UsAfUL"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF47F4A33
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755941713; cv=none; b=O0S+Ip8d+iSwpOgc7fChqZIZHFcn6RgR6wa9dWgoTU7r70ASLFMgWLCodxVfUz/YqfuUFQzmytqwxdJ9zNGRq8dxu+4fOvJg4zAySrNHe656hvnXUTFxlj/URVx6GFOkwiEw40Ff0+ZFUaI3a8xf8ltbEn74kg0zVz6uAdi2as8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755941713; c=relaxed/simple;
	bh=24sjhNDONNlfhjMuQocbxVfFgzhTLA154n85ceeYAig=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlyMOVBPXq8OWpMOaI5M/ZOoDRu7MUYSlo7T9jzjQphqS6/n0S0qm2pWwR8sEvHGwVVdpYoCBNf6e6R9gpBr48P5r96lbiJtBwVMbnhfp/Dt7WditFf/8WwADko3vPCXeSIC7eTtXSDh1hxWjzviGiME64uLCWs15miPnMfb9XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3UsAfUL; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f39c0a22dso525742e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 02:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755941710; x=1756546510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A92qUKVVscD1iUAIIcRKA9oYRSCgvP30+tdPO7B2xVE=;
        b=H3UsAfUL2POcfDoMAHyL7H3z5Q2uriOICZvRSgpQMZHS3Hr3ATaUd3JHTk/WPmMluS
         3ydkCwcSx190H3cIBUSUhNaO/wvTI2Rlz0E8OaSrevXD/bersGOKzFVb0adhVL8XZO0I
         NsqOH18bvINMLocXgEbd4fi5E696Vj6Ghe876Ox989gOo2YH1usktFfzcY4XABJs7g0/
         7jPk2HIQWa1SjjvTlOtcwzRFtAxiWFoecZQ2vm1m4UYqbC0n5Tx6myRt2Wi9mqnVyolu
         8FFxzGC7KNej5BVib43UqibhVt3g37gHCat5TE77XpFD7PhKELw5ICdrx+HLvgMkLpyt
         9xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755941710; x=1756546510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A92qUKVVscD1iUAIIcRKA9oYRSCgvP30+tdPO7B2xVE=;
        b=OsNtzT78SanGds2EHpbmLi2xToFiJ3UU3Q5lKN38qp8/xoJv6fKy7gbUS2pPwdKqCw
         C5xNbweBGhS7iPcQa+0o+izQhgF90oW5zGQRuAm3lVzjAkeQpRQ6j0WmrBmFpZ+xNVtj
         aY+XFXj+LMvgFb9lKu4Yfvl9Kws6hFs+kJLmOeep6+eK4IcUM6l1uEmsIOmMca/I/VBK
         N4vvN+0jKDIfOs5dETI4q2zspdXTdeBlfVKA99XnZrK+Pe1xdx7Syg9TGM2NI1qLNHfC
         SkS2KERdNYtvQSwtvv5MbmSVNeKc4BvX0wL7/wkyIpGI+vmqB81l/4O3uW3pwaeumL/u
         lV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVnjE909gGau3FNxvdRZj3DmzBWe3Htmt5C51bIXUIKni/XntkuNm3dbc97pMuZxMbuTLGXfdg/kAesDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwM5qUBk/LCz8J3N16EWtG0x/On1xnpwsAoTeukxfzxEkazWTt
	15yLMt7pWa0xWAsHaz0ftHCKwpdxfsMpXJ6EEnua3cM2/jhpxtsFOP63
X-Gm-Gg: ASbGncvL236HRXW0ml/z12Wq7FJWjg/fQGfy6/hT5z6H++edn0mj4EYR57kb4iY+5lF
	BanHhVtaPbj8I5N9ygcLt3oq9S/dUzpckq1vw7A8WKbkcCxAilybCGkpiQDOQsKHs9X+TNNTBYT
	Gik0Tj64n/vCQeYb/skZhAzaGIo0qC0LXpJn6pZU9+etyyltNYu/Rd+AU7uWz9qqBTwv10aNPiF
	8vaEcgRl/NZtWtQDVoiHTqtVrYHzzLtPopDYKPw2G9DUTBMI+WiuxqRkk9JbPy0HBegSsERfMOa
	P/8XAz6NYztH5eS3a0qSdTEOCETZ58qKnSugwf4rkXNBEdQ/kSz1gVz7fnDiw7h6
X-Google-Smtp-Source: AGHT+IEKI+WFby0u8zrSUkWE+Z6THT2SoEAd6rk+RgsOklByaudVol34fQCDN7e3412nflAMA9MT2g==
X-Received: by 2002:a05:6512:4048:20b0:55f:34e8:b1b8 with SMTP id 2adb3069b0e04-55f34e8ca2fmr503948e87.55.1755941709652;
        Sat, 23 Aug 2025 02:35:09 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c9a0bbsm402584e87.121.2025.08.23.02.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 02:35:09 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sat, 23 Aug 2025 11:35:07 +0200
To: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH 0/8] __vmalloc() and no-block support
Message-ID: <aKmLS0sLG5-ILTGR@pc636>
References: <20250807075810.358714-1-urezki@gmail.com>
 <aJSHbFviIiB2oN5G@elver.google.com>
 <aJW520nQ78NrhXWX@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJW520nQ78NrhXWX@pc636>

Hello, Alexander!

I am working on making vmalloc to support extra non-blocking flags.
Currently i see one more place that i need to address:

kmsan_vmap_pages_range_noflush() function which uses hard-coded GFP_KERNEL
flags for allocation of two arrays for its internal use only.

I have a question to you, can we just get rid of those two allocations?
It is the easiest way, if possible. Otherwise i can add "gfp_t gfp_mask"
extra parameter and pass there a corresponding gfp_mask flag. See below:

<snip>
diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index 2b1432cc16d5..e4b34e7a3b11 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -133,6 +133,7 @@ void kmsan_kfree_large(const void *ptr);
  * @prot:      page protection flags used for vmap.
  * @pages:     array of pages.
  * @page_shift:        page_shift passed to vmap_range_noflush().
+ * @gfp_mask:  gfp_mask to use internally.
  *
  * KMSAN maps shadow and origin pages of @pages into contiguous ranges in
  * vmalloc metadata address range. Returns 0 on success, callers must check
@@ -142,7 +143,8 @@ int __must_check kmsan_vmap_pages_range_noflush(unsigned long start,
                                                unsigned long end,
                                                pgprot_t prot,
                                                struct page **pages,
-                                               unsigned int page_shift);
+                                               unsigned int page_shift,
+                                               gfp_t gfp_mask);

 /**
  * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
@@ -348,7 +350,7 @@ static inline void kmsan_kfree_large(const void *ptr)

 static inline int __must_check kmsan_vmap_pages_range_noflush(
        unsigned long start, unsigned long end, pgprot_t prot,
-       struct page **pages, unsigned int page_shift)
+       struct page **pages, unsigned int page_shift, gfp_t gfp_mask)
 {
        return 0;
 }
diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc03..6a13b8ee1e6c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1359,7 +1359,7 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
 #ifdef CONFIG_MMU
 void __init vmalloc_init(void);
 int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-                pgprot_t prot, struct page **pages, unsigned int page_shift);
+               pgprot_t prot, struct page **pages, unsigned int page_shift, gfp_t gfp_mask);
 unsigned int get_vm_area_page_order(struct vm_struct *vm);
 #else
 static inline void vmalloc_init(void)
@@ -1368,7 +1368,7 @@ static inline void vmalloc_init(void)

 static inline
 int __must_check vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-                pgprot_t prot, struct page **pages, unsigned int page_shift)
+               pgprot_t prot, struct page **pages, unsigned int page_shift, gfp_t gfp_mask)
 {
        return -EINVAL;
 }
diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
index b14ce3417e65..5b74d6dbf0b8 100644
--- a/mm/kmsan/init.c
+++ b/mm/kmsan/init.c
@@ -233,5 +233,6 @@ void __init kmsan_init_runtime(void)
        kmsan_memblock_discard();
        pr_info("Starting KernelMemorySanitizer\n");
        pr_info("ATTENTION: KMSAN is a debugging tool! Do not use it on production machines!\n");
-       kmsan_enabled = true;
+       /* kmsan_enabled = true; */
+       kmsan_enabled = false;
 }
diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index 54f3c3c962f0..3cd733663100 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -215,7 +215,7 @@ void kmsan_free_page(struct page *page, unsigned int order)

 int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
                                   pgprot_t prot, struct page **pages,
-                                  unsigned int page_shift)
+                                  unsigned int page_shift, gfp_t gfp_mask)
 {
        unsigned long shadow_start, origin_start, shadow_end, origin_end;
        struct page **s_pages, **o_pages;
@@ -230,8 +230,8 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
                return 0;

        nr = (end - start) / PAGE_SIZE;
-       s_pages = kcalloc(nr, sizeof(*s_pages), GFP_KERNEL);
-       o_pages = kcalloc(nr, sizeof(*o_pages), GFP_KERNEL);
+       s_pages = kcalloc(nr, sizeof(*s_pages), gfp_mask);
+       o_pages = kcalloc(nr, sizeof(*o_pages), gfp_mask);
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
-                                       PAGE_KERNEL, pages, PAGE_SHIFT);
+                       PAGE_KERNEL, pages, PAGE_SHIFT, GFP_KERNEL);
 }

 /**
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ee197f5b8cf0..9be01dcca690 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -671,16 +671,28 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 }

 int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
-               pgprot_t prot, struct page **pages, unsigned int page_shift)
+               pgprot_t prot, struct page **pages, unsigned int page_shift,
+               gfp_t gfp_mask)
 {
        int ret = kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
-                                                page_shift);
+                                               page_shift, gfp_mask);

        if (ret)
                return ret;
        return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
 }

+static int __vmap_pages_range(unsigned long addr, unsigned long end,
+               pgprot_t prot, struct page **pages, unsigned int page_shift,
+               gfp_t gfp_mask)
+{
+       int err;
+
+       err = vmap_pages_range_noflush(addr, end, prot, pages, page_shift, gfp_mask);
+       flush_cache_vmap(addr, end);
+       return err;
+}
+
 /**
  * vmap_pages_range - map pages to a kernel virtual address
  * @addr: start of the VM area to map
@@ -696,11 +708,7 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 int vmap_pages_range(unsigned long addr, unsigned long end,
                pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
-       int err;
-
-       err = vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
-       flush_cache_vmap(addr, end);
-       return err;
+       return __vmap_pages_range(addr, end, prot, pages, page_shift, GFP_KERNEL);
 }

 static int check_sparse_vm_area(struct vm_struct *area, unsigned long start,
@@ -3804,8 +3812,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
                flags = memalloc_noio_save();

        do {
-               ret = vmap_pages_range(addr, addr + size, prot, area->pages,
-                       page_shift);
+               ret = __vmap_pages_range(addr, addr + size, prot, area->pages,
+                               page_shift, gfp_mask);
                if (nofail && (ret < 0))
                        schedule_timeout_uninterruptible(1);
        } while (nofail && (ret < 0));
<snip>

Thanks!

--
Uladzislau Rezki

