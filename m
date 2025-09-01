Return-Path: <linux-kernel+bounces-794534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C193B3E2FB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAA5179D99
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64B83376BA;
	Mon,  1 Sep 2025 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yEYf4Gu5"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43A13376B8;
	Mon,  1 Sep 2025 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729735; cv=none; b=MpufSQTwHEJxfSDRwpEjKr9FR1pJLnELOL3/Tq2E4CrzKphoOuQvNdHURC78tP1ERsCYiCViADVe4AkW77MWeREf5BZ/wY/E31K3bb14KWCg2HJwHJbWm8OvhDI5QzzEyuBY+ETfbTdtcmOcyQHkikhnJQMXgFFHkqXm1eWGeaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729735; c=relaxed/simple;
	bh=AHuXy/9bn643v++FikekyjR7rOzZzAKBSXF7Oymd12Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eK4uYp7fD4nmgO8VgIsgsiXIVoGnz6V/+kvp0Fyv8UbVah3OF2V0oSn5j2yu9+Ma8fOg5cFnsTtmNeReDzkuhmU83d4mE0IDXT4olOoxsgaUX9a2IOS0wSW8evOwQ83fRUo8Gr5FA3h9d+MQ8ScEb5FuOAsYmEuYMKyJoS+3EUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yEYf4Gu5; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 581CSmFN2369163;
	Mon, 1 Sep 2025 07:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756729728;
	bh=Kn7DKCsCS2OB/QdeXfV3m9IgHXEdPCeFN7iaFb5kKUY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yEYf4Gu5AW64jonL5aXlI7ByVrPNFu7DkZVQaNvybH6eGB2xZJ66S3Fa/gRtTu4lK
	 u3RZZ7rYvXGMtxboyxHTS9DxPkhQblxV58wk49CQ/TGEObnymp5N3qu0yQ1tabKNrR
	 /T+1Bv7FFc4r7rwKyWMeBbHUJXJEzplQ+u06Du/w=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 581CSmiE2721492
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 1 Sep 2025 07:28:48 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 07:28:48 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 07:28:48 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.177])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 581CSc7r2504775;
	Mon, 1 Sep 2025 07:28:44 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <praneeth@ti.com>, <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>,
        <d-gole@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <vishalm@ti.com>, <sebin.francis@ti.com>
Subject: [PATCH v2 1/3] arm64: dts: ti: k3-am62p5-sk: Remove the unused config from USB1_DRVVBUS
Date: Mon, 1 Sep 2025 17:58:33 +0530
Message-ID: <20250901122835.3022850-2-a-kaur@ti.com>
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

After the SoC has entered the DeepSleep low power mode, USB1 can be used
to wakeup the SoC based on USB events triggered by USB devices. This requires
that the pin corresponding to the Type-A connector remains pulled up even after
the SoC has entered the DeepSleep low power mode.
For that, either DeepSleep pullup can be selected or the pin can have the
same configuration that it had when SoC was in active mode.
In order for DeepSleep configuration to take effect, the DeepSleep
control bit has to be enabled.
Remove the DeepSleep state configuration from USB1_DRVBUS pin as it is
anyways not taking effect (DeepSleep control bit is not set).

This reverts commit 115290c112952db27009668aa7ae2f29920704f0.

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 899da7896563b..e8f0ac2c55e2f 100644
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


