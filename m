Return-Path: <linux-kernel+bounces-829144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C675AB9660A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494F518A572B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD91A2EC56A;
	Tue, 23 Sep 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcwmbxpX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665362EA146
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638423; cv=none; b=N0rOGq9NxygxtOSoRdOQ1bJ2BocOJ1M4cz4XEkUHC8wjfEURz6K82IHo+gCFyhZwCIWXZBcEYrQlVTTQwY76JJgChfwk7fdPA/aXzb3kRmszDe5L8biHQQfIWBx917qJ68F6M8sVZ9qezejXh6p9sEIMF8ZoFIj0yAXHDEClRDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638423; c=relaxed/simple;
	bh=Q4FysjLwmisDNtR/Tyh/L+zp4+LEXH1XuUq81ZlHyiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HfSauY03wL5Yny5TCAxiebwLEFlb3ajJGyYWvxlKX6KLto6h6Oxf9FJmr3JUTanAUDVd8DUudZOt6rWbt2wjGq24fnhdbzFPvPYkaNbKRlHb0M5aP8P6ny0UKsNCobhKqWkA9ldgXKsTkV8jXmboA6U3eHlfrqYGwIQBjIpwQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcwmbxpX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758638420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRIZZjnscf0CTJC2caJhMyNbvqlOTaws6rzDBpb96D8=;
	b=DcwmbxpXqK6stZOuymhQoob5tvB8wAw1QZ4Z/AswvyOYZ/VgoLzGs2P4PrFFiRwQK28mFl
	DK9oERLqRRQYGuGbN5o+OCQpK/X1H7hjv0dmd+/4sfJ0CkOzi2D1nLYLxovJsBZ2USVpb2
	JHbsYK8dssSBIuwyIfe7XIQ7CJwTNBg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-Vs6uc_ZGMCKrJ3IJRh9F3g-1; Tue, 23 Sep 2025 10:40:14 -0400
X-MC-Unique: Vs6uc_ZGMCKrJ3IJRh9F3g-1
X-Mimecast-MFC-AGG-ID: Vs6uc_ZGMCKrJ3IJRh9F3g_1758638413
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-829080582b4so1080649285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638413; x=1759243213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRIZZjnscf0CTJC2caJhMyNbvqlOTaws6rzDBpb96D8=;
        b=HLCp1ak02V7SrOSpZ1NH7VqJRLYrjpeZlmySS5HV912eynjHKGsalnTlEd0IfyKmRY
         ogEtYd8GAZgIR/Rwo8t/+m75lRUkLGI6AhK7+efGgv7AZtBLcnJ4pHSCOAzyfYcWAqOy
         BZsw8AuJRnmLH3zRDhV6fBtUgkm/q9hS0WGREzI50TXgAaBbmYJVkyLhw+80QIeEih/5
         8YvBa/dRzh05L/fe2fQmR/dz7/MnltbnrSKRgfBmhjZfOQjdJzHCdXMfwxWA+5dpVq5s
         qCktol6EMghGGnHD+9r1YAM/D/AB5cJHWBG2tRt8M0AXFvopVhxmGDnmhDcr9mF7mjCP
         D06A==
X-Forwarded-Encrypted: i=1; AJvYcCUX/9r5YMBkkhcmrr28v3/CzNCBBeGjZggQFpYivMb1gNhj2HBwhv8yuz93S+5w5xszBi1V76G0AsczKIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlG6BxXXukUDyiNnIM4e4L+sTkawF6+QgTH7djfyzJ+ikVkVk2
	eTFnC/gEMrpnaB+A+fol3Cq2ek58xV8HU1lEBiq/vooGexYUNkEHYUXkZjnHcbhOmW+6KmGmxkD
	FZ7YzZztz0FaVZQ1ZeGkufja1cWbev/36PwlmE0aryeXsbrSNxuL8sIlaWQyrf0BeYw==
X-Gm-Gg: ASbGncvB0BE1oEWNmiK2nW3M8bjO1JYx8Uv2bHupKHVgkoezBX4KPYdTKN8ow988ZsW
	GmjPZPQiSfbP9FkNly6CeK/pDm0Pm0JAFwKYz/9hUKtyqK7xF6qtiZOSjenbHzehyR4GKd59fbd
	3AzoWgAwcSpb95HlRkxNs6fbBn7yp23DLMtAFQOUM/786mk9IIJYybNHFj01dUJW6TXgGWHCwgA
	UMQXQS3OKNK9hpNift3VPMhk3mRHfm0GIKpqxrgSZPiT7FrjpZ0/ISmgbaQmY3vEqVLH7QzHqYF
	Zx5SzVmIs0LDmWMYEQ5+GfmbTB6K1I7s6YQXvlUm0NIa/FQdtOfultqs4KfZZqDHN60yAai1T5P
	tqQD3apIfKECczMCXjy2R8LLYu7m35AtY12wnkXk=
X-Received: by 2002:a05:620a:3953:b0:7ea:463:e2f9 with SMTP id af79cd13be357-8516eb4611bmr323652985a.20.1758638413182;
        Tue, 23 Sep 2025 07:40:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPaSgwgYu2jWSLtWkKuFwUUeiviIqk4f81BpVimVxbiuKlOcm9lYGy6m0TtX9XsNim1ZZ0Jg==
X-Received: by 2002:a05:620a:3953:b0:7ea:463:e2f9 with SMTP id af79cd13be357-8516eb4611bmr323648585a.20.1758638412624;
        Tue, 23 Sep 2025 07:40:12 -0700 (PDT)
Received: from [10.175.117.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84f2f6f3c25sm230272985a.49.2025.09.23.07.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:40:11 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 23 Sep 2025 10:39:27 -0400
Subject: [PATCH RFC v4 08/12] clk: test: introduce test variation for
 sibling rate changes on a mux
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-clk-tests-docs-v4-8-9205cb3d3cba@redhat.com>
References: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
In-Reply-To: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=Q4FysjLwmisDNtR/Tyh/L+zp4+LEXH1XuUq81ZlHyiA=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDIubTR4svCbnaRe5RUGyR8OPzdxRmdP4VxQ18a24lZaf
 I5+06zDHaUsDGJcDLJiiixLco0KIlJX2d67o8kCM4eVCWQIAxenAEwkrZuRYfO2iu/hbyb0XTlo
 tejBw8MuZVF/Y3tYTum8PHeu3+nsMnOGf7YnXzAUm1WWCu+dyqlh9OvDzOCb3j/uZrguz7jm/7f
 +HCsA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Introduce a test variation that creates a parent with two children: a
divider and a mux. Ensure that changing the rate of the divider does not
affect the rate of the mux.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk_test.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index a330de8bd8dc2cdda558d364a3c6d87a26791c8d..0344f3f62251728e15af277ea0d143dc1f40fd94 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -908,6 +908,47 @@ clk_rate_change_sibling_div_gate_test_init(struct kunit *test)
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
+					   "parent0", 24 * HZ_PER_MHZ,
+					   "parent1", 48 * HZ_PER_MHZ,
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
@@ -918,6 +959,10 @@ static struct clk_test_rate_change_sibling_test_case clk_test_rate_change_siblin
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
2.51.0


