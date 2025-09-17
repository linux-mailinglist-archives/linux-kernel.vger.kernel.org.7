Return-Path: <linux-kernel+bounces-820442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BCEB7E26C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 500EF4E1769
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A9A3568F1;
	Wed, 17 Sep 2025 10:12:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4035335B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103974; cv=none; b=CQug8FZZl1U/bQwmIDFQyz0CBmjzHY5+VIgL5cHpSrzU0QLQoP5KnowBo6k/5dfSNeTgoG38FjwORFw71gqt8J4/oGRJdtTxrdw8tWDOUzYykpF9xQ4ZL5zFIZhHkHhVSTVZOOxLvXr50TNwSITS+X7l9xUnRR5gbKw9D2ee6aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103974; c=relaxed/simple;
	bh=+HNLf5Nh134LRJe7Yk2RbvrVFs07+caGghRIwhbRwKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz1cwvm4M+i2ZLSH5NGplDQpjEAeOC0E0zs6JhIQwtQHXqKJcyNvJfc9+TVFbyoQr4QVedxelVxJdf3UDRKfJScVZ6OX2O4nT1ctcAwdwNHqQN7PnKOQ5IM4fXaB+OG8x2H0kNNOALsJraE4DP3aSv0/8rgR0wFjTEHLuA4j03M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uyp9E-0006bW-BM; Wed, 17 Sep 2025 12:12:24 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyp9D-001k60-0W;
	Wed, 17 Sep 2025 12:12:23 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyp9D-00DffQ-03;
	Wed, 17 Sep 2025 12:12:23 +0200
Date: Wed, 17 Sep 2025 12:12:22 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>, Rob Herring <robh@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Lukasz Majewski <lukma@denx.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Divya.Koppera@microchip.com,
	Kory Maincent <kory.maincent@bootlin.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v4 0/3] Documentation and ynl: add flow control
Message-ID: <aMqJhl2swbkiYx_p@pengutronix.de>
References: <20250909072212.3710365-1-o.rempel@pengutronix.de>
 <20250909143256.24178247@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250909143256.24178247@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2025 at 02:32:56PM -0700, Jakub Kicinski wrote:
> On Tue,  9 Sep 2025 09:22:09 +0200 Oleksij Rempel wrote:
> > This series improves kernel documentation around Ethernet flow control
> > and enhances the ynl tooling to generate kernel-doc comments for
> > attribute enums.
> > 
> > Patch 1 extends the ynl generator to emit kdoc for enums based on YAML
> > attribute documentation.
> > Patch 2 regenerates all affected UAPI headers (dpll, ethtool, team,
> > net_shaper, netdev, ovpn) so that attribute enums now carry kernel-doc.
> > Patch 3 adds a new flow_control.rst document and annotates the ethtool
> > pause/pause-stat YAML definitions, relying on the kdoc generation
> > support from the earlier patches.
> 
> The reason we don't render the kdoc today is that I thought it's far
> more useful to focus on the direct ReST generation. I think some of 
> the docs are not rendered, and other may be garbled, but the main
> structure of the documentation works quite well:
> 
>   https://docs.kernel.org/next/netlink/specs/dpll.html
> 
> Could you spell out the motivation for this change a little more?

The reason I went down the kdoc-in-UAPI route is mostly historical.
When I first started writing the flow control documentation, reviewers
pointed out that the UAPI parts should be documented in the header
files.  Since these headers are generated from YAML, the natural way was
to move  the docstrings into the YAML and let the generator emit them.
One step led  to another, and we ended up with this change.

I don’t have a strong preference for where the documentation lives, my
primary goal was to avoid duplicating text and make sure the UAPI enums
for pause / pause-stat are self-describing. If the consensus is that we
should concentrate on ReST output only, I’m happy to reduce the scope of
this series and drop the kernel-doc emission. The actual motivation of
my  series is to add flow_control.rst and document the ethtool API
there.

So if you prefer, I can respin with just the flow_control.rst and YAML  
annotations, and skip the generator changes.

Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

