Return-Path: <linux-kernel+bounces-736433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED21B09CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462B65A6C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9AC2690DB;
	Fri, 18 Jul 2025 07:39:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9E422A4F6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824339; cv=none; b=SsDNFvuaIMgTKWdRJocorCJMiBim0afpCjXo5vPPdMRR80wEoWYDcSwRMPy6qIFL5XrwXT33W3ELWQAbTE4GKXHE4OaEGP+0oMkR/0Dg4Ch8Tk/egUgJVcK+gAZ4IGJWknkcKIjcCmPCyWYogwywcdY2kZ0UuyaUsTZi3CMrjIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824339; c=relaxed/simple;
	bh=kZ0savlK8hmTukJ61RLvHvHkzYy+aZT8mFDG44NLLIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+FD+gYEYpK/bC28KNjalLmL4OKrxfrM2KBqZGQdA3bX9rLGHdzvC63D9yeYA/WT+A4iWIbmDZQSJmPvMIXz1PQao6hhKUN7nF+p8QEkFn2/ujc3S1gVDO8aRw3EwAdPK4D+kr+zIej/C24KeCFhGUYeRBZDEX2O2hDFf7z572s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ucffU-0005ix-MH; Fri, 18 Jul 2025 09:38:08 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ucffP-0092TR-0n;
	Fri, 18 Jul 2025 09:38:03 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ucffP-008KaQ-0N;
	Fri, 18 Jul 2025 09:38:03 +0200
Date: Fri, 18 Jul 2025 09:38:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Divya.Koppera@microchip.com
Subject: Re: [PATCH net-next v1 1/1] Documentation: networking: add detailed
 guide on Ethernet flow control configuration
Message-ID: <aHn526JuMBpUB_T8@pengutronix.de>
References: <20250717103702.2112988-1-o.rempel@pengutronix.de>
 <aHkzEalj6tjhQX8N@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHkzEalj6tjhQX8N@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2025 at 06:29:53PM +0100, Russell King (Oracle) wrote:
> On Thu, Jul 17, 2025 at 12:37:02PM +0200, Oleksij Rempel wrote:
> > +Changing the Settings
> > +---------------------
> > +Use `ethtool -A <interface>` to change the settings.
> > +
> > +.. code-block:: bash
> > +
> > +  # Enable RX and TX pause, with autonegotiation
> > +  ethtool -A eth0 autoneg on rx on tx on
> > +
> > +  # Force RX pause on, TX pause off, without autonegotiation
> > +  ethtool -A eth0 autoneg off rx on tx off
> > +
> > +**Key Configuration Concepts**:
> > +
> > +* **Autonegotiation Mode**: The recommended mode. The driver programs the PHY
> > +    to *advertise* the `rx` and `tx` capabilities. The final active state is
> > +    determined by what both sides of the link agree on.
> 
> I'm not sure one cal call this "recommended mode", because it doesn't.
> If one specifies tx=0 rx=1, one would expect that the "recommend mode"
> would be tx=0 and rx=1, but if the link partner supports symmetric
> pause, you actually end up with tx=1 and rx=1. If the link partner
> supports only asymmetric, then you end up with tx=0 rx=1 as requested.
> 
> Perversely, if you specify tx=1 rx=1, then if the remote supports only
> asymmetric, you end up with everything disabled. Only tx=1 rx=1 is
> supported in this configuration, you can't end up with anything else.
> 
> Basically, I don't think calling it "recommended" works.

Ack, I'll drop "recommended".

Would it make sense to also add a short note about the limitations of
link-level flow control? For example, how pause frames can interfere
with traffic prioritization and QoS mechanisms.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

