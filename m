Return-Path: <linux-kernel+bounces-752050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8195CB170CC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66D616FE81
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D092C08A1;
	Thu, 31 Jul 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uPzbAtpA"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5021A3150;
	Thu, 31 Jul 2025 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753963062; cv=none; b=SUPobhg2EiiP8IjRsj9IEJEUdcOy7YW+0YS3C1PQ8OjYTs5YaBv9AuwsK0CAloMOfPjmOEohkuy7lAaQDySl9WLdVoxxVLkzS2tEsZfkHRtg70vkvUlIax2Xzg2lOMXjqWp5EmHplzYseQl/TPRRzKraINTvjg/URmZuC5tTxWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753963062; c=relaxed/simple;
	bh=9wGDxiop2iAPiBaokYEUH8ikrRQ0ftDNEqFDtSYQ5/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dv/W4m/KubbqLypbhr9bAJeF12uCkM2Kc/1WlJnDKOyao5CiT/6ryNHOjnNKFLlXa8JKIByyBRPIj6escOu2yuSzzW/7NJvIFSf55RF2RvdGJMfwtXyo174D7fX9wVNnYx89T5WEefHVzJm4KvpA9CyDrdB3dwzBT2GgDJrMWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uPzbAtpA; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56VBvXj82995868;
	Thu, 31 Jul 2025 06:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753963053;
	bh=KiBTlWI3j1FJ7GHY2rhDHNUwcWsXDjSNiW0JAtJELYA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uPzbAtpA8CgVHHSs6zEo5OAQ1mUubzOB/oeI9iq79UIZsf7rMILYAy61764hNXUnB
	 nEdHxhiVIRuWON5a/S9yMHLai6/dG9RM5JynOzZ0mwtt2/bKe/rb+8m4InSTs4gWkN
	 PzyOQL5EEeSD9NTA/JZEKpp+RK6P9eSKd1FFOvsE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56VBvXgU2686528
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 31 Jul 2025 06:57:33 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 31
 Jul 2025 06:57:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 31 Jul 2025 06:57:32 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56VBudQQ2861468;
	Thu, 31 Jul 2025 06:57:29 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH 2/3] arm64: dts: ti: k3-am62x-sk-common: Remove the unused config from USB1_DRVVBUS
Date: Thu, 31 Jul 2025 17:26:30 +0530
Message-ID: <20250731115631.3263798-3-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731115631.3263798-1-a-kaur@ti.com>
References: <20250731115631.3263798-1-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

After the SoC has entered the Deep Sleep mode, USB1 can be used to wakeup
the SoC based on USB events triggered by USB devices. This requires that
the pin corresponding to the Type-A connector remains pulled up even after
the SoC has entered the Deep Sleep mode.
For that, either deep Sleep pullup can be selected or the pin can have the
same configuration that it had when SoC was in active mode.
In order for deep sleep configuration to take effect, the deep sleep
control bit has to be enabled.
Remove the deep sleep state configuration from USB1_DRVBUS pin as it is
anyways not taking effect (deep sleep control bit is not set).

This reverts commit 527f884d2d94981016e181dcbd4c4b5bf597c0ad.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 13e1d36123d5..d3bed23134ca 100644
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


