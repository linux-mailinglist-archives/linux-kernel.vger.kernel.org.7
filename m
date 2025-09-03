Return-Path: <linux-kernel+bounces-799522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAFBB42D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A47A547A78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0562EFDB0;
	Wed,  3 Sep 2025 22:57:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0477C2EDD75
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756940273; cv=none; b=HNBOfuX2mPGvJ+N0uGVGEPuScmqhKGOZdjfFoc/uWo2HxsBqAaArVAewvB8zDyNHNpnFOd58UDkE/j/mGYYfaUPEoxL3yL8p+JcCE4TG4BXYM6cK8TCxdcbPdaUzCvNI1EU48uSklZ9YCCfhwZLZg4+qnJijqs8km++JO+vS7sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756940273; c=relaxed/simple;
	bh=7ZCx4CH/nMDIQM6h0Tdqbvb3yVRC6/7a48WxJlNL5uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZkQ2gZ9o5hs4onKKlaPCMPYGE0tncv2Ej3g+eJpKfAkpHOnwoaCq01FeyZUiVCgaWBJ59/8ShmHFLOB621o7JgHpzwK764qFSRTW6YoU9PcpK8OaOxEuG8aWAUzrhNtBPNCK3JgA7lnMH2oCv3BPDuxWpNsIplu/ekCgGRMTl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1utwQ2-0002jI-LW; Thu, 04 Sep 2025 00:57:34 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1utwQ2-003dBR-0q;
	Thu, 04 Sep 2025 00:57:34 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1utwQ2-0008ir-0M;
	Thu, 04 Sep 2025 00:57:34 +0200
Date: Thu, 4 Sep 2025 00:57:34 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Rob Herring <robh@kernel.org>
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
Message-ID: <20250903225734.yfu5gvsclcxr4wge@pengutronix.de>
References: <20250821-v6-16-topic-usb-onboard-dev-v3-0-6d2b38a5d818@pengutronix.de>
 <20250821-v6-16-topic-usb-onboard-dev-v3-3-6d2b38a5d818@pengutronix.de>
 <20250822-maize-elk-of-growth-2a30bb@kuoka>
 <20250822103005.c7ba7dclbgdadyw7@pengutronix.de>
 <20250822200515.GA204607-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822200515.GA204607-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-08-22, Rob Herring wrote:
> On Fri, Aug 22, 2025 at 12:30:05PM +0200, Marco Felsch wrote:
> > On 25-08-22, Krzysztof Kozlowski wrote:
> > > On Thu, Aug 21, 2025 at 06:31:57PM +0200, Marco Felsch wrote:
> > > > Some PCB designs don't connect the USB hub port power control GPIO and
> > > > instead make use of a host controllable regulator. Add support for this
> > > > use-case by introducing portX-vbus-supply property.
> > > > 
> > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > ---
> > > >  Documentation/devicetree/bindings/usb/microchip,usb2514.yaml | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> > > > index 4e3901efed3fcd4fbbd8cb777f9df4fcadf2ca00..ac1e5f1a5ea2e66c61ce92154385952b15e78e55 100644
> > > > --- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> > > > +++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
> > > > @@ -49,6 +49,12 @@ patternProperties:
> > > >      $ref: /schemas/usb/usb-device.yaml
> > > >      additionalProperties: true
> > > >  
> > > > +  "^port[1-7]-vbus-supply$":
> > > > +    type: object
> > > > +    description:
> > > > +      Regulator controlling the USB VBUS on portX. Only required if the host
> > > > +      controls the portX VBUS.
> > > 
> > > Your commit msg should briefly describe status of previous discussion:
> > > why Rob's comment was not applied. Otherwise we repeat: this looks like
> > > property of specific port.
> > 
> > I answered Rob on my v1 but got no feedback. 
> 
> I just read it and don't understand. You don't have to have all 
> properties for a driver in the node associated with the driver. The 
> driver can freely look in the child nodes or anywhere else in the whole 
> tree if needed. Is that what you meant?
> 
> For USB hubs we generally define child nodes for each port. Some of the 
> hub bindings don't because they are incomplete. If you have a per port 
> property, then the DT property belongs in the port's node.

The problem was, that the regulator API didn't supported to search for
regulators which don't belong to its own DT node.

I wasn't sure if this is intented or not. Now I see that, the regulator
API gained the support for this use-case else I would have pinged Mark
if we need to add support for it.

I will change the "vbus-supply" to be specified within the port DT
nodes.

> > My v2 caused an issue found
> > by Rob's test bot. Therefore I thought he is okay and applied the
> > patchset for testing.
> 
> Other way around. If it doesn't pass tests, I don't look at it. (Well, I 
> do, but don't expect a reply.)

Okay, thanks for the clarification.

> > At least to me it's unclear when Rob's test bot is executed.
> 
> When you submit something. It's all automatic, though sometimes the 
> emails are delayed. Results are always in PW within 1-2 hours (unless 
> someone patch bombs us with a large series).

Thanks.

Regards,
  Marco

