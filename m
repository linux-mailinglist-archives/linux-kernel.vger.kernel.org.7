Return-Path: <linux-kernel+bounces-866713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ACAC007CE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D40619C7E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196362FC877;
	Thu, 23 Oct 2025 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtZzY7+K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E09723536C;
	Thu, 23 Oct 2025 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215249; cv=none; b=f1q0VNesSff2aNkN7JJHPKL1vs2QMrYVkyjnFFr5RjiLfSlYU6n9jqPOFwowj3GC+9gi0OfL8jdoBU+EfXCcOL0yWaj3qhuXWR1yUcDxvQV+LutOZE/UnJP2IcbTTlwYd5Mb2WfluKjrUZ2Zj7Oyx0TuJL9umDW5oj3c7mXPoeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215249; c=relaxed/simple;
	bh=9moM1zvWggM59ECkKTAgJYY6tGFpdNeypAAeKDaTrsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZUdQgjpt4x6KvBHmoExqK2rMhTF50QyLxjiszzWFGcEUB611EMkfzr4W8CutpdmshgfD78LFvUSIecTTUO/w2ek+DIlFzEdZBlgfxdpjA386gsbYUYNSsZhNVeTaJYmlEo2LuB9osZC2l6IQCRxHx1GSp4SPPeyy+cXh+EKQEZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtZzY7+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5F0BC4CEFB;
	Thu, 23 Oct 2025 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761215248;
	bh=9moM1zvWggM59ECkKTAgJYY6tGFpdNeypAAeKDaTrsc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=KtZzY7+KK5fh0BsjWRQXOLlZcL8+4/Wrjg8izY1b9HxLlZtAtlFMrx2GPoFESdEgh
	 ETw77KIaAUcLP1EqRIK5RGJuBUxJOwoHFTEhlzFj+E4UJYILRJiGsQsqh5Grt24xH+
	 L8Qzrjx1SDCoHVqUWTc8WMU+dCPdS7nULcZoIHPbpYI6U1vJaw2Tw4V1mEqoUaKt42
	 tXGDcoDYlBF3HriqpoZEpQbqP97SNUYpHUv1YUn6tzH3Jexv4G9rTOCz8MUbplUqY9
	 kXSujti/0bFNyxLk3m5QlGnLr4W7mVB+a2Zze+Qx1guUCQE1srfgcIUdAK/Ebg1M4F
	 GGhnds9rbNdrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BF8CCD1BE;
	Thu, 23 Oct 2025 10:27:28 +0000 (UTC)
From: Alex Wang via B4 Relay <devnull+alex.ts.wang.fii-foxconn.com@kernel.org>
Date: Thu, 23 Oct 2025 18:26:56 +0800
Subject: [PATCH] dt: aspeed: clemente: move hdd_led to its own gpio-leds
 group
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-leo-dts-add-shunt-resistor-v1-1-5d9980aba308@fii-foxconn.com>
X-B4-Tracking: v=1; b=H4sIAO8C+mgC/x3MQQqEMAxA0atI1gZqpYN4FXFRTEYDQytJFUG8u
 2WWDz7/BmMVNhibG5RPMcmpomsbWLaYVkahavDOh875Hn+ckYphJELbjlRQ2cRKVvRDLdwnBoo
 MdbArf+X6z6f5eV6VPZlpbAAAAA==
X-Change-ID: 20251023-leo-dts-add-shunt-resistor-2810206a5dae
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, Alex Wang <alex.ts.wang@fii-foxconn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761215247; l=1426;
 i=alex.ts.wang@fii-foxconn.com; s=20251023; h=from:subject:message-id;
 bh=nhjdaQhGONa6qRe6C17O9kT3BPIniN47qBnafl7NHt8=;
 b=un87bQXpomsn/0FLsOCFLiEpZ+BJAggKp/q9MiS5J3KjRJmifLf7SQcSV3kCAhfv3Qyd3/5/9
 gX5dDcKJ9s/AEHQk5fY+7RY7xwxkO6/DDYnjudaSMejQr96SpfDXuRx
X-Developer-Key: i=alex.ts.wang@fii-foxconn.com; a=ed25519;
 pk=m/IrKXb14uSdDm4KGXemjNIxgL6TrqXCc9NX09SUJp0=
X-Endpoint-Received: by B4 Relay for alex.ts.wang@fii-foxconn.com/20251023
 with auth_id=551
X-Original-From: Alex Wang <alex.ts.wang@fii-foxconn.com>
Reply-To: alex.ts.wang@fii-foxconn.com

From: Alex Wang <alex.ts.wang@fii-foxconn.com>

The gpio-leds driver requires all GPIOs in a group to be available;
if any GPIO in the group is missing the whole group will not be
created. The hdd_led GPIO is only present after standby power is
enabled, which can prevent other LEDs in the same group from being
created and blocks properly setting 'bmc_ready_noled'.

Move the 'hdd_led' node into a separate gpio-leds group so that other
LEDs are not blocked and the 'bmc_ready_noled' flag can be set
correctly.

Signed-off-by: Alex Wang <alex.ts.wang@fii-foxconn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index 450446913e36..c58922695f46 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -96,7 +96,12 @@ led-3 {
 			gpios = <&gpio0 ASPEED_GPIO(P, 5) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
 		};
 
-		led-hdd {
+	};
+
+	hdd-leds {
+		compatible = "gpio-leds";
+
+		led-0 {
 			label = "hdd_led";
 			gpios = <&io_expander13 1 GPIO_ACTIVE_LOW>;
 		};

---
base-commit: b5dd162282164dc202541ce6551cf705d345820e
change-id: 20251023-leo-dts-add-shunt-resistor-2810206a5dae

Best regards,
-- 
Alex Wang <alex.ts.wang@fii-foxconn.com>



