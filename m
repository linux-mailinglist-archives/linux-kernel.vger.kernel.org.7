Return-Path: <linux-kernel+bounces-823192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4626B85C39
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616927E09F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70E9315D32;
	Thu, 18 Sep 2025 15:45:11 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B467314B84;
	Thu, 18 Sep 2025 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210311; cv=none; b=k8P9zOdFP8LexXBPl9kAbqqCHRGG7qCOChNfnVfJDo4h8XfQS3KpH/Dr6i3ySg3CHKSoTJah+m6scifsWa/7Dw72ESrpaA+24U+ZljgTDqJOLuB8nSs591kgJnT+8w5LtHnk/HQK7SiIeuELzfCjsgnViF2XJA6Vh/rKG9ml+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210311; c=relaxed/simple;
	bh=bm8hHyQemjiUmvDQCawOnSDA0FHUe7wJgTnpKvnzYJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPVHyUh0tRDsXIOz3G/3i9YuVDMHz6uKBekUIZfoBYBzqifhVFdi+72R22gfSzOzXoM5wIA8hzWgkIvIBweGqbt/rWv3RoyYCK4FdJug3M9aKpYRdEMP1rYewqqNeBDFtRT+l9+Qmv8fh65JDuBnTRc3CaUsobrhjQT+BOLtwLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uzGoa-00B1eF-QM;
	Thu, 18 Sep 2025 15:44:56 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 4/7] arm64: dts: imx8mm-venice-gw700x: reduce RGMII CLK drive strength
Date: Thu, 18 Sep 2025 08:44:48 -0700
Message-Id: <20250918154451.2531802-5-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918154451.2531802-1-tharvey@gateworks.com>
References: <20250918154451.2531802-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX8M Mini FEC RGMII tracelength is less than 1in and does not
require a x6 drive strength. Reduce the CLK drive strength to x1 for
lower emissions. Additionally since TXC is not a high frequency clock,
use slow slew rate (FSEL=0) for lower emmissions and improved signal
quality.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2: add FSEL detail to log (Peng)
---
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
index baf46fe28133..dca213c85cc3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
@@ -446,7 +446,7 @@ MX8MM_IOMUXC_ENET_RD3_ENET1_RGMII_RD3		0x91
 			MX8MM_IOMUXC_ENET_RD2_ENET1_RGMII_RD2		0x91
 			MX8MM_IOMUXC_ENET_RD1_ENET1_RGMII_RD1		0x91
 			MX8MM_IOMUXC_ENET_RD0_ENET1_RGMII_RD0		0x91
-			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x1f
+			MX8MM_IOMUXC_ENET_TXC_ENET1_RGMII_TXC		0x0
 			MX8MM_IOMUXC_ENET_RXC_ENET1_RGMII_RXC		0x91
 			MX8MM_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
 			MX8MM_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
-- 
2.25.1


