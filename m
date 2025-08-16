Return-Path: <linux-kernel+bounces-771958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17522B28D3C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 13:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE731C85CC4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1995288529;
	Sat, 16 Aug 2025 11:00:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68EC277C9A;
	Sat, 16 Aug 2025 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755342036; cv=none; b=jA+rs7oHVmOKoyB3hHVYKuK19GYBJMaYe58dqsY4tdHt91Y78meyA0yi145JuWSxQFhqWXppTePsRik52eqUQdOZebJwi5Eu8p2b/lhzI5RALq0hFqw4t/HX/6jvmUkPNUVAh/U0t/6s8W1LxEVPBLQp1wspoj4hvqFNxebzUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755342036; c=relaxed/simple;
	bh=3M5ABGMeZjkfDL36B/m+oPqKT1lH0DaTgTGxSnGjW6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F7FLxQis+SjAPxy+jGuRnLAmy+FDIx6+1aeR+gi7pEniVAQ/ovP/DtALAg2aYGIGHWQLHuj6zo/fNOwdavtTjIxJXgDsvut8Ln7Lw5YXtVQewklDDk4nVSdko9rMKDY93GSMshYcDjmbvO3TIIY6DtzOTqyP7WPKOOdcwDXL0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D22CA1FC4;
	Sat, 16 Aug 2025 04:00:24 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08D4E3F5A1;
	Sat, 16 Aug 2025 04:00:28 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	akpm@linux-foundation.org,
	scott@os.amperecomputing.com,
	jhubbard@nvidia.com,
	pankaj.gupta@amd.com,
	leitao@debian.org,
	kaleshsingh@google.com,
	maz@kernel.org,
	broonie@kernel.org,
	oliver.upton@linux.dev,
	james.morse@arm.com,
	ardb@kernel.org,
	hardevsinh.palaniya@siliconsignals.io,
	david@redhat.com,
	yang@os.amperecomputing.com
Cc: kasan-dev@googlegroups.com,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v3 2/2] kasan: apply write-only mode in kasan kunit testcases
Date: Sat, 16 Aug 2025 12:00:18 +0100
Message-Id: <20250816110018.4055617-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816110018.4055617-1-yeoreum.yun@arm.com>
References: <20250816110018.4055617-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When KASAN is configured in write-only mode,
fetch/load operations do not trigger tag check faults.

As a result, the outcome of some test cases may differ
compared to when KASAN is configured without write-only mode.

Therefore, by modifying pre-exist testcases
check the write only makes tag check fault (TCF) where
writing is perform in "allocated memory" but tag is invalid
(i.e) redzone write in atomic_set() testcases.
Otherwise check the invalid fetch/read doesn't generate TCF.

Also, skip some testcases affected by initial value
(i.e) atomic_cmpxchg() testcase maybe successd if
it passes valid atomic_t address and invalid oldaval address.
In this case, if invalid atomic_t doesn't have the same oldval,
it won't trigger write operation so the test will pass.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 mm/kasan/kasan_test_c.c | 237 +++++++++++++++++++++++++++-------------
 1 file changed, 162 insertions(+), 75 deletions(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 2aa12dfa427a..8cf93715fdac 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -94,11 +94,13 @@ static void kasan_test_exit(struct kunit *test)
 }
 
 /**
- * KUNIT_EXPECT_KASAN_FAIL - check that the executed expression produces a
- * KASAN report; causes a KUnit test failure otherwise.
+ * _KUNIT_EXPECT_KASAN_TEMPLATE - check that the executed expression produces
+ * a KASAN report or not; a KUnit test failure when it's different from @produce.
  *
  * @test: Currently executing KUnit test.
- * @expression: Expression that must produce a KASAN report.
+ * @expr: Expression produce a KASAN report or not.
+ * @expr_str: Expression string
+ * @produce: expression should produce a KASAN report.
  *
  * For hardware tag-based KASAN, when a synchronous tag fault happens, tag
  * checking is auto-disabled. When this happens, this test handler reenables
@@ -110,25 +112,29 @@ static void kasan_test_exit(struct kunit *test)
  * Use READ/WRITE_ONCE() for the accesses and compiler barriers around the
  * expression to prevent that.
  *
- * In between KUNIT_EXPECT_KASAN_FAIL checks, test_status.report_found is kept
+ * In between _KUNIT_EXPECT_KASAN_TEMPLATE checks, test_status.report_found is kept
  * as false. This allows detecting KASAN reports that happen outside of the
  * checks by asserting !test_status.report_found at the start of
- * KUNIT_EXPECT_KASAN_FAIL and in kasan_test_exit.
+ * _KUNIT_EXPECT_KASAN_TEMPLATE and in kasan_test_exit.
  */
