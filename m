Return-Path: <linux-kernel+bounces-755483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D86B3B1A6D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D08188563A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75575274FFD;
	Mon,  4 Aug 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En1RijAH"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0418C274B4B;
	Mon,  4 Aug 2025 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322928; cv=none; b=jF/myz/cLWKToP2KzKtde47gKYuQcz89lP5kS4n3YG5Y8MI3f+Sj38FXmve2S3bkRJViXzw371UJrKGGJe+G3w9imRzuypySBve87PGVCT17TEnHDjHCkSOAXE6ia608/YR369ZeVJn2YAluOWvTy2plQR6f1DhihonzDievzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322928; c=relaxed/simple;
	bh=uweK4ZGM+aAvsENUFWqqy7fWvt4AmCh2AoFSFiZ5JLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWNo+XR3a0IVKI/KtehAITSdBgKs1gGJHxE39qaO+/+7sgxow3or2tZjuLjlOS40zr2mUymlXoywXWLvCcfXxXzFXtMEAAQu5tHroHsLmSCxZnchCAEOhTmz80wnH0/4TMykMuW7Rf7JQilmYlRG+wno/QOhs5JE09ej89qKwyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En1RijAH; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af9611d8ff7so274855666b.1;
        Mon, 04 Aug 2025 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322925; x=1754927725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns9K/OM0OlSKhVmMZUPRzp8mdJBBQqc3nvPasnNJ9zU=;
        b=En1RijAH4zzxihattxeH8a86+OEfV2xY6bhfRIy+s7ab5AI50FI6MANnKL62V9kpCV
         78GdRVD1f+6qtITrnWW5iewOhYaWjFudWzVo6NetjojMniG1quWxv2OW06o9PsjpHf7x
         Xa/Zq//GcgNLiau3wn/qHdsdPxOxAFfU4xUl6CYyPJh0fsQzkFIqEMoCtyDIRk5otpfg
         dEXFzE92aiGnIUJJpW8ohWhMY91dWG6C1a2xxCjHmCv0ZsmVT/f1sdSHSTbsprojKIWL
         Yjj1XVLLMxPmmVfsYz0oj6WwHLjMkCHUvQE8cdSAZT6l/FzZfoWlSrRk46sb5JdL6NVf
         lsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322925; x=1754927725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns9K/OM0OlSKhVmMZUPRzp8mdJBBQqc3nvPasnNJ9zU=;
        b=ADG8VpO79RPzustOcnI3c0isIHgkniD5mH2vn9IEIZaPEHbPem1gWithluIWwcMSKB
         ORTW+HskqKwSG4DAyiGxqNpmbtiqFFUYkBAhZgOY6/Bk+RS15hyC97Wd5bnX9rS19n4K
         eiZhWWrjt/7T+wsu8L/EjRqe1s/Xp7TamLMpkKqHK/1ovamtwKEv+bxKxO2P8pzSxnKU
         K+rRBUvVIvDoQnut0rI3q5r+9kKrqZewPOD9ao4xVg3rtp1+vsC90pPiA6V8ElbgiF+R
         UsdOqODo5732RPsPPngaggVF6EyHz2nSUemwNDnbcumgHJme6yowN2ld4b9FYEOYF2qw
         i/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUhiH+7dEXurRlTdbkxlpfGPFkxZ8xLCsgGtC8Yzl2dTXFfaNgzSga4XgMAwmkTJg8HkbfKNnp+8jdmkFwL@vger.kernel.org, AJvYcCW0el69i4vc3L9K4mwC9dzbyiU2ypPDpIlWtaNPSEjS/nbFXjjCj25YN5hxwPbIWoRvotk/VTkfKLPF@vger.kernel.org
X-Gm-Message-State: AOJu0Yws1tLVlu4nrTOKzUXH6N1kgUnxJWgpbsRjSkiHKb9gNwURbV8h
	appSNF6TtZMy9ffJzUw6xBoxSAKEfSErJb7orOFBL74mfkL55kWWSoIc
X-Gm-Gg: ASbGnct2jHO8uVZZnJaabTSHwTRHfQ5ASPOym1xUqzBpzZZ2jlG0NsDpjAWOYscoaCd
	JE0CoK/cINJmLr6OyeSIn9G1PanAXNT8sqNvdcE0YV1+FEsDiu/Z1wMOYcrIrDUrIYzLDO33eZM
	J8iLVidbfHcrOtKy2t9wyeJzBRHJO7cGLDZqaWK0j4COTkeJchuMXIg+a/uv9S4KL6VY5IevMcv
	jntupxMqyEzMgVHUyy4K4k1ONpYOq6lpulFcWj7UsJvsiZXO0Bg6Gw2r7hQANaPsMj4SCphyVQZ
	DozsboxwrKBFW5UYTS5biZ5kdwALVwlhivQly2r3SC4VF3rAt6XHid22z0/GvAGkeJ4BoG/yQjH
	wLS+8nZ5fU5HEo6mpQTHd39VmNv9gyhpANuip4rbVXW4WS5RFkRVDJlok3aU=
X-Google-Smtp-Source: AGHT+IEouzbjulkG+wmc2r45tzYYbBoKFNbyGXyIRI/lLFnz2uUKUnF6zkDeOJPorwY1elRfZNGXiA==
X-Received: by 2002:a17:907:1c1b:b0:af9:415e:2f38 with SMTP id a640c23a62f3a-af97d29c92fmr13675466b.7.1754322925044;
        Mon, 04 Aug 2025 08:55:25 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a075a74sm761114266b.17.2025.08.04.08.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:55:24 -0700 (PDT)
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
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 6/7] reset: imx8mp-audiomix: Support i.MX8ULP SIM LPAV
Date: Mon,  4 Aug 2025 11:54:06 -0400
Message-Id: <20250804155407.285353-7-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
References: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Support i.MX8ULP's SIM LPAV by adding its reset map definition.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/reset/reset-imx8mp-audiomix.c | 45 +++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index a3d0bd823272..2ab701ef1c30 100644
--- a/drivers/reset/reset-imx8mp-audiomix.c
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/reset/imx8mp-reset-audiomix.h>
+#include <dt-bindings/reset/imx8ulp-reset-sim-lpav.h>
 
 #include <linux/auxiliary_bus.h>
 #include <linux/device.h>
@@ -20,6 +21,8 @@
 #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
 #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK	BIT(5)
 
+#define IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET	0x8
+
 struct imx8mp_reset_map {
 	unsigned int offset;
 	unsigned int mask;
@@ -54,6 +57,44 @@ static const struct imx8mp_reset_info imx8mp_reset_info = {
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
 	spinlock_t lock; /* protect register read-modify-write cycle */
@@ -159,6 +200,10 @@ static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
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
2.34.1


