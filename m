Return-Path: <linux-kernel+bounces-812401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03BBB537B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3EC165DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6DB350D49;
	Thu, 11 Sep 2025 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dq/upbaN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19E334AB16;
	Thu, 11 Sep 2025 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604482; cv=none; b=RDIViGO1onD2Yu4XALt758wuNfp4oMG/EN6IZaxGKG0d9IGzSWdYRu9efyasmV8gULqNEUIoAKr7zWSuXOotNCaGiatSz94Q2fIZO5463TmNHvemiVdXd+YNTiuDgGUlflFtKinpstPOiXEziu1TvW7mMQ31fC6O4RaZfm71O0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604482; c=relaxed/simple;
	bh=NhSoUqUNYaOI0mErOTmy6zte2dPqumaW668Oc5+wINA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Hims9RCk9jRww1TbhIxGeT0cErr/bLACZjkt4FsKRaAd7r3XBOq9xfYDYDk9oc49pjp/cCuO5xatLgFNH9XDM7SCcBGJRc5Og9DtKymiDG6Ogm2gePDy4+lvK30/pCCvDbqndSW94SdqXU2HaWvm2ODlF4XNGFTTFL2a0HoXUWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dq/upbaN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757604481; x=1789140481;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NhSoUqUNYaOI0mErOTmy6zte2dPqumaW668Oc5+wINA=;
  b=dq/upbaNoeZhF5DUbAMb58JYy+4rsgsP6+RZ0Zmb37dw4wXzzta8njA6
   2zdYkUyTPYRKlZwV4ByR9u3QQXlES/jmj1tGqInXyCFYm+/WXLMRFRZ63
   IZrie4i2yOnmimY7xxHWUSoOCIA9zfHX/HEu7mfSPCDGYnM8XbiylyH+4
   EG/ay4aT8EdB0t3yx1P+PUymq5R3ZsYTKI4IKEDO28yFHxR7U31Rh/zLK
   al2fD9Xxg0pY1sfe4IRhhKGUW/DXwL9k/g6SHupSvHZBLsEhMbFPba6Vn
   xUEgUkJOXC04LgzDKP/WtwUw5CLICL2prR/6a83CMZBM57UdTwbpx09Cm
   Q==;
X-CSE-ConnectionGUID: GfrnwuRcTGGvDy+5ZTnmUQ==
X-CSE-MsgGUID: I1cwnFKsRzKsoLN1LQoTxg==
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="277761666"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2025 08:28:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 11 Sep 2025 08:27:53 -0700
Received: from ROU-LL-M19942.mpu32.int (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 11 Sep 2025 08:27:50 -0700
From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Date: Thu, 11 Sep 2025 17:26:27 +0200
Subject: [PATCH 3/5] ARM: dts: microchip: sam9x60: Add GFX2D GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250911-cpitchen-mainline_gfx2d-v1-3-d7fab1a381ee@microchip.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=964;
 i=cyrille.pitchen@microchip.com; h=from:subject:message-id;
 bh=NhSoUqUNYaOI0mErOTmy6zte2dPqumaW668Oc5+wINA=;
 b=owGbwMvMwCXmf6yzKqEsVIbxtFoSQ8ahVxnCbKFHp8RfqfvCfPlNy8Ss24L+1nXKuz7zyWtL6
 1tY6FzvKGVhEONikBVTZDn0Zmtv5vFXj+1eiUrBzGFlAhnCwMUpABO58JfhN9ujuEO2yX/9NogV
 xGkwlZ58zbHH6frEq59qC2SvL3dYvpqRYQf7ZA/TgFLj18EBr45dmMDMJnG9cfltN5WslS67ear
 XswMA
X-Developer-Key: i=cyrille.pitchen@microchip.com; a=openpgp;
 fpr=7A21115D7D6026585D0E183E0EF12AA1BFAC073D

Add support for the GFX2D GPU.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
---
 arch/arm/boot/dts/microchip/sam9x60.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index b075865e6a7688005d471665459b3f6f1f26f7a4..6a177c008e1501e49d984a216e8d060f9dbc63cb 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -353,6 +353,15 @@ AT91_XDMAC_DT_PERID(26))>,
 				status = "disabled";
 			};
 
+			gpu: gfx2d@f0018000 {
+				compatible = "microchip,sam9x60-gfx2d";
+				reg = <0xf0018000 0x4000>;
+				interrupts = <36 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 36>;
+				clock-names = "periph_clk";
+				status = "disabled";
+			};
+
 			i2s: i2s@f001c000 {
 				compatible = "microchip,sam9x60-i2smcc";
 				reg = <0xf001c000 0x100>;

-- 
2.48.1


