Return-Path: <linux-kernel+bounces-720880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453F8AFC1A5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3134253EA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED421DF980;
	Tue,  8 Jul 2025 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="dEJxUQek"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1E71D63D8;
	Tue,  8 Jul 2025 04:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751948531; cv=none; b=UsqPs7p1yp2PtJtX+HWKo/61RZhQwotrBJdo2t3hBDkwJlm3AKFamdiyWghSae3Kv52pdLIx9Znnn9GqXca7Iv5vzRyF5CyyX7wUHh4kK+yfnibDuyohu1kEjac2wFBiPdr3Q9CsFFpPu47kAMgcZdBdnoyzvqGvnUuNVSEbr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751948531; c=relaxed/simple;
	bh=dfPpwCM7OcyTLw0igecA8TsBNdeOXqGRUAE177jf01o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mvbD/Dffr59uQ36l12KOpMtnkygU2i+oHWOpIUqOaHIFsRPwrjhJNvIquwfm4hEZUkRie+oWs97GN65qWGt5vAHOGgt+Q5ZFOvTqfrd2KjXwYs/vIyGeEwVPm9QmGXXKxi8Q2VBXKnukTi8rwj4UFI/hv3dt/2AONLYmZEwz1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=dEJxUQek; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kWtLMNetAysLYmRYa3XY3eQD60RB/+MFvSgGQYe8k8I=; b=dEJxUQekx06MVMJZTTUYXA37xl
	pkuF/agw4v+L4NrBxZu3pJ+SmTvyQhVdCoez7naUmj7ZqPL5zhxVLJfHK137yGXT5WKpkI2lQfyjD
	UlF3JtTzr403we24IPQtfXA1C8bf3fqM+CB0nYV0KnrVz75di+edg/fycaPIJlXaGQtPGcDBc6JsK
	FbelNOgCjI5mSUjUo/qqak3ugvcNC4ZU8qYwbiyv1/VJ6lmU0UhwCnouWdVxXR87rKRNz6HhDKkW7
	ovp413W5kmPLV3B5SF0OceE6KgU420/uKe8Pv1TC+BGTsRCYtHvf1GgpcxoQNjR/F7PHM6lw+00Hd
	2Ke6zG5A==;
Received: from [89.212.21.243] (port=45388 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1uYzqK-00GO9H-16;
	Tue, 08 Jul 2025 06:22:07 +0200
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
Subject: [PATCH v3 1/4] arm64: dts: imx93-phycore-som: Add RPMsg overlay
Date: Tue,  8 Jul 2025 06:22:03 +0200
Message-Id: <20250708042206.329208-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708042206.329208-1-primoz.fiser@norik.com>
References: <20250708042206.329208-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Add an overlay used for remote processor inter-core communication
between A55 and M33 cores on the phyCORE-i.MX93 SoM based boards.

Overlay adds the required reserved memory regions and enables the
mailbox unit and the M33 core for RPMsg (Remote Processor Messaging
Framework).

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- fix license to match base dts
- add Reviewed-by tag

 arch/arm64/boot/dts/freescale/Makefile        |  4 ++
 .../dts/freescale/imx93-phycore-rpmsg.dtso    | 60 +++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-phycore-rpmsg.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 0b473a23d120..08a1de299538 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -324,6 +324,10 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-14x14-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
+
+imx93-phycore-rpmsg-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-segin.dtb imx93-phycore-rpmsg.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx93-phycore-rpmsg.dtb
+
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba91xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx93-phycore-rpmsg.dtso b/arch/arm64/boot/dts/freescale/imx93-phycore-rpmsg.dtso
new file mode 100644
index 000000000000..23bede7833f8
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx93-phycore-rpmsg.dtso
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH
+ * Author: Primoz Fiser <primoz.fiser@norik.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		rsc_table: rsc-table@2021e000 {
+			reg = <0 0x2021e000 0 0x1000>;
+			no-map;
+		};
+
+		vdev0vring0: vdev0vring0@a4000000 {
+			reg = <0 0xa4000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@a4008000 {
+			reg = <0 0xa4008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@a4010000 {
+			reg = <0 0xa4010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@a4018000 {
+			reg = <0 0xa4018000 0 0x8000>;
+			no-map;
+		};
+
+		vdevbuffer: vdevbuffer@a4020000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4020000 0 0x100000>;
+			no-map;
+		};
+	};
+};
+
+&cm33 {
+	mbox-names = "tx", "rx", "rxdb";
+	mboxes = <&mu1 0 1>,
+		 <&mu1 1 1>,
+		 <&mu1 3 1>;
+	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+		 <&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+	status = "okay";
+};
+
+&mu1 {
+	status = "okay";
+};
-- 
2.34.1


