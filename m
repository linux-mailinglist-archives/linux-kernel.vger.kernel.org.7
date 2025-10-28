Return-Path: <linux-kernel+bounces-873710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D05ECC147E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F83625359
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8B031AF31;
	Tue, 28 Oct 2025 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="KS/nLSgx"
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B540531A55A;
	Tue, 28 Oct 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652705; cv=none; b=MM8BLF+F110AIwviPRTZZgP4J+jiWzgYAoG24uXoWppkwWZzCumf5RWy0N3MosW+pq9ddpDTfCzebthaZk50E6aDjtq8ERcfXM5krErLLGtsCEVMtrehQV5NfikZSZLlqLctkrw6wL31J1rAXEvl3AR9x3yj95/FAsFN8LjtP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652705; c=relaxed/simple;
	bh=tjyeRnRhauUM9QW6d558OK/NIw7uinAYUHhwSLvlOR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HrTtWrvFxH66U1ZI3Ns+UK5zFznoYH9KQvyleQA7Zo7Xhn8X8KVcaBpqxKNOo2HpF7aUM3BKGUb3/mCAuLASKbyLzoLEKCaiBsbg3oTDBrO/mhCACTjmZwELx/STGVmpGZ374HmooL8zddhIGRjl+3Yjzzb2V8kLNJgaKnk1O64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=KS/nLSgx; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=g7D04cr7fjT7rjTu2A49pG6aFgCTS9pQ6fDcN6oGIi4=; b=KS/nLSgxgnKYjQobvtKiTe9AqP
	RMotu9k/Qw2lkfbODshME8Z5TEDmEqWTzO6/N1TBaFb646DxLw7vV2lmP01uRlUZ1wHip1Q2PFvZj
	/cvtBxHwMak6hKnSHcVAZYdZctkfWHo74oQPzqqQgo9z1KzpEh0kGCaQ562Yn3N4IzHlaq+kAq1Br
	3CUYFPmezmPL2zTTkT2u9YFdlC9xPQie36j0Sl3iMPPIo2GX7y3I20TXuuKEOyQUBqO7yxT44gvdy
	t4sveW2V78/2kI8fFFz6QYNjnUKp1LOCwmpeCd2T9rb6jP3hqfNHcGoAjg+N5UCch/NXg4QrWmIg0
	ClBNFqaw==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:39330 helo=localhost.localdomain)
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1vDiLI-00000009Q7M-0E1n;
	Tue, 28 Oct 2025 12:58:22 +0100
From: Primoz Fiser <primoz.fiser@norik.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH v2 1/2] arm64: dts: freescale: imx93-phyboard-nash: Add jtag overlay
Date: Tue, 28 Oct 2025 12:58:19 +0100
Message-Id: <20251028115820.3165399-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Add overlay to enable JTAG pins on the board's JTAG (X41) connector.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
Changes in v2:
- add suggested explanation comment

Link to v1: https://lore.kernel.org/all/20251007084028.1125185-1-primoz.fiser@norik.com/

 arch/arm64/boot/dts/freescale/Makefile        |  2 ++
 .../freescale/imx93-phyboard-nash-jtag.dtso   | 31 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 34a81d34de39..33151065684f 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -357,10 +357,12 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
 
+imx93-phyboard-nash-jtag-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-jtag.dtbo
 imx93-phyboard-nash-peb-wlbt-07-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-peb-wlbt-07.dtbo
 imx93-phyboard-segin-peb-eval-01-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-eval-01.dtbo
 imx93-phyboard-segin-peb-wlbt-05-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-wlbt-05.dtbo
 imx93-phycore-rpmsg-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-segin.dtb imx93-phycore-rpmsg.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-jtag.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-peb-wlbt-07.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-eval-01.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-wlbt-05.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
new file mode 100644
index 000000000000..89f93dca3208
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ * Author: Primoz Fiser <primoz.fiser@norik.com>
+ */
+
+#include "imx93-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+/*
+ * NOTE: Bind pinctrl_jtag to gpio2 so that the pinctrl settings are applied.
+ * JTAG itself has no dedicated driver, so without attaching it to an active
+ * device node (like gpio2), the pinmux configuration would not take effect.
+ */
+&gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_jtag>;
+};
+
+&iomuxc {
+	pinctrl_jtag: jtaggrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO24__JTAG_MUX_TDO	0x31e
+			MX93_PAD_GPIO_IO25__JTAG_MUX_TCK	0x31e
+			MX93_PAD_GPIO_IO26__JTAG_MUX_TDI	0x31e
+			MX93_PAD_GPIO_IO27__JTAG_MUX_TMS	0x31e
+		>;
+	};
+};
-- 
2.34.1


