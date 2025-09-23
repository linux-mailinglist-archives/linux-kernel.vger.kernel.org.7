Return-Path: <linux-kernel+bounces-829146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A21B96627
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F9A1888C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EBE25B69F;
	Tue, 23 Sep 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgA1bzqA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE8C30DD37
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638429; cv=none; b=Wz4rPFrnbgWKKrHpWnoSgc3bAvG5ddKnrPJunBIU9b5yyjPxO3hd3sofkqWd6mMf0qgX05b+QR9CxtYDgyMJ50fJiT3VHTuDSuiPcDcfJpbpQzG6GeG2hPCMRBe+fi+THFWJEQhx3rl4HbtHjSAnNgY+jfC+cVoXaDef1ah3pKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638429; c=relaxed/simple;
	bh=TiAVMMX0BhZ88QrzXHt9pRkEcv8jwTCO6wBg4capGYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t1xT2/PFG/Di1B8DmToIY6tZTx3Gk0qBsymJV8zjTfrIwipMGXaSCNePH3y1+SiN4AIoiof6L7m28p21ydf3VwTibkolAMBYNcthgUIcj0S0xglQaiYxvkBcnyQz9N3RqWEVgVyNckRA0BEXxD5SWohX7/45GfLeSFEVAyxqJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NgA1bzqA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758638426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ttJMiiiNX3mRY18NUefNDmQ3WxdD+1OalFtqeM6LpeI=;
	b=NgA1bzqAkvXl/4P8HRLCRyKhU7vOM0FMLWTbIAIf7RBBbe+RiGcl1607wV8hzm2/43/VxT
	EdwKLBvY7zjzxHJxQSApfxHHyXiv7RuSV5CLKWPZJ5+T9Z8QinrBz2iFOr98D9pjqQOOsx
	A8wcKrwSAzKhzW3O8qGmxiTL7dNmqos=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-7X5kzP9OOX6NKgOeY-PSsg-1; Tue, 23 Sep 2025 10:40:23 -0400
X-MC-Unique: 7X5kzP9OOX6NKgOeY-PSsg-1
X-Mimecast-MFC-AGG-ID: 7X5kzP9OOX6NKgOeY-PSsg_1758638422
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8502939d0f6so251014485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638422; x=1759243222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttJMiiiNX3mRY18NUefNDmQ3WxdD+1OalFtqeM6LpeI=;
        b=Ly0q6yWEDyn3aEeF9wp0kduuesRHCSKuGF6o0OcWSJ4gNHlOTSodIYjyjBLwImQuuN
         FpReyu1LLi1c0ab4UPlcItwybrTyckcx5139wEbCoPwMi7WKwcclaGqTHR4yLvMcE7mr
         golyZnDKFgXvtaUJCEki8h/ZZC1TFJDckDjA/PKAXPm5tDPNczKjPZII/Bw3qX0mshAB
         HGdHHJb9zA9mrJ4xNfMLDC2JoUQSl4P3hpVt7plOf76goUEoqYhxGCEhJy6LUnn9Xo9J
         Dbknz1186zBJKnp395rgKwrf9OEPCvWhwheifNT/WCtqRiSyJG5T6fvUJzDB/xNIjAdJ
         9Wzg==
X-Forwarded-Encrypted: i=1; AJvYcCUMj3+A6oP0BnzHEQssGkJauVmdnhjdLDknBlEb4P0uJWnKp/pxyEx9wcl32ZH8iiqMOaJBMiZIWTVX2p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfrbPpASJKN5sXMOjAaQ1RbidNJVe0A15D5fBr0qrVTdZI59Xf
	qPP6AQY283+I5IP4C+qtYw6Jqv/lyhwS6XMKosgGW1OGAa08HwPvKxB/8GMWHj+SpVc8Uyy+BGv
	lNKX9jrfxkvm0kB9D+tMKsYgANTESCl470d/9FOsX0L2njeFpiI4ly6jOvbSgll4QVQ==
X-Gm-Gg: ASbGncu9JrC/Z/QjEZUienkMGnFT47HtlTl9YBEs8ZhK4KKNBlo9saP70AAMCT8lJqt
	zjMHN9BTbkGAXuq//QyvPlopQ/Fhoz+eeE4ltx2JiMMlZ3Uawy+o87g9EObYP0HprUKLhp8T2GB
	WhCU8wjZdhA9RfBGgAPZNiZBu+AVJfE/0CUMIhhg1ldafpTYMNZhIs7X9L93ud69ppR2MRbMmAd
	Mx89Kl5YsNE/Nc2X24QccGP9dTxxFJ59H7EICo8xI1Sb0UzSOx0JH6uFuF1lX78KBNLZMZD+tfk
	Mutnw0YVfDymNiFK0iICmxtjLR202vFWgezKFTOCwQ0iwJ7Oh7NPA48U+JSc7m0uBqan7Wqgo3r
	ZZEUr8AtJ+l9Chg1AOnMS4o3OO5pLrGQR7dV9m6c=
