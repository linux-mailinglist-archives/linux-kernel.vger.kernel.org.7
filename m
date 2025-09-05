Return-Path: <linux-kernel+bounces-802641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBA1B45509
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BBE1CC3078
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652512DF71E;
	Fri,  5 Sep 2025 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="WS0pH5ub"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54230C63A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757068880; cv=none; b=cIJLoShvDPfNUT9+a7G6YgVbLtCn7I2Hb44O2BMikE+YEKr0Wo8aerVRMsY09p4Hto4OItePvMlcIABHxJLmH5PJ8G9mmSK7ifZ0mJrWpEWgSDfWRadEE6NGuCfTfA9rgVDlZSzd5iOUXlHJ2FKisAQkBqRxAylAHUMC3Fakp6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757068880; c=relaxed/simple;
	bh=baSRk0DHIH0JQTq1qw31u1MkBcbaJD6j/ihCEWLrpnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OFZzQFF8iWIcx502sPuHmv/QHFno/6g2/UfVnKTZy2ZrXOOl79PWfolZt3ysQHzR1G+hX+foAg86AFUNIRK3OFH7JyWAX7Tgt2PmN2AfmpQm2VyuZ47NQtdFq1WwuMuWb4DNgG4KnqnVVRX79EYUdB2w+WPD7Uf9PH1KM9V0Zlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=WS0pH5ub; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3e4aeaa57b9so211544f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1757068875; x=1757673675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MM2ai5n4cCWr05qGJpd7F89dTuaRprQnD261xjB242Q=;
        b=WS0pH5ubq5TFVDHKGIw29et06J9djqcBo4/3VEMYm4npshNbkdPKLCyMnT0EV7ZiMD
         CeFgSUugm00Z0FtS5dem+ment3VYYJpeCO3SMMZ8WCSd6WiznQTUOACRIqRZfbHS9bhs
         tL3fC2V6CBjvR30IDgNaUum7T+iEefBSRFKi5ny6qSAsdMRXtGl9ymLfhxwC3xuJyDS6
         fa6KSP4WG/2MqzCoS+G8yXwVZBrZ1r8r2QHm7Fk7830ZwHB1IZy9DGDloA3LhjjTc6e8
         VOwBPoXX4xABFT3DVqUbIC3iuWVRZx4+EZxO3IfQkrEzJc0Ntp7ksJdlO0Awr2EosCMY
         ZO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757068875; x=1757673675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MM2ai5n4cCWr05qGJpd7F89dTuaRprQnD261xjB242Q=;
        b=b2muEB668AHU08G+XSC/XvwTMBgpCpcvogWsCzpZaXbUCCV+EURMR2qgTi9OQGyeqv
         TJDJ/oQC1E6C2B3ucsCiWYkyiwE2ooSFc1mfdC0b40l4UfILXFhoaGYii3HCGhusmYtF
         DHEJ0UyGRiaf/bqbO2a+41xmsW+Ijk3cUf06peMUfKP42IpcKeWoDIg6uG8Pknx1fxpG
         2AQ0BJHV34Y2XicQvGyNSIv4Bk/wkHZGFyY2l/8e+Sw3iS6S2fmNGvroJrzCbcgVnzpQ
         ciZDP2OChofZXMrRbQsNDMJVJZjKJt4J/7sd3ncfnAYOuGpJIOBot4NU8s+eRw60ri6Q
         xhAw==
X-Forwarded-Encrypted: i=1; AJvYcCWv3zXZHlnfgiqhZVGBq6ZjtkpsxfOM8sN1OM6UAGSYBWIRAfhJDTzSp15cddCl9ARvH+ziCwTjSC6YsmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOpEzeWdcn01RIDlI5Fjwcv2v000KAhgKXS7Z0RT4MqJT4J9F+
	MaKFNFvZUFev9IAyERXaPSPnMkVkyjB+b46v8CBc2aJp9Bqn9Tqm5OYkTMDeaHThOyY=
X-Gm-Gg: ASbGnct2S8tPvARw3o0i4YLGM+tN0wSPom7T94xgbIq5COVp1cD5Bv8kTkSDuIury53
	+A93y8gPNxW+TqPSQKtbNXgwLyBDr46Jo9xJ/bbe6+OjBORrhO9Q4FcUS/9w2/XKFkdPN78D/VB
	Z9gm+Y6FVuENwn9vp6HQHssb9XVgsPEVMULROzZ785O7P3mgeczaxc6HOTejWv6el6HIgaRtG01
	t3bzKoCzgE+crurkjllNups84G4MHBSPNu4oRUrC8Qa80QRA/KT8/qGPxDEXRlTHveVkVKiUx9P
	61jl0aHBB1dd6vNRznYOsBHUG0hKzLRsgJ3ow0dpQIiTJzJirVUl9C+A/9B+rzEoP8AvQCDuuV/
	03CdbV/ybXteovAZGxxcLlV6ieIBcDg985ag/WZTmEHA95qYUT6u8PP6KYU/gjk6dYGv7VvBlNq
	NMHzfvNHbm/GXKxmcftZLZ/6KJqdiQHw==
