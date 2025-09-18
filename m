Return-Path: <linux-kernel+bounces-823090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C685DB8583A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79EDAB635A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE4030F954;
	Thu, 18 Sep 2025 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eS3KGWIp"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E4130DD33;
	Thu, 18 Sep 2025 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208155; cv=none; b=UIBjdRYLZKkZ80vNdU8wfKZAV8NAaaVy2P6EdY9zpr33wij/P5WFU0YKn1kKhrmr4Mm2AX6WwpMbIyaUJwu/57y/goL0Aqi9MXlEf6RTLoBkwweJiZ6bzW4Xgt0Gocus8qjqhj1mwr7qyJNSXA5G8RwBCUOYN4QxLksNqnhoSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208155; c=relaxed/simple;
	bh=/mLGAizM4D0NKvOiayu53Ks5IeoiBFtYbwR9O/5P3ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WBMTQZVLVzteEjkn6fSq4W0lSHb5Embqx1GmDBhXVZnB4lIVO/CpOeUc8J+bz+eX0Y6FYb5gzc4173P0HhxJEWQX83y5ZoEddDCKnA1tJCrV0+THa4HM7j0OemtH+lv4z6FQXB2l38OfCww7Zc86ZWGy3ojMTG6fysmSX8PXL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eS3KGWIp; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758208154; x=1789744154;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/mLGAizM4D0NKvOiayu53Ks5IeoiBFtYbwR9O/5P3ws=;
  b=eS3KGWIpuHvAKaLzlcrPHYRgb3woNepPs+OZhnlBARtDLP5M8sr4PI9n
   rzZVKGZVDfJN+tWVJMNqLZKnLdB09DUh5494TTkVasOJNrB5sEF74Hvju
   1m1qJVSYHW56KmSLfM5gsge2V2OXafhLBdkDjHxMqtD+gNiHU7QsuT+Qy
   eQV4uPHZ8UBeFjqoF6f8bUCSiHebymed0P32fO7MlA4SmEWgMtK6p1iri
   Uimwa90CzdT+XI9SNdEDEfL/t+DfSMN47eXZ1aY43ShSCnzjCSdE/q3bM
   nCvEREw2XqH4Iv9IayVL2cNEcHMcPaG509PIFJnW1ncnrXtYJ1aaqy3Ig
   Q==;
X-CSE-ConnectionGUID: ugeKBCocT/GeJhh6l5hQPQ==
X-CSE-MsgGUID: kCLCrTZbQD2iFf1NNNj/Lg==
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="47215044"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 08:09:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 08:08:43 -0700
Received: from ROU-LL-M19942.mpu32.int (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 08:08:40 -0700
From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Date: Thu, 18 Sep 2025 17:07:39 +0200
Subject: [PATCH v2 5/5] ARM: configs: at91_dt_defconfig: enable GFX2D
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250918-cpitchen-mainline_gfx2d-v2-5-6cfac9d56612@microchip.com>
References: <20250918-cpitchen-mainline_gfx2d-v2-0-6cfac9d56612@microchip.com>
In-Reply-To: <20250918-cpitchen-mainline_gfx2d-v2-0-6cfac9d56612@microchip.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=751;
 i=cyrille.pitchen@microchip.com; h=from:subject:message-id;
 bh=/mLGAizM4D0NKvOiayu53Ks5IeoiBFtYbwR9O/5P3ws=;
 b=owGbwMvMwCXmf6yzKqEsVIbxtFoSQ8YZhZSAPWcz1W++P2/y1OGSdTDnguSa3HbjhL+vS3trC
 u5mbHjRUcrCIMbFICumyHLozdbezOOvHtu9EpWCmcPKBDKEgYtTACZS/IORYbOS48lTTQ0VESz9
 KUu2H9m3ce9D3sfTHXZGuy/eYcMRlcnI8NmtiMPB7JDD/tpzT0tsln959KwogfNL1MTYvHsvb59
 4wwQA
X-Developer-Key: i=cyrille.pitchen@microchip.com; a=openpgp;
 fpr=7A21115D7D6026585D0E183E0EF12AA1BFAC073D

The GFX2D GPU is embedded in both SAM9X60 and SAM9X75; enable the
driver to use it.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index ff13e1ecf4bb9545d6d2210b2f3059e6807779a0..85e9b52152aec6746f660dd0c299cd5aa12ce2ea 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -144,6 +144,7 @@ CONFIG_VIDEO_OV2640=m
 CONFIG_VIDEO_OV7740=m
 CONFIG_DRM=y
 CONFIG_DRM_ATMEL_HLCDC=y
+CONFIG_DRM_MICROCHIP_GFX2D=y
 CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y

-- 
2.48.1


