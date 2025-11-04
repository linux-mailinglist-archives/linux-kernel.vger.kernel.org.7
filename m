Return-Path: <linux-kernel+bounces-884772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7DBC31153
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E64554F3D81
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E44A2ECD31;
	Tue,  4 Nov 2025 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4g2iz3R"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33B25F99B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260738; cv=none; b=AP4yJefnAZ75bf1y4j/T7mxJeTbT/zCDt1wbEsQ+lVU/bINc69GZmTd97+G+EPXSBchV8vayOz29u73h7Zu8GelPOt6r5OGoE6ulpO/0TUy0ZMt03eBJXjsvcXa+zQDWtrzTBAJGYTwlX+oZ9srEowgs5ofzRJ2M6c+Xbcsb33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260738; c=relaxed/simple;
	bh=GxgC0TolWtnzi7SvFdkB4vNBCzd2oYzDY3pnyXAe9bQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PJQDzks6uThpsO/zFNb6KA3320DBr1OSNDrRFWXqdMKQk4zISro13dAzagO4Jeur5CBAcUrGaFVtf3oOBuphQGK3WwIcOOuRn8j05Tzm485cST3KTSkOmdpFa42kEWxPw6kez42MZ4426ZKr06eQ9f6L2V2qWlPymTSDZAvlX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4g2iz3R; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso4130460a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260736; x=1762865536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q70u+s1V/4l35FFXxxmayKruUxA7+UqrHWq0UpA0ngQ=;
        b=f4g2iz3RO1n9h+5cgUcBoSmI5YEiCALAUMMXwcBTPrViL7TttVyK14PefvA8cs8guz
         gV8DX6WSIdm6ipKytdpxtz0e7XP/HlXwgFIXeTiYhxzWcVd4HL909ZKI2zxDIVrdChmK
         VSZzGoK1CKadfZrm25/33FHKjEZxb/ioiWAfXB/INUtNgvj/7z1GHHPxZwcgkI5oFQpx
         J0CfWWNJhpy2ezYrODfgJd5A+blwlkktF3eKL3HWBEG59IPUWzCHlz/Zv60c2iEX0g37
         WDjD5KAqZ3tAJwcOPEXj5u2RlC76Ri/4/5+sk7jUPq6ws+08D+2oyOxkV8hk1DoHtvZ5
         B9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260736; x=1762865536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q70u+s1V/4l35FFXxxmayKruUxA7+UqrHWq0UpA0ngQ=;
        b=ELy/YSqGKYNuVanRxUWKm0IKl2TLOk+uGcYLMEbiKV5xxQ/Yyz2wSlg5DfxRRzNb1z
         IME8PzIaBkXxFJAdhUul4dOPJnzkQc37emPy37CBB21xBFTmpQSnskBHntRFeF1G2Yuz
         OSaoBl64QZwicOp5F7CH5FpbUFM9xCMzDuV512CgcNNNifijm8isCzqI6XYWlcOFkTrw
         pgBcuuPfI80HGtmy+yUDVZKhbsdEiusBJPd8wOqHbmil5ggXgsTvLm+QG1z15RVZNIxi
         lXcAQwxdkDRgH90cg3a9KVbwzUpsVMqhdpCeahLsSuQcB09itAYsHAQ7sXmcQPA3Y7ER
         xZZw==
X-Forwarded-Encrypted: i=1; AJvYcCWJHUpW9IvgPiNixZ0XBHf8yDzKK8e2LrGzqniZ+lsPoemhiU8LMAoofj1+PVucIbZtC4TM+z5ij07cr80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQoldOVglKYoqloGvN2Su6+EXtJdLKO/UDAu7cm0t1UkbqtFQH
	NhFFLgs8Jg3plnfQjMKkOHqJriJmAwA35XQFbhRU8Ho2DdegevMesRJM
X-Gm-Gg: ASbGnct48RMcXZqFtnl6wMFVpT83zUUCePiaIx9um0tjY5yoXqN/2XQ85qlVDaKJb10
	rm1L7Zw8wuAbSn/M0kr06/NW7Dy9GOlnkPIHFfhQRJSkw0d6MNx8+iimgnFIW4TFkIii4vYulmr
	D4RN2HZL2mynvBMWumVXuWAdMK9D5Q51GcdCcIh71QAedSiwUInKMqjbkm5fpkX16aDZ5b10dRE
	JtSo2XE9M53Iet80NvdrgDkoibEVM5UFf57PnAYqoW6x5cmRas9Grhs1+nSBX4RsBOn2mwsG8XQ
	KlSjg6bvGoVoYMS2ejGHtioh7bt79x9zZR+jV8OvuavY3LIrejW6TlFewsiAL+GIrNsuQ46Cqlo
	zl+F/5Tq/LyBrJydeE4TJTgE62bb66bpKFN+Sbu/1jBXHnPl2xNILyxgROieGAaDzlIRSmUH5tl
	AuaWsKo+Bt4dzoXTwIvCfRDEH1CQ==
