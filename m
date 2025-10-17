Return-Path: <linux-kernel+bounces-857942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD80BE84C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5C1625B99
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969C1350D51;
	Fri, 17 Oct 2025 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJU0juSS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA6134DCCE
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700122; cv=none; b=R1r0Ie6TgUXSz/E9X0ppWjyDAGcDTCgY/xjaXn/vZVImK+pSIFKnzurpX93ZSwgipBACv0YrZ68sUeMJ9t+AlQnbGzNMk+W6rG5K0iNEP4mcG+lNW7dByXGwbgbKLk1lcqx+IfCX2Y5qNL9o1ud2cjI4OtZHhLvxb7sSdjCEsGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700122; c=relaxed/simple;
	bh=+Ey9SbmZcpxONfuufQWjoq8uULlUbxrUUaDZu5U2L78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFW5L4m7tFWuopqfPfrtXCjtVe/oWWFtSPZhcmhHkx7PZPLdFFzj17OsUoqELGHED0eyhCo/6k11Mf21/GHlMH7vZrdXMOWd6Ox/dZ+OyHMNuL4xma7PZhLEtLk9nOJpvSD6wg2E7Co1Fi+qClU6F8ixd+9XLJyEeg8n6rxKrgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJU0juSS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3d80891c6cso519549266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760700119; x=1761304919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUV6qtcx4rMTHA9YbDeCb7EleNNSZvqvmp58IK55HCg=;
        b=iJU0juSSyOnSlY93U2YRo6UI5S93aGarr6GL0MeXZjCo7e2DuHrHKYGj2zwm6IlGcR
         PhePU63v05jTNEYlXrVse50X3g9+NyxMn9jYZdrWxGNkD1esSCJe5H0ekoUAA7Go0sj3
         19Up68gqj/Q395iX8e5Ujye26jMsaLUoeDQ8M7Cm7Z1nEtJ4a0899fRk0CCsJgSxcPLP
         2aDs6FX4v7F1LzszlUJZcuQBm2lQoy7X2Qh3NaVx9ODoxfW0IQA0uf+hrXKpRIuIfF38
         OAkAcyDk1wqRqMCBFnjGWoTTPi1WlVTtVIBkckRAFCfL9iRnk0lx8Og/pQjK6LF6bd3b
         Od9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760700119; x=1761304919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUV6qtcx4rMTHA9YbDeCb7EleNNSZvqvmp58IK55HCg=;
        b=lQ3mJWzxnyBNAFkT1KT74SDM1no9CNLA/u44FJBtwSYBi+J32dzHWG9t6nzAN3vRV7
         sD0vRLJdMhKWw71e9djmGFflrMhl3TaeeJT4lfs0p4xdK2JePfixaun0NYEshfUqb489
         91G9AIiKTdLpylGPw3tjquRvUu2F/+e/oLKpL6D2qpg5brw3nbAIoc08O4x+H4y3ht9Q
         bFyhe293WCSCPIxyR01kGPisNkoraM4vVqqNpglfF7hEzXwtUjCVeEGCtFAruGrdgfNl
         HFdlaIQzilRLTMOYyvbJSGBvrBtcL6eEDCg830F0JnKBwX8CfVa780XjKLQ0OUE2oAVI
         Ok3g==
X-Forwarded-Encrypted: i=1; AJvYcCVLozZHLx2cjt6ap6gmglRk8TKyryP1JVRrIkd+4JKlIOAwvMMe0GKo5VauMbrwaBt7mccLasnxxB9VYvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRJipuQrzcEAY6XYahP1r/JyKzKrvjb8B8g90ycCJkw+F47f6R
	dlmB/I8koxPQmOGlsd+lbmTSusbXmAhVWZnXsSVRXs+p0f5sQ3StsSrV
