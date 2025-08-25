Return-Path: <linux-kernel+bounces-784719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DDDB34042
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FA767AB6B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA401EF0B9;
	Mon, 25 Aug 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="grD7m/Xe"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521FB1D54E2;
	Mon, 25 Aug 2025 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126885; cv=none; b=FnT3YoRcVIat+d5tqWhm2v3vTe4GdnUQCcsnn7FWlOOs3FRbyjVHm4LsmHOytojRD9eoc+qbBlQ+tYsp0xoXMC+I5g9txzlZ4Qx4+znDC9gutT7Upak+IhYbqS3lPGle8W/+rl4Jmyr2YzUrU/whbOl6kovCEJd/+EO15MJ6D1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126885; c=relaxed/simple;
	bh=3mg8H5raVBKkDe/TXL7in7wasHK55tIcmkgCouAAdu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=sJyFupzcozHSOT144LrYO0A/1EKxpPVMqa4zJZc5SQUBom8jn/7AEDdHSvzWMDMSHaiLDBceR2Iyn3u5nC4GmvSrpRCzM/2tiwLrLDeCsjO6E7vVuCB7ThflstLxkK7SLSryA6FgNx5hqfwG2j9/ooM/3fmpjQ65Is9cRfAYu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=grD7m/Xe; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 1D8F1A05C6;
	Mon, 25 Aug 2025 14:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=4EQUO9uZ0iCJ6TiGfFUQMxCSBU7gkSepVVETsOcLgjg=; b=
	grD7m/XeXhE5qIjaVKYgSduEHqXmqCL/nrRWDyhlz798QOa3ZmLrRujq4xvKMluh
	uimv1LzdaPwqe77Rh2htX9RcXI5/rRJbMlMS7qwV4awdZ/LOoY5QrJ9rsZW7o1+I
	KaEEiWXrfedJX2XjN11J1U3ysy3USshL7EggKf4/QfLLrUimIK+pLfdjI7xKtmU1
	rJh2Urhw5qzpns5bKGSSo3pVTP1kWpEoALMuwjYnnR0mA8FR48huWhSfB3yvMUl+
	IevPNA1QZiaOR8+D0GSgez44T6oNa9UeT1RAHhbU4Us6aYlq3EfQP8gZte2kNBud
	afiYEINbh5qjJNhUNSKFrpYsl9HAiVZ+sv+tuQlqrc5vtAB1nU4Hn6Nge9NsurP1
	Wr0gID6LObwDS6n5oigR/TsP0RJxlSN0P/mJnMudCwchlsRcP5oU/Ill19sZ9sWU
	Uud66ELIy5i7W9HScqF6995lx/eprTgPRnQlw2zRlEH2kNDILsYA2N+G9oqywGvZ
	qMa9iAqsgIYbbO4dR3gNAl8mvsf7CnsQdNTy8ReemfUZsS0SnB5nqErCyxnugsTA
	sn6I6H5/9BUbvJpgjlJ8ydr6UzgH7GsLjiecCF4iqC9o1fKazGcf4YiPB7gVLjH6
	vlhlbVAgjshKtzLQgN1mqxXXnfozEZpLUqZEKD5To7w=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Mon, 25 Aug 2025 14:52:09 +0200
Subject: [PATCH v2] ARM: dts: imx6ul-tx6ul: Switch away from deprecated
 `phy-reset-gpios`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250825-b4-tx6ul-dt-phy-rst-v2-1-0d3ba9736b0e@prolan.hu>
X-B4-Tracking: v=1; b=H4sIAHhcrGgC/32OQQ6DIBREr9Kw7m9Bi5aueo/GBQgKiQXzQaMx3
 r3oAbp8ycyb2Ug06Ewkr8tG0MwuuuAzFNcLaa30vQGnM5OCFpw+GQf1gLRU0wA6wWhXwJigll3
 LBJWVoDXJzRFN55bT+mkyKxkNKJS+tYcroOudv39lTAaPvHUxBVzPEzM7Wv/3ZgYMhKq4KRnXQ
 pfvEcMg/c1OpNn3/Qf2ChcS1gAAAA==
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
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1756126334;VERSION=7996;MC=126871935;ID=493941;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E607067

The Ethernet PHY's reset GPIO should be specified in the node of the PHY
itself, instead of the MAC (`fec`). The latter is deprecated, and was an
i.MX-specific extension, incompatible with the new reset controller
subsystem.

Co-developed-by: Csaba Buday <buday.csaba@prolan.hu>
Signed-off-by: Csaba Buday <buday.csaba@prolan.hu>
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
Changes in v2:
- Remove `reset-names` that was generating warnings
  - This is how it is already in `polytouch`
- Also move `etnphy1`'s reset
- Link to v1: https://lore.kernel.org/r/20250815-b4-tx6ul-dt-phy-rst-v1-1-9b65e315d9d3@prolan.hu
---
 arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi
index f053358bc9317f8447d65013a18670cb470106b2..5c7e9556b5ce823b339798ec8f1bd351afa07185 100644
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
@@ -262,6 +261,11 @@ etnphy0: ethernet-phy@0 {
 			pinctrl-0 = <&pinctrl_etnphy0_int>;
 			interrupt-parent = <&gpio5>;
 			interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+			reset-gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <100>;
+			reset-deassert-us = <25000>;
+			/* Energy detect sometimes causes link failures */
+			smsc,disable-energy-detect;
 			status = "okay";
 		};
 
@@ -272,6 +276,9 @@ etnphy1: ethernet-phy@2 {
 			pinctrl-0 = <&pinctrl_etnphy1_int>;
 			interrupt-parent = <&gpio4>;
 			interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+			reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <100>;
+			reset-deassert-us = <25000>;
 			status = "okay";
 		};
 	};
@@ -281,7 +288,6 @@ &fec2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet2 &pinctrl_etnphy1_rst>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
 	phy-supply = <&reg_3v3_etn>;
 	phy-handle = <&etnphy1>;
 	status = "disabled";

---
base-commit: 0cc53520e68bea7fb80fdc6bdf8d226d1b6a98d9
change-id: 20250815-b4-tx6ul-dt-phy-rst-7afc190a6907

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



