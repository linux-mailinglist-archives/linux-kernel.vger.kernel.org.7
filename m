Return-Path: <linux-kernel+bounces-878372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B566C20700
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3415A1A67D57
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C57526D4C0;
	Thu, 30 Oct 2025 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="baEDyjIo"
Received: from mx-relay94-hz2.antispameurope.com (mx-relay94-hz2.antispameurope.com [94.100.136.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C1F262FEB
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.136.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832506; cv=pass; b=UmErOeDGXFyzIy7pwCpD8z1vc4r9ZlW0XS7VWDlS6nNG9JFf7JxRh7YhcV5uDSe5EXz7REWZP0n96XrY6o2BYb1FrvV/X3wlCF2W3UPQX6kXDcMyuMwKNOH7R3X3+6ic6HGQ5JdNHIuTBJp2Ag8qnmbVcFPgaepq7EMYSabnrQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832506; c=relaxed/simple;
	bh=Js2Xlt1TcksUkzr8bWmp3YdEt6kTQ3aB6Ws4q1qzjx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZJjGzHW7ZJOwV5vo44UwAjMpEA/cjmSZ3AzHg8lpd9547pGTEwx+BzFVI5t7bdOeNr65Oag4/NGMBK3PSc8HS2QnDJbAuPEVacweg99ZCpVa8u/9XyX3evuaAQc2I92ZOERjQzdpLT0U3yjOUeIO1ZygwIEExXd5HBEUIogniE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=baEDyjIo; arc=pass smtp.client-ip=94.100.136.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate94-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=OgKqByS2/RO1SRU9MW5M+/ddL3PnmL8qHsnqkvfLvhY=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761832420;
 b=JQad6nyJ3MLhilSzToyTVw4kpaYi5wpR14anybiyJaU1X72Sab+WAqSD80dHDgyMlpA5lskE
 oHS9qlSmUYvKT/LXfhqpMzXrAhQzb1Orm5cTWdrPEYzmCG1DdJ5jHzJfxNxbAD6nl52/csZNG81
 reaWyhWSQOsjFEq98qe/AJEMhDAPH985At0KlODMOuydY9IrHJ/F+POIqkk0UsmbcS73Xm1O71U
 EpQ8o481+YVrcD+bCIT6xT9kMCqjD23jLHtHszq26djBBueyu0rtb+Jh2iIZLJroOTYw8GbCe62
 xrl3UX+o27j6FibcBUe0FnKd/9Ii0jCIY4q0maYCmtfHA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761832420;
 b=LKruBj0c3NGFga/c1VeYrCmB1+/YPtY9Hq/UCZKf+ZdtKNTF0tlI+XazitbTXu3+y1X1vkRg
 yZh9+AJDmiLCD4IXktlKj4TF2JYghdct8XI3fJWy4El40E1mc8MqSvhkt3/ctvE6Liygm/Yac/M
 WBHcKMV+MEUaSV0fK6Ey0L5MOX1yHJ+Js6aCkrEn+kN/E23USLXkonuUIOqUN6hD/tejP5+ehK8
 qg28b4TUXiX4mmjAsbBmNjTNQKWTFhGRIW434+/P0sfU+QGrV0F2Ei8dhkouseXdYXHUGXA6Mdw
 dZGw8W+cinxUnPj0iBNtkyEd+Ar6Eh2C5lOJ1sN5AjicQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay94-hz2.antispameurope.com;
 Thu, 30 Oct 2025 14:53:40 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 136855A07D3;
	Thu, 30 Oct 2025 14:53:14 +0100 (CET)
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
Subject: [PATCH 14/19] arm64: dts: imx95-tqma9596sa: whitespace fixes
Date: Thu, 30 Oct 2025 14:52:56 +0100
Message-ID: <20251030135306.1421154-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
References: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
 <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay94-hz2.antispameurope.com with 4cy5DK3v73z3dGQg
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:783d95388d58bfc72f1c3cb0f6f3ac9e
X-cloud-security:scantime:1.915
DKIM-Signature: a=rsa-sha256;
 bh=OgKqByS2/RO1SRU9MW5M+/ddL3PnmL8qHsnqkvfLvhY=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761832419; v=1;
 b=baEDyjIoN/peAyydzCfp0/lC00dn/a4jvLCLvRQFZB0vyuqlBBRYcRurt/pHN/BfMYAFvsFW
 iZixDWq9p2AM4BRzsqtHgQHIY1mk2FhmyPpe0XJeB1/XNXPzpyGWreop7xGi5a0cVJK4U8If9Rz
 gwyWTpLzdqXqTqsh+xMXY29VyNa/dvqZyD6+biKqXYgCGu+bZ/KOtcOA2YFQerfB+y8YbIEhj8g
 r8F6YD+/7xsJ6FNDEs08FAagcKRfaFZ7DzKeRIwyQBz1WlrkOqZLN+QPlyNI6IUgamoOZ814m6Q
 zieifRFZamdChPOIt2iHkWNBL5egPlg4gckQGgN5V2oTw==

Use tabs instead of spaces for indentation.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
index 9c892cd8ff215..a4c6083ab43b1 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa.dtsi
@@ -621,8 +621,8 @@ pinctrl_lpi2c3_gpio: lpi2c3-gpiogrp {
 	};
 
 	pinctrl_lpi2c4: lpi2c4grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO30__LPI2C4_SDA             0x4000191e>,
-			   <IMX95_PAD_GPIO_IO31__LPI2C4_SCL             0x4000191e>;
+		fsl,pins = <IMX95_PAD_GPIO_IO30__LPI2C4_SDA		0x4000191e>,
+			   <IMX95_PAD_GPIO_IO31__LPI2C4_SCL		0x4000191e>;
 	};
 
 	pinctrl_lpi2c4_gpio: lpi2c4-gpiogrp {
@@ -631,8 +631,8 @@ pinctrl_lpi2c4_gpio: lpi2c4-gpiogrp {
 	};
 
 	pinctrl_lpi2c6: lpi2c6grp {
-		fsl,pins = <IMX95_PAD_GPIO_IO02__LPI2C6_SDA             0x4000191e>,
-			   <IMX95_PAD_GPIO_IO03__LPI2C6_SCL             0x4000191e>;
+		fsl,pins = <IMX95_PAD_GPIO_IO02__LPI2C6_SDA		0x4000191e>,
+			   <IMX95_PAD_GPIO_IO03__LPI2C6_SCL		0x4000191e>;
 	};
 
 	pinctrl_lpi2c6_gpio: lpi2c6-gpiogrp {
-- 
2.43.0


