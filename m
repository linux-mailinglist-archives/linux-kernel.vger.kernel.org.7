Return-Path: <linux-kernel+bounces-815725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15853B56A5C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE133BE5C7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2532DC35B;
	Sun, 14 Sep 2025 15:57:37 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CD22DE710
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757865456; cv=none; b=laYd0++PBTZdL5CWbp9FJyfu8KB3a4puSRmOtCGoCKLyaoDNKNRhbW/6ObvMxc7SZWHgD5jEqFDzXjI2OIa0AhuanecCZI+V4NmNdnpI3ueOEWgvMEGte9Q5dN+lFnXYkyshgekdtUcvZmI0j26yO7Jfa2X8EfSgWpRhUdPPGFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757865456; c=relaxed/simple;
	bh=+hcwblRIBuQ+J9Yk8H60awXsSZXJkpOUptbXJftZtOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gcu8i1RYMEuSg1kICKIEL0eupikHwmuiRhkDPzj1Vl4J8rsZ3rltIC1MAJ6IBLFpKleU11wvFZhfIt5AFPHJ7X3JroeAhdY9fzPWzbsPD3PDQm4jq9b+OzJUPFCswdTosmk8FxO+P1CDZJbBMq4Q0ivUgDnRIvbnNq98C5uhrsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1757865441tc039d1b4
X-QQ-Originating-IP: 8I3arhshC7WQ0J2PtaSXvrAMOpGU1NDEy3L0KufdMqk=
Received: from [192.168.30.36] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 14 Sep 2025 23:57:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11909047073940114166
EX-QQ-RecipientCnt: 12
From: Xilin Wu <sophon@radxa.com>
Date: Sun, 14 Sep 2025 23:57:08 +0800
Subject: [PATCH DNM v2 5/5] arm64: dts: qcom: qcs6490-radxa-dragon-q6a:
 Enable USB 3.0 and HDMI ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-radxa-dragon-q6a-v2-5-045f7e92b3bb@radxa.com>
References: <20250914-radxa-dragon-q6a-v2-0-045f7e92b3bb@radxa.com>
In-Reply-To: <20250914-radxa-dragon-q6a-v2-0-045f7e92b3bb@radxa.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
 Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>, Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757865427; l=4169;
 i=sophon@radxa.com; s=20240424; h=from:subject:message-id;
 bh=+hcwblRIBuQ+J9Yk8H60awXsSZXJkpOUptbXJftZtOQ=;
 b=siCeStVnL8gXcVL0AicvXdoc3c1XwFNtfzOSwSc0lPIEUMPgA/NGguQeVNQ7DrsV/pCn06Sx8
 pDlq35z4XUYCNhI9SToIbpmQdj/4wxBeCRBFX8Hp7bI8F+ngLAy3Jjn
X-Developer-Key: i=sophon@radxa.com; a=ed25519;
 pk=vPnxeJnlD/PfEbyQPZzaay5ezxI/lMrke7qXy31lSM8=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NDyJFjRsJu3snF/xX8KzmrBgXsDrQrFYJRWJ7Ba8m+3lSe2MeikYKUam
	FWjjzL0wGrYKc71ymqXPRLOZpJJYoq+Vv0jVoCMuib51DH3eUNDp9SJFdOXmoZOz58FN7bj
	JBU3a11TrXwlZmiYG9AjfxfgWfTbxX7wJTHmbgAIfRJJaqHAxVabkTh8oBED1DCYHuNlNJN
	wKzatmvbGUiUoww47DLrBwVTN1l4IUSvCLrK1C/QbpCkVJPtEXLRJkuFlNoDJ0BRu/nmCWY
	qq19arEL6dJEu11xTykfHi2u8/zbeaW/Hzok9flyXM2C+GMznw1ZurQwrTNakc3j3I7aLm9
	f0TCqWzTrlwfn6yPsRjBwN1GQFGxqc0vCISQs/bNOS+P+jI3+MAtpp+J4uZ9CdZgA4UW0nP
	KbhsM5HQT4mLn/uz/4rfdhfqbp3kcL+YvAgfHLS7iG1lA2rqGFwM40eUG5nTEhle4trf+ch
	hk9Awv/TxeGYhsOfaudJWuB6ciYYDWkh2ZMHiSa9UWO7lDcEYyLY4rLq0J1qL2TocwY1JBe
	sOxtmhyAfkLb+ymDd803QolVoV8LOnkK5VZ/H96V5Mk/2FiJwGmCzIO13NTd7CiMv4KHwiP
	SI/AG2yue6aRjWO7TTxXCkGtUtGSELMtAGaGq+AjwjH1RIXqPj2j14skFka3/whlnXFLI1w
	Pf2xwGZ7F+tvpzxZMcCv8SUQlsn6tMow9tCCRkgqkYHI/0aq/2I33TJ/oFp/rdQEA76o66d
	WnezUQjr2moW1fmXbnG72/QcrryJc1r5OG8eKwU2XB7nSgyMTZur8Pw7oYNaRKHhwNg5g6y
	CaI9MEJypE9veujGhChLFZMTyghAy7M/hewhCpRr/X0fwsCVQbaVhR7egeHb9usx9qoc/tm
	dezGYXLiyWThx9OmbhmVMuSses3aXC6Vrkap681H2DPveEhUZXFN5tDNKLlOraUWQYApgvn
	uSio2myhozfbYowpn0oJBI7QrDdpeRS5ziIixITE7pAjJG+1sRsM3OCcDVJS3A40KYiZRuA
	uj5/q48ElX6GPhx0v1VtrR+0YI3OcJtzyu0J+HjDY+SbHzOf8bTZwN18LuQ7i/sYlQmLGDU
	g==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

