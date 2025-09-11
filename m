Return-Path: <linux-kernel+bounces-812630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAB5B53AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8751893637
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED5436CC77;
	Thu, 11 Sep 2025 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJd45Roz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1108F36934F;
	Thu, 11 Sep 2025 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757612836; cv=none; b=QvR2SLMCC4ggQr2mr3XIv4xlHJmjyzJCzulq6nUx+54N+gsTwpLIuxcHqifKC0YZb6HqwDZm6ZOLUUcKBV6CNKhw7vckNXd2mndr3U4xxymGFuzwDU1m7nS87W+MBcbqgdjckmnItqkJIIflvWgH04jk4k6HC1YdTlU5PP/sBG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757612836; c=relaxed/simple;
	bh=W8J/+Z9oRBNbp4TXxTxT486U9Z9A7OK+Xcu6z7nwH6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jT6R2QxMU/bRjjfg1TkFZF0gnqaEextNoOMC+8/fpvrYKLZtHU5kufGTK7+plkjGhto9iNTNOH7x5bI7eKdjMx+pvvef9x3WzwYRHH0jZTCoaQfI2g4pQI9yLtM0V2R1WmDYKytrJHCS2DL6QYBAyfz8c4elsRsSRO+qCJTpw7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJd45Roz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86C2C4CEFB;
	Thu, 11 Sep 2025 17:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757612835;
	bh=W8J/+Z9oRBNbp4TXxTxT486U9Z9A7OK+Xcu6z7nwH6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JJd45RozqFkAXe9m5Hfhk0n4JHTQvVyC/c+SxDDlCKZ6RCZCiEjddSRtjO0TmsKvZ
	 u172mTIPv0AfawQuFAXI77k94Eol/+WUutllAE5dcQZuddsPhizkBIynE/991UjTyt
	 lQ/BOQOR0cxz8qOLvmZ19G6WWca1+Gfgb2xjRDMp44ZDT7ML4su25Jj3HPpnc/3u5b
	 IdUQ4sS7Ywc591SNk+0Q9jjbghEXKsu5o1DxfowV3N6IsgmEIcDqGBS3LJpkeB45wp
	 Aztno5dew+S53sRlGe9A8OLj8ZNC8j37jwySePMSv80khSINbvTy5G/qtXzEAl1NKP
	 9yM+WdKM5vWIg==
Received: by wens.tw (Postfix, from userid 1000)
	id 09AEA5FF0D; Fri, 12 Sep 2025 01:47:12 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] arm64: dts: allwinner: a523: Add MCU PRCM CCU node
Date: Fri, 12 Sep 2025 01:47:09 +0800
Message-Id: <20250911174710.3149589-7-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250911174710.3149589-1-wens@kernel.org>
References: <20250911174710.3149589-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

Add a device node for the third supported clock controller found in the
A523 / T527 SoCs. This controller has clocks and resets for the RISC-V
MCU, and others peripherals possibly meant to operate in low power mode
driven by the MCU, such as audio interfaces, an audio DSP, and the NPU.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v1:
- Enlarged MCU PRCM register range to 0x200
- Moved "r-ahb" clock to the end of the list and added "r-apb0" clock
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 79bd9ce08c7c..f93376372aba 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -4,8 +4,10 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/sun6i-rtc.h>
 #include <dt-bindings/clock/sun55i-a523-ccu.h>
+#include <dt-bindings/clock/sun55i-a523-mcu-ccu.h>
 #include <dt-bindings/clock/sun55i-a523-r-ccu.h>
 #include <dt-bindings/reset/sun55i-a523-ccu.h>
+#include <dt-bindings/reset/sun55i-a523-mcu-ccu.h>
 #include <dt-bindings/reset/sun55i-a523-r-ccu.h>
 #include <dt-bindings/power/allwinner,sun55i-a523-ppu.h>
 #include <dt-bindings/power/allwinner,sun55i-a523-pck-600.h>
@@ -825,6 +827,31 @@ rtc: rtc@7090000 {
 			clock-names = "bus", "hosc", "ahb";
 			#clock-cells = <1>;
 		};
+
+		mcu_ccu: clock-controller@7102000 {
+			compatible = "allwinner,sun55i-a523-mcu-ccu";
+			reg = <0x7102000 0x200>;
+			clocks = <&osc24M>,
+				 <&rtc CLK_OSC32K>,
+				 <&rtc CLK_IOSC>,
+				 <&ccu CLK_PLL_AUDIO0_4X>,
+				 <&ccu CLK_PLL_PERIPH0_300M>,
+				 <&ccu CLK_DSP>,
+				 <&ccu CLK_MBUS>,
+				 <&r_ccu CLK_R_AHB>,
+				 <&r_ccu CLK_R_APB0>;
+			clock-names = "hosc",
+				      "losc",
+				      "iosc",
+				      "pll-audio0-4x",
+				      "pll-periph0-300m",
+				      "dsp",
+				      "mbus",
+				      "r-ahb",
+				      "r-apb0";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 	};
 
 	thermal-zones {
-- 
2.39.5


