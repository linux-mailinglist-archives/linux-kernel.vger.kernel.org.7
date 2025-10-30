Return-Path: <linux-kernel+bounces-878244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD0DC201C7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A2F460DA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7B3570A5;
	Thu, 30 Oct 2025 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="iqtkE+3E"
Received: from mx-relay112-hz1.antispameurope.com (mx-relay112-hz1.antispameurope.com [94.100.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC83E34164A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828668; cv=pass; b=nBNuWTdTMcDJPW7mDVJxtAAtwBBg8ICZgBESMg7wyZu9O7x7NPiQqv5e5gwCRJyH2wr/35vBV7PRM+E7wm4K/y5Lt8XvL3i5EgCaBU22UCMZAVPmawwXJy5NL6xCzTD+1gBo2Bkl8AIP59hH65H2LSkmW7kyLaZ5hNs9+soeYPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828668; c=relaxed/simple;
	bh=teC6RCLwcJ4ofs3BMnvnxEBibhOhTeiU3GjJARNrkN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VO9E5H9ZyecCzctBaVUhDAL7WCgTWpMqzhN+TdPwKIKLDKpEKTpcDC26LbYxk0066MsSPVK9jmQJnmK6Ry+VWfWA0hLkIQC0vufBDtO1khM+qY2bldg/QdmW6WecOzMBFU0nWyryXw1/LlLeIXlNvLNDMemLmroyupeS5z+rA30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=iqtkE+3E; arc=pass smtp.client-ip=94.100.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate112-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=vSkO+SAblxo65xQY7HUYugCLYQ6GKYpvPpD8mR1I6BI=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761828614;
 b=f8tKyLP+sl2wwMpUMiDcUtWZpctT9GLn6VQ1xi34GARyDMgEMmW4PQy4zP4akKp4FKefYj4R
 ZvZr8JBwBHiU2yhniDyhqYwTHjxe+tj/GFf2Uhmg1e+QZUfF4RuzjiWOARcXWk5kCmulHvHh0x9
 DCNUi4vlcpijR1npRluLhlhupxH2g346CWibLEKzbCydzvEUPhDvN1jgcPFXNF1YgH4S32JSzH9
 WxvYN913ISyEZRpI82F7vCQwsU0MCA3ac5e8v6mYfBp99/2KHTiuTHVbPLCOzXdUjERRG9Z3jSV
 BuVbCEfxFjVL2fjx1/QhCQ/kzFtWDOML4v4bm1oCsPpQQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761828614;
 b=FrJ5eMgzhPLYB5HMlGHhWIBUKJq5VSeoOF0u0S4oXAl8CjBpF22qJ0EYIiC/WPhvnFunhEar
 Zw51bPPC6OBuNqEllWQiyIFrC3ulP+Lg1IgX1XnkgfCZp4L3hy4JyEPdOafyM25CzOUiBRPIQxS
 8U0br4quPeSBqNSsFtD8G1Am7NMMGYkzvi31w/romIBGHAY6+JzKyO6PauKpturCyFrfNDC3p3h
 03ZHkiO/NEnItCMCrYOaFrrT34kJb3nR0vPUQTC0BGz1Nw43pQ5IXyk/D6rThGla/hJhr2QNQ4F
 0GVbSR1w69eyB/wX9ZCDBVP7ypnk8euCJiIWkK8HTXv/Q==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay112-hz1.antispameurope.com;
 Thu, 30 Oct 2025 13:50:14 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id AEA39220D31;
	Thu, 30 Oct 2025 13:49:53 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/19] arm64: dts: imx95-tqma9596sa: increase flexspi slew rate
Date: Thu, 30 Oct 2025 13:49:10 +0100
Message-ID: <20251030124936.1408152-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
References: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay112-hz1.antispameurope.com with 4cy3q62w4KzwRkZ
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:17f1ace8efd12130408b4857dfad62cb
X-cloud-security:scantime:2.238
DKIM-Signature: a=rsa-sha256;
 bh=vSkO+SAblxo65xQY7HUYugCLYQ6GKYpvPpD8mR1I6BI=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761828614; v=1;
 b=iqtkE+3ESUqWQg2JBVPRM2jtMR9s1hn/5eKpRJRCIfZq+Hs6XjP20DsAb2hyXYLB6VrrcNQr
 p9nInQzf+ueYG4xfUuMNN+ozDtkhhF+XYrxa22NAg1GtpKlzFLt1kM7b15jRS9zVg8I+P2auzEe
 vfq8jlc4b2riwnWIxNEmcXRr/iXDeyk64z7KwFBMKjAYplB5Y6rHHJ4qPasEFNbRQgjhPoSVsXd
 5vHzCYe8udkJMS74LCcUYLjPBCvpSnqn/f/BL60iQee291ivbFeu4aMZ+pehAELonEawOJglfi9
 9ZXO6lw+7ebwFecsiB9MWa2lKGVhNyquI/z45qbZXrxnA==

Switch to fast slew rate.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index 16c40d11d3b5d..52355a65a62da 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -497,12 +497,12 @@ pinctrl_flexcan3: flexcan3grp {
 	};
 
 	pinctrl_flexspi1: flexspi1grp {
-		fsl,pins = <IMX95_PAD_SD3_CLK__FLEXSPI1_A_SCLK		0x11e>,
-			   <IMX95_PAD_SD3_CMD__FLEXSPI1_A_SS0_B		0x11e>,
-			   <IMX95_PAD_SD3_DATA0__FLEXSPI1_A_DATA_BIT0	0x11e>,
-			   <IMX95_PAD_SD3_DATA1__FLEXSPI1_A_DATA_BIT1	0x11e>,
-			   <IMX95_PAD_SD3_DATA2__FLEXSPI1_A_DATA_BIT2	0x11e>,
-			   <IMX95_PAD_SD3_DATA3__FLEXSPI1_A_DATA_BIT3	0x11e>;
+		fsl,pins = <IMX95_PAD_SD3_CLK__FLEXSPI1_A_SCLK		0x19e>,
+			   <IMX95_PAD_SD3_CMD__FLEXSPI1_A_SS0_B		0x19e>,
+			   <IMX95_PAD_SD3_DATA0__FLEXSPI1_A_DATA_BIT0	0x19e>,
+			   <IMX95_PAD_SD3_DATA1__FLEXSPI1_A_DATA_BIT1	0x19e>,
+			   <IMX95_PAD_SD3_DATA2__FLEXSPI1_A_DATA_BIT2	0x19e>,
+			   <IMX95_PAD_SD3_DATA3__FLEXSPI1_A_DATA_BIT3	0x19e>;
 	};
 
 	pinctrl_gpio1: gpio1grp {
-- 
2.43.0


