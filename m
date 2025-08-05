Return-Path: <linux-kernel+bounces-755971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C361B1AE35
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C113178592
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BA521B196;
	Tue,  5 Aug 2025 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gv5JyxEV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321B21ABDB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375050; cv=none; b=jQzDa+aWJJyMKSSk/5hB/1oQQLdGwUPt9Wrep9X4X+XC4UwG2MKWFmx4kBh8kW3bHhdsPsJcXmg0mRCjbOmpL5cp6LLZlJeU1yKNvu2pilYQiekQL7c+X8efVRNiVN1GMseGX10UQXZY5ICPNtdJLVC3Vs+IzzxG1OJSgsIwzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375050; c=relaxed/simple;
	bh=lZ+OKkIOkFuedEaabW32pjJAl9o7rxnfTpjfeGfsgDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=InuKzErvDhj0Xjjgg5q1KqunOUajzzsBA0vUuAa2R93YL0vnIBb/W3hT2vYYOf0vuY/SJO7TYvnndK2sI6auWv56pRCAXUdRiYV7qgXaVej6r/bBlZT1aqlOCAc0LowYQHo0kl1+N2wCasguuvjLmUzQXr6rLFRQMZ81ncEWNfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gv5JyxEV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754375047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+hY2uT3rtX0jxqTDwr4o0wnNu5PQr3WJ9i3CgsATwQ=;
	b=gv5JyxEVKqU1++p8yFiJfgtVZ+ZlJ572dpVtrDyj1qTF7eIfubCmho+XYwM5xFkpZw5eym
	di3wPUbmEa/+0/6EYtIpwPPrF/3ICMj/7bACfvQeRtedAkhlcWwj9qam1kcybNrdzn5g8L
	9yynk81A74fWtA1YWifPC0ZCy1q96J4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-zuByUt8SMlOb-KzlFOuhUA-1; Tue,
 05 Aug 2025 02:24:03 -0400
X-MC-Unique: zuByUt8SMlOb-KzlFOuhUA-1
X-Mimecast-MFC-AGG-ID: zuByUt8SMlOb-KzlFOuhUA_1754375041
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C4B71800366;
	Tue,  5 Aug 2025 06:24:01 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 55DDF1956094;
	Tue,  5 Aug 2025 06:23:55 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/4] mm/kasan: don't initialize kasan if it's disabled
Date: Tue,  5 Aug 2025 14:23:32 +0800
Message-ID: <20250805062333.121553-4-bhe@redhat.com>
In-Reply-To: <20250805062333.121553-1-bhe@redhat.com>
References: <20250805062333.121553-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This is mainly done in all architectures which support kasan, and also
need be done in sw_tags init funciton kasan_init_sw_tags().

And also add code to enable kasan_flag_enabled, this is for later usage.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm/mm/kasan_init.c               | 6 ++++++
 arch/arm64/mm/kasan_init.c             | 7 +++++++
 arch/loongarch/mm/kasan_init.c         | 5 +++++
 arch/powerpc/mm/kasan/init_32.c        | 8 +++++++-
 arch/powerpc/mm/kasan/init_book3e_64.c | 6 ++++++
 arch/powerpc/mm/kasan/init_book3s_64.c | 6 ++++++
 arch/riscv/mm/kasan_init.c             | 6 ++++++
 arch/um/kernel/mem.c                   | 6 ++++++
 arch/x86/mm/kasan_init_64.c            | 6 ++++++
 arch/xtensa/mm/kasan_init.c            | 6 ++++++
 mm/kasan/sw_tags.c                     | 6 ++++++
 11 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 111d4f703136..c764e1b9c9c5 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -212,6 +212,8 @@ void __init kasan_init(void)
 	phys_addr_t pa_start, pa_end;
 	u64 i;
 
+	if (kasan_arg_disabled)
+		return;
 	/*
 	 * We are going to perform proper setup of shadow memory.
 	 *
@@ -300,6 +302,10 @@ void __init kasan_init(void)
 	local_flush_tlb_all();
 
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
+
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	pr_info("Kernel address sanitizer initialized\n");
 	init_task.kasan_depth = 0;
 }
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index d541ce45daeb..0e4ffe3f5d0e 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -384,6 +384,9 @@ void __init kasan_populate_early_vm_area_shadow(void *start, unsigned long size)
 {
 	unsigned long shadow_start, shadow_end;
 
+	if (!kasan_enabled())
+		return;
+
 	if (!is_vmalloc_or_module_addr(start))
 		return;
 
@@ -397,6 +400,9 @@ void __init kasan_populate_early_vm_area_shadow(void *start, unsigned long size)
 
 void __init kasan_init(void)
 {
+	if (kasan_arg_disabled)
+		return;
+
 	kasan_init_shadow();
 	kasan_init_depth();
 #if defined(CONFIG_KASAN_GENERIC)
@@ -405,6 +411,7 @@ void __init kasan_init(void)
 	 * Software and Hardware Tag-Based modes still require
 	 * kasan_init_sw_tags() and kasan_init_hw_tags() correspondingly.
 	 */
+	static_branch_enable(&kasan_flag_enabled);
 	pr_info("KernelAddressSanitizer initialized (generic)\n");
 #endif
 }
diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index d2681272d8f0..0c32eee6910f 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -267,6 +267,8 @@ void __init kasan_init(void)
 	u64 i;
 	phys_addr_t pa_start, pa_end;
 
