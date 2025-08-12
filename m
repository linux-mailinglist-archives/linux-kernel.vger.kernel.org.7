Return-Path: <linux-kernel+bounces-765069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3B9B22AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795E62A0DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A6A302CB7;
	Tue, 12 Aug 2025 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcqPr+K6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D52F548F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009679; cv=none; b=ljlyNbPUB1D3oonnTvAEAcNBo0TjkgozN+TzqBmo7wQNDOv40uZPCg8tti9pELSAWgWf9/exad1ZCju7PCDK5hTPf+mK/OpeNWfcGS5jqMphILvNxrqh7oWGrvVABlQ44sIFvtDVTyyUTsjwEpeKYlVgfSITu5nwWVPfL//6szg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009679; c=relaxed/simple;
	bh=IUzDle4gQB8Xk0bxNLtfHL2sLNitV0rVkDxOnQwk0ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZAsMhd/JrtE0zE1oWtr/mJXFcEmyomofrOQse8TcFJzp32r6ntbzLXA2OgOzhC9f3OWgTgYzDdKzYo0YyqL+FDyOYk1W4yCC4czw3uKoZBHA9RhiT69uAEAavcdSDyZrx/1Z87E/uRj7yF6uzdRACfexLBSLWWOwR4ULQhkiVz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hcqPr+K6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755009677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iutHxQ4O5SqVy6jHFiteHz6jLETStunywRM2TcmeHeA=;
	b=hcqPr+K6z6JrnWOXN/5ejbXYcjl42ScODmiGC9qTbT6biE32cmfufFDAQXZEZBjwurDPOh
	GBCUc9cqWn1OqdUp129Pwm/E228I7VkmZbHR7QIujPrHNm6MgBY7ityDgUgsky0WDrkGzP
	Rwgp7B/ZKn1XOq7wR2nkCBSNsUZsZR4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-Fhu1_So5OMSgYi90-q93Cg-1; Tue, 12 Aug 2025 10:41:15 -0400
X-MC-Unique: Fhu1_So5OMSgYi90-q93Cg-1
X-Mimecast-MFC-AGG-ID: Fhu1_So5OMSgYi90-q93Cg_1755009675
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b08b271095so146935011cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755009674; x=1755614474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iutHxQ4O5SqVy6jHFiteHz6jLETStunywRM2TcmeHeA=;
        b=Gn+L8a/PqET344zsRVLvHmkf5WWA88NGxIv9xStu39CETzwV3ZFnKvJHegoqYMm7sc
         6lIJJA5faSb4Mc5N7DBJ+IoajGOnIs3dd5V/s0fQ4PsqkMXbRkSQ37M0kZLnKhV0ueNg
         jggM2xrM9nHCT/Rzn7rGLui66Nz6FIxNOpUfq9jdr7/n5i4j7Bp7Iu6bp+H/Jnut7Dn/
         ZZAn0lwHIpMNUsXdpk4C3Wqk4yRN4iA/JID4l1wJhqLPaU3mLfqQtrkEoKKcAWs8U8mn
         Gld+Z158abDG1ArJ1eqJ1KTdQq19q93jHdU2BmhX00nObagcC2PaQ92KbXL7eefRdGdp
         7uRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd5cy9MOZlBlya946eaJTkcetvQKodk9HZZcqcvcpsQXeBveRJjgrBW9jKJlhi8SWgwxDHH93J1MVsHQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTJXD1DMEsWfLXWbyc1kaLSAd1Hv/AFLowXfy83yPVqEoPiryq
	Iowq//YC5G0IJQFiXoa8IVfKACBmVup3AMkFqwwZfCFmlsecD/qNrXEd2svfYO2izqUBLorOJ+T
	CO4MFjk+tDIxYF13N/O++MCTA/HB1d+iBmkVaZk16HRkPRWbiY6JDRwzgM3a94SiqhT/9nACvaK
	iw/d3WVLpoGpQNCCTCZKrgrkPlihVQmug5EQmUtngJwulTVjiK/L0=
X-Gm-Gg: ASbGncsNU0FAHPH47s2IclHRLPJW1bXP8V4C2ese55bNjAizfI6J97Ksdlr+BN774wt
	Y/f2rpSIndxseI7xBPnBDa5E9PUU7VmSmvSSEMij3V1JpQU0xB8dvPe1g1/AX8nVIMBhoWP5FKU
	W6Y2guS2cblCpynvGGkBQ+xtHfD77CiYr8bsIpj4wKwoOPLEKnIRMebJmA9k+Rh0OKexnAdyFQN
	KFHmMOjjYGgppnw/64ZwUekxWcX7yuT0TNd7qEYFYtvwJj2jYN+XjQvqZiaCFZkkOT1ndvt4H4O
	AOMSw7jLo2ru7wzbeqFQ21bRav31bjLLUJAml9CuNAAmQOuL6eCChrz9Ija0iVR6pPn33/FpGyk
	URg==
