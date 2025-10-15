Return-Path: <linux-kernel+bounces-854125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C1BDD9A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BCD544ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C86E308F1B;
	Wed, 15 Oct 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nw+8/3+T"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A12C235F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519231; cv=none; b=JUY/Y0p/j7QNylEhwu417owLqz01SGTYmSdJ5zK+w6+hRn9PGIuZ6DfpCEpJDm5sYtfva3Ad5CvFMQlAOpXvQUSZVXUVs0U+wn2rCkwMpwJwQQW+uUuf7xIIr59g7mKW71+TyeaWMosAZ0zn/srU08lzNFERkiMll88L95Qo6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519231; c=relaxed/simple;
	bh=sqfqcCk73C339CEFGKekRqgEOx3juK3PyvjyD2ABo7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVE9S1gWTSqOE6aVQQ9S4pVrfc6a87sr0P5QclZECl2rZmqATt10viczc+jiWBG6Y2EDpLAPHqwCiGYIjz5JZEcDq5BLRBtByIJ+3Sf5t9h83+3V7Un48mGMcGY3d+DnXLhYyag9llO7Di8kyZ6tp/u99xDFK1Q3126pIRSKrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nw+8/3+T; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-26e68904f0eso64759765ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760519229; x=1761124029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v54lCkZaDqlFCcH302UrfaefVMpcSxNOJrGx418qcEA=;
        b=Nw+8/3+Tl/lopvM/VYoSfKVkzRah1xOgmqxwVpv/HvNUAFIS3m0OGA/CEXgM2B6hMm
         lugAfr+ruJzgvCca9hGaZItiGcDuiY5BA3Wke+jyEx5YynslEqdvao+mN3EYxrsEd+XR
         aMHiaeiG8kqNfa5zoAB7VQEvImmre0JYcSUjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760519229; x=1761124029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v54lCkZaDqlFCcH302UrfaefVMpcSxNOJrGx418qcEA=;
        b=rLbzEPTN4IFbB8ITMJwdLBzdqdVHIr5Tbc0wZBLAyb+ip1hD2/ocVrM/Lxs1Eb9Ud/
         K1d/6bK+5fg3CdoNcAsubdRrGq0hDYuMcpv5LJErKrLle+Aq/ZLlvOjW4UbYQ70DBw3D
         32ywtWy1cr2eyHAqDH6XMAObPdKZUkDbcbO5DA7CZBBFDXs4ncd8ajHfbgp6lzfoCylm
         OoyNmDXATE6RKrR/alPjWrkh81PXpTq1wi3ZdejdGhhWxYRLusn162i/7yRMfFZMD9zN
         33rAwiD8tbEtvMHVACiS+Kb0X8X5x125quhpwKTDbPxbGeqFmCrXRDonbmZMdw8ryUaL
         Rr7w==
X-Forwarded-Encrypted: i=1; AJvYcCXPoKR7FwGt/cPfLwRiniUy+lVIqQFkZulGrJ1NcR+5z4ZQNiM+EzHLv/qyuEYbBnzp7mppuO4iZWQHwPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ugwFa0IcZEj2n+rKZXLR/dhY2dM+QCbr+Ub7OmPmGqWE3uQN
	z/9ZYQ2ysOsyioQPRXzjGD4cMSET+8mdAFKtb7r0DU3qlpKf9jsVvD2w03Ilw3JkpQ==
