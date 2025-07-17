Return-Path: <linux-kernel+bounces-735869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 489A4B094C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE60587070
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DC92FF480;
	Thu, 17 Jul 2025 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6NyQ04/"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B52FE31C;
	Thu, 17 Jul 2025 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779809; cv=none; b=DytO8M6BwssLicQRQ3021JMuxBV+gWIk9lzJwn02DVWBUFvSI17grahLs4mtSH5DHN8D+Fo0OmbEpN10R9i+5TmTLFCE1LfbTcY+hhYMXWXPFmlGgQ7sMG2Bi73EnGo8hZo7a5x5YPFQvEU7ox5xkRq3dDVSfZoyrZTMxwjbyCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779809; c=relaxed/simple;
	bh=Wiu/65e3susvS7JkHh1yHaahU+pjFzGTsPfFYQByFWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gd0Xxk3xRWXbJhvTFJ0YK77SDRJNvj1fhB2PCzwKjuWF6vn1wqfRI67XuOg8f4VE+dzC/eTBNJ7Q/GwRPZlqcQVqOh4OQFOxumMN5nJMvz7l4HDZS/hCebNg7DvcVFnms3duhD3ayy/E7h9w9beGUQFTxgPjrSAhPCREzl6LDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6NyQ04/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so945005f8f.2;
        Thu, 17 Jul 2025 12:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752779805; x=1753384605; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7wZY4iMw3S+iyFocZDdAUMBd6mAxDCSWG7psuC77bY=;
        b=J6NyQ04/GOBukpVlgL6I3dUOBV17Om0WvxiDrpnLNNzYQHO2hYV3dJGdNCmEP+UAiR
         1k5HzY/0IfIXAwY56HD2biyqNeY5OzfjinAb1nt0Ymkj/MUV6w7FUYe+xLTShefD3O/I
         ff3MWLldUSAjM57NXLtV7V/W5zz18IOBL2m4Cs+06Kfuj/UBbMEcVkQQCTBA/FOnUAz9
         cFvNPr/00LtakcvBfCXrXsa4DuUkFWLW+OZAbtYdpQevPOhgEBVD120QpKjBgCq7XGG8
         s0ZFrTDM803jtBs37FbyhxXLSaltyxmQ6uVOxr1s+SW+NsWwPCaRm1hFYmYLe18qpHlJ
         Sr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752779805; x=1753384605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7wZY4iMw3S+iyFocZDdAUMBd6mAxDCSWG7psuC77bY=;
        b=thXrbQFlgktlDtaUva2RdPKJ8ulX+9HBK/8iNGTFUYft0Yuv2wjFlIl7pKzby9w0gZ
         4zNLFJKSc3Y6BHKNXZaQjFneB1gK9YFf48HvnKoKKrJXmD/GHIypqv221LWd1S7PABnw
         53LBAmeCg0Ra346HCd1Ytmo8+WgTnxS2elm0+qCVERVtaLZGM7WykaI1lDKkAGIB3mmY
         FxzlGQwrZAVVWk393Fcq539V9IXzJ50Q5kvRsN2c7p83FNXhRik60qudNvq8zXkATjp7
         CPWnnf/jvIPAV3N7OO/C37W+2NKkbUc7+ULXjdWZ9SqQzyCTGQ8g9SUt2JirAu1tNuLx
         nGWg==
X-Forwarded-Encrypted: i=1; AJvYcCVowm5fmkHEr9jC8svz4iSZNkphrV9we1ipeI+M0CFRu62cu8n73NKV8VMgGpI4wC1J/eiCeLS9UR1SFVSC@vger.kernel.org, AJvYcCXfXkb0rMLHXFg73D2ZsZOrWN7y86HlR7NEUFkEOkTLo6jvjlKgOayKUhF/V0cChCgb4YC+9jdMNj+O@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9VpfJ99qIdlp4NYxSKnP6PFxH3HNGDuwpUbSMeXh+l0KPuS4/
	MlAvvXvsf0vPfbHGVpRGADduaMGQT8LJ+xhCIt0lwMD3SohzOZAaGmok
