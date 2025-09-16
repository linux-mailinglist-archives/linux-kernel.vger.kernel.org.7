Return-Path: <linux-kernel+bounces-819459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4F2B5A0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28639523180
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515622DE707;
	Tue, 16 Sep 2025 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L0qSGYez"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB9632D5D4;
	Tue, 16 Sep 2025 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758049674; cv=none; b=tcGp3JH9UKQkAI3RN+vMeQmnkEUo9fKVZgFXigVa516RLqS15B8sJUzSOynzqwoRixNVikR8/VtPOM78Q9XFqVCI1MVN8uwgVK9mnWjxbx2l6bJ6AqeumHz0OeghuXOj3/S01N5+Vn6zkztAmT1aW6K7J5qmyTB+nzxVMbsKZHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758049674; c=relaxed/simple;
	bh=6QySUy4LZEJZpfjQ0H6X9s+XHrpKUHC/n2BsSTTXfhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tq7+8c/62F0v7RKkqI0s+KJ3DOcreXN3LMRRPa7MqwFWQTIX+UcvlPuIy0i3FAJ3I8EHgSvSJsVfH/UFLSsgY8Gh+Lg8CDsvfH9z+NZ+yAnDyN6ExVOQo4kflEn/kLPwIKkD0o+4/hkL/zVFrXxj4RCaivLa+C2wYrxgyVexz6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L0qSGYez; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EXaqcsYENogvAnvlB2KNNelAI84J4RkeUSRS8e50eXg=; b=L0qSGYez+AX/bZrlmzh1BNLW0E
	EtKNdzLn0IOSUqLJ95hkAkKr/WHGXbRVqtBgnw6ggf6aJDSJttdau3MVJyP/oD0PcpfSqDKX7qm0E
	CVa8efe7MTJIwxmBA6mnF+ERrenn5O8SrFw7wUx2vWKbMVm/U76tRW8JqQwbgcR5PZts=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyb1b-008bIv-HR; Tue, 16 Sep 2025 21:07:35 +0200
Date: Tue, 16 Sep 2025 21:07:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rebecca Cran <rebecca@bsdio.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
Message-ID: <3f5e82ec-d96e-4258-b117-9876313f5402@lunn.ch>
References: <20250911051009.4044609-1-rebecca@bsdio.com>
 <20250911051009.4044609-3-rebecca@bsdio.com>
 <58a092c5-5dd0-4718-831a-e25ecb184087@lunn.ch>
 <5ccc4945-87f6-4325-b034-ca3f2f90257a@bsdio.com>
 <74e68c53-2696-4f86-97d3-c0b0a74d4669@lunn.ch>
 <92bcdac9-44b1-4fc8-892a-01ef0ed0b7e0@bsdio.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92bcdac9-44b1-4fc8-892a-01ef0ed0b7e0@bsdio.com>

On Tue, Sep 16, 2025 at 12:40:15PM -0600, Rebecca Cran wrote:
> On 9/15/25 18:37, Andrew Lunn wrote:
> 
> > And does it have a PHY? On an MDIO bus? Unless i'm mistaken, you don't
> > describe the PHY, a phy-handle pointing to the PHY, and don't have
> > phy-mode = 'rgmii-id'.
> 
> I've been trying to figure this out. Yes, it's connected to a PHY (an
> RTL8211E).
> 
> At the moment it's being detected by OpenBMC as:
> 
> ftgmac100 1e680000.ethernet: Read MAC address 9c:6b:00:43:0b:bd from device
> tree
> RTL8211E Gigabit Ethernet 1e680000.ethernet--1:00: attached PHY driver

So what is probably happening is that the ftgmac100 is creating an
MDIO bus. It does not matter if there is no node for it, it still
creates the bus, and the PHYs on the bus are found. You should be able
to see this in /sys/class/mdio_bus/. Then, since there is no
phy-handle, it uses phy_find_first() to find the first PHY on the bus,
and binds to that.

Now, it looks like all other aspeed-g5 boards also don't link to the
PHY. But the driver does seem to support adding an 'mdio' node within
the ethernet node, and listing the PHYs. Something like:

       mdio {
                #address-cells = <1>;
                #size-cells = <0>;

                ethphy0: ethernet-phy@0 {
                        reg = <0>;
                };
        };

And then you can add a phy-handle to point to it.

Then the question is, did Aspeed mess up the RGMII delays for g5? You
can try phy-mode = 'rgmii-id' and see if it works.

    Andrew

