Return-Path: <linux-kernel+bounces-775808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C768B2C511
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01FF74E4461
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECD032A3CA;
	Tue, 19 Aug 2025 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6f2F5TJ"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BA33EAF8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609394; cv=none; b=Vm+2yvNqfAybFJTvxEgvMdxH/yqIs73kxNNe/QdOpbN+IlMZhZdyaGbasNHlYrrMTFH3YEGBOdXNZiaObgZOGFDrLjii5kh+RZXSEcgyRfxq2YaI75YScxSQDJb5ZjnUzyyf/Q7FcoPlFi+aN7lozSZZM3ppGn0vwxrAzI1S1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609394; c=relaxed/simple;
	bh=y7xStFE0NPIkxi9Pu680sxAPkxq15o/aAJd/KvC53fU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfZynqQwZ0Mf82Rkyf6o9AyMjNBEgh4u5Ubeaoc1VTCuYeM7Gizpo1k846WE54xluECohLYXipey3Ti4+92JHlXLELAMadYcK2Rou0zKHM6wqUg0wr3s+ttzbz6sSozp3xf6jKW2VVh6KNyoZkXWlA+d0p8S15GnFwzcJwD/ArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h6f2F5TJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb79fb221so72395566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609391; x=1756214191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZZIdP+oBFimapfXAqXLnsiUg0mGHxd7q9JW+Ig3Zqk=;
        b=h6f2F5TJEplu0aCwBM+ylXH3Lxg4CeCQXlbT7mKmHsjHjN97sdtVFqmVVzwWvRnRhf
         RzXW0XB0fW9v6niFhTLvChEHTfu2688cwC0Vvk7FpsKxBgELz7c8Sq6o7ReOch+wYY4y
         yOsHOnK5wx/oEugDe+njkxC7lcGu7Twf8Bd5i/HcmOxZFed/qx+EIQcIUvASdSOrfvVx
         frEsUc0bcqbmRkbXv5mSDjnX52k6o9nApWitjXVDrs3NLZMy4qnI6ssHPdKmBACxn9k4
         ChDhkLwM686Jjk9vHivyaAICu027sknSEWH1P8z+Nq2XBeaU80VeHh0Bl3phqgMnxI9M
         08jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609391; x=1756214191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZZIdP+oBFimapfXAqXLnsiUg0mGHxd7q9JW+Ig3Zqk=;
        b=mnKBw0XEIKxfV1yC+V7sHkkaOIZ4zgA23MUS3f3wewgonMe2U2b8l7YA2MkCwV3HSv
         IUwZsjB29geQcV4HGGu0N1AlJltAp+z2dMUbWWRQK0DRlSp/X2uIu1rDQaZU4EvsFMYk
         hCbyaFUWlRcOy8Yqy2ispP8a39ccD7BSHdeVKjOxPRosULvMJZbRgbjEFf981M/2MPMR
         XuDuJuGMyVdVzp4Js4lZUCIYlF+G+CT1HYwb5SYejLervDxzntNO/RkKsY2yPEikppFZ
         23Mlu5KExxaD+n+be2PVy7495WkNFJqW8Ha4nRnHYlCx3uA7mxZTdCOV0hCfkygaFJ1I
         /mZg==
X-Forwarded-Encrypted: i=1; AJvYcCWUQCB0UJavyKVyafISJ2QL/TfKeDMou/r57v9VjJ7eQndTV7q3dP6fc8ZBHdrOrUEWvq9JO8Qb0QdmBPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJhLjOkE0NC8APIufyeUV24BXQiYGSjxLvG+Eaabnvv49jxHn
	5d9SPR0UOpPp33DKHNYG4YqFbgGPuSlv0BN0xq/GO/X3c0jvqHc3AUOL6PQWrC4zbjc=
X-Gm-Gg: ASbGnctrvVbKH3QqK2C1+xzvRihK8pEbk/riPJ0NNx7K7g2m7IngXSFD6tTXV8ljKEc
	Fk5PfjqYzfDuR5w3qjbgg2hG05vtd8cO8/OYZVkB6H2x9lGCucoTthn4CebeWP/FYPSM6/houTR
	8lK1UpnDNJA1KwRFfzsGluToCKH6pqtK+IRZ4OFMtKCVcnVjEC96+1yD6n6RF2kEJXM2NeNUOky
	yV/C2y5wkiCpqo+6FuPpz8gTlDV5cvwSksgkLWp5ue8CodyhGUloVJvUn+NizEFVxsricF5aeXF
	725sZj2nuBvRrgH/OJnB7ytnX5jENendMJ9HxOMHdGbBACRWoWsWgw+EfkHTW+iMniKrgGgNTxf
	5GPKF2P1iu6uKR/admyhEY96KdwieOMxF2Q==
X-Google-Smtp-Source: AGHT+IEpObl3AXqG5YLwGioik5GupCpWPb0I5hX7zakwD7RPUsahBj7xHDVrUgh2Vb0G+dzv1Jp3Uw==
X-Received: by 2002:a17:907:86a4:b0:ad8:9207:b436 with SMTP id a640c23a62f3a-afddd0c7d0bmr118076766b.5.1755609391064;
        Tue, 19 Aug 2025 06:16:31 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd010d4csm988721666b.85.2025.08.19.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:16:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: mediatek: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:16:27 +0200
