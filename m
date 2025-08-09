Return-Path: <linux-kernel+bounces-761184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ACAB1F565
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4E1625FA8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB2A2BEC5C;
	Sat,  9 Aug 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDTugSf6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DDB277029;
	Sat,  9 Aug 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754756305; cv=none; b=qnuqhClBBG/YU8xRrYC0x7Es4zmESMuDqth2dO4ld0idC8lou5ZWnDeGYElhjo8TAjk+C1Cvpgj3AUMyBEjQNkyjITcfEAjjqkca5crfxUeRX0jElzDekzBkN2GvsjvK1D3niZRqJLQjROUZOWZEqPjWpbnEkODuaKGoSt2y6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754756305; c=relaxed/simple;
	bh=Ym2P+ekDEEegX+3UjM/QGAdR0kffoWcIHKXwIKpTqxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEdSrKKe5DY1dXdXkhyuVprI58/2plmuP6pfYrgCDyDevuGYQfXjwo3XZ6mLZRbwh1sVmGNw2lIN7ZigSWrD/TinUEse3QNc9otNsYQhJDRLm9ancInd6O2V6iQMTtKjN2xlsZefseVrWq5Y1Z9+wyQMVfRxk5YQbQGpRXTWts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDTugSf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2737C4CEF1;
	Sat,  9 Aug 2025 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754756304;
	bh=Ym2P+ekDEEegX+3UjM/QGAdR0kffoWcIHKXwIKpTqxc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eDTugSf6nLEL4MnLxkD9CW9289CYSvdFcUZXFgdBu+QzrMwyM3JDbmde84YrqgdDY
	 CxCNg05LXvgfmBOkHKJowUfWBg3TNIH7wECRo/PYJRnfM+clN6AZVlet5D07P9Pebs
	 2KrNMzl8STivOzMMtMYA6oVRIhoDYsOLJWlVPV2uxv9OhK24ekFcfFIbDyk/INWFtV
	 1fsRZrSb0DTKxm1gP5aw5ttUElmvdY4BuedRUWrsAHBkjYmgtLlRq7G7led9RSxnH5
	 207QcKbSXZEaQgxW0heFn2PF+JhPcUt10E+N7+jmFoeccVRkPvrhJH/+nQiRfUkJGG
	 LukmMWxmaMRZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A14ECA0EC0;
	Sat,  9 Aug 2025 16:18:24 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Date: Sat, 09 Aug 2025 18:18:07 +0200
Subject: [PATCH v2 2/3] ARM: dts: allwinner: orangepi-zero2: Add default
 audio routing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250809-opz-audio-v2-2-f4fd15552a82@posteo.net>
References: <20250809-opz-audio-v2-0-f4fd15552a82@posteo.net>
In-Reply-To: <20250809-opz-audio-v2-0-f4fd15552a82@posteo.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754756302; l=1692;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=MNIFx+OhapBMs8FasylcBkObgSQEZMhAy+EBWCVQkAk=;
 b=wHIiYEunlGpmpYxfLe/S8ow0gBeBtJYtg7Np+1pF7G8x0teIiBYaUY11k1CQ+rGiTA3kz1Bk2
 W0koQwJWCQ0CHuiazLSiYbvQzJlyo+hyPbscDKkuOyIVvIS3OCK9on1
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

From: "J. Neuschäfer" <j.ne@posteo.net>

The Orange Pi Zero Plus 2 has the same pinout[1] as the Orange Pi
Zero[2] (with the possible exception of line-out left/right being
swapped), and the Orange Pi Zero Interface Board is sold[3] as
compatible with both of them. We can thus use the same audio routing.

[1]: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-Zero-Plus-2.html
[2]: https://linux-sunxi.org/Xunlong_Orange_Pi_Zero#Expansion_Port
[3]: https://orangepi.com/index.php?route=product/product&product_id=871

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---

v2:
- new patch
---
 .../boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts    | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
index 7a6444a10e2534458b7380882ea4fd42bd54fea8..97a3565ac7a819be6b18d324fa6f65d0d1d2b2ad 100644
--- a/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
+++ b/arch/arm/boot/dts/allwinner/sun8i-h3-orangepi-zero-plus2.dts
@@ -99,6 +99,20 @@ wifi_pwrseq: pwrseq {
 	};
 };
 
+/*
+ * Audio input/output is exposed on the 13-pin header and can't be used for
+ * anything else. However, adapter boards may use different audio routing.
+ * - http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-Zero-Plus-2.html
+ * - Allwinner H3 Datasheet, section 3.1. Pin Characteristics
+ */
+&codec {
+	allwinner,audio-routing =
+		"Line Out", "LINEOUT",
+		"MIC1", "Mic",
+		"Mic",  "MBIAS";
+	status = "disabled";
+};
+
 &de {
 	status = "okay";
 };

-- 
2.48.0.rc1.219.gb6b6757d772



