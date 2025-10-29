Return-Path: <linux-kernel+bounces-876302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 201E2C1B97A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F84066105C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47251357705;
	Wed, 29 Oct 2025 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlrVjYni"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96E302161
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746180; cv=none; b=aDgPQqpaVGlZxLcVaUAZLcAR/RulX5sdcAehQfrNmdd190rtwdFsq8Xbyb2GJzpzK8F39A1s0b2aWV8D3Tw7N60CMh746cv2+SKzDY9jdYBsGWhRzKhkzR3zz8EJTcrqtecBpk0ysajP+pPj0HBnKVhZZCuiwN3GYJpryzvq3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746180; c=relaxed/simple;
	bh=j3R2uXoM/Etft2azckQg/VwhpCxp23HVCKOSpioe9N8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGAMozcI3SnPP65APtyougDqvy8RpI1jsY19nvhawAHfmD1Y3nhPSHCElitjXOUi1S4WaMgvjvDGZGlmVOGEtC3GUG6DdL/gwreIVghGqliAKJOrynVRdGkvc5zk7Bnol5Op251Ip7aIcyLuXL3BGt1ZWbcJEwMVyjaoXhWJBFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlrVjYni; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d4e44c54aso1245207666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761746176; x=1762350976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=424Af6Pbv8SbwK0/36n/ieiQLcjf42UYg5pYhDqtE64=;
        b=NlrVjYniQiN/x3qtgehSBIShnRogo0ZaTAmkdB334wsuPZ/mTmVBZhW6j+eVDFIJ0U
         xAjSzDSfn9IQCWbK7PZLFjB3jqYQ77kzx9NFDycPn1sLiwNjstngY6Yt4pNwLyxs1Fvz
         XaHXPBIRYM9Qo6zCr8brtLohEaL51l/ugt9YIN4djZTvFeZHno8umKpuZIaKk+44KLTg
         7EBjFiRXzVr1G71EFaduKx6P5gwRRE9NlpdzlEOIcpPJcdGEo3RZmILD0576Mgggi90h
         VNpxbpOghxi3HTA8vLs6BMB8VVRS+Q9HTWWXP62VZoWqJGgIovO0vJuD1gqYpQuIF1My
         mGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761746177; x=1762350977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=424Af6Pbv8SbwK0/36n/ieiQLcjf42UYg5pYhDqtE64=;
        b=Mi8EH+zCYxQUAcd5+QWVWnjU/TM8Hc+QbhAap1ML6T0TcHu+mN7q+wVJ4kWBGOwHdA
         fTKYQwWqLe9bCmnnOp7i/WjEQRRUIKLrZYNRaEbjYK2H64nkcda1Li3Zpbv/M4iZYfxa
         69Jf8+e6QE6155pK3O2sxqeGd8YEKUde2VL2qGcUvoxDgZ+BdUEVWsperSSiXagOftAM
         3ps7sLbDQ6PABedYMYzq9xImh+Fqboi6nFIqTvYLYIfRSon0qYVaBQzLFGTH9K16FpxV
         F7fpPFFlUCWvCqTaIFLzK9oX2e6Fic/EB/cnZQPHugczo/LR8CiW7thP7GTu99PggULX
         LnTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQEkRz1Axz7XGW7obRCpoSp4gS8al/1iYH0hvNWuE2OykMwMUM/u0CKqe/LscMO7/6/y3ZBvgcFnqiEEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYEJmI2nfrUhHBiJkXM3UqTbMhx1UGO2I1PwBLjSkJKGIq0bJp
	A39NBETIk7GmGp+Dk/zsTuqS26qQcATaLVJR9C4EdDLgc5zHeCXhvOxR
X-Gm-Gg: ASbGncuFYwILN1/OHGJmGREnpJuPOpj+2sKMU91lot06Wy+Bhb9AHvaj61ZvLlilV4h
	2VpHzvvP1cguod+E9TazXILMc5VDWcMlqMqRhTw+1uzAax5gHfOIvJqsavPMw2hNHvClc5T/+OI
	otJA28yD6TEt8rXKfJkh0eT7nMvx9bu13YjgcEDgh+ZiHfEsgjA+UyUtPeqz3+CXafko07vdc9d
	muGzJsMkM9IJQRz7iaac7gdhfHQXARh+bFJkPIQ8tf38BdrxA8+N8IsUgELfznAjjEZLrbCPIAG
	lbW/rJk+M0p5gOhtqFDOAux67C+iSiOvU5Ac+Tde3Jy0SaZ1dQdDf3MGla9CBA2DZxw50Ei6Pi3
	FwZIcXlP0yZv8lvXvmZCkRmpXFKV5p84+w2zSeqvQZXurfhGCUNcooUbyfdqRqxflKT/gHQMX2m
	ucj8OpC7qN15HOYpRluOn64q6hrg==
X-Google-Smtp-Source: AGHT+IGW71s06HOeamIvGEWwmfCKA0lO2ind9hiNyNeFinhDdkAcMBYKLqyvdDoCQ0vzL31+LZ8kKg==
X-Received: by 2002:a17:907:1b22:b0:b6d:6c11:e9fe with SMTP id a640c23a62f3a-b703d5b0deemr281105666b.64.1761746176434;
        Wed, 29 Oct 2025 06:56:16 -0700 (PDT)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8534d99dsm1444960766b.21.2025.10.29.06.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:56:16 -0700 (PDT)
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
Subject: [PATCH v3 7/8] reset: imx8mp-audiomix: Support i.MX8ULP SIM LPAV
Date: Wed, 29 Oct 2025 06:52:28 -0700
Message-ID: <20251029135229.890-8-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
References: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
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
 drivers/reset/reset-imx8mp-audiomix.c | 45 +++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index 5ee5a32c6950..4e420c6b8fdc 100644
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
@@ -51,6 +54,44 @@ static const struct imx8mp_reset_info imx8mp_reset_info = {
 	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
 };
 
+static const struct imx8mp_reset_map imx8ulp_reset_map[] = {
+	[IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST] = {
+		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
+		.mask = BIT(25),
+		.active_low = false,
+	},
+	[IMX8ULP_SIM_LPAV_HIFI4_DSP_RST] = {
+		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
+		.mask = BIT(16),
+		.active_low = false,
+	},
+	[IMX8ULP_SIM_LPAV_HIFI4_DSP_STALL] = {
+		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
+		.mask = BIT(13),
+		.active_low = false,
+	},
+	[IMX8ULP_SIM_LPAV_DSI_RST_BYTE_N] = {
+		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
+		.mask = BIT(5),
+		.active_low = true,
+	},
+	[IMX8ULP_SIM_LPAV_DSI_RST_ESC_N] = {
+		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
+		.mask = BIT(4),
+		.active_low = true,
+	},
+	[IMX8ULP_SIM_LPAV_DSI_RST_DPI_N] = {
+		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
+		.mask = BIT(3),
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
@@ -179,6 +220,10 @@ static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
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


