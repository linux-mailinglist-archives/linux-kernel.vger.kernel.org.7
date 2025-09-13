Return-Path: <linux-kernel+bounces-815144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E40B56040
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D747AB5B2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BF52EBB9B;
	Sat, 13 Sep 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyj2oI2R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A58521A421;
	Sat, 13 Sep 2025 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757759101; cv=none; b=dNxagTQSmHGKbaoAqu4LQE9trWFc/kjL7EFATbvwIwnIkJDJBmrRhG4EhDd5SPlAruAqYwnMqsp0Uzvjwd6DLX4eTVqFQyi+m2Q+LDiF6XIqHKaP1sb+URtN/wAscgR8OZ2NMYyNJkkTBou6mZDniQ4MN1H/ZoHu4oAHkDP7xrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757759101; c=relaxed/simple;
	bh=7AISgck/ZfKlMuH4s1xfIjU+tBk3KnXivPq4YLbqruY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pu7hBp8bQQx2+BWXytXXD4kLexAZnnYGZnc2uuDA4ei5Ky9jgRYJGe/8n557zZrrAp03iwZzz5vnf3VCue5lQ0GDv6okuTv0SMOc/Sni5aDZQD+RWch1jlrl2djs/RmXm7DGRBvphWz6VDybBSLVEv9mKfwSvEGD3C5Y0zOdisw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyj2oI2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA168C4CEF4;
	Sat, 13 Sep 2025 10:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757759101;
	bh=7AISgck/ZfKlMuH4s1xfIjU+tBk3KnXivPq4YLbqruY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tyj2oI2RMRQskhiT81MTqum2l6GhYqY0PwIRVt4nqfJRTrm3cfoNVuhHJKl17KV3B
	 4iRQvig9nVX+PBxa4lq9SpVAWPSzIwAZHRWHzrbfOXELt/o1uBDgzYAPLXuesKqYQa
	 LF6B8O+C02ZS5EuLrVyhNC4NmzHGVbgd4dZdz53VUiqJzvABTQgZOtmaQZ4m37oPlF
	 pQg969k78J4vJtPSlKvNL3IjKTKh+7uGupXQDJMTNfRschgeQKaTYEwpt9WQB7joQz
	 hNXN7batDHUgvVlZvZS+wxX0tYSqIoQ18SQhW5V7kgNYLOUH9B7wukwGU7AHTHONlw
	 TtM6J9DZrq7dQ==
Received: by wens.tw (Postfix, from userid 1000)
	id BAADB5FE35; Sat, 13 Sep 2025 18:24:58 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: allwinner: t527: orangepi-4a: hook up external 32k crystal
Date: Sat, 13 Sep 2025 18:24:50 +0800
Message-Id: <20250913102450.3935943-3-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250913102450.3935943-1-wens@kernel.org>
References: <20250913102450.3935943-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

When the board was added, its external 32.768 KHz crystal was described
but not hooked up correctly. This meant the device had to fall back to
the SoC's internal oscillator or divide a 32 KHz clock from the main
oscillator, neither of which are accurate for the RTC. As a result the
RTC clock will drift badly.

Hook the crystal up to the RTC block and request the correct clock rate.

Fixes: de713ccb9934 ("arm64: dts: allwinner: t527: Add OrangePi 4A board")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
index fb5311a46c2e..f71860db83d3 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-orangepi-4a.dts
@@ -393,6 +393,14 @@ &r_pio {
 	vcc-pm-supply = <&reg_bldo2>;
 };
 
+&rtc {
+	clocks = <&r_ccu CLK_BUS_R_RTC>, <&osc24M>,
+		 <&r_ccu CLK_R_AHB>, <&ext_osc32k>;
+	clock-names = "bus", "hosc", "ahb", "ext-osc32k";
+	assigned-clocks = <&rtc CLK_OSC32K>;
+	assigned-clock-rates = <32768>;
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.39.5


