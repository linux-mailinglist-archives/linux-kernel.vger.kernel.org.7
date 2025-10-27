Return-Path: <linux-kernel+bounces-872319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 569ABC0FEA8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183E3402B78
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0282D8797;
	Mon, 27 Oct 2025 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TU/PrIb2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0860A2D7DF4;
	Mon, 27 Oct 2025 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589370; cv=none; b=Qh1ZhxTqeIb220Ted83BgAxaQIyHJtgZgam4TG/JM5OODj1S/Jw3kll4E+p3tr2iB3EMVuigViI0EbkCCNsd3zLYhC7FBuIMEA1LSTQgtzF0KiS2lRGQ2GfPfsMa4Hv98K5pp0lAKkgfIh0KSTUuwmEEBuNSoIYMRv2mTIPfV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589370; c=relaxed/simple;
	bh=h0Akxevv1FwFzTjlo4aljOnkFihbhJJn9CePtpMBHU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdFcO4jdf8aWLEUQbdtwxJNy72l2GQJIZq2qzVmgMRhgr+QNuBnZprYAtfjRKXbQJdW95g008VylFHzXCEr5Xi8RzrY5MW0ROufP4Vhk9Ns1hWb8hZiRAItlMOuMK1R7ZM5Y2ve50vHsWHn8IkLGCqI7aeD6a1Epr+Iod275zlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TU/PrIb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D48C4CEF1;
	Mon, 27 Oct 2025 18:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761589369;
	bh=h0Akxevv1FwFzTjlo4aljOnkFihbhJJn9CePtpMBHU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TU/PrIb2xo7EWam6dX1GZpobXpr8na62zyME1zrIQgmyzyS4dA+yPG9MQuLWIQdlM
	 73XzFcnx7gpqtLv06j29NUuec09shTXfnLrFy3WMXn5lsGbncv4iCqcukSqzFKcgRy
	 7zUtaHF5oIUk+TKenVBMO+StwH4UVbjoQTpmR34kZSOfrBn4WQwlHlQIpofgMqthJx
	 M/KXYj3W2cn/lvRn2aD2nUMfueeWZ/kJQnprH6uAcMC6dwo0xzZfls4eOkK7kzMQWF
	 o+yVeur7X3wGZHlH231jjtG7znLkhx2eaatY1reYrTDmgW/k+FDL9Ah4SE/hSFbRG8
	 UoaBdqpOJB6pg==
Date: Mon, 27 Oct 2025 13:22:48 -0500
From: Rob Herring <robh@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, srini@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	horatiu.vultur@microchip.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.machon@microchip.com,
	luka.perkov@sartura.hr
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: lan9662-otpc: Add LAN969x series
Message-ID: <20251027182248.GA1281416-robh@kernel.org>
References: <20251024192532.637563-1-robert.marko@sartura.hr>
 <f3bd99c8-eb70-40d3-9b43-fba56546f591@kernel.org>
 <CA+HBbNGZ3FwrGCtHX=mc8LQR9DCU84jqfhjFRGVDCJWtt+gdkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNGZ3FwrGCtHX=mc8LQR9DCU84jqfhjFRGVDCJWtt+gdkA@mail.gmail.com>

On Mon, Oct 27, 2025 at 01:23:20PM +0100, Robert Marko wrote:
> On Sun, Oct 26, 2025 at 11:10 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On 24/10/2025 21:24, Robert Marko wrote:
> > > LAN969x series also has the same HW block, its just 16KB instead of 8KB
> > > like on LAN966x series.
> > >
> > > So, document compatibles for the LAN969x series.
> > >
> > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > ---
> > >  .../devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml  | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
> > > index f97c6beb4766..f8c68cf22c1c 100644
> > > --- a/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
> > > +++ b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
> > > @@ -23,8 +23,15 @@ properties:
> > >        - items:
> > >            - const: microchip,lan9668-otpc
> > >            - const: microchip,lan9662-otpc
> > > +          - const: microchip,lan9691-otpc
> > > +          - const: microchip,lan9692-otpc
> > > +          - const: microchip,lan9693-otpc
> > > +          - const: microchip,lan9694-otpc
> > > +          - const: microchip,lan9696-otpc
> > > +          - const: microchip,lan9698-otpc
> >
> > Why are you changing lan9668? Nothing on this is explained in commit
> > msg. Also, list of more than 3 items is not really useful.
> 
> I am not chaning lan9668 but rather lan9698.
> I agree that a list of all possible SoC models is not ideal but I was
> just following the current
> style in the binding.
> 
> As far as I know, the whole LAN969x series has identical OTP so just
> using a single
> microchip,lan9691-otpc compatible is enough.

The above is a *list* of what a "compatible" entry must contain.

> 
> >
> > >        - enum:
> > >            - microchip,lan9662-otpc
> > > +          - microchip,lan9691-otpc

"enum" on the other hand is a list of possible values for 1 entry in 
"compatible".

Rob