Message-ID: <20250819131626.86437-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4619; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=y7xStFE0NPIkxi9Pu680sxAPkxq15o/aAJd/KvC53fU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHkqIAFaQMi6BKsdOrJ8UDRbfn4vqnrFDGbrN
 xSLPx67B5aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5KgAKCRDBN2bmhouD
 18ZuD/0cgDdl1OlZpiiI58Xe1O/d1MRcs7ODqESE1H53OSKkPjVj+Nvo3yifk8r2Cwr83p0DLHu
 SwlQLCZE/TyxzbWtWec1WsG2peVHMfYpDOJY5HzZmLHOXuB+u8oqWfpg+JBdbymqF98iZDbM7AU
 N3UQTzl81ZmerRBZSsBTv7tb7PIKtu1oSjpl/DB01EfmjdoV/dlb1Kw/P8Rzg69AxooAn2//vLW
 zvQ5+Q91CoYD8D9NU9L0rAuXnzhqLw1z1vL3El1L3T4i4lYvo+gL55yoZTQ11BklEzPmL9MK/or
 Q4f+QbDVhQRrBJJsbv0tw3CniZd3d2FMksMH3Ogxxrd/JBKhYpXNp1YY1U6kFvy6HoPtJTwFOhX
 b5x84gZ0b3HqsY12RyvG0PTzinl4ZtwaQiIhYsiAJ3jH8Upm10jj3MzBm1VH7O0ChZn4EkLGHCu
 lz3+a5YIcbLSHgDCYn9jpMjc5n5lwF5BTG3jZqMLRQKmO4ifFTPf/qJNYLl9C2cQYcU8p760Upa
 iq1Tg9Gh19osc/k8MnQm/F47iuDl8KpUytL9QcK7LG61T4h9ZoFyp5F0QA+ieryGdwOPW+k09Xa
 ARtd+Zx+NOXEKTZlNIUgtOa4Iz5uWYNZGloOeVU/DuFhpuLWP6xt2vEUBXP/TsjP86FCRwEU9Ec smZe34u2DJppFLw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi                 | 2 +-
 arch/arm64/boot/dts/mediatek/mt8188.dtsi                  | 8 ++++----
 arch/arm64/boot/dts/mediatek/mt8365.dtsi                  | 2 +-
 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi     | 4 ++--
 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts    | 2 +-
 .../boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts    | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 560ec86dbec0..2e108aad8aec 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -253,7 +253,7 @@ mux {
 			uart0_pins: uart0-pins {
 				mux {
 					function = "uart";
-					groups =  "uart0";
+					groups = "uart0";
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 202478407727..ef18117dc5d6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -1152,9 +1152,9 @@ power-domain@MT8188_POWER_DOMAIN_CAM_MAIN {
 									 <&camsys CLK_CAM_MAIN_CAM2MM0_GALS>,
 									 <&camsys CLK_CAM_MAIN_CAM2MM1_GALS>,
 									 <&camsys CLK_CAM_MAIN_CAM2SYS_GALS>;
-								clock-names= "ss-cam-l13", "ss-cam-l14",
-									     "ss-cam-mm0", "ss-cam-mm1",
-									     "ss-camsys";
+								clock-names = "ss-cam-l13", "ss-cam-l14",
+									      "ss-cam-mm0", "ss-cam-mm1",
+									      "ss-camsys";
 								mediatek,infracfg = <&infracfg_ao>;
 								#address-cells = <1>;
 								#size-cells = <0>;
@@ -1172,7 +1172,7 @@ power-domain@MT8188_POWER_DOMAIN_CAM_SUBB {
 								};
 
 								power-domain@MT8188_POWER_DOMAIN_CAM_SUBA {
-									reg =<MT8188_POWER_DOMAIN_CAM_SUBA>;
+									reg = <MT8188_POWER_DOMAIN_CAM_SUBA>;
 									clocks = <&camsys CLK_CAM_MAIN_CAM_SUBA>,
 										 <&camsys_rawa CLK_CAM_RAWA_LARBX>,
 										 <&camsys_yuva CLK_CAM_YUVA_LARBX>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index e6d2b3221a3b..9d6b5ce8c421 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -780,7 +780,7 @@ mmsys_ext: endpoint@1 {
 		};
 
 		mutex: mutex@14001000 {
-			compatible =  "mediatek,mt8365-disp-mutex";
+			compatible = "mediatek,mt8365-disp-mutex";
 			reg = <0 0x14001000 0 0x1000>;
 			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_LOW>;
 			power-domains = <&spm MT8365_POWER_DOMAIN_MM>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
index a2cdecd2b903..18b2771e7705 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
@@ -414,7 +414,7 @@ connector {
 			data-role = "dual";
 			op-sink-microwatt = <10000000>;
 			power-role = "dual";
-			try-power-role  = "sink";
+			try-power-role = "sink";
 			pd-revision = /bits/ 8 <0x03 0x00 0x01 0x08>;
 
 			sink-pdos = <PDO_FIXED(5000, 2000,
@@ -1130,7 +1130,7 @@ pins-wifi-enable {
 };
 
 &eth {
-	phy-mode ="rgmii-id";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethernet_phy0>;
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&eth_default_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
index cf8cd37f5708..58ce34e7fde8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
@@ -263,7 +263,7 @@ dsi0_out: endpoint {
 };
 
 &eth {
-	phy-mode ="rgmii-rxid";
+	phy-mode = "rgmii-rxid";
 	phy-handle = <&eth_phy0>;
 	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
 	snps,reset-delays-us = <0 10000 10000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
index 4985b65925a9..1a89de14ac3a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
@@ -266,7 +266,7 @@ &auxadc {
 };
 
 &eth {
-	phy-mode ="rgmii-id";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ethernet_phy0>;
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&eth_default_pins>;
-- 
2.48.1


