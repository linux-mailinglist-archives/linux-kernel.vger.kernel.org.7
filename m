Return-Path: <linux-kernel+bounces-854472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A42BDE776
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ADD5189BC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB49B326D5C;
	Wed, 15 Oct 2025 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEktIwMp"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74DA326D4D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531298; cv=none; b=nv2hlioJjxh9EQEE01Caiqj/Anvgnua+I8HihSurPLfQegow+uWSsATKLsL3t7e0QIssryKeW5AWPx30OjVPAwxCc8yh50c0gK8jHzAXRz469lJgZylCmkiv7rIyhgJ67PVuLBHIfwdt379T0h3KQ3ZdM5IRtPjr6MvpiEZyf3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531298; c=relaxed/simple;
	bh=Os5kE7Qp904fgsLtlKi0tEm+/ya14jhuJ1TcRTMG+jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pgTitebUlCIlnbGjmmdzAZXXRIgsPzX8I0UGh6tPb1tNDwQOUMDdoeGgoBdX+IK+tq1yYcZAF/j1PlaWTyp7odmTNQHQ/SN1OUGJ3Va+9SX9vSDXgw/P0E57pafSvqzkQDzG0j6UzzuRmwsPDBZCD+EEe8LVbxp+mCXfj2VyzAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEktIwMp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b551350adfaso5325331a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760531296; x=1761136096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/4Q1O4To4aHXOUJ7WUI51pM4khtah3DJn+Z1/RRGrw=;
        b=iEktIwMpcVWpHHVMbvDks1bbLR23IVav9X1qzcwR3MHrWCvIIDTWyESyClVHKKVJk4
         RlSk+mE9jUj/sOOGHjpFZA6qRMii1HeGaTd+EtuUtR3bS1gvrWZ99eUTrZebOuvk36uy
         8nIXj8y8y11HesukPQV+4xMO1kLgUCA9GbztmVrZ3vV3XHwfdlDCNLTJHVq7IqGDcdb6
         wnwjm0xRmUVTRNa/iL05XgmhG3OZ/bC4kKQMxe/jFFa9Ex2N/KFGf5553OwiNCHM4gdk
         5rCp8x6eV20KdCb6AEeRjpc8fL/lMFJl0/ujm0TZeM+Fe88AAuCMFHdhmCbECAPnot3+
         ysWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760531296; x=1761136096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/4Q1O4To4aHXOUJ7WUI51pM4khtah3DJn+Z1/RRGrw=;
        b=cSIfr/yTmxxeuUE/yERG8oZuXwqMaQ5uW211lUOz2+mX3hCuX/IUJIl5k7Z3OVUvCq
         p752jHm9bSp3fNAroznkbuWGllm0I5SslIjXP/45C3yUTD+0EO2ymMfYI6ZPBJ0Hn+AM
         rHog7qQSWCXUGvGX0nfub9ZdrY7wHwSJYnAwhVMVl9pTwCQ24MySOrP1anr6ABQqMCKj
         VKx/+HjYZ+Vx97nc47yklxVt1i7+uyMvCEotP+IRhGF88HFmttaFFbtRj1cfsUBoKjQP
         euVdaQRPI3nFZWRW/d8gjbBsAJQDLdL5LpTwSgDk78eQfs7DaTt/qNsetV4YdMbz75y9
         0Fkg==
X-Forwarded-Encrypted: i=1; AJvYcCW1seRBbeTOwgEHcnUspq8Quvb3ixXssKSRF7wJL6TUZwblp81/SuDUFQe5NPjUs248yw91jOEnj20gv4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4T8irMfMmhHnTqXho4f3pRzghn++46K5se/benX2lke8eTqjx
	FWuwhxfhjqjILrIY6Isy7oYC6xaGaKbkjwtZVSPFwu8niLqcLdl//xkc
