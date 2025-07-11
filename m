Return-Path: <linux-kernel+bounces-728105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20601B023B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC9D1CC29B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269F82F3C07;
	Fri, 11 Jul 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="htD4lNne"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7BB2F2C59
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258809; cv=none; b=eakGCOyXV7aETRIBKThqYgvZOwmhuN6TpOqmQMzS+qYiWWhZIfEMdOgXx+nomp/QTYHXDCkWi5juFZthcF4NRCbRDEKM5N7P/td310qF09ISFZSFiBH/zLhJyjxM0ly1cV4WgUFc/NXo6bh2PjWSXGdmTRbqHdaBu1KZ8o3w9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258809; c=relaxed/simple;
	bh=I2K1uHXw4EQkyH35EpeDjkCvWXqIGNmebVNMyD1Rqwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpkMisrlSluRyM4jNl71l0xSfEQ67p5CxEfzL1vXDUglXkrOlgUifeKNfMrXzcsK5j3Lo6sOJbPnPKm+/d/FTsHFGaLcT5rX8Ywlaex8NCokHKwHMFXM50JbiVBdXt/5Mslkgh1kRASRUjJT9cDCsGDO9q5LMiuv46L+PgjWfig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=htD4lNne; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-455b00339c8so6415675e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1752258806; x=1752863606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajLVmCN8EV1ROtFCYKGnJZHORiVxqh3PONYE32dE2Kw=;
        b=htD4lNneKRZcY8XkTFJQl1OF6NcqrTnRXG1/a/IUu1vCQrEzTjujc5k8ByIZiMZLW3
         u/1sGCHDephw/oNOzKgtO+jJj/AsIR0yD9OuU7CoJENMudqfIzfS0sTKyn4Ent7YjYwn
         nVjct0ug2O5gzjz8lNk6BEot3Aa75iXMAKabP1+2u4mEe3ciTt+sbPEAjcudY5e2ocoO
         I/JlcDj2KL1YtVphx/x9D6LsZ1kzT4eo38bGIK/IiFzpekNBNQpxseas34KfRefnHjRG
         XER2HoOJa8SvzK5TKjvvOjUebNRim5aX7ZdA95rv+VFqTjvKSsQ5LGUGIYuxNYI0hCjW
         7otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752258806; x=1752863606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajLVmCN8EV1ROtFCYKGnJZHORiVxqh3PONYE32dE2Kw=;
        b=Ng5CUX1W+oBF34+QUYnzXI1RA3lO1osn0SwRlLvbJKCTzcnYZ6j5+dymw3vxP8EL3h
         AxGcgXvWn6BhTn/EwAr7oWvp3hO0Zh+PkchSSGzc79n5C5E7qEW0rHyvYwBrbUwxVNdY
         NmNqYEVEGVKvAaVSLaHvDsyFelw+GzT00Dhu8T3iVtzK0G0cariBvi3+Ou9mS5st6/vY
         d2S+Nr3r22ui0Bt8ZMy1cpGDwXAsB3FRqQSqOUWwMIM+UvKvSsZ7XNHXX8HIAg061RIM
         i3x0jfKqsYmWpGMMlazZ12+eg3WRblVTIhy0XCUbA41C3WrR9Ea/zIo4qEK6WqHgDz5i
         lAkw==
X-Forwarded-Encrypted: i=1; AJvYcCUuC43aLeNfIQ+iF82q2QPkPmpZa/v8c9sax+FQwmZMxhkPv8lDFvQ5Oc7hMYg2InjjmpFZalAcdktnFiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHh8KK3UVKFbFdzA0UN9QO+X/7tksLzU3P2DwLHwyMR0iL2YFa
	u62lHBPBR7SykwjwKvceaPNuQpWCeheWOWVWNgBJ/pzixEKVlNROjq9o6HbKklq6hWU=
