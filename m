Return-Path: <linux-kernel+bounces-830765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F14B9A74D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75D417FC4B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20502313E0C;
	Wed, 24 Sep 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFhr6UCO"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774230BBBD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726034; cv=none; b=ETpNQvMWfpzWBT3sKeDJ1T25C3XQZq1c6mnqrVaKy6q3neLxKd6/miozrgbQW1oFKZDlVapNnNPHi4dHduErDsqUUiwFLsqlBTXVNgt5HIvgytZR7pmifa5z5EvVZHkHGaf6VFMfIPwGOzo8NK/6UYR3J2Ovjnj3PG632eWU+JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726034; c=relaxed/simple;
	bh=qcUdbQm9f0IEEs//mdY+wa1apR9KiQeDm5678H0bicc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JTQPW7pQnjsk3hugdZnRPHsEoFHleaouiPK51XxbaVVC9Ihej165if+E8jVGY3USfWuMbe7V42VKpFPK9kbGPlkhJMgYdA1HeXyil0CKBdIWmt1/7Lb+KfuCbitJjkVvM4lVdJQOdGJhK6oR444Un2KiGC2+FoUrn74aFz2tn3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFhr6UCO; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-63049fca047so4240733a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726030; x=1759330830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5L6wwf2TI57XEfLhcaZXMRQ+L/0zQiVmk9x1OVnFFiI=;
        b=ZFhr6UCOq6AmMkQMh3hxuDH16+PwR/ebFFtT/+bWT6YCQT9+VLY6EXHdCl/TTop7Ps
         bRqtMaO38ftXCN+Z5Nfm8y+vDCAkaa8OG5OfvpxaN/HUjZ2h3YaiO0vYKxaT2U9vHdJN
         A5UgKocdrijqfA0cfP4ZWFm7ZjOGYk1Lry6XJKyKFOQBmxT/bYTFa2ySQb9F9gMqzoDB
         xqOa2rtp3NlmnHK5CWDpt1aUzltsgA/7iIZkQzt7YRHNpUFF5qqSHqepjjwba28NQ9GE
         wf13nDzLnUAr1UPnX0vudsomsoTMn+uQ4yTidf3wfxi7lSl0/nMU7GC4+DSmDI71D+OY
         Dk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726030; x=1759330830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5L6wwf2TI57XEfLhcaZXMRQ+L/0zQiVmk9x1OVnFFiI=;
        b=P8BXfSvHF1EYJBTuUrgYjCJFKrzyyqjixphO/D/CVvM/D2Jegoo+pp8lzks+cgHFCe
         Wz3axxF8BF4uL2X5rMy0EAke0FvwvN54Z2eu1nrOspCt0auImCQ2xxmL1DEE3XFg6kmt
         WvlpJObTo9NRMYvkQV/ubmMF+Atpmj/5T2eXDfitEyI8dFC9gswHfTFieX8wdWYx08S3
         IZxH2saV19AeibL5x0jd72eXAnwA0V0LXQfOm+KTz04Js4nLVew4QpTH9lDV8D9HZRe5
         zyVrhSax2lDgKb0G/yeJJb4et3Auxcy798gsGguDz6+hUXEla6m4mvSsj8KkIf+m1v0t
         bZ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWR1uDd3FhKLzW3yZa0jmVU9lGmhp+ZO4uODxGpgB98hp+YQXv9mSKtk3VS14MdXcr6p07ioeNcSc2uj9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhvXFHtHFi7AXkCD9guW5V17zWaxEsPVEni5mIhakVG74cngQq
	DLPCmtEFs1GM1cQLD47ps6FHxhzNitdZijZQMW4vVMnvPvIOcYPCKdQmwBK4YnlXlRNNTJTA1pH
	DggG74Gph0Y5mYQ==
X-Google-Smtp-Source: AGHT+IHyYgPrnvJDNnriMm16XcgI4Z+GtksLauuH+Ta7oWXXcU6rl19T9F/meDi87vNPoKDDvgmVTSxx+6DjQQ==
X-Received: from eddp6.prod.google.com ([2002:a05:6402:46c6:b0:634:824b:21e0])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1ecd:b0:634:66c8:9e7d with SMTP id 4fb4d7f45d1cf-63467a209bbmr6324885a12.36.1758726029633;
 Wed, 24 Sep 2025 08:00:29 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:56 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-21-2d861768041f@google.com>
Subject: [PATCH 21/21] mm: asi_test: smoke test for [non]sensitive page allocs
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org, 
	david@redhat.com, derkling@google.com, junaids@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com, 
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="utf-8"

Add a simple smoke test for allocating pages of different sensitivities.

