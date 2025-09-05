Return-Path: <linux-kernel+bounces-802042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E87B44D10
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3AD87AD0B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9EC23D7CE;
	Fri,  5 Sep 2025 05:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XFiBaNuB"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6DB26A0C5;
	Fri,  5 Sep 2025 05:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049312; cv=none; b=GVx/kDJSKT5JjUtoQZiBAHfZCmK/qR8dod0hoeZvL9v6zu6onsJ1K9WTshZXXQlinBp9C2BTo1OWUHTFQbN1ssgL6nhDMclJPLXJdWf6uCNode59ZRdyupkDdYAclHbAR/W7pXAd4Lcp3h35czqRk0hxEhC5s99kf1uGY3k5Epc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049312; c=relaxed/simple;
	bh=jy4P8UWYGHbFspF7iugtJuJkmFtynAOIkxNyhFJU0zU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHsStiu23PKm8wB4SH9ZJhHC6Ww0p08wQrWHRRDua9CDy2SWRHXjDtl4H/bPfpURjD6bRCi1mT4Jh/EwbEzp2yHH0J7kZt/ApZv89sGbi0jcYC3jT38r3I+oIAdjI9QL+x/NpL9AVeMZn3xJXMU0fOZI8nQIH5VlSg6kebzXpo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XFiBaNuB; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5855F5d33245521;
	Fri, 5 Sep 2025 00:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757049305;
	bh=otDRlUkWg1EAiRuCq1NNN2J1DtOx7l367UeVek+CWEM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XFiBaNuBeDt3kfVBGSvKeYjoIVBA32DsiMWRl1JeA6vkTbdM99hy1sl8eWaiV9ZaA
	 NNSbsbs4uA9WgBAzcbUpVPt3LELEFzuzXHMa2YhqOS2rtqDV62jamd/++JJWI+geHM
	 nT5nsWosWo3iA7TJqKGFo5wUsomhgZ/VXGdCyfE0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5855F55l653255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 00:15:05 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 00:15:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 00:15:04 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5855Ep0f4118818;
	Fri, 5 Sep 2025 00:15:00 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <d-gole@ti.com>, <u-kumar1@ti.com>, <sebin.francis@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>
Subject: [PATCH v5 1/4] arm64: dts: ti: k3-am62p5-sk: Remove the unused cfg in USB1_DRVVBUS
Date: Fri, 5 Sep 2025 10:44:45 +0530
Message-ID: <20250905051448.2836237-2-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905051448.2836237-1-a-kaur@ti.com>
References: <20250905051448.2836237-1-a-kaur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

After the SoC has entered the DeepSleep low power mode, USB1 can be used
to wakeup the SoC based on USB events triggered by USB devices. This
requires that the pin corresponding to the Type-A connector remains pulled
up even after the SoC has entered the DeepSleep low power mode.
For that, either DeepSleep pullup configuration can be selected or the pin
can have the same configuration that it had when SoC was in active mode.
But, in order for DeepSleep configuration to take effect, the DeepSleep
control bit has to be enabled.
Remove the unnecessary DeepSleep state configuration from USB1_DRVBUS pin,
as the DeepSleep control bit is not set and the active configuration is
sufficient to keep the pin pulled up. This simplifies the setup and removes
redundant configuration.

This reverts commit 115290c112952db27009668aa7ae2f29920704f0.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 899da7896563..e8f0ac2c55e2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -360,7 +360,7 @@ AM62PX_IOPAD(0x01b0, PIN_OUTPUT, 2) /* (G20) MCASP0_ACLKR.UART1_TXD */
 
 	main_usb1_pins_default: main-usb1-default-pins {
 		pinctrl-single,pins = <
-			AM62PX_IOPAD(0x0258, PIN_INPUT | PIN_DS_PULLUD_ENABLE | PIN_DS_PULL_UP, 0) /* (G21) USB1_DRVVBUS */
+			AM62PX_IOPAD(0x0258, PIN_INPUT, 0) /* (G21) USB1_DRVVBUS */
 		>;
 	};
 
-- 
2.34.1


