Return-Path: <linux-kernel+bounces-765068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3735DB22AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C9E16BBED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7582EFDB0;
	Tue, 12 Aug 2025 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bl75hXbS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9852EFDAC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009677; cv=none; b=Zyto2KcM4sY+b+EfGmJoZF1IBN7MjRK9+GTGZG2pGtpT98jj3kOOQ86sRxlyb9mMv3tq1twuEPa6ntFeCJPA+VGTIZkiY6NNXpV9ZarUqH1iMLubWuXy6Z+2KvTGchuwgRzqJeU/0/Dm3kcC/XkC/SFUUAH6yEoRRilNVcJ9gjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009677; c=relaxed/simple;
	bh=XHXNEFI9odB0IIoG8jChbqF/uj+50qUnXYV2Gp5unms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AmmeQff7n08CDdTnFX5g1jUihNGpWZjb3WcxxGtMpvDFzLqzMD6UBgFn3ecg76GwjxebYLvwuHaU412T7390FFh6cLeoTNlLlojr4RccCm/2fFsFO+6Ag93rLB+8sjfgc3sax0scRxjBxfk6yuimjo5f6GGvehTEqujP/BjSI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bl75hXbS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755009674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NKFY3n7CuO3NWtgbzOLLtqZ6Z4Snbd39W5EBQWC1wwE=;
	b=bl75hXbSaWpPNRBzRybAssvNWTRqfghtHzqespT1iUM6imQqFlamrO9gIb0xrnEXw9xaEk
	h9DBE35WmdY9CzzEiAc2z5Mde21GdxzFl8EPmu3Yryob0/qGOh75TWSTm8fmyKJ7OzYPAd
	JcvsmlDwcmYRhSlOsLjAyjAd0vaLUwY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-cbGfjBMMO9a9qTLdAUpTAQ-1; Tue, 12 Aug 2025 10:41:13 -0400
X-MC-Unique: cbGfjBMMO9a9qTLdAUpTAQ-1
X-Mimecast-MFC-AGG-ID: cbGfjBMMO9a9qTLdAUpTAQ_1755009673
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b068c25f04so128924741cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009672; x=1755614472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKFY3n7CuO3NWtgbzOLLtqZ6Z4Snbd39W5EBQWC1wwE=;
        b=v0CIlve4ejMXce+hZ1U6nlGDXa5rg2Ox1TvGcNxYS9p29Rh0Jb4kBTeGW7dBoKGW7c
         M+1vi4tXOycGOUPJ58+lRA9OCfAlF4EyOmRI3YVlmDiEd/Daisy+m8mF17cSjyZxEaJj
         lKx3OM2mUWeDlf2eaT3zXtSjzosoidEceaQcqxKdsPXzwM/RWw4znYfVojcrj4Agwow/
         QR87HxuogtIPGsPW3M9jhKuYq16S2KB5b9cgVLhA8M/YUIdiSn+hLvu2o4aXBZkXSH/r
         rLGI7F3CfuvkwmQqIyXivYKG0Q8AXgQxqWilkV6ariTzNa2NVQlSw9Tq8aBYjMWFspxI
         Is7g==
X-Forwarded-Encrypted: i=1; AJvYcCXVYqYns0QlNkJx2qqVt+uYKtSeV7n5gVKOUMbV53VvM5r0Mzba70zfRJE1MlJ93GQcMv6KOmbFM/jzCUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBRPGVZdhqDxUybLuTm0cApPU040vLvHCBSFcmgSMNGwSiFGf
	OXkcbH8sEim6PPgbbxvz2PpD5AGXgOJ7QjzYr5udVD4hDJBvQ8yMSSA2lmd+kcmarZ8IXgDN5Y/
	uP3Ouq2Yf18g7yVuilIlkMME0rMKF4RDpz1xZ61Z+LOJmUfm4vmA1IBKCf80Y4f9+Z0o6H2ZmXY
	HqGCvlhiK04Aeuol4gsIjeCGDfkwYQZY/lmAerFpt6UdlNW3vuDqE=
