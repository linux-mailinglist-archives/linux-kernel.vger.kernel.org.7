Return-Path: <linux-kernel+bounces-810373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FEBB51964
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6197189B583
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAB132A80B;
	Wed, 10 Sep 2025 14:30:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DAE324B25
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514657; cv=none; b=IoQCWvTgcOLne+nUlt9J3rg4PSdfPs7YCJA4OiXPP2wtb6Cr/mvMv29SFH8sdwSpFHScfoxe+MII2aaqYJrNZnjlIpjzGnP09K5qbc2iUyAuu1z6SKkLUVDu8EUCBKgm/Pmyc3jBvu5FAJveCI2yCClgN+0D5UNLWS90iS7bcHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514657; c=relaxed/simple;
	bh=G1Aaivtu3qjtIaWwq2xO2UzCmo8ur1SlqjoB88xSAis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8vf70JpBLTECWMBVuz1efXCG1jFGtLq/ae2sBXWUqwweBaWTW0DeMjzR9dAWrwciHhTOe2RIxU2O4TcLeCwHuy85dLizw6O4SBqdfhUnj0QXExiaQN8fHV7SzDu8Vdeshj0TzW0M6giY5o0ldEcjJ5a2AnvvLSGTQdfoo79Ug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwLqQ-00075Z-3V; Wed, 10 Sep 2025 16:30:46 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwLqO-000beC-2I;
	Wed, 10 Sep 2025 16:30:44 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1uwLqO-00GHZB-1j;
	Wed, 10 Sep 2025 16:30:44 +0200
Date: Wed, 10 Sep 2025 16:30:44 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Jonas Rebmann <jre@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/4] dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios
 property
Message-ID: <20250910143044.jfq5fsv2rlsrr5ku@pengutronix.de>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
 <20250910-imx8mp-prt8ml-v1-1-fd04aed15670@pengutronix.de>
 <20250910125611.wmyw2b4jjtxlhsqw@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910125611.wmyw2b4jjtxlhsqw@skbuf>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-09-10, Vladimir Oltean wrote:
> On Wed, Sep 10, 2025 at 02:35:21PM +0200, Jonas Rebmann wrote:
> > Both the nxp,sja1105 and the nxp,sja1110 series feature an active-low
> > reset pin, rendering reset-gpios a valid property for all of the
> > nxp,sja1105 family.
> > 
> > Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> > index 9432565f4f5d..8f4ef9d64556 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> > @@ -32,6 +32,11 @@ properties:
> >    reg:
> >      maxItems: 1
> > 
> > +  reset-gpios:
> > +    description:
> > +      GPIO to be used to reset the whole device
> > +    maxItems: 1
> > +
> >    spi-cpha: true
> >    spi-cpol: true
> > 
> > 
> > --
> > 2.51.0.178.g2462961280
> >
> 
> There are multiple issues with the reset line and I was considering
> dropping driver support for it.
> 
> The most important issue is the fact that, according to NXP document
> AH1704, the RST_N signal has to be kept asserted for 5 us after power-on
> reset. That is hard to achieve if this pin is routed to an SoC GPIO.

Can you please elaborate a bit more? I was curious and checked the
AH1704, it says:

"The RST_N signal must be kept low for at least 5 us after all power
supplies and reference clock signals become stable."

This is very common, so the driver only needs to ensure that the pin was
pulled low for at least 5us but not exact 5us.

> Additionally, routing the reset signal to a host SoC GPIO does not bring
> any particular benefit, since the switch can be (and is) also reset by
> the driver over SPI.

I don't know the switch but it's also common that a so called
software-reset may not reset all registers, state machines, etc.

There it's common practice that the driver tries to pull the hw reset
line and if not present falls back to a software reset.

> So, at least for this particular switch, having a "reset-gpios" actively
> points towards a potential violation of its POR timing requirements.

Really? Please see my above comment.

> That is, unless the power rails are also software-controlled. But they
> aren't.

AH1704 Fig.10 just illustrate a reset and power-on sequence. I highly
doubt that the host can't pull the hw rest line if the supplies and the
clock is already running.

You're right about the fact that the driver is currently not able to do
a proper power-on sequence, so the kernel relies on the prev. firmware
or the hw-setup. But this is another problem.

Regards,
  Marco