X-Gm-Gg: ASbGncuSO+G0aH7fjsTt+pHs3Prbo9ai7b5CLAphXkswgeNb1tBxd734BS1RvUCmHku
	pol1IZqH7n0FbzkzXGCkHmo3iC/Mji+ERzARrXEBVI6p5QltlCXq00YBoarJX95RDkO5acZbuNC
	F66prG0nsuu7WU5y/NfZi9FMaNZ+7TsjgX8CUQEBhLw3mn3UgthhMIZNlvDOK94EGuu+rBD/Eo2
	b0RwlEVyw+w103hlTtJcs28UkUFWfzdWu6uCYk07FB8HPNg2TjTq/draZ+rA04HdUz2tGu1OTbN
	SP0Si0hF2itm13jFRJXUNNzROXe1OqJTmSCZO/6o+M5phcfFqtL+W+S5/mAIo4qZUmBP99geJtv
	5CJnuq0SeBioZ68latBirXMdrYJ0sSjCQyMj2x7EWsd7OekVYinGYPS8dyHfxwOgSb102odGuIz
	BlbQ==
X-Google-Smtp-Source: AGHT+IGBXsur2mXMSiVFdUfO/wNEz1AR+AmHWbQC9W/DI30eL7NtcHOtDsGmRKWzPjI5I7G9dDsy5Q==
X-Received: by 2002:a17:902:fc46:b0:27e:ef12:6e94 with SMTP id d9443c01a7336-29027418f97mr362061355ad.55.1760531295849;
        Wed, 15 Oct 2025 05:28:15 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f87b23sm196688025ad.113.2025.10.15.05.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 05:28:15 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andersson@kernel.org
Cc: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tessolveupstream@gmail.com
Subject: [PATCH v1] arm64: dts: qcom: talos-evk: Add ADV7535 DSI-to-HDMI bridge
Date: Wed, 15 Oct 2025 17:58:08 +0530
Message-Id: <20251015122808.1986627-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hook up the ADV7535 DSI-to-HDMI bridge on the QCS615 Talos EVK board.
This provides HDMI output through the external DSI-to-HDMI converter.

Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
 arch/arm64/boot/dts/qcom/talos-evk-som.dtsi | 21 ++++++
 arch/arm64/boot/dts/qcom/talos-evk.dts      | 76 +++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi b/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
index 55ec8034103d..b58cae02c9cb 100644
--- a/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
@@ -244,6 +244,27 @@ eeprom@5f {
 	};
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l11a>;
+
+	status = "okay";
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&adv7535_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
 &pcie {
 	perst-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/talos-evk.dts b/arch/arm64/boot/dts/qcom/talos-evk.dts
index 25057f4f6a91..f7e8be3667d1 100644
--- a/arch/arm64/boot/dts/qcom/talos-evk.dts
+++ b/arch/arm64/boot/dts/qcom/talos-evk.dts
@@ -14,6 +14,82 @@ / {
 	aliases {
 		mmc1 = &sdhc_2;
 	};
+
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "d";
+
+		port {
+			hdmi_con_out: endpoint {
+				remote-endpoint = <&adv7535_out>;
+			};
+		};
+	};
+
+	vreg_v1p2_out: regulator-v1p2-out {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg-v1p2-out";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vreg_v1p8_out: regulator-v1p8-out {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg-v1p8-out";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vreg_v3p3_out: regulator-v3p3-out {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg-v3p3-out";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	adv7535: adv7535@3d {
+		compatible = "adi,adv7535";
+		reg = <0x3d>;
+		avdd-supply = <&vreg_v1p8_out>;
+		dvdd-supply = <&vreg_v1p8_out>;
+		pvdd-supply = <&vreg_v1p8_out>;
+		a2vdd-supply = <&vreg_v1p8_out>;
+		v3p3-supply = <&vreg_v3p3_out>;
+		v1p2-supply = <&vreg_v1p2_out>;
+		interrupts-extended = <&tlmm 26 IRQ_TYPE_LEVEL_LOW>;
+		adi,dsi-lanes = <4>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				adv7535_in: endpoint {
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				adv7535_out: endpoint {
+					remote-endpoint = <&hdmi_con_out>;
+				};
+			};
+		};
+	};
 };
 
 &pon_pwrkey {
-- 
2.34.1


