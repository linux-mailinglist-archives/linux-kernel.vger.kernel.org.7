Return-Path: <linux-kernel+bounces-767358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8466FB25348
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1145A8A24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1AD2EBBA9;
	Wed, 13 Aug 2025 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="JjDY1Uvz"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E33D2E1C79
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110843; cv=none; b=G0+yG5Oikd2BvGrcldQ2mz9EmI71ZtAQ43tsZ7vaTwiNq7sTe0OELQ3sbnrTNOptk5eAiU3isQcf1zx/6TOnxK4wPP7Lj2wKwfId7IzCx072vZ9OQrfsWd2TtqMaH6NB6080Q/9Hck0YvdPOEKaFCrR0AZ10ukTg3AQPlVaMyuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110843; c=relaxed/simple;
	bh=H9BD+j78w0Ae5X2EXuClRx1XUwp3BCuC/J0XLupmcTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HP8m/s9MJ8PVgEiQ2OKIwc+Id0hE8lRkCTGhxMVYw6g79NYidr5frF3dMICCufyaYhqZHQIpwhynF12vUYajZD6bmsgswmjDX8Z49qxF9Joev8LJ8ZBrUj4/E5RcST8MpNjdnw9GbiGgxlXzE0kz6hmX2PROmtDrWMAthfnqE4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=JjDY1Uvz; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-435d3a45a3fso87498b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755110839; x=1755715639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZOFuAV9WIY3A6fVsmJXjk9IDNyN47AkttTE8N5+sQc=;
        b=JjDY1UvzN9g+KODOUc1nsx8A0/n3velKbGqZtJI47W7JYHLqsTz0rrOzepsvuK82n4
         VsE/7UUZ4F4pbY4lMv2rXbcGr/YvkHWK2GSrEwDW9IjhZD7+b1jwfhOgFF+0asHk13ek
         5UA9BjAvxjietblS/Zb5WRBGB3VlPFS9VZ7zzVYItdipZItdPQXRPz5bkxtdQuPKolu1
         ibUpqTzPZdJocZUGYJARCMU2DJcxQNO7MMecqz6oE/AY0JE32VgvXUlAWKG1M60YBO4i
         9uWs42knHAw0kiBqin25UKPS9OXk6kCU7SF0GIws77CJf++jj6C7mJBy5CXQZI8OrqcB
         t9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755110839; x=1755715639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZOFuAV9WIY3A6fVsmJXjk9IDNyN47AkttTE8N5+sQc=;
        b=AZSnGeekJ0l8np93s3veTmFreygdTW61lCDbIkdQXLOBHqLswwAE2dqsJ7Gk+dyQ+D
         kHq6M2g6IDx8msQpIdtFmCabAAfHYliSva9O+Rj8ysjBmgLAQtk3SjHmICOEGIiZ7OBS
         KJr66ddgZhXYHsiu78u5LfTUK7mP/XgivjvulJYGG5YXPJ6qRfIeGAxq3NNAiAxXjfpV
         AYaQzPat1+WkVqoEYyOo3otMQTCvbTCn7Xk811YNV9JpfJQKCdUFLRGDxMv9sAz8x7VO
         jFeXpuy9rEUOp0fMTrqv2wZOk/y196mQv2Ec/iNaqiYA+zWO7CQRWlNzTlvUlBUYAzKG
         OoTw==
X-Forwarded-Encrypted: i=1; AJvYcCUeI81XJe1EPm1j92Sti6CSXACInD6EIV4SdCpUi/IcJsCpXSJvF3fy/deeSh44cD5tXVicFkHfDyCMlZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj1hxmujGDfi0GcSj8Ivp3cm3+Pc+AKUiSs5FnU8ko9M3Z9JAS
	aLKEynu5vmC0DsTAmKphMFmJ7oJtkettn3Wpptln7CS73aHF63LDmG0qCag1V/NnO0w=
