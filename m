Return-Path: <linux-kernel+bounces-834981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB1DBA5F53
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4516C3237D4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3822E1F0D;
	Sat, 27 Sep 2025 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONPu0GbY"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0E72E1C56
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758977418; cv=none; b=FgiKC6yOqF6flwfUy9VMnvconnotkdscivSiZ8X4BX0mtsb7JaM3U3umh+IOWc5vEDT46KchAfA6hGqj/nKO67QXi2brWa4cuhHHs1fh+lNfeHoiOL1x0TzngkqobbIVXqEAZuFhailHe9oZrMJas6/RfMmktEWIrAf3LatPjWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758977418; c=relaxed/simple;
	bh=huLbVfzkLBTQUQlz9ORWw3HgW7xhCMqSQsZ/AWFnNOs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMnDR9uKZmXelipnWJGj8qBOwFU5jdx7NfF4ybjZn0s8OLmmewyW6clMgvo6q0/s3C91e3lIEYsApeVKw3HGcmRoK7wtESyRiN4bFMgmQAXg59g8Rs/BjGJIdMCUzp5WjknJ0ZOQ6L/jeMwyOfoebCvDepjtY3YmPKnfmsDCIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONPu0GbY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so29270685e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758977413; x=1759582213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvqCH35JXfb+heqlrUNAEgD5kXF3T57R7NZ3MRlHDho=;
        b=ONPu0GbYi89BuDjHHzuWQInBqWVIymhs22+4mVans0RnMOk6YqGtMlLsFTFZhNv9wJ
         FSnpzPELVNs+mmvin6iQt8IQ3f0omxHHYwnl0bVALAxbuQZiutt/xd564Jx6saRS054n
         yoXax4W2jqtmdAIQJeJtotOHGKW6FcDJCwEqcSHLJq7XJFIzm6WNLCI7aN5cLjPM8MC2
         ue+umFPWSyikQbFFo4l7rMHoCZoFKX1FHJnMHrnQuoEBi7zFF1Z7KMoapkROzxg4y4dM
         mAfvu2bUmvVvo+m+fDyxZr3O+DNZmepqDiG2B3FmUPK/zRA8a+/PepTyXYKfmwNH/ptR
         wbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758977413; x=1759582213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvqCH35JXfb+heqlrUNAEgD5kXF3T57R7NZ3MRlHDho=;
        b=OsQWaxoGakFOJDTH5tJVzn1MNo16+Ei81OFW+/bBwsmlcN4RIIvQfD5WcTKr7GDpqd
         +Wsowa+tfyYnNvNEbP/5fRxYLWABce4noJ7y13UWfDjApJm98lF89TWEXTzdK+kJx194
         4cdEIS1mgh4C/UU1ZOHPoOb5iQ1J2AAxXZGt6Ib/qIyIgkTbAkeNtKdnvYoQE5F8yHXr
         +UggO6DjmJ5sdWKzynZxkhIymzHSG0FmAoaiewh5pJmCqcmudQNQkpaZSnd7ZzDvwqXb
         slMFLOholQGY+3fXqmJAL8gVVIMOi59owaWlRAPvbz6ZAmsdvdUq329NETvv2d0lJW26
         pO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVeEJ2cXQ4sxQHdUxGLfZcws8NwBrRzMhVZLAd19NaEz/iAl/pG1reNRBZIyZhfXPCyxFHndIB2LwDv5I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMjfSp2flL/bKc8e4WulxQG4AFITIEFGq349u790TxbgxihnsM
	CBEjspVZnvmIwp3wJR3eM/naKPZaDxiJnPgKs5kvXDodHMqpNGH7Qvbd
