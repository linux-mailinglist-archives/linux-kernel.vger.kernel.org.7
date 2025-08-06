Return-Path: <linux-kernel+bounces-757525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BBFB1C32D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B5D183F93
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AAA28A1CB;
	Wed,  6 Aug 2025 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Kf8Xll6R"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55C828A705
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472117; cv=none; b=Snng4LnOrTwfS8hiNK71rMYuHt8Ts14Mi6kBqr2Ds2B7BC9od5UCvm4KGXPvhcgnsxbCxjNLMqNgiIChTarEqh6n5jZX/NYzL9oaynOV354gUrajvOsUDcNX0XXZtqIgi0uomuhPF6fbHX1q9qujKYYLSn4r+FQldHbMuqsmUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472117; c=relaxed/simple;
	bh=ahyQI2qcD5lkMjiLgEnAoOsK/OubeAfqZDxEeKCSVto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uE/stHRQLTcmlMy9IhjH/K7qALimZJSl3IOzM+zRIWe/MB9k3NMw3VQXi9sC0RMQYREc2mdtJouWp83PJQ0hWWDs3TRLpFS14ScD2BUi21iIaIRVbRZKnW120zxnUEiBqXgw0H2OqxfcvGy04rrX0yb1/0nGPPP2drMWjfOEHE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Kf8Xll6R; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459d4d7c745so33002065e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754472113; x=1755076913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvJiuyia4fn4UQXL1iH7HgBEs0hgCmf79kw9eKxGkW0=;
        b=Kf8Xll6RgvwW68XzxW1RX3Ttdb6FXIHQ7jH1WCN77Sb5q7OIHOk/TcaO8GVg2Kp2qK
         I+0qJ71NPCubS9jOcZoZ0HveVXBNvVrQUMX6FQvUvZTLidckgFsDek+h2G2eK4nGmJK1
         avqiPbuvbzh+i6TkEqpphRuciIY76qzCCYqJ341vca7CWv4pVYdfbKd9YzXQbGCXjsSt
         K+HCLJB1OnWcExW/Q6g5qeeOGED/rCQ9HNL1YuPxbVfyHQSxK7cn7XExoV+LB7lKgHgp
         fc5o6Ru880otY+pK1LuvlL09DE65u3w2a913DhHqWbx7KSS29NUbnQfi+oZv8jKWpLiL
         y3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754472113; x=1755076913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvJiuyia4fn4UQXL1iH7HgBEs0hgCmf79kw9eKxGkW0=;
        b=RLgDBwjdBgkGkDC0KlLjl534pbj5w+m6LLKojtBMFFViMtoiuIyoSciHN2iUoGxc3r
         yXam9nwK9+ZNg31ZugI4DoLpn0/GBsyd85AImOdFqkZ8UMS2z21DyFOucJNDVfvvQueH
         SemNG+xREgM3HD6kx+buiqrXvBM2nRjaVynXATg2GgV/pBVICRgNk7kvtvJk1KXolf/w
         citqK+3dF/DlNp8v20yv/MEsN1iZsuTdwLdV4Wy/fyfBa3qV0kqddSHIJCYaNlF2Q6qk
         DVD7i5qBgUbPnZ9LVZPEIF4oTY6wXtMfvhWwLepXXpMHlC0ZCXennPlQj3DZG1vxTURR
         5XOw==
X-Forwarded-Encrypted: i=1; AJvYcCVc+bzcKlHDvjlzQuWgod2/iPIWzrARLci5PSQoHk40qB7ppuTovLTLMi/vssN8iSRPVX5II7FKK0JVWXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCtdfD8sdSlQT0BVUWVtTdVKti/8kfZvXs2bYQDSxifFTa0mx
	RPR88XsOOYgSs/cACQkjGB3ivyvcmWsXEomnBa0JDJa8yKjOH3PM4VLAluscqHtana0=
X-Gm-Gg: ASbGncskn7zZ/AexMjY5s+jf6FMQc+hpypBPwZcAtDyhyNTLM5LB1nlBPrU0dwOiOpZ
	FFQ91lCbsQylovc8VAVjFWRclVLNQkYDvVePPPMiB20u8go/UgWl3CT90VyHCQIBNNC7B4weNzh
	GRWYfuC0zLmDyGdB6Rvxni/2RbInZLADDIoEBjiiN0KnownJYQu7pCTWMbFR783SDypeSXAYuI6
	8aJrnZIRwUfhPRvy3UHzz+VhulPOCrbB4P4OLhEn1NHVsA+iSOczkjXCVP9XBS5OUoKeF3nq53x
	YNOUwJA/K10p1r+LWSBBExJXPufpOTiRkZr15yQg1zlxsOnutzf+XH7J6MXw0NBWxOw6BygVCJl
	s5WC1PodzHsB83YIPGGRN3lqOROOp7UiQHV8X09lN4aWrNuQE54da
