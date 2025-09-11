Return-Path: <linux-kernel+bounces-812403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F98B537BC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A92A174E02
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A286F35208A;
	Thu, 11 Sep 2025 15:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1iZ9Cj6K"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDCF34DCE1;
	Thu, 11 Sep 2025 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604504; cv=none; b=PkNt7u5N4181SEFtut5uoc9grWuRhXgjGcQdLoN6uTrOfek47bCbGuAJGeQ0ov6iDIGbmHVLH1sClUQ+kBx+hd1CxLhRSc6qK5Nr92iT+B6ZrawIvxb1nK02LnfpygHzzikX2tBJQ1PO4PwI6Jnb6RWJVvyABGTjEBshiJM+gcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604504; c=relaxed/simple;
	bh=G0vF1nRRo8OGJwgxh7Qj2pyP4VAf4yh2TssGDuryO30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=onVD8tuC4vd+dphFeAZeM7gcYYabN4Fnz7wlz8+qVnSYlyADqjhntNILSyAOB0xVGZkWxHsVNP5tjzXoElnfGXo1ofg6sgXOqWAUbIJGHYJww8f/4473Rt+wRLnDf2+fKS0l+Sn+mukxwQGpitnMX7uetvdG2SEey2Jtuf7zmHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1iZ9Cj6K; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757604503; x=1789140503;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=G0vF1nRRo8OGJwgxh7Qj2pyP4VAf4yh2TssGDuryO30=;
  b=1iZ9Cj6KM/xJwkjgmrvBC5Js0Lwh3JlrXOeGZka/iBioCrNdodN4Dh1s
   q9zqH84WuwmZQcZ+k4CLil2kWNy9u0j3IThSxkpahmbopV0owhBzkGIJT
   oK4EjFx+G6DpnRN/t+Iqw1qHP/9DPDLjsteTi1HorG1LIAFJA12RFRVne
   73zTSdquSducbJFoCGDgwxnroVLeBTbcG5FYsQDIcHkTiC5DGDKB5payo
   kwcAgFNHusAzVLZqMn62y+Zf0Q0sHW6wh3J6/vMuQbgewQuyjVLGsJnDV
   zjYncAlQPe+fBkgwAK6NWFCbSGNfDI4QJao8i9UjJUbsfyDBYGpjPBM1V
   w==;
X-CSE-ConnectionGUID: wLSDZ5hSTNSXS1TQWmJymw==
X-CSE-MsgGUID: rw9Z7iT0R72cz3BXA9hQCA==
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="213773302"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2025 08:28:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 11 Sep 2025 08:27:57 -0700
Received: from ROU-LL-M19942.mpu32.int (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 11 Sep 2025 08:27:53 -0700
From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Date: Thu, 11 Sep 2025 17:26:28 +0200
Subject: [PATCH 4/5] ARM: dts: microchip: sam9x7: Add GFX2D GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250911-cpitchen-mainline_gfx2d-v1-4-d7fab1a381ee@microchip.com>
References: <20250911-cpitchen-mainline_gfx2d-v1-0-d7fab1a381ee@microchip.com>
In-Reply-To: <20250911-cpitchen-mainline_gfx2d-v1-0-d7fab1a381ee@microchip.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	"Alexandre Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Russell King <linux@armlinux.org.uk>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Cyrille Pitchen <cyrille.pitchen@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=972;
 i=cyrille.pitchen@microchip.com; h=from:subject:message-id;
 bh=G0vF1nRRo8OGJwgxh7Qj2pyP4VAf4yh2TssGDuryO30=;
 b=kA0DAAoWT8aJemB2VRwByyZiAGjC6miimge2+cexOmj7icCfis/c18+WmVfwOURkp1iomv1CN
 Yh1BAAWCgAdFiEEwuy1jWnH6uM+6hUaT8aJemB2VRwFAmjC6mgACgkQT8aJemB2VRz1+gEA4/xg
 Np9W2rxV/CcHc7TPcOH/0tkY5Aqwc5s8/VbnmvkA/A4ecn/d3xQVu3MagJtATPhmnsaCtwZzFT4
 4+BFGKT0G
X-Developer-Key: i=cyrille.pitchen@microchip.com; a=openpgp;
 fpr=7A21115D7D6026585D0E183E0EF12AA1BFAC073D

Add support for the GFX2D GPU.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
---
 arch/arm/boot/dts/microchip/sam9x7.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sam9x7.dtsi b/arch/arm/boot/dts/microchip/sam9x7.dtsi
index 66c07e642c3e1a2272490ec311062dfdf291c1cc..f4b71a49e6c167a0c9ad89b0c58fadb1ed467a5d 100644
--- a/arch/arm/boot/dts/microchip/sam9x7.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x7.dtsi
@@ -271,6 +271,15 @@ AT91_XDMAC_DT_PERID(38))>,
 			status = "disabled";
 		};
 
+		gpu: gfx2d@f0018000 {
+			compatible = "microchip,sam9x7-gfx2d";
+			reg = <0xf0018000 0x4000>;
+			interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 36>;
+			clock-names = "periph_clk";
+			status = "disabled";
+		};
+
 		i2s: i2s@f001c000 {
 			compatible = "microchip,sam9x7-i2smcc", "microchip,sam9x60-i2smcc";
 			reg = <0xf001c000 0x100>;

-- 
2.48.1


