Return-Path: <linux-kernel+bounces-847115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA0FBC9E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 015804F64A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6B62ECEA7;
	Thu,  9 Oct 2025 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvccXK/m"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC172EC57D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025263; cv=none; b=C9zeq99fjKoBCqZAJS2xBFm5PrVO995bVJcRsmPnd2tnQOOm/BKA4EKsiM40a5uo3inLg/klfKA1zjnui1r2rShf8nt9na7HZch4y7DnR2zOb+Nrmcs37w6Ap+aobPxtEasFe7vTll5V1L9LI3bFh1SKX3WXvm/lg/aw48KhcZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025263; c=relaxed/simple;
	bh=AMqTQiS/X1x1b+tt2RsoytbW+b4db+Er5cv0AHpBPzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEe/AZ92cYROdfLJwhT43eAJI1I/i9CsZJvOYWq2gnc5wXKql6y+O0V7dTV0Kp+VgV+iVrKJ5utyxuGZqT7liZIgwpvTc2xeBK4t9UohCdw2rC7h5VBXQgNOWHwY69UAfTlne22NmRhvs6d+VM4rmgJXmnt9sfYOKueGPdq/orA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvccXK/m; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so13800831fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760025260; x=1760630060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3jD6Srgk8c77Z/UJ+8ukqBQAN6er5a/zSDavY8QJGM=;
        b=LvccXK/mjYo+yVxwoCKwCUFgR3Pi0r/vpz+q6ePCdMHgd7mwc48rh1Edj+Pf1oacSC
         W/P7ZFVgaiiCSt5vHeECfDBLIbQclxUCvZ3LmHnvfDkodsh/L/77pqTqiX90isjMmQim
         IGFdhxZK72+Kp1kIsdfWG0kxrE/B1wjy1OmdjjmezCq0H3q1X4ruzJaye7LaIrZsDi7e
         10sJqu+5wnOgzOeMwaUvVFSEQ01A1x7Q0neFICh5KYe/sEg9gO25UP+1th1wF2PS1ggD
         aiAA+LjSkYXu3aAfoZnH7d+8uBxdZ6PUhC0UbOYd737Yn+CGOZxdOd/As8JFp3PEdr7z
         UYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025260; x=1760630060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3jD6Srgk8c77Z/UJ+8ukqBQAN6er5a/zSDavY8QJGM=;
        b=V9pMXJo0QuNjRR4r4jjrskkPPOx4QrEd3vr7GX/f0ELLl9HkBmVUyyhh7tA1TYN+Ci
         LGBEDx5E2D7YPFryDRx/ZOqrCcL19AaWFAyX0TZgLxq/gVDZPcUGcG1nieszn6OWEMnO
         090SBXgJUjDlnVkZo/dFkUqlyUyEguAigv4++MsqGAGRz5/RQn7a8cXVN0HnbJawcNEr
         lRtH1dVL6xjMh6By0dIyg2jPosMZDFvq+f0AkBqTTspAKDkA/HjKu0NJduVlx2PJI+rS
         8nWIE0eP2U5vHNvvQWD72JLj7pmRfyzeQTeTBLWOJ4ZKQGGg1G2E5KEpNI86VuVQZABv
         ah6A==
X-Forwarded-Encrypted: i=1; AJvYcCUUCz6nCHqkA6XNk8caFOPvNQOEnyWgM9/Rkz1d8PXbyInuIfvECwoLk/wxKh2mTkIjTjxEkKffXjlnu3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Wqam3jjV1QZCqSIPconaZ++fMlLy/H7SKJKn+NUiYCNPYCXY
	o4YDVMrJN9AoKBOLRYgprXQ8f2p6RbUsoXmEjz8JQNbAoWrbFz2nxFjp
