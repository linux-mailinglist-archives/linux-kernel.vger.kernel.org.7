Return-Path: <linux-kernel+bounces-766335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F8EB2454F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4E5722EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225A82F2915;
	Wed, 13 Aug 2025 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="jNQArNSe"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1A2F1FEC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077020; cv=none; b=YBAzFGaSArEGTfwIA+6/5iooo2akMrqiV2SStPIKYHytNHKmNZ1GwccHgxG14i15aQuFPhKInzsXcj5UFQgvSpqcLVQdAzDrINkqU/0ubrZuKtj9j3cnTU2j5PzvFfsOUepf1qR6ABM9ORSNzwDRIL0nncFKgOAz00NKcxKj/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077020; c=relaxed/simple;
	bh=YgCbgenFVOzNh67wJb83oSCGyPXaTZ71l6QIJbUP6yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOxWJ0QwjQvxK7dJbvh1OkHVcyrdMUTvlhuFBMD4lCaS9yDA0GedUGhQ+/9Rx+MJFCd5qF1vgt4fp4jFSWsaxM5hUzi3PbfA3L/4Ow5xOVU31jaKLgtn5pEq8G9Gxs0895dTqkeGX9OMEpvKNmduuec6ZVAyPB7StyrV2Lqt8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=jNQArNSe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9141866dcso910163f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1755077017; x=1755681817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1TU+Xl0n1RhqfO3nfZOueztwfTTkM2m62EBReINxsY=;
        b=jNQArNSe1+MXXA51jaUb/nrNYwSdt8uuMBzP+kDR9TU6NNyHnGqopw3vGweTJhI65x
         T8DMM/474GBzvxMXX8AIYGa7hSS13qfsCRuiaMEz32o9PTJumyOFll6+jPsem/bdpPue
         7LXd2P9MlVMzDD09fneRU08H1t8rJUhbmLXEEPNqiJD8blW5LHBABheOgMbRrUo5ELPl
         Vx3LYLzakNAGGhEDUBuCx9+tJ9ARn/dm6DlHuXSrS+5Yt1KPFiwFsOTt5Y0LVV/W/ZUN
         gGB3CFz7uYZF6sQruj/+vGSn+PFeQCPo1usZKuBMdKapP1pz4pCy0Nnl4mD3RU3mCCMP
         a2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755077017; x=1755681817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1TU+Xl0n1RhqfO3nfZOueztwfTTkM2m62EBReINxsY=;
        b=DJ/oAlakHPVygm0uvAwWdGqvkwaZOt9JgDySOAxcXxd++ezc+NWBVZAv1V/CjtoaTm
         9fJSKjy727jZqLW5bqFd9LozZkOlZxuJU5binC/NyyUOlynW+TIvlqoro5PFOHowZIzN
         5BuLMha0M2lz95hvnE44+YNJ41UpHbj3eDfJNHik0R/95SEvxdw4aApO9flUkGm2Ob02
         sJhSDgw0sdYsnhK8CmzXImq3FL5LVzWfyMDO8Ad0/1WofTkNmo//N8qTQ+wcG175fjux
         nrlstts0bL1UDnXWS+vGRpL0sEsLf4n9+gNpDpNjnRKy10zfj9gEDCNaqybs3RFeHjez
         qD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr7lUglPNioZC25yPFZhT8ZjFiSDgxmvcBkzD6E3eqwKfwoP8BdZ40SE5FH/gnRe3bwpsIQYmw1h0ZSzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1cEmU2l2RQ/vyGP9P/MisbxSykbtl9EiPEOHlbzlXJjfM6Zu5
	8Vdc6p9u72J/Fvcx3YclnlLdt5CGUUnc0FJlvh7B+wBUunmnZokUWsOqBsCxzWeZbiA=
X-Gm-Gg: ASbGncscJYTlzQw8YZ4YlXQw1FJ2brg5pczmffmTAXXKqLFP10fBe4kr35+WPrjuHbd
	Qv+L2ICVtBrGJG0UiezKbIR4aXREc2tUV4KiAE44TqMeQ2WbuIirE5Lg5hiES9w7+J8vsDi3F8r
	Qg9GTRGbhpNC/8uFxyO87ejFFGEQN38VroJTzFFj0rSA4uI3ne4RwRso5u98+ZuLaHppW0sNFU/
	CfND6yMn5ogwUdoY0dTjeWlgB6iUqhCEJkCTzPyLyrF8EYGAQlkyMKZGyChsMRbBf52sH0F/D9X
	vfhipQ7ah+uitdZl7WQu5flBwIpKNOJoo/el5BkOhvGC4lVRdqGzptqKNQ8wqHg6u8L4pHTM0fW
	RqW/W8rS/zIXr2HPtTauQSbtwaazy0fz8dNQwyHbBqAaSgpvvAg==
X-Google-Smtp-Source: AGHT+IE3vtz1ELNgTuw1NVDgwEF012pagU0/e5TxjB4oj/3WIMChqDWH9mXGzW1B/LaUDhfksyi79w==
X-Received: by 2002:a05:6000:2087:b0:3b7:905e:2a32 with SMTP id ffacd0b85a97d-3b917d2a92dmr1794493f8f.12.1755077016260;
        Wed, 13 Aug 2025 02:23:36 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:d33c:e682:2af6:3c3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac158sm47966077f8f.4.2025.08.13.02.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 02:23:35 -0700 (PDT)
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
Subject: [PATCH v3 2/2] riscv: dts: spacemit: Add OrangePi RV2 board device tree
Date: Wed, 13 Aug 2025 11:22:40 +0200
Message-ID: <20250813092240.180333-3-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813092240.180333-1-hendrik.hamerlinck@hammernet.be>
References: <20250813092240.180333-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial device tree support for the OrangePi RV2 board [1]. The board
is described as using the Ky X1 SoC, which, based on available downstream
sources and testing, appears to be identical or very closely related to
the SpacemiT K1 SoC [2].

The device tree is adapted from the OrangePi vendor tree [3], and similar
integration can be found in the Banana Pi kernel tree [4], confirming SoC
compatibility. The main difference with the current Banana Pi BPI-F3 tree
is that status led is using GPIO_ACTIVE_LOW.

This minimal device tree enables booting into a serial console with UART
output and a blinking LED.

Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-RV2.html [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]
Link: https://github.com/BPI-SINOVOIP/pi-linux/blob/linux-6.6.63-k1/arch/riscv/boot/dts/spacemit/k1-x_orangepi-rv2.dts [3]
Link: https://github.com/orangepi-xunlong/linux-orangepi/tree/orange-pi-6.6-ky [4]
Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Reviewed-by: Yixun Lan <dlan@gentoo.org>
---
Changes since v2: improved changelog
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


