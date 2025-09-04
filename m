Return-Path: <linux-kernel+bounces-800638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D5B43A13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4B93A8A39
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CD52FD7B9;
	Thu,  4 Sep 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Lhm/52Xc"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D6D2FC86F;
	Thu,  4 Sep 2025 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985161; cv=none; b=ptWhB6FNniurP+ecyW2ZzN9XspzmEyKS+kuLs1u4cbHjjxIc5mat9ILyp4YInt/u3NpDNJLwZAIAZuKsj4NwQYH6kOh8fFBShF9mTGoC+T5kxjrbHqZ1O+A6+aeCqLENqFpa3x/ziMTpJlFBBvh8odfhgqmn1gcFdWmP5ArT8HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985161; c=relaxed/simple;
	bh=jy4P8UWYGHbFspF7iugtJuJkmFtynAOIkxNyhFJU0zU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQSl7v1QG1yi3UKNDPE3SNDn2acAw3Z8NYKUFlB5pe7E3IjZfnspAa53MRS3Uxe0GJqIgKIaohCdFTy5Fx6+XrIRoBJkoxM81JVWNjobkyDudBGEqBU/xHaIqRWbXP1VMD8AXDeX/MCLmSPKtxdymrtxTCd8AASm6gIInj1Z0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Lhm/52Xc; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584BPtRC3000505;
	Thu, 4 Sep 2025 06:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756985155;
	bh=otDRlUkWg1EAiRuCq1NNN2J1DtOx7l367UeVek+CWEM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Lhm/52Xc/kyxsG6CE+RN45wHb8frZS/WKmOdQYDpG6NoP4lVYFSBCjEqQf+hMmEqv
	 QIqAElZGAYp8DJjUcX0xNELtxP53walkhfAILu7uACfjK9tNimcTVtabU2rHQFupnh
	 Fw6y6aCQ/NI2lpCXXlbGlB08+TXN9kPnXgt4SF/8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584BPtIU3772666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 06:25:55 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 06:25:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 06:25:54 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584BPedK3179752;
	Thu, 4 Sep 2025 06:25:50 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <d-gole@ti.com>, <u-kumar1@ti.com>, <sebin.francis@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>
Subject: [PATCH v4 1/4] arm64: dts: ti: k3-am62p5-sk: Remove the unused cfg in USB1_DRVVBUS
Date: Thu, 4 Sep 2025 16:55:35 +0530
Message-ID: <20250904112538.529857-2-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250904112538.529857-1-a-kaur@ti.com>
References: <20250904112538.529857-1-a-kaur@ti.com>
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