X-Received: by 2002:a05:622a:40cd:b0:4b0:8633:f961 with SMTP id d75a77b69052e-4b0ecae8695mr58555201cf.0.1755009674346;
        Tue, 12 Aug 2025 07:41:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd8odwF9Nz4qRqjYcflrFg8pVHarZXIcuayOZyBNpuegobdE3mhp+yY7nIC1pDd12ak0MQJA==
X-Received: by 2002:a05:622a:40cd:b0:4b0:8633:f961 with SMTP id d75a77b69052e-4b0ecae8695mr58554531cf.0.1755009673770;
        Tue, 12 Aug 2025 07:41:13 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0aa1efe78sm76186821cf.8.2025.08.12.07.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 07:41:11 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 12 Aug 2025 10:40:38 -0400
Subject: [PATCH v3 8/9] clk: test: introduce test variation for sibling
 rate changes on a mux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-clk-tests-docs-v3-8-054aed58dcd3@redhat.com>
References: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com>
In-Reply-To: <20250812-clk-tests-docs-v3-0-054aed58dcd3@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755009649; l=2563;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=IUzDle4gQB8Xk0bxNLtfHL2sLNitV0rVkDxOnQwk0ls=;
 b=qDeH4KgI9d/t57bzy5StIb5ffHemwEbChn/GxrH3K7AeP8PcRx6fvRik7/HOwF9tbWMLkxdL8
 S8oje3gdV1TAabkL5VvIMZchYTHFAoHW3W6BSIo3OVTOHjVOngomwdf
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

Introduce a test variation that creates a parent with two children: a
divider and a mux. Ensure that changing the rate of the divider does not
affect the rate of the mux.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk_test.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index c91de77a5b7a90396d9b4819ff90087445316567..f1c43b5004057eccd0591f17d625c549d9eecc78 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -906,6 +906,47 @@ clk_rate_change_sibling_div_gate_test_init(struct kunit *test)
 	return &ctx->clk_ctx;
 }
 
+struct clk_rate_change_sibling_div_mux_sibling_context {
+	struct clk_dummy_div child1;
+	struct clk_multiple_parent_ctx child2_mux;
+	struct clk_test_rate_change_sibling_clk_ctx clk_ctx;
+};
+
+static struct clk_test_rate_change_sibling_clk_ctx *
+clk_rate_change_sibling_div_mux_test_init(struct kunit *test)
+{
+	struct clk_rate_change_sibling_div_mux_sibling_context *ctx;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+	test->priv = ctx;
+
+	ret = clk_init_multiple_parent_ctx(test, &ctx->child2_mux,
+					   "parent0", clk_dummy_rate_mhz(24),
+					   "parent1", clk_dummy_rate_mhz(48),
+					   "child2", CLK_SET_RATE_NO_REPARENT,
+					   &clk_multiple_parents_mux_ops);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ctx->child1.hw.init = CLK_HW_INIT_HW("child1", &ctx->child2_mux.parents_ctx[0].hw,
+					     &clk_dummy_div_ops, CLK_SET_RATE_PARENT);
+	ctx->child1.div = 1;
+	ret = clk_hw_register_kunit(test, NULL, &ctx->child1.hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ctx->clk_ctx.parent_clk = clk_hw_get_clk(&ctx->child2_mux.parents_ctx[0].hw, NULL);
+	ctx->clk_ctx.child1_clk = clk_hw_get_clk(&ctx->child1.hw, NULL);
+	ctx->clk_ctx.child2_clk = clk_hw_get_clk(&ctx->child2_mux.hw, NULL);
+
+	return &ctx->clk_ctx;
+}
+
 struct clk_test_rate_change_sibling_test_case {
 	const char *desc;
 	struct clk_test_rate_change_sibling_clk_ctx *(*init)(struct kunit *test);
@@ -916,6 +957,10 @@ static struct clk_test_rate_change_sibling_test_case clk_test_rate_change_siblin
 		.desc = "div_gate",
 		.init = clk_rate_change_sibling_div_gate_test_init,
 	},
+	{
+		.desc = "div_mux",
+		.init = clk_rate_change_sibling_div_mux_test_init,
+	},
 };
 
 KUNIT_ARRAY_PARAM_DESC(clk_test_rate_change_sibling_test_case,

-- 
2.50.1


