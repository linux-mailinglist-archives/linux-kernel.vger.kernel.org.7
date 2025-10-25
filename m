Return-Path: <linux-kernel+bounces-869780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5958C08B90
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 07:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504DF3A7D60
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 05:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC10F2C0F70;
	Sat, 25 Oct 2025 05:37:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA3A23EAA1
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 05:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761370667; cv=none; b=QIgpWeAaFiz8rez1GuYdldRHUHKjsVaOO3fvw6K67BSHQ3+OT5r3OrpALLw7awKLe6zlLYXHFsu+fgiIx1UwKGW1wF6zMOqNH3ikpM/ZuKVRt9gQLrCzTQ6MGg0NjGH0/rDnf0yrMEv9I5HCUixzWVWZPOZ/wWsz04x1QgpeSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761370667; c=relaxed/simple;
	bh=3ek6W1mOhWcu4a+L94jPiS6unr23TPjMvZqPvfl7OIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnRYxpmxsfbnbpKR/cbCtqDuSPeaIlgUItYuhMiQ2clnzv2dyZNVuuJijId9bI0q3jn4VfL4JCrVPjclpY3SRwCpK7N/sMcsp+RXhSP6BtaY/hlv6ZXn19kuNpDjAfWD+YkOLMoLRoCZQY+fO8f668UfQNR5kS23zuXWSRd3U6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vCWxs-00026D-FF; Sat, 25 Oct 2025 07:37:20 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vCWxp-005LEj-15;
	Sat, 25 Oct 2025 07:37:17 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vCWxp-00GypS-0Y;
	Sat, 25 Oct 2025 07:37:17 +0200
Date: Sat, 25 Oct 2025 07:37:17 +0200
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
Subject: Re: [PATCH net-next v7 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <aPxiDazeEsR1lkgK@pengutronix.de>
References: <20251020103147.2626645-1-o.rempel@pengutronix.de>
 <20251020103147.2626645-3-o.rempel@pengutronix.de>
 <20251023181343.30e883a4@kernel.org>
 <aPt8jAXU0l1f2zPG@pengutronix.de>
 <20251024161213.2ed58127@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024161213.2ed58127@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Jakub,

On Fri, Oct 24, 2025 at 04:12:13PM -0700, Jakub Kicinski wrote:
> On Fri, 24 Oct 2025 15:18:04 +0200 Oleksij Rempel wrote:
> > Hi Jakub,
> > 
> > On Thu, Oct 23, 2025 at 06:13:43PM -0700, Jakub Kicinski wrote:
> > > On Mon, 20 Oct 2025 12:31:44 +0200 Oleksij Rempel wrote:  
> > > > +      -
> > > > +        name: supported-caps
> > > > +        type: nest
> > > > +        nested-attributes: bitset
> > > > +        enum: phy-mse-capability  
> > > 
> > > This is read only, does it really have to be a bitset?  
> > 
> > It describes the capabilities of the driver/hardware. You can get always
> > everything... Hm... I think we continue without capabilities for now and
> > also remove the specific channel request.
> 
> That's not what I'm saying. I'm just saying that it could be a basic
> uint with appropriate enum rather than bitset? At least with YNL its
> much easier to deal with. The main advantage of bitset is that you
> can modify individual bits, but that doesn't apply to read-only fields.
> 
> Sorry if I'm confused.

after discussing this with Marc Kleine-Budde, I realized that the current
MSE interface is not fully thought through.

Right now the interface lets user space select a specific channel to
poll, but that's not the only relevant selector. Each channel can expose
multiple metrics, and if we ever want to reduce the amount of data for
faster polling, we'll need a different, flag-based selector to describe
which parameters to fetch.

At the moment, however, the kernel simply returns all information that
the PHY can provide. In this situation, the capability flags are mostly
useful inside the kernel, but redundant for user space - we already
provide the values themselves, so there's no need for an extra
"supported-caps" flag set. They duplicate what the user already sees in
the reply (we have a value, and a flag telling that we have this value).

Still, user space needs part of the capabilities structure - the scale
and timing information (max-MSE ranges, refresh rate, number of symbols)
- to interpret the results and choose an appropriate polling rate.

So for the next revision I plan to:
- drop the user-space channel selector completely (the kernel will always
  return all available channels),
- remove the capability bitset from the UAPI,
- keep only the scale/timing fields in the capabilities nest,
- retain capability flags internally in the PHY API for kernel use.

Thanks,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

