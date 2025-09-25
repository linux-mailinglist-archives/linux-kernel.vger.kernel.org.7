Return-Path: <linux-kernel+bounces-832117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB43FB9E612
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA617A1F92
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C152ED84A;
	Thu, 25 Sep 2025 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xqWLxhad"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC62EC56C;
	Thu, 25 Sep 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792649; cv=none; b=goZzj8jqV/bRODh7VqP47pjXhL5BIGRpLWl9s8KLQDoaPHAuRJ1xdym0l5uBjcSqzzyS68zfCdUwdF2vXS2JJvCIhK89k7OR8hMEfGX+iCHtm6b8xxdtqJz/mzDMezs9v4d9IVYXTlQX6HNKH85rDWzJSe52YEPdFFZPsYr0zD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792649; c=relaxed/simple;
	bh=TweCIcZVkpu+j31MfkIM6BjBwkCltnRzNb1JDeE514M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egV0l3lSvUS/zQMnQIaxExmspmrs0Q9DEDi9fPHYwic2pLN6eLUYoY0PuuMKEcNF4lM98Mkva8MOjU7u3lj/R+KabxOmnsqYKDOixL1nXLFYZrCT7X/wWoBgDXw7D9h6C1L89SKEgNz50I94GannPtewjmzJFQZ6rp0w1XRtZnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xqWLxhad; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=ugLw6Txl/Nh1pQ7d2wkRFx9L+dNw/roMpkSALIkryUE=; b=xqWLxhadPrCEifekvoxMzB+bzo
	TEYZRD45vsXvFx0bxQwHYqD8pSdFqD1GjemIJ3g+svmZGa3U/ozP1cRs2yYD0IwOz2MAeriVUUzO5
	DbzKNytNOd7nHFtkSD82cXX7MdvY0p1PQVacUK8E0Z+VmEwv0X48ZYXd56Hx2HB4nhPgvj84qHIYa
	HBEEQqT5kHqF6DqPdvHwA98FAwtIA0qL6j08wOth/KdFEVQTi7yi22s/yyKHgdO4J0IEEscf8I3Xc
	bG8ovESVXE6M7fUoyZGabMN1IjMM8ACwFPEeUZ77hZ7G4gYV7WNEqYSFfszx/Ct12ZD71CzFQ0CRA
	USJFzE1Q==;
Received: from i53875a54.versanet.de ([83.135.90.84] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v1iJG-0001Nz-4h; Thu, 25 Sep 2025 11:30:42 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ukleinek@debian.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 2/6] arm64: dts: rockchip: Fix the 1Ghz ethernet on Qnap TS433
Date: Thu, 25 Sep 2025 11:29:19 +0200
Message-ID: <20250925092923.2184187-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250925092923.2184187-1-heiko@sntech.de>
References: <20250925092923.2184187-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While I want to remember that the dwmac on the TS433 was working at some
point, it seems I had my network always connected to the 2.5G nic after
that "point". And testing now revealed that the gmac does not actually
manages to transfer data.

Currently the gmac is set to rgmii-id with no rx-/tx-delay values set
which makes the driver use default values. Setting the delays to 0
also does not provide a working interface.

The vendor kernel is running with phy-mode set to rgmii and delays of
    tx_delay = 0x3c, rx_delay = 0x2f

As Andrew points out often, those delay values "are magic" and rgmii-id
should definitly be used "with small values" for delays, if really needed.

The Rockchip vendor-kernel actually contains additional code in the dwmac
driver to use the loopback function of a phy to find a window of usable
delay values. Code can be found for example on [0] and the process is
described in a document called "Rockchip GMAC RGMII Delayline Guide"
which has made its way onto the internet in a lot of places [1].

So I used this process, with the interface set to rgmii-id to get values
for this mode, which are in face lower than the ones for rgmii with
    tx_delay = 0x21, rx_delay = 0x15
and results in a working interface on the dwmac.

[0] https://github.com/armbian/linux-rockchip/blob/rk-6.1-rkr6.1/drivers/net/ethernet/stmicro/stmmac/dwmac-rk-tool.c
[1] https://gitlab.com/firefly-linux/docs/-/blob/rk356x/firefly/Common/GMAC/Rockchip_Developer_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 5656554ca284..e8af92a011d6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -257,6 +257,8 @@ &gmac0_tx_bus2
 		     &gmac0_rx_bus2
 		     &gmac0_rgmii_clk
 		     &gmac0_rgmii_bus>;
+	rx_delay = <0x15>;
+	tx_delay = <0x21>;
 	status = "okay";
 };
 
-- 
2.47.2


