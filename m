Return-Path: <linux-kernel+bounces-771836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E781B28C0D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8042E5E0CBF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475162206BF;
	Sat, 16 Aug 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0bQ49J9"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3BE23AE95;
	Sat, 16 Aug 2025 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755334066; cv=none; b=AMk8N+TRR5zlpN7kOuKM1lFhrUavQKRnTGkibi9IqYq97xonk2a/L8w+V0shIFH76+InKs36AQh+PvLC/53gmy1hO0wBng6o9vkCLX4Cfz6y9pkKuJf7PrrEIGSrVRr8BsimRKtEucNy+kHNUNtsCRW3EYGMWyKl0m7hEOBC/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755334066; c=relaxed/simple;
	bh=feqnGZIaBW0Kxr7JtqcWFeJjTYfwwUCPcXNkynw7PPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqVu1cmmnK602jZz7IgkyNpcDRJ4jKevd8FGV0TUXGyRl9CcL/+i+n3Gsxq7s6p+PQSd4WYxdqGPy6GFlW0YkSjbkZNOzsYx7x2xLhzI03J4ew6hCQCBUUY76z/xssv0e/v4zT/pIvTQkqaK3mM1YYgEkhr8c0+rAKdWJxyf3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0bQ49J9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24456f3f669so27104645ad.1;
        Sat, 16 Aug 2025 01:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755334064; x=1755938864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzugRTjSEEA3vhHWZEvncDTD2t0Cnyv/9flgnww7Mso=;
        b=h0bQ49J9diWpRXHqxEfGdv2fQvojRLDIMAn/WVMHl6+qyeAy2NJOQ5vL5AhKNEZo6e
         DW0x87R5GogFwAvtPospNq1/6MBc14Wxo53AaxhKHraOtWx8+tXN6pc9BZimBq6oQKWJ
         qwuR3r7R3I/RAkMCafZXsu0XklPO33n90y8kk8WWVBQ9XsLPiQNm6pPX4IyErO22EKeP
         WS0ZQNkkKt3wq28VfzIkuudgYnLojSd9qqlRWHgs5OePpurxMDc8zDIRoiiW24stQxGy
         Wxes3thjNkQTSNmdisGvur9vxE3j+DsIa8PtGSV/GJAd6l6M6boxKTTpmwhe5EbusB1H
         o+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755334064; x=1755938864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzugRTjSEEA3vhHWZEvncDTD2t0Cnyv/9flgnww7Mso=;
        b=nSVNX+nhqQfqUhNyA3KoL9tJ7CQ64xlAwikzFwVnNOxWFGHSzCDVB0WuN8nlqSiQcH
         4/jwD6LTXKH3gkyo3ndvLp1XjElNFfpOsIAF8lygswer5iGmsBd5M6sR8jWgJFhH9Fw4
         OoLR2SMvHoghtXZDBv3ew2uJw6IsovztEo2uOcRSDaydcdOcXXf8JG+WIA5fUvtPunzY
         YINRbMYTsvl/Abw+3P+YJ0j+lxkWTEAlTNVEtWtkRnj+pTf+d6cym8GIeV8btqU7/UkA
         NW+wT1XKsRFK6EWsWGFJ3FBJZakxSL/kIah0f8WnvA0fAl2q3E7Z9LcfQh25OU5zwIN4
         I74w==
X-Forwarded-Encrypted: i=1; AJvYcCUqjl6PRIArES7Kpfd/A6TeWoV4jYyTEhIAOVErWiaRjR+AQgbyG2YjibdaJWHCgVZcK5kGIObxE61DOuO4@vger.kernel.org, AJvYcCXcq2/mqMQTbfKuC/wSy+u0Dua2SWswZbeFqWnBJn393JbkReYmCP+SdNyhXCcg3wJpyUfOH+79EEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3h7d+qKhAVo0QfXTyNixggUx70mXOTFfBR4y1hHWAj7wXVgoJ
	xJ4r8ofqgUgUZDS+hXKyhZPTriENYmkLiN15gnH282uVFJnhurRSUhlP
