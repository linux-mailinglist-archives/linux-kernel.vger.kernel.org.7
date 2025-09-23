Return-Path: <linux-kernel+bounces-829147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7B9B96633
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F94816FFD5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D2B226D1D;
	Tue, 23 Sep 2025 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfByfB1h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EEA220F2D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638444; cv=none; b=lbX9+k4IrO5SpR5DsPZwtfk28MolKEopag2Iwmc8Fd+Pj6ZD9JehW/a5CqncQaZp7rXUBG7uCpRi9AmToccZlqnjIwHLtz/tyVsYDnn7CTjuGBLkmQKhEmCgOEOuOMb4p10IVEGR1aB3kt/wemP4aFBKBShMNCG23KXqHZjbzWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638444; c=relaxed/simple;
	bh=D3UgrSosq/MOSn8K9Aaz+rOUHHRaOZ0z2hzHPegpLO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQBd83RI8CsUeSYYdGpCKjYmy+C4r5q2gwJ9oDcM43j7Ex2zwojw3/BjHG00tPFF0FVy5nTECCFv66GFxsLpFAjeNduQvkev29RRKWu0mr0lgss3imNYXXxTk9GKse7zsUwncIbiJE9K9Mg3w3DRWY/C5epwuT+Y39U8t7mat9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfByfB1h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758638441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+erhI99JOuUzOc3CsexcHwDM2IOmUBQdfJnBT87dGw=;
	b=QfByfB1ht370cpNWFhSHlfjOwwOXoTbC7eYp8Nf0tbS84tBmL/pcqMX0/sVyXHmVntdSPx
	Pnk++ueS2XnhdjvTejdvybZfDbHph4CH2Qf2nQgPyf9j9dCf9LxHd4PMKoLuZzaIPpcNqB
	IaeGtzUPUiv7SbcbHH67p9YmhyI60CQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-iFmerer7OqaxaiEeA1KHhA-1; Tue, 23 Sep 2025 10:40:25 -0400
X-MC-Unique: iFmerer7OqaxaiEeA1KHhA-1
X-Mimecast-MFC-AGG-ID: iFmerer7OqaxaiEeA1KHhA_1758638425
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-828bd08624aso1152411685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638425; x=1759243225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+erhI99JOuUzOc3CsexcHwDM2IOmUBQdfJnBT87dGw=;
        b=ADvfzFOqt28e7e3Xi10NCe9fnGhb35L3+Dnqixt7ZIKZVdQfPU86gtxooIH3fYyy+X
         RLtkw0odxRtt1q6A+6wHhoQTftTJixszWF7iNXgEMRjKVXO4ybgX7DfDphjRsvGU2DBg
         1L/AgTVbS8PYqmJq0BTDg/cH062bV0EljI9FP1aI6yIRyrJutuxoU66l3+yN/YVWJXkp
         Ag1Dj9o6aqJZccfk103sq+FtluQAaiL5rjvqROkRntwb2neeCornGkZlNVodD06LXjQT
         3Bcv1/PXteuEMKENQD+i73n0c0OwIRor1Y+TmNhzeL4X1lKSaMFFUUj12XI0V3WuKzt1
         +efQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIOFSKPHl1IbaAsi9ImfYe7FnSI/TmxeA1Z/v5zT5vkAZ5eHKpBo5Re2PBog6SH76HTpSGLqUbdMOes98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbayepZfXCdKu0cCWPSCUTNQoybdLjJ5x37h9vGb7vM4g1MElK
	vErGV5vvndegktvb2eQLj+0+c36O5qzKXXN4qErZDA0kvDdTVCYGijbrZn5EMcOVItaUvQ7n24C
	KQL1EfRXhuTw/zP3zao7dBN0jpwiM36QkRwwSmj75i9fcHQWiP/UAx0XgWwLLBBGEiQ==
X-Gm-Gg: ASbGncsLrQ8ltEfsrdEg6FcTm6czASh1qsrO9a4ivSpeKiDf/9QdosjiL5LV2bfRaDG
	nxvdnFMxIzLKUPJxBao9tfaowPEGIrvbkRp6W6nr7OGJpWTOQZ6wy9T0UJs+gN0veBhmlklrk9L
	4pbgwhlu1Wafod7GypJ/mVKmg901iqGWiii60DOKQEQI4wR2oLg3rPRJbhEZ1QHwUNMGWe9TJV+
	7bx4ylbkZu2b32FtkmrD86zuTfHkzKuZ/LR2wOe5oyAP1TsC7CyZTra0QFsmHZ5tYHC0kIl38+H
	aryPBXkauw7kGsInxmz2/prlNiFk4ldtw6/WveaE5ZJpfzIG4YiejbX/4h81UgY7LJxNF3pdWh4
	IGH51GNbiOkSyFgK11LwzJk6Lw9M7nF2O2Jf8hoQ=
