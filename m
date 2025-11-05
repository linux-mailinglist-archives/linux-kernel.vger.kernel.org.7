Return-Path: <linux-kernel+bounces-887516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD522C386C7
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64F118952BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14252F5498;
	Wed,  5 Nov 2025 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="qHKe0Ako"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9F92F3C09
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386856; cv=none; b=VeaXY382NMPKaMYDcuQmdJb5JmxRBA+lPMAukow2LNy2iycA9/ECNTvYFUHw9CEElDV+A06Cmrlnr98P5CijaCsGb4bQgioo0b4ZP6hpTbITshdvErXedTdgjnXbnk8YlltKFhAaunUas+Um/yIMtjJLd4J7TVOhGRlSTRg1Ypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386856; c=relaxed/simple;
	bh=bqTrvNYJcHGeMNets2XRzmoJwHvog1wV/FZj31K+1Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+g88OB58OfbvcN9XzOOkuGH5l3HHnr3nTgokrsR/s01Rc10mUgb/5iRjcTD37lG3A4AmXMVDvfBg5npW7Ul0Mjd6ZBkXLgF30RdQGoOLuHnO5UInvXlowLlxP9v0R8xVcVwJpS2M2Li+EIOPER1k7k1frLFNZgx6SixUuhWQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=qHKe0Ako; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=W85a3Bth4H+0PuSuOPezMPOuhSZAa3dLiOvxgBT/vp8=; b=qHKe0AkoxPIo5gNP1bjl3ETDrE
	5k8Jknr78aZ3Yy2BlIAyTxULspppywWTy7rCKF471AcyqXFhrwvjGoTqmWYuAg7WvEkUs8FZUFIYy
	33rm/qGvFOoMAvsYwThcZke9XF8/P3+VXWz9tp3UR/bGTc+PYDeAPVdQls6kmTw/YKWgJd4w9au7s
	yq6N/5hJdQbv+xeJR/F9yGOrkoBDd7diawFiBsVpw8SiXQunr1NR99Oem/0m5RUy/yedt+ntjjHLY
	QP2dfkjSpSkzjg18ZlSCKzAn8D69BBWOoKVj7mlYV7qKjVaxEN78/s+SAx2zDn3LJK8yGQcTTzK14
	r6sVfttw==;
Received: from i53875bde.versanet.de ([83.135.91.222] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vGnKM-0001Qu-Gh; Thu, 06 Nov 2025 00:54:10 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	diederik@cknow-tech.com
Subject: [PATCH] arm64: dts: rockchip: use SCMI clock id for gpu clock on rk356x
Date: Thu,  6 Nov 2025 00:54:08 +0100
Message-ID: <20251105235408.163282-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of hard-coding 1, use the more descriptive ID from the binding
to reference the SCMI clock for the gpu on rk356x.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index a1815f8a96e1..16773904ff66 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -616,7 +616,7 @@ gpu: gpu@fde60000 {
 			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "job", "mmu", "gpu";
-		clocks = <&scmi_clk 1>, <&cru CLK_GPU>;
+		clocks = <&scmi_clk SCMI_CLK_GPU>, <&cru CLK_GPU>;
 		clock-names = "gpu", "bus";
 		#cooling-cells = <2>;
 		power-domains = <&power RK3568_PD_GPU>;
-- 
2.47.2


