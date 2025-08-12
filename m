Return-Path: <linux-kernel+bounces-764869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E9BB22828
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DADDE1BC4F51
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DF326B0A9;
	Tue, 12 Aug 2025 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZ3KaVOw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF1F25C706
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004240; cv=none; b=cWeRbOJiGI+dIM1zlJnpA+1jt5cQOwUG1o8RHZ/KQvlq3TFVqqDYVnUMOBVw52B3YcSD/rFzNZcWXG5bS3pd7RsBo/fzOp548914wSWB9ahg0elJXJokr+MFXD/uJPouyiXdEFMcYKosTgSN6spWrVAZPiGyo8QnF+BzMj7Nnbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004240; c=relaxed/simple;
	bh=26ooarSgdO9PSAiMZ0O74U9w8cb5/o/4g4Q76W9o+n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=WB6oxlXaHa+GEh2kYMSIwICTtsCcvt/0xNAncJ9WK6F/qeLE7Bm5fBJoUSMh6TMPasOhHhZoOHfZMVA5It1ZVuwKEvywPXbtM4BvfFbtBzTM0+DIBeU/QUfWW7oRXrOfTcPp7bZyz5oE0G6kroJXmiE36ur+nXKCYXXVbU6kr7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZ3KaVOw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755004237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90kjOoDlgJxvROpKhCBaV42MFQEOcPlCS7aVoYrLf2Q=;
	b=aZ3KaVOwTJOy8HWVqLiui874CV75GU2SB5QtkibLAwESLtY1PmsomAa1H+vojBXAYn/ixh
	yFw5Ffe5hlRkRXpAHfzsAaJlnEWjiZO9IHdyGaZ8jUvlM0yyK03vDxhtPt2hBEHYL4vXy8
	5oLTqCyxUude+lDHh5yVMLpU9PQcmhE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-TQnxb7SJOn-5DJ0f1i7kgA-1; Tue,
 12 Aug 2025 09:10:33 -0400
X-MC-Unique: TQnxb7SJOn-5DJ0f1i7kgA-1
X-Mimecast-MFC-AGG-ID: TQnxb7SJOn-5DJ0f1i7kgA_1755004227
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A40B1800291;
	Tue, 12 Aug 2025 13:10:27 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.156])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D1B71955F16;
	Tue, 12 Aug 2025 13:10:18 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: snovitoll@gmail.com,
	ryabinin.a.a@gmail.com,
	christophe.leroy@csgroup.eu,
	hca@linux.ibm.com,
	andreyknvl@gmail.com,
	akpm@linux-foundation.org,
	chenhuacai@loongson.cn,
	davidgow@google.com,
	glider@google.com,
	dvyukov@google.com,
	alexghiti@rivosinc.com,
	kasan-dev@googlegroups.com,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	agordeev@linux.ibm.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 4/4] mm/kasan: remove kasan_arch_is_ready()
Date: Tue, 12 Aug 2025 21:09:33 +0800
Message-ID: <20250812130933.71593-5-bhe@redhat.com>
In-Reply-To: <20250812130933.71593-1-bhe@redhat.com>
References: <20250812130933.71593-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Now there's no any place where kasan_arch_is_ready() is needed, remove
all its invocations.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/kasan/common.c  |  9 +++------
 mm/kasan/generic.c |  9 ---------
 mm/kasan/kasan.h   |  6 ------
 mm/kasan/shadow.c  | 18 ------------------
 4 files changed, 3 insertions(+), 39 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 69a848f2a8aa..e48c1fd60edf 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -271,7 +271,7 @@ static inline void poison_slab_object(struct kmem_cache *cache, void *object,
 bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
 				unsigned long ip)
 {
-	if (!kasan_arch_is_ready() || is_kfence_address(object))
+	if (is_kfence_address(object))
 		return false;
 	return check_slab_allocation(cache, object, ip);
 }
