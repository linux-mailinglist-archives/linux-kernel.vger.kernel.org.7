Return-Path: <linux-kernel+bounces-765559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BF0B239FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A734B1A2815D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C1F2D738F;
	Tue, 12 Aug 2025 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9awnORV"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D6D20B81D;
	Tue, 12 Aug 2025 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755030636; cv=none; b=uy+YCVnPZTkltuS0hJ4RCQvtiHgwSHMXXQ0PQunBppsRt1cZX1K01HSDl/SZkXSVQzw6u+8zR0Ti+Ith5MkJg1Jbe/0pxuRGsxSgmmiZtr/0b4/jwO58qZXfeOAb0T1FMxalogSD++xRpf/4kaxbgqkpeY1cgxpeObjG3BYMwJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755030636; c=relaxed/simple;
	bh=9DqcJtTzlqb1sSS7J90kHNHmzcXcp/6yYNEDD9Y/4d4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gx67I5DngWNbxdu9U7k0jop0Hmk43Hn2zvc4bvBK3dQRBrex0DusGRCRxVvk1hZSDnWPc8aJWpqKjiuunKrkRWwImI3Vt0VKy2WClI/OiagcRNCMtIkI84XA7Can+rRAsFHI83OAKOxj2QwzeAoENXqWwDbR7OYrCoyDUbrcBco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9awnORV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af949891d3aso772697066b.1;
        Tue, 12 Aug 2025 13:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755030633; x=1755635433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktvIjfxMrOnrAIQuJF/SowoEVNisSucGrU6MG81QF/M=;
        b=l9awnORVAoUDb07ghiS+IFELzdyDvQN5V+u7WIkOB26fQaIAB0OjfLsHZEMTOEP9VT
         kyaLi4BxkhO3fgX3TbcH57z9sGJroy8UhI3+6c7ZQ/ME6vqGnTcrF6jAa2aU5UmW+QAA
         QJvSPAn8IEp4T37G6WjYbly8Ol1aTLHjAq+aBRRu4aJSmDCSk4zGLXwFXf2QULrRgn3c
         ouTv2ZEfPi2hnnsOiT4ZHEl8/loOWaMZLZhybJNbJnOi7QjJhxEVV+u/Ae1Qj4S12ncq
         BMK9SKG8HYzgT/hB9rj/DphTvfELrKJST1FwU8uACzUUkLEE6NcJtM34fmypHdTrjkrh
         +Jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755030633; x=1755635433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktvIjfxMrOnrAIQuJF/SowoEVNisSucGrU6MG81QF/M=;
        b=WwL4SjoS10bmCocSgvSbaQPDjxL0EKnsWxeuJTpov9pG4fHykBorFyTfC7Na9OihNR
         BZbRIZQtCzCtlbs/RVt15rUoYN/oz+NIfj/35yRP23UbVR7y1z6w3WDm3uTaQy3ZnBcc
         /AtzckHxFBE1RWMigWA0yMzj4lhXVtbmPbzVIKI/mJsM6Io3qSI4DHaQpoQU7RfQea0F
         4gT7oABgms94lT3g9z0auU9wVHszlWEXVfWmV74zrKVyJrK3mUVAtocahImeM3QzaBLL
         F2Zp2rosJbJcC0a2ne0NXtC54l2OaHJkb3Ra2yvElZNhepw20gtK9oLTmDZ0Pxhr5vKu
         miCA==
X-Forwarded-Encrypted: i=1; AJvYcCV/Jk/hPiRWrtf0indyvqe6OBGr5OAReP/cw9Mht3YlgUN2YM2WxZViWQkAkuPyDgWeDK0fAh497ybgTRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8EclxVTTlYqWi3AQ0yDiP2QkYJ7npn3SSqi9+B9MdEJb4XqY
	A36L5EXHHA/nlNmdu3hLeEStmD5SnSiJjTXRL1+mHOLX6eD7joYVXpFbSri9apta3zk=
X-Gm-Gg: ASbGncvDf5yA/Ep599OwzxnwZ/j4xeKAf/I3BFCltzR4tQUtmzB77BRJ6keBbap+GWc
	raUm9Untz3ukrzZa9EPUDEcJvAeiZ/7pc6pI4UNHZuD0oZArJuHFuYnpagWEdxp4as40d4WkbjR
	5WBCxoJSCtxIM+dijz+sn4VTC4B7QgoOBSMRGJ3+ApmufoYJlKn7FRKO9rpcjropQ1ZOPIpngEi
	b/rXWclxkG60ZOK8zfe+5alb1yOvKmVq8jPcoKqEfjcL0elHLgOulVaIg7cMP+AfzIU+v5wUTY2
	9jCHQJGhOI4b0Rhvm/IEDyfeRiPnZpCmnq1gyvsFs6NrTSfsfmHD6epiZkm1zACMpjcbFE9AUyU
	Io/4PipvidRNEugLnX32iGXfTKs6834cOBArtH4pP
