Return-Path: <linux-kernel+bounces-724245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A1CAFF061
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E70562BC1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B795E238C20;
	Wed,  9 Jul 2025 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLDec0iU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8E8235050
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084218; cv=none; b=G2rISzskSSREkG4n2gcS+kzg/q6eU6f7GrTAi3LwS51u8grJ1Ud3xy44iYeXhhg836detd9EWSmke40AKLs90NG6gAu5RQdb4DLRYSxHnLmOuMjKDDTzfPTpQYqiQUEodN7yQQ7xO8aQbiKWV+kZ7SWQRqQ3KsqHPa04Ct9+/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084218; c=relaxed/simple;
	bh=I8lESwgVV2YmCOlO1spzAwAlpxikzidKRjeQ4dBVCoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KiFlODcLLOIe5CtYVG51Kx3y7LULkHwJt9RMX7MZ4PDwWMGPU/bJAczTlYki7KqIfvIQoc1Una0knHR1Hz+SMxCBs+a4jLZss9vbiVEIat6xaK8Dly/j8LVhamLXahPXqOmeeoC6Q2JI42tLIuwaCro5Fd4hFb7IZqUXKW9S6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLDec0iU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4B8C4CEF4;
	Wed,  9 Jul 2025 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752084217;
	bh=I8lESwgVV2YmCOlO1spzAwAlpxikzidKRjeQ4dBVCoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dLDec0iUaqX31hf62P3fe76Mb+XtWtkWsBkc2IvUhTxYhlsQG1aj1xMfvr3Ax4tgs
	 cwMKrd9EbdAZ2PEk7EII5hhMZQEhws9IrIwHkBUortBxyJ2UnAyfSkvMyBxc+ciqZH
	 7dfAlnDlKkLE7sFl/9ee5T381ypM4RPMOCNYKY8f4DxzE4+o8zefReVNiNhH4mQqld
	 C3dJuh+sElsQ6+Ma7CxCfGN6+nyCh8Iup2J39DcLdjZ+l9qzhyWhIchOQybGS3YWKV
	 7horklqCmPwTM1je4VX48ZKpMEPc2VBqTO17IoD1zTHNAPdupzU5ORbCr32W5e+16/
	 TAXXwD0Uxv+xw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1AB2BCE0B9F; Wed,  9 Jul 2025 11:03:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jon Pan-Doh <pandoh@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v6 1/3] lib: Add trivial kunit test for ratelimit
Date: Wed,  9 Jul 2025 11:03:33 -0700
Message-Id: <20250709180335.1716384-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d1007957-97ff-4f6f-92ac-606f68c65dfa@paulmck-laptop>
References: <d1007957-97ff-4f6f-92ac-606f68c65dfa@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple single-threaded smoke test for lib/ratelimit.c

To run on x86:

	make ARCH=x86_64 mrproper
	./tools/testing/kunit/kunit.py run --arch x86_64 --kconfig_add CONFIG_RATELIMIT_KUNIT_TEST=y --kconfig_add CONFIG_SMP=y lib_ratelimit

This will fail on old ___ratelimit(), and subsequent patches provide
the fixes that are required.

[ paulmck:  Apply timeout and kunit feedback from Petr Mladek. ]

Link: https://lore.kernel.org/all/fbe93a52-365e-47fe-93a4-44a44547d601@paulmck-laptop/
Link: https://lore.kernel.org/all/20250423115409.3425-1-spasswolf@web.de/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 lib/Kconfig.debug          | 11 ++++++
 lib/tests/Makefile         |  1 +
 lib/tests/test_ratelimit.c | 79 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 lib/tests/test_ratelimit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ebe33181b6e6e..d69d27f808340 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3225,6 +3225,17 @@ config TEST_OBJPOOL
 
 	  If unsure, say N.
 
+config RATELIMIT_KUNIT_TEST
+	tristate "KUnit Test for correctness and stress of ratelimit" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the "test_ratelimit" module that should be used
+	  for correctness verification and concurrent testings of rate
+	  limiting.
+
+	  If unsure, say N.
+
 config INT_POW_KUNIT_TEST
 	tristate "Integer exponentiation (int_pow) test" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 56d6450144828..3edc30a515840 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -46,5 +46,6 @@ obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
 obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
 obj-$(CONFIG_USERCOPY_KUNIT_TEST) += usercopy_kunit.o
 obj-$(CONFIG_UTIL_MACROS_KUNIT) += util_macros_kunit.o
+obj-$(CONFIG_RATELIMIT_KUNIT_TEST) += test_ratelimit.o
 
 obj-$(CONFIG_TEST_RUNTIME_MODULE)		+= module/
diff --git a/lib/tests/test_ratelimit.c b/lib/tests/test_ratelimit.c
new file mode 100644
index 0000000000000..0374107f5ea89
--- /dev/null
+++ b/lib/tests/test_ratelimit.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <kunit/test.h>
+
+#include <linux/ratelimit.h>
+#include <linux/module.h>
+
+/* a simple boot-time regression test */
+
+#define TESTRL_INTERVAL (5 * HZ)
+static DEFINE_RATELIMIT_STATE(testrl, TESTRL_INTERVAL, 3);
+
+#define test_ratelimited(test, expected) \
+	KUNIT_ASSERT_EQ(test, ___ratelimit(&testrl, "test_ratelimit_smoke"), (expected))
+
+static void test_ratelimit_smoke(struct kunit *test)
+{
+	// Check settings.
+	KUNIT_ASSERT_GE(test, TESTRL_INTERVAL, 100);
+
+	// Test normal operation.
+	test_ratelimited(test, true);
+	test_ratelimited(test, true);
+	test_ratelimited(test, true);
+	test_ratelimited(test, false);
+
+	schedule_timeout_idle(TESTRL_INTERVAL - 40);
+	test_ratelimited(test, false);
+
+	schedule_timeout_idle(50);
+	test_ratelimited(test, true);
+
+	schedule_timeout_idle(2 * TESTRL_INTERVAL);
+	test_ratelimited(test, true);
+	test_ratelimited(test, true);
+
+	schedule_timeout_idle(TESTRL_INTERVAL - 40);
+	test_ratelimited(test, true);
+	schedule_timeout_idle(50);
+	test_ratelimited(test, true);
+	test_ratelimited(test, true);
+	test_ratelimited(test, true);
+	test_ratelimited(test, false);
+
+	// Test disabling.
+	testrl.burst = 0;
+	test_ratelimited(test, false);
+	testrl.burst = 2;
+	testrl.interval = 0;
+	test_ratelimited(test, true);
+	test_ratelimited(test, true);
+	test_ratelimited(test, true);
+	test_ratelimited(test, true);
+	test_ratelimited(test, true);
+	test_ratelimited(test, true);
+	test_ratelimited(test, true);
+
+	// Testing re-enabling.
+	testrl.interval = TESTRL_INTERVAL;
+	test_ratelimited(test, true);
+	test_ratelimited(test, true);
+	test_ratelimited(test, false);
+	test_ratelimited(test, false);
+}
+
+static struct kunit_case sort_test_cases[] = {
+	KUNIT_CASE_SLOW(test_ratelimit_smoke),
+	{}
+};
+
+static struct kunit_suite ratelimit_test_suite = {
+	.name = "lib_ratelimit",
+	.test_cases = sort_test_cases,
+};
+
+kunit_test_suites(&ratelimit_test_suite);
+
+MODULE_DESCRIPTION("___ratelimit() KUnit test suite");
+MODULE_LICENSE("GPL");
-- 
2.40.1


