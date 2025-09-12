Return-Path: <linux-kernel+bounces-813252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1166BB542AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE62248023F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6CE27FD51;
	Fri, 12 Sep 2025 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XkeTqY9h"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD09D1DF270;
	Fri, 12 Sep 2025 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757658038; cv=none; b=eelwjdyNr+Irh57ttZJWuYDg7aZsx+TLbvOKWHszEg8YnQZkZgRVg5BdS9XMbo/0mLQ3iF/Y//LYIXN8qqswhr1QDlCEB85MOXZ/acgny0jNYj41leBGEMvNfeTBrTj3zG+cG5U1puRrbn+wK7pwlWjVQ4bGGxBOCSZVMRd2LCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757658038; c=relaxed/simple;
	bh=FkxNUGfHipRH/jeWIQdpx9jQo9D+wQJJne799VoKjns=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WUTP+k1Uh9Tm1qLHGdTvjF1lfWqx3ceH7xO8z5tyTWpEDIfiNHJsttNzphasFZy4i6td3zq5rwpqsSbshakmCQhRyBCii5By7eg2JiIPAFARL0xXHdNAY4b1IuReSywBDIHjC93npgnFVFVNG77Nmc/aYcgeE8+Rz6HJ9Jk52hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XkeTqY9h; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C6KRt8458365;
	Fri, 12 Sep 2025 01:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757658027;
	bh=6LH87+1IiY/lYyLvbTQW2dEczZuDxUoWtu5AqiVG26Q=;
	h=From:To:CC:Subject:Date;
	b=XkeTqY9h7X5uhDfwbJRyfbtlmdQdsmsrsJAFT+BH0J8YpP26KHDZtqAuOV+jiloN5
	 DBXgEAZhWLIWivijHykP0065sHLJl35ulcEyVXouR4vx1egIJn6O3bGX4YOmrSCt6B
	 eXWVtVn62g/KpzIIsPEHBBThEM40Hr9Smec4RZU0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C6KR8t2560140
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 01:20:27 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 01:20:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 01:20:26 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C6KM8v3143558;
	Fri, 12 Sep 2025 01:20:23 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j721s2-evm: Add overlay to enable USB0 Type-A
Date: Fri, 12 Sep 2025 11:50:14 +0530
Message-ID: <20250912062021.2906034-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The J721S2-EVM (J721S2-SOM mounted on the J7 Common Processor Board) has
a single instance of USB namely USB0. On the board, USB0 can be enabled
using a single USB interface at a time among the following:
1. USB3.1 Gen1 Type C interface
2. Two USB2.0 Type A interfaces via an on-board USB Hub

By default, USB0 is enabled using the USB3.1 Gen1 Type C interface. Hence,
add a device-tree overlay to allow using USB0 with the USB2.0 Type A
interfaces by configuring the "USB2.0_MUX_SEL" mux. Also, since the Type A
interfaces only connect to USB Devices with USB0 acting as the USB Host,
set the Dual-Role mode for USB0 to Host.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20250911.
Patch has been validated on J721S2-EVM. Test logs have been provided
below for the default case without the DT overlay (Type C Interface)
and with the DT overlay applied (Type A Interface).

Without the DT overlay, USB0 is configured with 'dr_mode' set to "otg"
due to which the 'lsusb' output does not contain any output initially
as the USB Mass Storage device is not yet connected to the Type C
Interface on the EVM. After connecting the USB Mass Storage device to
the Type C Interface, USB0 assumes the Host role and enumerates the Mass
Storage device. Following this, 'lsusb' output shows the USB Root Hub
and the USB Mass Storage Device. Test Logs for this are:
https://gist.github.com/Siddharth-Vadapalli-at-TI/6bc1434b7d949a2f2c43d55811aee661

With the DT overlay applied, USB0 assumes the Host role by default, due
to which the 'lsusb' output contains the Root Hub even without the USB
Mass Storage device connected to the Type A Interface on the EVM. After
the USB Mass Storage device is connected to the Type A Interface, it is
enumerated and shows up in the 'lsusb' output. Test Logs for this are:
https://gist.github.com/Siddharth-Vadapalli-at-TI/dc3443be624b61d920833f1a66ab356a

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/Makefile               |  4 +++
 .../dts/ti/k3-j721s2-evm-usb0-type-a.dtso     | 28 +++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-evm-usb0-type-a.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index aad9177930e6..1e4829801e49 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -131,6 +131,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-gesi-exp-board.dtbo
 k3-j721s2-evm-dtbs := k3-j721s2-common-proc-board.dtb k3-j721s2-evm-gesi-exp-board.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-pcie1-ep.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-j721s2-evm-usb0-type-a.dtbo
 
 # Boards with J722s SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am67a-beagley-ai.dtb
@@ -230,6 +231,8 @@ k3-j721e-sk-csi2-dual-imx219-dtbs := k3-j721e-sk.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
 k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
 	k3-j721s2-evm-pcie1-ep.dtbo
+k3-j721s2-evm-usb0-type-a-dtbs := k3-j721s2-common-proc-board.dtb \
+	k3-j721s2-evm-usb0-type-a.dtbo
 k3-j722s-evm-csi2-quad-rpi-cam-imx219-dtbs := k3-j722s-evm.dtb \
 	k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtbo
 k3-j722s-evm-csi2-quad-tevi-ov5640-dtbs := k3-j722s-evm.dtb \
@@ -272,6 +275,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-j721e-evm-pcie1-ep.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtb \
 	k3-j721s2-evm-pcie1-ep.dtb \
+	k3-j721s2-evm-usb0-type-a.dtb \
 	k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtb \
 	k3-j722s-evm-csi2-quad-tevi-ov5640.dtb \
 	k3-j742s2-evm-usb0-type-a.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-evm-usb0-type-a.dtso b/arch/arm64/boot/dts/ti/k3-j721s2-evm-usb0-type-a.dtso
new file mode 100644
index 000000000000..fe4a23efe708
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-evm-usb0-type-a.dtso
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT Overlay for enabling USB0 instance of USB in the Host Mode of operation
+ * with the Type-A Connector on the J7 common processor board.
+ *
+ * J7 Common Processor Board Product Link: https://www.ti.com/tool/J721EXCPXEVM
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+&exp_som {
+	p0-hog {
+		/* P0 - USB2.0_MUX_SEL */
+		gpio-hog;
+		gpios = <0 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "USB2.0_MUX_SEL";
+	};
+};
+
+&usb0 {
+	dr_mode = "host";
+};
-- 
2.43.0


