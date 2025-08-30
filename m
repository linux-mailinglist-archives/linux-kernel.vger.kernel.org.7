Return-Path: <linux-kernel+bounces-793078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D2DB3CDEB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F1591BA3762
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71B22D876B;
	Sat, 30 Aug 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5HIgdZo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACBE2D543E;
	Sat, 30 Aug 2025 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573762; cv=none; b=lWedJ0ABog/sYzSTPGfMZ6RKsEhEChEw15Z3+66ZyCpLM1+GyvLudpkwlp5lEiuuQPSJ4twEr/aFUkC0A0A7nn+7viVBCAAl70vqcAjC8J06gIUpWDm8SemDZixowUQUijtv2grd8GkpBEwzNJr6BcyCWTDMKch8cTaKRJnpo3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573762; c=relaxed/simple;
	bh=3EElTfctldD5Dqcdckanf0DB/BbI9/XMswzxMb6oj8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htSnXoBKczk04QAty8keJ1FzCnPEJI6qhlakCV4+Ki/mblbDrSRKvCQWNTQQzHdQBTdRM/RSQikczFmQ8r36G8S4LPCm0cvFZncgbPN6EeWRVY1JUtLdkCrW8pMmD2NJ5mQEc/+SGOK4x38hnN1ToYU2A7DXAdMIrbh9OnvsMhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5HIgdZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0542C4CEFB;
	Sat, 30 Aug 2025 17:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756573761;
	bh=3EElTfctldD5Dqcdckanf0DB/BbI9/XMswzxMb6oj8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J5HIgdZo7fUrIavRXEx4kKLTdmW8vPp6jyDArGG2ys1mr6zR78jA9pttUs+fqdaSD
	 T8EgKByOc1RUn7/IfHXBh7IR9rkIBeYVgNNQbJowLQFksA5CJ1VM1X4bO1bGvFvLeY
	 8HEMDLX3TxdrTK/jnBhf5UgSTdrVP1yyFIZvHFY4ak99ScG9sHbTs81PjFfRbGTRQg
	 BsjjVMwBC8Cw2vQBGC1Bna0kXP/qQv3GlW00U/PIb5g6JoVcr6IgwFu5/xz/zfonGx
	 WV/iFawQZNHaBEHI6k6PvKmS+fzgBihWb+i5uXOOqjEDtbXXKHNDFPl3xKBexwJpwF
	 eixc+hikrSxyw==
Received: by wens.tw (Postfix, from userid 1000)
	id 72A7E5FEDF; Sun, 31 Aug 2025 01:09:17 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-sunxi@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] arm64: dts: allwinner: a523: Add MCU PRCM CCU node
Date: Sun, 31 Aug 2025 01:09:00 +0800
Message-Id: <20250830170901.1996227-8-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250830170901.1996227-1-wens@kernel.org>
References: <20250830170901.1996227-1-wens@kernel.org>
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

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 79bd9ce08c7c..b6e82d53af54 100644
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
@@ -825,6 +827,29 @@ rtc: rtc@7090000 {
 			clock-names = "bus", "hosc", "ahb";
 			#clock-cells = <1>;
 		};
+
+		mcu_ccu: clock-controller@7102000 {
+			compatible = "allwinner,sun55i-a523-mcu-ccu";
+			reg = <0x7102000 0x164>;
+			clocks = <&osc24M>,
+				 <&rtc CLK_OSC32K>,
+				 <&rtc CLK_IOSC>,
+				 <&ccu CLK_PLL_AUDIO0_4X>,
+				 <&ccu CLK_PLL_PERIPH0_300M>,
+				 <&ccu CLK_DSP>,
+				 <&r_ccu CLK_R_AHB>,
+				 <&ccu CLK_MBUS>;
+			clock-names = "hosc",
+				      "losc",
+				      "iosc",
+				      "pll-audio0-4x",
+				      "pll-periph0-300m",
+				      "dsp",
+				      "r-ahb",
+				      "mbus";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 	};
 
 	thermal-zones {
-- 
2.39.5


