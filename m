Return-Path: <linux-kernel+bounces-815401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3052B563D4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 01:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F68A189D638
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C5E2D063D;
	Sat, 13 Sep 2025 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="QAvOXdgv"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D6D2D0616
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 23:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757807860; cv=none; b=oB9A/R6MfTwqhObFUDZF6JcZTDhoSJcfnBpOLPcwf5R4ZXF8mcrlvUh/Uo3JVVihOAPaEZvqi3t1HTX/lqAiwrUVZw8rXG0OkoS0x7ptttzamdwfGi9WZFyP74CV0uMc0kdeNxZVErqfCrTt1cvUQOC/7DXp3uoKQQFuMFGgxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757807860; c=relaxed/simple;
	bh=Ai26De6gFjxkqVX/FlgWGks9+l0Y+OM0fkNpwqBmVk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9zHQOGGr1y7qkaupSve2hg7aev3jfChvabe/ZjNCqarNo3Gpa4uMzo1dXO7dUMBrRiGmv0r2SluyZA4Zyws4NzimwwwhTVDZU8uCa9o+ycREBiMYqzf2uEKDg+XzyrmCGEENRvoakzMhszv8vOAfbiWU7C5oc2Bh77mdN+O+Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=QAvOXdgv; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1757807857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAevqdBw1eEdEeIsmCUgRw0DgnyymFzjE5uuOMCmvck=;
	b=QAvOXdgvfCmH+8ueg+d6dr7smnd01cTTnsSNS7QnGC1h0xIaFk59chCx5y81eHvD/0/hOZ
	sdZ8hN34U/IQNe8FCEP7ZKvVtYnkPDcNk5QmybJQ0vnd5mmd9TOtXke+VtNZCTLcFNQ3IR
	7uyg8T+woEdMj6dUs0DGT9Y9vFl7tqmGvOmtJeL3B/R340jSLenUj303sp+yqG0lWsJncS
	IRXEYBd1kxw5guLOH7TSz8O1BupqXclW2uf8eqeeh4KyHy1F3XH3sAunsPN6lUR2AnRIw2
	EV5w+LR7XOfKeYSf+xpREQcWCvnE/cPPtIZ14WzShfkwNO+sVVkAgdoU+Qx5dA==
From: Paul Sajna <sajattack@postmarketos.org>
Date: Sat, 13 Sep 2025 16:56:38 -0700
Subject: [PATCH 05/11] arm64: dts: qcom: sdm845-lg-judyln: Add display
 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-judyln-dts-v1-5-23b4b7790dce@postmarketos.org>
References: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
In-Reply-To: <20250913-judyln-dts-v1-0-23b4b7790dce@postmarketos.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Amir Dahan <system64fumo@protonmail.com>, 
 Christopher Brown <crispybrown@gmail.com>, 
 Paul Sajna <sajattack@postmarketos.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757807839; l=3692;
 i=sajattack@postmarketos.org; s=20250422; h=from:subject:message-id;
 bh=Ai26De6gFjxkqVX/FlgWGks9+l0Y+OM0fkNpwqBmVk0=;
 b=ZdgpZy7fnC7vc9bY4tw3PbnQv6d4Hj6R+XSggX3RiX3Mj/CTXeMGod+AYjCjkr6HYMP9g8lDQ
 UAkpaeUkFM9CU0X1nAWNqEmXTomIcmjQSgG+Bhstt4E1unexPW4cEBr
X-Developer-Key: i=sajattack@postmarketos.org; a=ed25519;
 pk=TwacvEOiRJ2P2oAdEqIDrtQTL18QS4FfcHfP/zNsxkQ=
X-Migadu-Flow: FLOW_OUT

And supporting msm drm nodes, including backlight
Depends on https://lore.kernel.org/all/20250910-judyln-panel-v1-1-825c74403bbb@postmarketos.org/T/#r9a976ca01e309b6c03100e984a26a0ffc2fe2002

Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
Co-authored-by: Amir Dahan <system64fumo@protonmail.com>
Signed-off-by: Amir Dahan <system64fumo@protonmail.com>
---
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi |  4 +-
 arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts  | 99 ++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index df826bca2bef5e3f85cf49708020a47b8d6bd8bb..1bf2f2b0e85de174959ec2467076a95f471a59d4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -461,8 +461,8 @@ &cdsp_pas {
 	status = "okay";
 };
 
-&dispcc {
-	status = "disabled";
+&gmu {
+	status = "okay";
 };
 
 &gcc {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
index da093b581c857c5acc9f0e72c9d3519977e13eab..fae85d4c1520e044d8166bb22a8f5762fda250b2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
@@ -23,6 +23,13 @@ framebuffer@9d400000 {
 			format = "a8r8g8b8";
 			lab-supply = <&lab>;
 			ibb-supply = <&ibb>;
+
+			panel = <&fb_panel>;
+
+			fb_panel: fb-panel {
+				width-mm = <72>;
+				height-mm = <153>;
+			};
 		};
 	};
 
@@ -72,6 +79,70 @@ &pmi8998_charger {
 	monitored-battery = <&battery>;
 };
 
+&ibb {
+	regulator-min-microvolt = <4600000>;
+	regulator-max-microvolt = <6000000>;
+	regulator-over-current-protection;
+	regulator-pull-down;
+	regulator-soft-start;
+	regulator-always-on;
+	qcom,discharge-resistor-kohms = <300>;
+};
+
+&lab {
+	regulator-min-microvolt = <4600000>;
+	regulator-max-microvolt = <6000000>;
+	regulator-over-current-protection;
+	regulator-pull-down;
+	regulator-soft-start;
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vdda_mipi_dsi0_1p2>;
+
+	status = "okay";
+
+	display_panel: panel@0 {
+		reg = <0>;
+		compatible = "lg,sw49410";
+
+		ibb-supply = <&ibb>;
+		lab-supply = <&lab>;
+
+		backlight = <&pmi8998_wled>;
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&sde_dsi_active &sde_te_active>;
+		pinctrl-1 = <&sde_dsi_sleep &sde_te_sleep>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vdda_mipi_dsi0_pll>;
+
+	status = "okay";
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&pmi8998_wled {
+	status = "okay";
+};
+
 &tlmm {
 	thinq_key_default: thinq-key-default-state {
 		pins = "gpio89";
@@ -80,6 +151,34 @@ thinq_key_default: thinq-key-default-state {
 		drive-strength = <2>;
 		bias-pull-up;
 	};
+
+	sde_dsi_active: sde-dsi-active-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	sde_dsi_sleep: sde-dsi-sleep-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	sde_te_active: sde-te-active-state {
+		pins = "gpio10";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	sde_te_sleep: sde-te-sleep-state {
+		pins = "gpio10";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
 };
 
 &uart6 {

-- 
2.51.0


