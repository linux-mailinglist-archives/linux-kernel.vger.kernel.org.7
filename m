Return-Path: <linux-kernel+bounces-815143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0409B5603D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A332166EA4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CFC2EBBA1;
	Sat, 13 Sep 2025 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuyQHpjT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5EB221F06;
	Sat, 13 Sep 2025 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757759101; cv=none; b=PhTlLuFOw54zlp1XXVdi2St1nlNkYUxabMIIYbi9vOusw7M2K4CLhfaouA34SBWKVFEbXpW1kweO85rizO7irAKBY0nvHgxn1gwmSHm5Nea5s8O6hmF/TEHz3VwbTt4XV14yXsZySo8JjOxhGuX6J0+wezxNCcQncIt4WKIfVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757759101; c=relaxed/simple;
	bh=9RmNGj7Z6j23AVn/GaYxlJV8TZ+lS7l5OuBjWd83A1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CdXzHCbJOZDfsjk9LbyP4u2soi9g5++69ZAFneYBgbN7C1ul8EdCngFdGOTeEKJXmorB2QkwhnV8uXas1EUa0emzMTD9ojYDRWyKC1TRKPvcV1hNkAw7uX7iIN6L06vxoRk5dKl1BJyFZyYSzPJUGBenAXaEuniH8yUFkII3r9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuyQHpjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E38C4CEEB;
	Sat, 13 Sep 2025 10:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757759101;
	bh=9RmNGj7Z6j23AVn/GaYxlJV8TZ+lS7l5OuBjWd83A1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KuyQHpjTCUOj0kl9bp7+z5S4WUK9QXtWV7aVEwTQDI8yFzgKvJo1ZSlCt+LtreOVb
	 FrwFZB9anGfujIdemPpT++KG9bMBpeZ7i50Z3RCAAq3vpo7cRjwRWI9GqGLW3Cms4J
	 GehctK5/bjygz/ce9u4XUekW2OaZg6UK6m4bfBW9wwKU6HzLu40h9rec8sF8ZuvQPf
	 2f8k/Cut+U9KPhA7hTZb5iiYJxfXKzbMrOviM2z4gadShg8cnXCk0tTdMKOuDYOCY+
	 bJXeolz6R/WsykGm6lJJsrliU8KszK5l9kPq/0Rh95VZmH/5cF3K3S/IOCOZEvQxIS
	 zoIFFHXDxepgQ==
Received: by wens.tw (Postfix, from userid 1000)
	id B173B5F752; Sat, 13 Sep 2025 18:24:58 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: allwinner: t527: avaota-a1: hook up external 32k crystal
Date: Sat, 13 Sep 2025 18:24:49 +0800
Message-Id: <20250913102450.3935943-2-wens@kernel.org>
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

Fixes: dbe54efa32af ("arm64: dts: allwinner: a523: add Avaota-A1 router support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index 535387912d9b..054d0357c139 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -354,6 +354,14 @@ &r_pio {
 	vcc-pm-supply = <&reg_aldo3>;
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


