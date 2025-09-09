Return-Path: <linux-kernel+bounces-809159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1DBB50962
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1BE54657D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E2428D8ED;
	Tue,  9 Sep 2025 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="JGoQv4PP"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A869825A35E;
	Tue,  9 Sep 2025 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757461970; cv=pass; b=B//f1MMk4Z20z9nb19muc5RcSn4U8buESErvadRDFqPey9LUddprm02XYXvwtoV321fb+vo5J0/IVpiIRYg5gI6BzU9T0OhppNBuJgnERkSLjYuaEDktI3AOV1COBgTibJTys5TtHohfVEicKpZ3K/q+KUsKriGBph1f/jCLvME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757461970; c=relaxed/simple;
	bh=oFSzGKh+jE9fG2st9bP5s0hopFkG7LsaFjWbH97Jv1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brbagbz6F1u1A86S1NngeKBDTAjohsD9ObD+uVot9gVNsv56xKg++A6ADzyE93VJddmFb7xLU2QQznbtXOz1rHli3X+c8afK2QxcBtbGBxVck5gPv69Mq1HpBqvjXVeYB/JLB0apRs3Ga/A7ONfpSyr3B66eiGbRG9jcLE1IajU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=JGoQv4PP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757461939; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XG9o0VLGNJfUWI+6pEk36Bc8hw4exL79D4RsD2GisQ9/SrD8gWHRRSSFD3GNBE+x/GskFMGZ6aeSylumWUn/u/7hDU9IQhtREu7OXqIwCw7oYW9gh0rlhFA7+C+9WjLY8PqmSa9jgr3EpP+wNId651CtSCYz6Uyb8g/D7yUmkn4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757461939; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MRosrKVQq7sn22Es6+VF8OMf7pwPJJ2RSe2u88w3Gr4=; 
	b=BIad/jg0ogPaNYBam7CZq0O1RQPh40DoJSFI89lvlgVsk96NmZfgG9kmAFcnkvAvGs6z1vDLYMTIocOSU2IvDjv/xxdV5yo1vHifyUXCQe4Sv0Oq5m4sFVrUdpZ96aScM2CoE2HBajI+BLfIlRIBwHQyPVO+Tuf1Pt3zgyvrYK0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757461939;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=MRosrKVQq7sn22Es6+VF8OMf7pwPJJ2RSe2u88w3Gr4=;
	b=JGoQv4PPa1GJOklEFDrtKWlq5uNnrhnjp8ZV50+7u9/R0qTCWZlE2liNFeCr+2YU
	FKbzH+jcvuQshgrJUr4AaLqJSN6mSTL9zh2hbdQdGpXAX3tjKZVd+l7j57Xh9sxVNy8
	4PNTyM2ycox2LM7a5xfw2BSZgO1fLx7LLY0uAgfI=
Received: by mx.zohomail.com with SMTPS id 1757461937134492.1287969959642;
	Tue, 9 Sep 2025 16:52:17 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 4D0E418031F; Wed, 10 Sep 2025 01:52:12 +0200 (CEST)
Date: Wed, 10 Sep 2025 01:52:12 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Frank Wang <frank.wang@rock-chips.com>, 
	Zhang Yubing <yubing.zhang@rock-chips.com>, Andy Yan <andyshrk@163.com>, 
	Maud Spierings <maud_spierings@hotmail.com>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] dt-bindings: phy: rockchip-usbdp: add improved
 ports scheme
Message-ID: <xyya5zy52mx4o76s6rr5h7lrfkhbri6bvmp7a5mn7cifpbpqlc@ca3zhclu6u3y>
References: <20250904-rock5b-dp-alt-mode-v1-0-23df726b31ce@collabora.com>
 <20250904-rock5b-dp-alt-mode-v1-1-23df726b31ce@collabora.com>
 <aLyKhngeksG2SKdq@umbar.lan>
 <jzooq6qg3y7nee2nz6lujustdf4z7vtn6t2slikw43dann5sbk@2telraae26tl>
 <aLyo4N59o4CIYm-6@umbar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLyo4N59o4CIYm-6@umbar.lan>
X-ZohoMailClient: External

Hi,