X-Google-Smtp-Source: AGHT+IFVFLda8Bb+Khe8BewvQJ3eDill+4KKAYhhfWLntuu8ommlDpF8ZcZXn8A+V/wqz2WhWv2q/Q==
X-Received: by 2002:a05:6a20:7d9f:b0:342:fb2d:e7ff with SMTP id adf61e73a8af0-348cd41de50mr18742995637.53.1762260735928;
        Tue, 04 Nov 2025 04:52:15 -0800 (PST)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd586f862sm2876463b3a.34.2025.11.04.04.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:52:15 -0800 (PST)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v2] arm64: dts: qcom: talos-evk: Add support for dual-channel LVDS panel
Date: Tue,  4 Nov 2025 18:22:08 +0530
Message-Id: <20251104125208.1009695-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The QCS615-based Talos EVK platform supports a dual-channel
LVDS display configuration using the TI SN65DSI84 DSI-to-LVDS bridge.
This setup enables dual-link LVDS operation where channel A
carries odd pixels and channel B carries even pixels.

A dedicated device tree variant is introduced to describe this
specific hardware configuration. It extends the base Talos EVK
device tree with the additional bridge node and display
pipeline settings required for dual-channel LVDS operation.

Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
Changes in v2:
- Renamed node 'lcd0_pwm_en' to 'lcd0-pwm-en' as per review feedback
- Restructured Talos DT hierarchy to avoid including a .dts file
  directly
- Updated 'talos-evk-lvds.dts' to include 'talos-evk-som.dtsi' and
 'talos-evk-cb.dtsi'

 arch/arm64/boot/dts/qcom/Makefile           |   1 +
 arch/arm64/boot/dts/qcom/talos-evk-lvds.dts | 122 ++++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-lvds.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d5a3dd98137d..6e7b04e67287 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -307,6 +307,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8750-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8750-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk-dsi.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk-lvds.dtb
 x1e001de-devkit-el2-dtbs	:= x1e001de-devkit.dtb x1-el2.dtbo
 dtb-$(CONFIG_ARCH_QCOM)	+= x1e001de-devkit.dtb x1e001de-devkit-el2.dtb
 x1e78100-lenovo-thinkpad-t14s-el2-dtbs	:= x1e78100-lenovo-thinkpad-t14s.dtb x1-el2.dtbo
diff --git a/arch/arm64/boot/dts/qcom/talos-evk-lvds.dts b/arch/arm64/boot/dts/qcom/talos-evk-lvds.dts
new file mode 100644
index 000000000000..3754ed1b4423
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/talos-evk-lvds.dts
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+/dts-v1/;
+#include "talos-evk-cb.dtsi"
+
+/ {
+
+	backlight: backlight {
+		compatible = "gpio-backlight";
+		gpios = <&tlmm 115 GPIO_ACTIVE_HIGH>;
+		default-on;
+	};
+
+	lcd-pwm-en {
+		compatible = "gpio-backlight";
+		gpios = <&tlmm 59 GPIO_ACTIVE_HIGH>;
+		default-on;
+	};
+
+	panel-lvds {
+		compatible = "auo,g133han01";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* LVDS A (Odd pixels) */
+			port@0 {
+				reg = <0>;
+				dual-lvds-odd-pixels;
+
+				lvds_panel_out_a: endpoint {
+					remote-endpoint = <&sn65dsi84_out_a>;
+				};
+			};
+
+			/* LVDS B (Even pixels) */
+			port@1 {
+				reg = <1>;
+				dual-lvds-even-pixels;
+
+				lvds_panel_out_b: endpoint {
+					remote-endpoint = <&sn65dsi84_out_b>;
+				};
+			};
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	bridge: bridge@2c {
+		compatible = "ti,sn65dsi84";
+		reg = <0x2c>;
+		enable-gpios = <&tlmm 42 GPIO_ACTIVE_HIGH>;
+		ti,dsi-lanes = <4>;
+		ti,lvds-format = "jeida-24";
+		ti,lvds-bpp = <24>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sn65dsi84_in: endpoint {
+					data-lanes = <0 1 2 3>;
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				sn65dsi84_out_a: endpoint {
+					data-lanes = <0 1 2 3>;
+					remote-endpoint = <&lvds_panel_out_a>;
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+
+				sn65dsi84_out_b: endpoint {
+					data-lanes = <0 1 2 3>;
+					remote-endpoint = <&lvds_panel_out_b>;
+				};
+			};
+		};
+	};
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l11a>;
+
+	status = "okay";
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&sn65dsi84_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&tlmm {
+	lcd_bklt_en: lcd-bklt-en-state {
+		pins = "gpio115";
+		function = "gpio";
+		bias-disable;
+	};
+
+	lcd_bklt_pwm: lcd-bklt-pwm-state {
+		pins = "gpio59";
+		function = "gpio";
+		bias-disable;
+	};
+};
-- 
2.34.1


