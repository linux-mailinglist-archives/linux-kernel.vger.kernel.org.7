Return-Path: <linux-kernel+bounces-833720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42628BA2D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9180385522
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E03428689F;
	Fri, 26 Sep 2025 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lAgR5Ux2"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C618928BAB1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872427; cv=none; b=LHoDTFijfoRyAl76BZfwZXqeRfWhS+lNW6fyDnROXSzRA1bOQx0y6WGzLBY1k0rnQp7aggbfcA7PMnzkg5gVFeu8FcpV9xFZwYZykddqDJP4h7uMwdxk1grFfnASaj0bXZejrpHxDZ8KMX7fDvwOLj6yclSYdxaol0sPqsWCv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872427; c=relaxed/simple;
	bh=reQEi00whED/ll36t7i3HZbucSn2+baZhGx32o4WuaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Ie0u55UUWFTs2BrvOmSR2WTWxCu4EOCGzquFmpAOE8geJ8q2KbbR5R4JZd4AjnCtawAHj4Y+3cyp2ahJZPEPY8pnv//z1nY3SwKpMEzQqUtcQZj4ye1joTtxfHI8MMCn0YJ54vON2oXKrKz/7ZYkgMmC7/QM4hb19Gj4eNv0DrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lAgR5Ux2; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250926074023epoutp044e01d30f5bfa0ee0bb921bf44b333bdc~oxSZntUUK0552105521epoutp04K
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:40:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250926074023epoutp044e01d30f5bfa0ee0bb921bf44b333bdc~oxSZntUUK0552105521epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758872423;
	bh=aZjO/7aUY2BQ0jofA/G8I/j0xLETJuzN3cVoRjzP220=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAgR5Ux2j98meDZ1r60coZPkzQ9W4ZHeb+8/Y68Lb1BIKsfQHVGl3UGkbr/RAHj4w
	 UkQI7PIN0at7S4pa0qcsGdqIGueLk4AaYH64/msi76VS/wMCYPP2fH9bZ7q/Z3mwFP
	 WLTBkBwjMgB5OuibxjzfYbvxVdzK+/46+6S1TiOI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20250926074022epcas2p387dc5ee0d8c4676e7236c804746ceeca~oxSY5OMK61530715307epcas2p3q;
	Fri, 26 Sep 2025 07:40:22 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.36.68]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cY2Yd6GH7z2SSKg; Fri, 26 Sep
	2025 07:40:21 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20250926074021epcas2p36a8dc02c84c9ca11e2318a1a8931d68a~oxSXvVrYl2057720577epcas2p3b;
	Fri, 26 Sep 2025 07:40:21 +0000 (GMT)
Received: from asswp146.dsn.sec.samsung.com (unknown [10.229.19.146]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250926074021epsmtip2d9a38292d8fdfabc0655d0e0ed648b74~oxSXmH4d41194111941epsmtip2r;
	Fri, 26 Sep 2025 07:40:21 +0000 (GMT)
From: Sanghoon Bae <sh86.bae@samsung.com>
To: robh@kernel.org, krzk@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
	alim.akhtar@samsung.com, kishon@kernel.org, m.szyprowski@samsung.com,
	jh80.chung@samsung.com, shradha.t@samsung.com
Cc: krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	sh86.bae@samsung.com
Subject: [PATCH 3/4] arm64: dts: ExynosAutov920: add PCIe PHY DT nodes
Date: Fri, 26 Sep 2025 16:39:18 +0900
Message-ID: <20250926073921.1000866-4-sh86.bae@samsung.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250926073921.1000866-1-sh86.bae@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250926074021epcas2p36a8dc02c84c9ca11e2318a1a8931d68a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250926074021epcas2p36a8dc02c84c9ca11e2318a1a8931d68a
References: <20250926073921.1000866-1-sh86.bae@samsung.com>
	<CGME20250926074021epcas2p36a8dc02c84c9ca11e2318a1a8931d68a@epcas2p3.samsung.com>

Add pcie_4l_phy, pcie_2l_phy dt node for all PCIe PHY instances
in ExynosAutov920 SoC.

Add HSI sysreg to control PCIe sysreg registers.

Signed-off-by: Sanghoon Bae <sh86.bae@samsung.com>
---
 .../arm64/boot/dts/exynos/exynosautov920.dtsi | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
index 2cb8041c8a9f..9e45bfcd7980 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
@@ -1021,12 +1021,40 @@ cmu_hsi0: clock-controller@16000000 {
 				      "noc";
 		};
 
+		syscon_hsi0: syscon@16030000 {
+			compatible = "samsung,exynosautov920-hsi0-sysreg",
+				     "syscon";
+			reg = <0x16030000 0x1000>;
+		};
+
 		pinctrl_hsi0: pinctrl@16040000 {
 			compatible = "samsung,exynosautov920-pinctrl";
 			reg = <0x16040000 0x10000>;
 			interrupts = <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pcie_2l_phy: pcie-phy2l@161c6000{
+			compatible = "samsung,exynosautov920-pcie-phy";
+			reg = <0x161c6000 0x2000>,
+			      <0x161d0000 0xb000>;
+			#phy-cells = <0>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			samsung,fsys-sysreg = <&syscon_hsi0>;
+			num-lanes = <2>;
+			status = "disabled";
+		};
+
+		pcie_4l_phy: pcie-phy4l@163c6000{
+			compatible = "samsung,exynosautov920-pcie-phy";
+			reg = <0x163c6000 0x2000>,
+			      <0x163d0000 0xb000>;
+			#phy-cells = <0>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
+			samsung,fsys-sysreg = <&syscon_hsi0>;
+			num-lanes = <4>;
+			status = "disabled";
+		};
+
 		cmu_hsi1: clock-controller@16400000 {
 			compatible = "samsung,exynosautov920-cmu-hsi1";
 			reg = <0x16400000 0x8000>;
-- 
2.45.2


