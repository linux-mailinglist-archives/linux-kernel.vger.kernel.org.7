Return-Path: <linux-kernel+bounces-792457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94102B3C428
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9A05A3FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C2234574A;
	Fri, 29 Aug 2025 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1XC+i7J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF3027CCE2;
	Fri, 29 Aug 2025 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756502017; cv=none; b=KOWd/4TRGFVT8nHHdneEHvO+3Sjgd3rvW4r9JkDBzgDvZOgpK07DjkgWhmiLsm6HU9wUWsW3s8VU8YDtR+SA3CMd9Elx56t9mRnvY3QB35uv5pCyHLqtsHEpkSqyBIRRIeB6FDzk/T3EXJwYVF4A5uOhA12mXDMVYxO2iKdM+UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756502017; c=relaxed/simple;
	bh=sbyw8T8JAdvdlkAq4zux1rD5z1Wak6PP9egfwjKNvFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=unpK1nBO9nd/iGewfgnQAj+9CMYXZYGBUjwQpqeBiLYG3Nz8RKJ+GHtomVqWc71D6fH/z02bLTJwop/F1jfhCwpl8LLVfCp07fIkiZ1vbBOcvddx7uYqVme8g/IXFUeLTtIZCVaTU+9SBFne7iRD3U2S0mc2dgaJzmkz/ly5fI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1XC+i7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9429BC4CEF0;
	Fri, 29 Aug 2025 21:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756502017;
	bh=sbyw8T8JAdvdlkAq4zux1rD5z1Wak6PP9egfwjKNvFI=;
	h=From:To:Cc:Subject:Date:From;
	b=t1XC+i7JMTzBN6/YM6iXaXxS7ND02N38fa8g3j1r5h082lgjCMsr2HzDxexxBeJOm
	 jmMTeZcSldK/7MG4RwWhIiSweMqSNzncUGPerbH/X7m/kSwZNvPjtWs//EJG0oSdKX
	 rJ8p4XB3nx6rcRPvFH8Tf/AYy35sc7kE9cGob1NbMXN33Dl7O8eWgU9DTU9lFdwG5o
	 WCvmH7SowZYmgHQ6wk5CfvZmi6BZxJr/W1opkRFMeE3r22eiLsEkrUnM8tEp0Iut5V
	 ePbHt7lQzyusXkqHnfxgb0gXRKnffyBgWCTptVBtK4JBXQCwTFwzTShkA7pEzlUjGc
	 +KxTU45ry+h+A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: Drop syscon "reg-io-width" properties
Date: Fri, 29 Aug 2025 16:13:29 -0500
Message-ID: <20250829211330.1336274-1-robh@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default width is 4 bytes for "syscon" devices, so "reg-io-width" is
redundant and can be dropped.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 1 -
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 2 --
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 2 --
 3 files changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
index 78c967812492..c3d4d916c69b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
@@ -356,7 +356,6 @@ vuart: serial@1e787000 {
 			lpc: lpc@1e789000 {
 				compatible = "aspeed,ast2400-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-				reg-io-width = <4>;
 
 				#address-cells = <1>;
 				#size-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 57a699a7c149..39500bdb4747 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -273,7 +273,6 @@ hace: crypto@1e6e3000 {
 			gfx: display@1e6e6000 {
 				compatible = "aspeed,ast2500-gfx", "syscon";
 				reg = <0x1e6e6000 0x1000>;
-				reg-io-width = <4>;
 				clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
 				resets = <&syscon ASPEED_RESET_CRT1>;
 				syscon = <&syscon>;
@@ -441,7 +440,6 @@ vuart: serial@1e787000 {
 			lpc: lpc@1e789000 {
 				compatible = "aspeed,ast2500-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-				reg-io-width = <4>;
 
 				#address-cells = <1>;
 				#size-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 61983feb2a4e..f8662c8ac089 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -382,7 +382,6 @@ rng: hwrng@1e6e2524 {
 			gfx: display@1e6e6000 {
 				compatible = "aspeed,ast2600-gfx", "syscon";
 				reg = <0x1e6e6000 0x1000>;
-				reg-io-width = <4>;
 				clocks = <&syscon ASPEED_CLK_GATE_D1CLK>;
 				resets = <&syscon ASPEED_RESET_GRAPHICS>;
 				syscon = <&syscon>;
@@ -572,7 +571,6 @@ peci0: peci-controller@1e78b000 {
 			lpc: lpc@1e789000 {
 				compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
-				reg-io-width = <4>;
 
 				#address-cells = <1>;
 				#size-cells = <1>;
-- 
2.50.1


