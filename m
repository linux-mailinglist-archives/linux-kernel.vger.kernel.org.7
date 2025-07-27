Return-Path: <linux-kernel+bounces-747178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A202CB130B7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0AAD3AD247
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2B921CC44;
	Sun, 27 Jul 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KU3etbvU"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64848BE46;
	Sun, 27 Jul 2025 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634680; cv=none; b=m78bqAgky5j12Y9PlLoZmuQwx8AiFm1s0CljGMlIcaCA9Zp3xIktP4t9kyie3aHA9r8AHQ8n0eN92cOqMs5ljUjgS8hSYVOSrX5VVYZ0Cm5A7yaLVziHASNq7fUMoBPcPOGB3dDBK01mcfFIR0Ognz5EMRL3O9uNX2SxGv+RU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634680; c=relaxed/simple;
	bh=TN3Zvak2DuQFd7+1gtgsfuiwvnGLR9SucMMeog92vUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrNth+otuRDNm9HnJzkihzeO2sewQUQkghZ/TFnBwjbZ9zn1JRzSxsiiRb1S9iwU00+bF0r6+4RimWAd3VJdyZH/M40W0RaxLFJkFo69geui2yv62xgMwlfUfmkJqQQHwB7Bia81Ar4bVgQnXoe1phBDW/WtzxqyyGP8aT+3PTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KU3etbvU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6+It4Ey213trphTymQomqoKQeVEgxSWb6/m2BAFCcKg=; b=KU3etbvUGZOfVLsG2bePY/Gq8I
	/ux6K4u3FHk5NrKtoB+Kf26OX0CQtqGeN0k+ElXxvpvGanwmn92+vUR5xb/ssw7+Y6wjPg9cC5f+9
	GoLu7yTeihQgioaYsviC3k5D89hGxMF7ZPFp6OXZIYY5CIcZDQHjmakmxTm+K7V2071Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ug4U7-0030wF-R4; Sun, 27 Jul 2025 18:44:27 +0200
Date: Sun, 27 Jul 2025 18:44:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add Radxa E24C
Message-ID: <8cf19ce3-28e3-44ee-bf28-06f9c6c406a9@lunn.ch>
References: <20250727144409.327740-1-jonas@kwiboo.se>
 <20250727144409.327740-4-jonas@kwiboo.se>
 <72d979e8-005a-4d4d-b5d2-3f59e78574de@lunn.ch>
 <91ea1a4e-3b83-4857-a410-38425e4e5de0@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ea1a4e-3b83-4857-a410-38425e4e5de0@kwiboo.se>

On Sun, Jul 27, 2025 at 06:26:03PM +0200, Jonas Karlman wrote:
> Hi Andrew,
> 
> On 7/27/2025 6:15 PM, Andrew Lunn wrote:
> >> +&gmac1 {
> >> +	clock_in_out = "output";
> >> +	phy-mode = "rgmii-id";
> >> +	phy-supply = <&avdd_rtl8367rb>;
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&rgmii_miim>, <&rgmii_tx_bus2>, <&rgmii_rx_bus2>,
> >> +		    <&rgmii_rgmii_clk>, <&rgmii_rgmii_bus>, <&gmac1_rstn_l>;
> >> +	status = "okay";
> >> +
> >> +	fixed-link {
> >> +		speed = <1000>;
> >> +		full-duplex;
> >> +	};
> > 
> > A fixed-link without an obvious reason gets me asking questions...
> > 
> > The schematic indicates there is a realtek 6387 switch on the other
> > end. rtl8365mb.c seems to support this. Is there a reason you did not
> > include this now?
> 
> Sorry, this was mentioned in the cover letter, and patches to enable use
> of the switch is incoming in a separate series very shortly.
> 
> """
> This also leaves out describing the RTL8367RB-VB switch as support for
> the switch requires dt-binding and/or driver changes to make it work,
> something that will be handled in a separate follow-up series.
> """

Ah, sorry, missed that.

Please Cc: me when you post these patches.

For the gmac1 node only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

It is nice to see the correct phy-mode being used.

    Andrew