-#define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {			\
+#define _KUNIT_EXPECT_KASAN_TEMPLATE(test, expr, expr_str, produce)	\
+do {									\
 	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&				\
 	    kasan_sync_fault_possible())				\
 		migrate_disable();					\
 	KUNIT_EXPECT_FALSE(test, READ_ONCE(test_status.report_found));	\
 	barrier();							\
-	expression;							\
+	expr;								\
 	barrier();							\
 	if (kasan_async_fault_possible())				\
 		kasan_force_async_fault();				\
-	if (!READ_ONCE(test_status.report_found)) {			\
-		KUNIT_FAIL(test, KUNIT_SUBTEST_INDENT "KASAN failure "	\
-				"expected in \"" #expression		\
-				 "\", but none occurred");		\
+	if (READ_ONCE(test_status.report_found) != produce) {		\
+		KUNIT_FAIL(test, KUNIT_SUBTEST_INDENT "KASAN %s "	\
+				"expected in \"" expr_str		\
+				 "\", but %soccurred",			\
+				(produce ? "failure" : "success"),	\
+				(test_status.report_found ?		\
+				 "" : "none "));			\
 	}								\
 	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&				\
 	    kasan_sync_fault_possible()) {				\
@@ -141,6 +147,29 @@ static void kasan_test_exit(struct kunit *test)
 	WRITE_ONCE(test_status.async_fault, false);			\
 } while (0)
 
+/*
+ * KUNIT_EXPECT_KASAN_FAIL - check that the executed expression produces a
+ * KASAN report; causes a KUnit test failure otherwise.
+ *
+ * @test: Currently executing KUnit test.
+ * @expr: Expression produce a KASAN report.
+ */
+#define KUNIT_EXPECT_KASAN_FAIL(test, expr)			\
+	_KUNIT_EXPECT_KASAN_TEMPLATE(test, expr, #expr, true)
+
+/*
+ * KUNIT_EXPECT_KASAN_FAIL_READ - check that the executed expression produces
+ * a KASAN report for read access.
+ * It causes a KUnit test failure. if KASAN report isn't produced for read access.
+ * For write access, it cause a KUnit test failure if a KASAN report is produced
+ *
+ * @test: Currently executing KUnit test.
+ * @expr: Expression doesn't produce a KASAN report.
+ */
+#define KUNIT_EXPECT_KASAN_FAIL_READ(test, expr)			\
+	_KUNIT_EXPECT_KASAN_TEMPLATE(test, expr, #expr,			\
+			!kasan_write_only_enabled())			\
+
 #define KASAN_TEST_NEEDS_CONFIG_ON(test, config) do {			\
 	if (!IS_ENABLED(config))					\
 		kunit_skip((test), "Test requires " #config "=y");	\
@@ -183,8 +212,8 @@ static void kmalloc_oob_right(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr[size + 5] = 'y');
 
 	/* Out-of-bounds access past the aligned kmalloc object. */
-	KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] =
-					ptr[size + KASAN_GRANULE_SIZE + 5]);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, ptr[0] =
+			ptr[size + KASAN_GRANULE_SIZE + 5]);
 
 	kfree(ptr);
 }
@@ -198,7 +227,8 @@ static void kmalloc_oob_left(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	OPTIMIZER_HIDE_VAR(ptr);
-	KUNIT_EXPECT_KASAN_FAIL(test, *ptr = *(ptr - 1));
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, *ptr = *(ptr - 1));
+
 	kfree(ptr);
 }
 
@@ -211,7 +241,8 @@ static void kmalloc_node_oob_right(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	OPTIMIZER_HIDE_VAR(ptr);
-	KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = ptr[size]);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, ptr[0] = ptr[size]);
+
 	kfree(ptr);
 }
 
