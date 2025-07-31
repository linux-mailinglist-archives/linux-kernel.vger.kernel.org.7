Return-Path: <linux-kernel+bounces-751858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC71B16E52
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DAA3B8160
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394082BDC0A;
	Thu, 31 Jul 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="YvTRIgOb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="NXzFN34L"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4827CCE2;
	Thu, 31 Jul 2025 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953437; cv=none; b=n9rKjDzZx5h5brT68O7q/i24CXPP0rg3a+ScSLVlps8lCR/F/psLWqyhGEDyCYmFNdQKluzB1Wu8nx3D0lDZ23TW4/4km1+ZX0mrTRLwUeHYR/Q7MZyIkN0PhMPp2CfQ58U8mC/28gmIE1r9fhRoFbv+wGm77+vuSm/0ZOPzAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953437; c=relaxed/simple;
	bh=XLy9JforODX1vg94EoQoeuC1fy55ynPGnrmbyWpbvRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0NaJL7A4Q7Lx013faw3hI0W2giOyOgVzhNsb/t3FitVCYvs/6K/ZyqIcvPEadjSXgJURCQ97yenVqLsKC3VyIoUUlpDyyYS7A+JCZyiKz5x2nuzz5HEk1etfMC0fzs0PEumcubA7egDTHf2K6Av3E3gvEtUvd8heKfPbylfaoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=YvTRIgOb; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=NXzFN34L reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753953435; x=1785489435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iMVr0ws5CkQAGwUnCKlS4uzwI98zmvZR9krDCNF3JCI=;
  b=YvTRIgOb80Z43jywsNgN65Sf9eTzFK6nQGpjPeXfHTHO1suGXMem/Z9q
   2J+FUzE50bD0drt71QmMrxSbfePbnW2HrjFuG2W05d5Gd27QlNqKvmH6N
   6KRbFGToEKs+oKMkvi8p1msq+ch/f5gdgaGcWV2uBs1ExsG+RkPQ24m5v
   DHQobOXo5R6Iem1RGEHIAp3cAXWDqVVk9W011B9Ng712mQmV/ETCOvBFA
   7vfEPbD28Fi5yuSgxF9ylkj5T4o7HWvQNknOVysg5HMArxym7hsI473wR
   o9tUB7NRr9khGg+KkU6WFYVvcq+jQnszGyksvhZ5HZNpDqlU5oN32bkp7
   A==;
X-CSE-ConnectionGUID: KES0HHvgRUi/R//cAtr2VA==
X-CSE-MsgGUID: Rj7oXHOHRAmM44IczhCTFg==
X-IronPort-AV: E=Sophos;i="6.16,353,1744063200"; 
   d="scan'208";a="45516522"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 31 Jul 2025 11:17:12 +0200
X-CheckPoint: {688B3498-1B-4FC15ADB-CD71293B}
X-MAIL-CPID: 88682096A4402C254D972D6D13907F90_0
X-Control-Analysis: str=0001.0A00210D.688B344E.0008,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0573D163C63;
	Thu, 31 Jul 2025 11:17:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753953428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMVr0ws5CkQAGwUnCKlS4uzwI98zmvZR9krDCNF3JCI=;
	b=NXzFN34LjoFcpC1RkpbQlkGvR+epBpgqgdVT0WrflWTYbGcPhNeWX0Abtbww9wF/gyk/Kg
	GHpgoTrollxGszJ5AZDVKXU/UbZnlMlbCvKW0YmF/TR3IXRFTBQtxXNeHnp9QZrVI8WR5Q
	R+7RENT7WDGBLQTGnnoRRvc3jBE6cDTwn32nFD8TXXo1vzJrnsO/ThyOn8W+VdCE8ywDtA
	LYZkFQgilYrXqEVEckHL5TrwgemyU4VRob2YdfqKVFvF9beHd5Kiqnzp9eTTN1CsCpXxHk
	EhMEJwGL6f7yss4Y97hH9i6AulCLUT7qB1bJ8aLeM8ZcLGuZLdqCyBvjnzpWHA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: imx8mp-tqma8mpql: remove virtual 3.3V regulator
Date: Thu, 31 Jul 2025 11:16:53 +0200
Message-ID: <20250731091655.2453107-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731091655.2453107-1-alexander.stein@ew.tq-group.com>
References: <20250731091655.2453107-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

BUCK4 rail supplies the 3.3V rail. Use the actual regulator
instead of a virtual fixed regulator.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../boot/dts/freescale/imx8mp-tqma8mpql.dtsi      | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
index b48d5da147273..9716f24f7c6ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
@@ -16,15 +16,6 @@ memory@40000000 {
 		reg = <0x0 0x40000000 0 0x80000000>;
 	};
 
-	/* identical to buck4_reg, but should never change */
-	reg_vcc3v3: regulator-vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC3V3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-
 	reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
 		compatible = "regulator-gpio";
 		pinctrl-names = "default";
@@ -187,14 +178,14 @@ at24c02: eeprom@53 {
 		read-only;
 		reg = <0x53>;
 		pagesize = <16>;
-		vcc-supply = <&reg_vcc3v3>;
+		vcc-supply = <&buck4_reg>;
 	};
 
 	m24c64: eeprom@57 {
 		compatible = "atmel,24c64";
 		reg = <0x57>;
 		pagesize = <32>;
-		vcc-supply = <&reg_vcc3v3>;
+		vcc-supply = <&buck4_reg>;
 	};
 };
 
@@ -211,7 +202,7 @@ &usdhc3 {
 	non-removable;
 	no-sd;
 	no-sdio;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&buck4_reg>;
 	vqmmc-supply = <&buck5_reg>;
 	status = "okay";
 };
-- 
2.43.0