X-Gm-Gg: ASbGncuZgTh6EwrSYZXCJGlyA4gqM4WxXx/EKBXgdERZwWLRhuAkHe6Nco60aCZiEzd
	S6d4h5lSuVP/bCG5HG3BfzuDorVLpcetC+8GMpeC0J0wI/GK2BDCTCcwEFbavTsE6Nf/aKrr/yF
	Huk5ks6Mbib7Qls9PCaeblOayyySOfWETHW7FbAqsaDYBDO0tSaFLy2KaRcuNbqcAJSJyPfAbe+
	sMzGFfc6FLPljaJXhWucIH+QtnZrB8FSgEr9e2HwaULXTH+VcNzIjaTgDyQTl2RR+OQjs06oTlX
	0r2HQfZCrp7OZ6fp0Nvn/0RS44l9KdufKpuSbGxwnonIhYAnH+0YCuWF727bt80dbICjhs3KAWi
	xXv5tmKzQU6gGa9jgH+xr7Q==
X-Google-Smtp-Source: AGHT+IEaWpyAkfNY16SIAQ5Qr8spUGP8XPUVtJlDTbDMPM28VEWzZoDlp033KO7PNx6qhV2Hd7fPBw==
X-Received: by 2002:a05:6000:310d:b0:3b6:c6b:e4e6 with SMTP id ffacd0b85a97d-3b60e4be9b2mr6714332f8f.11.1752779805329;
        Thu, 17 Jul 2025 12:16:45 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4562e89c739sm58164615e9.32.2025.07.17.12.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 12:16:45 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Thu, 17 Jul 2025 21:15:34 +0200
Subject: [PATCH 3/4] ARM: dts: sti: extract display subsystem out of soc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-sti-rework-v1-3-46d516fb1ebb@gmail.com>
References: <20250717-sti-rework-v1-0-46d516fb1ebb@gmail.com>
In-Reply-To: <20250717-sti-rework-v1-0-46d516fb1ebb@gmail.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10843;
 i=rgallaispou@gmail.com; h=from:subject:message-id;
 bh=Wiu/65e3susvS7JkHh1yHaahU+pjFzGTsPfFYQByFWw=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBoeUwYzf7hOYj6ppQRFLV+8X9OCA8WzrVH8DOrN
 W6WahlUEF6JAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaHlMGAAKCRDnIYpo1BLC
 tcp0D/9PM8j3Fqnq+WEeu2zRJNkflTpxsxy4Sh2KeHUoi/zsiPwxJd7hwjSmrzukOsSsbG7hth2
 23QhQpBXKwUApvtodc82b2/9FPWCTa6n5RUcUcFCFeO6jZowQg7uFozKaMSSGs6xCsQsfKrkJY6
 RPqZnZVRREpZg102KGOslpvBK0KPFxPVKufcIn6ep8NmX1XOMigkdkqW116bryrfUsaEmobOfju
 c69yF/JU0Xhf8kdCOVUVD5u0v1wOeQqwR5HHOcfQZdATU+6LoOIP1cKRP/qeDbi7cSOBm5V8ncb
 TKVHginXdiuldgvg9rsH3QWZvNEymY4fQMcuyh7cPa9S1f4etGuac45Pzo0oWElxSCQOg13muio
 2fJNY3qOBTaWxQITe8hWNUpIP5x455YuFIe/NYutGHY1HD/eazIY6aLtgTp9OtmtEmqX4daF6nO
 7tyJHhzzmxngNGoO9LIgLD1czx0Kq20S52hwwI1tzMfEgW0dWfFHRIh1EJcK76B+f2de62YkaQ8
 bPwf2hsZrbljJqHOLKp5OdH2bvyrwUlwCAH2xqiM+n0Ayqn/BVmSmOUUWOyq6pvEHiQXfu58ctK
 4tmXrxwDws3pbIrjD85aVA154ZnT6/Gi0bu99ciLCpHcMhOQbvyC9xQBR6m18ZWaSv/n/wfMiDr
 8jBo4Yt8YeOLYww==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

The display subsystem represent how IPs are interacting together and
have nothing to do within the SoC node.

Extract it from the SoC node and let IPs nodes in the Soc node.

Several nodes did not use conventional name:
 * sti-display-subsystem -> display-subsystem
 * sti-controller -> display-controller
 * sti-tvout -> encoder
 * sti-hda -> analog
 * sti-hqvdp -> plane

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 arch/arm/boot/dts/st/stih410.dtsi | 316 +++++++++++++++++++++++---------------
 1 file changed, 188 insertions(+), 128 deletions(-)

diff --git a/arch/arm/boot/dts/st/stih410.dtsi b/arch/arm/boot/dts/st/stih410.dtsi
index d56343f44fda4e9e1de2e5efc86e2d984bad14b4..47d66d7eb07a3d73d98b3e21d62b2253aa1171e4 100644
--- a/arch/arm/boot/dts/st/stih410.dtsi
+++ b/arch/arm/boot/dts/st/stih410.dtsi
@@ -34,6 +34,41 @@ usb2_picophy2: phy3 {
 		status = "disabled";
 	};
 