X-Received: by 2002:a05:620a:d8a:b0:812:c6e3:6663 with SMTP id af79cd13be357-8516ba5c35emr303165385a.34.1758638424923;
        Tue, 23 Sep 2025 07:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7D73wHsfmP93/Sd0Q4FqlIqORkx+fAcKsqHGCJ9Fpb8lMOLSJtCsdrIjyP8S4cVr0zCMXug==
X-Received: by 2002:a05:620a:d8a:b0:812:c6e3:6663 with SMTP id af79cd13be357-8516ba5c35emr303161285a.34.1758638424314;
        Tue, 23 Sep 2025 07:40:24 -0700 (PDT)
Received: from [10.175.117.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84f2f6f3c25sm230272985a.49.2025.09.23.07.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:40:23 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 23 Sep 2025 10:39:31 -0400
Subject: [PATCH RFC v4 12/12] clk: test: update divider kunit tests for v1
 and v2 rate negotiation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-clk-tests-docs-v4-12-9205cb3d3cba@redhat.com>
References: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
In-Reply-To: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6302; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=D3UgrSosq/MOSn8K9Aaz+rOUHHRaOZ0z2hzHPegpLO8=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDIubTRcsnyrxlvJRTGXHzxVa+Dbvcaj9kidJs+JwOKF6
 1/P33TxXkcpC4MYF4OsmCLLklyjgojUVbb37miywMxhZQIZwsDFKQATSTZm+O8bY5OYtenwxQfR
 EVErn77OOchw21lN/b5hqIljzKEw7hiGvzLlRe1WapwMGucS/LR6hc7F9K5R9e+csvHi7b7F4Te
 NWAE=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Update the divider kunit tests to verify that the v1 and v2 rate
negotiation logic is working as expected.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk_test.c | 77 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 59 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index 7c4d1a50a7dd0bfb66e021ba314a9a9709813d97..87af60d0782274c9faacf7729ed95bf04dfd4860 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -763,6 +763,7 @@ static int clk_rate_change_sibling_div_div_test_init(struct kunit *test)
 	test->priv = ctx;
 
 	ctx->parent.hw.init = CLK_HW_INIT_NO_PARENT("parent", &clk_dummy_rate_ops, 0);
+	ctx->parent.negotiate_step_size = 1 * HZ_PER_MHZ;
 	ctx->parent.rate = 24 * HZ_PER_MHZ;
 	ret = clk_hw_register_kunit(test, NULL, &ctx->parent.hw);
 	if (ret)
@@ -793,6 +794,20 @@ static int clk_rate_change_sibling_div_div_test_init(struct kunit *test)
 	return 0;
 }
 