This board doesn't feature a regular Type-C port. The usb_1_qmpphy's
RX1/TX1 pair is statically connected to the USB-A port, while its RX0/TX0
pair is connected to the RA620 DP-to-HDMI bridge.

Add and enable the nodes for the features to work.

Signed-off-by: Xilin Wu <sophon@radxa.com>

---

This change depends on the following patch series:
https://lore.kernel.org/all/20250908-topic-x1e80100-hdmi-v3-4-c53b0f2bc2fb@linaro.org/
---
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 152 +++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
index 3bf85d68c97891db1f1f0b84fb5649803948e06f..12bc9a0fcfbfeaabf6ede351f96c61193a8261c0 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
@@ -78,6 +78,71 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	usb3_con: connector {
+		compatible = "usb-a-connector";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				usb3_con_hs_in: endpoint {
+					remote-endpoint = <&usb_1_dwc3_hs>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				usb3_con_ss_in: endpoint {
+					remote-endpoint = <&usb_dp_qmpphy_out_usb>;
+				};
+			};
+		};
+	};
+
+	hdmi-bridge {
+		compatible = "radxa,ra620";
+
+		pinctrl-0 = <&dp_hot_plug_det>;
+		pinctrl-names = "default";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				hdmi_bridge_in: endpoint {
+					remote-endpoint = <&usb_dp_qmpphy_out_dp>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				hdmi_bridge_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_bridge_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -504,6 +569,21 @@ &lpass_va_macro {
 	status = "okay";
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_dp {
+	sound-name-prefix = "Display Port0";
+
+	status = "okay";
+};
+
+&mdss_dp_out {
+	data-lanes = <0 1>;
+	remote-endpoint = <&usb_dp_qmpphy_dp_in>;
+};
+
 &pcie0 {
 	perst-gpios = <&tlmm 87 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 89 GPIO_ACTIVE_HIGH>;
@@ -753,6 +833,22 @@ platform {
 			sound-dai = <&q6apm>;
 		};
 	};
+
+	dp0-dai-link {
+		link-name = "DP0 Playback";
+
+		codec {
+			sound-dai = <&mdss_dp>;
+		};
+
+		cpu {
+			sound-dai = <&q6apmbedai DISPLAY_PORT_RX_0>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
 };
 
 /* Pin 11, 29, 31, 32 in GPIO header */
@@ -967,6 +1063,58 @@ &ufs_mem_phy {
 	status = "okay";
 };
 
+&usb_1 {
+	dr_mode = "host";
+
+	status = "okay";
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&usb3_con_hs_in>;
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l10c_0p88>;
+	vdda33-supply = <&vreg_l2b_3p072>;
+	vdda18-supply = <&vreg_l1c_1p8>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l6b_1p2>;
+	vdda-pll-supply = <&vreg_l1b_0p912>;
+
+	/delete-property/ orientation-switch;
+
+	status = "okay";
+
+	ports {
+		port@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/delete-node/ endpoint;
+
+			/* RX1/TX1 is statically connected to USB-A port */
+			usb_dp_qmpphy_out_usb: endpoint@0 {
+				reg = <0>;
+
+				data-lanes = <2 3>;
+				remote-endpoint = <&usb3_con_ss_in>;
+			};
+
+			/* RX0/TX0 is statically connected to RA620 bridge */
+			usb_dp_qmpphy_out_dp: endpoint@1 {
+				reg = <1>;
+
+				data-lanes = <3 2>;
+				remote-endpoint = <&hdmi_bridge_in>;
+			};
+		};
+	};
+};
+
 &usb_2 {
 	dr_mode = "host";
 
@@ -986,6 +1134,10 @@ &venus {
 };
 
 /* PINCTRL - additions to nodes defined in sc7280.dtsi */
+&dp_hot_plug_det {
+	bias-disable;
+};
+
 &pcie0_clkreq_n {
 	bias-pull-up;
 	drive-strength = <2>;

-- 
2.51.0