X-Google-Smtp-Source: AGHT+IEhBN23fHYD9HD9rJNv5eHIc3wxMe2qLfcYv9cCJJBHEGKutPk282chDrY0GVVVd+6ScJRb3g==
X-Received: by 2002:a17:907:7b89:b0:af2:5a26:b32a with SMTP id a640c23a62f3a-afca4e01f03mr58694466b.30.1755030632925;
        Tue, 12 Aug 2025 13:30:32 -0700 (PDT)
Received: from alchark-surface.localdomain ([185.213.155.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b58sm2266073166b.58.2025.08.12.13.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:30:32 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 13 Aug 2025 00:30:24 +0400
Subject: [PATCH 2/3] arm64: dts: rockchip: Add WiFi on rk3576-evb1-v10
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-evb1-rtcwifibt-v1-2-d13c83422971@gmail.com>
References: <20250813-evb1-rtcwifibt-v1-0-d13c83422971@gmail.com>
In-Reply-To: <20250813-evb1-rtcwifibt-v1-0-d13c83422971@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Pavel Zhovner <pavel@flipperdevices.com>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755030626; l=2878;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=9DqcJtTzlqb1sSS7J90kHNHmzcXcp/6yYNEDD9Y/4d4=;
 b=ZEYpBvII7kSWRyvS+kKlecvScuKWTqUQ49vogugzgI47oBWYhuLAI2pMP+g7Vh8G14THuG116
 Tc2LrzMOkrJCFGqxp06jHZ7m2Wufydr19hT+JuqwQuOvBvcPk6zqW7J
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

Add device tree nodes to enable the onboard Ampak AP6275P WiFi chip
connected over a PCIe link on Rockchip RK3576 EVB1.

It takes an external 32 kHz clock from the RTC chip and requires the
WIFI_REG_ON signal to be enabled before the bus is enumerated to
initialize properly.

Tested-by: Pavel Zhovner <pavel@flipperdevices.com>
Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts | 58 ++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
index bfefd37a1ab8c67a17aba0cdb80980102d66bb76..100ca2e23c6093ae517d741fcd047e2a8172f457 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts
@@ -232,6 +232,20 @@ vcc_ufs_s0: regulator-vcc-ufs-s0 {
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc_sys>;
 	};
+
+	vcc_wifi_reg_on: regulator-wifi-reg-on {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&wifi_reg_on>;
+		pinctrl-names = "default";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "wifi_reg_on";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_1v8_s3>;
+	};
 };
 
 &cpu_l0 {
@@ -242,6 +256,10 @@ &cpu_b0 {
 	cpu-supply = <&vdd_cpu_big_s0>;
 };
 
+&combphy0_ps {
+	status = "okay";
+};
+
 &combphy1_psu {
 	status = "okay";
 };
@@ -712,6 +730,30 @@ rgmii_phy1: phy@1 {
 	};
 };
 
+&pcie0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_rst>;
+	reset-gpios = <&gpio2 RK_PB4 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc_3v3_s3>;
+	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x0 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xf>;
+		device_type = "pci";
+		ranges;
+
+		wifi: wifi@0,0 {
+			compatible = "pci14e4,449d";
+			reg = <0x10000 0 0 0 0>;
+			clocks = <&hym8563>;
+			clock-names = "lpo";
+		};
+	};
+};
+
 &pcie1 {
 	reset-gpios = <&gpio4 RK_PC4 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie1>;
@@ -730,6 +772,12 @@ rtc_int: rtc-int {
 		};
 	};
 
+	pcie0 {
+		pcie0_rst: pcie0-rst {
+			rockchip,pins = <2 RK_PB4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	usb {
 		usb_host_pwren: usb-host-pwren {
 			rockchip,pins = <0 RK_PC7 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -743,6 +791,16 @@ usbc0_int: usbc0-int {
 			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
+
+	wifi {
+		wifi_reg_on: wifi-reg-on {
+			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		wifi_wake_host: wifi-wake-host {
+			rockchip,pins = <0 RK_PB0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
 };
 
 &sdmmc {

-- 
2.49.1


