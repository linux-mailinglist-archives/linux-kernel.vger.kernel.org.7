Return-Path: <linux-kernel+bounces-886759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6EBC36768
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EF2F505B95
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0F4314B6B;
	Wed,  5 Nov 2025 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="M+bB92fH"
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53742D46DB;
	Wed,  5 Nov 2025 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.3.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356946; cv=none; b=h9BBZpS2gB9XJ5RUPfC7MBRT54q/9WJEBCp57k0oGmltagP4wK00IruIcQCxiDctXrG/OGotKBpAgeRP+J9wLvle1hGk4j/3zbAjd3UdYYnVJrOGEUiGXZ0t7kTIU8xHS1VUvrgLt+mW6NAiutTHzbdOM9LHCPDqCRnhqqw8dq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356946; c=relaxed/simple;
	bh=AHMxABvZnlpYTNFvSrA6D7GexRGotM5oB2fFzJuuqBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWjx+CzkJjGcMWIleaPTX4gYy19tmoixdUR0KhjdRXcpgn6b/sUIzShI1uocCz7IEQlGXngwPJdfwgn1jhioaUZ5ZZRTFBHl1CTmubj54c2eGuMXFg4IqEUyOxcI7Xy4DzSaU33gfqMCUZjLIUDzfBKXd7vs8exXy98t+IdvvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com; spf=pass smtp.mailfrom=ysoft.com; dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b=M+bB92fH; arc=none smtp.client-ip=81.19.3.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ysoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ysoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
	s=20160406-ysoft-com; t=1762356410;
	bh=8WXhsTsO/J0Z7EVRJucBcIkmUQ6VEPYVZ7BqTfVRhGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+bB92fHU8kMUn3S3+k3cqJQ28dRjbyvz9BrECwQ6yLD97LUCVknqKgGCtMTP5ZHD
	 oDLcq724qv0E4FgT+yPXOw4MXQ8XOznFYpvSB+mcAtBjIbImMyxk4X/sYzeRHJOLDF
	 SJOzer5LLVWrlWfpqKU2GblpCiG83kOSjinDhjPk=
Received: from vokac-nb.ysoft.local (unknown [10.1.8.111])
	by uho.ysoft.cz (Postfix) with ESMTP id A78BCA03C4;
	Wed,  5 Nov 2025 16:26:50 +0100 (CET)
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
Subject: [PATCH 2/2] ARM: dts: imx6dl-yapp4: Model the RGB LED as a single multi-led part
Date: Wed,  5 Nov 2025 16:25:54 +0100
Message-ID: <20251105152555.1992513-2-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105152555.1992513-1-michal.vokac@ysoft.com>
References: <20251105152555.1992513-1-michal.vokac@ysoft.com>
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

issue: HWOS-816

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
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


