Return-Path: <linux-kernel+bounces-771856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B6CB28C42
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB957AD3A3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDB6241664;
	Sat, 16 Aug 2025 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="E+wq0B7O"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ACC23F429;
	Sat, 16 Aug 2025 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755335530; cv=pass; b=bayHhDTuzYdt1nXIWYayTp3oB5+LglkpcQ/WO4UMlKzyROXt4OnHbMFMy0IBZYSwRplo/aLPp8fbR1Aw7Uiu1XSFslRWTjS1tsxmcks7fZjhWl4IgIFecH/dpZqj+SJDIzl+1D2wmmB3eYHVVJA9yAC3InC0Mqn93TsJX295vtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755335530; c=relaxed/simple;
	bh=KD02o48DHNQr2a66iJi0HFDZ6V2bdT6DPE78DmSl4LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sznlq+HU+siulee3uimjbgVFwBV5fff6xf80qG2pXsvglXINK57fv5h2be53TSWh02C0gG3tHpDfKnCba7X9uuB6EUmhCk87KHcq0hy27XIyGQ7bQRdBv+c+jpji+DxrNyqCMytHkccnaRnSCuEskIYPWrv1pTsmqKwZsQzruf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=E+wq0B7O; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755335512; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WSsgTThAy7jMuDrf1u3yDPZ9tT+4wHD06xMgMRwaMQ5Uumu9rxxgSmFW//9fFKani0A8RmE50+G43SS2zQ9S+qz6mw1aifv00c9SS18Z5UvFkyOkvPVrHdSf3qoVb0OVR4Bf5Up9gneNG1KH89cHG/40jf7kpUizrMzaYJbZfZc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755335512; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wQL6RzmWDVretl33sqWxS4afoARp3tc0r+5Jdb2Dkdg=; 
	b=jsKnafYLAD5U8kAXRX1F7x7bkpzO3Av2UdIe7KorGqqlQTpcR0l35wK/uzI2NO/JEBpPZ+2a9G2wXXM+jYeFV7tzI64xKx6eaqQH4LxWDzvmUsLbRRcj0IxuVTQTyZ82hH00N8Tk8pv7fId+6LKWmM0yzYgvxHCEKbywXNhM7Xw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755335512;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wQL6RzmWDVretl33sqWxS4afoARp3tc0r+5Jdb2Dkdg=;
	b=E+wq0B7OaGSLi++tEfIhLjrEE2MtVCD/Xw0K/l1lCZVHIUpEJSMgdwKBOYDO8n1t
	95+r241QrcMZXwZh05hDoNFPXS/6wDJv5P/mQ8E7d9qQGMI+cr7rFxEQ/7lH4moHqnw
	rwC9Do/U+b/tqngHqfLAzfQuDw5fJYH0LXfgLDeu4ABl5HkLmIj98DVtz6Yb6B58sXs
	mNjK6JPXN3yd9qtlHGiazWCK4f1Aj1XljDhc0tImZwTqICLNSTwNNzwQe4cHJIRg5nl
	wlCuXu8l9dpGxQiJBodeG9R+/khVL7hg0WTE+3uGNHpcLVEN6Yydjk63gxrupbYqAb6
	S8WH5ZSB4w==
Received: by mx.zohomail.com with SMTPS id 1755335508929177.78944857973283;
	Sat, 16 Aug 2025 02:11:48 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v3 2/4] clk: thead: add support for enabling/disabling PLLs
Date: Sat, 16 Aug 2025 17:11:11 +0800
Message-ID: <20250816091113.2596048-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816091113.2596048-1-uwu@icenowy.me>
References: <20250816091113.2596048-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The 2nd control word of T-Head TH1520 PLLs contains a bit to put the VCO
into reset state, which means disabling the PLL.

Some PLLs are put to disabled state by the bootloader, and the clock
driver should be able to enable them.

Add support for enabling/disabling PLLs. PLLs other than DPU ones are
set CLK_IS_CRITICAL to prevent killing the system -- they're meant to
drive CPU or system buses (even the GMAC/Video ones are driving arbitrary
buses).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Reviewed-by: Drew Fustini <fustini@kernel.org>
---
No changes in v2.
Changes in v3:
- Added Drew's R-b.

 drivers/clk/thead/clk-th1520-ap.c | 38 +++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
index ec52726fbea95..d81445e24a96a 100644
--- a/drivers/clk/thead/clk-th1520-ap.c
+++ b/drivers/clk/thead/clk-th1520-ap.c
@@ -18,6 +18,7 @@
 #define TH1520_PLL_FBDIV	GENMASK(19, 8)
 #define TH1520_PLL_REFDIV	GENMASK(5, 0)
 #define TH1520_PLL_BYPASS	BIT(30)
+#define TH1520_PLL_VCO_RST	BIT(29)
 #define TH1520_PLL_DSMPD	BIT(24)
 #define TH1520_PLL_FRAC		GENMASK(23, 0)
 #define TH1520_PLL_FRAC_BITS    24
@@ -236,6 +237,30 @@ static const struct clk_ops ccu_div_ops = {
 	.determine_rate	= clk_hw_determine_rate_no_reparent,
 };
 
+static void ccu_pll_disable(struct clk_hw *hw)
+{
+	struct ccu_pll *pll = hw_to_ccu_pll(hw);
+
+	regmap_set_bits(pll->common.map, pll->common.cfg1,
+			TH1520_PLL_VCO_RST);
+}
+
+static int ccu_pll_enable(struct clk_hw *hw)
+{
+	struct ccu_pll *pll = hw_to_ccu_pll(hw);
+
+	return regmap_clear_bits(pll->common.map, pll->common.cfg1,
+				 TH1520_PLL_VCO_RST);
+}
+
+static int ccu_pll_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_pll *pll = hw_to_ccu_pll(hw);
+
+	return !regmap_test_bits(pll->common.map, pll->common.cfg1,
+				 TH1520_PLL_VCO_RST);
+}
+
 static unsigned long th1520_pll_vco_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
@@ -293,6 +318,9 @@ static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
 }
 
 static const struct clk_ops clk_pll_ops = {
+	.disable	= ccu_pll_disable,
+	.enable		= ccu_pll_enable,
+	.is_enabled	= ccu_pll_is_enabled,
 	.recalc_rate	= ccu_pll_recalc_rate,
 };
 
@@ -308,7 +336,7 @@ static struct ccu_pll cpu_pll0_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_DATA("cpu-pll0",
 					      osc_24m_clk,
 					      &clk_pll_ops,
-					      0),
+					      CLK_IS_CRITICAL),
 	},
 };
 
@@ -320,7 +348,7 @@ static struct ccu_pll cpu_pll1_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_DATA("cpu-pll1",
 					      osc_24m_clk,
 					      &clk_pll_ops,
-					      0),
+					      CLK_IS_CRITICAL),
 	},
 };
 
@@ -332,7 +360,7 @@ static struct ccu_pll gmac_pll_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_DATA("gmac-pll",
 					      osc_24m_clk,
 					      &clk_pll_ops,
-					      0),
+					      CLK_IS_CRITICAL),
 	},
 };
 
@@ -352,7 +380,7 @@ static struct ccu_pll video_pll_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_DATA("video-pll",
 					      osc_24m_clk,
 					      &clk_pll_ops,
-					      0),
+					      CLK_IS_CRITICAL),
 	},
 };
 
@@ -404,7 +432,7 @@ static struct ccu_pll tee_pll_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS_DATA("tee-pll",
 					      osc_24m_clk,
 					      &clk_pll_ops,
-					      0),
+					      CLK_IS_CRITICAL),
 	},
 };
 
-- 
2.50.1