@@ -291,7 +322,7 @@ static void kmalloc_large_uaf(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 	kfree(ptr);
 
-	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, ((volatile char *)ptr)[0]);
 }
 
 static void kmalloc_large_invalid_free(struct kunit *test)
@@ -323,7 +354,8 @@ static void page_alloc_oob_right(struct kunit *test)
 	ptr = page_address(pages);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
-	KUNIT_EXPECT_KASAN_FAIL(test, ptr[0] = ptr[size]);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, ptr[0] = ptr[size]);
+
 	free_pages((unsigned long)ptr, order);
 }
 
@@ -338,7 +370,7 @@ static void page_alloc_uaf(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 	free_pages((unsigned long)ptr, order);
 
-	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, ((volatile char *)ptr)[0]);
 }
 
 static void krealloc_more_oob_helper(struct kunit *test,
@@ -455,10 +487,10 @@ static void krealloc_uaf(struct kunit *test)
 	ptr1 = kmalloc(size1, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
 	kfree(ptr1);
-
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr2 = krealloc(ptr1, size2, GFP_KERNEL));
 	KUNIT_ASSERT_NULL(test, ptr2);
-	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)ptr1);
+
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, *(volatile char *)ptr1);
 }
 
 static void kmalloc_oob_16(struct kunit *test)
@@ -501,7 +533,8 @@ static void kmalloc_uaf_16(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
 	kfree(ptr2);
 
-	KUNIT_EXPECT_KASAN_FAIL(test, *ptr1 = *ptr2);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, *ptr1 = *ptr2);
+
 	kfree(ptr1);
 }
 
@@ -640,8 +673,10 @@ static void kmalloc_memmove_invalid_size(struct kunit *test)
 	memset((char *)ptr, 0, 64);
 	OPTIMIZER_HIDE_VAR(ptr);
 	OPTIMIZER_HIDE_VAR(invalid_size);
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		memmove((char *)ptr, (char *)ptr + 4, invalid_size));
+
+	KUNIT_EXPECT_KASAN_FAIL_READ(test,
+			memmove((char *)ptr, (char *)ptr + 4, invalid_size));
+
 	kfree(ptr);
 }
 
@@ -654,7 +689,8 @@ static void kmalloc_uaf(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
 	kfree(ptr);
-	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[8]);
+
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, ((volatile char *)ptr)[8]);
 }
 
 static void kmalloc_uaf_memset(struct kunit *test)
@@ -701,7 +737,8 @@ static void kmalloc_uaf2(struct kunit *test)
 		goto again;
 	}
 
-	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr1)[40]);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, ((volatile char *)ptr1)[40]);
+
 	KUNIT_EXPECT_PTR_NE(test, ptr1, ptr2);
 
 	kfree(ptr2);
@@ -727,19 +764,19 @@ static void kmalloc_uaf3(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
 	kfree(ptr2);
 
-	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr1)[8]);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, ((volatile char *)ptr1)[8]);
 }
 
 static void kasan_atomics_helper(struct kunit *test, void *unsafe, void *safe)
 {
 	int *i_unsafe = unsafe;
 
-	KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*i_unsafe));
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, READ_ONCE(*i_unsafe));
+
 	KUNIT_EXPECT_KASAN_FAIL(test, WRITE_ONCE(*i_unsafe, 42));
-	KUNIT_EXPECT_KASAN_FAIL(test, smp_load_acquire(i_unsafe));
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, smp_load_acquire(i_unsafe));
 	KUNIT_EXPECT_KASAN_FAIL(test, smp_store_release(i_unsafe, 42));
