Return-Path: <linux-kernel+bounces-744499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9427BB10DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FBF1C81ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DB6277CA2;
	Thu, 24 Jul 2025 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lSMuodqp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA0AA937;
	Thu, 24 Jul 2025 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367497; cv=none; b=gYubV1NgJHkG6DCbuTeVNmpSRlGwv7IPgwpL8a7M5mIs64rZkTH99dYSdsaY6DOGQLuvSYidlU0hBc8/K1HTjY7KpoKVEG7yoPcK/8+iIXbbIp6x+lifyNK+Nu4oBwwj2ERR/VGYAlpa5w1ZKeNY5TThMtso5Ghz5zLJM8cRnTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367497; c=relaxed/simple;
	bh=u9PdAYuALXEVozae3RfJMx3RFx6T5Oe/vgBOyHiZLK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UZwF9V8SuxGpoAC3qE1nvcnwrDtehgsRX3h9z1vREvhnGy7gXRS6PC3G1bgI1SypBJQsAGxWsr+ZqGF+biRTVOvnYCn6g4ezVWI+DvPEAr4xeNgz8yz0t/YLXLCp69/6v9Lf4kfJRbpfSXsiHOpY4pOvqcOdCbZlGBVFYtEe6tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lSMuodqp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753367493;
	bh=u9PdAYuALXEVozae3RfJMx3RFx6T5Oe/vgBOyHiZLK8=;
	h=From:Date:Subject:To:Cc:From;
	b=lSMuodqp7YZ23b38WJ2oV1WBi/fZCKhs4ma5VVLSiqYHgwSS0IYRYWhNg8xEu9vKv
	 nT0U1beQPVNKE2vHcuzK7w63mbpITTrT9m7Isp1RE57o00oCk0yx9uslrBaYeStGYo
	 tmBQSgqbR6UuoQXt3xiQIbALojBr6qlGBmrWH1U1ixxfRqWuo+8tIjqmyPeXKuxUrr
	 ZlriQmuVFgYsImJ5jAA9v11QpPyZvsGDSg5hlaUeWCq5QZQNngzZZO9XFYAClYFVjA
	 RD0uW4jl68BclIwhFNNsRD09gw0p9yySbMl9ND/InXNzt28GWYtiuW/QcBQ7Api17G
	 OsQ7a+70z1xvw==