X-Gm-Gg: ASbGncvt6vej4P5e+vcbwyEuyIbX/1gvuBLxl0ERFvB1/vJY2pWIsfjYXDIfIQDhSmG
	Kj0ItBKDC0FJeBsTX4hVzZZM8/RA3mgsCvCIUyriO/mnvX2cpXvs6LZtJbJbQApDzDBu5MGBhkF
	zRPkXi7m+nFWQ9r5GvBfpUY6Zp/LlSGkb7NYMM8ZF0/Ew0OiuOevM0rFfERcYaRRTrE+QC8EcPG
	7tmZoOdjTCXbKZpRDcUB4Lac1r5qpMPXAZN7ijto61XQKvqMM6Bsytl56101p0AJB1nAKLqjlBU
	lmA1n23NCIVr4v8jHmc0cKK+tRFXGvQUUqfzb468Ynd+n094TC/m9F1W4zA8oojuHn1HZk2PZ/j
	Lor6yYW4Ll0SoLaCcp3Z/OSHQJoJruqyrSiQTe9rZNIg0+Wb0uv39F0Zz4X56w8NceNSksT2h6N
	5mVlEDa1nfKEDW9RNWxKJOgis32TXdysjWdpeskg==
X-Google-Smtp-Source: AGHT+IGBmOLlRjgaTi3Dp0i7n6ywhQoBAle46tY4Ru1l6tF04+Mf45lE3lTlEpkDb4XkYETG5Xjxmw==
X-Received: by 2002:a17:907:a0b:b0:afe:159:14b1 with SMTP id a640c23a62f3a-b645d20ef0fmr390859366b.9.1760700119091;
        Fri, 17 Oct 2025 04:21:59 -0700 (PDT)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd1af35fsm788256166b.60.2025.10.17.04.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:21:58 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 7/8] reset: imx8mp-audiomix: Support i.MX8ULP SIM LPAV
Date: Fri, 17 Oct 2025 04:20:24 -0700
Message-ID: <20251017112025.11997-8-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Support i.MX8ULP's SIM LPAV by adding its reset map definition.

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/reset/reset-imx8mp-audiomix.c | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index c370913107f5..b333d7c1442a 100644
--- a/drivers/reset/reset-imx8mp-audiomix.c
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -3,6 +3,7 @@
  * Copyright 2024 NXP
  */
 
+#include <dt-bindings/reset/fsl,imx8ulp-sim-lpav.h>
 #include <dt-bindings/reset/imx8mp-reset-audiomix.h>
 
 #include <linux/auxiliary_bus.h>
@@ -17,6 +18,8 @@
 #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
 #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
 
+#define IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET	0x8
+
 struct imx8mp_reset_map {
 	unsigned int offset;
 	unsigned int mask;
@@ -55,6 +58,50 @@ static const struct imx8mp_reset_info imx8mp_reset_info = {
 	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
 };
 
+static const struct imx8mp_reset_map imx8ulp_reset_map[] = {
+	[IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST] = {
+		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
+		.mask = BIT(25),
+		.shift = 25,
+		.active_low = false,
+	},
+	[IMX8ULP_SIM_LPAV_HIFI4_DSP_RST] = {
+		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
+		.mask = BIT(16),
+		.shift = 16,
+		.active_low = false,
+	},
+	[IMX8ULP_SIM_LPAV_HIFI4_DSP_STALL] = {
+		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
+		.mask = BIT(13),
+		.shift = 13,
+		.active_low = false,
+	},
+	[IMX8ULP_SIM_LPAV_DSI_RST_BYTE_N] = {
+		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
+		.mask = BIT(5),
+		.shift = 5,
+		.active_low = true,
+	},
+	[IMX8ULP_SIM_LPAV_DSI_RST_ESC_N] = {
+		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
+		.mask = BIT(4),
+		.shift = 4,
+		.active_low = true,
+	},
+	[IMX8ULP_SIM_LPAV_DSI_RST_DPI_N] = {
+		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
+		.mask = BIT(3),
+		.shift = 3,
+		.active_low = true,
+	},
+};
+
+static const struct imx8mp_reset_info imx8ulp_reset_info = {
+	.map = imx8ulp_reset_map,
+	.num_lines = ARRAY_SIZE(imx8ulp_reset_map),
+};
+
 struct imx8mp_audiomix_reset {
 	struct reset_controller_dev rcdev;
 	void __iomem *base;
@@ -183,6 +230,10 @@ static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
 		.name = "clk_imx8mp_audiomix.reset",
 		.driver_data = (kernel_ulong_t)&imx8mp_reset_info,
 	},
+	{
+		.name = "clk_imx8ulp_sim_lpav.reset",
+		.driver_data = (kernel_ulong_t)&imx8ulp_reset_info,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
-- 
2.43.0