X-Gm-Gg: ASbGnctHpFQU2edTgbWoB9Stb60B+kvxdF6ylTvAeD7n0efTrfCMjCImDrLBH7UTUGb
	jtbBJJganWLTmXt8uV0AkOA8KBDubBaRwmMbm4yQZYY9SngwOB8buBoyQlSBqVpBqTwvUxcOyPW
	2yqIw8RC+aF8q9qkqGtzkFTpUoRfVzBXic82tYT/8R17Ae4XVgjEAByYel4Pd1vAkqQWejraFfP
	30L5XgOQwBbRs47NegTDv4OwUwJua5+n4GxOdVYb3RRLhFP3w5NIPexVJp3GgEei2RTcZ6rTJ6n
	dUVrFVgnsF+57I+xMSrphY/HtwvoSw8QmorCjKextQoFcuqVpCCYrwXGwsOuw5H/DigNSfBrzmY
	AZTW1TcTZ2iNObR/ikeuwYBiMl6C+lEy/DsHyznucPV4j+HsU18bQnnmYRK7Ji10D385tRxY6pg
	==
X-Google-Smtp-Source: AGHT+IEw+s+w6dsCMs+FyUWCNhIcM01oy6wj30FcD6bZDLMLaZbzcGhDGKpIi8Zl/WSuXa35QvXIUw==
X-Received: by 2002:a05:651c:2210:b0:373:a537:6a19 with SMTP id 38308e7fff4ca-37609cf869emr22052341fa.2.1760025259655;
        Thu, 09 Oct 2025 08:54:19 -0700 (PDT)
Received: from fedora (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-375f3bcd2a8sm29499831fa.55.2025.10.09.08.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:54:19 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	bhe@redhat.com
Cc: christophe.leroy@csgroup.eu,
	ritesh.list@gmail.com,
	snovitoll@gmail.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] kasan: cleanup of kasan_enabled() checks
Date: Thu,  9 Oct 2025 20:54:03 +0500
Message-ID: <20251009155403.1379150-3-snovitoll@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155403.1379150-1-snovitoll@gmail.com>
References: <20251009155403.1379150-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Deduplication of kasan_enabled() checks which are already used by callers.

* Altered functions:

check_page_allocation
	Delete the check because callers have it already in __wrappers in
	include/linux/kasan.h:
		__kasan_kfree_large
		__kasan_mempool_poison_pages
		__kasan_mempool_poison_object

kasan_populate_vmalloc, kasan_release_vmalloc
	Add __wrappers in include/linux/kasan.h.
	They are called externally in mm/vmalloc.c.

__kasan_unpoison_vmalloc, __kasan_poison_vmalloc
	Delete checks because there're already kasan_enabled() checks
	in respective __wrappers in include/linux/kasan.h.

release_free_meta -- Delete the check because the higher caller path
	has it already. See the stack trace:

	__kasan_slab_free -- has the check already
	__kasan_mempool_poison_object -- has the check already
		poison_slab_object
			kasan_save_free_info
				release_free_meta
					kasan_enabled() -- Delete here

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 include/linux/kasan.h | 20 ++++++++++++++++++--
 mm/kasan/common.c     |  3 ---
 mm/kasan/generic.c    |  3 ---
 mm/kasan/shadow.c     | 20 ++++----------------
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index d12e1a5f5a9..f335c1d7b61 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -571,11 +571,27 @@ static inline void kasan_init_hw_tags(void) { }
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 
 void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
-int kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp_t gfp_mask);
-void kasan_release_vmalloc(unsigned long start, unsigned long end,
+int __kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp_t gfp_mask);
+static inline int kasan_populate_vmalloc(unsigned long addr,
+					 unsigned long size, gfp_t gfp_mask)
+{
+	if (kasan_enabled())
+		return __kasan_populate_vmalloc(addr, size, gfp_mask);
+	return 0;
+}
+void __kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end,
 			   unsigned long flags);
