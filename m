Return-Path: <linux-kernel+bounces-780269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A95B2FFA5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EA91CC36EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5B92BE641;
	Thu, 21 Aug 2025 16:01:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19922BCF4C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792117; cv=none; b=tCOtf57JQWF4MEBCIlsDlr9hL1+MWsrLgIcm0b4ZLUmKCibbg5vJNrfvRK5+ci3AeMHJyN2NcflFfJOOf2SU8sRtsxzadjip4TFVbMTvnbxLBqCQxUn1y/G06+3IhhziJO0WP5d441hhbnlY3YK9avdYXV7xN0MbaB5ymkiAWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792117; c=relaxed/simple;
	bh=PEi8jUH7bpdq5/xLOUrl4lY2gtTLVOSF4SM7Vr3CbMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sE1hWqUGBOfUmvg3UnBhhfrNPJUTVJ0t9hEut7wh2hGmHRz8s7IPyFYxaF3iDhJPVltVdpeUfcXsoUVSG3TBhWvrftgyJHqnRP2SxTIgED2aH3Yg7daorfwPiTgoWuENUj7IInL+kgFcSn4wGb8gA4wvVPFqT1zV9Qf+Wb8k0+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1up7jR-0000Iw-4B; Thu, 21 Aug 2025 18:01:41 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8mp: add interconnect for lcdif-hdmi
Date: Thu, 21 Aug 2025 18:01:37 +0200
Message-Id: <20250821160137.108735-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add the missing interconnect for the lcdif-hdmi.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v2:
- align the list with the dt-bindings list

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 948b88cf5e9d..ca7ec1bb4be5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -2046,6 +2046,10 @@ hdmi_blk_ctrl: blk-ctrl@32fc0000 {
 						     "pai", "pvi", "trng",
 						     "hdmi-tx", "hdmi-tx-phy",
 						     "hdcp", "hrv";
+				interconnects = <&noc IMX8MP_ICM_HRV &noc IMX8MP_ICN_HDMI>,
+						<&noc IMX8MP_ICM_LCDIF_HDMI &noc IMX8MP_ICN_HDMI>,
+						<&noc IMX8MP_ICM_HDCP &noc IMX8MP_ICN_HDMI>;
+				interconnect-names = "hrv", "lcdif-hdmi", "hdcp";
 				#power-domain-cells = <1>;
 			};
 
-- 
2.39.5