X-Gm-Gg: ASbGnctxKwCGYksPun61gBc0ACyizpuc7rX3Rh5J/pBk6s6sqB0G0j+oqadmYW52aCt
	zrBcSkzEs0JdMouI64lZFHWxwveH4TjFqyT/tq3utYcEhB+iow/aB6q+hBBC406yPQm7y3jJAsO
	JrfP2+bTDzdpEUcYiCFtZUigrNg3NTKUYbEeeRCkSls2cO2dCNQQIwkUBR3noR4XYIaBrLLtYpw
	BqWdSuhIwWeG2hqz4eGl+P+Mu7m52sJNT+3pieYKbEDL7dMfV7wNim3xLZvn6AewBSZjL5YxkTO
	RriF2+bW9RNBOEVkssgJlsmCXffCS88gUf0qjyWp6d2uNDMMoXEBOQYmp23238jxkq6nSy36tfC
	1c4OJyH+ru4t7mjswbVCuOm+Oh+H6sicMofKcn0PdTSkfjl+YPddKa4h3MA2K
X-Google-Smtp-Source: AGHT+IHoIVVNWSLMADUf1EqgQlVt++Sa+z/qkL2VbBz8sznu1zu8Z81BC5P4gKRYQcV0niTuA1b6wA==
X-Received: by 2002:a05:6000:4108:b0:3a8:38b4:1d55 with SMTP id ffacd0b85a97d-3b5f18dc7dfmr3898978f8f.28.1752258806040;
        Fri, 11 Jul 2025 11:33:26 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:bed2:2848:b66c:32d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45601053020sm705205e9.36.2025.07.11.11.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 11:33:25 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dlan@gentoo.org,
	palmer@dabbelt.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH 2/2] riscv: dts: spacemit: Add OrangePi RV2 board device tree
Date: Fri, 11 Jul 2025 20:32:45 +0200
Message-ID: <20250711183245.256683-3-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711183245.256683-1-hendrik.hamerlinck@hammernet.be>
References: <20250711183245.256683-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial device tree support for the OrangePi RV2 board [1], which is
marketed as using the Ky X1 SoC but has been confirmed to be 
identical to the SpacemiT K1 [2].

The device tree is adapted from the OrangePi vendor tree [3], and similar
integration can be found in the Banana Pi kernel tree [4], confirming SoC
compatibility.

This minimal device tree enables booting into a serial console with UART
output and a blinking LED.

Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-RV2.html [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]
Link: https://github.com/BPI-SINOVOIP/pi-linux/blob/linux-6.6.63-k1/arch/riscv/boot/dts/spacemit/k1-x_orangepi-rv2.dts [3]
Link: https://github.com/orangepi-xunlong/linux-orangepi/tree/orange-pi-6.6-ky [4]
Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
---
 arch/riscv/boot/dts/spacemit/Makefile         |  1 +
 .../boot/dts/spacemit/k1-orangepi-rv2.dts     | 43 +++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts

diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
index 92e13ce1c16d..152832644870 100644
--- a/arch/riscv/boot/dts/spacemit/Makefile
+++ b/arch/riscv/boot/dts/spacemit/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-bananapi-f3.dtb
 dtb-$(CONFIG_ARCH_SPACEMIT) += k1-milkv-jupiter.dtb
+dtb-$(CONFIG_ARCH_SPACEMIT) += k1-orangepi-rv2.dtb
diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
new file mode 100644
index 000000000000..8313f9589cd2
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Copyright (c) 2023 Ky, Inc */
+
+/dts-v1/;
+
+#include "k1.dtsi"
+#include "k1-pinctrl.dtsi"
+
+/ {
+	model = "OrangePi RV2";
+	compatible = "xunlong,orangepi-rv2", "spacemit,k1";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x00000000 0x0 0x80000000>;
+	};
+
+	memory@100000000 {
+		device_type = "memory";
+		reg = <0x1 0x00000000 0x0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led1 {
+			label = "sys-led";
+			gpios = <&gpio K1_GPIO(96) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+			default-state = "on";
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_2_cfg>;
+	status = "okay";
+};
-- 
2.43.0