X-Gm-Gg: ASbGncvuxBIJFxW8YcpF6ua+TeHBbq7VQzZpcaomXfvBk/TT71f80ymhPqluBLJsw1H
	jvnwhlpNg08KUk3NzLzbbYYHbKtKH/vIyPheW/HQB09imxogggLU1nI9znwUOxNUjCokXu/VUTN
	CrlzyOh1vZp1b3l7ECkcLDT1dGbeblTFi/JQ4cbXDNCgcaXDtl3GZym61aR7jfChUxKAE24LymL
	AVSlCv/zV6OxzlH4J3fNIdJMZFUwPEhfDhR2llT4MFTyM8huBUMO0BTiSRYANeePQLLM/hSgAup
	jtKiq9Gsxfd9jnAhHgI5ehWzrH3JUK4UBkE+7XX0WHf8+wrjh1uj+j15j+s+D9IF5PqO57bQ0ME
	NeaLqd1fjxMvZO3TuS9+CROmLFfLgJd5jDOD54AG0rSvkfbzh9U15jqlH1DmYzJa9sA==
X-Google-Smtp-Source: AGHT+IEVdlqkv+IjfRZpjpzlFpvbX8D1AFg7vJKffDYeBbbSoCO3+AQRuqOj7/Glw0tpxI6YnBjgGw==
X-Received: by 2002:a05:6808:4482:b0:434:b72:de0b with SMTP id 5614622812f47-435de998a60mr460294b6e.8.1755110839199;
        Wed, 13 Aug 2025 11:47:19 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9bd89d7sm3933104173.59.2025.08.13.11.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:47:18 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	tglx@linutronix.de,
	johan+linaro@kernel.org,
	thippeswamy.havalige@amd.com,
	namcao@linutronix.de,
	mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com,
	inochiama@gmail.com,
	quic_schintav@quicinc.com,
	fan.ni@samsung.com,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] riscv: dts: spacemit: PCIe and PHY-related updates
Date: Wed, 13 Aug 2025 13:47:00 -0500
Message-ID: <20250813184701.2444372-7-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813184701.2444372-1-elder@riscstar.com>
References: <20250813184701.2444372-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define PCIe and PHY-related Device Tree nodes for the SpacemiT K1 SoC.

Enable the combo PHY and the two PCIe-only PHYs on the Banana Pi BPI-F3
board.  The combo PHY is used for USB on this board, and that will be
enabled when USB 3 support is accepted.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  28 +++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  33 ++++
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 169 ++++++++++++++++++
 3 files changed, 230 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index fe22c747c5012..1c75e38b1fab9 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -40,6 +40,34 @@ &emmc {
 	status = "okay";
 };
 
+&combo_phy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_3_cfg>;
+	status = "okay";
+};
+
+&pcie1_phy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_3_cfg>;
+	status = "okay";
+};
+
+&pcie2_phy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2_4_cfg>;
+	status = "okay";
+};
+
+&pcie1 {
+	phys = <&pcie1_phy>;
+	status = "okay";
+};
+
+&pcie2 {
+	phys = <&pcie2_phy>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
index 3810557374228..e7dbecd7389b7 100644
--- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
@@ -21,6 +21,39 @@ uart0-2-pins {
 		};
 	};
 
