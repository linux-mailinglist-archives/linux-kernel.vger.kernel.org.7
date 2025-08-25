Return-Path: <linux-kernel+bounces-784965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2553B343F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E19337AFEA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4892FB967;
	Mon, 25 Aug 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vgfd8FLz"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D29304BB4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132040; cv=none; b=NdECSWFjHd4hffkYbHgWu4+wOfDQIKvg4TMZuPFtbdqEnEYrZqVhsqebLwSuDieV+ptEnyELTNFTqGhO0h9aFQu3SDD4mOD6JRLkKyCRVf0QA58CjEYUrEyWuGKZzSa+pj+wsOKcst75/rwpbbm+C8T90AUKTDzyNa8hIH8PcSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132040; c=relaxed/simple;
	bh=suncESI2oSW1jGwgW8HALT/gxYfqW5NYgFG0TK2ZRwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tCI6cXwEPAZ5+zKxCmF3ZFv21DkejN7ku7mPsmO/FcW28OtD2FqC+chij6J825LYhqbtWZz+Wdbac8ZqLouPpplvT/ra/ufvCIiUQn3f0QmbgifWW0GZgaqDqcSikfDvEknQD21o6VTF1eNNswTgfHNpAtPTXR0o4iqyDSUlwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vgfd8FLz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c51f0158d8so3284838f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756132033; x=1756736833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmj4+KeJRz5xK/o1A5pSjOswraJHwrE5iHoxwCs+mmQ=;
        b=vgfd8FLzTLvULW5s1Ttkne+HaQReqPad1N3AXFPaioDQMKwXrRSNVhzFAbXcpBTybH
         wNyg5hngDROUVwD9a3izRNjbJnS5DA/ictcO82AH2IBOY/dc3+04lj70nzOO4YmTikT+
         D7OlTkAO8cttwKvvTABoXkEHhtlOtNfwy7cy0u54DoEk2S/g+Si7mHifEX/elo1lRoHk
         2WsOQiLJGO5qB+RBdEO/zLaOhzFhgmS7O4a0kFRH9npqVMdNs+ar2pbSwJoaEaXIfU3k
         pCzNrNNEyCRoD+e0Bq3xYoplS8Ib8KsaBGdx5585Xun3oNnUQNu79bt02dfXG98VS01o
         m3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756132033; x=1756736833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wmj4+KeJRz5xK/o1A5pSjOswraJHwrE5iHoxwCs+mmQ=;
        b=ikVtF2Np+ygK5O7rOro2R+t1TJUy4z+p40sMlRDU737V8oovh1sdjR0kX6cEJJVSag
         SGEX2mwcMVoGVG9zeY+Lbuld5qNokaunG1tMaJt2zetRiviMZVniGdtG589M82i+WPqG
         ubYQl0OzsgJdL6IA6wqeTN5bEMdEUoMfDIhXgZeO+sJygq4p3EilKwhY0lrsWI0hF1D9
         eop/OGgdFz3a0QcFjz2Qn3/v5BChnXY0j1QCDRkJ/LyyRte/8+vZ5v9rfBSof7nXmO/8
         VgBMr3isK6kjYwiC+2v4kso4rSljuE6NHHB+i/8kKfO6BzOPmYPxy4XVjE060O52wP7j
         KchQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTw98cLXGuRxZ+Ihq/ccm/YmSW3CEo0bSFGSztA1C1spFb1SUNVjO0V8FqkjF87QNBie8yue9e7/9QFq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztGZ0zJg/FoXVyvBfRhJsqx5G6L6Me2A8D+EuIW66toqpF1YHO
	b/qUobPJeaR3rzmfHsPGBLMwcU74t2Dj2NM9iFgThJt6KCH9U+gtgcTlM2v2QnCSuh0=
X-Gm-Gg: ASbGnctyqrdjOGce/HNW9WkJ8BhCU8+dQXnDm74I2ljAEa1yzHMuKoLcK2pqHm1G9sJ
	KyILj7o7RbTEXeCQTug+mkqkexTrRAomZcj80zxOlHqGLRst+rNGhmNEu/6JdY5JU2uh+VGZwYy
	qRMRnP8pA4B+UwFOkD3xJ/GcmIZwgzKEpmKKLKH0Ol+rH0JccLZnyCrfkWqCMufJf1dBDrgVXFw
	sLLKxWG9MXwStLEZKSh8P5M4SrPURlRB/71C3jxuXrH39YHc7iydfuHLXYQSGRsxkjvvYRxlC7u
	etun1Gp9G0JteZnTKoEK6e2DnruHlVnx+/4ejuERvhvswuHhcCUb0KzSYYUFsigr0bAk8TmC5ad
	tPXFRqntVt0p9YspxLvCcxNrTbboFGVHSZF/e
X-Google-Smtp-Source: AGHT+IGnZNd0TF8B+2qH0v2ERRAcEJzB1LmVzNbD2rj+M2fJbkxWf2Ryny9Bv8Zv7wCD4HSuYBiLDw==
X-Received: by 2002:a5d:6ac7:0:b0:3c6:cb4:e060 with SMTP id ffacd0b85a97d-3c60cb4e54amr5981665f8f.34.1756132033426;
        Mon, 25 Aug 2025 07:27:13 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b261:baab:ed3d:3cb6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm12634462f8f.14.2025.08.25.07.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:27:13 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 25 Aug 2025 16:26:35 +0200
