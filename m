Return-Path: <linux-kernel+bounces-802546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C8AB45396
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4F11C272B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B29285C99;
	Fri,  5 Sep 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="b0q74gOA"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597128031D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065306; cv=none; b=tTFQ+W6eLI2JKwP3F86CwZHGSVl0sCbKOEo5osqWY7cdvoNEr5jwY9E5bWcqIfVVCUXAcEWAqaGWsD4O+qlgDBr8lCz1QEeYaRy6cPBRC87JNtnm0z/zE/UQusO43NOl2ufs/g1HRSzxFN7tpvIjiGaeZv0OZqAJ1NoBdhd/VX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065306; c=relaxed/simple;
	bh=uxBvIG6JS93Piz5bucjuuXb7Y1x/9XP0tXEguRFykwE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HSW9QCsHDOiOmLVaO4vj5MEKpY8Q3u6l92jqoytmsi7WSF1ShsIvhcslzneGqUoNTFHJKbqx91VsItv6A0nV++py5Si/gAe/5zy4whR7xGg0+iwfffDYmGzvjoOZw+6SFpqS86XT7lwnCJMWv1ILCRFiy7h8kzfncRJ+EEH6ud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=b0q74gOA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757065304; x=1788601304;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uxBvIG6JS93Piz5bucjuuXb7Y1x/9XP0tXEguRFykwE=;
  b=b0q74gOAYGHLy8uMA3XzxjY3YkKioz5IzbQf50vmKXgDc6t6i2B6AU0f
   zKFRBecT63PRVBpG5+elYJfI1jPvttG7dzUEIJ6QgEOUfxDSlj2uSWIh9
   UTyvI8kjIuce32ubx5Xs8wu50XmQJV6XR1jE/RuG0HxDGpb04BcP0nXDm
   0ZRfoOtcP36G1wBK4x9EwabzURUFEZEGlgbBshS2eB7LS6CnNAeBAU3nM
   j/2OaymPbP+FVDjXbu+wRNDFgBUEj++OkbQa6fG6Dc5SGgJ9DTiTurymC
   GbsPgC7RHw89zkM+bnzKUngXsN7Ta2DQM/4GmY0sDd23RFVajzWRYRNa7
   Q==;
X-CSE-ConnectionGUID: V3vcaq34T5mcK/flcDdNQQ==
X-CSE-MsgGUID: o6GtJDsEQ62AaBY3LPcuLw==
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="46672956"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 02:41:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 5 Sep 2025 02:41:27 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 5 Sep 2025 02:41:26 -0700
From: <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: Ryan Wanner <ryan.wanner@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>
Subject: [PATCH 1/2] ARM: debug: at91: add UART0 for sama5d2 DEBUG_LL
Date: Fri, 5 Sep 2025 11:41:11 +0200
Message-ID: <20250905094113.27480-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add the UART0 that is by default console on some boards
like the SAMA5D29-Curiosity.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/Kconfig.debug | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 366f162e147d..c941adbc850b 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -174,6 +174,14 @@ choice
 		    at91sam9263, at91sam9g45, at91sam9m10,
 		    sama5d3
 
+	config DEBUG_AT91_SAMA5D2_UART0
+		bool "Kernel low-level debugging on SAMA5D2 UART0"
+		select DEBUG_AT91_UART
+		depends on SOC_SAMA5D2
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on the UART0 port of sama5d2.
+
 	config DEBUG_AT91_SAMA5D2_UART1
 		bool "Kernel low-level debugging on SAMA5D2 UART1"
 		select DEBUG_AT91_UART
@@ -1635,6 +1643,7 @@ config DEBUG_UART_PHYS
 	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
 	default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
+	default 0xf801c000 if DEBUG_AT91_SAMA5D2_UART0
 	default 0xf8020000 if DEBUG_AT91_SAMA5D2_UART1
 	default 0xf8b00000 if DEBUG_HIX5HD2_UART
 	default 0xf991e000 if DEBUG_QCOM_UARTDM
@@ -1707,6 +1716,7 @@ config DEBUG_UART_VIRT
 	default 0xf7000400 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART1
 	default 0xf7000800 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART2
 	default 0xf7000c00 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART3
+	default 0xf701c000 if DEBUG_AT91_SAMA5D2_UART0
 	default 0xf7020000 if DEBUG_AT91_SAMA5D2_UART1
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
 	default 0xf8007000 if DEBUG_HIP04_UART
-- 
2.43.0