-
-	KUNIT_EXPECT_KASAN_FAIL(test, atomic_read(unsafe));
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, atomic_read(unsafe));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_set(unsafe, 42));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_add(42, unsafe));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub(42, unsafe));
@@ -752,18 +789,35 @@ static void kasan_atomics_helper(struct kunit *test, void *unsafe, void *safe)
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_xchg(unsafe, 42));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_cmpxchg(unsafe, 21, 42));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(unsafe, safe, 42));
-	KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(safe, unsafe, 42));
+
+	/*
+	 * The result of the test below may vary due to garbage values of unsafe in
+	 * store-only mode. Therefore, skip this test when KASAN is configured
+	 * in store-only mode.
+	 */
+	if (!kasan_write_only_enabled())
+		KUNIT_EXPECT_KASAN_FAIL(test, atomic_try_cmpxchg(safe, unsafe, 42));
+
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_sub_and_test(42, unsafe));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_and_test(unsafe));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_and_test(unsafe));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_negative(42, unsafe));
-	KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_unless(unsafe, 21, 42));
-	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_not_zero(unsafe));
-	KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_unless_negative(unsafe));
-	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_unless_positive(unsafe));
-	KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_if_positive(unsafe));
 
-	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_read(unsafe));
+	/*
+	 * The result of the test below may vary due to garbage values of unsafe in
+	 * store-only mode. Therefore, skip this test when KASAN is configured
+	 * in store-only mode.
+	 */
+	if (!kasan_write_only_enabled()) {
+		KUNIT_EXPECT_KASAN_FAIL(test, atomic_add_unless(unsafe, 21, 42));
+		KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_not_zero(unsafe));
+		KUNIT_EXPECT_KASAN_FAIL(test, atomic_inc_unless_negative(unsafe));
+		KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_unless_positive(unsafe));
+		KUNIT_EXPECT_KASAN_FAIL(test, atomic_dec_if_positive(unsafe));
+	}
+
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, atomic_long_read(unsafe));
+
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_set(unsafe, 42));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add(42, unsafe));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_sub(42, unsafe));
@@ -776,16 +830,32 @@ static void kasan_atomics_helper(struct kunit *test, void *unsafe, void *safe)
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_xchg(unsafe, 42));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_cmpxchg(unsafe, 21, 42));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_try_cmpxchg(unsafe, safe, 42));
-	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_try_cmpxchg(safe, unsafe, 42));
+
+	/*
+	 * The result of the test below may vary due to garbage values in
+	 * store-only mode. Therefore, skip this test when KASAN is configured
+	 * in store-only mode.
+	 */
+	if (!kasan_write_only_enabled())
+		KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_try_cmpxchg(safe, unsafe, 42));
+
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_sub_and_test(42, unsafe));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_and_test(unsafe));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_and_test(unsafe));
 	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add_negative(42, unsafe));
-	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add_unless(unsafe, 21, 42));
-	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_not_zero(unsafe));
-	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_unless_negative(unsafe));
-	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_unless_positive(unsafe));
-	KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_if_positive(unsafe));
+
+	/*
+	 * The result of the test below may vary due to garbage values in
+	 * store-only mode. Therefore, skip this test when KASAN is configured
+	 * in store-only mode.
+	 */
+	if (!kasan_write_only_enabled()) {
+		KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_add_unless(unsafe, 21, 42));
+		KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_not_zero(unsafe));
+		KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_inc_unless_negative(unsafe));
+		KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_unless_positive(unsafe));
+		KUNIT_EXPECT_KASAN_FAIL(test, atomic_long_dec_if_positive(unsafe));
+	}
 }
 
 static void kasan_atomics(struct kunit *test)
@@ -842,8 +912,9 @@ static void ksize_unpoisons_memory(struct kunit *test)
 	/* These must trigger a KASAN report. */
 	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
 		KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
-	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size + 5]);
-	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size - 1]);
+
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, ((volatile char *)ptr)[size + 5]);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, ((volatile char *)ptr)[real_size - 1]);
 
 	kfree(ptr);
 }
@@ -863,8 +934,8 @@ static void ksize_uaf(struct kunit *test)
 
 	OPTIMIZER_HIDE_VAR(ptr);
 	KUNIT_EXPECT_KASAN_FAIL(test, ksize(ptr));
