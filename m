Return-Path: <linux-kernel+bounces-823189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A058EB85C60
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5FA1C06FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864FC3148C4;
	Thu, 18 Sep 2025 15:45:08 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B764B313291;
	Thu, 18 Sep 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210308; cv=none; b=orU4B0UuQ+MTOZRAQC5DJXS10VhUqKsH4UswFfX/yHa+qKtUMF/CIDxZeimNA0u8L8S4gJzFuRQ75cZ8Vf7KDsCpj0NfQ5Yslbg1nNPh8SsMoXLNFxKeFOt0TXdyN70L8nD2hZHZ99tO6I4QT3xK1rY4PCAJdlDhtRziNYdi16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210308; c=relaxed/simple;
	bh=vsAmNFxLbdkNTlMLmwyaXIICvEbVQlM3xrmAQAQ+h6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h3ssvJUKHmva5UwsT7YAhT+ieCEmeZuSwQUueEjJ2qKn2zDILDKNe0aJ9xIzoAZGQT4vOinFH/5o4OiOwBRXUixojnmH7rXLdlBSQxTxA+8WcRr5C98BIQa12jM+bB2NzLUWANfD0+cm+phTaqw52FatoQwKz5sh2iadMcLFHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1uzGoZ-00B1eF-UP;
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
Subject: [PATCH v2 3/7] arm64: dts: imx8mp-venice-gw702x: reduce RGMII CLK drive strength
Date: Thu, 18 Sep 2025 08:44:47 -0700
Message-Id: <20250918154451.2531802-4-tharvey@gateworks.com>
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

The i.MX8M Plus EQOS RGMII tracelength is less than 1in and does not
require a x6 drive strength. Reduce the CLK drive strength to x1 for
lower emissions. Additionally since TXC is not a high frequency clock,
use slow slew rate (FSEL=0) for lower emmissions and improved signal
quality.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2: add FSEL detail to log (Peng)
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
index a1232a4f8485..dd9eeb3479fd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw702x.dtsi
@@ -462,7 +462,7 @@ MX8MP_IOMUXC_ENET_TD1__ENET_QOS_RGMII_TD1		0x16
 			MX8MP_IOMUXC_ENET_TD2__ENET_QOS_RGMII_TD2		0x16
 			MX8MP_IOMUXC_ENET_TD3__ENET_QOS_RGMII_TD3		0x16
 			MX8MP_IOMUXC_ENET_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x16
-			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x16
+			MX8MP_IOMUXC_ENET_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x0
 		>;
 	};
 
-- 
2.25.1


