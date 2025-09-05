Return-Path: <linux-kernel+bounces-801949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B113FB44BFA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F291F5A0A87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DA52571C9;
	Fri,  5 Sep 2025 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfUq7kvp"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E2246BC6;
	Fri,  5 Sep 2025 02:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041022; cv=none; b=SjtvVIMmss2LOIWhpyOAa1x7fI68jSenaZyICYe8AX4z/SNLyfO3arzYZ4KNBTDI4kJREz9IZqHtOf/aKrpz1tKBJmRc22tm8Vc3otd/oM2ZEFLYCz0fjiJePXZHXAoJbEUqi2/L+DED0C7Y0E1qktQ/8mbhoayIJOS+4rCtwJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041022; c=relaxed/simple;
	bh=p1cN1FVpICsqCAtQfZVV3UJiXkS/77xWhXLMrkuxyg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jg0EMZchz9OSu+J00AL990MYkA6+u4Y/FcKG0ugU1TmO7AqufHp/YtfFYpP2sp8DPlAqRvpPGQYokc68UooJb+DTlV++HMdgDN4rsbk6/Qp5wIn97GFdo7l4w5Ks8ie0x2uYfqkWxOh021CWrYLf+/786GMn3lCsDCtKenjsii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfUq7kvp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24c8ef94e5dso14457505ad.1;
        Thu, 04 Sep 2025 19:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757041019; x=1757645819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSm+aabJuGQQVAHdFRseyG4Ifw03HE1bx3RoCtswd04=;
        b=HfUq7kvpvegWtfLcePM7JQS5erDNczUFMcjF+7V3HKuQe4kb3EUZeO8KC5uek2CuYM
         pcQFCGiO2z3KnlQceVBoIl7xyQuJzKVmZR2ay6/UdfEXHUEoRSgabNcakXwfaMw7WlJm
         QDokYobY3r7hetXc3w/17TyY76In/xeEsGvKrTV5A3fwHtlxVUdR1GzZHbVaPi/CELnx
         j8TKfSgFkkU4lgDxjjSu6FI2ftSD12R1R3xhaMsxkTL4Mc9HIvzgzP1R9X+eHmNe0O48
         /W9gQm8lI3zjF74WUoxqxnWLjss+G3fOJeISvD2PR2SSXYolbh40ppoK+EkzXJYOpmza
         0fVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757041019; x=1757645819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSm+aabJuGQQVAHdFRseyG4Ifw03HE1bx3RoCtswd04=;
        b=eT5xNCc7yU5pHHVayzsZeGrseQOMwNUG+wXF6SfRhHRJMe2r4sfKwBTTK16PJOEAbH
         jlVmPPVumc2Z4uUbacPQvMKrTybHMqF23ZQPGXZq7/JXMmFvZ4ecLbPL+WBOO8ItWs7C
         VT8eHn8jRUBToP5gabLQNLoCUiV2PT9jLvg6P8KU2bylte1q7J4abVG159ktQ1lAU/jt
         cbTbM8HNhWJq+YfvfmqkqUAzL5yLez5iiA0koT1aL/iupUoBostm5hUEaz4AFCTR18MI
         PAfvy3yXfwVgbJnnJMi8nMZ/JuSYBZUwJSA9a5IcCifnnYQ7Dg0w9LeQ3arNWAkcXsj5
         +HUA==
X-Forwarded-Encrypted: i=1; AJvYcCUjjYgxeDemM5SO2lIpi7OnflphxiCk4tdflBD+zu8z8XNzIXoWIygXtO/7Ukc8H+TKZ1jLpnfRsGiw@vger.kernel.org, AJvYcCWc4uxkYgG/BT+ixZPYmNU6SQOzV4H4PbZ64nohGotGoiPhg3ZnA48Z9CFXndPe3FAk+NZwyB+hXvWe@vger.kernel.org, AJvYcCX4JlU/ltiyGJ9KJ7nvwrL6Hr6yLgVmRV3LzFz2CCvM6FP4/vebcrk+ulFHBOhay5ZXkmWidzqbTwSEHK/o@vger.kernel.org
X-Gm-Message-State: AOJu0Yy25lJKxWDzTM1nhgV9YuYJFGJGgIr2tQ85+WG3Bo3/irZpLUrF
	qeoRXybN/ficJ2k1HvcbzgfOnvWXEuC2hQBeq8tfdyIRPN6t8RSSjKN8
