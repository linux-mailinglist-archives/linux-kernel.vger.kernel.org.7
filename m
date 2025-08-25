Return-Path: <linux-kernel+bounces-784964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68FFB34427
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F57117DD22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E654F3090C0;
	Mon, 25 Aug 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0b3eZDwH"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144C304967
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132040; cv=none; b=DHtOUhdWcw130Em2BNwHTZ22j+KJX3dsxm2hEOFT+DagSzy5LUmX9X7xq7oozlby371Ui9d/WA4Fae7kAI78Woz7BmnBbbDpwLY9UVoKSamb0ZYTA/kKvYG0laZF0u0uITbs+2m9vILUIIHW1h4gAxRx4LDCQGE9m+5Grt5iqFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132040; c=relaxed/simple;
	bh=KKJgRJArtEZnmgn+Mscv9ei4wZaRB5fejXiQda3cJb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fIjyXEcVIsbNsrGAU+wKj31BSHkWI8XgAAH02LclEVUIynSrbsWWGZ3oPtzNHncjW4uWFyX3C/OMNcpKfQOtZtY11pNAL/p2difE8bSW6FvMW5vFIHpVxqnCMHNp4CXi7czSiCcrTfQ0J+OxOHYVIQ25sXnc/DvASZuJnG6cGKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0b3eZDwH; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c79f0a606fso1203915f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756132034; x=1756736834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUky9lqttrbpUCvILYpHg9Z0/QzSnBTRvjKKimO9Xdo=;
        b=0b3eZDwHjWXs3xhu6y9JtfuQbTuYINmlssZjl9qfPg2abkovdhrnHnGVmA+psLVaec
         EiVtWp5Wid9dCFwn9X4nL2YZcgJsXbggc5v7inJH0RV5mP0+Lyvk2pUVmok+eKPSB3ga
         p+qfumfUOrq0re/Q6X4Sljvj9iAKBQV2Hwi+VQDBNVx+4AMgt83V3tG1lBLA5V6QOfGE
         Jd6QeyWlsUfSOD+xluFmwNSdWPWR9kg/tLD70O4NWL7iZLKDTRiFHVP4pHMQugWlH7f8
         uZj6+WxRm/EuPG8dlbCx2BsjTCB1LR6uiddo/jSOczrrobM7xOphTF374eUtnWZESlVQ
         XuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756132034; x=1756736834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUky9lqttrbpUCvILYpHg9Z0/QzSnBTRvjKKimO9Xdo=;
        b=qz8zXnlxdTvP0EOqBed+KS+RHAbFsu8WLup6chESclUAtVkMaNsLBCdFKXlNb6IATT
         7GQQNzhSeyugzwYMz7slw7S2JVdefc+33AQxRPUMRn/ZwwQeqSwMitqRX8U1nN9yomKI
         +Zoi7hN388h1rUNdcJODDxx1BOIKJfPKB8QTFqvDPVOfFD1/dzSff6PFMVZ4AW/QJiE2
         fqwkRzw2GkkSVjYlEaQnHvc/TElfyt0d47+Q2ZtCA9PkUvqPdPqMqX4Ajj49RsdLx3/z
         x6bYBr79C+SVr+ZlZ6wLk1k2wup7UbQrCZTa6mSNr9e5hWJHpcnvScviRSGQP2wfHgVQ
         vW4w==
X-Forwarded-Encrypted: i=1; AJvYcCWiOB6SVl8CHsMCWMK0Vam3vfULCzkc9kO3p++wE4w40m4NwTkOZ49cEoRj4JzOp84uCj+Y4a/ECUFlf0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjIACPrWeudcWsTFPTYXetOMJj9J3m7GHCLUeTKa+Eb1Drazd9
	/LNog4wVXgVhpzgHzxi45FMeUKX3F7B/K0gAsb50VKkHZV+D82rVaHbmoGCJf4hcTlo=
