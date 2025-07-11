Return-Path: <linux-kernel+bounces-727746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A78E0B01F07
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2ED3760E65
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388DE2E54B8;
	Fri, 11 Jul 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="Lg5ijLxO"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78D72DCF6C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752243721; cv=none; b=mYq52/WG7NprrIg8lhZ+AJ566hRqoAarfGQi5duYgzbaPhOIcoi4rAwOkh4HW6R4mj6j6WG5RhsyewsrFrkKLxXc3RMqYXLg67ka5zt4be4muv1DY3/3iOgHvBytgrH0mn6nGvxDKqTonDFGVhVkhsC9sA8Dhtk03bqKcu3Uk3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752243721; c=relaxed/simple;
	bh=kqTyx3YtUrbH3F2LDtcHzUbTPg5QBCZ0+M7V2AskFmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4L0k2p2eqPTkTuRY4TpSDfw8M3+h4Q4ryhMqxgoQ7UUGvK5/AMYYdE1nayRcrAFJ+QHPziZIUFsSsvmvG1Y5TAOylt9iUzBRXEpBlC/g/g2aaIVO21hT/AQal911JhUZ37wjUbIRxr+dgKfC2I/6J+JJzLgcBMVygSgIC/wHUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=Lg5ijLxO; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1752243715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dhtbCU3GSz2mEXV2JGmRz2FQjficBt4XaAng4rRz9xo=;
	b=Lg5ijLxO5CRdonuTMfVh2iFNTsNoo2FIm5duJWI8gUfMuR2Bqp0Ouoql8t8y8woakXJqf6
	J1nUXUX/uEN47Dn/ddcfqA1zfk/F8U6dPoCltAT9zwjL86Iv0q4nJAG0xdcOMw52fwzcWF
	gZOugybV2W0FrVZbF35XoUoWeG9Du6Fl8y3aPoMnVlPQK2t5B/y9EQqkK2IkToQoTUQqqZ
	wtbLxp/eiSnvAJ6i02TlLOjtVu3CRZrkwGL2TfBYcT8nRDWFbfddTefKRjDs26GK4wRUOF
	c8mnidSdNzSl9ti5K23O3vOZMZy0YFuY2YPTqNQbeKkctXD1RhKNuDMizKBINw==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH v2] arm64: dts: rockchip: Add reset button to NanoPi R5S
Date: Fri, 11 Jul 2025 16:20:37 +0200
Message-ID: <20250711142138.197445-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The NanoPi R5S LTS version has a reset button, which is connected via
GPIO. Note that the non-LTS version does not have the reset button and
therefore on page 19 of the schematic version 2204 it is marked 'NC',
but it is connected on the LTS version.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
Changes in v2:
- add 'pin' suffix to pinctrl nodes names/labels

 .../boot/dts/rockchip/rk3568-nanopi-r5s.dts   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
index 3b31f0dd8f3b..c12bd01e2805 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
@@ -17,6 +17,19 @@ aliases {
 		ethernet0 = &gmac0;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&gpio4_a0_k1_pin>;
+		pinctrl-names = "default";
+
+		button-reset {
+			debounce-interval = <50>;
+			gpios = <&gpio4 RK_PA0 GPIO_ACTIVE_LOW>;
+			label = "RESET";
+			linux,code = <KEY_RESTART>;
+		};
+	};
+
 	gpio-leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -127,6 +140,12 @@ eth_phy0_reset_pin: eth-phy0-reset-pin {
 		};
 	};
 
+	gpio-keys {
+		gpio4_a0_k1_pin: gpio4-a0-k1-pin {
+			rockchip,pins = <4 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	gpio-leds {
 		lan1_led_pin: lan1-led-pin {
 			rockchip,pins = <3 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.50.0