X-Gm-Gg: ASbGnctkMvY3RZx8YpMfjM3EY85uadsl/17hOK5tn50Cv1STkjh9nPyeU2+5XHJIAKb
	21CZK/hYL+QX5jO4TVCAYDwBH+n82w0N6abJ971UnveDv/uRLJB3M3tl6B+s5QRFde4qKwhlSyG
	FSMl86do/ESXat9T4Qa08Df7NcC+6FySanqCvjyxRxRn87l0G+8jIUCXtsguTjCTKxyHc7Nukjk
	WBTdkcokvZdH76Cva+TuK/c+576fg9T4Ogaaz4c36WW6VRU1y4/f8t+DV5wtE4Ek/eI+EErkDsq
	Owen+iMtIMzc/2cge4oHTWkHxdISqwmlIKn0mTxehVejaEOc6EFruK0erWfzfpdCXPtleMFmyJR
	+pq2G3nNZGz8m2ckylfw+OQ==
X-Google-Smtp-Source: AGHT+IGiCiFlHf1mtHvOyU5iKaEmLyatGv7/gGlkix1p+pQFsrakTBSwM9VngVTFGiMaNmLO0Ctoyg==
X-Received: by 2002:a17:902:d487:b0:24a:acb7:a1a4 with SMTP id d9443c01a7336-24cedc8e40fmr22018125ad.9.1757041019191;
        Thu, 04 Sep 2025 19:56:59 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e1c8e07bsm9428588a91.4.2025.09.04.19.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:56:58 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v2 1/8] drm/rockchip: dsi: Add support for RK3368
Date: Fri,  5 Sep 2025 10:56:25 +0800
Message-Id: <20250905025632.222422-2-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250905025632.222422-1-cn.liweihao@gmail.com>
References: <20250905025632.222422-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3368 has DesignWare MIPI DSI controller and an external inno D-PHY.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 5523911b9..de8405ee8 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -163,6 +163,11 @@
 #define RK3288_DSI0_LCDC_SEL		BIT(6)
 #define RK3288_DSI1_LCDC_SEL		BIT(9)
 
+#define RK3368_GRF_SOC_CON7		0x41c
+#define RK3368_DSI_FORCETXSTOPMODE	(0xf << 7)
+#define RK3368_DSI_FORCERXMODE		BIT(6)
+#define RK3368_DSI_TURNDISABLE		BIT(5)
+
 #define RK3399_GRF_SOC_CON20		0x6250
 #define RK3399_DSI0_LCDC_SEL		BIT(0)
 #define RK3399_DSI1_LCDC_SEL		BIT(4)
@@ -1528,6 +1533,18 @@ static const struct rockchip_dw_dsi_chip_data rk3288_chip_data[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_dw_dsi_chip_data rk3368_chip_data[] = {
+	{
+		.reg = 0xff960000,
+		.lanecfg1_grf_reg = RK3368_GRF_SOC_CON7,
+		.lanecfg1 = FIELD_PREP_WM16_CONST((RK3368_DSI_TURNDISABLE |
+						RK3368_DSI_FORCETXSTOPMODE |
+						RK3368_DSI_FORCERXMODE), 0),
+		.max_data_lanes = 4,
+	},
+	{ /* sentinel */ }
+};
+
 static int rk3399_dphy_tx1rx1_init(struct phy *phy)
 {
 	struct dw_mipi_dsi_rockchip *dsi = phy_get_drvdata(phy);
@@ -1687,6 +1704,9 @@ static const struct of_device_id dw_mipi_dsi_rockchip_dt_ids[] = {
 	}, {
 	 .compatible = "rockchip,rk3288-mipi-dsi",
 	 .data = &rk3288_chip_data,
+	}, {
+	 .compatible = "rockchip,rk3368-mipi-dsi",
+	 .data = &rk3368_chip_data,
 	}, {
 	 .compatible = "rockchip,rk3399-mipi-dsi",
 	 .data = &rk3399_chip_data,
-- 
2.39.5


