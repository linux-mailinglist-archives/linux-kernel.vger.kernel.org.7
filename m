Return-Path: <linux-kernel+bounces-723431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D2BAFE6AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301054E09A6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED28428DF4B;
	Wed,  9 Jul 2025 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="AP+BQZNG"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AF728DB46;
	Wed,  9 Jul 2025 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058649; cv=none; b=Qn3VWjannrHw2och6l7fKCEpTjaobSWs8TLDdJPc20mA+JoKBhjk4VD3Uyz8b9F35PBzrD4CZtG9VlQVcRYI6V7AeBoP30ivNyfF/0lFK7j5yX99wPJuQWKkrmG63mA9DJIqViibBk9lLw8Bpc/Gu8LoWN9v8+D93SGtdZzfjb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058649; c=relaxed/simple;
	bh=WFk4SqbiU9zhI1KnA8UnaBHDZy46PjfwGbFdmWTQUPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aY/a6jxQSDzuLSkWZZ4GGFactnxGlzpldVzrdCBNVrSjMcnzAekxKypKSdTyIiI/HNR894eOenZNFmoGdM50q6TrTrsoJZgiWM0BVNIO4QE1zzGQ7Af+yPo05+l9WEPMxve64QR5RCfnIB1Ck75lP3DEfphIVC5bI6/PmBEh5Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=AP+BQZNG; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1752058643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C6I02oAO5O9n+NqOYPD+dGaxhuaskJQMZV+WpCzJXCs=;
	b=AP+BQZNGoaJmYJygNM/cNI4+L4nhRS9+v7XJ5tpNOmB/nZd++qTbTBwNo/O+1votD3hpuU
	d2fuhHU756K8GgwfWy5GeCU+ivd/FYXqqwRXiEltwXyM1sIBCAstixjodvc8CRFhKokd9C
	D233PemB7tVZu576E/LMMtVGOZwXHMeojtpVXR0Oe95O3l2xINtDlkzqFhZu/ViPAV4tlg
	RoqiV6pYcLWjXPQiU5cgM9aynKpPtCaCZhYcr5KlrnJHgZbK1qqS4OM8w/0SRYQ28ywlrZ
	ZP9psoJFX7TlIMTbxfojeVfvI4+uBHyTdUhs5VXjS3WhmW7noKCQeEJsRKtiEA==
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
Subject: [PATCH] arm64: dts: rockchip: Add reset button to NanoPi R5S
Date: Wed,  9 Jul 2025 12:57:08 +0200
Message-ID: <20250709105715.119771-1-didi.debian@cknow.org>
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
 .../boot/dts/rockchip/rk3568-nanopi-r5s.dts   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
index 3b31f0dd8f3b..4eaedb321914 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5s.dts
@@ -17,6 +17,19 @@ aliases {
 		ethernet0 = &gmac0;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&gpio4_a0_k1>;
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
+		gpio4_a0_k1: gpio4-a0-k1 {
+			rockchip,pins = <4 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	gpio-leds {
 		lan1_led_pin: lan1-led-pin {
 			rockchip,pins = <3 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
-- 
2.50.0