+	if (kasan_arg_disabled)
+		return;
 	/*
 	 * If PGDIR_SIZE is too large for cpu_vabits, KASAN_SHADOW_END will
 	 * overflow UINTPTR_MAX and then looks like a user space address.
@@ -327,6 +329,9 @@ void __init kasan_init(void)
 	csr_write64(__pa_symbol(swapper_pg_dir), LOONGARCH_CSR_PGDH);
 	local_flush_tlb_all();
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KernelAddressSanitizer initialized.\n");
diff --git a/arch/powerpc/mm/kasan/init_32.c b/arch/powerpc/mm/kasan/init_32.c
index 03666d790a53..b0c465f3fbf5 100644
--- a/arch/powerpc/mm/kasan/init_32.c
+++ b/arch/powerpc/mm/kasan/init_32.c
@@ -141,6 +141,9 @@ void __init kasan_init(void)
 	u64 i;
 	int ret;
 
+	if (kasan_arg_disabled)
+		return;
+
 	for_each_mem_range(i, &base, &end) {
 		phys_addr_t top = min(end, total_lowmem);
 
@@ -163,6 +166,9 @@ void __init kasan_init(void)
 
 	clear_page(kasan_early_shadow_page);
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KASAN init done\n");
@@ -170,7 +176,7 @@ void __init kasan_init(void)
 
 void __init kasan_late_init(void)
 {
-	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
+	if (IS_ENABLED(CONFIG_KASAN_VMALLOC) && kasan_enabled())
 		kasan_unmap_early_shadow_vmalloc();
 }
 
diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/kasan/init_book3e_64.c
index 60c78aac0f63..1e1c10467a2b 100644
--- a/arch/powerpc/mm/kasan/init_book3e_64.c
+++ b/arch/powerpc/mm/kasan/init_book3e_64.c
@@ -111,6 +111,9 @@ void __init kasan_init(void)
 	u64 i;
 	pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page), PAGE_KERNEL_RO);
 
+	if (kasan_arg_disabled)
+		return;
+
 	for_each_mem_range(i, &start, &end)
 		kasan_init_phys_region(phys_to_virt(start), phys_to_virt(end));
 
@@ -125,6 +128,9 @@ void __init kasan_init(void)
 
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	/* Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KASAN init done\n");
diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
index 7d959544c077..9c5cf2354c8b 100644
--- a/arch/powerpc/mm/kasan/init_book3s_64.c
+++ b/arch/powerpc/mm/kasan/init_book3s_64.c
@@ -56,6 +56,9 @@ void __init kasan_init(void)
 	u64 i;
 	pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page), PAGE_KERNEL);
 
+	if (kasan_arg_disabled)
+		return;
+
 	if (!early_radix_enabled()) {
 		pr_warn("KASAN not enabled as it requires radix!");
 		return;
@@ -94,6 +97,9 @@ void __init kasan_init(void)
 
 	static_branch_inc(&powerpc_kasan_enabled_key);
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	/* Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KASAN init done\n");
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 41c635d6aca4..ac3ac227c765 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -485,6 +485,9 @@ void __init kasan_init(void)
 	phys_addr_t p_start, p_end;
 	u64 i;
 
+	if (kasan_arg_disabled)
+		return;
+
 	create_tmp_mapping();
 	csr_write(CSR_SATP, PFN_DOWN(__pa(tmp_pg_dir)) | satp_mode);
 
@@ -531,6 +534,9 @@ void __init kasan_init(void)
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	init_task.kasan_depth = 0;
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
 }
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 76bec7de81b5..6961841daa12 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -26,6 +26,9 @@
 int kasan_um_is_ready;
 void kasan_init(void)
 {
+
+	if (kasan_arg_disabled)
+		return;
 	/*
 	 * kasan_map_memory will map all of the required address space and
 	 * the host machine will allocate physical memory as necessary.
@@ -33,6 +36,9 @@ void kasan_init(void)
 	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
 	init_task.kasan_depth = 0;
 	kasan_um_is_ready = true;
+
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
 }
 
 static void (*kasan_init_ptr)(void)
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0539efd0d216..d7e8c59da435 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -343,6 +343,9 @@ void __init kasan_init(void)
 	unsigned long shadow_cea_begin, shadow_cea_per_cpu_begin, shadow_cea_end;
 	int i;
 
+	if (kasan_arg_disabled)
+		return;
+
 	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
 
 	/*
@@ -450,6 +453,9 @@ void __init kasan_init(void)
 	/* Flush TLBs again to be sure that write protection applied. */
 	__flush_tlb_all();
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	init_task.kasan_depth = 0;
 	pr_info("KernelAddressSanitizer initialized\n");
 }
diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index f39c4d83173a..4a7b77f47225 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -70,6 +70,9 @@ void __init kasan_init(void)
 {
 	int i;
 
+	if (kasan_arg_disabled)
+		return;
+
 	BUILD_BUG_ON(KASAN_SHADOW_OFFSET != KASAN_SHADOW_START -
 		     (KASAN_START_VADDR >> KASAN_SHADOW_SCALE_SHIFT));
 	BUILD_BUG_ON(VMALLOC_START < KASAN_START_VADDR);
@@ -92,6 +95,9 @@ void __init kasan_init(void)
 	local_flush_tlb_all();
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	/* At this point kasan is fully initialized. Enable error messages. */
 	current->kasan_depth = 0;
 	pr_info("KernelAddressSanitizer initialized\n");
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index 01f19bc4a326..dd963ba4d143 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -40,11 +40,17 @@ void __init kasan_init_sw_tags(void)
 {
 	int cpu;
 
+	if (kasan_arg_disabled)
+		return;
+
 	for_each_possible_cpu(cpu)
 		per_cpu(prng_state, cpu) = (u32)get_cycles();
 
 	kasan_init_tags();
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	pr_info("KernelAddressSanitizer initialized (sw-tags, stacktrace=%s)\n",
 		str_on_off(kasan_stack_collection_enabled()));
 }
-- 
2.41.0


