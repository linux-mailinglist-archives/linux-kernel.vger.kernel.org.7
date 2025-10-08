Return-Path: <linux-kernel+bounces-845844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85584BC645C
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E471891AE3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340C02C11F2;
	Wed,  8 Oct 2025 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdDpnFOW"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742AC2C11C3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759947683; cv=none; b=RHVuPBXOBDe5c4KjfEhnXg5rboaa8YORMZzpYCZisF9neznIOK0sdFAKxP29DayHEcCk600m9mkouDp7J82/NRx/6kHdDHbHyvUr4L0P8mTPWfgrVxwOfNQJEGOPJ9VRgVINj9Wel+4YHjl8lM4Pa6SldDAVzjK1DSGNWntJvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759947683; c=relaxed/simple;
	bh=Kl4q/D7nfppLjlQrmRLj7XfvEwj3MSpqoJDjNllE58E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWx5zIQXcSW3UAzocVaxdo7NMlpVKUk+e+M2o2iG0WZ3P+8QvWeHTOZs8ItWcNAAhibLKEjRNpG+naiCgdvBLrG2m4mL7fF3pbmQQnmuGYy9AebpzWDgFDwQqgyqW35DjNMozCC4I1mWeWTrlKKrljr6nCv72eWIql/Eq8yinQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdDpnFOW; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57a604fecb4so194055e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759947680; x=1760552480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQLKb9Rkh1oQUK1I7BmlhT3z4f6StPjvIila7EBGntI=;
        b=jdDpnFOWG+/CyLYmq0o0zFrYQLnqRa/6OHDFajG6xASUENWqcfZ91VbZjv9Hr2O7Db
         5detF7cneX6Vw6dj30zIu5Ie4IwiqJz3gqAyBu1WnzijRYD0KpNlYMDvHLWmA2BMmWPp
         VwPUBKnbeYXHMT0a01gy0TvaprHIDp0brddI63vHeQsy/uMT0znj8mePd/nQ0aJEKh5I
         KDZVSAS7MtKjp+HGp2S+8rD48zefCs0ARQrOGI/VDYCu4rsL5WgoDw3JtmgZvlEBiT4O
         mejwC9RSWvECmz02DbOzgQnuv9rA2VcuowsLkh48eQmMgq21R3ZMrC6xEUQogLZdNebK
         PcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759947680; x=1760552480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQLKb9Rkh1oQUK1I7BmlhT3z4f6StPjvIila7EBGntI=;
        b=cxKX9lhnSq6XXpDamtDECAVzlVjyw5QRVL2IKvagG16ORbaAxEnIXhagTPAyNHT5Sk
         hXviRzEA7SIKQw9TDxDivGD+puW1fwb143RhWYXTgmTfi8enihzXiOFuQgCVr/gL+zVB
         /JPVFZzavIMLwPgPh0zYFmXGp6PPiIh8+XYl6K+6AbI6SUC8GckPkCZJbfIRRPHSNz6U
         KX7LQqCvmojarESXkIYZ0nk8pEl0iFRVKEP+tgOGTfAB26cOc2DBNeggAJbdTY1NouSl
         Sp+Bl7UaFSHEOrrh1e2YsbtM0PMzCJBhp4zTqMOqUid073GVqppXNSjV18DMXCLpGARR
         BWhA==
X-Forwarded-Encrypted: i=1; AJvYcCXQJcGx6y3yQeC2oaggitiAcJQzhjv6Kbaw9hna1yM5QK/tuONmUAPXrNyNPk7Y8rZr4WO0xR0I58dvlFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+F5U+y9mrxLaWve/2TtL6guetorRC0jcywu9MQXEJ0jxKfzkL
	RuaAIZPEinsrnM2TTp5zbGQK5w8B88cAU5elHpSmSxiFfUw2SXv4YZvY
X-Gm-Gg: ASbGnctQT51PwAYHV4+ps6JyYOC1O117Jfa03TSeEJSAGUz3bzsj+mr49+lalRqzour
	QA74cfsvjgNbY+b7qB4WhmBLLgYS3rHj25C54K5AOE9zY8UEgBSipJPt8Nj1ougB9ReHOQPDUsX
	EX53r/TPfF991Vc9fNErt+ueqWHX9dL280JH9rdmiN4CdQQa2iOL2xY1cJpLxWxB1xn33kTQ5XG
	6mMJO7UpywY34LkIQYqKZmz5nB2Q6yoEFWJvWqtOach64oBCrXLLgkHv2qjAWJaIvfgd8ebAutS
	jcllvxhceno86/6kdx6PO1+5j5w9s9+9EB+AVoUDPVc7V71CPwUIIkfHwI/mqUSNGc3DC1yiFK6
	Ken6obcxD2Xi0fO3xOpEHsRY1oE3AtnXDFv5S1df5Iv5N
X-Google-Smtp-Source: AGHT+IEfKH/JfDemgTpsqSa+H3Z/Hc8hNRwaIMuAtNW9nJ/1vTUKfusljb2l85OO0h19Tn1iszjpRQ==
X-Received: by 2002:a05:6512:3da8:b0:560:8b86:75ba with SMTP id 2adb3069b0e04-5906dafc8a7mr1328825e87.52.1759947679418;
        Wed, 08 Oct 2025 11:21:19 -0700 (PDT)
