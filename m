Return-Path: <linux-kernel+bounces-832926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197ABA0C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A6D7BB4F4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5913D30CD95;
	Thu, 25 Sep 2025 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4ah210tl"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F68309F0D;
	Thu, 25 Sep 2025 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820298; cv=none; b=Kgd+ktC+e/pE3U6JJcnQ+10Y/VonGbThulKEjsZZTPwIy15XK7CY5Xqgkg3Bq/aNsm2sBtAveKZ25aU8LgbkaYXIbZe110U12tjdzSxoFtxW2mwWxWP9r55xqOKQDFfzsg9hc6aj63M0L/LwrCRZ6BvDiNPboDHOJUYwswEMsuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820298; c=relaxed/simple;
	bh=daMgWyGHv+PhnYM5vLgFXJjb9jvOntNfF9sGX6v8LGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLB7fd3K+EWgIBpHLT72VABiUWLmJ8eq6nas7lx0yqcF2iB9Yne3BFusp0mJm2q6ev2ohRUiT9+7pUybaa3i7d9f/yF7aBNBgsU37rMV4/VZDPhgUhaRru9Z3rPPBuAYh72taYXvahgT8Jonz1npJ0codI/KfYWCssfJoGRDL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4ah210tl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=l2KQXK0QxwhIywdI52yxYsSm5g6v5vjP57GLurR9+TM=; b=4ah210tlcMTfmpCOwPnIBcnn11
	xM/z+chDbvSpKyoMvOO7U+Z6/kJjuGIC8fMr8KD0WNt2Xed/v3PrTcngYIyb+UrYinR1eVDl5oogZ
	t29Jek3QJh5s5Ia79aOpBKyu8xesBe1OPjV60IrTSAgJcWu7NgTY8UVgwgCSSc1ey8IA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v1pVB-009US2-6Q; Thu, 25 Sep 2025 19:11:29 +0200
Date: Thu, 25 Sep 2025 19:11:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"ukleinek@debian.org" <ukleinek@debian.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH 2/6] arm64: dts: rockchip: Fix the 1Ghz ethernet on Qnap
 TS433
Message-ID: <e4d3127b-c879-4931-9ea0-de7449bc508c@lunn.ch>
References: <20250925092923.2184187-1-heiko@sntech.de>
 <20250925092923.2184187-3-heiko@sntech.de>
 <da752790-da17-4d26-b9b2-8240b38b3276@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da752790-da17-4d26-b9b2-8240b38b3276@kwiboo.se>

On Thu, Sep 25, 2025 at 06:58:06PM +0200, Jonas Karlman wrote:
> Hi Heiko,
> 
> On 9/25/2025 11:29 AM, Heiko Stuebner wrote:
> > While I want to remember that the dwmac on the TS433 was working at some
> > point, it seems I had my network always connected to the 2.5G nic after
> > that "point". And testing now revealed that the gmac does not actually
> > manages to transfer data.
> > 
> > Currently the gmac is set to rgmii-id with no rx-/tx-delay values set
> > which makes the driver use default values. Setting the delays to 0
> > also does not provide a working interface.
> > 
> > The vendor kernel is running with phy-mode set to rgmii and delays of
> >     tx_delay = 0x3c, rx_delay = 0x2f
> > 
> > As Andrew points out often, those delay values "are magic" and rgmii-id
> > should definitly be used "with small values" for delays, if really needed.
> > 
> > The Rockchip vendor-kernel actually contains additional code in the dwmac
> > driver to use the loopback function of a phy to find a window of usable
> > delay values. Code can be found for example on [0] and the process is
> > described in a document called "Rockchip GMAC RGMII Delayline Guide"
> > which has made its way onto the internet in a lot of places [1].
> > 
> > So I used this process, with the interface set to rgmii-id to get values
> > for this mode, which are in face lower than the ones for rgmii with
> >     tx_delay = 0x21, rx_delay = 0x15
> > and results in a working interface on the dwmac.
> > 
> > [0] https://github.com/armbian/linux-rockchip/blob/rk-6.1-rkr6.1/drivers/net/ethernet/stmicro/stmmac/dwmac-rk-tool.c
> > [1] https://gitlab.com/firefly-linux/docs/-/blob/rk356x/firefly/Common/GMAC/Rockchip_Developer_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf
> > 
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> > index 5656554ca284..e8af92a011d6 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> > @@ -257,6 +257,8 @@ &gmac0_tx_bus2
> >  		     &gmac0_rx_bus2
> >  		     &gmac0_rgmii_clk
> >  		     &gmac0_rgmii_bus>;
> > +	rx_delay = <0x15>;
> > +	tx_delay = <0x21>;
> 
> I do not understand why defining rx/tx_delay would change anything.

I was also wondering why these two properties are added but no change
to phy-mode.

> 
> Setting these should currently not have any effect on the driver code
> when phy-mode=rgmii-id is used, see below (next-20250924, dwmac-rk.c):
> 
> 
> 	switch (bsp_priv->phy_iface) {
> 	case PHY_INTERFACE_MODE_RGMII:
> 		dev_info(dev, "init for RGMII\n");
> 		bsp_priv->ops->set_to_rgmii(bsp_priv, bsp_priv->tx_delay,
> 					    bsp_priv->rx_delay);
> 		break;
> 	case PHY_INTERFACE_MODE_RGMII_ID:
> 		dev_info(dev, "init for RGMII_ID\n");
> 		bsp_priv->ops->set_to_rgmii(bsp_priv, 0, 0);
> 		break;

And this explains it, thanks.

> I have played around with a few patches that changes this and apply the
> rx/tx_delay for rgmii-id modes (both Linux and U-Boot), see top of [2]
> for Linux patches. Will try to get them on ML in a few days.

We should not really be expanding the use of rx_delay and
tx_delay. The standardized properties {tx|rx}-internal-delay-ps should
be used.

	Andrew