X-Gm-Gg: ASbGncuad3uEh8zvoO1K3Oayh2nJ4WYUS610qs5GMNU2I9aE0Zqj7w8I/es0l75QtZG
	kCtCpglUwS0NkC26Gm996865u8QcM2PGSMTDFlCpbY5GwJFMYILnOI8mrYnZpu7vahqYazT2S/X
	DtGzgFCiKQeDrXvmBnyZpPzgMxTrioJOfroZgKRJH5jkMNzciMq8QDl424QMMLwzfXNs+YJ8rDX
	ARiEW1z0bnSwbB492r4yST8+05zVIl52VKGFT44OH2b9GF3TSNWH+D9RU9Vb6py6DQMVK028IwT
	F8A4fcQQQEmSirNSojABZxbzKiI5lAAtILSlyiQ1jpEY4vuOGFoUQFgDAUifiGLjfHzI8izj9gw
	nG5jcTtIYIZ+sTqSO887jkrvx6chFx4/NNldL
X-Google-Smtp-Source: AGHT+IFyirK+nJVW3TSIPe8IdYzeCN4+xJ95Y/siJ2NO5IGM9xDzrIhZnHpMmswZS9kHh+gZ03v77w==
X-Received: by 2002:a05:6000:4022:b0:3ca:a190:c45a with SMTP id ffacd0b85a97d-3caa190c847mr1129222f8f.40.1756132034173;
        Mon, 25 Aug 2025 07:27:14 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b261:baab:ed3d:3cb6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm12634462f8f.14.2025.08.25.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:27:13 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 25 Aug 2025 16:26:36 +0200
Subject: [PATCH v2 11/12] clk: amlogic: align s4 and c3 pwm clock
 descriptions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-meson-clk-cleanup-24-v2-11-0f402f01e117@baylibre.com>
References: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
In-Reply-To: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=23845; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=KKJgRJArtEZnmgn+Mscv9ei4wZaRB5fejXiQda3cJb4=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBorHK32MkKZMhtncHhNzkjnsZZFAA/KL4kBfxgZ
 oR/8jZtjSuJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaKxytwAKCRDm/A8cN/La
 hcrMD/wKJEBRLsHXNqvrJqmH63n0JoDfvtdVeSwVwXL2ReXRCuoq4Yt61Ei4LdXQCg55TN/SZL2
 y1Gd9SsT1Y9bkoD1s22zoiE8PYOHFSNO9l2ejl9LFUPZ669l9WDXjNX/aF5e9/BJCO2xIyx0tGH
 010yzihS1Eh6eI6i31O32HBjGyOkKH/WFdpQVqCezS3qi8ikVd/agYTUuB4tuzcCUb/DtA/5Ktl
 pZTCYZm2oWFb9aLH/DYrfqSdSInx3Wbjiw0gQXPeIGr6gv0ox2CnNlddZMjyhzP8hOobDYLv7pW
 VjxSGfBtbgqSpFLAkz1v4yvr+n9RmRcWGx3p+DIHtiy5/SPueE3hPiXoFfjhlwgnRtacEBfp3Yg
 3raTRDKjfzcqyGXiyWUtpo9Ei4NstyySh8xeEOoeDihtOHMbLeVpDcr00rgOL6qkW8Fn1zA0/M5
 wBFcS7fGR42hfilpLGBnwT+r2Wc1RgAqnLcaL1mwju2U68HUog0tZYKwLYVPHkEEMwhmAfhKC9P
 gwsvkl/ED0WzWgtEpCeQl1BUhf7Plf5me5HjNQ7Uwx/vr1oac6uco7uAom/dnVNRBTJQyZ4Thf/
 FjMF1pmznyOmKzU4+CR5KtrybJ4S8LkWiZWwHa19DoXfsLGA3G8wn3tjS1ocvm6uYQEJkHIeyaT
 sgqM5SgLJfnNFAg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

s4 and c3 follow exactly the same structure when it comes to PWM clocks but
differ in the way these clocks are described, for no obvious reason.

Align the description of the pwm clocks of these SoCs with the composite
clock helpers.

Reviewed-by: Chuan Liu <chuan.liu@amlogic.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/c3-peripherals.c | 204 +++++----------
 drivers/clk/meson/s4-peripherals.c | 508 +++----------------------------------
 2 files changed, 103 insertions(+), 609 deletions(-)

diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
index 02c9820cd98655e57a290859b595cf09d39e5fe3..fd35f9b7994720d069c5f72142d6064790d40b60 100644
--- a/drivers/clk/meson/c3-peripherals.c
+++ b/drivers/clk/meson/c3-peripherals.c
@@ -48,6 +48,15 @@
 #define SPIFC_CLK_CTRL				0x1a0
 #define NNA_CLK_CTRL				0x220
 
