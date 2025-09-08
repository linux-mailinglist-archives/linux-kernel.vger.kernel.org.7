Return-Path: <linux-kernel+bounces-805180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD772B484FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73BB63C0D95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686042E5B1E;
	Mon,  8 Sep 2025 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdalncAM"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899C1CAA65;
	Mon,  8 Sep 2025 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316102; cv=none; b=K4QYr7bBqazU/YrDQIqp++KFrtVTFHZAdP503V/dlasbtGsVPqJjcO2ILsUcAvdD7fhct5pqe2TudC0GpWDxcyPrOST02Up3pRgTHemXlTmViTnL60wX5loNXn/SQIovry5LncgmrtfH9hND92+S6/0dV2kBZ1FjXKnD3BlvJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316102; c=relaxed/simple;
	bh=Xak1Cuq9EVFZC01eU03q61FejiUCiI7T4pcMfA4/wnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zv89VkuSSFcvDQ4ABo0rnnN/vFylajk+25cZHcCLbrIQrWtv6EwEtzMd4ZR7eWClKqRrMUN51BaDSsIzGqo88UJiaWVVBiEMy9tfbks+phWvn9TvKxQCyjPB82/nx44VdZetGgp5vIcbz4TB93TYTLYuIZ5iGIBQ4Vehb8yAbCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdalncAM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e2055ce973so2064969f8f.0;
        Mon, 08 Sep 2025 00:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757316099; x=1757920899; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8vGETqveoBt5cMEam5jsZwP+S/bgV2oFw9uuaDskBWE=;
        b=MdalncAMH/b1MzmRc9NcS6Johxwy48Eqepjuuf96mjVnKt8DtkRNRPL8Hy7kLc41fV
         YR8aa1OHvR0/iWDxPyvVxs3Y45htyHx4zuQFrj70Cq3ZcYXJu+hn6jbeNjVcX/KKR+yb
         y6iBEZtQfiwAEfSTKaP90PWw5Q6v49t6w1aShoH8GZ/LjHnClEILQ9WzgoaEa5jNcAkX
         Tl+pJiLBdJ+j4WxEz69BCCFBkNyPWKrNEYf1z5lob/swtiKrTtAMr+iQZNsFhvYE2zvx
         KYrb/h/c5vZmGvliJaSWNPG7/wnDLZzcbrwHtMH9nCZyQr89iTdhIiwitKpHry6nYWwN
         Vs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757316099; x=1757920899;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vGETqveoBt5cMEam5jsZwP+S/bgV2oFw9uuaDskBWE=;
        b=QP/rRFbNMGteX07NnkpPVDoj+Z0khE+/NeuSR0Kbv7dGYkcgRy+bbdfxfF4NnEGqU/
         MWJgDamOcjRDHpzXhuDcPzzw7Pv3ai8bDeV1qeBvlTLJCLLbvSundGVi3/DqA0HionBy
         JWGVJKj2U4S75iq7ddfY3TUN8hWxW37BfCmbjJ3GJYgpHg4HJ671OC7I1XPcdLRwSApG
         K76ZoE11+E38KfOJ0P2+WmFQuOmR/28pIpiZtqO27vVDu7Br7HJmV2KeNDssJX+4N6T6
         L+D5sQfv9qQ4XIpgr1Zz3sQccehThGbjjoVRLaFhrLYW3UmEpy1TADc9rmKlSG3KqQsb
         UB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwiJM1L/BZYMH44cCYFRIkVIu5Humf1Kf6yyjaa7q908NDncbjFjNIPZrERkQs6fHwUFSumRKsvu2S@vger.kernel.org, AJvYcCXcm/R3hnO6WS0wSUABFMHemBudspN2qXw/4KF5fdZeysQu3Sy6g/ZZFaxOijbTzYR48/vxt/kc5V5RjWOg@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIIbh5LYXvgR43dxYXmlAtEwkiDyuJDlJGe5ZLOMoJYe5J3m+
	DMGHx8vCoqVXKvMLaKix3Q/oUY8wM4vBVHpjDdyzsxDy68qjCmakXpsT
