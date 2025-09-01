Return-Path: <linux-kernel+bounces-794535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2E1B3E2F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2CF3A8B37
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18A9334739;
	Mon,  1 Sep 2025 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SswIjOZ+"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A0338F3B;
	Mon,  1 Sep 2025 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729741; cv=none; b=bVV7CLCKUsp2f38GADe1symbptwlrozBOC9DgsKoWa1rW7svk6uVYS+aiJxOqnp/wNI1pNsJykDbsjOAaxWNwPbvjki08nO+41xaHFOCpizRAGFBM87OtI46sO3/0ON6szSdHppSelBqf2M4nLjT/9cw5sXI8/jpwv42eQeSCiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729741; c=relaxed/simple;
	bh=ROxo+6HBRTu2WhNyNfP/6zbMmPihIqMWbmoJDRa+QXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bj3s+sZHeyu7nYzkCwJL8Bu+0QCl55ZMPdJO6IGaJPrzAwoYqTmybQFTwmMHnQ4Hx24DbKwawYHAD8NrSs6e4pVowNo9+Fai1IstjWRUFxMctzhnK4E9eMDJ70FRWUpPOBPj0QmjWzzYpTqUS4TNWF17ClEXibaSE/DV5rjkem4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SswIjOZ+; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 581CSsE62805457;
	Mon, 1 Sep 2025 07:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756729734;
	bh=WN+whkUQ8XqfkuukuvJSM7K0OZfjbIY1Xk7U8MUNQGM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SswIjOZ+vPoWXNa1AUtTi5wq8sXs9BJbN8Gw0lqU12UkU1+jU/9oQFxb8QtCoppRm
	 IOQ/GfrjSpl6MNsXEpWvSbnq2qlDuRcRL/hqwcJt1QBeTS8kFvJDLwtknFMhm+0NBt
	 ZnWeUHrFHL5mpW6EBIFYcl189AEliuWwuI+hY8fo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 581CSsMf1538228
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 1 Sep 2025 07:28:54 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 07:28:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 07:28:54 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 581CSc7s2504775;
	Mon, 1 Sep 2025 07:28:50 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <d-gole@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH v2 2/3] arm64: dts: ti: k3-am62x-sk-common: Remove the unused config from USB1_DRVVBUS
Date: Mon, 1 Sep 2025 17:58:34 +0530
Message-ID: <20250901122835.3022850-3-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901122835.3022850-1-a-kaur@ti.com>
References: <20250901122835.3022850-1-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

After the SoC has entered the DeepSleep low power mode, USB1 can be
used to wakeup the SoC based on USB events triggered by USB devices.
This requires that the pin corresponding to the Type-A connector
remains pulled up even after the SoC has entered the DeepSleep low power
mode.
For that, either DeepSleep pullup can be selected or the pin can have the
same configuration that it had when SoC was in active mode.
In order for DeepSleep configuration to take effect, the DeepSleep
control bit has to be enabled.
Remove the DeepSleep state configuration from USB1_DRVBUS pin as it is
anyways not taking effect (DeepSleep control bit is not set).

This reverts commit 527f884d2d94981016e181dcbd4c4b5bf597c0ad.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 13e1d36123d51..d3bed23134ca0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -249,7 +249,7 @@ AM62X_IOPAD(0x12c, PIN_OUTPUT, 0) /* (AD19/V15) RGMII1_TX_CTL */
 
 	main_usb1_pins_default: main-usb1-default-pins {
 		pinctrl-single,pins = <
-			AM62X_IOPAD(0x0258, PIN_OUTPUT | PIN_DS_PULLUD_ENABLE | PIN_DS_PULL_UP, 0) /* (F18/E16) USB1_DRVVBUS */
+			AM62X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18/E16) USB1_DRVVBUS */
 		>;
 	};
 
-- 
2.34.1


