Return-Path: <linux-kernel+bounces-813697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA30B54998
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1FE1CC44F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BBC2E8B6C;
	Fri, 12 Sep 2025 10:21:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83572E06C3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672488; cv=none; b=SVJDgLKhD3Uqjc9T4pxCnCByVgdgPoFZb203hhSXz2GbjoqueRlF8uQcBvSYtE4WTLm5gdGTqy1uE/rLBkxyzQ1qz6uLWUbXyMQVydyIzGuZA9UOtskEZfTIoosSs9GZqkSlFIgBZv7lIYP/+xFLLui46op8oW0F3PFI3f7ss5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672488; c=relaxed/simple;
	bh=092SCxL+WXvHZnvLVti8MYwhjgwjoVdrX7KAmDB8X3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBi+Qi70eYuFWKB3N5Z7eiUcP1fxDhhzP/0ZaUFNzHYVz9rizgrQ29pEJS+IHfHd5aEFIKrbx4YK0e/1xMozZblfZI8IzbHu/MD2xwNGHip+JQEUq0c9ZX3s8nobSem28/MfkvQa4yo2mJ9BnrAKnAY5DV8/r1iASNsVgEpDa4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ux0u0-0004ZG-IF; Fri, 12 Sep 2025 12:21:12 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ux0tz-000uni-1k;
	Fri, 12 Sep 2025 12:21:11 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ux0tz-002ye5-1K;
	Fri, 12 Sep 2025 12:21:11 +0200
Date: Fri, 12 Sep 2025 12:21:11 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nishanth Menon <nm@ti.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk <roan@protonic.nl>
Subject: Re: [PATCH net-next v5 1/5] ethtool: introduce core UAPI and driver
 API for PHY MSE diagnostics
Message-ID: <aMP0F0NVrIHk7jBY@pengutronix.de>
References: <20250908124610.2937939-1-o.rempel@pengutronix.de>
 <20250908124610.2937939-2-o.rempel@pengutronix.de>
 <20250911192318.0628831f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911192318.0628831f@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2025 at 07:23:18PM -0700, Jakub Kicinski wrote:
> On Mon,  8 Sep 2025 14:46:06 +0200 Oleksij Rempel wrote:
> > Add the base infrastructure for Mean Square Error (MSE) diagnostics,
> > as proposed by the OPEN Alliance "Advanced diagnostic features for
> > 100BASE-T1 automotive Ethernet PHYs" [1] specification.
> > 
> > The OPEN Alliance spec defines only average MSE and average peak MSE
> > over a fixed number of symbols. However, other PHYs, such as the
> > KSZ9131, additionally expose a worst-peak MSE value latched since the
> > last channel capture. This API accounts for such vendor extensions by
> > adding a distinct capability bit and snapshot field.
> > 
> > Channel-to-pair mapping is normally straightforward, but in some cases
> > (e.g. 100BASE-TX with MDI-X resolution unknown) the mapping is ambiguous.
> > If hardware does not expose MDI-X status, the exact pair cannot be
> > determined. To avoid returning misleading per-channel data in this case,
> > a LINK selector is defined for aggregate MSE measurements.
> > 
> > All investigated devices differ in MSE configuration parameters, such
> > as sample rate, number of analyzed symbols, and scaling factors.
> > For example, the KSZ9131 uses different scaling for MSE and pMSE.
> > To make this visible to userspace, scale limits and timing information
> > are returned via get_mse_config().
> 
> But the parameter set is set by the standard? If not we should annotate
> which one is and which isn't.

Do you mean we should show which parameters are defined by a standard
(for example Open-Alliance - MSE/pMSE) or which parts of the measurement
method - like how many samples in what time - are vendor or product
specific?

And should we only write this in comments/docs, or add a flag/enum so
user space can detect it?

> > +  -
> > +    name: phy-mse-capability
> > +    doc: |
> > +      Bitmask flags for MSE capabilities.
> > +
> > +      These flags are used in the 'supported_caps' field of struct
> > +      phy_mse_config to indicate which measurement capabilities are supported
> > +      by the PHY hardware.
> > +    type: flags
> > +    name-prefix: phy-mse-cap-
> > +    entries:
> > +      -
> > +        name: avg
> > +        doc: Average MSE value is supported.
> > +      -
> > +        name: peak
> > +        doc: Current peak MSE value is supported.
> > +      -
> > +        name: worst-peak
> > +        doc: Worst-case peak MSE (latched high-water mark) is supported.
> > +      -
> > +        name: channel-a
> > +        doc: Diagnostics for Channel A are supported.
> > +      -
> > +        name: channel-b
> > +        doc: Diagnostics for Channel B are supported.
> > +      -
> > +        name: channel-c
> > +        doc: Diagnostics for Channel C are supported.
> > +      -
> > +        name: channel-d
> > +        doc: Diagnostics for Channel D are supported.
> > +      -
> > +        name: worst-channel
> > +        doc: |
> > +          Hardware or drivers can identify the single worst-performing channel
> > +          without needing to query each one individually.
> > +      -
> > +        name: link
> > +        doc: |
> > +          Hardware provides only a link-wide aggregate MSE or cannot map
> > +          the measurement to a specific channel/pair. Typical for media where
> > +          the MDI/MDI-X resolution or pair mapping is unknown (e.g. 100BASE-TX).
> 
> Should we invert the order here? I think it's more likely we'd
> encounter new statistical measures rather than new channels.
> So channels should go first, and then the measures?

ack, sounds good.

> > +  -
> > +    name: phy-mse-channel
> > +    doc: |
> > +      Identifiers for the 'channel' parameter used to select which diagnostic
> > +      data to retrieve.
> > +    type: enum
> > +    name-prefix: phy-mse-channel-
> > +    entries:
> > +      -
> > +        name: a
> > +        value: 0
> 
> Don't enums default to starting from 0?  I think setting value is unnecessary

ack.

> > +        doc: Request data for channel A.
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

