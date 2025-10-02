Return-Path: <linux-kernel+bounces-840061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C00BB3710
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EB916A92D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB033009E1;
	Thu,  2 Oct 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fsoX9i4q"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801802FA0C4
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396846; cv=none; b=iLR0h1kLNR4/ppE1poh3eWlZRcK3H7Rfz2tG71+mXV6wIlo1rukil0OHH4qL8DMppRZgvgTLXw2CCE8vc+yt9OjZvzqF57FKK0c6ylQirFgiJjJDP4ann+AmS30XXqVMUn6cPZdDh3bnqOUDWs9e/TcZzsmpvK7+Ta6BzSwoO1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396846; c=relaxed/simple;
	bh=kZw9F7Lh2RYicqW8c/0dnsDClsMKLP+FvXBKFUUeXFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaS92nfBUnP3vNYZNOcGjZ2C86N8uAEd11R/xOU5drD/PAedBT89Fyek3OMfJlkwJoRnCgj3QqSiKtY5U3iwYsimH6YNZvsuad8g87UaLm6o0CtS/xfKWAZZG/fciDhveZzX4FF49oQ4TmiR3kQySaOGG+R+r3xyP2mRJq6SQxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fsoX9i4q; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781001e3846so816844b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759396844; x=1760001644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQDxw8Hfh8Y8mQlGaDxHtor3fvvIJuG60cJHSTBd1Q4=;
        b=fsoX9i4qxJW1EmjWp1T6HIX9J6fIdXahAMFj8ullF/E8wTrvb9HWBvyDaFczErZT0d
         twW8QWPRIsgsUDGiqgseJOhfSLBVAItMuESHB1D/lkqqWyTthGSrOjzYNHHF9MUqza3L
         zGGwdLmpcmLVN/Wxj4COtYFkb4kd3eqC9AvWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396844; x=1760001644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQDxw8Hfh8Y8mQlGaDxHtor3fvvIJuG60cJHSTBd1Q4=;
        b=JDANzK2/LBxOEHejFZlJG6LgtQwiZ+mYuOfRrNGxjy5x94Kv1XiRHifwZIO2b5XhWP
         x6Z4r9HN0WF27f39+ObbWDu4YqRoUvzktB7wgRferWxpyplrGCJlOg3EwYJBUls5FW2/
         8Ydm8rfLRgcCXHkp/e2kgSsz+9vpDRvwnJLOIpKzoALTXT7T6PsiA64EjArCZ1NpjQQG
         LKgRxGdTDT6J2sWsJGlST2+wImmwDJwbr9DpULodquBnvBhRiLCbuwf9f4ApnGV4nS24
         8kfNUAsgr8Lkh1/7nHv/SVJQS065nwK3XLJm4cy8eNezRYaXizn5K4CurNX9c16Zictf
         GnrA==
X-Forwarded-Encrypted: i=1; AJvYcCWV8LdZePKyuovp85e4DGz3NunqRp0yHC2iod5z3bqnxVql3bFH6zYmEHgmt03gqWISb4N7aLW6Bcom3Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe5An+f+4EzcjANngkmvMhTzP3WbvnJvo44RMUjE3v1dBG/vdr
	xHX6jqruPDmDiXuyriX7H/EhHBKIixoolVXSK3JEaPCl5zcGCKga+yURLPmicLhEqkPgbD7gcpN
	emJQ=
X-Gm-Gg: ASbGnctK9dOktzcJ4psgqC/762Mi9nERNcEBIRFYgMBRtg0x0WuIsBuA+0FCKqnByNV
	K9SrI1hLsKrGyYr8VoG12tZRpU6nNh4ak2Ne07QbaE35/SIWUQQpjMSTqMO24avTFefjNTC7ty3
	BLtInhUwxiPc/noqm5GACILGwYmVsC9EJiR6k+gJw/TIB6BZSDCIjjdma948bECSbYxUASSDDR5
	pzSY4m2oqe30HTAtNdHuAfXv6F5I/AGNm4ZNJ91BUEdwA/DXq5n5frPvkOv30E8RSZ14JMZu3YP
	GsjkHOn7ruTKziqabOc2KIgRA+jEg5CdjVblSUQLJajsNXUOwSKsbVcM3OfWE6+RIto3z3dpAhe
	XcgB6Q7yJusQVe/I89YowHYFunF6RpJ8azrSnE5eh5981HJbnK/OrIATooLcNd/QQ1AvD8FH6BZ
	BXkLSQz8JvMi/h13LHbZ9nQv77v4jUjEHQRn0ogg==
X-Google-Smtp-Source: AGHT+IHMtN6ZJkMHIj5HdMYlnYyAczHcoKg+g+PecKKLereDk3zQkSokXvTzEx9YpyqnCmsVnxbEug==
X-Received: by 2002:a17:903:f84:b0:28e:9427:68f7 with SMTP id d9443c01a7336-28e94276a97mr5653845ad.6.1759396843616;
        Thu, 02 Oct 2025 02:20:43 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3299:ab9e:3686:a840])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1f2dbesm17531825ad.135.2025.10.02.02.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:20:43 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: tests: Add tests for clk lookup by name
Date: Thu,  2 Oct 2025 17:20:35 +0800
Message-ID: <20251002092036.2504858-1-wenst@chromium.org>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
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
 drivers/clk/clk.c      | 11 +++++++
 drivers/clk/clk.h      |  4 +++
 drivers/clk/clk_test.c | 66 +++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 85d2f2481acf..a17d0070d11f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -778,6 +778,17 @@ struct clk *__clk_lookup(const char *name)
 	return !core ? NULL : core->hw->clk;
 }
 
+#if IS_ENABLED(CONFIG_CLK_KUNIT_TEST)
+/* This is only provided for kunit tests to test the core lookup functions. */
+struct clk_hw *clk_hw_lookup(const char *name)
+{
+	struct clk_core *core = clk_core_lookup(name);
+
+	return !core ? NULL : core->hw;
+}
+EXPORT_SYMBOL_GPL(clk_hw_lookup);
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
index a268d7b5d4cb..b3b5ce0ad897 100644
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
@@ -3560,6 +3623,7 @@ kunit_test_suites(
 	&clk_register_clk_parent_data_device_suite,
 	&clk_single_parent_mux_test_suite,
 	&clk_uncached_test_suite,
+	&clk_lookup_test_suite,
 );
 MODULE_DESCRIPTION("Kunit tests for clk framework");
 MODULE_LICENSE("GPL v2");
-- 
2.51.0.618.g983fd99d29-goog