X-Gm-Gg: ASbGnctj81Ld4/KpkAQp2xALJDqm1Ynqfcj8nWjkpYpzKQZrUiq34OSaj512u1OXFDd
	btgDxI8zXy1vUQFkHBYnEeZpq4JDDgE49T8W1TDkZtaqJRRkRecZDr7DVvn6s80YGet9BcMiGwM
	Is06PVcGLr5kvYtatW6IEfABxloliLoYqBnjlKYkTzeBM3+g296HJrgNcNVqVoVpO0b9u/Q6I9l
	nRVwqZ2FyNukhAA+9vV+GqE5A1vNClcAsAmH9xk3JeAk2iO57MY/s6xjz13A7aAMU1uI+DngM0X
	BAhYO142G8mt/+t9SRYELEQ/fW56KPRu42YjWwKIvA56Ti1rogmAPBH0T9V3sNbWH1QOz1U1LXp
	Bqt5bBjw79kQ=
X-Google-Smtp-Source: AGHT+IGC/f9ctRQyGd8OhPgk/EDa/XtCGcODk7HhjJFFgAw+CxRy4DpFueYRqcfy/Uow1U/CzbWKQQ==
X-Received: by 2002:a17:902:d4d0:b0:240:6fc0:3421 with SMTP id d9443c01a7336-2446bce444fmr73487325ad.3.1755334064339;
        Sat, 16 Aug 2025 01:47:44 -0700 (PDT)
Received: from junAIR ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm31048215ad.157.2025.08.16.01.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 01:47:43 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 2/7] arm64: dts: allwinner: a523: add third usb2 phy
Date: Sat, 16 Aug 2025 16:46:55 +0800
Message-ID: <20250816084700.569524-3-iuncuim@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816084700.569524-1-iuncuim@gmail.com>
References: <20250816084700.569524-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

It seems that there are actually three usb2 phys in the processor, which
makes it incompatible with D1.
The third phy is used together with USB3/PCIe combophy with DWC3
controller. In the BSP code, the third PHY requires a separate glue
driver, but it seems that it is not needed.
According to the BSP code, the third phy does not have a reset line; the
only reset is declared in the DWC3 node, but none of this is documented.
Since sun4i-usb-phy driver requires a reset, I added RST_BUS_3 here.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
index 6b6f2296b..e4ed4fa82 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
@@ -503,22 +503,27 @@ usb_otg: usb@4100000 {
 		};
 
 		usbphy: phy@4100400 {
-			compatible = "allwinner,sun55i-a523-usb-phy",
-				     "allwinner,sun20i-d1-usb-phy";
+			compatible = "allwinner,sun55i-a523-usb-phy";
 			reg = <0x4100400 0x100>,
 			      <0x4101800 0x100>,
-			      <0x4200800 0x100>;
+			      <0x4200800 0x100>,
+				  <0x4e00000 0x100>;
 			reg-names = "phy_ctrl",
 				    "pmu0",
-				    "pmu1";
+				    "pmu1",
+					"pmu2";
 			clocks = <&osc24M>,
-				 <&osc24M>;
+				 <&osc24M>,
+				 <&ccu CLK_USB2>;
 			clock-names = "usb0_phy",
-				      "usb1_phy";
+				      "usb1_phy",
+					  "usb2_phy";
 			resets = <&ccu RST_USB_PHY0>,
-				 <&ccu RST_USB_PHY1>;
+				 <&ccu RST_USB_PHY1>,
+				 <&ccu RST_BUS_3>;
 			reset-names = "usb0_reset",
-				      "usb1_reset";
+				      "usb1_reset",
+					  "usb2_reset";
 			status = "disabled";
 			#phy-cells = <1>;
 		};
-- 
2.50.1


