Return-Path: <linux-kernel+bounces-790923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 687B0B3AFD0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C34178970
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F111E47A8;
	Fri, 29 Aug 2025 00:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqmkND7M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C37984D02
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427924; cv=none; b=hm8+Psns4Wzy5N4v8hhw6rJfh9Ujo7E1u9/Ihwisn9oi3xTHYv607zUxCdVd3CYmyFdky5/jYaWAHuLllMcjwyYwFiM0AHIRd/GMVSTyMYXZPuK4JURRoBT11MJbkorR/3/kj3dQcLezU/C58/1EfJ/BfA09aXUX9wfKgzc42aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427924; c=relaxed/simple;
	bh=3ht1wGseKshyK0elknVvnPuwk+xst31YCIMTYyJbsnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ICMaIh5dqbT0h+TTzm3h9zEUyzAqrrm8oUmdP0HBRDr+Jp5JOWbVUJHjnOjPOLNdP/bgxKXsq/aFmpE5MRDrZILBwuaUYwRH/kI0iqH3nNhXJ4CLyNAH/ZUcHJrwfrF5HZ5zqaL0L1RzKeWL68nonLBASUidtr/1j5W4gKZbDXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PqmkND7M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756427921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c3u7x/K6tl9OG9wiIGh8KHdwHeRRIahMnviBLAU+NwA=;
	b=PqmkND7M44usJYlRY1zs1BxeQQGR9HXa2q+OcRYpd1O8e4HJM8sQthmiFLcB0koT2SJJkc
	pLStHnjAHVgjJffvUs6hP44nczjdhZcDIezvuIc85CpmdRYHSFvhlIw0Y+pdsbEq7Etkl8
	ZQnIIjt1zSAAnCk1dkzMLsPAdQ6MwYU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-7DGagdovMPKiObjxf9-7Qg-1; Thu, 28 Aug 2025 20:38:40 -0400
X-MC-Unique: 7DGagdovMPKiObjxf9-7Qg-1
X-Mimecast-MFC-AGG-ID: 7DGagdovMPKiObjxf9-7Qg_1756427919
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70f9ef271a4so830776d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427919; x=1757032719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3u7x/K6tl9OG9wiIGh8KHdwHeRRIahMnviBLAU+NwA=;
        b=dX8Rtir/zS6rSt3g2Vai/6RyGLu1mVBE8sS16mr+eJve2TWJ9yOCgMrVN1324LC7qz
         LwDzmmoDt/mClugjYIJeXb8TDT6EWH2DvoQ8SKNeTsmy0IWDG3I5BMH5LGqGxGQ/Usxm
         QsQAlpzjCxLmMKbuwMtl85zvHQ7fT4SMUNtuPZXKLOWh2tv+q82Y8TgZcXPJYKzWvQJ4
         vRZEof31D5ZwHQxR4jpqb5Nk8fyMVJPeCUcs0dioHAE28OBRw98V1oA2wjkiFb5I7fTs
         ZarAMNBfo7HqXnBA9S2XDfzv3Rj1EnNwfN+ZwMl2YNKot3dEl0ILU4fmLpJNJAIvJj4E
         5YoA==
X-Forwarded-Encrypted: i=1; AJvYcCXjKX/gQFy9v5ExYwqsAHCmkjgghZne+j/ZaIbNbzQC11M8SD2XY/5508GT5njcRkwfMB0eaRp/KorQ8GY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7nzVA+eHxS2o75iHTJINl/RR4TmQUuW+9G6b4z1nIyqUsTpqY
	lcEoduCjuShzYsuXseQM2aQZvmrRZ2xPDd5LJEmJtl0VqptwKzAYkl52InIZMLzV9vUIQM5wULt
	5dg5vJGXRLK4IzmuHQ+ERwANMW5lr4pvH8sjZTIk6nEMXUhsP10SZC6pi+q1KT71gtw==
