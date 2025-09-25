Return-Path: <linux-kernel+bounces-832471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90DBB9F678
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0C33A3C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2B2211460;
	Thu, 25 Sep 2025 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKgCikrb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED2220102B;
	Thu, 25 Sep 2025 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805512; cv=none; b=lj/3fIvqqrBcLuC9Mqrxt5lpug8FMNVUCNzTFXCI1JrH9wWZ++zelnWB1cyxiCpHeeYVDIcmUavWvx2oHfio8D2/E3aFWCChEi+ybWAf1kZc8C3sS3ud6mtyZLiSn0f/vWpLj8UtRZ3FXIsRcfkQUeVikicZVo6Xdq1C10vhWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805512; c=relaxed/simple;
	bh=tBH6b/012H4Tj3wKXmB4ra2XVLYC8PL8Cd50q+FllFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyDyrrfAJ6wv9M8QzB5dHPepyzs79dWlt5/bC3/yYHwl8vO8iU4okLGM652iOLgGwbzjmwi1/wDo2BJPfPBMMJmjGULSV64gkYFLCZl7Tl5chNgq+H6UIZSRVLjbZmD7buu0kSl0FQFts+mod0hlyiBWE2P2g2oxC09/+5QGAoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKgCikrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0075C4CEF0;
	Thu, 25 Sep 2025 13:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758805511;
	bh=tBH6b/012H4Tj3wKXmB4ra2XVLYC8PL8Cd50q+FllFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKgCikrbATt1bRGTTX39ZjdL0+5WywwS0FCeUS8sm1FJVn3Cbskm8B++rV/M8Uw+1
	 cTB1mnZ9883WWFoU9+1KS2yRBMcfIANsnI331ZlHPxq+6eO48CbTPc2poK9h0fxxtG
	 wamLElqify2KdQBYUTZIaJpdpgCXE3/VbAcDIyKVM3Ahs2+rdOfF0BfGjoA9SeE0uo
	 SM6deBCAMmHDL28Kyt1e2cS4zoF87NT5iNMbU8wLwwW17xPgg4VPLSA5VvpGwXbx2M
	 TliN8NPDOjStbnrovbqsATLb3U+TgGBodmTzBvVnaoC08AWaX/X6fn8Tot6RaoLNMJ
	 aIyDXyZaHCO5g==
Date: Thu, 25 Sep 2025 08:05:10 -0500
From: Rob Herring <robh@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 phy 12/16] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250925130510.GA451343-robh@kernel.org>
References: <20250923194445.454442-1-vladimir.oltean@nxp.com>
 <20250923194445.454442-13-vladimir.oltean@nxp.com>
 <20250924135429.GA1523283-robh@kernel.org>
 <20250924154534.cyyfi2aez46iu2sw@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924154534.cyyfi2aez46iu2sw@skbuf>

On Wed, Sep 24, 2025 at 06:45:34PM +0300, Vladimir Oltean wrote:
> Hi Rob,
> 
> On Wed, Sep 24, 2025 at 08:54:29AM -0500, Rob Herring wrote:
> > > +description: |
> > 
> > Don't need '|' if no formatting to preserve.
> 
> Thanks, will drop.
> 
> > > +  "#address-cells":
> > > +    const: 1
> > > +    description: "Address cells for child lane nodes"
> > 
> > You don't need generic descriptions of common properties.
> 
> Ok, I'll also drop the description from #size-cells but keep it in
> #phy-cells (less obvious).
> 
> > > +
> > > +  "#size-cells":
> > > +    const: 0
> > > +    description: "Size cells for child lane nodes"
> > > +
> > >    "#phy-cells":
> > > +    description: "Number of cells in PHY specifier (legacy binding only)"
> > >      const: 1
> > >  
> > > @@ -32,9 +124,51 @@ examples:
> > >      soc {
> > >        #address-cells = <2>;
> > >        #size-cells = <2>;
> > > -      serdes_1: phy@1ea0000 {
> > > -        compatible = "fsl,lynx-28g";
> > > +
> > > +      serdes_1: serdes@1ea0000 {
> > > +        compatible = "fsl,lx2160a-serdes1";
> > >          reg = <0x0 0x1ea0000 0x0 0x1e30>;
> > > -        #phy-cells = <1>;
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        phy@0 {
> > > +          reg = <0>;
> > > +          #phy-cells = <0>;
> > > +        };
> > 
> > There's really no difference between having child nodes 0-7 and 8 phy 
> > providers vs. putting 0-7 into a phy cell arg and 1 phy provider. 
> > 
> > The only difference I see is it is more straight-forward to determine 
> > what lanes are present in the phy driver if the driver needs to know 
> > that. But you can also just read all 'phys' properties in the DT with a 
> > &serdes_1 phandle and determine that. Is that efficient? No, but you 
> > have to do that exactly once and probably has no measurable impact.
> > 
> > With that, then can't you simply just add a more specific compatible:
> > 
> > compatible = "fsl,lx2160a-serdes1", "fsl,lynx-28g";
> > 
> > Then you maintain some compatibility.
> > 
> > Rob
> 
> With the patches that have been presented to you thus far -- yes, this
> is the correct conclusion, there is not much of a difference. But this
> is not all.

That's all I can base my conclusion on if you don't tell me more...

> If I want in the future to apply the properties from
> Documentation/devicetree/bindings/phy/transmit-amplitude.yaml to just
> one of the lanes, how would I do that with just 1 phy provider? It's not
> so clear. Compared to 8 phy providers, each with its OF node => much
> easier to structure and to understand.

That's unfortunate that binding wasn't designed to support more than 
1 instance. You could do:

lane@0 {
  reg = <0>;
  tx-p2p-microvolt = <123>;
};

lane@1 {
  reg = <1>;
  tx-p2p-microvolt = <123>;
};

Yeah, that's about what you had, but it avoids changing the cell size. 
That should be a bit simpler to implement in the driver and to add to 
existing DTs as a fixup (because you don't have to change 'phys' entries 
everywhere).

Another option is go to cell size of 2 and stick the voltage in a cell. 
That approach doesn't work well if you have a 3rd, 4th, etc. cell to add 
later for more properties.

Your overlaying the old and new bindings approach works too. That 
approach is fine with me.

Rob

