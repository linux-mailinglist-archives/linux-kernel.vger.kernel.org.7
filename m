Return-Path: <linux-kernel+bounces-802547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E79CB4539C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42F3560217
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1928688A;
	Fri,  5 Sep 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KpUUR9pi"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D252284880
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065308; cv=none; b=ASGMlAT/5JWfQzwkbwFM9P5syPnfeFvhdK7lE0Gol96qoWd6s1owmTd8BFqbrGVNT7FSNcyf0k9Se5PZ7KMcr4GbZmavmLTHRyJjLClUhP0vkRBCMCT+ewytlBxNQUbATcm51ivb9izb/BarIIHxWbx7PkLD1MYbD2oSr0cpNfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065308; c=relaxed/simple;
	bh=TWlOD5JXXoZNqvz8QV1CVTOyMCxc0QRwYAvXeE6WEKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlyoPXIGHkd4cMRQOrfe/vjBj38ma99ffeB2lnUcfnATuqsCCQ1njNch/s58RnzYH5OtSHY5oSh6BRvKHq9L3Y3XrBZdH4BFN1E1EDpD5eADfP03SqLWJkMBDoPp2cNJUufwoQ0aoDEwgqngw40S3YYTaZgWvYyrxgfH6O3ckLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KpUUR9pi; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757065306; x=1788601306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TWlOD5JXXoZNqvz8QV1CVTOyMCxc0QRwYAvXeE6WEKc=;
  b=KpUUR9pibY4k/o5pG1r3qWSI9fScHedMavyxyKvaYSIR/sRVxyxTsvL2
   9wEusO1R45cVcdXsN7GHx3dSiKGBAKLpIzoAY2GrB2INxJoF/dmmdseMv
   5Yc6/pZhZ1DcKMa7J2eGqojUz8D9FvKQydgbgZ2WG/ZFVuhfkvugkFQvh
   NVH8e68RcLPRthz7Avj6qTU1U8wYS6Go0F+PkHqv9F17+vyWswdfQE3QN
   Oj0cXqb+/ikVYWYw96Qc/+HPmoaCumdYYjZL6UjJxAKdO3eCQriF380mF
   SDAVBZL1IxshCDqKYg4u8IXEmTqHtjSPRCa9MB1iIudUYxo72u+BiUAei
   A==;
X-CSE-ConnectionGUID: V3vcaq34T5mcK/flcDdNQQ==
X-CSE-MsgGUID: TK0c2vcETQKZ5tXxhj0VwA==
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="46672958"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 02:41:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 5 Sep 2025 02:41:29 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 5 Sep 2025 02:41:27 -0700
From: <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: Ryan Wanner <ryan.wanner@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>
Subject: [PATCH 2/2] ARM: debug: at91: add sama7d65 debug uarts for DEBUG_LL
Date: Fri, 5 Sep 2025 11:41:12 +0200
Message-ID: <20250905094113.27480-2-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905094113.27480-1-nicolas.ferre@microchip.com>
References: <20250905094113.27480-1-nicolas.ferre@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add USART6 on Flexcom6 for AT91 DEBUG_LL with associated physical and
virtual addresses. It's the debug console on SAMA765 Curiosity board.
Add the possibility to use USART3 as well because it's the debug console
on some other SAMA7D65 boards.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Reviewed-by: Ryan Wanner <ryan.wanner@microchip.com>
---
 arch/arm/Kconfig.debug | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index c941adbc850b..1f4c473b81ac 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -207,6 +207,22 @@ choice
 		  their output to the USART1 port on SAMV7 based
 		  machines.
 
+	config DEBUG_AT91_SAMA7D65_FLEXCOM3
+		bool "Kernel low-level debugging on SAMA7D65 FLEXCOM3"
+		select DEBUG_AT91_UART
+		depends on SOC_SAMA7D65
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on the FLEXCOM3 port IOSET 1 of SAMA7D65.
+
+	config DEBUG_AT91_SAMA7D65_FLEXCOM6
+		bool "Kernel low-level debugging on SAMA7D65 FLEXCOM6"
+		select DEBUG_AT91_UART
+		depends on SOC_SAMA7D65
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on the FLEXCOM6 port IOSET 4 of SAMA7D65.
+
 	config DEBUG_AT91_SAMA7G5_FLEXCOM3
 		bool "Kernel low-level debugging on SAMA7G5 FLEXCOM3"
 		select DEBUG_AT91_UART
@@ -1627,6 +1643,8 @@ config DEBUG_UART_PHYS
 	default 0xd4018000 if DEBUG_MMP_UART3
 	default 0xe0000000 if DEBUG_SPEAR13XX
 	default 0xe0064200 if DEBUG_AT91_LAN966_FLEXCOM
+	default 0xe182c200 if DEBUG_AT91_SAMA7D65_FLEXCOM3
+	default 0xe2020200 if DEBUG_AT91_SAMA7D65_FLEXCOM6
 	default 0xe1824200 if DEBUG_AT91_SAMA7G5_FLEXCOM3
 	default 0xe4007000 if DEBUG_HIP04_UART
 	default 0xe6c40000 if DEBUG_RMOBILE_SCIFA0
@@ -1690,6 +1708,8 @@ config DEBUG_UART_VIRT
 	default 0xc8821000 if DEBUG_RV1108_UART1
 	default 0xc8912000 if DEBUG_RV1108_UART0
 	default 0xe0010fe0 if ARCH_RPC
+	default 0xfc82c200 if DEBUG_AT91_SAMA7D65_FLEXCOM3
+	default 0xfd020200 if DEBUG_AT91_SAMA7D65_FLEXCOM6
 	default 0xe0824200 if DEBUG_AT91_SAMA7G5_FLEXCOM3
 	default 0xf0010000 if DEBUG_ASM9260_UART
 	default 0xf0100000 if DEBUG_DIGICOLOR_UA0
-- 
2.43.0