-	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
-	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, ((volatile char *)ptr)[0]);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, ((volatile char *)ptr)[size]);
 }
 
 /*
@@ -886,6 +957,7 @@ static void rcu_uaf_reclaim(struct rcu_head *rp)
 		container_of(rp, struct kasan_rcu_info, rcu);
 
 	kfree(fp);
+
 	((volatile struct kasan_rcu_info *)fp)->i;
 }
 
@@ -899,9 +971,9 @@ static void rcu_uaf(struct kunit *test)
 	global_rcu_ptr = rcu_dereference_protected(
 				(struct kasan_rcu_info __rcu *)ptr, NULL);
 
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		call_rcu(&global_rcu_ptr->rcu, rcu_uaf_reclaim);
-		rcu_barrier());
+	KUNIT_EXPECT_KASAN_FAIL_READ(test,
+			call_rcu(&global_rcu_ptr->rcu, rcu_uaf_reclaim);
+			rcu_barrier());
 }
 
 static void workqueue_uaf_work(struct work_struct *work)
@@ -924,8 +996,8 @@ static void workqueue_uaf(struct kunit *test)
 	queue_work(workqueue, work);
 	destroy_workqueue(workqueue);
 
-	KUNIT_EXPECT_KASAN_FAIL(test,
-		((volatile struct work_struct *)work)->data);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test,
+			((volatile struct work_struct *)work)->data);
 }
 
 static void kfree_via_page(struct kunit *test)
@@ -972,7 +1044,7 @@ static void kmem_cache_oob(struct kunit *test)
 		return;
 	}
 
-	KUNIT_EXPECT_KASAN_FAIL(test, *p = p[size + OOB_TAG_OFF]);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, *p = p[size + OOB_TAG_OFF]);
 
 	kmem_cache_free(cache, p);
 	kmem_cache_destroy(cache);
@@ -1068,7 +1140,7 @@ static void kmem_cache_rcu_uaf(struct kunit *test)
 	 */
 	rcu_barrier();
 
-	KUNIT_EXPECT_KASAN_FAIL(test, READ_ONCE(*p));
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, READ_ONCE(*p));
 
 	kmem_cache_destroy(cache);
 }
@@ -1207,7 +1279,7 @@ static void mempool_oob_right_helper(struct kunit *test, mempool_t *pool, size_t
 		KUNIT_EXPECT_KASAN_FAIL(test,
 			((volatile char *)&elem[size])[0]);
 	else
-		KUNIT_EXPECT_KASAN_FAIL(test,
+		KUNIT_EXPECT_KASAN_FAIL_READ(test,
 			((volatile char *)&elem[round_up(size, KASAN_GRANULE_SIZE)])[0]);
 
 	mempool_free(elem, pool);
@@ -1273,7 +1345,8 @@ static void mempool_uaf_helper(struct kunit *test, mempool_t *pool, bool page)
 	mempool_free(elem, pool);
 
 	ptr = page ? page_address((struct page *)elem) : elem;
-	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
+
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, ((volatile char *)ptr)[0]);
 }
 
 static void mempool_kmalloc_uaf(struct kunit *test)
@@ -1532,7 +1605,8 @@ static void kasan_memchr(struct kunit *test)
 
 	OPTIMIZER_HIDE_VAR(ptr);
 	OPTIMIZER_HIDE_VAR(size);
-	KUNIT_EXPECT_KASAN_FAIL(test,
+
+	KUNIT_EXPECT_KASAN_FAIL_READ(test,
 		kasan_ptr_result = memchr(ptr, '1', size + 1));
 
 	kfree(ptr);
@@ -1559,8 +1633,10 @@ static void kasan_memcmp(struct kunit *test)
 
 	OPTIMIZER_HIDE_VAR(ptr);
 	OPTIMIZER_HIDE_VAR(size);
-	KUNIT_EXPECT_KASAN_FAIL(test,
+
+	KUNIT_EXPECT_KASAN_FAIL_READ(test,
 		kasan_int_result = memcmp(ptr, arr, size+1));
+
 	kfree(ptr);
 }
 
@@ -1594,7 +1670,7 @@ static void kasan_strings(struct kunit *test)
 			strscpy(ptr, src + 1, KASAN_GRANULE_SIZE));
 
 	/* strscpy should fail if the first byte is unreadable. */
