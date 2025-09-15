Return-Path: <linux-kernel+bounces-816523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE54FB574F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEE4440F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B492EF665;
	Mon, 15 Sep 2025 09:31:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA092D2488
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928696; cv=none; b=g+1Gbbgbd3t8yFnBHIfULqS86O0CZ9vYF7x+fMhdLp3RExEkLRhnJrqgSTetLQkgyUoAuV+czVRRJ0kS2UTcvK1U7azNOyUnHSJFVcjv+7HSsVZkEq3LCndJPRUOTuns6XA3O1IZyUe+GOLC4RPPYkQi5mT7gD9T0yeg2xsaJvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928696; c=relaxed/simple;
	bh=OGXyjUvYK5vmnEp5jqa+n3SQ1w1v/lwJlIt5A/daJNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5pjzjBYvvcTLqyyLjOcFhRqJ50adq8R7tlrzXpcOmYtrwlSoSy+92Y7xkrM8/fS7I04mqHqduAUKFE1ZSzqQMOu93msiyHWRcG99bvzAoKn2fVR3E/pXNOoLsjxwKHjnZyxdH4YqqIDFLh44WDaSzm6WNeAAjyVZMcPlOAgO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uy5Xz-0000Vh-8o; Mon, 15 Sep 2025 11:30:55 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uy5Xw-001Och-13;
	Mon, 15 Sep 2025 11:30:52 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uy5Xw-009L6r-0X;
	Mon, 15 Sep 2025 11:30:52 +0200
Date: Mon, 15 Sep 2025 11:30:52 +0200
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
Subject: Re: [PATCH net-next v5 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <aMfczCuRf0bm2GgQ@pengutronix.de>
References: <20250908124610.2937939-1-o.rempel@pengutronix.de>
 <20250908124610.2937939-3-o.rempel@pengutronix.de>
 <20250911193440.1db7c6b4@kernel.org>
 <aMPw7kUddvGPJCzx@pengutronix.de>
 <20250912170053.24348da3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250912170053.24348da3@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2025 at 05:00:53PM -0700, Jakub Kicinski wrote:
> On Fri, 12 Sep 2025 12:07:42 +0200 Oleksij Rempel wrote:
> > > > +      -
> > > > +        name: max-average-mse
> > > > +        type: u32
> > > > +      -
> > > > +        name: max-peak-mse
> > > > +        type: u32
> > > > +      -
> > > > +        name: refresh-rate-ps
> > > > +        type: u64
> > > > +      -
> > > > +        name: num-symbols
> > > > +        type: u64  
> > > 
> > > type: uint for all these?  
> > 
> > I would prefer to keep u64 for refresh-rate-ps and num-symbols.
> > 
> > My reasoning comes from comparing the design decisions of today's industrial
> > hardware to the projected needs of upcoming standards like 800 Gbit/s. This
> > analysis shows that future PHYs will require values that exceed the limits of a
> > u32.
> 
> but u64 may or may not also have some alignment expectations, which uint
> explicitly excludes

just to confirm - if we declare an attribute as type: uint in the YAML
spec, the kernel side can still use nla_put_u64() to send a 64-bit
value, correct? My understanding is that uint is a flexible integer
type, so userspace decoders will accept both 4-byte and 8-byte encodings
transparently.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