Received: from jupiter.universe (dyndsl-091-248-210-114.ewe-ip-backbone.de [91.248.210.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C15917E0B72;
	Thu, 24 Jul 2025 16:31:33 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 07205480039; Thu, 24 Jul 2025 16:31:33 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 24 Jul 2025 16:31:25 +0200
Subject: [PATCH] arm64: dts: rockchip: use MAC TX delay for ROCK 4D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-rk3576-rock4d-phy-timings-v1-1-1cdce2b4aca4@kernel.org>
X-B4-Tracking: v=1; b=H4sIALxDgmgC/x3MTQ5AMBBA4avIrE1C1U9cRSzaGkxEyVSEiLtrL
 L/Few8EEqYAbfKA0MmBNx+Rpwm42fiJkIdoUJkqs1pplKUo6wplc4secJ9vPHhlPwWsrCarrWn
 U6CD2u9DI1//u+vf9AMmpQXtrAAAA
X-Change-ID: 20250724-rk3576-rock4d-phy-timings-6b4eb4ba82fc
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2874; i=sre@kernel.org;
 h=from:subject:message-id; bh=u9PdAYuALXEVozae3RfJMx3RFx6T5Oe/vgBOyHiZLK8=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGiCQ8ROUfuRfo4mNRUGEaWZbqk0Wkbt8RBEL
 w3/ULol4z1cW4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJogkPEAAoJENju1/PI
 O/qaMSUP/13LhvhKXd0+OszgpGriuOkZE/79bCvrU1METdH/ofIq1UZMuht+thZw7M2dZejhYhB
 LNgFfxK3ci+Ffmrt+Wl+m3ZG3fZ4itWPPRtmbS2Lpy3XZk9zsjw4TBZmwoELGT2A7RwQFC+iINr
 gJMEHVDY5UlsnyonFSt8qu5Cy0vymNH+FqIDypFTP6uA6EX6PbpF17QqGlfGCrp2TppxBBKL8X1
 sb9AFtoGFfrBUHwxVvCVPepWzOQdrS3CUHZ5oktAIS+eK6wO2fZoxHKPYwcFS+TxaN1RcJnM5kA
 +M4FbuhevnUybNLdvxvoFevajz5bXo9J9PajrIlGnwXI3sPnVUioeymlPI9q7LLOhXAKMMIyVN2
 kPMyjqTTW8Onfp4akskSaC0mNSNBPmvvvxvFjVdyPf7gJOGrEMuuA4ur9xUxObr4eQrtAuwoCBS
 z/GMx1hWtvPnRZxVpeJXU6ZUNSwQYLyxhnZ/42vKgJjD4NQKzNgsTmldR9w5eoJAJmtZmktunQz
 vfcT1zXSPNC3EuraiEKcS3p1RxUwnJlyCbgOiHhYyNBHmGwRCzeF+4toNmA+YfDRY5SWEcgfbel
 OyF07/JiK8f7u31M2BgdHFbqhXdiHMHMEzHBae8QepHDNONnUWn5P1QbyoQAyxNcykXPVBUmjrl
 GewoN3r2NJh5VXpayUnctgQ==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

According to the Ethernet controller device tree binding "rgmii-id"
means, that the PCB does not have extra long lines to add the required
delays. This is indeed the case for the ROCK 4D.

The problem is, that the Rockchip MAC Linux driver interprets the
interface type differently and abuses the information to configure
RX and TX delays in the MAC using (vendor) properties 'rx_delay' and
'tx_delay'.

When Detlev Casanova upstreamed the ROCK 4D device tree, he used the
correct description for the board ("rgmii-id"). This results in no delays
being configured in the MAC. At the same time the PHY will provide
some delays.

This works to some degree, but is not a stable configuration. All five
ROCK 4D production boards, which have recently been added to the Collabora
LAVA lab for CI purposes have trouble with data not getting through
after a connection has been established.

Using the same delay setup as the vendor device tree fixes the
functionality (at the cost of not properly following the DT binding).
As we cannot fix the driver behavior for RK3576 (some other boards
already depend on this), let's update the ROCK 4D DT instead.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
There is an additional problem, that the link does not come up in the
first place. This has been handled by the recently merged (and less
questionable) DT changes [0] combined with a PHY driver patch to trigger
a PHY reset after the clock has been enabled [1] (I will send a new
version of that patch after this one). Stable network support on the
ROCK 4D requires all patches.

[0] https://lore.kernel.org/linux-rockchip/20250704-rk3576-rock4d-phy-handling-fixes-v1-1-1d64130c4139@kernel.org/
[1] https://lore.kernel.org/netdev/20250704-phy-realtek-clock-fix-v1-1-63b33d204537@kernel.org/
---
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
index 0388d72076bf79ee4f20ac1d3bc04fe1859f857b..f105ed675d3671e93916c830a9a17dc240ca5fda 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts
@@ -237,7 +237,7 @@ &cpu_l3 {
 &gmac0 {
 	clock_in_out = "output";
 	phy-handle = <&rgmii_phy0>;
-	phy-mode = "rgmii-id";
+	phy-mode = "rgmii-rxid";
 	pinctrl-names = "default";
 	pinctrl-0 = <&eth0m0_miim
 		     &eth0m0_tx_bus2
@@ -246,6 +246,8 @@ &eth0m0_rgmii_clk
 		     &eth0m0_rgmii_bus
 		     &ethm0_clk0_25m_out>;
 	status = "okay";
+	tx_delay = <0x20>;
+	rx_delay = <0x00>;
 };
 
 &gpu {

---
base-commit: e05818ef75bee755fc56811cb54febf4174d7cf2
change-id: 20250724-rk3576-rock4d-phy-timings-6b4eb4ba82fc

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>