+static int clk_rate_change_sibling_div_div_v1_test_init(struct kunit *test)
+{
+	clk_enable_v1_rate_negotiation();
+
+	return clk_rate_change_sibling_div_div_test_init(test);
+}
+
+static int clk_rate_change_sibling_div_div_v2_test_init(struct kunit *test)
+{
+	clk_enable_v2_rate_negotiation();
+
+	return clk_rate_change_sibling_div_div_test_init(test);
+}
+
 static void clk_rate_change_sibling_div_div_test_exit(struct kunit *test)
 {
 	struct clk_rate_change_sibling_div_div_context *ctx = test->priv;
@@ -833,16 +848,21 @@ static void clk_test_rate_change_sibling_div_div_2(struct kunit *test)
 	struct clk_rate_change_sibling_div_div_context *ctx = test->priv;
 	int ret;
 
-	kunit_skip(test, "This needs to be fixed in the core.");
-
 	ret = clk_set_rate(ctx->child1_clk, 48 * HZ_PER_MHZ);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	KUNIT_EXPECT_EQ(test, clk_get_rate(ctx->parent_clk), 48 * HZ_PER_MHZ);
 	KUNIT_EXPECT_EQ(test, clk_get_rate(ctx->child1_clk), 48 * HZ_PER_MHZ);
 	KUNIT_EXPECT_EQ(test, ctx->child1.div, 1);
-	KUNIT_EXPECT_EQ(test, clk_get_rate(ctx->child2_clk), 24 * HZ_PER_MHZ);
-	KUNIT_EXPECT_EQ(test, ctx->child2.div, 2);
+
+	if (clk_use_v2_rate_negotiation(ctx->child1_clk)) {
+		KUNIT_EXPECT_EQ(test, clk_get_rate(ctx->child2_clk), 24 * HZ_PER_MHZ);
+		KUNIT_EXPECT_EQ(test, ctx->child2.div, 2);
+	} else {
+		// Legacy behavior in v1 logic where sibling clks are expectedly changed.
+		KUNIT_EXPECT_EQ(test, clk_get_rate(ctx->child2_clk), 48 * HZ_PER_MHZ);
+		KUNIT_EXPECT_EQ(test, ctx->child2.div, 1);
+	}
 }
 
 /*
@@ -856,19 +876,26 @@ static void clk_test_rate_change_sibling_div_div_3(struct kunit *test)
 	struct clk_rate_change_sibling_div_div_context *ctx = test->priv;
 	int ret;
 
-	kunit_skip(test, "This needs to be fixed in the core.");
-
 	ret = clk_set_rate(ctx->child1_clk, 32 * HZ_PER_MHZ);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	ret = clk_set_rate(ctx->child2_clk, 48 * HZ_PER_MHZ);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
-	KUNIT_EXPECT_EQ(test, clk_get_rate(ctx->parent_clk), 96 * HZ_PER_MHZ);
-	KUNIT_EXPECT_EQ(test, clk_get_rate(ctx->child1_clk), 32 * HZ_PER_MHZ);
-	KUNIT_EXPECT_EQ(test, ctx->child1.div, 3);
-	KUNIT_EXPECT_EQ(test, clk_get_rate(ctx->child2_clk), 48 * HZ_PER_MHZ);
-	KUNIT_EXPECT_EQ(test, ctx->child2.div, 2);
+	if (clk_use_v2_rate_negotiation(ctx->child1_clk)) {
+		KUNIT_EXPECT_EQ(test, clk_get_rate(ctx->parent_clk), 96 * HZ_PER_MHZ);
+		KUNIT_EXPECT_EQ(test, clk_get_rate(ctx->child1_clk), 32 * HZ_PER_MHZ);
+		KUNIT_EXPECT_EQ(test, ctx->child1.div, 3);
+		KUNIT_EXPECT_EQ(test, clk_get_rate(ctx->child2_clk), 48 * HZ_PER_MHZ);
+		KUNIT_EXPECT_EQ(test, ctx->child2.div, 2);
+	} else {
+		// Legacy behavior in v1 logic where sibling clks are expectedly changed.
+		KUNIT_EXPECT_EQ(test, clk_get_rate(ctx->parent_clk), 48 * HZ_PER_MHZ);
+		KUNIT_EXPECT_EQ(test, clk_get_rate(ctx->child1_clk), 48 * HZ_PER_MHZ);
+		KUNIT_EXPECT_EQ(test, ctx->child1.div, 1);
+		KUNIT_EXPECT_EQ(test, clk_get_rate(ctx->child2_clk), 48 * HZ_PER_MHZ);
+		KUNIT_EXPECT_EQ(test, ctx->child2.div, 1);
+	}
 }
 
 static struct kunit_case clk_rate_change_sibling_div_div_cases[] = {
@@ -879,13 +906,25 @@ static struct kunit_case clk_rate_change_sibling_div_div_cases[] = {
 };
 
 /*
- * Test suite that creates a parent with two divider-only children, and
- * ensures that changing the rate of one child does not affect the rate
- * of the other child.
+ * Test suite with v1 rate negotiation logic that creates a parent with two
+ * divider-only children, and ensures that changing the rate of one child
+ * does not affect the rate of the other child.
+ */
+static struct kunit_suite clk_rate_change_sibling_div_div_v1_test_suite = {
+	.name = "clk-rate-change-sibling-div-div-v1",
+	.init = clk_rate_change_sibling_div_div_v1_test_init,
+	.exit = clk_rate_change_sibling_div_div_test_exit,
+	.test_cases = clk_rate_change_sibling_div_div_cases,
+};
+
+/*
+ * Test suite with v2 rate negotiation logic that creates a parent with two
+ * divider-only children, and ensures that changing the rate of one child
+ * does not affect the rate of the other child.
  */
-static struct kunit_suite clk_rate_change_sibling_div_div_test_suite = {
-	.name = "clk-rate-change-sibling-div-div",
-	.init = clk_rate_change_sibling_div_div_test_init,
+static struct kunit_suite clk_rate_change_sibling_div_div_v2_test_suite = {
+	.name = "clk-rate-change-sibling-div-div-v2",
+	.init = clk_rate_change_sibling_div_div_v2_test_init,
 	.exit = clk_rate_change_sibling_div_div_test_exit,
 	.test_cases = clk_rate_change_sibling_div_div_cases,
 };
@@ -4017,7 +4056,8 @@ kunit_test_suites(
 	&clk_leaf_mux_set_rate_parent_test_suite,
 	&clk_test_suite,
 	&clk_multiple_parents_mux_test_suite,
-	&clk_rate_change_sibling_div_div_test_suite,
+	&clk_rate_change_sibling_div_div_v1_test_suite,
+	&clk_rate_change_sibling_div_div_v2_test_suite,
 	&clk_rate_change_sibling_test_suite,
 	&clk_mux_no_reparent_test_suite,
 	&clk_mux_notifier_test_suite,
@@ -4033,4 +4073,5 @@ kunit_test_suites(
 	&clk_uncached_test_suite,
 );
 MODULE_DESCRIPTION("Kunit tests for clk framework");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 MODULE_LICENSE("GPL v2");

-- 
2.51.0