X-Gm-Gg: ASbGncuqdk35xWbcIALDvC7EfyRxpHsnfeSwVRy3PFTSdUlxqcl02r6wJUYb1HH8UL0
	THkAW7yMBcSe3HzV2jjru14ZnIYEgNmh1CC490MlRNYRssyDR37eqSGqSDbhf63wwriX5USr+2d
	ZEKQmYXs+fdD8zfPzsSQzqwRqSYd0veXO5I7Th77Cs9f0x+FiyJ5weekC9rkX4Bi3nL1cJJLHE6
	ND9KOuU824GNkLQQtIsK9dJIzZqwiyaW3xQoab9JZVU9DF2TVskoXq31wyonQp9OaT1wAgtUwzq
	vIcWlpLG0j+NosLNmsw6hvwETt7kMm9RVq3eCvCfcKAsK2uqSyg16UhqF2cQSk+Bw1KSSXl8QLO
	BhXYH2GjW4Vhk5XgQIuvQu9lU/DonzSS6FWfHh4PngFEUcVn88XsvSMP/4d9txUWIOsl1YS7WUi
	TLVESkVZMlMEG7Fb734Zwetyo9bPmVHp86
X-Google-Smtp-Source: AGHT+IHlL0oIuISBopxFJ5LX7OHcqdJOEAXBYDDnEYLkTxGptox99BOIpt/UkQRjt+HPN1uykPtDLA==
X-Received: by 2002:a17:903:3807:b0:269:8d16:42d1 with SMTP id d9443c01a7336-290272e1e24mr316691295ad.50.1760519228878;
        Wed, 15 Oct 2025 02:07:08 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:1a1f:d7c1:704a:3e83])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df233cfsm14389395a12.28.2025.10.15.02.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:07:08 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Brian Masney <bmasney@redhat.com>
Subject: [PATCH v2] clk: tests: Add tests for clk lookup by name
Date: Wed, 15 Oct 2025 17:06:59 +0800
Message-ID: <20251015090701.2049164-1-wenst@chromium.org>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clk lookup (by name) recently gained some performance improvements at
the expense of more complexity within the lookup code.

To make sure that this works as intended and doesn't break, add some
basic tests for this part of the CCF.

A new "clk_hw_lookup()" function is added purely for running kunit
tests.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

---
Changes since v1:
- Added missing prepare lock/unlock
- Switched to EXPORT_SYMBOL_IF_KUNIT and VISIBLE_IF_KUNIT kunit
  visibility macros for consistency (Brian)
  This probably doesn't make much difference except that the symbol is
  now in the EXPORT_SYMBOL_IF_KUNIT namespace
---
 drivers/clk/clk.c      | 18 ++++++++++++
 drivers/clk/clk.h      |  4 +++
 drivers/clk/clk_test.c | 67 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 85d2f2481acf..b39ad8944a06 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -10,6 +10,7 @@
 #include <linux/clkdev.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/compiler_attributes.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/hashtable.h>
@@ -25,6 +26,8 @@
 #include <linux/string.h>
 #include <linux/stringhash.h>
 
+#include <kunit/visibility.h>
+
 #include "clk.h"
 
 static DEFINE_SPINLOCK(enable_lock);
@@ -778,6 +781,21 @@ struct clk *__clk_lookup(const char *name)
 	return !core ? NULL : core->hw->clk;
 }
 
+/* This is only provided for kunit tests to test the core lookup functions. */
+#if IS_ENABLED(CONFIG_CLK_KUNIT_TEST)
+VISIBLE_IF_KUNIT struct clk_hw * __maybe_unused __must_check clk_hw_lookup(const char *name)
+{
+	struct clk_core *core;
+
+	clk_prepare_lock();
+	core = clk_core_lookup(name);
+	clk_prepare_unlock();
+
+	return !core ? NULL : core->hw;
+}
+EXPORT_SYMBOL_IF_KUNIT(clk_hw_lookup);
+#endif
+
 static void clk_core_get_boundaries(struct clk_core *core,
 				    unsigned long *min_rate,
 				    unsigned long *max_rate)
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 2d801900cad5..a8ed54f5b572 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -8,6 +8,10 @@ struct clk_hw;
 struct device;
 struct of_phandle_args;
 
+#if IS_ENABLED(CONFIG_CLK_KUNIT_TEST)
+struct clk_hw *clk_hw_lookup(const char *name);
+#endif
+
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk_hw *of_clk_get_hw(struct device_node *np,
 				    int index, const char *con_id);
diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index a268d7b5d4cb..a8989566946b 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -175,6 +175,8 @@ static const struct clk_ops clk_multiple_parents_no_reparent_mux_ops = {
 	.set_parent = clk_multiple_parents_mux_set_parent,
 };
 
+#define DUMMY_CLK_NAME	"test_dummy_rate"
+
 static int clk_test_init_with_ops(struct kunit *test, const struct clk_ops *ops)
 {
 	struct clk_dummy_context *ctx;
@@ -187,7 +189,7 @@ static int clk_test_init_with_ops(struct kunit *test, const struct clk_ops *ops)
 	ctx->rate = DUMMY_CLOCK_INIT_RATE;
 	test->priv = ctx;
 
-	init.name = "test_dummy_rate";
+	init.name = DUMMY_CLK_NAME;
 	init.ops = ops;
 	ctx->hw.init = &init;
 
@@ -3541,6 +3543,67 @@ static struct kunit_suite clk_hw_get_dev_of_node_test_suite = {
 	.test_cases = clk_hw_get_dev_of_node_test_cases,
 };
 
+/*
+ * Test that clk lookup with a name that is not registered returns NULL.
+ */
+static void clk_lookup_not_registered_clk_returns_NULL(struct kunit *test)
+{
+	KUNIT_EXPECT_PTR_EQ(test, NULL, clk_hw_lookup(DUMMY_CLK_NAME));
+}
+
+/*
+ * Test that clk lookup with a name that is registered returns the clk.
+ */
+static void clk_lookup_registered_clk_returns_clk(struct kunit *test)
+{
+	struct clk_hw *hw;
+	struct clk_init_data init = {
+		.name = DUMMY_CLK_NAME,
+		.ops = &empty_clk_ops,
+	};
+
+	hw = kunit_kzalloc(test, sizeof(*hw), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+
+	hw->init = &init;
+	KUNIT_ASSERT_EQ(test, 0, clk_hw_register_kunit(test, NULL, hw));
+
+	KUNIT_EXPECT_PTR_EQ(test, hw, clk_hw_lookup(DUMMY_CLK_NAME));
+}
+
+/*
+ * Test that clk lookup with a name that was unregistered returns NULL.
+ */
+static void clk_lookup_unregistered_clk_returns_NULL(struct kunit *test)
+{
+	struct clk_hw *hw;
+	struct clk_init_data init = {
+		.name = DUMMY_CLK_NAME,
+		.ops = &empty_clk_ops,
+	};
+
+	hw = kunit_kzalloc(test, sizeof(*hw), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+
+	hw->init = &init;
+	KUNIT_ASSERT_FALSE(test, clk_hw_register(NULL, hw));
+
+	clk_hw_unregister(hw);
+
+	KUNIT_EXPECT_PTR_EQ(test, NULL, clk_hw_lookup(DUMMY_CLK_NAME));
+}
+
+static struct kunit_case clk_lookup_test_cases[] = {
+	KUNIT_CASE(clk_lookup_not_registered_clk_returns_NULL),
+	KUNIT_CASE(clk_lookup_registered_clk_returns_clk),
+	KUNIT_CASE(clk_lookup_unregistered_clk_returns_NULL),
+	{}
+};
+
+static struct kunit_suite clk_lookup_test_suite = {
+	.name = "clk-lookup",
+	.test_cases = clk_lookup_test_cases,
+};
 
 kunit_test_suites(
 	&clk_assigned_rates_suite,
@@ -3560,6 +3623,8 @@ kunit_test_suites(
 	&clk_register_clk_parent_data_device_suite,
 	&clk_single_parent_mux_test_suite,
 	&clk_uncached_test_suite,
+	&clk_lookup_test_suite,
 );
 MODULE_DESCRIPTION("Kunit tests for clk framework");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_LICENSE("GPL v2");
-- 
2.51.0.788.g6d19910ace-goog


