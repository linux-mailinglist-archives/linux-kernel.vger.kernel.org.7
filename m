Return-Path: <linux-kernel+bounces-855161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E24BE06D2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D83B358578
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2E530F7E4;
	Wed, 15 Oct 2025 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJVWslYf"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48320324B1D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556445; cv=none; b=RKJ99fOXXg2foVgXpnTeye2Mtb6KQMwCEeNBxFRNkftIk64f4cBe5rpz2mWlmJFSXMXPtATabyA1H81xm8VgEMTHcYaoHFfA42PMD3hY12gOzX+EcUvPZNkGobGb+yGYPB8tR5DVm6NIrWi48Jr0tA4MvzVACz3bE8A3eaTkFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556445; c=relaxed/simple;
	bh=NTjuf7bfo6RX2CGL8a/iTDj7lfSodD8ZOOLQqrbK1B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IA/JtvKeDTn6svC/WlbHmzqg1feefhYZt3ImAe81xal5ugM15+YpsaDtWayHKcUE9oW3mOKcTCJH42PMIi9WZ1b0WY41I9Da7idNDUGaOZt3f3bj2EwUR6Hd9uzKqSKFGnadUkR0d+KNbD+6yCBnvrAlzRLRcGFKP8EuPLFIi14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJVWslYf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2681660d604so75469335ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556443; x=1761161243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pom1z8x6b2wC6BQNMaEH7yl2novyBrsq9B9vL+Qq3dc=;
        b=GJVWslYfUnLtBSJnQ6opFTStZaxyNXN4YWeHSuKg9u9ilJ5S3pdhkpE0RgG5edyLWm
         Evmg8jvtgsTGmni3v7JxhsBNFdiOPuQfhp6IVSD6vvwuQkm/kHtJCEnbyXJrgVZfba3b
         m/Pn3j8oIu25NLS6TdF3NQ+OhO+CIg7YagXQ0JXX39liR6jnS3/f8aI2K5FDt9A1pPGO
         bhCKRum8Ti/jQBlX5y16NFFhB+Zbktn3uN7b0dZgfVZgLbfO3w5yh7RUAzE/KbS0ZNfd
         4ljcvIM4fQbHnqHpfJ4d2v4dzYgpM4eVGHIyfo/7RqcjGqUgZHFUAGumhIDuk0Xx6rfV
         7AXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556443; x=1761161243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pom1z8x6b2wC6BQNMaEH7yl2novyBrsq9B9vL+Qq3dc=;
        b=La1hKcFtGVQS49Hq75FHqvGmAv1cBcn8cdYID3hFbX5Nqek51/0169ox/EOLuMThJE
         ovwjg/AuamjS03rlFCkZy0yyNigO8ETayvAaD/+J8ezMGfuYFrA1DOqRUIwasdifPwAY
         jsvIevWRNVMr4k4qjL7g9sl9TZcmVC3YWxguKUc+uDUNdd3DYeeosm8a6hK8Vl0FUrV1
         CUX0RKB2iML3TYjj4nRtY26dd9jgyZgbbAqfcgfVZ0vhOwIdaxi2CWr0M3SZo4AqXmVH
         JK+FVFiUMIhCeXRUOhB37k3xZhjHfyAhMqcB+yZM6Npt4CcSP0mY+aXIXCZg9w7YS3Hr
         zGGA==
X-Forwarded-Encrypted: i=1; AJvYcCWmepBGzzNRM7HRvUxrLW0vS8rZeX4oUzIhnhKemepTKO4vChF1FhkLNBskll/7ahPQBnBENYw6p8Ge0Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQuFAkj5IzlohFVclTzbOoy/QfC0xzl81Zu52qrcu4bKjwna8Z
	SNngSjjG+swc6CkBkrpio2pJLu/DetPmLciv22m4P5p1mL+DOq09LW1W
