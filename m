Return-Path: <linux-kernel+bounces-816480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 737C3B57452
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C33416EFD1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897E72F066C;
	Mon, 15 Sep 2025 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="yfmTZ+GC"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4678B2F39AB;
	Mon, 15 Sep 2025 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927686; cv=none; b=QGGSZhIUSod08niVsn+irpm/P0pxICFugJjR/lAHo8G5sGeH0Mh6eTp+f5J5wlHwygWhbnb5JexxQfzlq6D3F2zTz5eqWnY8Nnjt/r3PtyhoqIoFdqyd6Hs1+/bcZsazblTzLs+zBhFas74KbIScUFhMoVPG5WW/FVF9adEbXaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927686; c=relaxed/simple;
	bh=oQfosn2zhfeucMRo21AsBcaF4NJayEqqcVK99eNlv3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=HYmGHDWjEUg3pAN8+b+u+VSKT4VJ1k781RU4TIh04LE1QxAvzmmxyatWNpTt+vIxNmmj/vUMoW1nQOxmpAjBP4eMvDLA93IYpGqckaoCzGAxmp6YDGspuMlHOAUrj8dXsA2IdyZ0OX8NWgpfYHXbeBlXSpgtXq0q3ZcUsepohFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=yfmTZ+GC; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757927685; x=1789463685;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=oQfosn2zhfeucMRo21AsBcaF4NJayEqqcVK99eNlv3Q=;
  b=yfmTZ+GCtWRq7+NiBWaYHtyvvnCUvlRyPTuQiUdhtssipimxx/SnsTYF
   3jro0iKRFgovV1i47cdKrPxujvbseHGG2qpfzx+q00arhXrYuIGhY2ABz
   Zmd0qiP/9aNCp2fuOOB7z9WfxmVRuYzAdaEil77xhQeomxgwEpGJ9bI8R
   LYci5OzPu9gq/tBR0dCWOvqeQ3WGTaMks5P3K4Dwkj2aM0UT9IhogRPQl
   sOH0B8ncSzzSRUM/psCHP9dyiVkaExxATvbhzRnr582kqH0KVkTpNXjdI
   bxS+PZjf88pJ5u4blX8PWc2seJ4aHNUtAwALbVrqw31YkITfKx5jBiUtu
   w==;
X-CSE-ConnectionGUID: tqZ4GQ/vQ0a7gKvyioyWTQ==
X-CSE-MsgGUID: yueklx7FSNKUzjdwWJszSQ==
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="213891748"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2025 02:14:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 15 Sep 2025 02:14:05 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 15 Sep 2025 02:14:00 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Mon, 15 Sep 2025 14:43:57 +0530
Subject: [PATCH] ARM: dts: microchip: sam9x7: Add qspi controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250915-sam9x7-qspi-dtsi-v1-1-1cc9adba7573@microchip.com>
X-B4-Tracking: v=1; b=H4sIANTYx2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0NT3eLEXMsKc93C4oJM3ZSS4kzdRBMLExMjM7MkQ/MUJaC2gqLUtMw
 KsJHRsbW1AFznxiViAAAA
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dharma Balasubiramani
	<dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757927640; l=1714;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=oQfosn2zhfeucMRo21AsBcaF4NJayEqqcVK99eNlv3Q=;
 b=NYixYiS+TI4iR/32pLdtnHSaO90FMDfIhQphSIsup9JZeqYuVvcOVQ4HJloezNJMWSIWKn/YG
 V/cPI3tieG8BmN4OsemoTkAxFVsn8EFDZGm90qTbgDFlsyngVVkki58
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Add support for QSPI controller.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Driver and Doc support
https://lore.kernel.org/lkml/20250908-microchip-qspi-v2-0-8f3d69fdd5c9@microchip.com/
---
 arch/arm/boot/dts/microchip/sam9x7.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sam9x7.dtsi b/arch/arm/boot/dts/microchip/sam9x7.dtsi
index 66c07e642c3e..46dacbbd201d 100644
--- a/arch/arm/boot/dts/microchip/sam9x7.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x7.dtsi
@@ -271,6 +271,27 @@ AT91_XDMAC_DT_PERID(38))>,
 			status = "disabled";
 		};
 
+		qspi: spi@f0014000 {
+			compatible = "microchip,sam9x7-ospi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xf0014000 0x100>, <0x60000000 0x20000000>;
+			reg-names = "qspi_base", "qspi_mmap";
+			interrupts = <35 IRQ_TYPE_LEVEL_HIGH 7>;
+			dmas = <&dma0
+				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+				AT91_XDMAC_DT_PERID(26))>,
+				<&dma0
+				(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+				AT91_XDMAC_DT_PERID(27))>;
+			dma-names = "tx", "rx";
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 35>, <&pmc PMC_TYPE_GCK 35>;
+			clock-names = "pclk", "gclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 35>;
+			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_PLLADIV2>;
+			status = "disabled";
+		};
+
 		i2s: i2s@f001c000 {
 			compatible = "microchip,sam9x7-i2smcc", "microchip,sam9x60-i2smcc";
 			reg = <0xf001c000 0x100>;

---
base-commit: 590b221ed4256fd6c34d3dea77aa5bd6e741bbc1
change-id: 20250915-sam9x7-qspi-dtsi-a4844266b17d

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>


