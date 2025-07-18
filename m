Return-Path: <linux-kernel+bounces-736539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B77CAB09E43
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191A51C20B69
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E20D296161;
	Fri, 18 Jul 2025 08:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="jy02NJ3W"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AA12951CE
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828272; cv=none; b=OxHp1IVsD/VoVFamq7K7wNbJCFzmNkOu6GucDPIPl7Z0p2KD+WEuecS3Y56ZoAYCCMvuxvvu4oerNvWE31OSmHRDznAAa2qjDtQhYTwe1yjLBUDLLzKRgio70xMYHlvZ7pGGr7u9aJD8ycq7bW1C9HjDTxSnfBE9yl7zWhaGBsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828272; c=relaxed/simple;
	bh=b2MYDK+PAwESQkrD0k9SN6tJHVK+oPHFALbYh/bbzxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In+MXx8u2t/WCZYvMWqodXhjxFPfHvZ0E7JK7EVEWrBc3MwhUr8dqBVQH8cZojAP70CiPK7lk4BoflcUsrobhvKOcIiv2ym7DnbCFu2WNxecDdWXVhpaihfqYR28920gzRcgHYrawMKZy+xa2hn9iRKoLD2MW7jaf5oFWkhZw5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=jy02NJ3W; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so2756335e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1752828268; x=1753433068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZF7vneJ/oeaOQ29Nz/sbY4GH4SE3qUarTuWdFIe75qc=;
        b=jy02NJ3Wt8fw5spFKf+nFw/jYgIT0UZ8xUTLX60XEZTODPhsDsOtxjttR2NcfJcuFO
         1PFEPqzas1eU1KhfHxrII1l6qtoVs3akOpUr/qgwArBFd17a0jFEiuFwEFvss9XCcriE
         URhKKSmjl3pXnesHtTIDLtnDPNU6wpyhREnmPwiR8v2vAZ8pmIQExI7mCoxu8bQ7HUSi
         0vHLkW7oXXczUHHrMD8c3sDHJ/GMsKh3HsZIMke7mBcVRecglw474RNFS/A0nQnzZg78
         PFicz/B0RXd+CY+DspzvdA74IxHokXg+mQpeVt+kbEJr/qaZBykbJW5FLAe7jcnkYLRu
         1WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752828268; x=1753433068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZF7vneJ/oeaOQ29Nz/sbY4GH4SE3qUarTuWdFIe75qc=;
        b=M/0UuROSxwxQ01hSslY18nIMc2J9ksIuySL7cPUvDOXyisHVrO+FxBn/KWxgZ7+Yue
         nTfJDaRi1x4MVhARoinnB3UE9cuw++k3SlxTU7DGVlORYAYifZcjxTs33HuARdFsI/0K
         02uBKo8ys9JtY8GwdygVkwqDB93utHFriBLhPQKPNnFYIKZvFRG/90whqkIGHC8s51+p
         cRImQafrzKSK66iq6bWTjhMWCuUPhqeP5BFbbR6PzJ1iKcv93BW+EYn3SM5xd5KTeT/k
         TnHPPyKBQOtoJjjAnXPqNxvwO+1XRti7tuzAuMbLJYTxvP3TgiY7BYO8iPv3paOy4i4s
         IYNg==
X-Forwarded-Encrypted: i=1; AJvYcCVg0Mu/3OjegYZkuXIJOAAmfOfwePXHbMJ0TYl0jnhKZ713O9nqz/h3mbOD/3PUMfQJB3zyvzE7RdogpGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEdnDQoL7IUbOzAu9Zh1kHw2RbXb+04AIaDG5XepN/40SA7iZq
	ektQLRdDitx0FX8DPS/sdCW5QITyTR2kOX5ERhm0fVbC/+9labGTaCAAnbj6bhNlEyY=
X-Gm-Gg: ASbGncta+Ut0atGxQDwnGdoIdle5e3/HUzBg6JslRp2bTKuWN6K97eCwqsmSJXBDBEB
	8KxrsJhLKA2DDpwhANo1/IahSWtBi+wKRXsM36XWQTarTWa6tI9x0wx0JQlmcfxyvfcBUhDQ2Ws
	VLBDFDdUlzAsMKsZylw+ieY7sbqzK5lLsVSI7vK2MRiOJ04IbABkgzMwL0blE+23xjjAH+T1O1J
	Ix6DusY51x8Xb3poNbLJ2T3yOEt5C7TGSPddooAO6IptC4YcZamSdgp/yZn+QqZErucMGRKB3ho
	ftGbmOJou3G/77hyyIRq1Q8UwIavoe68V9NQSJV5wLfqS5ug518pmWFkAck/UBuUQ+mrqWbpTmH
	UFKorXXuUVyWoCgGmOBUYoX597/qcRb71hmBGl7+U8H4TZJIQ
X-Google-Smtp-Source: AGHT+IGqz0s/AaH2jo7lzKlm58e4CdVC6fpR5T/WfzdfwX2FhNDW9nmVqoPf2WlNPuA5uOQWGsE3zg==
X-Received: by 2002:a05:600c:8b0b:b0:456:1442:86e with SMTP id 5b1f17b1804b1-45635e6d11emr49725385e9.21.1752828268318;
        Fri, 18 Jul 2025 01:44:28 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:9aa9:dd5c:bad6:e31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45627962384sm58208115e9.2.2025.07.18.01.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:44:27 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	palmer@dabbelt.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH v2 2/2] riscv: dts: spacemit: Add OrangePi RV2 board device tree
Date: Fri, 18 Jul 2025 10:43:39 +0200
Message-ID: <20250718084339.471449-3-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718084339.471449-1-hendrik.hamerlinck@hammernet.be>
References: <20250718084339.471449-1-hendrik.hamerlinck@hammernet.be>
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
Changes since v1:
- Added the aliases section to the device tree.
- Removed the memory section, as it is populated by the bootloader.
- Replaced unclear copyright similar to the other K1-based boards.
---
 arch/riscv/boot/dts/spacemit/Makefile         |  1 +
 .../boot/dts/spacemit/k1-orangepi-rv2.dts     | 40 +++++++++++++++++++
 2 files changed, 41 insertions(+)
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
index 000000000000..337240ebb7b7
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ * Copyright (C) 2025 Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
+ */
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
+	aliases {
+		serial0 = &uart0;
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


