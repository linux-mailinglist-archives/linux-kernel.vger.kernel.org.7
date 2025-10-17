Return-Path: <linux-kernel+bounces-858391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 637B7BEAC7D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 642295A9159
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0B1287511;
	Fri, 17 Oct 2025 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5H9fOme"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B3283FC5
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717663; cv=none; b=fXdVkWGRSOwksML4+ftnRIU8s255YjrVPCA8KZ4497/orFk+opVESZ228ZtGLw4zD63wVDdD8ltQtvQwIpGKSMqYZXTUBR/fuQOwDviXtb/cnkcHrflN/hid7KGpVEYaUwyPB9Yw5I0/UewrtXNphqQVqdPoljAXcIErDBcISNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717663; c=relaxed/simple;
	bh=oxHS6u7FeboNBttWQlQCkoLj03pi1x2TmYSFQR57jhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyMnCQ8QZxUv5hT9SlJ1NvbKJ8Qoen/tlMa7Pf3Ij44whkPUAmKBRp0uGfCw1RKdUhUgvnxwS6BJIQeaaYnSvAVXIeT2TnpdvRBWX4+YvxiHxv8kTdTZijDnU+PYgIY/qHcjwPifVtsJZAA4AcxNuMf1LD5g/vHUDgn9arhM9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5H9fOme; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3d5088259eso302491766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760717658; x=1761322458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/0xrgYWwbL6uDm6bWRd8Dfjm9NXSGd8s9gIV76gFCo=;
        b=N5H9fOme9RthmD+DW85Wkzdr73XsdociiRB0zb1pLi1WJCZiLY6RaDEZOtl73EV6ct
         I/udWKLcPwq+WiLhuNYtCcqi1GcNEOxIPTeDo/3vStx09k0ob4SQ4W9cqVxDI8uQKfU5
         v+R4C0TIsguDQ2eiZOzwKmjdTnXNT6xZuyrhLOtStD2BYRKRQUzMJeDC/XPqb2Feajhp
         fpxmoX0bDs0zH2eMGL2dfvtfGLJwUC5RR1zmC2jviyfncvKL1TzOwOxv1Du16+vNL7JV
         x/lbUIJbIQOkZOoCfzpaDkibjS1KNkPUJcav2zb3jaBG+zzPSwmVhDoh+WkEW1C9Cnbq
         LNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717658; x=1761322458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/0xrgYWwbL6uDm6bWRd8Dfjm9NXSGd8s9gIV76gFCo=;
        b=midQWCUp6aTBlDHmJaofJWk0ccmvk6hU3IlgyJBIPDi8X4hL//kmqu2vR7z537qu0F
         LxT7tJtTm4F+4Au3JpQWjowXHjpS36qZEovI/JVEGBZbyVC+L4lba3CnpK4+BANZFN4P
         fyJlP80e+iVd5Bqp4srdp2V9jPhswckTQfBrqUW+EMl8lXaqKgFnTwPqkmA8F2opKonj
         OtrKhpAE6mwGS+KsqSMvLVi1KJUECz6BGMFNNC1mcH6Z4/Di3aa7joAvam9Ura8rwVyq
         aj/VaZARKdYWw3nUxi19h44lJq5eG6L6yMrjOpvglYNugQPz64ODBVbgiOWbJ7XXaU8v
         kWAg==
X-Forwarded-Encrypted: i=1; AJvYcCX15cmgGBsc2wvuMvjKTNL9N2tET+GWSixH3FSSevskJSXYGwlhycoFDbmsJwYnoeWgftilLgPxyXNHN0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy6QUZupyC/bREh3uNHq7EdXU7H8aX5XkqKlysDn48nTiGYkEV
	m8uaJQGlRG+1wrq2xYQ/0sngjvHN9lcWXzpEPcCrf5fQBKWehajM3akh
X-Gm-Gg: ASbGnctoIFMo+k3GtZk/oZz9A/aAeGmJtwn2X7MAj7Ug0yUJ4N/MLLAZRRkZoY21HyY
	uqzg3W47hUKeVsLxFw52IRAcWhimSQimcW9JgT0VHLA8gfq+izpenauX06cbH2+rzJMbDzKz5dU
	01ZZ/T/61b/W3dSfHkbD1KcqHf5E3QgXqTzmKN+kfFrEDGqK5c9gHfppkt7RjutAniq96MTos43
	G6azPrp2nBsuzdzi7jTW8nAVpF5HfEgz13wNB2FW48lqw7mTHMEKKMN+cnrv17s9uPImo9zddSt
	lep18bzNAkX2sl/eAJ25/BFzOfpP+95WVpqZ9RLaCCiUAeLdSYJERZ0bYcSi4ke0v7CzwiG8SRl
	Vx8JlYZqQsMj0KQTIZP7ucpI9uH81vXMHwtGkSpdLzsztSCvPIPywWii7nRZCTXguKXXbA8Nd++
	S7V7WWfOr4WmzqaJS/4B3ECmi9nNT5tNnHEBg0af2x
X-Google-Smtp-Source: AGHT+IEvX2NLEl2JEWd8maw6vu+Cz/hVCzCLPJGWsXutTdMkKS8cKelXvHyzoaBlWYedD/QgQ0uDEA==
X-Received: by 2002:a17:907:a46:b0:b46:6718:3f30 with SMTP id a640c23a62f3a-b6475128af5mr477286966b.51.1760717657887;
        Fri, 17 Oct 2025 09:14:17 -0700 (PDT)
Received: from ivaylo-T580.. (79-100-18-255.ip.btc-net.bg. [79.100.18.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036706sm9606466b.41.2025.10.17.09.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:14:17 -0700 (PDT)
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
Subject: [PATCH v2 2/5] clk: samsung: clk-pll: Add support for pll_141xx
Date: Fri, 17 Oct 2025 19:13:30 +0300
Message-ID: <20251017161334.1295955-3-ivo.ivanov.ivanov1@gmail.com>
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

The PLL is similar to pll_35xx, with the exception of a different
Locktime - 150 instead of 270, as with pll_142xx.

When defining a PLL, the "con" parameter should be set to CON0
register, like this:

PLL(pll_141xx, CLK_FOUT_SHARED0_PLL, "fout_shared0_pll", "oscclk",
    PLL_LOCKTIME_PLL_SHARED0, PLL_CON0_PLL_SHARED0,
    pll_shared0_rate_table),

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
Changes since V2:
- rebase on next and drop the unnecessary new line
---
 drivers/clk/samsung/clk-pll.c | 4 +++-
 drivers/clk/samsung/clk-pll.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 7bea7be1d..4700eadad 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -278,7 +278,8 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	}
 
 	/* Set PLL lock time. */
-	if (pll->type == pll_142xx || pll->type == pll_1017x)
+	if (pll->type == pll_142xx || pll->type == pll_1017x ||
+	    pll->type == pll_141xx)
 		writel_relaxed(rate->pdiv * PLL142XX_LOCK_FACTOR,
 			pll->lock_reg);
 	else
@@ -1497,6 +1498,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	case pll_1451x:
 	case pll_1452x:
 	case pll_142xx:
+	case pll_141xx:
 	case pll_1017x:
 		pll->enable_offs = PLL35XX_ENABLE_SHIFT;
 		pll->lock_offs = PLL35XX_LOCK_STAT_SHIFT;
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index 6c8bb7f26..3c7575cde 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -51,6 +51,7 @@ enum samsung_pll_type {
 	pll_4311,
 	pll_1017x,
 	pll_1031x,
+	pll_141xx,
 };
 
 #define PLL_RATE(_fin, _m, _p, _s, _k, _ks) \
-- 
2.43.0