@@ -279,7 +279,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
 bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
 		       bool still_accessible)
 {
-	if (!kasan_arch_is_ready() || is_kfence_address(object))
+	if (is_kfence_address(object))
 		return false;
 
 	/*
@@ -318,9 +318,6 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
 
 static inline bool check_page_allocation(void *ptr, unsigned long ip)
 {
-	if (!kasan_arch_is_ready())
-		return false;
-
 	if (ptr != page_address(virt_to_head_page(ptr))) {
 		kasan_report_invalid_free(ptr, ip, KASAN_REPORT_INVALID_FREE);
 		return true;
@@ -547,7 +544,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
 		return true;
 	}
 
-	if (is_kfence_address(ptr) || !kasan_arch_is_ready())
+	if (is_kfence_address(ptr))
 		return true;
 
 	slab = folio_slab(folio);
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 8daea5892754..d513e3e2e136 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -168,9 +168,6 @@ static __always_inline bool check_region_inline(const void *addr,
 	if (!kasan_enabled())
 		return true;
 
-	if (!kasan_arch_is_ready())
-		return true;
-
 	if (unlikely(size == 0))
 		return true;
 
@@ -196,9 +193,6 @@ bool kasan_byte_accessible(const void *addr)
 {
 	s8 shadow_byte;
 
-	if (!kasan_arch_is_ready())
-		return true;
-
 	shadow_byte = READ_ONCE(*(s8 *)kasan_mem_to_shadow(addr));
 
 	return shadow_byte >= 0 && shadow_byte < KASAN_GRANULE_SIZE;
@@ -505,9 +499,6 @@ static void release_alloc_meta(struct kasan_alloc_meta *meta)
 
 static void release_free_meta(const void *object, struct kasan_free_meta *meta)
 {
-	if (!kasan_arch_is_ready())
-		return;
-
 	/* Check if free meta is valid. */
 	if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_SLAB_FREE_META)
 		return;
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 129178be5e64..e0ffc16495d7 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -544,12 +544,6 @@ static inline void kasan_poison_last_granule(const void *address, size_t size) {
 
 #endif /* CONFIG_KASAN_GENERIC */
 
-#ifndef kasan_arch_is_ready
-static inline bool kasan_arch_is_ready(void)	{ return true; }
-#elif !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
-#error kasan_arch_is_ready only works in KASAN generic outline mode!
-#endif
-
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 
 void kasan_kunit_test_suite_start(void);
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 637f2d02d2a3..d8b975282b22 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -128,9 +128,6 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 	if (!kasan_enabled())
 		return;
 
-	if (!kasan_arch_is_ready())
-		return;
-
 	/*
 	 * Perform shadow offset calculation based on untagged address, as
 	 * some of the callers (e.g. kasan_poison_new_object) pass tagged
@@ -156,9 +153,6 @@ void kasan_poison_last_granule(const void *addr, size_t size)
 	if (!kasan_enabled())
 		return;
 
-	if (!kasan_arch_is_ready())
-		return;
-
 	if (size & KASAN_GRANULE_MASK) {
 		u8 *shadow = (u8 *)kasan_mem_to_shadow(addr + size);
 		*shadow = size & KASAN_GRANULE_MASK;
@@ -402,9 +396,6 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 	if (!kasan_enabled())
 		return 0;
 
-	if (!kasan_arch_is_ready())
-		return 0;
-
 	if (!is_vmalloc_or_module_addr((void *)addr))
 		return 0;
 
@@ -575,9 +566,6 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 	if (!kasan_enabled())
 		return;
 
-	if (!kasan_arch_is_ready())
-		return;
-
 	region_start = ALIGN(start, KASAN_MEMORY_PER_SHADOW_PAGE);
 	region_end = ALIGN_DOWN(end, KASAN_MEMORY_PER_SHADOW_PAGE);
 
@@ -626,9 +614,6 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 	 * with setting memory tags, so the KASAN_VMALLOC_INIT flag is ignored.
 	 */
 
-	if (!kasan_arch_is_ready())
-		return (void *)start;
-
 	if (!is_vmalloc_or_module_addr(start))
 		return (void *)start;
 
@@ -651,9 +636,6 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
  */
 void __kasan_poison_vmalloc(const void *start, unsigned long size)
 {
-	if (!kasan_arch_is_ready())
-		return;
-
 	if (!is_vmalloc_or_module_addr(start))
 		return;
 
-- 
2.41.0


