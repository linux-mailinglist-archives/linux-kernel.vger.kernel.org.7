Return-Path: <linux-kernel+bounces-721269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 285DDAFC6E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D777D7A2E07
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2503220F48;
	Tue,  8 Jul 2025 09:20:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862218A6DB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751966419; cv=none; b=eiGCIlYUPncEuYtDM4D2ntMq1Dc/QP6gjTI2mPT+XAlgGbhuS+mYOWe44zh3wGQc5QhLQ9cPolGkAKCgVjUwZr5ZoYF9mtSVY+d0ExzB6lBRlVl7iosZGFa0qf73gZJ4Qf2KGf5oJHxkoMXVnJjB3vlk/J/GFGbevCUwe4PfxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751966419; c=relaxed/simple;
	bh=X1ap/8oSHd5+obaob3rFdSeiHkv9x2Z/zC908cdecSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFAXJpYyQLE3jI0SsrXRrgvJxBC2gJo6EnBIVhs8EVWnPBi5qhmjjx2zPMwUiQvBWfNPdTZJpdxArYMUDa+25sh5/XjKthNvWKehGWv99rp7mOz1xN87+lPiVG5wmUsm3syAzuHzBLIQyoc4fDlks/8zCZdI51TpA4kiYVWP1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uZ4UP-0004wf-Tu; Tue, 08 Jul 2025 11:19:49 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZ4UN-007OMx-2N;
	Tue, 08 Jul 2025 11:19:47 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uZ4UN-007sDz-1t;
	Tue, 08 Jul 2025 11:19:47 +0200
Date: Tue, 8 Jul 2025 11:19:47 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>
Subject: Re: [PATCH net v1 2/2] net: phy: smsc: add adaptive polling to
 recover missed link-up on LAN8700
Message-ID: <aGziszwhN1dykeks@pengutronix.de>
References: <20250707153232.1082819-1-o.rempel@pengutronix.de>
 <20250707153232.1082819-3-o.rempel@pengutronix.de>
 <aGwNnBJbM9LWnJ8f@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aGwNnBJbM9LWnJ8f@wunner.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Jul 07, 2025 at 08:10:36PM +0200, Lukas Wunner wrote:
> > Mitigate this by combining interrupts with adaptive polling:
> > 
> > - When the driver is running in pure polling mode it continues to poll
> >   once per second (unchanged).
> > - With an IRQ present we now
> >   - poll every 30 s while the link is up (low overhead);
> >   - switch to a 1 s poll for up to 30 s after the last IRQ and while the
> >     link is down, ensuring we catch the final silent link-up.
> 
> I think this begs the question, if we *know* that the link may come up
> belatedly without an interrupt, why poll?  Would it work to schedule a
> one-off link check after a reasonable delay to catch the link change?

The exact timing of the link-up depends on the link partner. For
example, when testing with an Intel i350, the longest observed link-up
time was 3.85 seconds. But I cannot measure all possible combinations of
PHYs and link partners, and some might take even longer.

If we use a one-shot delayed check, we would have to wait at least 5
seconds to be safe-maybe more. This would increase the link-up time for
most users, even in cases where the link is already up earlier. So the
user experience would get worse, without guaranteeing we catch all
cases.

That’s why I decided to go with a conservative 1 Hz polling for 30
seconds after the last interrupt. This keeps the link-up time short when
possible, and also helps detect obscure link changes that may otherwise
go unnoticed.

> I'm also wondering if enabling EDPD changes the behavior?

This is not straightforward to test. The PHY driver explicitly requires
polling mode for EDPD support, so when EDPD is enabled, polling is
already active. In that case, the missing IRQ issue is avoided by
design, because the PHY state machine runs regularly regardless of
interrupts. So enabling EDPD indirectly works around the problem, but
not because it changes the PHY behavior-just because it activates
polling.

> > +static unsigned int smsc_phy_get_next_update(struct phy_device *phydev)
> > +{
> > +	struct smsc_phy_priv *priv = phydev->priv;
> > +
> > +	/* If interrupts are disabled, fall back to default polling */
> > +	if (phydev->irq == PHY_POLL)
> > +		return SMSC_NOIRQ_POLLING_INTERVAL;
> > +
> > +	/* The PHY sometimes drops the *final* link-up IRQ when we run
> > +	 * with autoneg OFF (10 Mbps HD/FD) against an autonegotiating
> > +	 * partner: we see several "link down" IRQs, none for "link up".
> 
> Hm, I'm not seeing a check for all those conditions (e.g. autoneg off) here?

You're right, I'm not checking explicitly for autoneg == off or speed ==
10 in the code. I chose not to limit it to just that case, because if
IRQ behavior is unreliable in one configuration, it's possible that
other cases may also be affected in less obvious ways.

Polling once per second for 30 seconds is a small cost in terms of
power, but it greatly reduces the risk of missing a link-up event. In my
opinion, it's a safer default and avoids user-visible issues without
significantly impacting energy usage.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

