Return-Path: <linux-kernel+bounces-776964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 215B4B2D38D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9301C408DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793129DB96;
	Wed, 20 Aug 2025 05:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Evg/cT82"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB32853FD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668128; cv=none; b=FOZ9K+uDeAHHg1NH+arapJxcLRULbZUFgPo4rivK0m3qJn0dnLeSqnKEc+2BcQVAG1jUkkGijpQOPrNgibfZj82H1WhRdKkNcb0HMgNN3TUqu0PwP3zP6hUqGwmSmcqCpKzjvBUq9FMwzzET3/8VnWfyejRqIOEL78d1czkmktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668128; c=relaxed/simple;
	bh=8jk0i++LAnDk3WELsHB9+3LcJrHqFyRw/1w+tpO9zNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=JMZ5Yc0cdbDxd6ysl2MsOkJx9PqYVQBYVCcyK0TUM/4MV/w8WwsFyrk3WDhXSWo8U0W3TZH6HexfZqfXgWUP5F+szZnfXq8Mh20lRpfptTOWzahZ2Zcck60P/cgvpYu0JIogdwThrl7pJQ0Uiggr24YSMcHDlm6btda5ZZqXN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Evg/cT82; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755668125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAFiQLTxZfWIjT2BgzBfUHBH1TsYFyFlhKTQvwrw4NE=;
	b=Evg/cT82UOS/g4LoLlWfxz2EVeDJiR8rQXpf6PKYvn+D7xxeRkKU4wYPj+1auf0+5K0uio
	DdiMBTTxlr415Cf44j0dadeZUAjFI8hmOYKyOjNss6wS9Xvg0u0ERhF/YdPQnJDxdhLJTm
	Fz4TsgrOxFhW56kzm7QEWYNF1EiWyIM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-SZJqQwM0MQieMhFfhK9-vw-1; Wed,
 20 Aug 2025 01:35:22 -0400
X-MC-Unique: SZJqQwM0MQieMhFfhK9-vw-1
X-Mimecast-MFC-AGG-ID: SZJqQwM0MQieMhFfhK9-vw_1755668120
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B55A11800357;
	Wed, 20 Aug 2025 05:35:19 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D33719560B6;
	Wed, 20 Aug 2025 05:35:11 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	elver@google.com,
	snovitoll@gmail.com,
	christophe.leroy@csgroup.eu,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 01/12] mm/kasan: add conditional checks in functions to return directly if kasan is disabled
Date: Wed, 20 Aug 2025 13:34:48 +0800
Message-ID: <20250820053459.164825-2-bhe@redhat.com>
In-Reply-To: <20250820053459.164825-1-bhe@redhat.com>
References: <20250820053459.164825-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The current code only does the check if kasan is disabled for hw_tags
mode. Here add the conditional checks for functional functions of
generic mode and sw_tags mode.

This is prepared for later adding kernel parameter kasan=on|off for
all kasan modes.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/kasan/generic.c    | 20 ++++++++++++++++++--
 mm/kasan/init.c       |  6 ++++++
 mm/kasan/quarantine.c |  3 +++
 mm/kasan/report.c     |  4 +++-
 mm/kasan/shadow.c     | 23 ++++++++++++++++++++++-
 mm/kasan/sw_tags.c    |  3 +++
 6 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d54e89f8c3e7..8daea5892754 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -165,6 +165,9 @@ static __always_inline bool check_region_inline(const void *addr,
 						size_t size, bool write,
 						unsigned long ret_ip)
 {
+	if (!kasan_enabled())
+		return true;
+
 	if (!kasan_arch_is_ready())
 		return true;
 
@@ -203,12 +206,13 @@ bool kasan_byte_accessible(const void *addr)
 
 void kasan_cache_shrink(struct kmem_cache *cache)
 {
-	kasan_quarantine_remove_cache(cache);
+	if (kasan_enabled())
+		kasan_quarantine_remove_cache(cache);
 }
 
 void kasan_cache_shutdown(struct kmem_cache *cache)
 {
-	if (!__kmem_cache_empty(cache))
+	if (kasan_enabled() && !__kmem_cache_empty(cache))
 		kasan_quarantine_remove_cache(cache);
 }
 
@@ -228,6 +232,9 @@ void __asan_register_globals(void *ptr, ssize_t size)
 	int i;
 	struct kasan_global *globals = ptr;
 
+	if (!kasan_enabled())
+		return;
+
 	for (i = 0; i < size; i++)
 		register_global(&globals[i]);
 }
@@ -358,6 +365,9 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 	unsigned int rem_free_meta_size;
 	unsigned int orig_alloc_meta_offset;
 
+	if (!kasan_enabled())
+		return;
+
 	if (!kasan_requires_meta())
 		return;
 