X-Gm-Gg: ASbGncucqD31WahquOfP+jY1KMn2Tj7zHpMSErV24SLIpdO+7orp25x/hDtg9WzwCfj
	llasBswt9MuY4yoseSME3d9+5rs++SYGWy1j87Z0N1oXzcRLO3vPtMN/NcBRFT5fWKpbPWKWnFQ
	bd9awRw+/z5IIM3Zw6myrifbYiYpUNz1geHuNkJCGYFgwTvF4fYPltrqL8q6wisGTjP1oXhH5+4
	qbijuZavjF9W+YTnZQvsS1TMn8LjNJm0z4JYN8/jN4ParlCx4ptIl1U0GtwBLZ0g9XZL/3KWpFf
	yNpgQvRVMcQCXdtPbWdGWG3+ovPruiEWqIMvjxH2WGqRgrTWcDEeSqggbfMeutCSLDxbCbaVKxD
	5zQSdr2fKHmb16QCakLDaziq34DdSTIp7f/WntGSH4WdM257a+SVRFAZc/SCWImTijobMOKt7QR
	zw/K0XJfV3GWKq2bq2wITLZi2+qPweF7HF
X-Google-Smtp-Source: AGHT+IEUBZvmZ7j5CmyPSsiuBgYRCtqbKU9tc4v6VxZf7CqxDQDbwQYqkXWhISDpFwWeOwm+SJbo/w==
X-Received: by 2002:a17:902:ef10:b0:271:5bde:697e with SMTP id d9443c01a7336-29027213340mr393885805ad.3.1760556442627;
        Wed, 15 Oct 2025 12:27:22 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:f449:63fb:7005:808e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290993102c9sm4427005ad.24.2025.10.15.12.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:27:22 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Subject: [PATCH v11 6/7] drm: renesas: rz-du: mipi_dsi: Add LPCLK clock support
Date: Wed, 15 Oct 2025 20:26:10 +0100
Message-ID: <20251015192611.241920-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015192611.241920-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251015192611.241920-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add LPCLK clock handling to the RZ/G2L MIPI DSI driver to support proper
DSI timing parameter configuration on RZ/V2H SoCs. While lpclk is present
on both RZ/G2L and RZ/V2H SoCs, the RZ/V2H SoC specifically uses the lpclk
rate to configure the DSI timing parameter ULPSEXIT.

Introduce a new lpclk field in the rzg2l_mipi_dsi structure and acquire
the "lpclk" clock during probe to enable lpclk rate-based timing
calculations on RZ/V2H while maintaining compatibility with RZ/G2L.

Co-developed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
v10->v11:
- No changes.

v9->v10:
- No changes.

v8->v9:
- Added reviewed-by tag from Tomi

v7->v8:
- Updated commit message
- Switched to use devm_clk_get() instead of devm_clk_get_optional()
  as lpclk clock is available on all SoCs.

v6->v7:
- New patch
Note, this patch was previously part of series [0].
[0] https://lore.kernel.org/all/20250609225630.502888-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 3b52dfc0ea1e..bb03b49b1e85 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -68,6 +68,7 @@ struct rzg2l_mipi_dsi {
 	struct drm_bridge *next_bridge;
 
 	struct clk *vclk;
+	struct clk *lpclk;
 
 	enum mipi_dsi_pixel_format format;
 	unsigned int num_data_lanes;
@@ -979,6 +980,10 @@ static int rzg2l_mipi_dsi_probe(struct platform_device *pdev)
 	if (IS_ERR(dsi->vclk))
 		return PTR_ERR(dsi->vclk);
 
+	dsi->lpclk = devm_clk_get(dsi->dev, "lpclk");
+	if (IS_ERR(dsi->lpclk))
+		return PTR_ERR(dsi->lpclk);
+
 	dsi->rstc = devm_reset_control_get_optional_exclusive(dsi->dev, "rst");
 	if (IS_ERR(dsi->rstc))
 		return dev_err_probe(dsi->dev, PTR_ERR(dsi->rstc),
-- 
2.43.0


