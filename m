Return-Path: <linux-kernel+bounces-878948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9567C21D58
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2960E1882AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F9136CE1E;
	Thu, 30 Oct 2025 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppahJgI3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFA323BD17;
	Thu, 30 Oct 2025 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761850284; cv=none; b=eMSibZLMVTDt+Cw1UwaPHSSKt+9sEg9nw20UWwDL6JBSzY/QPRMp3MW1sXzmxUjv6YP/Gz/cvqd9U9R10pmGtryZCzfJv17NbQw6NkYAAwL1RkEABRbGIo9XiGynZJdKnhkg/qNbbCOswl11gDd5VIHp0piPpKE4SYmL6b+f574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761850284; c=relaxed/simple;
	bh=FBCCR/Suue4f/BvtdNxzoMBDqCveM6h0dVOlYqgroZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbJv1WLrtxUOfn/65EC4xHlMZDNhYTqZWfnNJvHlA0OaeHYoWJ9Xd3lxbovRMmeeJ8ySSwRqnjuSjJDP5TkUXI3OTGMjB4d7Gtf5co/k04W3qBHUo9NJQcECAf9CqWWw73T7tEVL+BFh0w2OS/wrzXpBx7mNYEIIxKngBvtQnX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppahJgI3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9089C4CEF1;
	Thu, 30 Oct 2025 18:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761850284;
	bh=FBCCR/Suue4f/BvtdNxzoMBDqCveM6h0dVOlYqgroZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppahJgI3Xpdl1cneURrtsR7KIjC+5T47cH07+HkmD4gKk5zbtBbcJ7WlO5RtFoDGB
	 Agf3/JtDIpzT0bS9yvmQmQxyN6MEBMVjerBSWgqL7LqLflyyi0dPVIn1J4kE4PG/nK
	 q6EAr0bkeofrSkl4D7UdD/TRn1xSWZFL1xIptv+Xv53fOu5x+4LIQ5w9sg9O4QfYGJ
	 NrWp2HIU+xkwZmrtcL3sAtuDnpFkugmTDZMWKykXc5JTuelFgbnUz2heyaxVB6hgat
	 6t/Bnpm073zqJY11MUlgRPwAkRGaNeLHmm5w9AABv+WHTMAeO+v3+QTSzn9kYAxZFs
	 3RzUr4Zp4XgRA==
Date: Thu, 30 Oct 2025 13:51:22 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: phy: Add documentation for Airoha
 AN7581 USB PHY
Message-ID: <20251030185122.GA236742-robh@kernel.org>
References: <20251029173713.7670-1-ansuelsmth@gmail.com>
 <20251029173713.7670-3-ansuelsmth@gmail.com>
 <20251029-mutual-scotch-7ca52e17da69@spud>
 <69025bc9.5d0a0220.1f0440.deb9@mx.google.com>
 <20251029-henna-easily-227513366e90@spud>
 <690266d4.050a0220.3a144c.eef7@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690266d4.050a0220.3a144c.eef7@mx.google.com>

On Wed, Oct 29, 2025 at 08:11:10PM +0100, Christian Marangi wrote:
> On Wed, Oct 29, 2025 at 06:35:51PM +0000, Conor Dooley wrote:
> > On Wed, Oct 29, 2025 at 07:24:04PM +0100, Christian Marangi wrote:
> > > On Wed, Oct 29, 2025 at 06:07:22PM +0000, Conor Dooley wrote:
> > > > On Wed, Oct 29, 2025 at 06:37:10PM +0100, Christian Marangi wrote:
> > > > > Add documentation for Airoha AN7581 USB PHY that describe the USB PHY
> > > > > for the USB controller.
> > > > > 
> > > > > Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
> > > > > always supported. The USB 3.0 mode is optional and depends on the Serdes
> > > > > mode currently configured on the system for the relevant USB port.
> > > > > 
> > > > > The first USB port on the SoC can be both used for USB 3.0 operation or
> > > > > Ethernet (HSGMII).
> > > > > The second USB port on the SoC can be both used for USB 3.0 operation or
> > > > > for an additional PCIe line.
> > > > > 
> > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > ---


> > > > > +  '#phy-cells':
> > > > > +    description: Describe if the referred PHY is the USB 2.0 PHY or USB 3.0 PHY.
> > > > > +    const: 1
> > > > 
> > > > Which is which here?
> > > >
> > > 
> > > Mhh I think I didn't understand here. #phy-cells describe the
> > > parameters to be used for phys property in a different node.
> > > 
> > > The current usage would be
> > > 
> > > <&usb0_phy PHY_TYPE_USB2> for USB 2.0
> > > or <&usb0_phy PHY_TYPE_USB3> for USB 3.0
> > > 
> > > This node expose 2 PHY that can be referenced by the single parameters.
> > 
> > Ah, I didn't know that the 1 cell variant here was type not index.
> > 
> 
> Yes in the driver I'm maching for type not index as it's very confusing.
> Any hint on better describe it on the schema? Maybe I can reword with
> 
> "Describe if the referred PHY is PHY_TYPE_USB2 or PHY_TYPE_USB3"

"The cell contains the mode, PHY_TYPE_USB2 or PHY_TYPE_USB3, as defined 
in dt-bindings/phy/phy.h."

Rob

