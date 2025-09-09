Return-Path: <linux-kernel+bounces-807971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6EFB4AB94
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E75A00579
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9A632CF97;
	Tue,  9 Sep 2025 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="R6OYSxYh"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198B932CF85;
	Tue,  9 Sep 2025 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416475; cv=none; b=JxLiDk12jshYvBd0cWJnng5uVu5wj1K8jZ8V1wvYmd7QveZvM6Y0fWYNqbDwKaDSTe4b6ZzLLJpe3Xk831clwFgs1LJKjZZBRuF7P1RfiQt1SLE5Q2pxAki5Lc/R91EeBeUQGc5lzfySKGAQOAnpeHsfU9cmOWoQmACKMjp5bjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416475; c=relaxed/simple;
	bh=GZJmWMk93oXyxDyZivakFznXcmsnaFRq2N8vRJ7jwuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRLJCoC6a1cPC3OvGmMqn73AArTM4kTOTAooW/PRS+Yf1ehzFbOn0Q6FI6VNpavnlz/EIcp3+NoABvZpu1ZqxQ+Y1kfzbHcTsBcVt0aFGKiaDLV4oPulihWO+IZM4lCywv8Lwk7ZD9Nh4LYhg2PJ08DcYxHcJn1tDgttNO4FF6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=R6OYSxYh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757416475; x=1788952475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GZJmWMk93oXyxDyZivakFznXcmsnaFRq2N8vRJ7jwuw=;
  b=R6OYSxYhrRYb3cwlsOn9gADHRPv4o8B2yhWpK/CZMzjng7s8mhvC7wcZ
   PTFCyK+ZyHvLQ3qUpzSJOKVey6eyTbNdb8tj6NkOKl/YvJi+ERw0IUWZj
   3c49lMW1aCOF61qD5s/RWRhCBx0Uuj2H6yIEwL0B+DeV4LtUc25tk53fg
   7ko7dCMNlq6Ti1/8MRPBA6yg630IKzwPstCMtT9s8Bo5IeP6XFFKpMSAs
   6KtisgOLkvH/oUmNoR7bG+MDPd/w1gCIc0We3DXzUQw/rtDZ4GXQa7CnR
   +Cyj3ATaBBAaRpsgjKpeQtM9+hxv9r2NeLDb5HaJryTOBamhBfN3Aue4F
   Q==;
X-CSE-ConnectionGUID: zXKKnkvnQ9OWOnJoRLg38w==
X-CSE-MsgGUID: b4n6CbC2R8OPedHkPkkdCQ==
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="46245765"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:14:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 9 Sep 2025 04:14:13 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 9 Sep 2025 04:14:08 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
To: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <balamanikandan.gunasundar@microchip.com>,
	<nicolas.ferre@microchip.com>
CC: Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH 4/4] ARM: dts: microchip: add I3C controller
Date: Tue, 9 Sep 2025 16:43:33 +0530
Message-ID: <20250909111333.170016-5-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909111333.170016-1-durai.manickamkr@microchip.com>
References: <20250909111333.170016-1-durai.manickamkr@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add microchip I3C HCI master controller for sama7d65 SoC.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index c191acc2c89f..fbc80924daab 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -721,5 +721,17 @@ gic: interrupt-controller@e8c11000 {
 			#address-cells = <0>;
 			interrupt-controller;
 		};
+
+		i3c: i3c@e9000000 {
+			compatible = "microchip,sama7d65-i3c-hci";
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