X-Gm-Gg: ASbGncu0gvA4qzxYLnAZg3OO3XnzQXpIQfNyaveh+54P/bWgZ9gYgQdrDhBRuGGsGwS
	aML/gLG7gVhrNWBHfFz5ld30K85EgJ+f4VhZhPGV1iHfqWZkYkIV+qfKihBZmt7oQ0bQg/nsOny
	82JyVxvFoQENOrMDXMHf4kemaO3RTqvzgWDdhm+IkFaDS4vhZDkRlna6PzAq5AHXvDqx10yPB7I
	+Kd3lFv/r18E4qehICOIvb5Kyft4tfK9jOLloW3//gXfDsVUYG2xhhz9Y7Q+/4hr/czlCzK12jg
	hWim6LkxShEfW8WwVcmoY68EKsXGi+o11yYd8m+H8i7j0TDTs4RHbYDGP1i895NA3btk4m6jmsU
	eX8HB5jWPwdTbKXU0NZbl2kT1dHsBJsPihg==
X-Received: by 2002:a05:6214:238e:b0:70d:b960:22d9 with SMTP id 6a1803df08f44-70dd59c0dc5mr108738126d6.0.1756427919311;
        Thu, 28 Aug 2025 17:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9Y+srjMYTUDi85Cn0pJcSe0dbGIf69GdJd8S7Yq6E+2fhSrZboCv3tbgRe/rYDM8Hmu9x3A==
X-Received: by 2002:a05:6214:238e:b0:70d:b960:22d9 with SMTP id 6a1803df08f44-70dd59c0dc5mr108737916d6.0.1756427918880;
        Thu, 28 Aug 2025 17:38:38 -0700 (PDT)
Received: from [192.168.1.2] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e6264141asm5588696d6.65.2025.08.28.17.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 17:38:37 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 28 Aug 2025 20:38:20 -0400
Subject: [PATCH 1/8] clk: nxp: lpc32xx: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-clk-round-rate-v2-v1-1-b97ec8ba6cc4@redhat.com>
References: <20250828-clk-round-rate-v2-v1-0-b97ec8ba6cc4@redhat.com>
In-Reply-To: <20250828-clk-round-rate-v2-v1-0-b97ec8ba6cc4@redhat.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Bjorn Andersson <andersson@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Andrea della Porta <andrea.porta@suse.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756427914; l=6057;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=3ht1wGseKshyK0elknVvnPuwk+xst31YCIMTYyJbsnI=;
 b=vBgDN2UolIYgWOoWXbkA84AYONG/GqJkkikThkMURYKOSkSyvbFpmEqJUiCoeaUkKgCqq7nEQ
 DFy61Z9uuUoC1htEQWfzBbUhQKFicg1qdsl//DSZRp+vreyJtcnSot0
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Note that the changes involving LPC32XX_DEFINE_PLL_OPS were done
by hand.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/nxp/clk-lpc32xx.c | 59 ++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
index 96a1a527b3808573d3ce2c73af066a0bf37f1245..23f980cf6a2b59ee1c93a2519fe5188d251fa12f 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -578,17 +578,17 @@ static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return regmap_update_bits(clk_regmap, clk->reg, 0x1FFFF, val);
 }
 
-static long clk_hclk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *parent_rate)
+static int clk_hclk_pll_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	struct lpc32xx_pll_clk *clk = to_lpc32xx_pll_clk(hw);
-	u64 m_i, o = rate, i = *parent_rate, d = (u64)rate << 6;
+	u64 m_i, o = req->rate, i = req->best_parent_rate, d = (u64)req->rate << 6;
 	u64 m = 0, n = 0, p = 0;
 	int p_i, n_i;
 
-	pr_debug("%s: %lu/%lu\n", clk_hw_get_name(hw), *parent_rate, rate);
+	pr_debug("%s: %lu/%lu\n", clk_hw_get_name(hw), req->best_parent_rate, req->rate);
 
-	if (rate > 266500000)
+	if (req->rate > 266500000)
 		return -EINVAL;
 
 	/* Have to check all 20 possibilities to find the minimal M */
@@ -613,9 +613,9 @@ static long clk_hclk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 		}
 	}
 
-	if (d == (u64)rate << 6) {
+	if (d == (u64)req->rate << 6) {
 		pr_err("%s: %lu: no valid PLL parameters are found\n",
-		       clk_hw_get_name(hw), rate);
+		       clk_hw_get_name(hw), req->rate);
 		return -EINVAL;
 	}
 
