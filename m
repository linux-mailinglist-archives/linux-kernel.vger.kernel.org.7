Return-Path: <linux-kernel+bounces-815581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7D5B5687A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AF23BE773
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B433F267B02;
	Sun, 14 Sep 2025 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8i2fInP"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ABD262D0B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757852487; cv=none; b=qie/1JV/0kvI/GdK69gGqFElYBhwyX+35DfYEYy2a2EZgdbdQP/0JCXBIJ1UIiNJ/c9KnV6nb09R6mU+ia2yXEH00c7IyAn+jX9TrXTkW6MgD5TkiAaANOlbOMvIUBSMzmjY2sC14ptrS2vUeTdR9brvDwFkbEEzmfmp7QamIr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757852487; c=relaxed/simple;
	bh=+ARkTTfgYAV8lq+cpguXWwMOib8tysz+VwmQ4xeFl5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dljHkX2XsYZaXqQ0IAvh0fZk41TDvcXAPefAKS36uft058U+yzK/FyhVD2UbmNac7Th7Qyaq6MdnKFGsQSzVVzUXgWkqRuUgSji+JzQpzdTeSSKQ7DwKDIp1tKA2rAb/uXwQVcSkS1rwvqv5f5HpjgnwoAzEpO8M5SB1j/BkKxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8i2fInP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso2362174f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757852483; x=1758457283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/o/CmP3Rg70MppvTZL3UgHlhdGprRSi/0bRMfCqA7ss=;
        b=X8i2fInPVWgbF0VhpKD2Soj5sBQbSsjvijxy4gGKB7pMm+u8ZdYr2AfX2kfAUk8aG5
         qerugikVWvZeSNAsnkvLFjs4jgiXCAJ71r/BVreVhEQ3ekh9zQGjBXF92hcj1/aOAiM+
         uZMrZ67J8D5Ikjt3mTekzAn+QqzvVnk0bdPUi6hX1alDH/hjwRpaC7qDg11sYDTc7Vza
         6psuANFgw94UyPCJ/jAACE3drmqcqsvz1SPWB4Z5yM7gwyfx0JSIl0i/KMIk1n/H/1mc
         ByMeA0n4F3VnzvaqVizYvxpOrllWF/Z3eh8lYKDZFEMLG8/hnY4kGJV1V3TwEKDdeuhT
         m1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757852483; x=1758457283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/o/CmP3Rg70MppvTZL3UgHlhdGprRSi/0bRMfCqA7ss=;
        b=Sj/g+rHg9Z8DESrU495MYCZfFV5AxX3cR+9yK/+m9TqpsUgL3Hm1RhLJiWaQHPJWFs
         ow3avdozvfQ4U1x9AG76jVyEdWMU2aVDxk65rxAFLOhr+ZjCYeai20XfO7AocOM61xjh
         QqCsnycVWX7kDEvxjBkgofIlpPvBGf0G/SujpUmdxr6wRHfZR6ExZWKR7LKYZppXexIo
         O1JEN9GaIKTJipne2Kt+JvjTQgM8tfkMLnm0X4LWLA9+Qr8bGYOjXBNPqUKBftU5rRKx
         YNQzY0EIe0KP8r1k+r6pl+xFTioTpKF3CdeNVazb88O18x5d4hlUHg+0PQWQnHm+vpA/
         oaaA==
X-Forwarded-Encrypted: i=1; AJvYcCVA1l7jFIV0LbvNZ7LWmCmgPiSALenvlehmwUwLYAcbtsPDbk64boAvzXtKcu6SE7BI3ShXp97u3ObUkys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi2Jl8i6d4JwarS2XJgvRPahPa/GbUfgcpxPV+zrLDOS2JH9wB
	+rPrfndOf32lGO0CbLHNWOrfi7d6aMWPH04w4Xj0XJAfFEuojXIvOqaj
X-Gm-Gg: ASbGnctWpRy1hv66f3aQmuK6A4WUubNge15WfQEylCjN+T0rAiUkZVeG9kP8YKsvOm4
	lGEkwmcNer+6XfFJELXq6OEr+h4/otoTvQvl2J1lTswhNTHxEfFOSy217Jp2znftnP0gtd7ZPo5
	+LOu/IFgDunfzGA3KroylNuNJ5SjFaXykLLGRIuSx2XMTHhDfxXKvs9aB4/ty3C7clGlIvjBdlD
	EFHIvqfBJnmInDUWPKiITrZf1aeFoaRJf3/NgPoQ6FEhLhySjQxD12TxjTSCKgM8BHj3HJJn/s4
	atQnxCWDnp647uch6mcOLtybtVf8TugqUT+ehN0usVik+kDuW4LsHdRuTIwrqtPclRs/gtmMfe2
	sI/6mk+abuKOtUbAgOS5zyPba7TUyrJhP2iHkclPw2Qwh1efTXZSjyXu46A+bkgsbU6YUXgS2TV
	o1niOf0cCP
