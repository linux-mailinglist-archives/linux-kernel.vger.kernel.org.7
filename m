Return-Path: <linux-kernel+bounces-822457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D77BB83ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7864A2A71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2552F25E9;
	Thu, 18 Sep 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q6jYYVtA"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAB52DA76F;
	Thu, 18 Sep 2025 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189310; cv=none; b=h6tfp8LPvyCg0ikHpohPpZh7J9nnj0+rsHeNtce0dQoImkGQHi2YcJRESJy6HCuIWg3/OR6kT+aXad20DAIsxMebZe4np8DRm+Hy3IaVqeNt6/0/23aSHYXBkDcLdABDPJE+t2t3FsbnguVjOxtkIqmb8uPgtJCpUv7oCZyVxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189310; c=relaxed/simple;
	bh=LVDuLILG0rHg7RJ4jCcHsn8yRzwBL0hGBrsWquovBqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ztc3VwDP068yJ6xAWyADcfSuGitykeTgJuvea9hvTn/0PHz+4oCufdiVChoBzy8z+7g6pGoSETBamsHpf/ATWqSGyZfAA+a42j77RV2ZPFnCkJpyom3mYNW9p/WcSKGhvQ5OQSST+RWnK0xOPFIhk/9jcNGx35IOGF4PJRFvxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=q6jYYVtA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758189309; x=1789725309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LVDuLILG0rHg7RJ4jCcHsn8yRzwBL0hGBrsWquovBqM=;
  b=q6jYYVtAqUYwoP/FI0AXlIe2g+U69rEOLisFuRX/HFQ53xOQAGpncs4B
   tThuM/A2Oz9ke2I7oWY+R840ZV6z00vNQleeemvfxaAWqYAqjoguk/h3y
   jY2kAAX0nc8rQEwMXhtTQcARRbkkd5Pi8A4kyITCFAPnBpvDn+V/0aj5b
   lmrjF/X6bfOafZY65VpMwgsLKksXOcoflinRRcsA2cIld5BBss8IW7yGw
   vdzC32mwJKHCUv8rPHcKhKgtnUlFfv90qkfcJHJCzHa7zQv2kj2VPwfpW
   vH7qt7WGhvld+5qWE1ciZerTGwd4Bz+jcLdeo1aJbxQRWtnlwwrs/e4XH
   Q==;
X-CSE-ConnectionGUID: O8aTGVqaQjOx+eu6DgQ62g==
X-CSE-MsgGUID: f9VEl02USAaSQcCXZL8aPA==
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="46088874"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 02:55:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 02:55:00 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 02:54:55 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
To: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <balamanikandan.gunasundar@microchip.com>,
	<nicolas.ferre@microchip.com>
CC: Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH 4/4] ARM: dts: microchip: add I3C controller
Date: Thu, 18 Sep 2025 15:24:29 +0530
Message-ID: <20250918095429.232710-5-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918095429.232710-1-durai.manickamkr@microchip.com>
References: <20250918095429.232710-1-durai.manickamkr@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add I3C controller for sama7d65 SoC.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index c191acc2c89f..3a5da27f7d83 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -721,5 +721,17 @@ gic: interrupt-controller@e8c11000 {
 			#address-cells = <0>;
 			interrupt-controller;
 		};
+
+		i3c: i3c@e9000000 {
+			compatible = "mchp,sama7d65-i3c-hci";
+			reg = <0xe9000000 0x300>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_PERIPHERAL 105>, <&pmc PMC_TYPE_GCK 105>;
+			clock-names = "pclk", "gclk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 105>;
+			assigned-clock-parents = <&pmc PMC_TYPE_CORE PMC_ETHPLL>;
+			assigned-clock-rates = <125000000>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1


