Return-Path: <linux-kernel+bounces-881184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4C3C27A8B
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F8DE4E4778
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59D22BE650;
	Sat,  1 Nov 2025 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lu9GOlqP"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED98723AE9A
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761987857; cv=none; b=Geh85HsW3PNdWQQMtsQgJ0961KphyIGPWMC2mDPECzW1uAJ1T64r9jI3Vatm3Hr/RwQU5EBGTyE8IflapXlyi1R5Wz8+vr2Hw/eMYBjiqw+FsCusisJhWm1SHt+f6fUPtGM/3GjBkYMoKyjqskmGdk3f6HXsd3XUbA8rNbtWKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761987857; c=relaxed/simple;
	bh=d303GJdP3RFLY+pATJhr/H7FKmjHD6dDsiJZY3bUP94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gKgd7Emley5CoSmY8SrFncEkXdfmwNCCvmMlRq1ArGV3w0AtOVx75z89SX/JT5wdFalalg9SZ41krCB4oyRjY8UFQUgRgnIx5rs+MQe9c0o2OKqq+UqzrxXF0Ms8837l+02fO421G6w7SBflrbORqZNxsIIZqwpOp9pn47zA3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lu9GOlqP; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761987853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkHzUy7kWIFbe9fiN7GijSrGSeSfQnU7pR3fbcrTN3Q=;
	b=lu9GOlqPBQzBWJbcG2tonlAj0AS/5leITLacAUTIfQn3dEqjBc8fyor8LNfJbr+3POOxk6
	C48id8aJY/HCv6jtpxh1WJr9CPLfZCzfLoMiTtrOF78EhP4fcdXyHdadRiJJchW8VdWett
	2mTNbKYKd1vGPwReqbvAbI3+lzBj3aE=
From: Ze Huang <huang.ze@linux.dev>
Date: Sat, 01 Nov 2025 17:03:27 +0800
Subject: [PATCH 3/3] riscv: dts: spacemit: Enable USB3.0 on BananaPi-F3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-k1-usb3dts-v1-3-dd2660e5740b@linux.dev>
References: <20251101-k1-usb3dts-v1-0-dd2660e5740b@linux.dev>
In-Reply-To: <20251101-k1-usb3dts-v1-0-dd2660e5740b@linux.dev>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Ze Huang <huang.ze@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761987811; l=2076;
 i=huang.ze@linux.dev; s=20250705; h=from:subject:message-id;
 bh=d303GJdP3RFLY+pATJhr/H7FKmjHD6dDsiJZY3bUP94=;
 b=VFRENH/Ogtq/hy2xA8HZYruIT7VtqjnWGTznxmuPT5OGizcVa1ougYQwSZ9u5+nMhgFTh9gG2
 xOBwKXcN1E8Cy6Q/wbEYK4GKaSNphpT/lpoOnoDUp/V2erfx+1KpoLB
X-Developer-Key: i=huang.ze@linux.dev; a=ed25519;
 pk=Kzc4PMu5PTo8eZZQ5xmTNL9jeXcQ9Wml0cs+vlQpBkg=
X-Migadu-Flow: FLOW_OUT

Enable the DWC3 USB 3.0 controller and its associated usbphy2 on the
Banana Pi F3 board.

The board utilizes a VLI VL817 hub, which requires two separate power
supplies: one VBUS and one for hub itself. Add two GPIO-controlled
fixed-regulators to manage this.

Signed-off-by: Ze Huang <huang.ze@linux.dev>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 47 +++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 6d566780aed9..4b67f44c7863 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -38,6 +38,25 @@ pcie_vcc_3v3: pcie-vcc3v3 {
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	usb3_vbus: regulator-vbus-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "USB30_VBUS";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		gpio = <&gpio K1_GPIO(97) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usb3_vhub: regulator-vhub-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "USB30_VHUB";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio K1_GPIO(123) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &combo_phy {
@@ -135,3 +154,31 @@ &uart0 {
 	pinctrl-0 = <&uart0_2_cfg>;
 	status = "okay";
 };
+
+&usbphy2 {
+	status = "okay";
+};
+
+&usb_dwc3 {
+	dr_mode = "host";
+	vbus-supply = <&usb3_vbus>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	hub_2_0: hub@1 {
+		compatible = "usb2109,2817";
+		reg = <0x1>;
+		vdd-supply = <&usb3_vhub>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
+	};
+
+	hub_3_0: hub@2 {
+		compatible = "usb2109,817";
+		reg = <0x2>;
+		vdd-supply = <&usb3_vhub>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
+	};
+};

-- 
2.51.2