+	display-subsystem {
+		compatible = "st,sti-display-subsystem";
+		ports = <&compositor>, <&hqvdp>, <&tvout>, <&sti_hdmi>;
+
+		assigned-clocks = <&clk_s_d2_quadfs 0>,
+				  <&clk_s_d2_quadfs 1>,
+				  <&clk_s_c0_pll1 0>,
+				  <&clk_s_c0_flexgen CLK_COMPO_DVP>,
+				  <&clk_s_c0_flexgen CLK_MAIN_DISP>,
+				  <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>,
+				  <&clk_s_d2_flexgen CLK_PIX_AUX_DISP>,
+				  <&clk_s_d2_flexgen CLK_PIX_GDP1>,
+				  <&clk_s_d2_flexgen CLK_PIX_GDP2>,
+				  <&clk_s_d2_flexgen CLK_PIX_GDP3>,
+				  <&clk_s_d2_flexgen CLK_PIX_GDP4>;
+
+		assigned-clock-parents = <0>,
+					 <0>,
+					 <0>,
+					 <&clk_s_c0_pll1 0>,
+					 <&clk_s_c0_pll1 0>,
+					 <&clk_s_d2_quadfs 0>,
+					 <&clk_s_d2_quadfs 1>,
+					 <&clk_s_d2_quadfs 0>,
+					 <&clk_s_d2_quadfs 0>,
+					 <&clk_s_d2_quadfs 0>,
+					 <&clk_s_d2_quadfs 0>;
+
+		assigned-clock-rates = <297000000>,
+				       <297000000>,
+				       <0>,
+				       <400000000>,
+				       <400000000>;
+	};
+
 	soc {
 		ohci0: usb@9a03c00 {
 			compatible = "st,st-ohci-300x";
@@ -99,153 +134,178 @@ ehci1: usb@9a83e00 {
 			status = "disabled";
 		};
 
-		sti-display-subsystem@0 {
-			compatible = "st,sti-display-subsystem";
+		compositor: display-controller@9d11000 {
+			compatible = "st,stih407-compositor";
+			reg = <0x9d11000 0x1000>;
+
+			clock-names = "compo_main",
+				      "compo_aux",
+				      "pix_main",
+				      "pix_aux",
+				      "pix_gdp1",
+				      "pix_gdp2",
+				      "pix_gdp3",
+				      "pix_gdp4",
+				      "main_parent",
+				      "aux_parent";
+
+			clocks = <&clk_s_c0_flexgen CLK_COMPO_DVP>,
+				 <&clk_s_c0_flexgen CLK_COMPO_DVP>,
+				 <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>,
+				 <&clk_s_d2_flexgen CLK_PIX_AUX_DISP>,
+				 <&clk_s_d2_flexgen CLK_PIX_GDP1>,
+				 <&clk_s_d2_flexgen CLK_PIX_GDP2>,
+				 <&clk_s_d2_flexgen CLK_PIX_GDP3>,
+				 <&clk_s_d2_flexgen CLK_PIX_GDP4>,
+				 <&clk_s_d2_quadfs 0>,
+				 <&clk_s_d2_quadfs 1>;
+
+			reset-names = "compo-main", "compo-aux";
+			resets = <&softreset STIH407_COMPO_SOFTRESET>,
+				 <&softreset STIH407_COMPO_SOFTRESET>;
+			st,vtg = <&vtg_main>, <&vtg_aux>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					compo_main_out: endpoint {
+						remote-endpoint = <&tvout_in0>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					compo_aux_out: endpoint {
+						remote-endpoint = <&tvout_in1>;
+					};
+				};
+			};
+		};
+
+		tvout: encoder@8d08000 {
+			compatible = "st,stih407-tvout";
+			reg = <0x8d08000 0x1000>;
+			reg-names = "tvout-reg";
+			reset-names = "tvout";
+			resets = <&softreset STIH407_HDTVOUT_SOFTRESET>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			assigned-clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
+					  <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
+					  <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
+					  <&clk_s_d0_flexgen CLK_PCM_0>,
+					  <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
+					  <&clk_s_d2_flexgen CLK_HDDAC>;
 
-			reg = <0 0>;
-			assigned-clocks = <&clk_s_d2_quadfs 0>,
-					  <&clk_s_d2_quadfs 1>,
-					  <&clk_s_c0_pll1 0>,
-					  <&clk_s_c0_flexgen CLK_COMPO_DVP>,
-					  <&clk_s_c0_flexgen CLK_MAIN_DISP>,
-					  <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>,
-					  <&clk_s_d2_flexgen CLK_PIX_AUX_DISP>,
-					  <&clk_s_d2_flexgen CLK_PIX_GDP1>,
-					  <&clk_s_d2_flexgen CLK_PIX_GDP2>,
-					  <&clk_s_d2_flexgen CLK_PIX_GDP3>,
-					  <&clk_s_d2_flexgen CLK_PIX_GDP4>;
-
-			assigned-clock-parents = <0>,
-						 <0>,
-						 <0>,
-						 <&clk_s_c0_pll1 0>,
-						 <&clk_s_c0_pll1 0>,
-						 <&clk_s_d2_quadfs 0>,
-						 <&clk_s_d2_quadfs 1>,
-						 <&clk_s_d2_quadfs 0>,
+			assigned-clock-parents = <&clk_s_d2_quadfs 0>,
+						 <&clk_tmdsout_hdmi>,
 						 <&clk_s_d2_quadfs 0>,
+						 <&clk_s_d0_quadfs 0>,
 						 <&clk_s_d2_quadfs 0>,
 						 <&clk_s_d2_quadfs 0>;
 
-			assigned-clock-rates = <297000000>,
-					       <297000000>,
-					       <0>,
-					       <400000000>,
-					       <400000000>;
-
-			ranges;
-
-			sti-compositor@9d11000 {
-				compatible = "st,stih407-compositor";
-				reg = <0x9d11000 0x1000>;
-
-				clock-names = "compo_main",
-					      "compo_aux",
-					      "pix_main",
-					      "pix_aux",
-					      "pix_gdp1",
-					      "pix_gdp2",
-					      "pix_gdp3",
-					      "pix_gdp4",
-					      "main_parent",
-					      "aux_parent";
-
-				clocks = <&clk_s_c0_flexgen CLK_COMPO_DVP>,
-					 <&clk_s_c0_flexgen CLK_COMPO_DVP>,
-					 <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>,
-					 <&clk_s_d2_flexgen CLK_PIX_AUX_DISP>,
-					 <&clk_s_d2_flexgen CLK_PIX_GDP1>,
-					 <&clk_s_d2_flexgen CLK_PIX_GDP2>,
-					 <&clk_s_d2_flexgen CLK_PIX_GDP3>,
-					 <&clk_s_d2_flexgen CLK_PIX_GDP4>,
-					 <&clk_s_d2_quadfs 0>,
-					 <&clk_s_d2_quadfs 1>;
-
-				reset-names = "compo-main", "compo-aux";
-				resets = <&softreset STIH407_COMPO_SOFTRESET>,
-					 <&softreset STIH407_COMPO_SOFTRESET>;
-				st,vtg = <&vtg_main>, <&vtg_aux>;
-			};
-
-			sti-tvout@8d08000 {
-				compatible = "st,stih407-tvout";
-				reg = <0x8d08000 0x1000>;
-				reg-names = "tvout-reg";
-				reset-names = "tvout";
-				resets = <&softreset STIH407_HDTVOUT_SOFTRESET>;
+			ports {
 				#address-cells = <1>;
-				#size-cells = <1>;
-				assigned-clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
-						  <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
-						  <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
-						  <&clk_s_d0_flexgen CLK_PCM_0>,
-						  <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
-						  <&clk_s_d2_flexgen CLK_HDDAC>;
+				#size-cells = <0>;
 
-				assigned-clock-parents = <&clk_s_d2_quadfs 0>,
-							 <&clk_tmdsout_hdmi>,
-							 <&clk_s_d2_quadfs 0>,
-							 <&clk_s_d0_quadfs 0>,
-							 <&clk_s_d2_quadfs 0>,
-							 <&clk_s_d2_quadfs 0>;
+				port@0 {
+					reg = <0>;
+					tvout_in0: endpoint {
+						remote-endpoint = <&compo_main_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					tvout_in1: endpoint {
+						remote-endpoint = <&compo_aux_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					tvout_out0: endpoint {
+						remote-endpoint = <&hdmi_in>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					tvout_out1: endpoint {
+						remote-endpoint = <&hda_in>;
+					};
+				};
 			};
+		};
 
-			sti_hdmi: sti-hdmi@8d04000 {
-				compatible = "st,stih407-hdmi";
-				reg = <0x8d04000 0x1000>;
-				reg-names = "hdmi-reg";
-				#sound-dai-cells = <0>;
-				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "irq";
-				clock-names = "pix",
-					      "tmds",
-					      "phy",
-					      "audio",
-					      "main_parent",
-					      "aux_parent";
+		sti_hdmi: hdmi@8d04000 {
+			compatible = "st,stih407-hdmi";
+			reg = <0x8d04000 0x1000>;
+			reg-names = "hdmi-reg";
+			#sound-dai-cells = <0>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "irq";
+			clock-names = "pix",
+				      "tmds",
+				      "phy",
+				      "audio",
+				      "main_parent",
+				      "aux_parent";
 
-				clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
-					 <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
-					 <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
-					 <&clk_s_d0_flexgen CLK_PCM_0>,
-					 <&clk_s_d2_quadfs 0>,
-					 <&clk_s_d2_quadfs 1>;
+			clocks = <&clk_s_d2_flexgen CLK_PIX_HDMI>,
+				 <&clk_s_d2_flexgen CLK_TMDS_HDMI>,
+				 <&clk_s_d2_flexgen CLK_REF_HDMIPHY>,
+				 <&clk_s_d0_flexgen CLK_PCM_0>,
+				 <&clk_s_d2_quadfs 0>,
+				 <&clk_s_d2_quadfs 1>;
 
-				hdmi,hpd-gpio = <&pio5 3 GPIO_ACTIVE_LOW>;
-				reset-names = "hdmi";
-				resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
-				ddc = <&hdmiddc>;
+			hdmi,hpd-gpio = <&pio5 3 GPIO_ACTIVE_LOW>;
+			reset-names = "hdmi";
+			resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
+			ddc = <&hdmiddc>;
+
+			port {
+				hdmi_in: endpoint {
+					remote-endpoint = <&tvout_out0>;
+				};
 			};
+		};
 
-			sti-hda@8d02000 {
-				compatible = "st,stih407-hda";
-				status = "disabled";
-				reg = <0x8d02000 0x400>, <0x92b0120 0x4>;
-				reg-names = "hda-reg", "video-dacs-ctrl";
-				clock-names = "pix",
-					      "hddac",
-					      "main_parent",
-					      "aux_parent";
-				clocks = <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
-					 <&clk_s_d2_flexgen CLK_HDDAC>,
-					 <&clk_s_d2_quadfs 0>,
-					 <&clk_s_d2_quadfs 1>;
-			};
+		analog@8d02000 {
+			compatible = "st,stih407-hda";
+			status = "disabled";
+			reg = <0x8d02000 0x400>, <0x92b0120 0x4>;
+			reg-names = "hda-reg", "video-dacs-ctrl";
+			clock-names = "pix",
+				      "hddac",
+				      "main_parent",
+				      "aux_parent";
+			clocks = <&clk_s_d2_flexgen CLK_PIX_HDDAC>,
+				 <&clk_s_d2_flexgen CLK_HDDAC>,
+				 <&clk_s_d2_quadfs 0>,
+				 <&clk_s_d2_quadfs 1>;
 
-			sti-hqvdp@9c00000 {
-				compatible = "st,stih407-hqvdp";
-				reg = <0x9C00000 0x100000>;
-				clock-names = "hqvdp", "pix_main";
-				clocks = <&clk_s_c0_flexgen CLK_MAIN_DISP>,
-					 <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>;
-				reset-names = "hqvdp";
-				resets = <&softreset STIH407_HDQVDP_SOFTRESET>;
-				st,vtg = <&vtg_main>;
+			port {
+				hda_in: endpoint {
+					remote-endpoint = <&tvout_out1>;
+				};
 			};
 		};
 
+		hqvdp: plane@9c00000 {
+			compatible = "st,stih407-hqvdp";
+			reg = <0x9C00000 0x100000>;
+			clock-names = "hqvdp", "pix_main";
+			clocks = <&clk_s_c0_flexgen CLK_MAIN_DISP>,
+				 <&clk_s_d2_flexgen CLK_PIX_MAIN_DISP>;
+			reset-names = "hqvdp";
+			resets = <&softreset STIH407_HDQVDP_SOFTRESET>;
+			st,vtg = <&vtg_main>;
+		};
+
 		bdisp0:bdisp@9f10000 {
 			compatible = "st,stih407-bdisp";
 			reg = <0x9f10000 0x1000>;

-- 
2.50.1


