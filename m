Return-Path: <linux-kernel+bounces-812405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFBCB537C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4AD174200
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44223353366;
	Thu, 11 Sep 2025 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TjIDLpeo"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057A1350D5B;
	Thu, 11 Sep 2025 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604506; cv=none; b=tAS6zNsWR4c1clvKu4M0/c9aTF2ETiHhsOpSa6jwE9TNdpazyMkKdZPU6J4qqQqpvKoEMSqNEvzUWNH75w8JUA0AYDGHdNGvUHCImoLwi6y2gWe3VruVhByjULA/MT1Vt93ANSaF1LOOebtVMzrZ+ywkEq4SbHLalgmEGO3xcbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604506; c=relaxed/simple;
	bh=/mLGAizM4D0NKvOiayu53Ks5IeoiBFtYbwR9O/5P3ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QUZ6S6b2X2raeK6r2fXyXG1ZeBLTCCtbNKSfgnXiNfEvFpYMkFXxIayxEYAb4pe/bczdFBQYMc9M6hwgJ9ParkSdbqz6c/y6jnMLz9SKEgdphK5p4bY52QgPbs0qd51Qyv5C/k4BT6jv68Ul4iiyue0bnngsGgUxYZTenbisaWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TjIDLpeo; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757604504; x=1789140504;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/mLGAizM4D0NKvOiayu53Ks5IeoiBFtYbwR9O/5P3ws=;
  b=TjIDLpeoPbheyh8wGdDEXTP2guEyynVSTa3LVqC3l61iogBx2Qn66Xmb
   FLWjcvH7ozDfK47WipkNrcVlDifQF07NtAtH1qrlyczFzrUH/8YK9dpBO
   gNlczUBaikXZo984Fpy49ka3Tr7/IdeP8yv+5qDoWfD5Qeea6NFJSIbE0
   VHLBiXU3NR9R8Qc76tMqwHlCsCDEMAZRGcKb96ZbpnjaKkbx/72q2BqkV
   IRH3G9pDk3gCJQwPM5b9dQnkL9oWvFlChd22cmrn8XESQJvuzzZoHWVNq
   /W8Z4u7AIbLvXBB47SBqsMvHlEvP9nf0NH/yff351/6i0lh3kPTRdGCsD
   w==;
X-CSE-ConnectionGUID: wLSDZ5hSTNSXS1TQWmJymw==
X-CSE-MsgGUID: 2qR1GhkmSEm/uyQPjbW9Nw==
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="213773303"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2025 08:28:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 11 Sep 2025 08:28:00 -0700
Received: from ROU-LL-M19942.mpu32.int (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 11 Sep 2025 08:27:57 -0700
From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Date: Thu, 11 Sep 2025 17:26:29 +0200
Subject: [PATCH 5/5] ARM: configs: at91_dt_defconfig: enable GFX2D driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250911-cpitchen-mainline_gfx2d-v1-5-d7fab1a381ee@microchip.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=751;
 i=cyrille.pitchen@microchip.com; h=from:subject:message-id;
 bh=/mLGAizM4D0NKvOiayu53Ks5IeoiBFtYbwR9O/5P3ws=;
 b=owGbwMvMwCXmf6yzKqEsVIbxtFoSQ8ahV5kvmMVNL/+e/elgq0JlwT5+r5DOZ6c3ivmsnm2du
 OXfstlNHaUsDGJcDLJiiiyH3mztzTz+6rHdK1EpmDmsTCBDGLg4BWAimxcwMvz0WTLN12Nn8fwP
 E6v6Gm/zns2aMYE5mVEw+nr2rAyOghWMDIdvLzv5er3/n2AdjqcCNy/v3jGtaGXezbAfG8Qa7rM
 fV+cAAA==
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