Received: from crusty-box ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907adb1268sm223930e87.90.2025.10.08.11.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:21:19 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: qcom: msm8939-asus-z00t: add initial device tree
Date: Wed,  8 Oct 2025 21:20:20 +0300
Message-ID: <20251008182106.217340-3-xerikasxx@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008182106.217340-1-xerikasxx@gmail.com>
References: <20251008182106.217340-1-xerikasxx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an initial device tree for Asus ZenFone 2 Laser/Selfie. This
includes support for:
- UART
- USB
- Internal storage
- MicroSD
- Volume keys
- Touchscreen: Focaltech FT5306
- Accelerometer: Invensense MPU6515
- Magnetometer: Asahi Kasei AK09911
- Vibrator
- Audio input and output
- Modem

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>

---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../arm64/boot/dts/qcom/msm8939-asus-z00t.dts | 256 ++++++++++++++++++
 2 files changed, 257 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-asus-z00t.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 296688f7cb26..35f3ff0d6f18 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -72,6 +72,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-yiming-uz801v3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8917-xiaomi-riva.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8929-wingtech-wt82918hd.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-asus-z00t.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-huawei-kiwi.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-longcheer-l9100.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8939-samsung-a7.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8939-asus-z00t.dts b/arch/arm64/boot/dts/qcom/msm8939-asus-z00t.dts
new file mode 100644
index 000000000000..ebb548e62e02
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8939-asus-z00t.dts
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8939-pm8916.dtsi"
+#include "msm8916-modem-qdsp6.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "Asus ZenFone 2 Laser/Selfie (1080p)";
+	compatible = "asus,z00t", "qcom,msm8939";
+	chassis-type = "handset";
+
+	aliases {
+		mmc0 = &sdhc_1;
+		mmc1 = &sdhc_2;
+		serial0 = &blsp_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
+
+		button-volume-up {
+			label = "Volume Up";
+			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+
+		button-volume-down {
+			label = "Volume Down";
+			gpios = <&tlmm 117 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <15>;
+		};
+	};
+
+	reg_sd_vmmc: regulator-sdcard-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "sdcard-vmmc";
+		regulator-min-microvolt = <2950000>;
+		regulator-max-microvolt = <2950000>;
+
+		gpio = <&tlmm 87 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		startup-delay-us = <200>;
+
+		pinctrl-0 = <&sd_vmmc_en_default>;
+		pinctrl-names = "default";
+	};
+
+	usb_id: usb-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&usb_id_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&blsp_i2c2 {
+	status = "okay";
+
+	magnetometer@c {
+		compatible = "asahi-kasei,ak09911";
+		reg = <0x0c>;
+
+		vdd-supply = <&pm8916_l8>;
+		vid-supply = <&pm8916_l6>;
+
+		reset-gpios = <&tlmm 112 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&mag_reset_default>;
+		pinctrl-names = "default";
+	};
+
+	imu@68 {
+		compatible = "invensense,mpu6515";
+		reg = <0x68>;
+
+		interrupts-extended = <&tlmm 36 IRQ_TYPE_EDGE_RISING>;
+
+		vdd-supply = <&pm8916_l8>;
+		vddio-supply = <&pm8916_l6>;
+
+		pinctrl-0 = <&imu_default>;
+		pinctrl-names = "default";
+
+		mount-matrix = "0",  "1", "0",
+			       "-1", "0", "0",
+			       "0",  "0", "1";
+	};
+};
+
+&blsp_i2c5 {
+	status = "okay";
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5306";
+		reg = <0x38>;
+
+		interrupts-extended = <&tlmm 13 IRQ_TYPE_EDGE_FALLING>;
+
+		reset-gpios = <&tlmm 12 GPIO_ACTIVE_LOW>;
+
+		vcc-supply = <&pm8916_l8>;
+		iovcc-supply = <&pm8916_l6>;
+
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <1920>;
+
+		pinctrl-0 = <&touchscreen_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&blsp_uart2 {
+	pinctrl-0 = <&blsp_uart2_console_default>;
+	pinctrl-1 = <&blsp_uart2_console_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+};
+
+&mpss_mem {
+	reg = <0x0 0x86800000 0x0 0x5500000>;
+};
+
+&pm8916_codec {
+	qcom,micbias-lvl = <2800>;
+	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+	qcom,micbias1-ext-cap;
+	qcom,hphl-jack-type-normally-open;
+
+	status = "okay";
+};
+
+&pm8916_vib {
+	status = "okay";
+};
+
+&sdhc_1 {
+	status = "okay";
+};
+
+&sdhc_2 {
+	vmmc-supply = <&reg_sd_vmmc>;
+
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
+	pinctrl-names = "default", "sleep";
+	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+};
+
+&sound {
+	audio-routing =
+		"AMIC1", "MIC BIAS External1",
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS External1";
+
+	status = "okay";
+};
+
+&usb {
+	extcon = <&usb_id>, <&usb_id>;
+
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&usb_id>;
+};
+
+&wcnss {
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3660b";
+};
+
+&wcnss_mem {
+	status = "okay";
+};
+
+&tlmm {
+	touchscreen_default: touchscreen-default-state {
+		reset-pins {
+			pins = "gpio12";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		touch-pins {
+			pins = "gpio13";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	imu_default: imu-default-state {
+		pins = "gpio36";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	sd_vmmc_en_default: sd-vmmc-en-default-state {
+		pins = "gpio87";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	gpio_keys_default: gpio-keys-default-state {
+		pins = "gpio107", "gpio117";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	usb_id_default: usb-id-default-state {
+		pins = "gpio110";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	mag_reset_default: mag-reset-default-state {
+		pins = "gpio112";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
-- 
2.51.0


