Return-Path: <linux-kernel+bounces-878133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDB9C1FDBA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86933342AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DABD33C530;
	Thu, 30 Oct 2025 11:41:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731EA5695
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824465; cv=none; b=WSCQiWo21FvWMl54prGUjNxqm1Mdm020mQmz7M4DbgPcaVg9nSDKmVDB+K+McE2AosFJ+WT7JCQ64Znb9iacXi7pLv6qtkSfczlH/r6dqb1g7egWwik6JW2vAgotGcbHEhJmjtJ4OsbEXdWh6NuRzJ05hCruFxW5sLYsiKU4lh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824465; c=relaxed/simple;
	bh=lZKo9fp4728vlExsBM5BJnKwNB7fqUa1ufmGk3S8KXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCRu7WG02jvziy9JS29vsSSP571BLMdY6BudKyBqgG66cvrswUZMWfzZ/6upx3/DhLgV+mXxRSZtk4zCX5O4OQgLaAIymdp4ta4EMcE7tYY35fkplsE0ciyhwv3LMac7xXtlWrQv6H430ZYr4iJFbY+y2RBcFNnmTqxU4eTbUis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vER1M-0004mR-8i; Thu, 30 Oct 2025 12:40:48 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vER1J-006CfY-2A;
	Thu, 30 Oct 2025 12:40:45 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vER1J-008sMp-1j;
	Thu, 30 Oct 2025 12:40:45 +0100
Date: Thu, 30 Oct 2025 12:40:45 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
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
Subject: Re: [PATCH net-next v8 2/4] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <aQNOvYzUH8OEbw8d@pengutronix.de>
References: <20251027122801.982364-1-o.rempel@pengutronix.de>
 <20251027122801.982364-3-o.rempel@pengutronix.de>
 <4dc6ca34-d6c5-4eec-87b3-31a6b7fba2f8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dc6ca34-d6c5-4eec-87b3-31a6b7fba2f8@redhat.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Oct 30, 2025 at 12:04:11PM +0100, Paolo Abeni wrote:
> On 10/27/25 1:27 PM, Oleksij Rempel wrote:
> > Introduce the userspace entry point for PHY MSE diagnostics via
> > ethtool netlink. This exposes the core API added previously and
> > returns both capability information and one or more snapshots.
> > 
> > Userspace sends ETHTOOL_MSG_MSE_GET. The reply carries:
> > - ETHTOOL_A_MSE_CAPABILITIES: scale limits and timing information
> > - ETHTOOL_A_MSE_CHANNEL_* nests: one or more snapshots (per-channel
> >   if available, otherwise WORST, otherwise LINK)
> > 
> > Link down returns -ENETDOWN.
> > 
> > Changes:
> >   - YAML: add attribute sets (mse, mse-capabilities, mse-snapshot)
> >     and the mse-get operation
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
> > ---
> > changes v8:
> > - drop user-space channel selector; kernel always returns available selectors
> 
> Overall LGTM, but it's unclear why you dropped the above. I understand
> one of the goal here is to achieve fast data retrival. I _guess_ most of
> the overhead is possibly due to phy regs access. Explicitly selecting a
> single/limited number of channels could/should reduce the number of
> registers access; it looks like a worthy option. What am I missing?

Yes the goal was fast data retrieval. However, I realized the initial
channel selector was just a guess at the right optimization.

My concern is that the channel selector do not fully achieve the goal.
While reading metrics from just one channel is an advantage, the
optimization could be much better if we also allowed reading only one
metric from that channel, instead of all of them.

So, rather than push another half-guess, I decided it is safer to
remove this part of the interface entirely for now. Once we have data on
where the actual performance bottlenecks are, we can design and add a
filter that solves the right problem.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

