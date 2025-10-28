Return-Path: <linux-kernel+bounces-873447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E0C13F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CE43560274
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F57B3064AA;
	Tue, 28 Oct 2025 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ5pvINl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69C304BC1;
	Tue, 28 Oct 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645156; cv=none; b=WhEXYmn+FhYRW2BFlqNebgJPfbhVuFR2h+pzAip9qqRyAoZVG9Ttjlr9n3BlfesxBkpu39/GOb5EYwrhkw0eKCdYFr+RbVdTFEpb4swZ6W40Vnb+qNxampwuTRSvK677dtzNhJ/nAdGZvDrh0xdSA0MrAZ+nOyPq7npY1+jD48c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645156; c=relaxed/simple;
	bh=cVF3ZGBxFw46Zm8/l8bHWG0RQpu+h0lasLVe7zXgkkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jg2G/ZdyT6X7Jb7XCZUIm45i6qjkkxhMpmTbo+QnDk+lhmEaVIXOzwmytWw7S2TnkApMsCfIKqqe25k7VTri8/riU9dACKZxbQlz15LxFBPnKBrGkp1BiS40VI0tuf3fYE8ed2PhzvMwm1JMeGZkazwnjWNdJB653iDrHqJ2yPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ5pvINl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9DB0C2BCB1;
	Tue, 28 Oct 2025 09:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761645155;
	bh=cVF3ZGBxFw46Zm8/l8bHWG0RQpu+h0lasLVe7zXgkkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MZ5pvINlLVJSn6ZfjH57wmSF9QK9xvTgiD+vwWPq5azTKGyPBGZNjELKM0/uat6hM
	 ujmCmeQ3F3H+6oTPuAE+24PgXSFAjnBsiHl2klGSsMSUHXQPfj0Tlybh/EYTtQ7dkX
	 G47H2iNp8Zi8wWvbcB5OZnIfAZec0zzlXudqhc6/yGHK6/fQr2dj/ssgRb3gVWcXAa
	 Uvl0qqWxy8ItpHN8kQrXnZGHwkiq7kdb9tFXEXmZF3lVGDUY0ZiMPLBfgpbrA53rvY
	 tga1eKTUk8w8knqg++33kk4Qyc5t2zDEby1twftX7EYy7KyFItkh96WFCU9MWbX+v9
	 5tx8N9eEc7TNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0923CCF9EE;
	Tue, 28 Oct 2025 09:52:35 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 28 Oct 2025 17:52:34 +0800
Subject: [PATCH v4 8/8] arm64: dts: amlogic: A5: Add peripheral clock
 controller node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-a5-clk-v4-8-e62ca0aae243@amlogic.com>
References: <20251028-a5-clk-v4-0-e62ca0aae243@amlogic.com>
In-Reply-To: <20251028-a5-clk-v4-0-e62ca0aae243@amlogic.com>
To: Chuan Liu <chuan.liu@amlogic.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761645153; l=2041;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=YYbjhOqv9sLsKL9/6kFNdkCYIVZ6AE4KPrWobMyqnNo=;
 b=DoeEFqJNWBpzx0tOSYR8gEBcxicBskuvYLQGtd01Z114H7ZbIhZKnIz5tz0HrMXe+cYzQKes8
 1r2vICflcg9DNe+Vi2WNxfemF/EvYsC2b1LUoPNmBkr2nN8uRFH3H/B
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add peripheral clock controller node for A5 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi | 43 +++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
index 70deeab220e0..7324e427ed39 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/power/amlogic,a5-pwrc.h>
 #include <dt-bindings/clock/amlogic,a5-scmi-clkc.h>
 #include <dt-bindings/clock/amlogic,a5-pll-clkc.h>
+#include <dt-bindings/clock/amlogic,a5-peripherals-clkc.h>
 
 / {
 	cpus {
@@ -83,6 +84,48 @@ scmi_clk: protocol@14 {
 };
 
 &apb {
+	clkc_periphs: clock-controller@0 {
+		compatible = "amlogic,a5-peripherals-clkc";
+		reg = <0x0 0x0 0x0 0x224>;
+		#clock-cells = <1>;
+		clocks = <&xtal>,
+			 <&scmi_clk CLKID_OSC>,
+			 <&scmi_clk CLKID_FIXED_PLL>,
+			 <&scmi_clk CLKID_FCLK_DIV2>,
+			 <&scmi_clk CLKID_FCLK_DIV2P5>,
+			 <&scmi_clk CLKID_FCLK_DIV3>,
+			 <&scmi_clk CLKID_FCLK_DIV4>,
+			 <&scmi_clk CLKID_FCLK_DIV5>,
+			 <&scmi_clk CLKID_FCLK_DIV7>,
+			 <&clkc_pll CLKID_MPLL2>,
+			 <&clkc_pll CLKID_MPLL3>,
+			 <&clkc_pll CLKID_GP0_PLL>,
+			 <&scmi_clk CLKID_GP1_PLL>,
+			 <&clkc_pll CLKID_HIFI_PLL>,
+			 <&scmi_clk CLKID_SYS_CLK>,
+			 <&scmi_clk CLKID_AXI_CLK>,
+			 <&scmi_clk CLKID_SYS_PLL_DIV16>,
+			 <&scmi_clk CLKID_CPU_CLK_DIV16>;
+		clock-names = "xtal",
+			      "oscin",
+			      "fix",
+			      "fdiv2",
+			      "fdiv2p5",
+			      "fdiv3",
+			      "fdiv4",
+			      "fdiv5",
+			      "fdiv7",
+			      "mpll2",
+			      "mpll3",
+			      "gp0",
+			      "gp1",
+			      "hifi",
+			      "sysclk",
+			      "axiclk",
+			      "sysplldiv16",
+			      "cpudiv16";
+	};
+
 	reset: reset-controller@2000 {
 		compatible = "amlogic,a5-reset",
 			     "amlogic,meson-s4-reset";

-- 
2.42.0