X-Gm-Gg: ASbGncsMx8hnEzdbAxY2XSPaCSgt0wGWOSW3jJ5WlTLwaWA0FhQ9o3vOK5Zg7w7cx7a
	BrYPbo8KK1p2f/RpobGv2/Jqrm3uRMalsNKozfEOY1nKBvFwdtgk+d7VMU90gymROnBqyZj5QOX
	2SXxBHq7cq0+jc+a3QCxXhHzP6gGmWxbcFNh/GG9vyX9jqUtnnIyPKn1hGHZnur7/LqettQCZ/C
	ITFonE1WcfVFwYlIP1hajgwLCZpKE/zUWNvFzIqctBCY6/FgspUEK5s0xUv1SXlPqpNvjUkja8t
	9NK+Lh2WzpbKd4Glc+7j2VPcCX9/NOT5NG2YmyG7/4pp+rSKRR7jKwOYZThAY+CR9N/6wO9F9zQ
	CzVBxIXwJuOEoPbV4PA9vVb/XRRQYZIbGto4=
X-Google-Smtp-Source: AGHT+IHHRvnjLjaP0w5j76MN8JSMdM4W9ZQKfUq+NI60zYTqiD7a5mNtTsbJQOEUbeQ7e6wq3tHcfg==
X-Received: by 2002:a05:6000:26d2:b0:3df:b9e7:35ba with SMTP id ffacd0b85a97d-3e6440f0674mr4452980f8f.57.1757316098881;
        Mon, 08 Sep 2025 00:21:38 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:2acd:89a8:83d9:4be5])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e21e4c0e6fsm13952247f8f.17.2025.09.08.00.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:21:38 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Mon, 08 Sep 2025 09:21:25 +0200
Subject: [PATCH] ARM: dts: sti: remove dangling stih407-clock file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-master-v1-1-98efab52f143@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPSDvmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwNz3dzE4pLUIt2kJEND0zTTJDPzxBQloOKCotS0zAqwQdGxtbUA90i
 DWlgAAAA=
X-Change-ID: 20250907-master-bb115f5b67ad
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5504; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=Xak1Cuq9EVFZC01eU03q61FejiUCiI7T4pcMfA4/wnI=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBovoP3xxOfavO5iVXwjoyBYGWLe0mSLtrJfqT9q
 vQI1AU2blKJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaL6D9wAKCRDnIYpo1BLC
 tX+LD/44ev/qY+hr+l2mbBLGFLqE1Nm4ebIao4amZ8Mmj8wYGMW3x25uQGKqRxe0r4rHpcIox+5
 bPHdDs2RZ8Ni46dS+9KkG94t31RZRzGdYKiZDKmce6Y9FIBBs56xw9pJSv/C+A+iE1HJXoNjJWY
 xOvv9Kth8hZlJ9zSfExbRYE25PEi8TcfnvSdCIF4NqYUWCqD0DVNll35vvlNjCwjUzGR3m7u8Po
 SyB9q8cHk+Ah1xkPYiFyWt3tRPRs2Ww7T+ByiD3HFvchDbUyr9vSpX8PSrJC74LxPb7ialJ7/Wp
 f8nMcK9jpXTDYxX7/t7NiiKAVI6WqgLIDaJ+n+NbACJ6B+pccvcC9V4EopvOQW4PKx/7kg8Qvvf
 ET8hztDfrnaWBCIet3xzzo/OqeIFOHFOhwTWJ7VWU1/y1LyMbTcmwnIp/h//oh5YHFoosRTWjDr
 lyISAGZZkm0cMmccpyqB/aGGJ30uiaU6hKQa00AVdiC30FOmnGz1nXewMpkyCssKIQhBjAVmB86
 UK/nwx1VT4kH292C8Ci9OpoGbYNdV6eQmIP+4sjN7C7mgSMGKgfuXTYSz/hu0812XHWaUejEBBr
 iQ/VGHcOVa5W8NFTjkz3SoMIbVfbhm+XW8j5LmWZn+Ml4T/m5g85qMIQ/enxFwHuY5eS1tvBfJM
 mDOr5TnExcThxpg==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

