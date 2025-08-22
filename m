Return-Path: <linux-kernel+bounces-782663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E734B3235D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050225E2FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC86A2D7398;
	Fri, 22 Aug 2025 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbj0m+8n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6D61F418D;
	Fri, 22 Aug 2025 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755893118; cv=none; b=dqTxPsWP9WZst4aj65+6q8UDn/gxBKm4VAx64VQGYQcZ1Wu4tsasUB5pbbZInM2kPsaCoFRgjboDthlMuzx1oU6sfcwsE6SOx3/P5I60GWy5KQm+j3KhVHyTvki4verh73iY1bBT1DQnhSeuTRlWlFJAPXtUCuArrUfAFKW/p40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755893118; c=relaxed/simple;
	bh=FJYKSaWg9qfXe9WhCcNjPEiiwTTwCMlUdpAl+aVXHpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXVuLtz9TdY1CBMP6dc3i+JHMugND5Oma26CZF3ykHyP8fdLnY36zpOc9saryNZvucVmCHPYqrQzWMaD+sNDH0+8ZHSBdVzm321M8MrxcpJFYZ+SehCji8NX3n/sRf+6SMJ8Gz0XgSrLko3iBLbHLnAKgVpogOLuOtmCSA6aWUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbj0m+8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7B3C4CEED;
	Fri, 22 Aug 2025 20:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755893116;
	bh=FJYKSaWg9qfXe9WhCcNjPEiiwTTwCMlUdpAl+aVXHpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbj0m+8nozri5c8U3S2Zv0AfT230nTh/sYeos0NSYVdHUysxGUdGTLCmkLFKmw4yr
	 zTW6lUDsp08O3/vQiuzLc2RZ/T7cN/5DFHB3tRTRicvIF0zWkMX34303y7TX5aPUq5
	 kSFj+ohdfVffexSNACB+1gql9djQo5YpyL1mw1hTAHJJv+G7hKJGZiVhQUsJ0GTN1x
	 Ldjt1AepnXOSDnkl+VC0FOJMlTkl46yWse96gQFhO2CyVK+jEMnhjUNCQcpRIikB0M
	 iqy5M2j5eSsqgBj0+tn1n/rkqmDU4c15SfZRguJVtpen+cvomBUW/v7oTOiuYKpvJL
	 9eK0Enurv6o0g==
Date: Fri, 22 Aug 2025 15:05:15 -0500
From: Rob Herring <robh@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH v3 3/4] dt-bindings: usb: microchip,usb2514: add support
 for port vbus-supply
Message-ID: <20250822200515.GA204607-robh@kernel.org>
References: <20250821-v6-16-topic-usb-onboard-dev-v3-0-6d2b38a5d818@pengutronix.de>
 <20250821-v6-16-topic-usb-onboard-dev-v3-3-6d2b38a5d818@pengutronix.de>
 <20250822-maize-elk-of-growth-2a30bb@kuoka>
 <20250822103005.c7ba7dclbgdadyw7@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822103005.c7ba7dclbgdadyw7@pengutronix.de>

On Fri, Aug 22, 2025 at 12:30:05PM +0200, Marco Felsch wrote:
> On 25-08-22, Krzysztof Kozlowski wrote:
> > On Thu, Aug 21, 2025 at 06:31:57PM +0200, Marco Felsch wrote:
> > > Some PCB designs don't connect the USB hub port power control GPIO and
> > > instead make use of a host controllable regulator. Add support for this
> > > use-case by introducing portX-vbus-supply property.
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  Documentation/devicetree/bindings/usb/microchip,usb2514.yaml | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> > > index 4e3901efed3fcd4fbbd8cb777f9df4fcadf2ca00..ac1e5f1a5ea2e66c61ce92154385952b15e78e55 100644
> > > --- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> > > @@ -49,6 +49,12 @@ patternProperties:
> > >      $ref: /schemas/usb/usb-device.yaml
> > >      additionalProperties: true
> > >  
> > > +  "^port[1-7]-vbus-supply$":
> > > +    type: object
> > > +    description:
> > > +      Regulator controlling the USB VBUS on portX. Only required if the host
> > > +      controls the portX VBUS.
> > 
> > Your commit msg should briefly describe status of previous discussion:
> > why Rob's comment was not applied. Otherwise we repeat: this looks like
> > property of specific port.
> 
> I answered Rob on my v1 but got no feedback. 

I just read it and don't understand. You don't have to have all 
properties for a driver in the node associated with the driver. The 
driver can freely look in the child nodes or anywhere else in the whole 
tree if needed. Is that what you meant?

For USB hubs we generally define child nodes for each port. Some of the 
hub bindings don't because they are incomplete. If you have a per port 
property, then the DT property belongs in the port's node.

> My v2 caused an issue found
> by Rob's test bot. Therefore I thought he is okay and applied the
> patchset for testing.

Other way around. If it doesn't pass tests, I don't look at it. (Well, I 
do, but don't expect a reply.)

> At least to me it's unclear when Rob's test bot is executed.

When you submit something. It's all automatic, though sometimes the 
emails are delayed. Results are always in PW within 1-2 hours (unless 
someone patch bombs us with a large series).

> 
> > The binding does not list ports now, but lists hard-wired devices, so my
> > question is now: is this per hard-wired device or per port (even if port
> > is hot-pluggable)?
> 
> Sorry but I don't get you. The binding lists the regulators required to
> enable/disable the hub downstream port VBUS. These regulators are
> controlled by an external party e.g. the CPU instead of the USB hub
> itself. The connection from the CPU to the regulator which controlls the
> +5V usb-connector pin is hard-wired, yes.
> 
> Regards,
>   Marco