@@ -633,22 +633,25 @@ static long clk_hclk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 
 	if (!d)
 		pr_debug("%s: %lu: found exact match: %llu/%llu/%llu\n",
-			 clk_hw_get_name(hw), rate, m, n, p);
+			 clk_hw_get_name(hw), req->rate, m, n, p);
 	else
 		pr_debug("%s: %lu: found closest: %llu/%llu/%llu - %llu\n",
-			 clk_hw_get_name(hw), rate, m, n, p, o);
+			 clk_hw_get_name(hw), req->rate, m, n, p, o);
 
-	return o;
+	req->rate = o;
+
+	return 0;
 }
 
-static long clk_usb_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *parent_rate)
+static int clk_usb_pll_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct lpc32xx_pll_clk *clk = to_lpc32xx_pll_clk(hw);
 	struct clk_hw *usb_div_hw, *osc_hw;
 	u64 d_i, n_i, m, o;
 
-	pr_debug("%s: %lu/%lu\n", clk_hw_get_name(hw), *parent_rate, rate);
+	pr_debug("%s: %lu/%lu\n", clk_hw_get_name(hw), req->best_parent_rate,
+		 req->rate);
 
 	/*
 	 * The only supported USB clock is 48MHz, with PLL internal constraints
@@ -656,7 +659,7 @@ static long clk_usb_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	 * and post-divider must be 4, this slightly simplifies calculation of
 	 * USB divider, USB PLL N and M parameters.
 	 */
-	if (rate != 48000000)
+	if (req->rate != 48000000)
 		return -EINVAL;
 
 	/* USB divider clock */
@@ -684,30 +687,30 @@ static long clk_usb_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 			clk->m_div = m;
 			clk->p_div = 2;
 			clk->mode = PLL_NON_INTEGER;
-			*parent_rate = div64_u64(o, d_i);
+			req->best_parent_rate = div64_u64(o, d_i);
 
-			return rate;
+			return 0;
 		}
 	}
 
 	return -EINVAL;
 }
 
-#define LPC32XX_DEFINE_PLL_OPS(_name, _rc, _sr, _rr)			\
+#define LPC32XX_DEFINE_PLL_OPS(_name, _rc, _sr, _dr)			\
 	static const struct clk_ops clk_ ##_name ## _ops = {		\
 		.enable = clk_pll_enable,				\
 		.disable = clk_pll_disable,				\
 		.is_enabled = clk_pll_is_enabled,			\
 		.recalc_rate = _rc,					\
 		.set_rate = _sr,					\
-		.round_rate = _rr,					\
+		.determine_rate = _dr,					\
 	}
 
 LPC32XX_DEFINE_PLL_OPS(pll_397x, clk_pll_397x_recalc_rate, NULL, NULL);
 LPC32XX_DEFINE_PLL_OPS(hclk_pll, clk_pll_recalc_rate,
-		       clk_pll_set_rate, clk_hclk_pll_round_rate);
+		       clk_pll_set_rate, clk_hclk_pll_determine_rate);
 LPC32XX_DEFINE_PLL_OPS(usb_pll,  clk_pll_recalc_rate,
-		       clk_pll_set_rate, clk_usb_pll_round_rate);
+		       clk_pll_set_rate, clk_usb_pll_determine_rate);
 
 static int clk_ddram_is_enabled(struct clk_hw *hw)
 {
@@ -954,8 +957,8 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 				   divider->flags, divider->width);
 }
 
-static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long *prate)
+static int clk_divider_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct lpc32xx_clk_div *divider = to_lpc32xx_div(hw);
 	unsigned int bestdiv;
@@ -967,11 +970,15 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 		bestdiv &= div_mask(divider->width);
 		bestdiv = _get_div(divider->table, bestdiv, divider->flags,
 			divider->width);
-		return DIV_ROUND_UP(*prate, bestdiv);
+		req->rate = DIV_ROUND_UP(req->best_parent_rate, bestdiv);
+
+		return 0;
 	}
 
-	return divider_round_rate(hw, rate, prate, divider->table,
-				  divider->width, divider->flags);
+	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
+				       divider->table, divider->width, divider->flags);
+
+	return 0;
 }
 
 static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -990,7 +997,7 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops lpc32xx_clk_divider_ops = {
 	.recalc_rate = clk_divider_recalc_rate,
-	.round_rate = clk_divider_round_rate,
+	.determine_rate = clk_divider_determine_rate,
 	.set_rate = clk_divider_set_rate,
 };
 

-- 
2.50.1