X-Received: by 2002:a05:620a:3905:b0:84f:fa6f:8dae with SMTP id af79cd13be357-851b786ab49mr314755485a.30.1758638421511;
        Tue, 23 Sep 2025 07:40:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUK/M1zsnzUN9MP0pcbn4lT/oOtPlFmMyQzwG6v93P6G8aw82V54M2ccRD4QNt3HkJwTzLZQ==
X-Received: by 2002:a05:620a:3905:b0:84f:fa6f:8dae with SMTP id af79cd13be357-851b786ab49mr314751885a.30.1758638421010;
        Tue, 23 Sep 2025 07:40:21 -0700 (PDT)
Received: from [10.175.117.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84f2f6f3c25sm230272985a.49.2025.09.23.07.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:40:20 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Tue, 23 Sep 2025 10:39:30 -0400
Subject: [PATCH RFC v4 11/12] clk: test: introduce negotiate_rates() op for
 clk_dummy and clk_dummy_div
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-clk-tests-docs-v4-11-9205cb3d3cba@redhat.com>
References: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
In-Reply-To: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2578; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=TiAVMMX0BhZ88QrzXHt9pRkEcv8jwTCO6wBg4capGYg=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDIubTS4dPWjtbXpB9tlnQwnJMKmrP7TWLkzU2FljPjRP
 +9Psz2531HKwiDGxSArpsiyJNeoICJ1le29O5osMHNYmUCGMHBxCsBE5ugx/M/qvHHrxuJr7Bse
 f3+m9FUgwG/XuecNl06o2Bw5xSv1aUYSI8M7hUCrhjl3p7Dq/F/LJPDL3myq7j8N3oql3yMUBCL
 fzGcBAA==
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

This is needed for the v2 rate negotiation code where the parent works
with all of it's children to find the best suitable rate.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk_test.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index 32defaf1972c28224108c32aef1e74796aae8bc0..7c4d1a50a7dd0bfb66e021ba314a9a9709813d97 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -29,6 +29,7 @@ static const struct clk_ops empty_clk_ops = { };
 struct clk_dummy_context {
 	struct clk_hw hw;
 	unsigned long rate;
+	unsigned long negotiate_step_size;
 };
 
 static unsigned long clk_dummy_recalc_rate(struct clk_hw *hw,
@@ -97,10 +98,31 @@ static u8 clk_dummy_single_get_parent(struct clk_hw *hw)
 	return 0;
 }
 
+static bool clk_dummy_negotiate_rates(struct clk_hw *hw,
+				      struct clk_rate_request *req,
+				      bool (*check_rate)(struct clk_core *, unsigned long))
+{
+	struct clk_dummy_context *ctx =
+		container_of(hw, struct clk_dummy_context, hw);
+
+	if (WARN_ON_ONCE(!ctx->negotiate_step_size))
+		return false;
+
+	for (unsigned long rate = req->min_rate;
+	     rate <= req->max_rate;
+	     rate += ctx->negotiate_step_size) {
+		if (check_rate(req->core, rate))
+			return true;
+	}
+
+	return false;
+}
+
 static const struct clk_ops clk_dummy_rate_ops = {
 	.recalc_rate = clk_dummy_recalc_rate,
 	.determine_rate = clk_dummy_determine_rate,
 	.set_rate = clk_dummy_set_rate,
+	.negotiate_rates = clk_dummy_negotiate_rates,
 };
 
 static const struct clk_ops clk_dummy_maximize_rate_ops = {
@@ -175,10 +197,28 @@ static int clk_dummy_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
+static bool clk_dummy_div_negotiate_rates(struct clk_hw *hw,
+					  struct clk_rate_request *req,
+					  bool (*check_rate)(struct clk_core *, unsigned long))
+{
+	unsigned long rate;
+
+	for (int i = 0; i < BIT(CLK_DUMMY_DIV_WIDTH + 1); i++) {
+		rate = divider_recalc_rate(hw, req->best_parent_rate, i, NULL,
+					   CLK_DIVIDER_ROUND_CLOSEST,
+					   CLK_DUMMY_DIV_WIDTH);
+		if (check_rate(req->core, rate))
+			return true;
+	}
+
+	return false;
+}
+
 static const struct clk_ops clk_dummy_div_ops = {
 	.recalc_rate = clk_dummy_div_recalc_rate,
 	.determine_rate = clk_dummy_div_determine_rate,
 	.set_rate = clk_dummy_div_set_rate,
+	.negotiate_rates = clk_dummy_div_negotiate_rates,
 };
 
 struct clk_dummy_gate {

-- 
2.51.0


