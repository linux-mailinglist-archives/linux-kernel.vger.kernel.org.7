Return-Path: <linux-kernel+bounces-809321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1387DB50C04
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0CD164B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AAA2472BC;
	Wed, 10 Sep 2025 02:57:19 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9575221FCD;
	Wed, 10 Sep 2025 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473038; cv=none; b=EAZU8Yyw29ggY/3cMt9Pz8Yopzz/XCmk+J9O/56K5HvaMW69fJPOkqyflE7A0mRP0MaxJ5lRiX5Ln7CyennPgSAL0gO6ujn82WAMn+/1XhlcpcfGXg8vbwa01IvtnjFNbnjZdd0btym1MosYiyaAf3NcE7ZI3cpgoha9Sgin734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473038; c=relaxed/simple;
	bh=wo9OsIKUSOb4y/YjQTxP7fSgYy7JcUtfrnlbE0zFHYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JkY/5SxNt4V90jwJhE30/PCP0DtWKuwz751S867GlbPeYB34qqwyufhIgZEK2IftTjJgDs9nK9Kswrw4wWJKfUts0HcRnTONnTkkvJo7GxvOth/7FeJ98m9yPmWkrlmQidYuncuJHjsJStyHTLNJ52YvBbGyY+P47aIux/5eIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn; spf=pass smtp.mailfrom=t-chip.com.cn; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-chip.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-chip.com.cn
X-QQ-mid: zesmtpgz1t1757472967t74690c6b
X-QQ-Originating-IP: M3qgbrrmtUk2hnbg2au9CWkEhPxB9US2+LWcIhSpDN0=
Received: from dkx-H410M-H-V2 ( [183.51.121.90])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Sep 2025 10:55:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 654995868464269577
EX-QQ-RecipientCnt: 16
Message-ID: <76B19AD42CA555FC+fff44db30522cf270802ec31912a9c19d29b2d39.camel@t-chip.com.cn>
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add devicetree for the
 ROC-RK3588-RT
From: Kaison <dkx@t-chip.com.cn>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Jimmy Hon <honyuenkwun@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Wayne Chou
 <zxf@t-chip.com.cn>, Quentin Schulz <quentin.schulz@cherry.de>, Dragan
 Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>, FUKAUMI Naoki
 <naoki@radxa.com>, Peter Robinson <pbrobinson@gmail.com>,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,  linux-kernel@vger.kernel.org
Date: Wed, 10 Sep 2025 10:55:22 +0800
In-Reply-To: <307a76a6-cc92-44a1-9ac0-97005bf51b4b@lunn.ch>
References: <cover.1757322046.git.dkx@t-chip.com.cn>
	 <42ae6d16ed9162582e7b03cbad661a7950c0db55.1757322046.git.dkx@t-chip.com.cn>
	 <307a76a6-cc92-44a1-9ac0-97005bf51b4b@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:t-chip.com.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mdc3TkmnJyI/6FAGiVcHwJ65lGMqzzmC4ZTtdU2m2p2uPPUJu7BMkcsK
	KlYEwj7i1oKfzoiSgPlZ9UYslC1ildvmL36d8LoGHnVfGG5unWPERjYrbD2hRAVTsgyNmI1
	3IbtkZniHef03LV6kIapNrwbf7nm7AawHJ7pzBsE2KoM7A3hGWd5o5pfJquKub6O5PDAyNG
	wdAsUSja73QUu04ik8NgopRS4+rwPSkl8R8boGMMhH9NYwWAEVJVk/PQZGtScaADukCvMVl
	DF4UYnJ9mT5BXATIgaQx6kqKHxpKZR2B9I8b9HqavS9Qoqt4iexiplvCpLXHqpZTnUPB7X2
	b8YDfkYQh3n5VsrH1iL7p1Y9wqBSw5eGQBrqiEPn7j2kgjCZVlfiBPa2m+iPsm+HFZ/2CxR
	/BxK3R0Eya5XirYggByvrf7fGDjrLtp4mggeRLlOU7jVl7gc1Ilnjsx1EWx2rKiUNrZ6iBJ
	VUe+fEQzl3g940Qr879lVt8DJ3VtbCssvhM4ctuTB8VntdsZxbGWaaOzr5+c6heMxGQQ/1t
	d+lBQlpqQseLNOaxzdrAcNoOypIbWA4aswCvps+wU3wowXaIp3x5BcFW+pD8KQABT+X17sG
	2ufjW8iRjHRI8x18O+jD2yjsTnZ/4IPPLLAkxaoyms6gBIN9QhckYrEprgCvtX/Bas5vX2p
	dESicn1Vd5G7UDgzYMNmuIIQRIzOukKmmbm8cciNFUcnk8p5BsiTZlVLTBS9dvGgdVUyflA
	vlBEzBSKP+nf/FCcKaQkxxJ4r9etcmrHZrOei5krT2ZvgYbMqYHUBLCrubXowhyAJiN0mcJ
	ZhrPbbzGoEO4PyiaNPCGi1Ab4X3ezQPAoV4MykZ0BxSvh6jrUyiJtjMdGqhQPZyzd+B705h
	dqKS0E6+AV/PGP+vpMhkU+kVLtj1nSn6cyPclHEx3My4H3EMxRW/kZLlH475RJBNSMh8DaP
	ebQxs1dOVr2d3JYHBpRgEuhOUH/hCGD9lB2apuVvIanK1b7rabj9yJTdXraeaOjZb4gvct4
	VER6O/LjAsKXAzn7C7jiMagzoiRgVde8U/TIAw7cUzHysd8UtIyHTJQzj6Ego=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

hi,
I'm very sorry. Due to the default configuration of my email, I didn't
receive your email normally. I have fixed this issue.

On Tue, 2025-09-09 at 14:31 +0200, Andrew Lunn wrote:
> > - 2x Gigabit Ethernet, 1x 2.5G Ethernet
> 
> I actually only see the 2x 1G. Is the 2.5G not supported yet?
The 2.5G Ethernet is based on the Realtek RTL8125 network controller of
PCIe 2.0x1.

+&combphy0_ps {
+       status = "okay";
+};

[snip]

+&pcie2x1l2 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&pcie2_2_rst>;
+       reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
+       status = "okay";
+};

> 
> > +&gmac0 {
> > +	clock_in_out = "output";
> > +	phy-handle = <&rgmii_phy0>;
> > +	phy-mode = "rgmii-rxid";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&gmac0_miim
> > +		     &gmac0_tx_bus2
> > +		     &gmac0_rx_bus2
> > +		     &gmac0_rgmii_clk
> > +		     &gmac0_rgmii_bus>;
> > +	tx_delay = <0x47>;
> 
> What happened about my comment that "rgmii-rxid" is probably wrong?
> 
> If you think it is correct, you should reply with a
> justification. Maybe PCB is very odd? In which case, a comment would
> be good to explain who it is odd.
The Ethernet part of the board is designed with reference to the
rockchip evb1 board. 

link: 
https://github.com/Firefly-rk-linux/docs/blob/rk3588/firefly-public/en/Common/GMAC/Rockchip_Developer_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf


The document describes the usage of the rgmii-rxid mode:

When the hardware enables the RX delay of the PHY. Need to turn off the
RX delay of the GMAC, and the dts configuration mode becomes "rgmii-
rxid".

> 
> 	Andrew
> 

Kaison