X-Google-Smtp-Source: AGHT+IHBVy+7ifJovbNtkvDbrEpCDkMYjLpQycIEeGAPhFLGlaF3WnbQXIsaKp34nfKweM+JnqXrtw==
X-Received: by 2002:a05:600c:1c22:b0:456:1d93:4365 with SMTP id 5b1f17b1804b1-459e95af9b4mr11147555e9.5.1754472112969;
        Wed, 06 Aug 2025 02:21:52 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm30188445e9.6.2025.08.06.02.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:21:52 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 4/4] clk: renesas: r9a07g04[34]: Use tabs instead of spaces
Date: Wed,  6 Aug 2025 12:21:29 +0300
Message-ID: <20250806092129.621194-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250806092129.621194-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250806092129.621194-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use tabs instead of spaces in the CRU clock descriptions to match the
formatting used in the rest of the clock definitions.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 8 ++++----
 drivers/clk/renesas/r9a07g044-cpg.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index f050f8565916..33e9a1223c72 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -213,13 +213,13 @@ static const struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 	DEF_MOD("sdhi1_aclk",	R9A07G043_SDHI1_ACLK, R9A07G043_CLK_P1,
 				0x554, 7, MSTOP(BUS_PERI_COM, BIT(1))),
 #ifdef CONFIG_ARM64
-	DEF_MOD("cru_sysclk",   R9A07G043_CRU_SYSCLK, CLK_M2_DIV2,
+	DEF_MOD("cru_sysclk",	R9A07G043_CRU_SYSCLK, CLK_M2_DIV2,
 				0x564, 0, MSTOP(BUS_PERI_VIDEO, BIT(3))),
-	DEF_MOD("cru_vclk",     R9A07G043_CRU_VCLK, R9A07G043_CLK_M2,
+	DEF_MOD("cru_vclk",	R9A07G043_CRU_VCLK, R9A07G043_CLK_M2,
 				0x564, 1, MSTOP(BUS_PERI_VIDEO, BIT(3))),
-	DEF_MOD("cru_pclk",     R9A07G043_CRU_PCLK, R9A07G043_CLK_ZT,
+	DEF_MOD("cru_pclk",	R9A07G043_CRU_PCLK, R9A07G043_CLK_ZT,
 				0x564, 2, MSTOP(BUS_PERI_VIDEO, BIT(3))),
-	DEF_MOD("cru_aclk",     R9A07G043_CRU_ACLK, R9A07G043_CLK_M0,
+	DEF_MOD("cru_aclk",	R9A07G043_CRU_ACLK, R9A07G043_CLK_M0,
 				0x564, 3, MSTOP(BUS_PERI_VIDEO, BIT(3))),
 	DEF_COUPLED("lcdc_clk_a", R9A07G043_LCDC_CLK_A, R9A07G043_CLK_M0,
 				0x56c, 0, MSTOP(BUS_PERI_VIDEO, GENMASK(8, 7))),
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index fdbc0635a869..0dd264877b9a 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -303,13 +303,13 @@ static const struct {
 					0x558, 1, 0),
 		DEF_MOD("gpu_ace_clk",	R9A07G044_GPU_ACE_CLK, R9A07G044_CLK_P1,
 					0x558, 2, 0),
-		DEF_MOD("cru_sysclk",   R9A07G044_CRU_SYSCLK, CLK_M2_DIV2,
+		DEF_MOD("cru_sysclk",	R9A07G044_CRU_SYSCLK, CLK_M2_DIV2,
 					0x564, 0, MSTOP(BUS_PERI_VIDEO, BIT(3))),
-		DEF_MOD("cru_vclk",     R9A07G044_CRU_VCLK, R9A07G044_CLK_M2,
+		DEF_MOD("cru_vclk",	R9A07G044_CRU_VCLK, R9A07G044_CLK_M2,
 					0x564, 1, MSTOP(BUS_PERI_VIDEO, BIT(3))),
-		DEF_MOD("cru_pclk",     R9A07G044_CRU_PCLK, R9A07G044_CLK_ZT,
+		DEF_MOD("cru_pclk",	R9A07G044_CRU_PCLK, R9A07G044_CLK_ZT,
 					0x564, 2, MSTOP(BUS_PERI_VIDEO, BIT(3))),
-		DEF_MOD("cru_aclk",     R9A07G044_CRU_ACLK, R9A07G044_CLK_M0,
+		DEF_MOD("cru_aclk",	R9A07G044_CRU_ACLK, R9A07G044_CLK_M0,
 					0x564, 3, MSTOP(BUS_PERI_VIDEO, BIT(3))),
 		DEF_MOD("dsi_pll_clk",	R9A07G044_MIPI_DSI_PLLCLK, R9A07G044_CLK_M1,
 					0x568, 0, MSTOP(BUS_PERI_VIDEO, GENMASK(6, 5))),
-- 
2.43.0