Subject: [PATCH v2 10/12] clk: amlogic: add composite clock helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-meson-clk-cleanup-24-v2-10-0f402f01e117@baylibre.com>
References: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
In-Reply-To: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2898; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=suncESI2oSW1jGwgW8HALT/gxYfqW5NYgFG0TK2ZRwc=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBorHK2LR9cAulu/Dg7wzveWSkLYkNJ9hi4wbYHo
 pFJxTH5+cWJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaKxytgAKCRDm/A8cN/La
 hSDrD/9Qb0PyVOZn3hszgeqgrG8upaAQ55iBmu/kHai53eku7dMNLCgo/GSxS12i1nnj8NSriLW
 ErB6hHemrtB7p9fYVUslxB/hZ9MISdi7tRa1yZjB6FuxI8XE+mZUICX5tmrea/cNAxFLAGcnQlN
 63CIJ7+aYY6X0vM9nQIrY4D0gluWYwi85q2rxa4VaD0z7DzmhXUjKIF6XaztRJxp4rl4Zz54u+g
 P0Px1NL0pQdh3m1V4ADCp0hlht2Mnzvxneei7m4Mu8jAdo8K1TjrabWY8mAWheTSZ0JCSyg6KJi
 WvlFlQcKiK6nsgepnfrp+MXo2+/dpljD8J+K3zwkmA65txvZMac3NcBacKTG2ToB0oNKzFqOiRO
 TijnFU8ByjWNQOhGlD/H3vfpxvxIV5Rglm8Ds6CBqTLTFPEPc1iFTE9E41mrWxLok/nvH8ov6vQ
 hPfIhHKuIgFGlxtEZsqxcY9WiPpqIMqaQyzueRkUhy+j7LTEhT8+kSduPZUUsKYRwFnZFxcTMYk
 XyKrwLv4GAN4/x6tEqqXKSPmolH2SND4jkjse858xq0S+3Y05806RQL0270Q4/6IOLKcstu4hZE
 5VHDw8Ltk2K0/Psd8SrPWGv2XkA703A+IqUiQuQ0kc7LPsCvpD3crNQrMt3bDU+csrYlXJ1V78w
 eaM64tYtmmBuiWw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Device composite clocks tend to reproduce the usual sel/div/gate
arrangement.

Add macros to help define simple composite clocks in the system.

The idea is _not_ to replace all instances of mux, div or gate with those
macros. It is rather to use it for recurring and/or simple composite
clocks, reducing controller verbosity where it makes sense. This should
help reviews focus on the tricky parts.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson-clkc-utils.h | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/clk/meson/meson-clkc-utils.h b/drivers/clk/meson/meson-clkc-utils.h
index 95d9f85f7ca22f63a16f8665d6f7a250b21bfdb8..ddadf14b4923781d8807546f35a1ba2e6a8a894a 100644
--- a/drivers/clk/meson/meson-clkc-utils.h
+++ b/drivers/clk/meson/meson-clkc-utils.h
@@ -48,4 +48,61 @@ struct clk_regmap _name = {						\
 #define MESON_PCLK_RO(_name, _reg, _bit, _pdata, _flags)		\
 	__MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ro_ops, _pdata, _flags)
 
+/* Helpers for the usual sel/div/gate composite clocks */
+#define MESON_COMP_SEL(_prefix, _name, _reg, _shift, _mask, _pdata,	\
+		       _table, _dflags, _iflags)			\
+struct clk_regmap _prefix##_name##_sel = {				\
+	.data = &(struct clk_regmap_mux_data) {				\
+		.offset = (_reg),					\
+		.mask = (_mask),					\
+		.shift = (_shift),					\
+		.flags = (_dflags),					\
+		.table = (_table),					\
+	},								\
+	.hw.init = &(struct clk_init_data){				\
+		.name = #_name "_sel",					\
+		.ops = &clk_regmap_mux_ops,				\
+		.parent_data = _pdata,					\
+		.num_parents = ARRAY_SIZE(_pdata),			\
+		.flags = (_iflags),					\
+	},								\
+}
+
+#define MESON_COMP_DIV(_prefix, _name, _reg, _shift, _width,		\
+		       _dflags, _iflags)				\
+struct clk_regmap _prefix##_name##_div = {				\
+	.data = &(struct clk_regmap_div_data) {				\
+		.offset = (_reg),					\
+		.shift = (_shift),					\
+		.width = (_width),					\
+		.flags = (_dflags),					\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = #_name "_div",					\
+		.ops = &clk_regmap_divider_ops,				\
+		.parent_hws = (const struct clk_hw *[]) {		\
+			&_prefix##_name##_sel.hw			\
+		},							\
+		.num_parents = 1,					\
+		.flags = (_iflags),					\
+	},								\
+}
+
+#define MESON_COMP_GATE(_prefix, _name, _reg, _bit, _iflags)		\
+struct clk_regmap _prefix##_name = {					\
+	.data = &(struct clk_regmap_gate_data) {			\
+		.offset = (_reg),					\
+		.bit_idx = (_bit),					\
+	},								\
+	.hw.init = &(struct clk_init_data) {				\
+		.name = #_name,						\
+		.ops = &clk_regmap_gate_ops,				\
+		.parent_hws = (const struct clk_hw *[]) {		\
+			&_prefix##_name##_div.hw			\
+		},							\
+		.num_parents = 1,					\
+		.flags = (_iflags),					\
+	},								\
+}
+
 #endif

-- 
2.47.2


