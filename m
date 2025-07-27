Return-Path: <linux-kernel+bounces-747115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA343B12FF2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13032175327
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 14:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B8D21B1BC;
	Sun, 27 Jul 2025 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="tDrLTID3"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59561DB13A
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753627470; cv=none; b=jEYbz9QgAMO99bPgOIFXuLuLTRx5Dxg7mBhd1sgMPkq1Ycszj+OJ4/C9KUs83is1Hixfq9em88Yj+tfUffENv+MGQN5ohlm7rHurYZxh1YINN38Ib87g5eZ2FbdlMt8R66mqkI1i4NA1rboxd+9PMZZMeHaH2gz5SvCo94a/QqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753627470; c=relaxed/simple;
	bh=rxB4wwmTm9qP+EMFaQl40OrhmxbUhexlUXKracSsIvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqjkwbwsCcDoSq9TNwhmuEfByFPik/e4nFdOTbNKo2T1J8pNckfPeFruhHpr6ql9GsKWiwt4hSL/DJqEoKmntKNZlI5q1NLIP1eg9+UJUJwfFB3jYHWkkGzdaeKHLUvaCkaXcZM/1JsmAhMZhnLcpajn1fftQoYDyCwHHVL8xCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=tDrLTID3; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753627462; bh=3ETGr9nGI2JrVhT/rXZdTDhtjuBKP4m13iSkZEx+nqA=;
 b=tDrLTID3o2FTuhtEQ/otmm53YgIPq6gL/pYVY9ViOVe6wbs6FkVtJKcYuOaDdc5kGW9MQ44zj
 MfjXzTwE4VBUE9ukwUK9QzhBTiguBv4GwJ9nNhBAvfnQZyWnbuhq1uifwkrr+VHKCxVQbFZYTSP
 p4e/Otc4ER0uAV8eMOPf+pB4GYunQ9MTtC2zmYo9f39Bs/VH0iFUhtqhONYP5B3FL/T8Gws3gt7
 cVUsy+HRSlRvt6AVToseur9fcy7RzkdpfXZvzMsHIloTacgwSWuoNtuxiW49LHnrB6Y6Ii212Lf
 7O5QKcGoTHYwwJPOLai9OAXu/yKJoAGU34Ch84ewL7Lw==
X-Forward-Email-ID: 68863b43c752737c6c097874
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.7
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/3] arm64: dts: rockchip: Add SFC node for RK3528
Date: Sun, 27 Jul 2025 14:44:01 +0000
Message-ID: <20250727144409.327740-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250727144409.327740-1-jonas@kwiboo.se>
References: <20250727144409.327740-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Flexible Serial Flash Interface (FSPI) controller in Rockchip RK3528
is similar to the one included in e.g. RK3568 and RK3588.

Add device tree node for the Flexible Serial Flash Interface (FSPI)
controller in RK3528.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm64/boot/dts/rockchip/rk3528.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
index 3e51a3f51e05..49886a4b58f1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
@@ -1077,6 +1077,18 @@ sdhci: mmc@ffbf0000 {
 			status = "disabled";
 		};
 
+		sfc: spi@ffc00000 {
+			compatible = "rockchip,sfc";
+			reg = <0x0 0xffc00000 0x0 0x4000>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru SCLK_SFC>, <&cru HCLK_SFC>;
+			clock-names = "clk_sfc", "hclk_sfc";
+			power-domains = <&power RK3528_PD_VPU>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		sdio0: mmc@ffc10000 {
 			compatible = "rockchip,rk3528-dw-mshc",
 				     "rockchip,rk3288-dw-mshc";
-- 
2.50.1