+	pcie0_3_cfg: pcie0-3-cfg {
+		pcie0-3-pins {
+			pinmux = <K1_PADCONF(54, 3)>,	/* PERST# */
+				 <K1_PADCONF(55, 3)>,	/* WAKE */
+				 <K1_PADCONF(53, 3)>;	/* CLKREQ# */
+
+			bias-pull-up = <0>;
+			drive-strength = <21>;
+		};
+	};
+
+	pcie1_3_cfg: pcie1-3-cfg {
+		pcie1-3-pins {
+			pinmux = <K1_PADCONF(59, 4)>,	/* PERST# */
+				 <K1_PADCONF(60, 4)>,	/* WAKE */
+				 <K1_PADCONF(61, 4)>;	/* CLKREQ# */
+
+			bias-pull-up = <0>;
+			drive-strength = <21>;
+		};
+	};
+
+	pcie2_4_cfg: pcie2-4-cfg {
+		pcie2-4-pins {
+			pinmux = <K1_PADCONF(62, 4)>,	/* PERST# */
+				 <K1_PADCONF(112, 3)>,	/* WAKE */
+				 <K1_PADCONF(117, 4)>;	/* CLKREQ# */
+
+			bias-pull-up = <0>;
+			drive-strength = <21>;
+		};
+	};
+
 	pwm14_1_cfg: pwm14-1-cfg {
 		pwm14-1-pins {
 			pinmux = <K1_PADCONF(44, 4)>;
diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index abde8bb07c95c..6343f6e95284d 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -4,6 +4,8 @@
  */
 
 #include <dt-bindings/clock/spacemit,k1-syscon.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
 
 /dts-v1/;
 / {
@@ -358,6 +360,42 @@ syscon_rcpu2: system-controller@c0888000 {
 			#reset-cells = <1>;
 		};
 
+		combo_phy: phy@c0b10000 {
+			compatible = "spacemit,k1-combo-phy";
+			reg = <0x0 0xc0b10000 0x0 0x1000>;
+			clocks = <&syscon_apmu CLK_PCIE0_DBI>,
+				 <&syscon_apmu CLK_PCIE0_MASTER>,
+				 <&syscon_apmu CLK_PCIE0_SLAVE>;
+			clock-names = "dbi",
+				      "mstr",
+				      "slv";
+			resets = <&syscon_apmu RESET_PCIE0_DBI>,
+				 <&syscon_apmu RESET_PCIE0_MASTER>,
+				 <&syscon_apmu RESET_PCIE0_SLAVE>,
+				 <&syscon_apmu RESET_PCIE0_GLOBAL>;
+			reset-names = "dbi",
+				      "mstr",
+				      "slv",
+				      "global";
+			spacemit,syscon-pmu = <&syscon_apmu>;
+			#phy-cells = <1>;
+			status = "disabled";
+		};
+
+		pcie1_phy: phy@c0c10000 {
+			compatible = "spacemit,k1-pcie-phy";
+			reg = <0x0 0xc0c10000 0x0 0x1000>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		pcie2_phy: phy@c0d10000 {
+			compatible = "spacemit,k1-pcie-phy";
+			reg = <0x0 0xc0d10000 0x0 0x1000>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		syscon_apbc: system-controller@d4015000 {
 			compatible = "spacemit,k1-syscon-apbc";
 			reg = <0x0 0xd4015000 0x0 0x1000>;
@@ -814,6 +852,137 @@ pcie-bus {
 			#size-cells = <2>;
 			dma-ranges = <0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>,
 				     <0x0 0xb8000000 0x1 0x38000000 0x3 0x48000000>;
+			pcie0: pcie@ca000000 {
+				compatible = "spacemit,k1-pcie-rc";
+				reg = <0x0 0xca000000 0x0 0x00001000>,
+				      <0x0 0xca300000 0x0 0x0001ff24>,
+				      <0x0 0x8f000000 0x0 0x00002000>,
+				      <0x0 0xc0b20000 0x0 0x00001000>;
+				reg-names = "dbi",
+					    "atu",
+					    "config",
+					    "link";
+				spacemit,syscon-pmu = <&syscon_apmu 0x03cc>;
+
+				ranges = <0x01000000 0x0 0x8f002000 0 0x8f002000 0x0 0x100000>,
+					 <0x02000000 0x0 0x80000000 0 0x80000000 0x0 0x0f000000>;
+
+				clocks = <&syscon_apmu CLK_PCIE0_DBI>,
+					 <&syscon_apmu CLK_PCIE0_MASTER>,
+					 <&syscon_apmu CLK_PCIE0_SLAVE>;
+				clock-names = "dbi",
+					      "mstr",
+					      "slv";
+
+				resets = <&syscon_apmu RESET_PCIE0_DBI>,
+					 <&syscon_apmu RESET_PCIE0_MASTER>,
+					 <&syscon_apmu RESET_PCIE0_SLAVE>,
+					 <&syscon_apmu RESET_PCIE0_GLOBAL>;
+				reset-names = "dbi",
+					      "mstr",
+					      "slv",
+					      "global";
+
+				interrupts-extended = <&plic 141>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+
+				device_type = "pci";
+				max-link-speed = <2>;
+				bus-range = <0x00 0xff>;
+				num-viewport = <8>;
+
+				status = "disabled";
+			};
+
+			pcie1: pcie@ca400000 {
+				compatible = "spacemit,k1-pcie-rc";
+				reg = <0x0 0xca400000 0x0 0x00001000>,
+				      <0x0 0xca700000 0x0 0x0001ff24>,
+				      <0x0 0x9f000000 0x0 0x00002000>,
+				      <0x0 0xc0c20000 0x0 0x00001000>;
+				reg-names = "dbi",
+					    "atu",
+					    "config",
+					    "link";
+				spacemit,syscon-pmu = <&syscon_apmu 0x3d4>;
+
+				ranges = <0x01000000 0x0 0x9f002000 0 0x9f002000 0x0 0x100000>,
+					 <0x02000000 0x0 0x90000000 0 0x90000000 0x0 0x0f000000>;
+				clocks = <&syscon_apmu CLK_PCIE1_DBI>,
+					 <&syscon_apmu CLK_PCIE1_MASTER>,
+					 <&syscon_apmu CLK_PCIE1_SLAVE>;
+				clock-names = "dbi",
+					      "mstr",
+					      "slv";
+
+				resets = <&syscon_apmu RESET_PCIE1_DBI>,
+					 <&syscon_apmu RESET_PCIE1_MASTER>,
+					 <&syscon_apmu RESET_PCIE1_SLAVE>,
+					 <&syscon_apmu RESET_PCIE1_GLOBAL>;
+				reset-names = "dbi",
+					      "mstr",
+					      "slv",
+					      "global";
+
+				interrupts-extended = <&plic 142>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+
+				device_type = "pci";
+				max-link-speed = <2>;
+				bus-range = <0x00 0xff>;
+				num-viewport = <8>;
+
+				status = "disabled";
+			};
+
+			pcie2: pcie@ca800000 {
+				compatible = "spacemit,k1-pcie-rc";
+				reg = <0x0 0xca800000 0x0 0x00001000>,
+				      <0x0 0xcab00000 0x0 0x0001ff24>,
+				      <0x0 0xb7000000 0x0 0x00002000>,
+				      <0x0 0xc0d20000 0x0 0x00001000>;
+				reg-names = "dbi",
+					    "atu",
+					    "config",
+					    "link";
+
+				spacemit,syscon-pmu = <&syscon_apmu 0x3dc>;
+
+				ranges = <0x01000000 0x0 0xb7002000 0 0xb7002000 0x0 0x100000>,
+					 <0x42000000 0x0 0xa0000000 0 0xa0000000 0x0 0x10000000>,
+					 <0x02000000 0x0 0xb0000000 0 0xb0000000 0x0 0x7000000>;
+				clocks = <&syscon_apmu CLK_PCIE2_DBI>,
+					 <&syscon_apmu CLK_PCIE2_MASTER>,
+					 <&syscon_apmu CLK_PCIE2_SLAVE>;
+				clock-names = "dbi",
+					      "mstr",
+					      "slv";
+
+				resets = <&syscon_apmu RESET_PCIE2_DBI>,
+					 <&syscon_apmu RESET_PCIE2_MASTER>,
+					 <&syscon_apmu RESET_PCIE2_SLAVE>,
+					 <&syscon_apmu RESET_PCIE2_GLOBAL>;
+				reset-names = "dbi",
+					      "mstr",
+					      "slv",
+					      "global";
+
+				interrupts-extended = <&plic 143>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+
+				device_type = "pci";
+				max-link-speed = <2>;
+				bus-range = <0x00 0xff>;
+				num-viewport = <8>;
+
+				status = "disabled";
+			};
 		};
 
 		storage-bus {
-- 
2.48.1


