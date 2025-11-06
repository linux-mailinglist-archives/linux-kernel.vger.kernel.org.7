Return-Path: <linux-kernel+bounces-888046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CDEC39ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D32D4F46CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231F23093C9;
	Thu,  6 Nov 2025 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="RCCrVAXs"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED840305044;
	Thu,  6 Nov 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419281; cv=none; b=aYCcQijYoRxcSuF+nS2nY22b6erABK+BFk/BJLvcUhjNqiMrTgqY2Uf1PSxBhLr257IhJ4w1AR8IGufXHXhWx7aYPzHsLbeLRkAbreHZJNWoqNDyPgRzGyGqF4nUmAQ+3NwiYhcCivMsjSMeqASuOjha+m1sP2j+Je0bLOlXyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419281; c=relaxed/simple;
	bh=52Jbx77qx5qHac0X+nosmXiiY8Z3RnLgLjZ4/YwILqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXxu8lqwIM1HR5oR2P2P+XWX0MkRXNrb+e6W4RhmewVoSiaPlNuqEUOZ5/IO3623I8DaC/n3P2X0d08xk2/pIK4LftC6d5nvfDxrSQQXZMk5+mBzwkH9WFPbULlYeilXdM8zVzr6P3MXx2mZ83d+XYUXFWmBBt+bPH4DvDVKo3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=RCCrVAXs; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1762419278;
	bh=ps9vapSiAzSq7ACg34jfzO+hmVnf1lnwCkq+2yxADxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCCrVAXsfNWWNFeUTsJakZslb2RIyjlHueShOvolNDa1nC9IMyK4QQEj4a9M8JifO
	 tAT74X+npT5u1WlYz/CqthNGAVkYYvBlm7i2zbuyrQURGfWNwJ6wHYi1DZktN6zGs/
	 nN0lfgeFbXMV/MdnPWbVNDphXaBjydKscAfNkxw4=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id 11537A0534;
	Thu,  6 Nov 2025 09:54:38 +0100 (CET)
From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v2 2/2] ARM: dts: imx6dl-yapp4: Model the RGB LED as a single multi-led part
Date: Thu,  6 Nov 2025 09:54:29 +0100
Message-ID: <20251106085429.2067699-2-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106085429.2067699-1-michal.vokac@ysoft.com>
References: <20251106085429.2067699-1-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Describe the RGB LED indicator according to the reality - it is a single
part containing all the three R,G and B LEDs in one package.
With this description the chan-name property becomes useless, remove it.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
changes in v2: Removed reference to internal issue tracker from commit message.

 .../boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi | 44 ++++++++++---------
 .../dts/nxp/imx/imx6dl-yapp43-common.dtsi     | 44 ++++++++++---------
 2 files changed, 48 insertions(+), 40 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
index 8bc6376d0dc1..4a5736526927 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
@@ -279,28 +279,32 @@ leds: led-controller@30 {
 		#size-cells = <0>;
 		status = "disabled";
 
-		led@0 {
-			chan-name = "R";
-			led-cur = /bits/ 8 <0x20>;
-			max-cur = /bits/ 8 <0x60>;
-			reg = <0>;
-			color = <LED_COLOR_ID_RED>;
-		};
+		multi-led@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			color = <LED_COLOR_ID_RGB>;
+			function = LED_FUNCTION_INDICATOR;
+
+			led@0 {
+				led-cur = /bits/ 8 <0x20>;
+				max-cur = /bits/ 8 <0x60>;
+				reg = <0>;
+				color = <LED_COLOR_ID_RED>;
+			};
 
-		led@1 {
-			chan-name = "G";
-			led-cur = /bits/ 8 <0x20>;
-			max-cur = /bits/ 8 <0x60>;
-			reg = <1>;
-			color = <LED_COLOR_ID_GREEN>;
-		};
+			led@1 {
+				led-cur = /bits/ 8 <0x20>;
+				max-cur = /bits/ 8 <0x60>;
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+			};
 
-		led@2 {
-			chan-name = "B";
-			led-cur = /bits/ 8 <0x20>;
-			max-cur = /bits/ 8 <0x60>;
-			reg = <2>;
-			color = <LED_COLOR_ID_BLUE>;
+			led@2 {
+				led-cur = /bits/ 8 <0x20>;
+				max-cur = /bits/ 8 <0x60>;
+				reg = <2>;
+				color = <LED_COLOR_ID_BLUE>;
+			};
 		};
 	};
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi
index 6f9bd163ffbe..6e49e1ccf6fc 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp43-common.dtsi
@@ -278,28 +278,32 @@ leds: led-controller@30 {
 		#size-cells = <0>;
 		status = "disabled";
 
-		led@0 {
-			chan-name = "R";
-			led-cur = /bits/ 8 <0x6e>;
-			max-cur = /bits/ 8 <0xc8>;
-			reg = <0>;
-			color = <LED_COLOR_ID_RED>;
-		};
+		multi-led@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			color = <LED_COLOR_ID_RGB>;
+			function = LED_FUNCTION_INDICATOR;
+
+			led@0 {
+				led-cur = /bits/ 8 <0x6e>;
+				max-cur = /bits/ 8 <0xc8>;
+				reg = <0>;
+				color = <LED_COLOR_ID_RED>;
+			};
 
-		led@1 {
-			chan-name = "G";
-			led-cur = /bits/ 8 <0xbe>;
-			max-cur = /bits/ 8 <0xc8>;
-			reg = <1>;
-			color = <LED_COLOR_ID_GREEN>;
-		};
+			led@1 {
+				led-cur = /bits/ 8 <0xbe>;
+				max-cur = /bits/ 8 <0xc8>;
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+			};
 
-		led@2 {
-			chan-name = "B";
-			led-cur = /bits/ 8 <0xbe>;
-			max-cur = /bits/ 8 <0xc8>;
-			reg = <2>;
-			color = <LED_COLOR_ID_BLUE>;
+			led@2 {
+				led-cur = /bits/ 8 <0xbe>;
+				max-cur = /bits/ 8 <0xc8>;
+				reg = <2>;
+				color = <LED_COLOR_ID_BLUE>;
+			};
 		};
 	};
 
-- 
2.43.0


