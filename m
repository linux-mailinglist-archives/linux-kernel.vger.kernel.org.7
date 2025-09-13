Return-Path: <linux-kernel+bounces-815140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F344BB56037
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF401C857EF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56DD2EBB93;
	Sat, 13 Sep 2025 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDj51K4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E228643D;
	Sat, 13 Sep 2025 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758565; cv=none; b=H9ZwL1ZRJnwmGsEPcQ3R4TiVuE4YMMX3tVj+YjtLAFBvgrfW31aBa7fS/GVCtkYs0+kWslGDgoU1rJRAjLOxDBtFGwpSBLKnGwTW6r5IR+34Vw/ImUcRZAWTIdT2YX4KSXPQMZln0uc3UBj78XGZqJISux8ZBM+A+SUEI8l3RFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758565; c=relaxed/simple;
	bh=ojF6PfBKwReEDaj3Mu698DpXN9oraXTujEiRhBUQr4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xft9QEtAsxnvXDb3ZLM/hQELw3pttetfFiovcOV3yK3i2cUVemzvkj0El/FpjeJvxuZLaG+667bt3fJAJyjRDbjkInCEnXyzz/fQ1rsCsL/G/PSqh8kcNYUgJa7JQ+kUCM/PxYZEHL/nG5lSH+fjRqSwmFRCAdkI+KknsWPnfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDj51K4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE92C4CEEB;
	Sat, 13 Sep 2025 10:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757758564;
	bh=ojF6PfBKwReEDaj3Mu698DpXN9oraXTujEiRhBUQr4g=;
	h=From:To:Cc:Subject:Date:From;
	b=WDj51K4z3iWjhPFCI7RymiVsSdQW+WqIf/Pa5Pi0Q7i06vDTAS81VP2Grh7l4GE/X
	 Vry82r6ey6DJysCVDhJowMXp7a4VLYQuHAAGOCTX8r4JyrlMGUCGqJ3Z14Sx0XyBzD
	 U6WTkDfRbiC8WJm+XToSaTmqPi3IJE1XhEFFWrwVZTWz8XcBizMan2DPyPRI2augOy
	 0vLjJmAuxQu+D/pB3E51CVzfqabaFj8Ig10s0MUsLi3jx6LwD5TGl+lrxfjBjP0X7m
	 rE8WeT+yoxagx8PJ9QQ7FTG7yDV9pkr7+JhMgqIHSTquv2/weYMk4jMcdur7ueyEJs
	 oiYXMieo8H5sw==
Received: by wens.tw (Postfix, from userid 1000)
	id 275645FC8D; Sat, 13 Sep 2025 18:16:02 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: sun55i: a523: Assign standard clock rates to PRCM bus clocks
Date: Sat, 13 Sep 2025 18:16:00 +0800
Message-Id: <20250913101600.3932762-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

At least in the initial version of U-boot support landed upstream, the
PRCM bus clocks were not configured, and left at their reset default 24
MHz clock rate. This is quite slow for the peripherals on them.

The recommended rates from the manual are:

- AHBS: 200 MHz
- APBS0: 100 MHz
- APBS1: 24 MHz

Since 24 MHz is the hardware default, just assign rates for the first two.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 3aad1b909501..5cd6ddae86c8 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -767,6 +767,8 @@ r_ccu: clock-controller@7010000 {
 				      "pll-audio";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			assigned-clocks = <&r_ccu CLK_R_AHB>, <&r_ccu CLK_R_APB0>;
+			assigned-clock-rates = <200000000>, <100000000>;
 		};
 
 		nmi_intc: interrupt-controller@7010320 {
-- 
2.39.5


