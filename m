Return-Path: <linux-kernel+bounces-864578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C01BFB19B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 726EC4F73C1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221B631280D;
	Wed, 22 Oct 2025 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s2IIjxue"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF173101B8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124454; cv=none; b=Nmr03uCfM+idSDDtixGA4AsiMlHtYCGJ0mkLgDax5gBJcWDPwNcDeymg8UQ4ksueEOG7dgzREvw4Z/VZmQZdbi7Rj7akQYnYaUhxN2TIlXJe9FY8K18ngxxzgZDSb7Y831CDsoA+IWo4nSPY3fT+mbe+aHwKu133UlCPuwJVOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124454; c=relaxed/simple;
	bh=qcS+K1bmBeQE86BuzfqFQqSfV1A2G1hZGYBYEBDMwck=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R6uEIpvsSn6cvt3GfbnZ53YPxT4gDyXyELdlBpb/TkOJCSF2wdTua7qIDNTTDaN2y2+r1GPWdwimbIbdxQ2X+L57LR4dM9ygnp73FZFxE6X6G9RnZ+8BGA7gSxddoCRWelQjFecS1tNBdeNBR3H7DxrmRdSOwh7gZbbIHlo6PAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s2IIjxue; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761124453; x=1792660453;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qcS+K1bmBeQE86BuzfqFQqSfV1A2G1hZGYBYEBDMwck=;
  b=s2IIjxueaX3JKb4nABfsPLq33XhF7QEirM+zwVb+q7CVjaA4WRTEZDSe
   ROM+S8N+YvCbPFjGJuozughj+J59dKayWKJaufyBo+fAdI8DiMLfgSya8
   gcd6/xmZPxSbvmLA+0wtNCseYfCOmue4K0Z5Sa1bKK7Tvke+z6oMVrQtl
   2c27MoBxW2Wetdt+hZyNPv7PWLXP16J/zxbeVx/eUAX4wmYpzZPVhVPWf
   UiLoSuRk1LXq+AmT/EpZv1OyIenIPKy3NuKnhdXXz9Q/h/dIvQOWPdBD4
   3Ig91+AI1nUQPr8F4/a3VWX5JINwOCLMQzRooLJRLzBOQQkQTPWzLOjbA
   w==;
X-CSE-ConnectionGUID: sQh31e/WR3uMWyklH0AEwg==
X-CSE-MsgGUID: dmOl+ZzSSDafFvA0GS/R0A==
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="48111526"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 02:14:11 -0700
Received: from chn-vm-ex3.mchp-main.com (10.10.87.32) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Oct 2025 02:13:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Wed, 22 Oct 2025 02:13:51 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 22 Oct 2025 02:13:46 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>, <dharma.b@microchip.com>
Subject: [PATCH v2 RESEND 0/3] Add LVDS display support and PLL handling
Date: Wed, 22 Oct 2025 14:43:48 +0530
Message-ID: <20251022091351.472331-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit

Hi all,

This patch series adds LVDS display support for the Atmel HLCDC driver
and introduces proper handling of the LVDS PLL clock required for such
panels.

The Atmel XLCDC IP supports multiple output types — Parallel RGB, MIPI
DSI, and LVDS. While the existing implementation handles RGB and MIPI
displays using the LCD generic clock (sys_clk), LVDS panels require the
dedicated LVDS PLL clock (lvds_pll_clk).Configuring the LVDS PLL clock
rate automatically based on the panel pixel clock, eliminates the need
for assigned-clock-rates entries in the device tree

Change logs are mentioned in individual patches

Dharma Balasubiramani (2):
  drm: atmel-hlcdc: add support for LVDS encoder type
  drm: atmel-hlcdc: set LVDS PLL clock rate for LVDS Displays

Manikandan Muralidharan (1):
  mfd: atmel-hlcdc: fetch LVDS PLL clock for LVDS display

 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 86 +++++++++++++++++--
 drivers/mfd/atmel-hlcdc.c                     | 16 +++-
 include/linux/mfd/atmel-hlcdc.h               |  1 +
 3 files changed, 95 insertions(+), 8 deletions(-)


base-commit: c1a7cc00cd412505e070eb4e62bc0b0ca85243e0
-- 
2.25.1