On Sun, Sep 07, 2025 at 12:34:24AM +0300, Dmitry Baryshkov wrote:
> On Sat, Sep 06, 2025 at 10:42:22PM +0200, Sebastian Reichel wrote:
> > On Sat, Sep 06, 2025 at 10:24:54PM +0300, Dmitry Baryshkov wrote:
> > > On Thu, Sep 04, 2025 at 08:26:02PM +0200, Sebastian Reichel wrote:
> > > > Currently the Rockchip USBDP PHY as a very simply port scheme: It just
> > > > offers a single port, which is supposed to point towards the connector.
> > > > Usually with 2 endpoints, one for the USB-C superspeed port and one for
> > > > the USB-C SBU port.
> > > > 
> > > > This scheme is not good enough to properly handle DP AltMode, so add
> > > > a new scheme, which has separate ports for everything. This has been
> > > > modelled after the Qualcomm QMP USB4-USB3-DP PHY controller binding
> > > > with a slight difference that there is an additional port for the
> > > > USB-C SBU port as the Rockchip USB-DP PHY also contains the mux.
> > > > 
> > > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > > ---
> > > >  .../bindings/phy/phy-rockchip-usbdp.yaml           | 23 ++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> > > > index 8b7059d5b1826fdec5170cf78d6e27f2bd6766bb..f728acf057e4046a4d254ee687af3451f17bcd01 100644
> > > > --- a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> > > > +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
> > > > @@ -114,6 +114,29 @@ properties:
> > > >        A port node to link the PHY to a TypeC controller for the purpose of
> > > >        handling orientation switching.
> > > >  
> > > > +  ports:
> > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > +    properties:
> > > > +      port@0:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description:
> > > > +          Output endpoint of the PHY for USB (or DP when configured into 4 lane
> > > > +          mode), which should point to the superspeed port of a USB connector.
> > > 
> > > What abourt USB+DP mode, where each one gets 2 lanes?
> > 
> > Right, I guess we would need one port more and have one port for
> > lane 0 + 1 and one port for 1 + 2. For USB-C both ports are
> > connected to the USB-C superspeed port. For DP 4-lane mode the
> > same is done for the input port of the connector. Last but not
> > least for 2 lanes USB + 2 lanes DP, one port can be connected
> > to the USB connector and one port can be connected to the DP
> > connector.
> 
> Hmm. I'm not sure what do you mean here. Basically, it should be:
> 
> - Normal USB-C case with DP AltMode:
>   + port@0 routed to connector's port@1 (through mux or retimer if any)
>   + port@4 routed to connector's port@2 (through mux or retimer if any)
> 
> - Actual DP or mini-DP connector:
>   + port@0 routed to connector's sole port (most likely direcrly)
>   + port@4 most likely unconnected (at least for now, dp-connector
>     doesn't have AUX lines described)
> 
> - Weird mode of having both USB-A or -C and actual DisplayPort
>   + port@0 should get two endpoints, each having data-lines properties,
>     one endpoint being connected to the USB port, another endpoint being
>     connected to DP connector.
>   + port@4 unconnected (yep, we should extend DP properties, maybe I'll
>     send a patch)

That's a bit different from what I described, but sounds more
sensible. Effectively the Rockchip USBDP PHY binding would need
to deprecate rockchip,dp-lane-mux and switch to using data-lines
on the endpoint instead, just like it is currently proposed for
Qualcomm (I follow the T14S HDMI thread).

AFAIK the Rockchip PHY hardware does not support 1-lane DP, so the
binding will have to forbid that. Shouldn't be a problem, though :)

> I'd say, the first two options are the most important ones. Unless you
> have actual hardware that uses the USB + separate DP, I'd say, we can
> ignore that part.

The RK3588 evaluation board routes the first two lanes to a USB-A
connector and the second two lanes + AUX to a RTD2166 bridge, which
converts it to VGA and then terminates on a VGA connector. I have
that on my desk and can do some tests. But I don't have enough time
for preparing patches right now - especially since the RTD2166 is
not yet supported upstream.

Greetings,

-- Sebastian

> > > > +      port@1:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description: Incoming endpoint from the USB controller
> > > > +
> > > > +      port@2:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description: Incoming endpoint from the DisplayPort controller
> > > > +
> > > > +      port@3:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description:
> > > > +          Output endpoint of the PHY for DP, which should either point to the
> > > > +          SBU port of a USB-C connector or a DisplayPort connector input port.
> > > 
> > > I would suggest describing this port as 'DisplayPort AUX signals to be
> > > connected to the SBU port of a USB-C connector (maybe through the
> > > additinal mux, switch or retimer)'. It should not be confused with the
> > > actual DisplayPort signals (as those go through the port@0).
> > > 
> > > In the Qualcomm world we currently do not describe this link from the
> > > PHY to the gpio-mux or retimer, but I think we will have to do that
> > > soon.
> > 
> > It does looks like no upstream platform does a proper description of
> > USB-C setups :(
> > 
> > Thanks for having a look,
> > 
> > -- Sebastian
> 
> 
> 
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> 
> -- 
> With best wishes
> Dmitry

