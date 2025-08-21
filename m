Return-Path: <linux-kernel+bounces-779505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8005B2F4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3022A1C23419
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F182E9743;
	Thu, 21 Aug 2025 10:16:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF30C21770C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771366; cv=none; b=gKGnVJjhra2BIixgDqlwYCqGxtrAMoGGvDTtxVykgCCgkSCDYsCQVqlfBsa2zAk6q5u4JbSBsO1sfp5FrNEHrYyIWZmqfMfLWLEdBzfiSNrCVBFrXJe5kbAV3WceqW4h2PtmTbf7WsWs0pWbwH7soDhv1Sy4E1kj8tdygbZg4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771366; c=relaxed/simple;
	bh=GBwCNdsSPTgkl6+MZ/58UzFmAiMnptb1wekxJ049+9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHajzmVQZbxG/f7f66SCXg/gVfAviA+JykrmeDfM5UnDZ3nVROlI5v6Z/efY6xVaDwRcUCiaQy3oV/tnD/VIq2U9BauPpU5nBF3WvMwiKqyWPc8OUkwxH7og6NrJglQdZtmyr+EtSWMenWkpdDqRGEMn16sjdU4t2xfuy6WONy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1up2Kk-0001Yg-Jm; Thu, 21 Aug 2025 12:15:50 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1up2Ki-001OYX-0t;
	Thu, 21 Aug 2025 12:15:48 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1up2Ki-00805O-0T;
	Thu, 21 Aug 2025 12:15:48 +0200
Date: Thu, 21 Aug 2025 12:15:48 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nishanth Menon <nm@ti.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk <roan@protonic.nl>
Subject: Re: [PATCH net-next v4 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <aKbx1EoO0iWe2bMU@pengutronix.de>
References: <20250821091101.1979201-1-o.rempel@pengutronix.de>
 <20250821091101.1979201-3-o.rempel@pengutronix.de>
 <20250821115830.3a231885@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250821115830.3a231885@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Kory,

On Thu, Aug 21, 2025 at 11:59:14AM +0200, Kory Maincent wrote:
> Hello Oleksij,
> 
> Le Thu, 21 Aug 2025 11:10:58 +0200,
> Oleksij Rempel <o.rempel@pengutronix.de> a écrit :
> 
> > Introduce the userspace entry point for PHY MSE diagnostics via
> > ethtool netlink. This exposes the core API added previously and
> > returns both configuration and one or more snapshots.
> > 
> > Userspace sends ETHTOOL_MSG_MSE_GET with an optional channel
> > selector. The reply carries:
> >   - ETHTOOL_A_MSE_CONFIG: scale limits, timing, and supported
> >     capability bitmask
> >   - ETHTOOL_A_MSE_SNAPSHOT+: one or more snapshots, each tagged
> >     with the selected channel
> > 
> > If no channel is requested, the kernel returns snapshots for all
> > supported selectors (per‑channel if available, otherwise WORST,
> > otherwise LINK). Requests for unsupported selectors fail with
> > -EOPNOTSUPP; link down returns -ENOLINK.
> > 
> > Changes:
> >   - YAML: add attribute sets (mse, mse-config, mse-snapshot) and
> >     the mse-get operation
> >   - UAPI (generated): add ETHTOOL_A_MSE_* enums and message IDs,
> >     ETHTOOL_MSG_MSE_GET/REPLY
> >   - ethtool core: add net/ethtool/mse.c implementing the request,
> >     register genl op, and hook into ethnl dispatch
> >   - docs: document MSE_GET in ethtool-netlink.rst
> > 
> > The include/uapi/linux/ethtool_netlink_generated.h is generated
> > from Documentation/netlink/specs/ethtool.yaml.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> ...
> 
> > +MSE Configuration
> > +-----------------
> > +
> > +This nested attribute contains the full configuration properties for the MSE
> > +measurements
> > +
> > +  ===============================================  ======
> > ====================
> > +  ETHTOOL_A_MSE_CONFIG_MAX_AVERAGE_MSE             u32     max avg_mse scale
> > +  ETHTOOL_A_MSE_CONFIG_MAX_PEAK_MSE                u32     max peak_mse scale
> > +  ETHTOOL_A_MSE_CONFIG_REFRESH_RATE_PS             u64     sample rate (ps)
> > +  ETHTOOL_A_MSE_CONFIG_NUM_SYMBOLS                 u64     symbols per sample
> > +  ETHTOOL_A_MSE_CONFIG_SUPPORTED_CAPS              bitset  capability bitmask
> > +  ===============================================  ======
> > ==================== +
> 
> Why did you remove the kernel doc identifiers to phy_mse_config?
> It was useful for the documentation.
> 
> > +MSE Snapshot
> > +------------
> > +
> > +This nested attribute contains an atomic snapshot of MSE values for a
> > specific +channel or for the link as a whole.
> > +
> > +  ===============================================  ======
> > ======================
> > +  ETHTOOL_A_MSE_SNAPSHOT_CHANNEL                   u32     channel enum value
> > +  ETHTOOL_A_MSE_SNAPSHOT_AVERAGE_MSE               u32     average MSE value
> > +  ETHTOOL_A_MSE_SNAPSHOT_PEAK_MSE                  u32     current peak MSE
> > +  ETHTOOL_A_MSE_SNAPSHOT_WORST_PEAK_MSE            u32     worst-case peak
> > MSE
> > +  ===============================================  ======
> 
> Same question here for phy_mse_snapshot.

I had following warnings:
Documentation/networking/ethtool-netlink:2499: ./include/linux/phy.h:3: WARNING: Duplicate C declaration, also defined at kapi:892. 
Declaration is '.. c:struct:: phy_mse_config'. 
Documentation/networking/ethtool-netlink:2515: ./include/linux/phy.h:3: WARNING: Duplicate C declaration, also defined at kapi:915.
Declaration is '.. c:struct:: phy_mse_snapshot'

I didn't found proper was to solve it, so I removed them.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

