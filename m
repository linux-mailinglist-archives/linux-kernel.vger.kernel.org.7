Return-Path: <linux-kernel+bounces-873446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB8EC13F1A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46DA84E8E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEA030597C;
	Tue, 28 Oct 2025 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4JFRL1L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C66303A38;
	Tue, 28 Oct 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645156; cv=none; b=NIcRpL2oGMzFXPiSN92pKG4xEoosva8eFcQiX88Ot9Q/JUcDZd1CZMy7soCvoSmvpF4Ew/7kLXfpJ0UFZIisWRjs+f93M/mYyNnpcD2E3Q1ALUfayAjeojWC3VO16MZT21g0t0MrC+Du3wiP8zBw7SlXi/bc+igh3X+qsfv5Q00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645156; c=relaxed/simple;
	bh=X2LgKGxvc+yiUAPkHyPMwzAGhXvItiDTlNdNw6TQWqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ACzKgDQDH4eQJ4Xt5gqTEoXbJ9H3UXxAcKukQ05kevNvcf66mPof0rziFgD5Br/b/dx17bXEyEGFAGz7BcdIEX5vCANi/R2OVQm3G39KGUn/2MAdZMbpwB1L1+72rQliNsU+bTU0GCLmKaa0S1MCJaYGbGd+b8UHbL+8ChdT/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4JFRL1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC6E1C2BC87;
	Tue, 28 Oct 2025 09:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761645155;
	bh=X2LgKGxvc+yiUAPkHyPMwzAGhXvItiDTlNdNw6TQWqo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t4JFRL1LHezh+pDEOavRzpciy6ukDQRspmubAEvFpihyHageE4WYTV8JKVXzDWVpI
	 wTed7pttMW895m7ygAsnBk5WeVdn3+s4soHmOL33s1kTnMPjTE07D0XofQeGmz9dGX
	 CAL97CfJvWV1tvAEF5njYYhr8qCUw3DJBe35LqG3gcowwcsdPTTqs7dBI5DDoAZVC7
	 8gf850h6XS2M8kpmI2KC8q4yj/JHE6IgEltVTbGgg23smsXjoPSUHv3In2CvGT7/Ob
	 fck8qQQtxS2PVsoTuwL0zMPRDWnbCjiuVDek+Ya5ePJfMg2SpTMdzM5HjbxMEEP5LS
	 fCeGSjWyyKK7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B248CCCF9E0;
	Tue, 28 Oct 2025 09:52:35 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 28 Oct 2025 17:52:33 +0800
Subject: [PATCH v4 7/8] arm64: dts: amlogic: A5: Add PLL controller node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-a5-clk-v4-7-e62ca0aae243@amlogic.com>
References: <20251028-a5-clk-v4-0-e62ca0aae243@amlogic.com>
In-Reply-To: <20251028-a5-clk-v4-0-e62ca0aae243@amlogic.com>
To: Chuan Liu <chuan.liu@amlogic.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761645153; l=1163;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=W8yE0gYMnw2TeYIsOkbQZ2yJTdvcybUThyiQBa5vAa4=;
 b=aEsMXHrLZog7rahKISm0rdVZl/eWN5ue3go4FB7W+uwpAjdcEEr35iq9s+5Qb3lzPijMXPAVv
 RuPggJTaf4gANchCoZf33G9GtybQvpexOciXvyTsMogxEMMOSgA+pQ9
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add PLL controller node for A5 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
index a6625508893d..70deeab220e0 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/pinctrl/amlogic,pinctrl.h>
 #include <dt-bindings/power/amlogic,a5-pwrc.h>
 #include <dt-bindings/clock/amlogic,a5-scmi-clkc.h>
+#include <dt-bindings/clock/amlogic,a5-pll-clkc.h>
 
 / {
 	cpus {
@@ -187,4 +188,16 @@ gpio_intc: interrupt-controller@4080 {
 		amlogic,channel-interrupts =
 			<10 11 12 13 14 15 16 17 18 19 20 21>;
 	};
+
+	clkc_pll: clock-controller@8000 {
+		compatible = "amlogic,a5-pll-clkc";
+		reg = <0x0 0x8000 0x0 0x1a4>;
+		#clock-cells = <1>;
+		clocks = <&xtal>,
+			 <&scmi_clk CLKID_FIXED_PLL_DCO>,
+			 <&scmi_clk CLKID_FIXED_PLL>;
+		clock-names = "xtal",
+			      "fix_dco",
+			      "fix";
+	};
 };

-- 
2.42.0



