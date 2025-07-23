Return-Path: <linux-kernel+bounces-742346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37575B0F060
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD00172D65
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA5C2DA74A;
	Wed, 23 Jul 2025 10:48:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96A8277815
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267707; cv=none; b=kSL5SSic13s+YEW06UrTUzDlhkTi/Y+E2TOYryPBUAQ17+dTvxrKMcbn2LT2TGxAQeO5COw7o/nNAGQi6+n9Vx2FWAeHtWy9lhEpRBzhthoNUSMynNVVYBFZrzSsP/j7XOThxobXfBMAsPY6jmB4Q2x6+7siGwZ3fiMub0XBH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267707; c=relaxed/simple;
	bh=TAHWis23G46fXp6LQc4qsXNReDqQ232ezrQAuXft++c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pid6UDb3E81sThZSGJJJXxhCDYWXtgFongEsnCgUtn+y+VyjIsVm7oq7K6ZgxK03M2WVcG3IUlBESFtcMX4K0s1efLruvfhswtjAVZARKIxY5vbwgjTwNoDaH5H9/EaE1sX1VFFLzpjuteEzN4gEDIw5bOl5ei2P3thQMAgCDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ueX13-0002Bo-H8; Wed, 23 Jul 2025 12:48:05 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ueX11-009sDo-2v;
	Wed, 23 Jul 2025 12:48:03 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ueX11-0014eb-2b;
	Wed, 23 Jul 2025 12:48:03 +0200
Date: Wed, 23 Jul 2025 12:48:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan8842
Message-ID: <aIC944gcYkfFsIRD@pengutronix.de>
References: <20250721071405.1859491-1-horatiu.vultur@microchip.com>
 <aIB0VYLqcBKVtAmU@pengutronix.de>
 <20250723090145.o2kq4vxcjrih54rt@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723090145.o2kq4vxcjrih54rt@DEN-DL-M31836.microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2025 at 11:01:45AM +0200, Horatiu Vultur wrote:
> The 07/23/2025 07:34, Oleksij Rempel wrote:
> > 
> > Hi Horatiu,
> 
> Hi Olekij,
> 
> > 
> > On Mon, Jul 21, 2025 at 09:14:05AM +0200, Horatiu Vultur wrote:
> > 
> > > +static int lan8842_config_init(struct phy_device *phydev)
> > > +{
> > > +     int val;
> > > +     int ret;
> > > +
> > > +     /* Reset the PHY */
> > > +     val = lanphy_read_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET);
> > 
> > It would be good to use defines for MMD pages.
> 
> Those are extended pages and not MMD pages. Currently in the entire
> source code I can see we used hardcoded values, also in the register
> description it looks like all these extended pages do not have really
> meaningfull names: Extended Page 0, Extended Page 4, Extended Page 5...

I'll be happy with xxxx_EXT_PAGE_0, etc 

> > > +     val = lanphy_read_page_reg(phydev, 0, LAN8842_FLF);
> > > +     if (val < 0)
> > > +             return val;
> > > +     val |= LAN8842_FLF_ENA | LAN8842_FLF_ENA_LINK_DOWN;
> > 
> > If I see it correctly, FLF support will make link fail after ~1ms, while
> > IEEE 802.3 recommends 750ms. Since a link recovery of a PHY with autoneg
> > support usually takes multiple seconds, I see the benefit for FLF
> > support only mostly for SyncE environment at same time it seems to be
> > a disadvantage for other environments.
> 
> Why would be a disadvantage?

The disadvantage in a standard network without a backup link (like one
using RSTP) comes from how the system handles recoverable, temporary
errors like a short burst of noise.

# Standard PHY Behavior (Grace Period)
When a standard 1000BASE-T link becomes unstable, the IEEE 802.3
standard requires the PHY to attempt to retrain and recover the
connection on its own. It has a timeout window of up to 750 ms to do
this, which acts as a grace period.

If the link issue was temporary and the PHY recovers within this window,
the operating system never sees a "link down" event. Applications only
experience a brief moment of packet loss, which is often handled
gracefully by protocols like TCP.

# FLF Behavior (Immediate Failure)
An FLF-enabled PHY is designed to report link instability almost
immediately (~1 ms). Instead of trying to recover silently, it
immediately reports a hard link failure to the operating system.

# The Disadvantage in a Single-Link System

For a system with only one link, this "fail-fast" approach can be a
disadvantage. Consider a short, recoverable noise burst:

- Without FLF: The PHY uses its 750 ms grace period to recover. The
link stays up, and the service interruption is limited to brief packet
loss.

- With FLF: The PHY reports "link down" after ~1 ms. The operating
system tears down the network interface. Even if the hardware recovers
quickly, the OS has to bring the interface back up, re-run DHCP, and
re-establish all application connections. This system-level recovery
often takes much longer than the original glitch.

In short, FLF can turn a minor, recoverable physical-layer glitch into a
more disruptive, longer-lasting outage at the application level when
there is no backup link to switch to.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

