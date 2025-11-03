Return-Path: <linux-kernel+bounces-883791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C154BC2E6DD
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055653B0D48
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDFD2FFFA9;
	Mon,  3 Nov 2025 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="L8f/2Zwr"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75612142E83;
	Mon,  3 Nov 2025 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213255; cv=none; b=rjqUkEY/+WtPduFO9N46gqE8WCzmIbCjAUhEoVG53xFKJaG7D/rQ9YvLB8nzZaUGjQeP6/nFzepemXSdrD3bESYOLTQF5qJv4f0LHiaY3lVJc6saYJXCo1AXri23OKYnFLpMn83vqlkCrWhQSZlJUIFq0/eIfrJjdhUARiWzz6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213255; c=relaxed/simple;
	bh=tO9bqyMR53aT9tnDbQHZ/O6tAlZL2ZsQddj07ko2Jwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxKZg9XWt92BCYvEaOSbmr6Q4d/pWuAHKoxCfTCA781W5cgJY1yCyTFxCyC6dQ1zkfLr740InBrl/KSktu3mLrL1I04cCATB5/gYxOWd3cjC/smY7AI2uVIpTOj6fzczgQ8MT2Lp5uwUkY25rkCXvdQSdT7hNe4XT/Drbwix5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=L8f/2Zwr; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=fTD0aMOXBBOpbBIVQQTjDpagN8By2cNhTKkE/uevXAw=; b=L8f/2ZwrGXYkE90+DKcgkBuhwK
	uIB3y38I1897ULQwP2s7L/EfythRnryipMhU5iwsd4dPDlEe/EbEOWyMHhN53MUvBFtjLR1ECojI1
	6Um6RX28ngSGVFYgH++XDmCMva/b/qPE8xBk5TRaCpC/T3Q5zRR1c4RNsCUdgbu9wiql5GBATGKdU
	FDizrXhCkJ/dL7f4iBKlEI9mWhVBzrRhUKVIMe9uzyGUcEljpMFzQhTyu32N4SGBlpnK8toX5o5ZS
	ikUoZvXp4XakaxZJkRSSSArmQp5iNhebKyeWuYgVYL8nu+tyKNMlXvU4rf8USOpdnCma86zZxXVxd
	neprGcwg==;
Received: from i53875a3a.versanet.de ([83.135.90.58] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vG4AJ-0007rE-Vj; Tue, 04 Nov 2025 00:40:48 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	michael.riesch@collabora.com
Subject: [PATCH 1/2] clk: rockchip: rk3568: Drop CLK_NR_CLKS usage
Date: Tue,  4 Nov 2025 00:40:31 +0100
Message-ID: <20251103234032.413563-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251103234032.413563-1-heiko@sntech.de>
References: <20251103234032.413563-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to get rid of CLK_NR_CLKS and be able to drop it from the
bindings, use rockchip_clk_find_max_clk_id helper to find the highest
clock id.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3568.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
index 97d279399ae8..74eabf9b2ae2 100644
--- a/drivers/clk/rockchip/clk-rk3568.c
+++ b/drivers/clk/rockchip/clk-rk3568.c
@@ -1652,6 +1652,7 @@ CLK_OF_DECLARE(rk3568_cru_pmu, "rockchip,rk3568-pmucru", rk3568_pmu_clk_init);
 static void __init rk3568_clk_init(struct device_node *np)
 {
 	struct rockchip_clk_provider *ctx;
+	unsigned long clk_nr_clks;
 	void __iomem *reg_base;
 
 	reg_base = of_iomap(np, 0);
@@ -1660,7 +1661,9 @@ static void __init rk3568_clk_init(struct device_node *np)
 		return;
 	}
 
-	ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
+	clk_nr_clks = rockchip_clk_find_max_clk_id(rk3568_clk_branches,
+						   ARRAY_SIZE(rk3568_clk_branches)) + 1;
+	ctx = rockchip_clk_init(np, reg_base, clk_nr_clks);
 	if (IS_ERR(ctx)) {
 		pr_err("%s: rockchip clk init failed\n", __func__);
 		iounmap(reg_base);
-- 
2.47.2