Since KUnit doesn't (yet) have infrastructure for this, add custom .init
and .exit hooks to our kunit_suite that detect WARNs by checking the
kernel's taint flags before and after running the tests.

Since ASI is disabled by default, whatever command people currently use
to run KUnit tests probably won't run these tests. Therefore add a new
.kunitconfig file for the x86 tree that explicitly enables ASI. It
should be possible to delete this again when ASI is the default.

So the most straightforward way to run this test is:

tools/testing/kunit/kunit.py run --arch=x86_64 \
	--kunitconfig=arch/x86/.kunitconfig --kernel_args asi=on

The more long-winded way, which lets you customize the kernel config,
is:

mkdir -p .kunit
cp arch/x86/.kunitconfig .kunit
tools/testing/kunit/kunit.py config --arch=x86_64
make O=.kunit menuconfig  # Or debug.config or whatever
tools/testing/kunit/kunit.py run --arch=x86_64 --kernel_args asi=on

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/.kunitconfig  |   7 +++
 arch/x86/Kconfig       |   7 +++
 arch/x86/mm/Makefile   |   2 +
 arch/x86/mm/asi_test.c | 145 +++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/panic.c         |   2 +
 mm/init-mm.c           |   3 +
 6 files changed, 166 insertions(+)

diff --git a/arch/x86/.kunitconfig b/arch/x86/.kunitconfig
new file mode 100644
index 0000000000000000000000000000000000000000..83219e6ecca8d2064aba71fab1f15d57161fa2e4
--- /dev/null
+++ b/arch/x86/.kunitconfig
@@ -0,0 +1,7 @@
+CONFIG_PCI=y
+CONFIG_MMU=y
+CONFIG_64BIT=y
+CONFIG_X86_64=y
+CONFIG_KUNIT=y
+CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION=y
+CONFIG_ASI_KUNIT_TESTS=y
\ No newline at end of file
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cb874c3857cf443c6235e05bc3f070b0ea2686f0..a7b5658ecb1203458e06a0a065bcc7aa7dca8538 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2458,6 +2458,13 @@ config MITIGATION_PAGE_TABLE_ISOLATION
 
 	  See Documentation/arch/x86/pti.rst for more details.
 