+#define C3_COMP_SEL(_name, _reg, _shift, _mask, _pdata) \
+	MESON_COMP_SEL(c3_, _name, _reg, _shift, _mask, _pdata, NULL, 0, 0)
+
+#define C3_COMP_DIV(_name, _reg, _shift, _width) \
+	MESON_COMP_DIV(c3_, _name, _reg, _shift, _width, 0, CLK_SET_RATE_PARENT)
+
+#define C3_COMP_GATE(_name, _reg, _bit) \
+	MESON_COMP_GATE(c3_, _name, _reg, _bit, CLK_SET_RATE_PARENT)
+
 static struct clk_regmap c3_rtc_xtal_clkin = {
 	.data = &(struct clk_regmap_gate_data) {
 		.offset = RTC_BY_OSCIN_CTRL0,
@@ -512,146 +521,61 @@ static const struct clk_parent_data c3_pwm_parents[] = {
 	{ .fw_name = "fdiv3" }
 };
 
-#define C3_PWM_CLK_MUX(_name, _reg, _shift) {			\
-	.data = &(struct clk_regmap_mux_data) {			\
-		.offset = _reg,					\
-		.mask = 0x3,					\
-		.shift = _shift,				\
-	},							\
-	.hw.init = &(struct clk_init_data) {			\
-		.name = #_name "_sel",				\
-		.ops = &clk_regmap_mux_ops,			\
-		.parent_data = c3_pwm_parents,			\
-		.num_parents = ARRAY_SIZE(c3_pwm_parents),	\
-	},							\
-}
-
-#define C3_PWM_CLK_DIV(_name, _reg, _shift) {			\
-	.data = &(struct clk_regmap_div_data) {			\
-		.offset = _reg,					\
-		.shift = _shift,				\
-		.width = 8,					\
-	},							\
-	.hw.init = &(struct clk_init_data) {			\
-		.name = #_name "_div",				\
-		.ops = &clk_regmap_divider_ops,			\
-		.parent_names = (const char *[]) { #_name "_sel" },\
-		.num_parents = 1,				\
-		.flags = CLK_SET_RATE_PARENT,			\
-	},							\
-}
-
-#define C3_PWM_CLK_GATE(_name, _reg, _bit) {			\
-	.data = &(struct clk_regmap_gate_data) {		\
-		.offset = _reg,					\
-		.bit_idx = _bit,				\
-	},							\
-	.hw.init = &(struct clk_init_data) {			\
-		.name = #_name,					\
-		.ops = &clk_regmap_gate_ops,			\
-		.parent_names = (const char *[]) { #_name "_div" },\
-		.num_parents = 1,				\
-		.flags = CLK_SET_RATE_PARENT,			\
-	},							\
-}
-
-static struct clk_regmap c3_pwm_a_sel =
-	C3_PWM_CLK_MUX(pwm_a, PWM_CLK_AB_CTRL, 9);
-static struct clk_regmap c3_pwm_a_div =
-	C3_PWM_CLK_DIV(pwm_a, PWM_CLK_AB_CTRL, 0);
-static struct clk_regmap c3_pwm_a =
-	C3_PWM_CLK_GATE(pwm_a, PWM_CLK_AB_CTRL, 8);
-
-static struct clk_regmap c3_pwm_b_sel =
-	C3_PWM_CLK_MUX(pwm_b, PWM_CLK_AB_CTRL, 25);
-static struct clk_regmap c3_pwm_b_div =
-	C3_PWM_CLK_DIV(pwm_b, PWM_CLK_AB_CTRL, 16);
-static struct clk_regmap c3_pwm_b =
-	C3_PWM_CLK_GATE(pwm_b, PWM_CLK_AB_CTRL, 24);
-
-static struct clk_regmap c3_pwm_c_sel =
-	C3_PWM_CLK_MUX(pwm_c, PWM_CLK_CD_CTRL, 9);
-static struct clk_regmap c3_pwm_c_div =
-	C3_PWM_CLK_DIV(pwm_c, PWM_CLK_CD_CTRL, 0);
-static struct clk_regmap c3_pwm_c =
-	C3_PWM_CLK_GATE(pwm_c, PWM_CLK_CD_CTRL, 8);
-
-static struct clk_regmap c3_pwm_d_sel =
-	C3_PWM_CLK_MUX(pwm_d, PWM_CLK_CD_CTRL, 25);
-static struct clk_regmap c3_pwm_d_div =
-	C3_PWM_CLK_DIV(pwm_d, PWM_CLK_CD_CTRL, 16);
-static struct clk_regmap c3_pwm_d =
-	C3_PWM_CLK_GATE(pwm_d, PWM_CLK_CD_CTRL, 24);
-
-static struct clk_regmap c3_pwm_e_sel =
-	C3_PWM_CLK_MUX(pwm_e, PWM_CLK_EF_CTRL, 9);
-static struct clk_regmap c3_pwm_e_div =
-	C3_PWM_CLK_DIV(pwm_e, PWM_CLK_EF_CTRL, 0);
-static struct clk_regmap c3_pwm_e =
-	C3_PWM_CLK_GATE(pwm_e, PWM_CLK_EF_CTRL, 8);
-
-static struct clk_regmap c3_pwm_f_sel =
-	C3_PWM_CLK_MUX(pwm_f, PWM_CLK_EF_CTRL, 25);
-static struct clk_regmap c3_pwm_f_div =
-	C3_PWM_CLK_DIV(pwm_f, PWM_CLK_EF_CTRL, 16);
-static struct clk_regmap c3_pwm_f =
-	C3_PWM_CLK_GATE(pwm_f, PWM_CLK_EF_CTRL, 24);
-
-static struct clk_regmap c3_pwm_g_sel =
-	C3_PWM_CLK_MUX(pwm_g, PWM_CLK_GH_CTRL, 9);
-static struct clk_regmap c3_pwm_g_div =
-	C3_PWM_CLK_DIV(pwm_g, PWM_CLK_GH_CTRL, 0);
-static struct clk_regmap c3_pwm_g =
-	C3_PWM_CLK_GATE(pwm_g, PWM_CLK_GH_CTRL, 8);
-
-static struct clk_regmap c3_pwm_h_sel =
-	C3_PWM_CLK_MUX(pwm_h, PWM_CLK_GH_CTRL, 25);
-static struct clk_regmap c3_pwm_h_div =
-	C3_PWM_CLK_DIV(pwm_h, PWM_CLK_GH_CTRL, 16);
-static struct clk_regmap c3_pwm_h =
-	C3_PWM_CLK_GATE(pwm_h, PWM_CLK_GH_CTRL, 24);
-
-static struct clk_regmap c3_pwm_i_sel =
-	C3_PWM_CLK_MUX(pwm_i, PWM_CLK_IJ_CTRL, 9);
-static struct clk_regmap c3_pwm_i_div =
-	C3_PWM_CLK_DIV(pwm_i, PWM_CLK_IJ_CTRL, 0);
-static struct clk_regmap c3_pwm_i =
-	C3_PWM_CLK_GATE(pwm_i, PWM_CLK_IJ_CTRL, 8);
-
-static struct clk_regmap c3_pwm_j_sel =
-	C3_PWM_CLK_MUX(pwm_j, PWM_CLK_IJ_CTRL, 25);
-static struct clk_regmap c3_pwm_j_div =
-	C3_PWM_CLK_DIV(pwm_j, PWM_CLK_IJ_CTRL, 16);
-static struct clk_regmap c3_pwm_j =
-	C3_PWM_CLK_GATE(pwm_j, PWM_CLK_IJ_CTRL, 24);
-
-static struct clk_regmap c3_pwm_k_sel =
-	C3_PWM_CLK_MUX(pwm_k, PWM_CLK_KL_CTRL, 9);
-static struct clk_regmap c3_pwm_k_div =
-	C3_PWM_CLK_DIV(pwm_k, PWM_CLK_KL_CTRL, 0);
-static struct clk_regmap c3_pwm_k =
-	C3_PWM_CLK_GATE(pwm_k, PWM_CLK_KL_CTRL, 8);
-
-static struct clk_regmap c3_pwm_l_sel =
-	C3_PWM_CLK_MUX(pwm_l, PWM_CLK_KL_CTRL, 25);
-static struct clk_regmap c3_pwm_l_div =
-	C3_PWM_CLK_DIV(pwm_l, PWM_CLK_KL_CTRL, 16);
-static struct clk_regmap c3_pwm_l =
-	C3_PWM_CLK_GATE(pwm_l, PWM_CLK_KL_CTRL, 24);
-
-static struct clk_regmap c3_pwm_m_sel =
-	C3_PWM_CLK_MUX(pwm_m, PWM_CLK_MN_CTRL, 9);
-static struct clk_regmap c3_pwm_m_div =
-	C3_PWM_CLK_DIV(pwm_m, PWM_CLK_MN_CTRL, 0);
-static struct clk_regmap c3_pwm_m =
-	C3_PWM_CLK_GATE(pwm_m, PWM_CLK_MN_CTRL, 8);
-
-static struct clk_regmap c3_pwm_n_sel =
-	C3_PWM_CLK_MUX(pwm_n, PWM_CLK_MN_CTRL, 25);
-static struct clk_regmap c3_pwm_n_div =
-	C3_PWM_CLK_DIV(pwm_n, PWM_CLK_MN_CTRL, 16);
-static struct clk_regmap c3_pwm_n =
-	C3_PWM_CLK_GATE(pwm_n, PWM_CLK_MN_CTRL, 24);
+static C3_COMP_SEL(pwm_a, PWM_CLK_AB_CTRL, 9, 0x3, c3_pwm_parents);
+static C3_COMP_DIV(pwm_a, PWM_CLK_AB_CTRL, 0, 8);
+static C3_COMP_GATE(pwm_a, PWM_CLK_AB_CTRL, 8);
+
+static C3_COMP_SEL(pwm_b, PWM_CLK_AB_CTRL, 25, 0x3, c3_pwm_parents);
+static C3_COMP_DIV(pwm_b, PWM_CLK_AB_CTRL, 16, 8);
+static C3_COMP_GATE(pwm_b, PWM_CLK_AB_CTRL, 24);
+
+static C3_COMP_SEL(pwm_c, PWM_CLK_CD_CTRL, 9, 0x3, c3_pwm_parents);
+static C3_COMP_DIV(pwm_c, PWM_CLK_CD_CTRL, 0, 8);
+static C3_COMP_GATE(pwm_c, PWM_CLK_CD_CTRL, 8);
+
+static C3_COMP_SEL(pwm_d, PWM_CLK_CD_CTRL, 25, 0x3, c3_pwm_parents);
+static C3_COMP_DIV(pwm_d, PWM_CLK_CD_CTRL, 16, 8);
+static C3_COMP_GATE(pwm_d, PWM_CLK_CD_CTRL, 24);
+
+static C3_COMP_SEL(pwm_e, PWM_CLK_EF_CTRL, 9, 0x3, c3_pwm_parents);
+static C3_COMP_DIV(pwm_e, PWM_CLK_EF_CTRL, 0, 8);
+static C3_COMP_GATE(pwm_e, PWM_CLK_EF_CTRL, 8);
+
+static C3_COMP_SEL(pwm_f, PWM_CLK_EF_CTRL, 25, 0x3, c3_pwm_parents);
+static C3_COMP_DIV(pwm_f, PWM_CLK_EF_CTRL, 16, 8);
+static C3_COMP_GATE(pwm_f, PWM_CLK_EF_CTRL, 24);
+
+static C3_COMP_SEL(pwm_g, PWM_CLK_GH_CTRL, 9, 0x3, c3_pwm_parents);
+static C3_COMP_DIV(pwm_g, PWM_CLK_GH_CTRL, 0, 8);
+static C3_COMP_GATE(pwm_g, PWM_CLK_GH_CTRL, 8);
+
+static C3_COMP_SEL(pwm_h, PWM_CLK_GH_CTRL, 25, 0x3, c3_pwm_parents);
+static C3_COMP_DIV(pwm_h, PWM_CLK_GH_CTRL, 16, 8);
+static C3_COMP_GATE(pwm_h, PWM_CLK_GH_CTRL, 24);
+
+static C3_COMP_SEL(pwm_i, PWM_CLK_IJ_CTRL, 9, 0x3, c3_pwm_parents);
+static C3_COMP_DIV(pwm_i, PWM_CLK_IJ_CTRL, 0, 8);
+static C3_COMP_GATE(pwm_i, PWM_CLK_IJ_CTRL, 8);
+
+static C3_COMP_SEL(pwm_j, PWM_CLK_IJ_CTRL, 25, 0x3, c3_pwm_parents);
+static C3_COMP_DIV(pwm_j, PWM_CLK_IJ_CTRL, 16, 8);
+static C3_COMP_GATE(pwm_j, PWM_CLK_IJ_CTRL, 24);
+
+static C3_COMP_SEL(pwm_k, PWM_CLK_KL_CTRL, 9, 0x3, c3_pwm_parents);
+static C3_COMP_DIV(pwm_k, PWM_CLK_KL_CTRL, 0, 8);
+static C3_COMP_GATE(pwm_k, PWM_CLK_KL_CTRL, 8);
+
+static C3_COMP_SEL(pwm_l, PWM_CLK_KL_CTRL, 25, 0x3, c3_pwm_parents);
+static C3_COMP_DIV(pwm_l, PWM_CLK_KL_CTRL, 16, 8);
+static C3_COMP_GATE(pwm_l, PWM_CLK_KL_CTRL, 24);
+
+static C3_COMP_SEL(pwm_m, PWM_CLK_MN_CTRL, 9, 0x3, c3_pwm_parents);
+static C3_COMP_DIV(pwm_m, PWM_CLK_MN_CTRL, 0, 8);
+static C3_COMP_GATE(pwm_m, PWM_CLK_MN_CTRL, 8);
+
+static C3_COMP_SEL(pwm_n, PWM_CLK_MN_CTRL, 25, 0x3, c3_pwm_parents);
+static C3_COMP_DIV(pwm_n, PWM_CLK_MN_CTRL, 16, 8);
+static C3_COMP_GATE(pwm_n, PWM_CLK_MN_CTRL, 24);
 
 static const struct clk_parent_data c3_spicc_parents[] = {
 	{ .fw_name = "oscin" },
diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index 3e048e645b080f9e5982ef908e3f9c43578a0b5f..6d69b132d1e1f5950d73757c45b920c9c9052344 100644
--- a/drivers/clk/meson/s4-peripherals.c
+++ b/drivers/clk/meson/s4-peripherals.c
@@ -62,6 +62,15 @@
 #define CLKCTRL_PWM_CLK_IJ_CTRL                    0x190
 #define CLKCTRL_DEMOD_CLK_CTRL                     0x200
 
+#define S4_COMP_SEL(_name, _reg, _shift, _mask, _pdata) \
+	MESON_COMP_SEL(s4_, _name, _reg, _shift, _mask, _pdata, NULL, 0, 0)
+
+#define S4_COMP_DIV(_name, _reg, _shift, _width) \
+	MESON_COMP_DIV(s4_, _name, _reg, _shift, _width, 0, CLK_SET_RATE_PARENT)
+
+#define S4_COMP_GATE(_name, _reg, _bit) \
+	MESON_COMP_GATE(s4_, _name, _reg, _bit, CLK_SET_RATE_PARENT)
+
 static struct clk_regmap s4_rtc_32k_by_oscin_clkin = {
 	.data = &(struct clk_regmap_gate_data){
 		.offset = CLKCTRL_RTC_BY_OSCIN_CTRL0,
@@ -2559,484 +2568,45 @@ static const struct clk_parent_data s4_pwm_parents[] = {
 	{ .fw_name = "fclk_div3", },
 };
 
-static struct clk_regmap s4_pwm_a_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
-		.mask = 0x3,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_a_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = s4_pwm_parents,
-		.num_parents = ARRAY_SIZE(s4_pwm_parents),
-		.flags = 0,
-	},
-};
-
-static struct clk_regmap s4_pwm_a_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
-		.shift = 0,
-		.width = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_a_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_a_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap s4_pwm_a = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_a_gate",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_a_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap s4_pwm_b_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
-		.mask = 0x3,
-		.shift = 25,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_b_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = s4_pwm_parents,
-		.num_parents = ARRAY_SIZE(s4_pwm_parents),
-		.flags = 0,
-	},
-};
-
-static struct clk_regmap s4_pwm_b_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
-		.shift = 16,
-		.width = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_b_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_b_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap s4_pwm_b = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
-		.bit_idx = 24,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_b",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_b_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap s4_pwm_c_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
-		.mask = 0x3,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_c_mux",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = s4_pwm_parents,
-		.num_parents = ARRAY_SIZE(s4_pwm_parents),
-		.flags = 0,
-	},
-};
-
-static struct clk_regmap s4_pwm_c_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
-		.shift = 0,
-		.width = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_c_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_c_sel.hw
-		},
-		.num_parents = 1,
-	},
-};
-
-static struct clk_regmap s4_pwm_c = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_c",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_c_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap s4_pwm_d_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
-		.mask = 0x3,
-		.shift = 25,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_d_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = s4_pwm_parents,
-		.num_parents = ARRAY_SIZE(s4_pwm_parents),
-		.flags = 0,
-	},
-};
-
-static struct clk_regmap s4_pwm_d_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
-		.shift = 16,
-		.width = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_d_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_d_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap s4_pwm_d = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = CLKCTRL_PWM_CLK_CD_CTRL,
-		.bit_idx = 24,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_d",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_d_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap s4_pwm_e_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
-		.mask = 0x3,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_e_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = s4_pwm_parents,
-		.num_parents = ARRAY_SIZE(s4_pwm_parents),
-		.flags = 0,
-	},
-};
-
-static struct clk_regmap s4_pwm_e_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
-		.shift = 0,
-		.width = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_e_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_e_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap s4_pwm_e = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_e",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_e_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap s4_pwm_f_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
-		.mask = 0x3,
-		.shift = 25,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_f_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = s4_pwm_parents,
-		.num_parents = ARRAY_SIZE(s4_pwm_parents),
-		.flags = 0,
-	},
-};
+static S4_COMP_SEL(pwm_a, CLKCTRL_PWM_CLK_AB_CTRL, 9, 0x3, s4_pwm_parents);
+static S4_COMP_DIV(pwm_a, CLKCTRL_PWM_CLK_AB_CTRL, 0, 8);
+static S4_COMP_GATE(pwm_a, CLKCTRL_PWM_CLK_AB_CTRL, 8);
 
