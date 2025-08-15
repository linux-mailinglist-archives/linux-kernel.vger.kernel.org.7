Return-Path: <linux-kernel+bounces-771092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E233CB282CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9EC1CC204C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F60129E0EF;
	Fri, 15 Aug 2025 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="OezYG2/s"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E891E51EB;
	Fri, 15 Aug 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271092; cv=none; b=OcvOsbq0zjosH6Y+yXswHai0f+D2GxMzdmk4s+mWuB3AbyFOdZgdSEUzk8Mhh/ixAX5dTAnBt5H7fCPrABlagGaYApJqwxg8H4aFr+gpMhjTb8/JG2DuxR3llbAamwO2Nw/GhqgjDRsbi7OvU4wIQd03O8UzKSVlyTehy5DlAb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271092; c=relaxed/simple;
	bh=a3HBoztTfuAyisI14UaGwu6/MO/nbJ57xjQxo/xLbck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=qtveQJWhoF5nM/CoK+cdqjJUR/vacBbRFd3H/Q5D1i6jZrxtoqkdfvJLRS3ztOFJp6fEUoZ4kFi/yQGnPjaX3rlXmecOxxKPQPuktmc7cJm8Mo3zTMaAJJOTdEfsc49J7lMK4gVf6Ilt/CSiOj9aVtGTSA46ZdhwTQAHt3FcGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=OezYG2/s; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DD709A1132;
	Fri, 15 Aug 2025 17:18:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=jrCNPXnnoQqaDELgsJKRlngS3CXoF51zhyKLy22jlso=; b=
	OezYG2/sIP7w9L+In2xEeaa2K6AJTOxkn4yPlvp24uvV9zxi7MtMTK2cCXvFdB9k
	1h55oG4p3YusmV56LzmctAMoUJQrDP9/aPABMm3f/yiPfYau2AN50/JLlf0RmN93
	wpTdwU5dOXm6HjKh9m5PH+PuyhWHVl/7LUq3fNge4g56Ifgv6ABa3u4yjQEjs5q1
	5qTH3Naf6IxkyeROi0FETPGam41LR9pTVJdWZc+rZEuujVUuX23E/AJpzw7BD/LS
	3SETKquD2JBFq5ABIlIWhQUlauy03skoxSrzMy5ejEZICsoYy1xqxh3O1kvfT7ci
	/KPc8CvgKRpT9sNJOjmTo2HIeU/X8HDAPwaAIEKePsISzks0fc9uGi9Eh+Fo/FeZ
	+RiR16v14zkAw1IMj/0kJ/LpT/Ao8N3VaqEKNRjDAAwJhBxN42uTM5/UydQ/vqpa
	mlcFs6380dGr4ycgJ1GgygPr4Gos0UVazCM96l/n8auUdXF0oxz+qjEM2F5K8oWz
	RT4tVYz6HJtchEErTdcyE1NORYiycnHfHRoU8GzBUPl5gWvNxoJkSPdjGK/t6cUV
	0DGOEGEYetpDEcuOlgi6F9KgF134OhlV/K6DTobyc5pUql12GVh7nVh9opDH3WVB
	OPb8Vw8L+iBjTZRyInPTsR+o2iB6xyj8pBvnGgdHGHw=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Fri, 15 Aug 2025 17:17:37 +0200
Subject: [PATCH] ARM: dts: imx6ul-tx6ul: Switch away from deprecated
 `phy-reset-gpios`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250815-b4-tx6ul-dt-phy-rst-v1-1-9b65e315d9d3@prolan.hu>
X-B4-Tracking: v=1; b=H4sIAJBPn2gC/x3MQQ6CMBBA0auQWTuxJQLiVYiLtgx0Ei1kphoM4
 e5Wl2/x/w5KwqRwq3YQerPykgrsqYIQXZoJeSyG2tSNudoG/QXz1r4eOGZc4wdFM3ZuCrY3ru1
 NB6VchSbe/tfhXuydEnpxKcTfaxGeOZ2fTjMJHMcXVJ/IwYUAAAA=
X-Change-ID: 20250815-b4-tx6ul-dt-phy-rst-7afc190a6907
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Csaba Buday" <buday.csaba@prolan.hu>, =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?=
	<csokas.bence@prolan.hu>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1755271085;VERSION=7996;MC=709096725;ID=1149888;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515E617063

The Ethernet PHY's reset GPIO should be specified in the node of the PHY
itself, instead of the MAC (`fec`). The latter is deprecated, and was an
i.MX-specific extension, incompatible with the new reset controller
subsystem.

Co-developed-by: Csaba Buday <buday.csaba@prolan.hu>
Signed-off-by: Csaba Buday <buday.csaba@prolan.hu>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
index f053358bc9317f8447d65013a18670cb470106b2..0a5e90704ea481b0716d6ff6bc6d2110914d4f31 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
@@ -246,7 +246,6 @@ &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1_mdio &pinctrl_etnphy0_rst>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
 	phy-supply = <&reg_3v3_etn>;
 	phy-handle = <&etnphy0>;
 	status = "okay";
@@ -262,6 +261,13 @@ etnphy0: ethernet-phy@0 {
 			pinctrl-0 = <&pinctrl_etnphy0_int>;
 			interrupt-parent = <&gpio5>;
 			interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+			/* Reset SHOULD be a PHY property */
+			reset-names = "phy";
+			reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <100>;
+			reset-deassert-us = <25000>;
+			/* Energy detect sometimes causes link failures */
+			smsc,disable-energy-detect;
 			status = "okay";
 		};
 

---
base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
change-id: 20250815-b4-tx6ul-dt-phy-rst-7afc190a6907

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