-	KUNIT_EXPECT_KASAN_FAIL(test, strscpy(ptr, src + KASAN_GRANULE_SIZE,
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, strscpy(ptr, src + KASAN_GRANULE_SIZE,
 					      KASAN_GRANULE_SIZE));
 
 	kfree(src);
@@ -1607,17 +1683,13 @@ static void kasan_strings(struct kunit *test)
 	 * will likely point to zeroed byte.
 	 */
 	ptr += 16;
-	KUNIT_EXPECT_KASAN_FAIL(test, kasan_ptr_result = strchr(ptr, '1'));
 
-	KUNIT_EXPECT_KASAN_FAIL(test, kasan_ptr_result = strrchr(ptr, '1'));
-
-	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = strcmp(ptr, "2"));
-
-	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = strncmp(ptr, "2", 1));
-
-	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = strlen(ptr));
-
-	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = strnlen(ptr, 1));
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, kasan_ptr_result = strchr(ptr, '1'));
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, kasan_ptr_result = strrchr(ptr, '1'));
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, kasan_int_result = strcmp(ptr, "2"));
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, kasan_int_result = strncmp(ptr, "2", 1));
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, kasan_int_result = strlen(ptr));
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, kasan_int_result = strnlen(ptr, 1));
 }
 
 static void kasan_bitops_modify(struct kunit *test, int nr, void *addr)
@@ -1636,12 +1708,22 @@ static void kasan_bitops_test_and_modify(struct kunit *test, int nr, void *addr)
 {
 	KUNIT_EXPECT_KASAN_FAIL(test, test_and_set_bit(nr, addr));
 	KUNIT_EXPECT_KASAN_FAIL(test, __test_and_set_bit(nr, addr));
-	KUNIT_EXPECT_KASAN_FAIL(test, test_and_set_bit_lock(nr, addr));
+
+	/*
+	 * When KASAN is running in store-only mode,
+	 * a fault won't occur when the bit is set.
+	 * Therefore, skip the test_and_set_bit_lock test in store-only mode.
+	 */
+	if (!kasan_write_only_enabled())
+		KUNIT_EXPECT_KASAN_FAIL(test, test_and_set_bit_lock(nr, addr));
+
 	KUNIT_EXPECT_KASAN_FAIL(test, test_and_clear_bit(nr, addr));
 	KUNIT_EXPECT_KASAN_FAIL(test, __test_and_clear_bit(nr, addr));
 	KUNIT_EXPECT_KASAN_FAIL(test, test_and_change_bit(nr, addr));
 	KUNIT_EXPECT_KASAN_FAIL(test, __test_and_change_bit(nr, addr));
-	KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result = test_bit(nr, addr));
+
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, kasan_int_result = test_bit(nr, addr));
+
 	if (nr < 7)
 		KUNIT_EXPECT_KASAN_FAIL(test, kasan_int_result =
 				xor_unlock_is_negative_byte(1 << nr, addr));
@@ -1765,7 +1847,7 @@ static void vmalloc_oob(struct kunit *test)
 		KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v_ptr)[size]);
 
 	/* An aligned access into the first out-of-bounds granule. */
-	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)v_ptr)[size + 5]);
+	KUNIT_EXPECT_KASAN_FAIL_READ(test, ((volatile char *)v_ptr)[size + 5]);
 
 	/* Check that in-bounds accesses to the physical page are valid. */
 	page = vmalloc_to_page(v_ptr);
@@ -2042,15 +2124,20 @@ static void copy_user_test_oob(struct kunit *test)
 
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		unused = copy_from_user(kmem, usermem, size + 1));
-	KUNIT_EXPECT_KASAN_FAIL(test,
+
+	KUNIT_EXPECT_KASAN_FAIL_READ(test,
 		unused = copy_to_user(usermem, kmem, size + 1));
+
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		unused = __copy_from_user(kmem, usermem, size + 1));
-	KUNIT_EXPECT_KASAN_FAIL(test,
+
+	KUNIT_EXPECT_KASAN_FAIL_READ(test,
 		unused = __copy_to_user(usermem, kmem, size + 1));
+
 	KUNIT_EXPECT_KASAN_FAIL(test,
 		unused = __copy_from_user_inatomic(kmem, usermem, size + 1));
-	KUNIT_EXPECT_KASAN_FAIL(test,
+
+	KUNIT_EXPECT_KASAN_FAIL_READ(test,
 		unused = __copy_to_user_inatomic(usermem, kmem, size + 1));
 
 	/*
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


