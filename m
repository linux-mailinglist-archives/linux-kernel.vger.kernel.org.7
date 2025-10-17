Return-Path: <linux-kernel+bounces-858394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CF6BEAA8B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B197585D49
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D006C28DB71;
	Fri, 17 Oct 2025 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIMW6a0b"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF92857CF
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717664; cv=none; b=R16oDATMSj+LYv8HUBBRH6vk1EqR5bHyHPFyfkf5/ObUTrx7EGK4nhQxxBXUh7yMzlIbkxSSRFCYUlMX6RAlp202fyK0qfiXKgbeD9v5VA8gjdafATTbYpxXRHALgDRYEPq/MuSxibxi2XQ1CmGsw8KwvSsEufZGWqqgv22eIAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717664; c=relaxed/simple;
	bh=XFwwYgwIrE13kgm1GHDPMNiskJfkj4wbU7LgqZMT5+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PN8mQjpfENzGE1DafZ/MtFfW1iYX1uHr/Ry1Szpn/788n95HyiqcYVv6043PLl9dr09SUegDULg+L0YTbbmBi5VhkKNfEZSS1LEvFW6z5+KzxeLqNbA2mqwwyNADVas1vTSPOdxnzMYK92BY7oZeTHoT5XMlj7qF8k6H+FvxiwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIMW6a0b; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso355111366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760717659; x=1761322459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+ezreZej8AwNtgLmDRvkBFDk/rnw6yuzZ412Fm/rQ0=;
        b=YIMW6a0bqMl/IRqEE1KQVWc8RBdOvAoiGN4+K8z0xBtJjhG7DMwfoabK83Wik0ri00
         nHs7FYHbeiY7qg+9EqtDza7/QnnxQ00GiRQmGFKWGexDzsC+5frqIEqeCnpqeFA32app
         funHh40N/8ABzy900LlTcL4JE1PK8fkmnCh2ZcIF4Dcz761WY6vILShSIzcu86I0hP2B
         C/N/7C0q7Df1iBI5x2FdmB8TNSGe+0TLI319jCulceebz38YCMJ93IOhC4WFvN0R0AHr
         UyUEOa76tVMlsIuOEiJxAEuaxty4rUywenC3ysc/BEzrjdJjc0A6po5nuJ18f51Y6CYs
         p4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717659; x=1761322459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+ezreZej8AwNtgLmDRvkBFDk/rnw6yuzZ412Fm/rQ0=;
        b=qsFNR+QIJqhDT4EmrY5WRqbuNRYX6cELAVwTSSm5DrRGPZfjouezE0OkXFkP32Xu+l
         Z/OtL14+Nus/Gg4uEJdIe1qroOeRb/WGZDQJwoKJM9rY4v7Ayr9WFAKNH1vCce+L5HYv
         96n4lX1c6YvdnWxr4Q9/+rlJHFDk+ncftIsiv4U33KP1A+WvaSsUfQO0VU2NduR243yg
         MnnEUp68Ff3ciQuiLSRE2Y7EsGr0u3iOpj6g85PKI5VUqWKZKiHV0RQfTpGScZkP6qPW
         BzkqU6vyY2Z18rFAeq6fmkwpsuA230ZisXh9Ew7JfDTAQEvgo1wiUwau+yL5+AVRupIn
         xtWg==
X-Forwarded-Encrypted: i=1; AJvYcCV4GLQkLdEiW5aYIyHiIUR0xCfCKV+J9zefDdrv/QH9DgmxHCH7WBCZwhfH28AXrpr7RTkT2fAlwTpyfvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY0ljceZdBGf4ixsTpuuv27wkPGQUTAHArbYV+PxpwBPRXJw5c
	Wz6eg3snPatvu2YjMEtbnDUlX2WwgYdLAmeaa4/yKiZUksHd7pIHwi1l
X-Gm-Gg: ASbGnct0pfkpykiyXZl7iTon1sDIce4AM2AOypDNJmkF4USVysZQAaB8TWt2XciJEm9
	1ASE2R5fFK7POsaR6kHq6ucSgpX1NEtxetNUqHVnLVcDmI5AIywHnFFo/HjlCG9FQAEyMi53KAb
	wVO3DKkO5hG4sCvuxZrCe/aRnt2dGOVE/Spf8fGiksO0e5wNO+7cU63UqvEyJ9pjI/Od0RNcqs4
	NH3Obcxx4QDsNQ39cfZIvowCyWUKwthfsPZJ2ZXyV5rLDScckEs+nQw5SU6bh08EOc7qDiZKEUG
	+b+93YA877fcnyosJ0bIXDZJEcttONlgA3nfzXDmuF8YbvEXxKBiLk7+a7GyFQODmx8rhKOltBz
	13sv2t4YPMQvPgDuVJenNsJV5LzQ42mOiNBWQDTArBQvkDOg0XSp3ubO/tdaRo2DTNmXoYuLB0s
	TLKOernfpDg58GGD1XxgO+avMTt0B42It92qKmF3VX
X-Google-Smtp-Source: AGHT+IGaVeu0oUJ1C7UDFeHqtgsEFDLC0C+6KDtBnxoCgNM6QWJpaLsxbbHRVuTXDwHGVCCCSflQPg==
X-Received: by 2002:a17:906:c144:b0:b04:48b5:6e8a with SMTP id a640c23a62f3a-b6472d5d715mr467188466b.7.1760717659090;
        Fri, 17 Oct 2025 09:14:19 -0700 (PDT)
Received: from ivaylo-T580.. (79-100-18-255.ip.btc-net.bg. [79.100.18.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036706sm9606466b.41.2025.10.17.09.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:14:18 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] clk: samsung: clk-pll: Add support for pll_1419x
Date: Fri, 17 Oct 2025 19:13:31 +0300
Message-ID: <20251017161334.1295955-4-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017161334.1295955-1-ivo.ivanov.ivanov1@gmail.com>
References: <20251017161334.1295955-1-ivo.ivanov.ivanov1@gmail.com>
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
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
Changes from v2:
- rebase on next
- add r-b tag from Peng Fan
---
 drivers/clk/samsung/clk-pll.c |  7 ++++++-
 drivers/clk/samsung/clk-pll.h | 10 ++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 4700eadad..3c7333529 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -234,7 +234,11 @@ static unsigned long samsung_pll35xx_recalc_rate(struct clk_hw *hw,
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
@@ -1498,6 +1502,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	case pll_1451x:
 	case pll_1452x:
 	case pll_142xx:
+	case pll_1419x:
 	case pll_141xx:
 	case pll_1017x:
 		pll->enable_offs = PLL35XX_ENABLE_SHIFT;
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index 3c7575cde..04b3fe97f 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -52,6 +52,7 @@ enum samsung_pll_type {
 	pll_1017x,
 	pll_1031x,
 	pll_141xx,
+	pll_1419x,
 };
 
 #define PLL_RATE(_fin, _m, _p, _s, _k, _ks) \
@@ -68,6 +69,15 @@ enum samsung_pll_type {
 		.sdiv	=	(_s),				\
 	}
 
+#define PLL_1419X_RATE(_fin, _rate, _m, _p, _s)			\
+	{							\
+		.rate	=	PLL_VALID_RATE(_fin, _rate,	\
+				2 * _m, _p, _s, 0, 16),		\
+		.mdiv	=	(_m),				\
+		.pdiv	=	(_p),				\
+		.sdiv	=	(_s),				\
+	}
+
 #define PLL_36XX_RATE(_fin, _rate, _m, _p, _s, _k)		\
 	{							\
 		.rate	=	PLL_VALID_RATE(_fin, _rate,	\
-- 
2.43.0