@@ -510,6 +520,9 @@ size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
 {
 	struct kasan_cache *info = &cache->kasan_info;
 
+	if (!kasan_enabled())
+		return 0;
+
 	if (!kasan_requires_meta())
 		return 0;
 
@@ -535,6 +548,9 @@ void kasan_record_aux_stack(void *addr)
 	struct kasan_alloc_meta *alloc_meta;
 	void *object;
 
+	if (!kasan_enabled())
+		return;
+
 	if (is_kfence_address(addr) || !slab)
 		return;
 
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index ced6b29fcf76..43d95f329675 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -449,6 +449,9 @@ void kasan_remove_zero_shadow(void *start, unsigned long size)
 	unsigned long addr, end, next;
 	pgd_t *pgd;
 
+	if (!kasan_enabled())
+		return;
+
 	addr = (unsigned long)kasan_mem_to_shadow(start);
 	end = addr + (size >> KASAN_SHADOW_SCALE_SHIFT);
 
@@ -484,6 +487,9 @@ int kasan_add_zero_shadow(void *start, unsigned long size)
 	int ret;
 	void *shadow_start, *shadow_end;
 
+	if (!kasan_enabled())
+		return 0;
+
 	shadow_start = kasan_mem_to_shadow(start);
 	shadow_end = shadow_start + (size >> KASAN_SHADOW_SCALE_SHIFT);
 
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 6958aa713c67..a6dc2c3d8a15 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -405,6 +405,9 @@ static int __init kasan_cpu_quarantine_init(void)
 {
 	int ret = 0;
 
+	if (!kasan_enabled())
+		return 0;
+
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mm/kasan:online",
 				kasan_cpu_online, kasan_cpu_offline);
 	if (ret < 0)
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 62c01b4527eb..884357fa74ed 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -576,7 +576,9 @@ bool kasan_report(const void *addr, size_t size, bool is_write,
 	unsigned long irq_flags;
 	struct kasan_report_info info;
 
-	if (unlikely(report_suppressed_sw()) || unlikely(!report_enabled())) {
+	if (unlikely(report_suppressed_sw()) ||
+	    unlikely(!report_enabled()) ||
+	    !kasan_enabled()) {
 		ret = false;
 		goto out;
 	}
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d2c70cd2afb1..637f2d02d2a3 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -125,6 +125,9 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 {
 	void *shadow_start, *shadow_end;
 
+	if (!kasan_enabled())
+		return;
+
 	if (!kasan_arch_is_ready())
 		return;
 
@@ -150,6 +153,9 @@ EXPORT_SYMBOL_GPL(kasan_poison);
 #ifdef CONFIG_KASAN_GENERIC
 void kasan_poison_last_granule(const void *addr, size_t size)
 {
+	if (!kasan_enabled())
+		return;
+
 	if (!kasan_arch_is_ready())
 		return;
 
@@ -164,6 +170,8 @@ void kasan_unpoison(const void *addr, size_t size, bool init)
 {
 	u8 tag = get_tag(addr);
 
+	if (!kasan_enabled())
+		return;
 	/*
 	 * Perform shadow offset calculation based on untagged address, as
 	 * some of the callers (e.g. kasan_unpoison_new_object) pass tagged
@@ -277,7 +285,8 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
 
 static int __init kasan_memhotplug_init(void)
 {
-	hotplug_memory_notifier(kasan_mem_notifier, DEFAULT_CALLBACK_PRI);
+	if (kasan_enabled())
+		hotplug_memory_notifier(kasan_mem_notifier, DEFAULT_CALLBACK_PRI);
 
 	return 0;
 }
@@ -390,6 +399,9 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
 	unsigned long shadow_start, shadow_end;
 	int ret;
 
+	if (!kasan_enabled())
+		return 0;
+
 	if (!kasan_arch_is_ready())
 		return 0;
 
@@ -560,6 +572,9 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 	unsigned long region_start, region_end;
 	unsigned long size;
 
+	if (!kasan_enabled())
+		return;
+
 	if (!kasan_arch_is_ready())
 		return;
 
@@ -655,6 +670,9 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
 	size_t shadow_size;
 	unsigned long shadow_start;
 
+	if (!kasan_enabled())
+		return 0;
+
 	shadow_start = (unsigned long)kasan_mem_to_shadow(addr);
 	scaled_size = (size + KASAN_GRANULE_SIZE - 1) >>
 				KASAN_SHADOW_SCALE_SHIFT;
@@ -691,6 +709,9 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
 
 void kasan_free_module_shadow(const struct vm_struct *vm)
 {
+	if (!kasan_enabled())
+		return;
+
 	if (IS_ENABLED(CONFIG_UML))
 		return;
 
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index b9382b5b6a37..01f19bc4a326 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -78,6 +78,9 @@ bool kasan_check_range(const void *addr, size_t size, bool write,
 	u8 *shadow_first, *shadow_last, *shadow;
 	void *untagged_addr;
 
+	if (!kasan_enabled())
+		return true;
+
 	if (unlikely(size == 0))
 		return true;
 
-- 
2.41.0