X-Gm-Gg: ASbGnctUnSBA+hSkVTD++BSfHUIanD9yLdWsilq4Xjtj5j5HLjZn6tYep/u9A6+AXOy
	dJ0Qw9CnKPqMxccZIWv0R4MQruGr4GKcak9PxhKO33hCNgg3DESROyR/R4FJ9IustQC3/SQV9OS
	5rYI43jtdYOLwUkY6sbDkYUM0jUU93U0tTGYD3n64No11DJ8A6yD65RNG3/LBSKXHOKMfEZ2Yyk
	HSyUqsdfzi8ODWGO6Ibwr6k/mOWEMNxzPSlIlSoXS8Tb1J+tQf8a8uMg64jmIOagEkkfebpydxJ
	gBhjFp0pTT4JUeyHWWEJnXjkuVSDfmaFk1z1uU8PXsQVQPmU0F9LdEiDI2lAmbi/DEUbcJHXHL0
	qgg==
X-Received: by 2002:a05:622a:4d8e:b0:4b0:e92d:78e1 with SMTP id d75a77b69052e-4b0eca37c40mr54121131cf.15.1755009671780;
        Tue, 12 Aug 2025 07:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER9jNCy7HOkkzvC7BBgOfqjjwCJoE/DqvN6LcIDUE+Bto/PsR/V+ZKHaCCMfitCCAQpQfftA==
X-Received: by 2002:a05:622a:4d8e:b0:4b0:e92d:78e1 with SMTP id d75a77b69052e-4b0eca37c40mr54120381cf.15.1755009671021;
        Tue, 12 Aug 2025 07:41:11 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0aa1efe78sm76186821cf.8.2025.08.12.07.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:41:10 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 12 Aug 2025 10:40:37 -0400
Subject: [PATCH v3 7/9] clk: test: introduce helper to create a mock mux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-clk-tests-docs-v3-7-054aed58dcd3@redhat.com>
References: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com>
In-Reply-To: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755009649; l=7421;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=XHXNEFI9odB0IIoG8jChbqF/uj+50qUnXYV2Gp5unms=;
 b=g08sE/ZPUIcWigiq9gMMDGVozwCf9DVFr2Y7RbubTpS/IvY3INOf5roDMU6hCDonrKI96Tlg+
 HtLYf/3OmNVC64Hj2VymeJrhDFyNEWoGlZwcFiGZnIQG9WbakfDQnth
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

Introduce a helper to create a mock mux to reduce code duplication.
This also changes it so that the relevant clk_hws are registered with
the kunit framework.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk_test.c | 141 ++++++++++++++++++-------------------------------
 1 file changed, 52 insertions(+), 89 deletions(-)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index 2e002f3154430e8cd4bafb5addc350798d4b02bb..c91de77a5b7a90396d9b4819ff90087445316567 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -536,45 +536,64 @@ static struct kunit_suite clk_uncached_test_suite = {
 	.test_cases = clk_uncached_test_cases,
 };
 