-static struct clk_regmap s4_pwm_f_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
-		.shift = 16,
-		.width = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_f_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_f_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static S4_COMP_SEL(pwm_b, CLKCTRL_PWM_CLK_AB_CTRL, 25, 0x3, s4_pwm_parents);
+static S4_COMP_DIV(pwm_b, CLKCTRL_PWM_CLK_AB_CTRL, 16, 8);
+static S4_COMP_GATE(pwm_b, CLKCTRL_PWM_CLK_AB_CTRL, 24);
 
-static struct clk_regmap s4_pwm_f = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = CLKCTRL_PWM_CLK_EF_CTRL,
-		.bit_idx = 24,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_f",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_f_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static S4_COMP_SEL(pwm_c, CLKCTRL_PWM_CLK_CD_CTRL, 9, 0x3, s4_pwm_parents);
+static S4_COMP_DIV(pwm_c, CLKCTRL_PWM_CLK_CD_CTRL, 0, 8);
+static S4_COMP_GATE(pwm_c, CLKCTRL_PWM_CLK_CD_CTRL, 8);
 
-static struct clk_regmap s4_pwm_g_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
-		.mask = 0x3,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_g_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = s4_pwm_parents,
-		.num_parents = ARRAY_SIZE(s4_pwm_parents),
-		.flags = 0,
-	},
-};
+static S4_COMP_SEL(pwm_d, CLKCTRL_PWM_CLK_CD_CTRL, 25, 0x3, s4_pwm_parents);
+static S4_COMP_DIV(pwm_d, CLKCTRL_PWM_CLK_CD_CTRL, 16, 8);
+static S4_COMP_GATE(pwm_d, CLKCTRL_PWM_CLK_CD_CTRL, 24);
 
