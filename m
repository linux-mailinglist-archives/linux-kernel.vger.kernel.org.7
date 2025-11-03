Return-Path: <linux-kernel+bounces-883809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B525FC2E7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3419A189AD4E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A823148AB;
	Mon,  3 Nov 2025 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jPRaZV2C"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4BD29AB05;
	Mon,  3 Nov 2025 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213778; cv=none; b=IMm5zYPT1/mgovuRHjhXgaPQPhH3GLd+wM1RF1BQrd34dHX49RvB3pCw6dpNpSe3Wrb0Bb3E+Qu5hFo2dBz4F8WnEbd8HldnjcUdiCLxG7vy9WZ6qF3FWpYerQgXtyyw1q5fGN6F7kzw/zl7CwSIQ1MUY6B1wfKhzsfNc/JKgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213778; c=relaxed/simple;
	bh=EZfbPK9Xr3tF39XaRIdfqxz2Twswx4WKAnIksHi+JwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKkik4U7XjRfymGvRDtdU2NF/YIayOYUEPROSKtTHiCORotztPb7Bkr5ExQ9Z/VIzG0iawaxu+Yld7T/cNUjJpaj1Erke0IWnKzv2Im2X61uxcJ3hEsbs090pmyKBb53J5nzaXcL8J1LUvwIF26nCHl6QQB3uuoFwIFCj32B25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jPRaZV2C; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=6Bed2wzgyyzbCuzjQG7pgG0QKZQhz1UrIXWqdynClIA=; b=jPRaZV2Cbv2PhwnmHKuc/iD6gI
	koYH4ETx2vTXbfOikR75/Pq2MDgkgafTkehFPL7QPz+8p8oHUMZxwlBk1BgYErTeBkN5+eokdgV+k
	HUclx4q1AUiazl5Rhu0EAwJzzstoWiD3M+Ev1fFvNkT12RWwgGm76FadoEU/2UUrC1VFqWzRxApca
	F9YibWggOr0bKp3LHE/124KYsEfzdhVlaUSA5xnJh0VP7lDPAmKC79+MekW4a+lrDdYmyrNc0vjkE
	cMqxuTd/rfEItk8RB6iXKfH6rAshs1f+VBpto3EQlkGRTzI4qL1q6Pc63TXrOXUA2xShK2G6juOXY
	DC+77tgQ==;
Received: from i53875a3a.versanet.de ([83.135.90.58] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vG4Ik-0007vT-Pk; Tue, 04 Nov 2025 00:49:30 +0100
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
Subject: [PATCH 3/3] arm64: dts: rockchip: add missing clocks for cpu cores on rk356x
Date: Tue,  4 Nov 2025 00:49:26 +0100
Message-ID: <20251103234926.416137-4-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251103234926.416137-1-heiko@sntech.de>
References: <20251103234926.416137-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All cpu cores are supplied by the same clock, but all except the first
core are missing that clocks reference - add the missing ones.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index d0c76401b45e..a1815f8a96e1 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -69,6 +69,7 @@ cpu1: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x100>;
+			clocks = <&scmi_clk SCMI_CLK_CPU>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
@@ -84,6 +85,7 @@ cpu2: cpu@200 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x200>;
+			clocks = <&scmi_clk SCMI_CLK_CPU>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
@@ -99,6 +101,7 @@ cpu3: cpu@300 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x300>;
+			clocks = <&scmi_clk SCMI_CLK_CPU>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
-- 
2.47.2