+static inline void kasan_release_vmalloc(unsigned long start, unsigned long end,
+			   unsigned long free_region_start,
+			   unsigned long free_region_end,
+			   unsigned long flags)
+{
+	if (kasan_enabled())
+		return __kasan_release_vmalloc(start, end, free_region_start,
+					 free_region_end, flags);
+}
 
 #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
 
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index d4c14359fea..22e5d67ff06 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -305,9 +305,6 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
 
 static inline bool check_page_allocation(void *ptr, unsigned long ip)
 {
-	if (!kasan_enabled())
-		return false;
-
 	if (ptr != page_address(virt_to_head_page(ptr))) {
 		kasan_report_invalid_free(ptr, ip, KASAN_REPORT_INVALID_FREE);
 		return true;
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 516b49accc4..2b8e73f5f6a 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -506,9 +506,6 @@ static void release_alloc_meta(struct kasan_alloc_meta *meta)
 
 static void release_free_meta(const void *object, struct kasan_free_meta *meta)
 {
-	if (!kasan_enabled())
-		return;
-
 	/* Check if free meta is valid. */
 	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREE_META)
 		return;
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 5d2a876035d..cf842b620a2 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -354,7 +354,7 @@ static int ___alloc_pages_bulk(struct page **pages, int nr_pages, gfp_t gfp_mask
 	return 0;
 }
 
-static int __kasan_populate_vmalloc(unsigned long start, unsigned long end, gfp_t gfp_mask)
+static int __kasan_populate_vmalloc_do(unsigned long start, unsigned long end, gfp_t gfp_mask)
 {
 	unsigned long nr_pages, nr_total = PFN_UP(end - start);
 	struct vmalloc_populate_data data;
@@ -403,14 +403,11 @@ static int __kasan_populate_vmalloc(unsigned long start, unsigned long end, gfp_
 	return ret;
 }
 
-int kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp_t gfp_mask)
+int __kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp_t gfp_mask)
 {
 	unsigned long shadow_start, shadow_end;
 	int ret;
 
-	if (!kasan_enabled())
-		return 0;
-
 	if (!is_vmalloc_or_module_addr((void *)addr))
 		return 0;
 
@@ -432,7 +429,7 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size, gfp_t gfp_mas
 	shadow_start = PAGE_ALIGN_DOWN(shadow_start);
 	shadow_end = PAGE_ALIGN(shadow_end);
 
-	ret = __kasan_populate_vmalloc(shadow_start, shadow_end, gfp_mask);
+	ret = __kasan_populate_vmalloc_do(shadow_start, shadow_end, gfp_mask);
 	if (ret)
 		return ret;
 
@@ -574,7 +571,7 @@ static int kasan_depopulate_vmalloc_pte(pte_t *ptep, unsigned long addr,
  * pages entirely covered by the free region, we will not run in to any
  * trouble - any simultaneous allocations will be for disjoint regions.
  */
-void kasan_release_vmalloc(unsigned long start, unsigned long end,
+void __kasan_release_vmalloc(unsigned long start, unsigned long end,
 			   unsigned long free_region_start,
 			   unsigned long free_region_end,
 			   unsigned long flags)
@@ -583,9 +580,6 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 	unsigned long region_start, region_end;
 	unsigned long size;
 
-	if (!kasan_enabled())
-		return;
-
 	region_start = ALIGN(start, KASAN_MEMORY_PER_SHADOW_PAGE);
 	region_end = ALIGN_DOWN(end, KASAN_MEMORY_PER_SHADOW_PAGE);
 
@@ -634,9 +628,6 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 	 * with setting memory tags, so the KASAN_VMALLOC_INIT flag is ignored.
 	 */
 
-	if (!kasan_enabled())
-		return (void *)start;
-
 	if (!is_vmalloc_or_module_addr(start))
 		return (void *)start;
 
@@ -659,9 +650,6 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
  */
 void __kasan_poison_vmalloc(const void *start, unsigned long size)
 {
-	if (!kasan_enabled())
-		return;
-
 	if (!is_vmalloc_or_module_addr(start))
 		return;
 
-- 
2.34.1