+config ASI_KUNIT_TESTS
+	tristate "KUnit tests for ASI" if !KUNIT_ALL_TESTS
+	depends on MITIGATION_ADDRESS_SPACE_ISOLATION && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds the KUnit tests for ASI.
+
 config MITIGATION_RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
 	select OBJTOOL if HAVE_OBJTOOL
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5ecbff70964f61a903ac96cec3736a7cec1221fd..7c36ec7f24ebb285fcfc010004206a57536fc990 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -58,3 +58,5 @@ obj-$(CONFIG_X86_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
+
+obj-$(CONFIG_ASI_KUNIT_TESTS)	+= asi_test.o
diff --git a/arch/x86/mm/asi_test.c b/arch/x86/mm/asi_test.c
new file mode 100644
index 0000000000000000000000000000000000000000..6076a61980ed9daea63113a30e990eb02a7b08d5
--- /dev/null
+++ b/arch/x86/mm/asi_test.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/mm_types.h>
+#include <linux/mm.h>
+#include <linux/pgtable.h>
+#include <linux/set_memory.h>
+#include <linux/sched/mm.h>
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+
+#include <kunit/resource.h>
+#include <kunit/test.h>
+
+#include <asm/asi.h>
+
+struct free_pages_ctx {
+	unsigned int order;
+	struct list_head pages;
+};
+
+static void action_many__free_pages(void *context)
+{
+	struct free_pages_ctx *ctx = context;
+	struct page *page, *tmp;
+
+	list_for_each_entry_safe(page, tmp, &ctx->pages, lru)
+		__free_pages(page, ctx->order);
+}
+
+/*
+ * Allocate a bunch of pages with the same order and GFP flags, transparently
+ * take care of error handling and cleanup. Does this all via a single KUnit
+ * resource, i.e. has a fixed memory overhead.
+ */
+static struct free_pages_ctx *do_many_alloc_pages(struct kunit *test, gfp_t gfp,
+						unsigned int order, unsigned int count)
+{
+	struct free_pages_ctx *ctx = kunit_kzalloc(
+		test, sizeof(struct free_pages_ctx), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	INIT_LIST_HEAD(&ctx->pages);
+	ctx->order = order;
+
+	for (int i = 0; i < count; i++) {
+		struct page *page = alloc_pages(gfp, order);
+
+		if (!page) {
+			struct page *page, *tmp;
+
+			list_for_each_entry_safe(page, tmp, &ctx->pages, lru)
+				__free_pages(page, order);
+
+			KUNIT_FAIL_AND_ABORT(test,
+				"Failed to alloc order %d page (GFP *%pG) iter %d",
+				order, &gfp, i);
+		}
+		list_add(&page->lru, &ctx->pages);
+	}
+
+	KUNIT_ASSERT_EQ(test,
+		kunit_add_action_or_reset(test, action_many__free_pages, ctx), 0);
+	return ctx;
+}
+
+/*
+ * Do some allocations that force the allocator to change the sensitivity of
+ * some blocks.
+ */
+static void test_alloc_sensitive_nonsensitive(struct kunit *test)
+{
+	unsigned long page_majority;
+	struct free_pages_ctx *ctx;
+	gfp_t gfp = GFP_KERNEL | __GFP_THISNODE;
+	struct page *page;
+
+	if (!cpu_feature_enabled(X86_FEATURE_ASI))
+		kunit_skip(test, "ASI off. Set asi=on in kernel cmdline\n");
+
+	/* No cleanup here - assuming kthread "belongs" to this test. */
+	set_cpus_allowed_ptr(current, cpumask_of_node(numa_node_id()));
+
+	/*
+	 * First allocate more than half of the memory in the node as
+	 * nonsensitive. Assuming the memory starts out unmapped, this should
+	 * exercise the sensitive->nonsensitive flip already.
+	 */
+	page_majority = (node_present_pages(numa_node_id()) / 2) + 1;
+	ctx = do_many_alloc_pages(test, gfp, 0, page_majority);
+
+	/* Check pages are mapped */
+	list_for_each_entry(page, &ctx->pages, lru) {
+		/*
+		 * Logically it should be an EXPECT, but that would cause heavy
+		 * log spam on failure so use ASSERT for concision.
+		 */
+		KUNIT_ASSERT_FALSE(test, direct_map_sensitive(page));
+	}
+
+	/*
+	 * Now free them again and allocate the same amount as sensitive.
+	 * This will exercise the nonsensitive->sensitive flip.
+	 */
+	kunit_release_action(test, action_many__free_pages, ctx);
+	gfp |= __GFP_SENSITIVE;
+	ctx = do_many_alloc_pages(test, gfp, 0, page_majority);
+
+	/* Check pages are unmapped */
+	list_for_each_entry(page, &ctx->pages, lru)
+		KUNIT_ASSERT_TRUE(test, direct_map_sensitive(page));
+}
+
+static struct kunit_case asi_test_cases[] = {
+	KUNIT_CASE(test_alloc_sensitive_nonsensitive),
+	{}
+};
+
+static unsigned long taint_pre;
+
+static int store_taint_pre(struct kunit *test)
+{
+	taint_pre = get_taint();
+	return 0;
+}
+
+static void check_taint_post(struct kunit *test)
+{
+	unsigned long new_taint = get_taint() & ~taint_pre;
+
+	KUNIT_EXPECT_EQ_MSG(test, new_taint, 0,
+		"Kernel newly tainted after test. Maybe a WARN?");
+}
+
+static struct kunit_suite asi_test_suite = {
+	.name = "asi",
+	.init = store_taint_pre,
+	.exit = check_taint_post,
+	.test_cases = asi_test_cases,
+};
+
+kunit_test_suite(asi_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
diff --git a/kernel/panic.c b/kernel/panic.c
index d9c7cd09aeb9fe22f05e0b05d26555e20e502d2f..6aa79c5192520af55cd473912d2ac802de687304 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -39,6 +39,7 @@
 #include <linux/sys_info.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
+#include <kunit/visibility.h>
 
 #define PANIC_TIMER_STEP 100
 #define PANIC_BLINK_SPD 18
@@ -737,6 +738,7 @@ unsigned long get_taint(void)
 {
 	return tainted_mask;
 }
+EXPORT_SYMBOL_IF_KUNIT(get_taint);
 
 /**
  * add_taint: add a taint flag if not already set.
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 4600e7605cab43b4bce24b85ec1667db8b92dc80..456b8f7d2ab3bd7963a51908dff76713a4e65ab5 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -13,6 +13,8 @@
 #include <linux/iommu.h>
 #include <asm/mmu.h>
 
+#include <kunit/visibility.h>
+
 #ifndef INIT_MM_CONTEXT
 #define INIT_MM_CONTEXT(name)
 #endif
@@ -47,6 +49,7 @@ struct mm_struct init_mm = {
 	.cpu_bitmap	= CPU_BITS_NONE,
 	INIT_MM_CONTEXT(init_mm)
 };
+EXPORT_SYMBOL_IF_KUNIT(init_mm);
 
 void setup_initial_init_mm(void *start_code, void *end_code,
 			   void *end_data, void *brk)

-- 
2.50.1