-static int
-clk_multiple_parents_mux_test_init(struct kunit *test)
-{
-	struct clk_multiple_parent_ctx *ctx;
-	const char *parents[2] = { "parent-0", "parent-1"};
+static int clk_init_multiple_parent_ctx(struct kunit *test,
+					struct clk_multiple_parent_ctx *ctx,
+					const char *parent0_name,
+					unsigned long parent0_rate,
+					const char *parent1_name,
+					unsigned long parent1_rate,
+					const char *mux_name, int mux_flags,
+					const struct clk_ops *mux_ops)
+{
+	const struct clk_hw *parents[2];
 	int ret;
 
-	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return -ENOMEM;
-	test->priv = ctx;
-
-	ctx->parents_ctx[0].hw.init = CLK_HW_INIT_NO_PARENT("parent-0",
+	ctx->parents_ctx[0].hw.init = CLK_HW_INIT_NO_PARENT(parent0_name,
 							    &clk_dummy_rate_ops,
 							    0);
-	ctx->parents_ctx[0].rate = DUMMY_CLOCK_RATE_1;
+	ctx->parents_ctx[0].rate = parent0_rate;
 	ret = clk_hw_register_kunit(test, NULL, &ctx->parents_ctx[0].hw);
 	if (ret)
 		return ret;
 
-	ctx->parents_ctx[1].hw.init = CLK_HW_INIT_NO_PARENT("parent-1",
+	ctx->parents_ctx[1].hw.init = CLK_HW_INIT_NO_PARENT(parent1_name,
 							    &clk_dummy_rate_ops,
 							    0);
-	ctx->parents_ctx[1].rate = DUMMY_CLOCK_RATE_2;
+	ctx->parents_ctx[1].rate = parent1_rate;
 	ret = clk_hw_register_kunit(test, NULL, &ctx->parents_ctx[1].hw);
 	if (ret)
 		return ret;
 
-	ctx->current_parent = 0;
-	ctx->hw.init = CLK_HW_INIT_PARENTS("test-mux", parents,
-					   &clk_multiple_parents_mux_ops,
-					   CLK_SET_RATE_PARENT);
+	parents[0] = &ctx->parents_ctx[0].hw;
+	parents[1] = &ctx->parents_ctx[1].hw;
+	ctx->hw.init = CLK_HW_INIT_PARENTS_HW(mux_name, parents,
+					      mux_ops, mux_flags);
 	ret = clk_hw_register_kunit(test, NULL, &ctx->hw);
 	if (ret)
 		return ret;
 
+	ctx->current_parent = 0;
+
 	return 0;
 }
 
+static int
+clk_multiple_parents_mux_test_init(struct kunit *test)
+{
+	struct clk_multiple_parent_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	test->priv = ctx;
+
+	return clk_init_multiple_parent_ctx(test, ctx,
+					    "parent-0", DUMMY_CLOCK_RATE_1,
+					    "parent-1", DUMMY_CLOCK_RATE_2,
+					    "test-mux", CLK_SET_RATE_PARENT,
+					    &clk_multiple_parents_mux_ops);
+}
+
 /*
  * Test that for a clock with multiple parents, clk_get_parent()
  * actually returns the current one.
@@ -2539,7 +2558,6 @@ static int
 clk_leaf_mux_set_rate_parent_test_init(struct kunit *test)
 {
 	struct clk_leaf_mux_ctx *ctx;
-	const char *top_parents[2] = { "parent-0", "parent-1" };
 	int ret;
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
@@ -2547,27 +2565,11 @@ clk_leaf_mux_set_rate_parent_test_init(struct kunit *test)
 		return -ENOMEM;
 	test->priv = ctx;
 
-	ctx->mux_ctx.parents_ctx[0].hw.init = CLK_HW_INIT_NO_PARENT("parent-0",
-								    &clk_dummy_rate_ops,
-								    0);
-	ctx->mux_ctx.parents_ctx[0].rate = DUMMY_CLOCK_RATE_1;
-	ret = clk_hw_register(NULL, &ctx->mux_ctx.parents_ctx[0].hw);
-	if (ret)
-		return ret;
-
-	ctx->mux_ctx.parents_ctx[1].hw.init = CLK_HW_INIT_NO_PARENT("parent-1",
-								    &clk_dummy_rate_ops,
-								    0);
-	ctx->mux_ctx.parents_ctx[1].rate = DUMMY_CLOCK_RATE_2;
-	ret = clk_hw_register(NULL, &ctx->mux_ctx.parents_ctx[1].hw);
-	if (ret)
-		return ret;
-
-	ctx->mux_ctx.current_parent = 0;
-	ctx->mux_ctx.hw.init = CLK_HW_INIT_PARENTS("test-mux", top_parents,
-						   &clk_multiple_parents_mux_ops,
-						   0);
-	ret = clk_hw_register(NULL, &ctx->mux_ctx.hw);
+	ret = clk_init_multiple_parent_ctx(test, &ctx->mux_ctx,
+					   "parent-0", DUMMY_CLOCK_RATE_1,
+					   "parent-1", DUMMY_CLOCK_RATE_2,
+					   "test-mux", 0,
+					   &clk_multiple_parents_mux_ops);
 	if (ret)
 		return ret;
 
@@ -2755,7 +2757,6 @@ static int clk_mux_notifier_callback(struct notifier_block *nb,
 static int clk_mux_notifier_test_init(struct kunit *test)
 {
 	struct clk_mux_notifier_ctx *ctx;
-	const char *top_parents[2] = { "parent-0", "parent-1" };
 	int ret;
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
@@ -2766,27 +2767,11 @@ static int clk_mux_notifier_test_init(struct kunit *test)
 	init_waitqueue_head(&ctx->pre_rate_change.wq);
 	init_waitqueue_head(&ctx->post_rate_change.wq);
 
-	ctx->mux_ctx.parents_ctx[0].hw.init = CLK_HW_INIT_NO_PARENT("parent-0",
-								    &clk_dummy_rate_ops,
-								    0);
-	ctx->mux_ctx.parents_ctx[0].rate = DUMMY_CLOCK_RATE_1;
-	ret = clk_hw_register(NULL, &ctx->mux_ctx.parents_ctx[0].hw);
-	if (ret)
-		return ret;
-
-	ctx->mux_ctx.parents_ctx[1].hw.init = CLK_HW_INIT_NO_PARENT("parent-1",
-								    &clk_dummy_rate_ops,
-								    0);
-	ctx->mux_ctx.parents_ctx[1].rate = DUMMY_CLOCK_RATE_2;
-	ret = clk_hw_register(NULL, &ctx->mux_ctx.parents_ctx[1].hw);
-	if (ret)
-		return ret;
-
-	ctx->mux_ctx.current_parent = 0;
-	ctx->mux_ctx.hw.init = CLK_HW_INIT_PARENTS("test-mux", top_parents,
-						   &clk_multiple_parents_mux_ops,
-						   0);
-	ret = clk_hw_register(NULL, &ctx->mux_ctx.hw);
+	ret = clk_init_multiple_parent_ctx(test, &ctx->mux_ctx,
+					   "parent-0", DUMMY_CLOCK_RATE_1,
+					   "parent-1", DUMMY_CLOCK_RATE_2,
+					   "test-mux", 0,
+					   &clk_multiple_parents_mux_ops);
 	if (ret)
 		return ret;
 
@@ -2869,39 +2854,17 @@ static int
 clk_mux_no_reparent_test_init(struct kunit *test)
 {
 	struct clk_multiple_parent_ctx *ctx;
-	const char *parents[2] = { "parent-0", "parent-1"};
-	int ret;
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 	test->priv = ctx;
 
-	ctx->parents_ctx[0].hw.init = CLK_HW_INIT_NO_PARENT("parent-0",
-							    &clk_dummy_rate_ops,
-							    0);
-	ctx->parents_ctx[0].rate = DUMMY_CLOCK_RATE_1;
-	ret = clk_hw_register(NULL, &ctx->parents_ctx[0].hw);
-	if (ret)
-		return ret;
-
-	ctx->parents_ctx[1].hw.init = CLK_HW_INIT_NO_PARENT("parent-1",
-							    &clk_dummy_rate_ops,
-							    0);
-	ctx->parents_ctx[1].rate = DUMMY_CLOCK_RATE_2;
-	ret = clk_hw_register(NULL, &ctx->parents_ctx[1].hw);
-	if (ret)
-		return ret;
-
-	ctx->current_parent = 0;
-	ctx->hw.init = CLK_HW_INIT_PARENTS("test-mux", parents,
-					   &clk_multiple_parents_no_reparent_mux_ops,
-					   0);
-	ret = clk_hw_register(NULL, &ctx->hw);
-	if (ret)
-		return ret;
-
-	return 0;
+	return clk_init_multiple_parent_ctx(test, ctx,
+					    "parent-0", DUMMY_CLOCK_RATE_1,
+					    "parent-1", DUMMY_CLOCK_RATE_2,
+					    "test-mux", 0,
+					    &clk_multiple_parents_no_reparent_mux_ops);
 }
 
 static void

-- 
2.50.1