X-Google-Smtp-Source: AGHT+IF65054uWgaEnZnjo3739WPkXpFwENVCRBSnh2RLQhMQq0qfIAS99sWpws28e4M/hCiCQUjLQ==
X-Received: by 2002:a05:6000:178c:b0:3e7:63dc:1ff6 with SMTP id ffacd0b85a97d-3e7658bc908mr6223136f8f.8.1757852482965;
        Sun, 14 Sep 2025 05:21:22 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017b4222sm136476615e9.20.2025.09.14.05.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 05:21:22 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] clk: samsung: clk-pll: Add support for pll_1419x
Date: Sun, 14 Sep 2025 15:21:14 +0300
Message-ID: <20250914122116.2616801-4-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914122116.2616801-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914122116.2616801-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PLL is similar to pll_35xx, with the following differences:
- different locktime - 150 instead of 270, as with pll_142xx
- different rate calculation

When defining a PLL, the "con" parameter should be set to CON0
register, like this:

PLL(pll_1419x, CLK_FOUT_SHARED0_PLL, "fout_shared0_pll", "oscclk",
    PLL_LOCKTIME_PLL_SHARED0, PLL_CON0_PLL_SHARED0,
    pll_shared0_rate_table),

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 drivers/clk/samsung/clk-pll.c | 10 ++++++++--
 drivers/clk/samsung/clk-pll.h | 10 ++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index acb366f14..6b3593445 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -229,7 +229,11 @@ static unsigned long samsung_pll35xx_recalc_rate(struct clk_hw *hw,
 	pdiv = (pll_con >> PLL35XX_PDIV_SHIFT) & PLL35XX_PDIV_MASK;
 	sdiv = (pll_con >> PLL35XX_SDIV_SHIFT) & PLL35XX_SDIV_MASK;
 
-	fvco *= mdiv;
+	if (pll->type == pll_1419x)
+		fvco *= (2 * mdiv);
+	else
+		fvco *= mdiv;
+
 	do_div(fvco, (pdiv << sdiv));
 
 	return (unsigned long)fvco;
@@ -273,7 +277,8 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	}
 
 	/* Set PLL lock time. */
-	if (pll->type == pll_142xx || pll->type == pll_141xx)
+	if (pll->type == pll_142xx || pll->type == pll_141xx ||
+	    pll->type == pll_1419x)
 		writel_relaxed(rate->pdiv * PLL142XX_LOCK_FACTOR,
 			pll->lock_reg);
 	else
@@ -1373,6 +1378,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	case pll_1450x:
 	case pll_1451x:
 	case pll_1452x:
+	case pll_1419x:
 	case pll_141xx:
 	case pll_142xx:
 		pll->enable_offs = PLL35XX_ENABLE_SHIFT;
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index 989addfdb..c07d76121 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -50,6 +50,7 @@ enum samsung_pll_type {
 	pll_0732x,
 	pll_4311,
 	pll_141xx,
+	pll_1419x,
 };
 
 #define PLL_RATE(_fin, _m, _p, _s, _k, _ks) \
@@ -57,6 +58,15 @@ enum samsung_pll_type {
 #define PLL_VALID_RATE(_fin, _fout, _m, _p, _s, _k, _ks) ((_fout) + \
 	BUILD_BUG_ON_ZERO(PLL_RATE(_fin, _m, _p, _s, _k, _ks) != (_fout)))
 
+#define PLL_1419X_RATE(_fin, _rate, _m, _p, _s)			\
+	{							\
+		.rate	=	PLL_VALID_RATE(_fin, _rate,	\
+				2 * _m, _p, _s, 0, 16),		\
+		.mdiv	=	(_m),				\
+		.pdiv	=	(_p),				\
+		.sdiv	=	(_s),				\
+	}
+
 #define PLL_35XX_RATE(_fin, _rate, _m, _p, _s)			\
 	{							\
 		.rate	=	PLL_VALID_RATE(_fin, _rate,	\
-- 
2.43.0


