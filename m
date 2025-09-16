Return-Path: <linux-kernel+bounces-819680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC55B5BEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2D61BC24BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9642B285077;
	Tue, 16 Sep 2025 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TmB0SquX"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5398021E098;
	Tue, 16 Sep 2025 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060326; cv=none; b=K66ERRL8I4bs3DiqUl6bo7AOheRGQC5rOPcZNfiy3ZUQe59XCljsV8uS4UJ/wK2Yb2I2g6/KXFp/votnguyBfndockW6F16506Kb7vqCZBdanaw8eTNaJnHlzsPKO6JpjlhBt6z+QI6gHhKXdaCOPO9For/82ChBK7vpvrCJ5o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060326; c=relaxed/simple;
	bh=huuM+ARkPDCxyOXO1vNoTClH0iOFBCoWPzK9y9RCrzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO03W/judNfB0yvPovqdGNZ2C5HbjvAp1xE5N4JC7slo9zCxwcnqOEI43/aVYcaL/rk93WESWLs2QibSG7W5jFilbDhlUjVWNTqyXlWH+Ecbt9Acyw1+f1KFfa4TQt28BBqk6IpJKhn+5hp4G2MVc6L4XM95jSGrr5QTRxl1JdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TmB0SquX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0NhlOmwwkbZxCW85MLAxOa0IFUPYAvjNPwpAMzd4f7U=; b=TmB0SquXq7T6jSiGvoN6t1GMKP
	WCDhj8wDFT/A5PtG/BREIkNIGFYYAxh0o98TF9TGgB45iejGzcgjHgrDRf8QbExubYbvnSsGTo7iM
	HkqW4BWHrciZDw7mdTmFDRUGMUNxD6s20rxchpp0SM9C518HluqC8mgPS09hTXWLXCuo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uydnP-008cU8-I7; Wed, 17 Sep 2025 00:05:07 +0200
Date: Wed, 17 Sep 2025 00:05:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rebecca Cran <rebecca@bsdio.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
Message-ID: <cc00cc74-778f-45ae-b48f-be26c91f78c7@lunn.ch>
References: <20250911051009.4044609-1-rebecca@bsdio.com>
 <20250911051009.4044609-3-rebecca@bsdio.com>
 <58a092c5-5dd0-4718-831a-e25ecb184087@lunn.ch>
 <5ccc4945-87f6-4325-b034-ca3f2f90257a@bsdio.com>
 <74e68c53-2696-4f86-97d3-c0b0a74d4669@lunn.ch>
 <92bcdac9-44b1-4fc8-892a-01ef0ed0b7e0@bsdio.com>
 <3f5e82ec-d96e-4258-b117-9876313f5402@lunn.ch>
 <e9b0d9c8-9117-4c75-93a7-1c334d823d99@bsdio.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b0d9c8-9117-4c75-93a7-1c334d823d99@bsdio.com>

On Tue, Sep 16, 2025 at 03:22:04PM -0600, Rebecca Cran wrote:
> On 9/16/25 13:07, Andrew Lunn wrote:
> 
> > Now, it looks like all other aspeed-g5 boards also don't link to the
> > PHY. But the driver does seem to support adding an 'mdio' node within
> > the ethernet node, and listing the PHYs. Something like:
> > 
> >         mdio {
> >                  #address-cells = <1>;
> >                  #size-cells = <0>;
> > 
> >                  ethphy0: ethernet-phy@0 {
> >                          reg = <0>;
> >                  };
> >          };
> > 
> > And then you can add a phy-handle to point to it.
> > 
> > Then the question is, did Aspeed mess up the RGMII delays for g5? You
> > can try phy-mode = 'rgmii-id' and see if it works.
> 
> I can't get that to work, with either 'rgmii-id' or 'rgmii'.
> 
> It says "Failed to connect to phy".

That probably means i have the wrong reg value. Try 1, 2, ... 31.

Or put a printk() in phy_find_first() to print the value of addr.

	Andrew