-static struct clk_regmap s4_pwm_g_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
-		.shift = 0,
-		.width = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_g_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_g_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static S4_COMP_SEL(pwm_e, CLKCTRL_PWM_CLK_EF_CTRL, 9, 0x3, s4_pwm_parents);
+static S4_COMP_DIV(pwm_e, CLKCTRL_PWM_CLK_EF_CTRL, 0, 8);
+static S4_COMP_GATE(pwm_e, CLKCTRL_PWM_CLK_EF_CTRL, 8);
 
-static struct clk_regmap s4_pwm_g = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_g",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_g_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static S4_COMP_SEL(pwm_f, CLKCTRL_PWM_CLK_EF_CTRL, 25, 0x3, s4_pwm_parents);
+static S4_COMP_DIV(pwm_f, CLKCTRL_PWM_CLK_EF_CTRL, 16, 8);
+static S4_COMP_GATE(pwm_f, CLKCTRL_PWM_CLK_EF_CTRL, 24);
 
-static struct clk_regmap s4_pwm_h_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
-		.mask = 0x3,
-		.shift = 25,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_h_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = s4_pwm_parents,
-		.num_parents = ARRAY_SIZE(s4_pwm_parents),
-		.flags = 0,
-	},
-};
+static S4_COMP_SEL(pwm_g, CLKCTRL_PWM_CLK_GH_CTRL, 9, 0x3, s4_pwm_parents);
+static S4_COMP_DIV(pwm_g, CLKCTRL_PWM_CLK_GH_CTRL, 0, 8);
+static S4_COMP_GATE(pwm_g, CLKCTRL_PWM_CLK_GH_CTRL, 8);
 