X-Gm-Gg: ASbGncvK2ax6bx2n8Dtr9HYNvdqFZfatzk/if9fYcRdbD62/iucSS0jneA7XnWLzz6b
	Wy6MXPA6tX5UpbP3hbGF2XPPK5DVwYBGHvhDzDcFsPOEC2/Xy1WSCSPZ501h3TgU6lF5HPf+0Fr
	mGPtQdEYvIUP1PZeKJwhGUSUJ8xG9ut6pSb+1+4gle/5w+8UVN0zqOlbMq3ThrS3sHP8q1F8mJa
	LhPw2UNkTttrSdiU2bIUJ22Uim/KJjW0yPZkEoWKhlK5OvNlT9anLpQSzyjKzxYOGO7U+KjEAxZ
	Znj1cvG9ezkKII3lo1EiOSy3x5m3j7M3tYzl1ZjA4GuZQ4E+3YOKM/+Pvshng7juSvylREHJsFL
	JZTIAUu6rv8Fw5b5BFJrmOhEH1E0=
X-Google-Smtp-Source: AGHT+IGFiza2PyST1hvBpar3qyMF627+xP0YSabLGMeYvzRG6Xn1tvxP7J8jmmQXhXGeK1SK484Oow==
X-Received: by 2002:a05:600c:1da1:b0:46e:37fe:f0e6 with SMTP id 5b1f17b1804b1-46e37fef1cdmr84106095e9.30.1758977413198;
        Sat, 27 Sep 2025 05:50:13 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bede39sm115338255e9.18.2025.09.27.05.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 05:50:12 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: meson: add initial device-tree for Tanix TX9 Pro
Date: Sat, 27 Sep 2025 12:50:06 +0000
Message-Id: <20250927125006.824293-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250927125006.824293-1-christianshewitt@gmail.com>
References: <20250927125006.824293-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Oranth Tanix TX9 Pro is based on the Amlogic Q200 reference design with
an S912 chip and the following specs:

- 3GB DDR3 RAM
- 32GB eMMC
- 10/100/1000 Base-T Ethernet
- AP6356 Wireless (802.11 b/g/n/ac, BT 5.0)
- HDMI 2.0a video
- VFD for clock/status
- 2x USB 2.0 ports
- IR receiver
- 1x Power LED (white)
- 1x Update/Reset button (underside)
- 1x micro SD card slot

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Checkpatch generates the 'phy-mode "rgmii" without comment'
warning but this dts is using the same rgmii format as all
other Amlogic boards, so I have omitted a comment.

 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../boot/dts/amlogic/meson-gxm-tx9-pro.dts    | 90 +++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-tx9-pro.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 619dce79b020..219fb088c704 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -80,6 +80,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-q201.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-libretech-pc.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxm-tx9-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-ugoos-am3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-tx9-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-tx9-pro.dts
new file mode 100644
index 000000000000..9a62176cfe5a
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-tx9-pro.dts
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2016 Endless Computers, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
+ */
+
+/dts-v1/;
+
+#include "meson-gxm.dtsi"
+#include "meson-gx-p23x-q20x.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	compatible = "oranth,tx9-pro", "amlogic,s912", "amlogic,meson-gxm";
+	model = "Tanix TX9 Pro";
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1710000>;
+
+		button-function {
+			label = "Update";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <10000>;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <100>;
+
+		button {
+			label = "power";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&ethmac {
+	pinctrl-0 = <&eth_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&external_phy>;
+	amlogic,tx-delay-ns = <2>;
+	phy-mode = "rgmii";
+};
+
+&external_mdio {
+	external_phy: ethernet-phy@0 {
+		/* Realtek RTL8211F (0x001cc916) */
+		reg = <0>;
+		max-speed = <1000>;
+
+		reset-assert-us = <10000>;
+		reset-deassert-us = <80000>;
+		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_15 */
+		interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&ir {
+	linux,rc-map-name = "rc-tanix-tx3mini";
+};
+
+&sd_emmc_a {
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
+};
+
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
+		max-speed = <2000000>;
+		clocks = <&wifi32k>;
+		clock-names = "lpo";
+	};
+};
-- 
2.34.1