X-Google-Smtp-Source: AGHT+IGNc9jvJ26B2ZfWHhYDA0PnCS7nifdHaE4vFZpqUA1rg1ITsXJzj4ygGyaHAZqLF9Y74pO4zg==
X-Received: by 2002:a05:6000:2386:b0:3de:78c8:120e with SMTP id ffacd0b85a97d-3de78c8174dmr6548919f8f.6.1757068875228;
        Fri, 05 Sep 2025 03:41:15 -0700 (PDT)
Received: from [172.18.170.139] (ip-185-104-138-158.ptr.icomera.net. [185.104.138.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d6cf485eb7sm20990738f8f.3.2025.09.05.03.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:41:14 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 05 Sep 2025 12:40:36 +0200
Subject: [PATCH v3 5/7] arm64: dts: qcom: pm8550vs: Disable different PMIC
 SIDs by default
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sm7635-fp6-initial-v3-5-0117c2eff1b7@fairphone.com>
References: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
In-Reply-To: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757068857; l=8169;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=baSRk0DHIH0JQTq1qw31u1MkBcbaJD6j/ihCEWLrpnc=;
 b=gJUuqr0sbhzszxBRyGFUywuUTfQmr0dUItiTJsO1UspdO6tJDnbIdip/Yt+oy69+CEJzXnbmP
 RgLhczfqgvnC9FcaWSUFQq7pa1NPGdN0HMKDooxYA6nkgvKYDFSgPAO
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Keep the different PMIC definitions in pm8550vs.dtsi disabled by
default, and only enable them in boards explicitly.

This allows to support boards better which only have pm8550vs_c, like
the Milos/SM7635-based Fairphone (Gen. 6).

Note: I assume that at least some of these devices with PM8550VS also
don't have _c, _d, _e and _g, but this patch is keeping the resulting
devicetree the same as before this change, disabling them on boards that
don't actually have those is out of scope for this patch.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm8550vs.dtsi                   |  8 ++++++++
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi             | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts                  | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts                  | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts                  | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts          | 16 ++++++++++++++++
 .../boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts     | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts                  | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts                  | 16 ++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts                  | 16 ++++++++++++++++
 10 files changed, 152 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8550vs.dtsi b/arch/arm64/boot/dts/qcom/pm8550vs.dtsi
index 6426b431616bde2d960780be2bed4c623af246c2..7b5898c263ad8a687e8c914fbb0072c58799b6b2 100644
--- a/arch/arm64/boot/dts/qcom/pm8550vs.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8550vs.dtsi
@@ -98,6 +98,8 @@ pm8550vs_c: pmic@2 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		status = "disabled";
+
 		pm8550vs_c_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
@@ -122,6 +124,8 @@ pm8550vs_d: pmic@3 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		status = "disabled";
+
 		pm8550vs_d_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
@@ -146,6 +150,8 @@ pm8550vs_e: pmic@4 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		status = "disabled";
+
 		pm8550vs_e_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
@@ -170,6 +176,8 @@ pm8550vs_g: pmic@6 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		status = "disabled";
+
 		pm8550vs_g_temp_alarm: temp-alarm@a00 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0xa00>;
diff --git a/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
index e6ac529e6b7216ac4b9e10900c5ddc9a06c9011c..e6ebb643203b62ba0050d11930576023207a2e35 100644
--- a/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
@@ -366,6 +366,22 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32764>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index b5d7f0cd443a18b167c94e450b5b9412897b2ba2..0c070e7e927c3a8612dbe1fb5c202f8dc2323438 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -1107,6 +1107,22 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &pon_pwrkey {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 38f2928f23cc3c1905ceea182270ce882d61eed7..10b7434bb30d707ab9139a060a93210c4a3ec463 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -789,6 +789,22 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index a3f4200a1145d8633944de46dfe3221a13c8ba7c..c562a9b52a609f60dfb3a97db1dba8d6dda6aae2 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -957,6 +957,22 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &pon_pwrkey {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
index b4ef40ae2cd956d2c0a1e46d6428aaa6e5d9c4ee..81c02ee27fe998a489d6a3fa67c946987a0ca88c 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
@@ -533,6 +533,22 @@ volume_up_n: volume-up-n-state {
 	};
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &pon_pwrkey {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
index d90dc7b37c4a74cbfb03c929646fda3381413084..0e6ed6fce614706590ab37eb96c1077622d0d532 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
@@ -661,6 +661,22 @@ focus_n: focus-n-state {
 	};
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &pm8550vs_g_gpios {
 	cam_pwr_a_cs: cam-pwr-a-cs-state {
 		pins = "gpio4";
diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index d4e5c95e93395b84292366a6ad8bc1ee7d7c362b..c8f8d492f4c3997232759478c45b916ec1b8ad88 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -1046,6 +1046,22 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &pmk8550_rtc {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
index c67bbace27439ad67cfb247a88aec633f93f5a6d..bb688a5d21c2d0c8b9fd4ff29e8d85ef9e271883 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
@@ -692,6 +692,22 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index d71031cb26e2ecb1bf5c4e8b200e68f2d3b5d3a4..e47b5ad8a9a3a2680406c467531bc896cd1cff81 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -1002,6 +1002,22 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pm8550vs_c {
+	status = "okay";
+};
+
+&pm8550vs_d {
+	status = "okay";
+};
+
+&pm8550vs_e {
+	status = "okay";
+};
+
+&pm8550vs_g {
+	status = "okay";
+};
+
 &pmk8550_rtc {
 	status = "okay";
 };

-- 
2.51.0