-static struct clk_regmap s4_pwm_h_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
-		.shift = 16,
-		.width = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_h_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_h_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static S4_COMP_SEL(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 25, 0x3, s4_pwm_parents);
+static S4_COMP_DIV(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 16, 8);
+static S4_COMP_GATE(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 24);
 
-static struct clk_regmap s4_pwm_h = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = CLKCTRL_PWM_CLK_GH_CTRL,
-		.bit_idx = 24,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_h",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_h_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static S4_COMP_SEL(pwm_i, CLKCTRL_PWM_CLK_IJ_CTRL, 9, 0x3, s4_pwm_parents);
+static S4_COMP_DIV(pwm_i, CLKCTRL_PWM_CLK_IJ_CTRL, 0, 8);
+static S4_COMP_GATE(pwm_i, CLKCTRL_PWM_CLK_IJ_CTRL, 8);
 
-static struct clk_regmap s4_pwm_i_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
-		.mask = 0x3,
-		.shift = 9,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_i_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = s4_pwm_parents,
-		.num_parents = ARRAY_SIZE(s4_pwm_parents),
-		.flags = 0,
-	},
-};
-
-static struct clk_regmap s4_pwm_i_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
-		.shift = 0,
-		.width = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_i_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_i_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap s4_pwm_i = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
-		.bit_idx = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_i",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_i_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap s4_pwm_j_sel = {
-	.data = &(struct clk_regmap_mux_data) {
-		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
-		.mask = 0x3,
-		.shift = 25,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_j_sel",
-		.ops = &clk_regmap_mux_ops,
-		.parent_data = s4_pwm_parents,
-		.num_parents = ARRAY_SIZE(s4_pwm_parents),
-		.flags = 0,
-	},
-};
-
-static struct clk_regmap s4_pwm_j_div = {
-	.data = &(struct clk_regmap_div_data) {
-		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
-		.shift = 16,
-		.width = 8,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_j_div",
-		.ops = &clk_regmap_divider_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_j_sel.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
-
-static struct clk_regmap s4_pwm_j = {
-	.data = &(struct clk_regmap_gate_data) {
-		.offset = CLKCTRL_PWM_CLK_IJ_CTRL,
-		.bit_idx = 24,
-	},
-	.hw.init = &(struct clk_init_data){
-		.name = "pwm_j",
-		.ops = &clk_regmap_gate_ops,
-		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_j_div.hw
-		},
-		.num_parents = 1,
-		.flags = CLK_SET_RATE_PARENT,
-	},
-};
+static S4_COMP_SEL(pwm_j, CLKCTRL_PWM_CLK_IJ_CTRL, 25, 0x3, s4_pwm_parents);
+static S4_COMP_DIV(pwm_j, CLKCTRL_PWM_CLK_IJ_CTRL, 16, 8);
+static S4_COMP_GATE(pwm_j, CLKCTRL_PWM_CLK_IJ_CTRL, 24);
 
 static struct clk_regmap s4_saradc_sel = {
 	.data = &(struct clk_regmap_mux_data) {

-- 
2.47.2


