Return-Path: <linux-kernel+bounces-783039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5083EB3289A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5435C77C6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FEC279798;
	Sat, 23 Aug 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7/iZwHO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A240C277C90;
	Sat, 23 Aug 2025 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953034; cv=none; b=DMLdvzT2+JCKur2wKmF1fPxP8PK/LR8ZOSLFycM4p4ooyDeLm/HT5iV2Vl3OA/DcscNNkmaGOekAE/OeH6HxJr92dyER6sWw7qrgGUQRqmv5wlzffg/O8S4szDHpyc4m/W5OWT8+q4Foj1odpSDyx3Ia3XDnmmBe6YvSmRwc5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953034; c=relaxed/simple;
	bh=VQ1GUY2EiTPu4SjJoDzd70Xf1RpVnGqds8+QtYq8Q9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YD2n/okUo0dGzyMsL23ypYMZax6mbI1otmoyDJbgNUVN1FUmqObnwXpuP01gzkUumAnXQYFDDxA9rEhNXFTkVAxeAUMP7d8bMhnhQHmR63oxjkt6hzu/X2/hsEOXjQtrgcD/atgwIOi3HwYElpnLTAnJgRC4fdsH3JoDqEs2Zyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7/iZwHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4745EC4FDFB;
	Sat, 23 Aug 2025 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755953034;
	bh=VQ1GUY2EiTPu4SjJoDzd70Xf1RpVnGqds8+QtYq8Q9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p7/iZwHO+4c0Qb0P+5QUQ5TA0wgDTP6G2rce5VQdCw/C9BTLr8MbCQv3VmGD2OT7F
	 eF2WVrgS4taBP2KxAdbbDmHT5APfPx8+llqBe2tsMpld+j/MDpTDNLl2ntMFpHbRuY
	 XbTkIZUpFDFYRxDrT5uVoHkV8qsn8k0dX1nF01g+HqAjHxeNdmd9jQhTDy5bT+GkwW
	 GCLtSyOLSFKjrkeY92RkCrXVofhX+14xoRoru6JKw2CIZpK9GeVrZXQax/z/FXl64S
	 goXmyALOWC87O78hJKMIzwGiTSHZ7aQrmy6Av/DX7TbxWtE+7lD1tSEobVKonOP8oy
	 1axpz28O0lhXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB2ACA0EFA;
	Sat, 23 Aug 2025 12:43:54 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maud_spierings.hotmail.com@kernel.org>
Date: Sat, 23 Aug 2025 14:43:51 +0200
Subject: [PATCH 2/3] arm64: dts: rockchip: Enable HDMI receiver on orangepi
 5 plus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-orangepi5-v1-2-ae77dd0e06d7@hotmail.com>
References: <20250823-orangepi5-v1-0-ae77dd0e06d7@hotmail.com>
In-Reply-To: <20250823-orangepi5-v1-0-ae77dd0e06d7@hotmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Ondrej Jirman <megi@xff.cz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Maud Spierings <maud_spierings@hotmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755953033; l=1303;
 i=maud_spierings@hotmail.com; s=20241110; h=from:subject:message-id;
 bh=cqF8f43yoVXcmOBW/qzowTAQoqelusXMIpBTqWyFkKQ=;
 b=e5rk5j157Pc110tlG1qPb/JIPQGiDbO9A+GNioTHi5dwaS+OTK54zQBnVy9QTWCrJJXChDbbE
 zB+wprfpaOrDegEQmj7y2Tx7xMASdUtj1wQKs+BD9xCTVGonas1o07P
X-Developer-Key: i=maud_spierings@hotmail.com; a=ed25519;
 pk=CeFKVnZvRfX2QjB1DpdiAe2N+MEjwLEB9Yhx/OAcxRc=
X-Endpoint-Received: by B4 Relay for maud_spierings@hotmail.com/20241110
 with auth_id=273
X-Original-From: Maud Spierings <maud_spierings@hotmail.com>
Reply-To: maud_spierings@hotmail.com

From: Maud Spierings <maud_spierings@hotmail.com>

Enable support for the HDMI input port found on the orangepi 5 plus.

Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index 8222f1fae8fadc5cbb4ef16b3db5ed975ed43915..9950d1147e129dc866cfde62ddd636b082ae1926 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -160,6 +160,17 @@ &hdmi1_sound {
 	status = "okay";
 };
 
+&hdmi_receiver_cma {
+	status = "okay";
+};
+
+&hdmi_receiver {
+	hpd-gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&hdmim1_rx_cec &hdmim1_rx_hpdin &hdmim1_rx_scl &hdmim1_rx_sda &hdmirx_hpd>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &hdptxphy0 {
 	status = "okay";
 };
@@ -279,6 +290,12 @@ blue_led_pin: blue-led {
 		};
 	};
 
+	hdmirx {
+		hdmirx_hpd: hdmirx-5v-detection {
+			rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	ir-receiver {
 		ir_receiver_pin: ir-receiver-pin {
 			rockchip,pins = <4 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;

-- 
2.50.1



