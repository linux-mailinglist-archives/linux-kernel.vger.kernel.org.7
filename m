Return-Path: <linux-kernel+bounces-802519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C85B4530E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15F61885C7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81802701CF;
	Fri,  5 Sep 2025 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Wbyq1OIR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919782459E7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757064083; cv=none; b=HcKGbfB+YqlGZNKAgN8ZOvsVLEGxb5hYERZziLGkcDUrWd7GlP6vutzy/PNNY0mk9nvy7MTEaomt9SI4VkFnjP1ThqNWH7WKHs91IPCIDrEuXuW5adK1+jbs3EW3+2frdb98qskedWqTr4hMLYiuQOvIhmfyHzvVdnZc51+zykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757064083; c=relaxed/simple;
	bh=3wlQplHKoQ+m8+l8Ds1tA3KMLL8GWFA9HaRZhemqOdU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fk19Mp6ykNcOOtiO/x9vKOXlzy9bigetuyMMBxuNwngl4BXMMeTKYYdtjQEtUiEIKnG0Mpc8UeyxM/YufLnwi+j5v92hR0PrftJrreEezCriUUmbjHvFv5mWHSc7OOeJq7+CeKPK02o7HkFSb6thFEDJHWozBSJk+jvHE5ue95Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Wbyq1OIR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757064081; x=1788600081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3wlQplHKoQ+m8+l8Ds1tA3KMLL8GWFA9HaRZhemqOdU=;
  b=Wbyq1OIRYF8JQqedxe6ZzSKi9+dSI09j4AaQD3i/J8yjnTVokcAJyYky
   SIcrL014ak8R5LPxtlph9gQQQ2HIiyubQuOnKKal+fyAPHDkhqzh7/xkz
   HKcgqTSVPOsjMeq/KwZUZMgjlr+LtMJV5GcN4eBOwcgvhzAnJBljEUBIu
   9DvgZJIJ6OmAKozeheDj2pp7uPC2JFPlLzWDJm0QNpncCCDJ5wI5yN6lZ
   ZGDZWcN4H8EqkqK1+3EPO7yNdjkV3uuoYZofd1qbIOAvE727A5afJfNt5
   4rnWZ4Lp0Mk6bWsy8l31ru/FiQTPe5lzXfJFE10iivDeiS14uCuBkM4HZ
   A==;
X-CSE-ConnectionGUID: TCGxiWdGRGmXVlKQMbRlFg==
X-CSE-MsgGUID: E7XpECVTReeMFy9O5WQIBw==
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="277490372"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 02:21:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 5 Sep 2025 02:21:00 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 5 Sep 2025 02:20:58 -0700
From: <nicolas.ferre@microchip.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: Ryan Wanner <ryan.wanner@microchip.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>
Subject: [PATCH] ARM: dts: microchip: sama7d65: add uart3 definition for flexcom3 peripheral
Date: Fri, 5 Sep 2025 11:20:44 +0200
Message-ID: <20250905092044.25429-1-nicolas.ferre@microchip.com>
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

Add the definition of uart3 at the side of i2c3 for flexcom3.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Reviewed-by: Ryan Wanner <ryan.wanner@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index 84bac1d29421..9f3340c4ccf4 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -506,6 +506,21 @@ flx3: flexcom@e182c000 {
 			#size-cells = <1>;
 			status = "disabled";
 
+			uart3: serial@200 {
+				compatible = "microchip,sama7d65-usart", "atmel,at91sam9260-usart";
+				reg = <0x200 0x200>;
+				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
+				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pmc PMC_TYPE_PERIPHERAL 37>;
+				clock-names = "usart";
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(12)>,
+				       <&dma0 AT91_XDMAC_DT_PERID(11)>;
+				dma-names = "tx", "rx";
+				atmel,use-dma-rx;
+				atmel,use-dma-tx;
+				status = "disabled";
+			};
+
 			i2c3: i2c@600 {
 				compatible = "microchip,sama7d65-i2c", "microchip,sam9x60-i2c";
 				reg = <0x600 0x200>;
-- 
2.43.0