Following the removal of B2120 board support, the st/stih407-clock.dtsi
file has been left unused.  Remove it.

Fixes: dee546e1adef ("ARM: sti: drop B2120 board support")
Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 arch/arm/boot/dts/st/stih407-clock.dtsi | 210 --------------------------------
 1 file changed, 210 deletions(-)

diff --git a/arch/arm/boot/dts/st/stih407-clock.dtsi b/arch/arm/boot/dts/st/stih407-clock.dtsi
deleted file mode 100644
index 350bcfcf498bc410ebdb4fd00f2e1ea496a9c8be..0000000000000000000000000000000000000000
--- a/arch/arm/boot/dts/st/stih407-clock.dtsi
+++ /dev/null
@@ -1,210 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2014 STMicroelectronics R&D Limited
- */
-#include <dt-bindings/clock/stih407-clks.h>
-/ {
-	/*
-	 * Fixed 30MHz oscillator inputs to SoC
-	 */
-	clk_sysin: clk-sysin {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <30000000>;
-	};
-
-	clk_tmdsout_hdmi: clk-tmdsout-hdmi {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <0>;
-	};
-
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		/*
-		 * A9 PLL.
-		 */
-		clockgen-a9@92b0000 {
-			compatible = "st,clkgen-c32";
-			reg = <0x92b0000 0x10000>;
-
-			clockgen_a9_pll: clockgen-a9-pll {
-				#clock-cells = <1>;
-				compatible = "st,stih407-clkgen-plla9";
-
-				clocks = <&clk_sysin>;
-			};
-
-			clk_m_a9: clk-m-a9 {
-				#clock-cells = <0>;
-				compatible = "st,stih407-clkgen-a9-mux";
-
-				clocks = <&clockgen_a9_pll 0>,
-					 <&clockgen_a9_pll 0>,
-					 <&clk_s_c0_flexgen 13>,
-					 <&clk_m_a9_ext2f_div2>;
-
-				/*
-				 * ARM Peripheral clock for timers
-				 */
-				arm_periph_clk: clk-m-a9-periphs {
-					#clock-cells = <0>;
-					compatible = "fixed-factor-clock";
-
-					clocks = <&clk_m_a9>;
-					clock-div = <2>;
-					clock-mult = <1>;
-				};
-			};
-		};
-
-		clockgen-a@90ff000 {
-			compatible = "st,clkgen-c32";
-			reg = <0x90ff000 0x1000>;
-
-			clk_s_a0_pll: clk-s-a0-pll {
-				#clock-cells = <1>;
-				compatible = "st,clkgen-pll0-a0";
-
-				clocks = <&clk_sysin>;
-			};
-
-			clk_s_a0_flexgen: clk-s-a0-flexgen {
-				compatible = "st,flexgen", "st,flexgen-stih407-a0";
-
-				#clock-cells = <1>;
-
-				clocks = <&clk_s_a0_pll 0>,
-					 <&clk_sysin>;
-			};
-		};
-
-		clk_s_c0: clockgen-c@9103000 {
-			compatible = "st,clkgen-c32";
-			reg = <0x9103000 0x1000>;
-
-			clk_s_c0_pll0: clk-s-c0-pll0 {
-				#clock-cells = <1>;
-				compatible = "st,clkgen-pll0-c0";
-
-				clocks = <&clk_sysin>;
-			};
-
-			clk_s_c0_pll1: clk-s-c0-pll1 {
-				#clock-cells = <1>;
-				compatible = "st,clkgen-pll1-c0";
-
-				clocks = <&clk_sysin>;
-			};
-
-			clk_s_c0_quadfs: clk-s-c0-quadfs {
-				#clock-cells = <1>;
-				compatible = "st,quadfs-pll";
-
-				clocks = <&clk_sysin>;
-			};
-
-			clk_s_c0_flexgen: clk-s-c0-flexgen {
-				#clock-cells = <1>;
-				compatible = "st,flexgen", "st,flexgen-stih407-c0";
-
-				clocks = <&clk_s_c0_pll0 0>,
-					 <&clk_s_c0_pll1 0>,
-					 <&clk_s_c0_quadfs 0>,
-					 <&clk_s_c0_quadfs 1>,
-					 <&clk_s_c0_quadfs 2>,
-					 <&clk_s_c0_quadfs 3>,
-					 <&clk_sysin>;
-
-				/*
-				 * ARM Peripheral clock for timers
-				 */
-				clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
-					#clock-cells = <0>;
-					compatible = "fixed-factor-clock";
-
-					clocks = <&clk_s_c0_flexgen 13>;
-
-					clock-output-names = "clk-m-a9-ext2f-div2";
-
-					clock-div = <2>;
-					clock-mult = <1>;
-				};
-			};
-		};
-
-		clockgen-d0@9104000 {
-			compatible = "st,clkgen-c32";
-			reg = <0x9104000 0x1000>;
-
-			clk_s_d0_quadfs: clk-s-d0-quadfs {
-				#clock-cells = <1>;
-				compatible = "st,quadfs-d0";
-
-				clocks = <&clk_sysin>;
-			};
-
-			clk_s_d0_flexgen: clk-s-d0-flexgen {
-				#clock-cells = <1>;
-				compatible = "st,flexgen", "st,flexgen-stih407-d0";
-
-				clocks = <&clk_s_d0_quadfs 0>,
-					 <&clk_s_d0_quadfs 1>,
-					 <&clk_s_d0_quadfs 2>,
-					 <&clk_s_d0_quadfs 3>,
-					 <&clk_sysin>;
-			};
-		};
-
-		clockgen-d2@9106000 {
-			compatible = "st,clkgen-c32";
-			reg = <0x9106000 0x1000>;
-
-			clk_s_d2_quadfs: clk-s-d2-quadfs {
-				#clock-cells = <1>;
-				compatible = "st,quadfs-d2";
-
-				clocks = <&clk_sysin>;
-			};
-
-			clk_s_d2_flexgen: clk-s-d2-flexgen {
-				#clock-cells = <1>;
-				compatible = "st,flexgen", "st,flexgen-stih407-d2";
-
-				clocks = <&clk_s_d2_quadfs 0>,
-					 <&clk_s_d2_quadfs 1>,
-					 <&clk_s_d2_quadfs 2>,
-					 <&clk_s_d2_quadfs 3>,
-					 <&clk_sysin>,
-					 <&clk_sysin>,
-					 <&clk_tmdsout_hdmi>;
-			};
-		};
-
-		clockgen-d3@9107000 {
-			compatible = "st,clkgen-c32";
-			reg = <0x9107000 0x1000>;
-
-			clk_s_d3_quadfs: clk-s-d3-quadfs {
-				#clock-cells = <1>;
-				compatible = "st,quadfs-d3";
-
-				clocks = <&clk_sysin>;
-			};
-
-			clk_s_d3_flexgen: clk-s-d3-flexgen {
-				#clock-cells = <1>;
-				compatible = "st,flexgen", "st,flexgen-stih407-d3";
-
-				clocks = <&clk_s_d3_quadfs 0>,
-					 <&clk_s_d3_quadfs 1>,
-					 <&clk_s_d3_quadfs 2>,
-					 <&clk_s_d3_quadfs 3>,
-					 <&clk_sysin>;
-			};
-		};
-	};
-};

---
base-commit: be5d4872e528796df9d7425f2bd9b3893eb3a42c
change-id: 20250907-master-bb115f5b67ad

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>


