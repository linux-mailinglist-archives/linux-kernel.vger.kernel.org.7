Return-Path: <linux-kernel+bounces-808929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 488FAB506A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA781C657F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F32135AAC9;
	Tue,  9 Sep 2025 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEpAQBFa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13AC225415;
	Tue,  9 Sep 2025 19:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447906; cv=none; b=cyAc6PyumReXC5Y7xTnEyn4aFx69z3fY6tt7og14FN/Ws69a4MlAKQ0fhC9oe0ZRgdVWzQqjPnHX5TwinXwoZLvmAhT/56mJ+jJTGzzasf9RRyPD8EglOXyVAPH6hYhNI9pCz4jfvU3rH7EKo5fay8tB90VdMNIZTjrh/h0f33I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447906; c=relaxed/simple;
	bh=coVjTOw4sLHDfBakjSlveG2TDtwJq/PpPGElv5zd+KY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GEAo5rTQhoVwFOkyU10LsMxx3r0N63PWwhSCfwBpOFihmyA7bTIH5yVsGMaAtvqz4MOssWsuFNwCfnMMN+kW71FWF8Cu0YSwSmTyMskSnQc3JPLEBZmNUN4rl5kFgDh2S5Mrl5p70UF/CUlEcwdYdkXOk8MYFPP/8hwtlG7uJfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEpAQBFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D6AC4CEF4;
	Tue,  9 Sep 2025 19:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757447905;
	bh=coVjTOw4sLHDfBakjSlveG2TDtwJq/PpPGElv5zd+KY=;
	h=From:To:Cc:Subject:Date:From;
	b=OEpAQBFaCqld1Z/XsKuXeu0kO0sa+Eh9Qoysb/M5+3/BBWMKwbB6dN/6XEyN+Tc7V
	 mCcOr4FjmzLrd5hbcMs8JkBlA0S6hO+cHQ2Q3XHJ2HT4G//LKnXw4gL7gmOT2o5Dpg
	 XIchr89SnWuwewzlGUMjNqsARy7RBFlt4pcD+MDFDX5QkpHXpEtsJhlTBLUswGF9lU
	 DPtgAkIx6bexUGwQtxEucONXZLmk+I/WAn75kVbdnTEl/wol/mn1U6lp/FRYp/mM+G
	 BhAhJkEBkhJasqwGrkLMl5embSN6vDd/s6+27NPTpwiZljwxnHtDlc0EMgmtCw7feV
	 zU0K+hiOdaTwg==
From: Conor Dooley <conor@kernel.org>
To: linux-sunxi@lists.linux.dev
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] riscv: dts: allwinner: rename devterm i2c-gpio node to comply with binding
Date: Tue,  9 Sep 2025 20:58:17 +0100
Message-ID: <20250909-frown-wrinkle-f16df243a970@spud>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=5nDAh3oXDhRSMzBY7Xh2+riGNHudXRKLDRxiREafnqA=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBkH2m4UsH88fsjnefHviMCq9wUFX3/bNdvdm5BXeKxyw 5I75Yn3OkpZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCR1uuMDEe5C7KOJ+xJ4XiU vXnG7Ddz7p/8zshouSTBp3D1VZuEZZEM/9OONv9zyDQr5W6R0cwXudnEXRMhUfl5mors35MzD27 azgAA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The i2c controller binding does not permit permit the node name to
contain "gpio", resulting in two warnings:

i2c-gpio-0 (i2c-gpio): $nodename:0: 'i2c-gpio-0' does not match '^i2c(@.+|-[a-z0-9]+)?$'
i2c-gpio-0 (i2c-gpio): Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'adc@54' were unexpected)

Drop it to satisfy dtbs_check.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Chen-Yu Tsai <wens@csie.org>
CC: Jernej Skrabec <jernej.skrabec@gmail.com>
CC: Samuel Holland <samuel@sholland.org>
CC: devicetree@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-sunxi@lists.linux.dev
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts
index bc5c84f227622..5f2e5cc3e3d55 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-devterm-v3.14.dts
@@ -17,7 +17,7 @@ fan {
 		#cooling-cells = <2>;
 	};
 
-	i2c-gpio-0 {
+	i2c-0 {
 		compatible = "i2c-gpio";
 		sda-gpios = <&pio 3 14 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /* PD14/GPIO44 */
 		scl-gpios = <&pio 3 15 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /* PD15/GPIO45 */
-- 
2.47.2


