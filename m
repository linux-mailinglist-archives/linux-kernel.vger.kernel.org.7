Return-Path: <linux-kernel+bounces-698993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E395AE4C88
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 20:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591333BDDAE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 18:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563392D878B;
	Mon, 23 Jun 2025 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l4i87764"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B992D5C81
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702153; cv=none; b=SQso0PbRQZdK4qCE38Is3gTqm22P4yY/TLFTnIHL4kfvFHOz7g8sHg81hAqPpHQoQopxDEoUF9rmheGyxXt0P0XBEPUNSWtekNlZg6eOlv8cPMdCM89+PNFgfElZyEGNjtvPVqNAc54JtXNOYdTEU6c1NCIKTbhYQkQI9e9C3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702153; c=relaxed/simple;
	bh=pQpdhYmfxqh3Yfxmei5sPv11PaCzGkgZVRufLVaDNj8=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=EGabdtuSJRosDXbc/t2tmXmq5d5eVBDB9E/wg/r8tmQs5JUVoG8QEPLRAQFcKh7qjmagpBKT1tWahFNbVfcAIdsW2K5t/TX/DMU0AXYoqjI4RqcKqrBSo0DXpvpUS7GEYe87tzBJlwyYhGwOWaJThs0IEJKgSjFs4kyfEpuN3mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=l4i87764; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250623180909euoutp01d4def5fd6d0155fe17b38a99373ae836~LvlRltErd0365003650euoutp01D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 18:09:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250623180909euoutp01d4def5fd6d0155fe17b38a99373ae836~LvlRltErd0365003650euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750702149;
	bh=Thc/4MnT4r5I8ag38cbivyQhpbuX345C1nEB0lzCSSU=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=l4i87764c4t/HnfCZ+5UFqdEXrcuyOHrgrER0xN/t/TVnHg4hlvR9qO570ZnZVc/L
	 kvcuvLqzLNdTL2k6/aby4ydB5Ov+RPGcXiu5/em1DLzZR5NEtQSjidLcpUUo8Yx3tA
	 y0pRn2r81/6FZWiAguXjBeicofEge1/Q4QfiGz84=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250623180908eucas1p1a3494bba009ff1d7b7d5d59f915e9927~LvlQeI11R2898428984eucas1p1Y;
	Mon, 23 Jun 2025 18:09:08 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250623180907eusmtip10853b0d9e99b673eabdf4475ccf85ae0~LvlPWboOD3150531505eusmtip1z;
	Mon, 23 Jun 2025 18:09:07 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Mon, 23 Jun 2025 20:08:57 +0200
Subject: [PATCH v5 9/9] riscv: dts: thead: Add PWM fan and thermal control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-rust-next-pwm-working-fan-for-sending-v5-9-0ca23747c23e@samsung.com>
In-Reply-To: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,  Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <drew@pdp7.com>,  Guo
	Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,  Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
	<conor+dt@kernel.org>,  Paul Walmsley <paul.walmsley@sifive.com>,  Palmer
	Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,  Alexandre
	Ghiti <alex@ghiti.fr>,  Marek Szyprowski <m.szyprowski@samsung.com>,  Benno
	Lossin <lossin@kernel.org>,  Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250623180908eucas1p1a3494bba009ff1d7b7d5d59f915e9927
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250623180908eucas1p1a3494bba009ff1d7b7d5d59f915e9927
X-EPHeader: CA
X-CMS-RootMailID: 20250623180908eucas1p1a3494bba009ff1d7b7d5d59f915e9927
References: <20250623-rust-next-pwm-working-fan-for-sending-v5-0-0ca23747c23e@samsung.com>
	<CGME20250623180908eucas1p1a3494bba009ff1d7b7d5d59f915e9927@eucas1p1.samsung.com>

Add Device Tree nodes to enable a PWM controlled fan and it's associated
thermal management for the Lichee Pi 4A board.

This enables temperature-controlled active cooling for the Lichee Pi 4A
board based on SoC temperature.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts | 67 +++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
index 4020c727f09e8e2286fdc7fecd79dbd8eba69556..c58c2085ca92a3234f1350500cedae4157f0c35f 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
@@ -28,9 +28,76 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay = <1000>;
+			polling-delay-passive = <1000>;
+			thermal-sensors = <&pvt 0>;
+
+			trips {
+				fan_config0: fan-trip0 {
+					temperature = <39000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				fan_config1: fan-trip1 {
+					temperature = <50000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				fan_config2: fan-trip2 {
+					temperature = <60000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+			};
+
+			cooling-maps {
+				map-active-0 {
+					cooling-device = <&fan 1 1>;
+					trip = <&fan_config0>;
+				};
+
+				map-active-1 {
+					cooling-device = <&fan 2 2>;
+					trip = <&fan_config1>;
+				};
+
+				map-active-2 {
+					cooling-device = <&fan 3 3>;
+					trip = <&fan_config2>;
+				};
+			};
+		};
+	};
+
+	fan: pwm-fan {
+		pinctrl-names = "default";
+		pinctrl-0 = <&fan_pins>;
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		pwms = <&pwm 1 10000000 0>;
+		cooling-levels = <0 66 196 255>;
+	};
+
 };
 
 &padctrl0_apsys {
+	fan_pins: fan-0 {
+		pwm1-pins {
+			pins = "GPIO3_3"; /* PWM1 */
+			function = "pwm";
+			bias-disable;
+			drive-strength = <25>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
 	uart0_pins: uart0-0 {
 		tx-pins {
 			pins = "UART0_TXD";

-- 
2.34.1


