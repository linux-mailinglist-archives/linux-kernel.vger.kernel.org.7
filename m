Return-Path: <linux-kernel+bounces-620689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E52A9CE2F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 18:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC334C6258
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D147686342;
	Fri, 25 Apr 2025 16:31:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29897194A60
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745598692; cv=none; b=M0U6I/QEpRuDsHSM29OTe0Tz/GxxHhZexmCS/ts++PZBRRCRBjBXFXmx4RLGRopf+xl97Y3AUwk1ZIb9/Wbvl2qlrw3YzhZFpqaw/QFOGGk9EW99zFcMwqQwC8nmKNcE6fzS6IYUffYy9iY6fGCefCVjL3OuhixcEp5Q1bAVLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745598692; c=relaxed/simple;
	bh=umv34Omx9kG30FPHmNxsuOEzQrw097DD64u5IOzgDpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0Rf+mUUzyOWOcUjW0oJ1StHmXWKqwW8fK2UhA6K4z55gaNnJoXn1DjO8F9dD/x44md1aXhyVtIN6ZdcOhj7FYJS/m8dKE6jIMRwneQM9uFY7lx5TBIlcQ+6Pi2D6tKYhvlLg5w3kouo9c5uk7GEbh8Qlk+lggAUhr5SZTJWVSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1u8LxP-00018y-Lt; Fri, 25 Apr 2025 18:31:19 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u8LxO-0024b5-0u;
	Fri, 25 Apr 2025 18:31:18 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1u8LxO-003Kor-0S;
	Fri, 25 Apr 2025 18:31:18 +0200
Date: Fri, 25 Apr 2025 18:31:18 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v2 1/1] net: dsa: microchip: Remove ineffective
 checks from ksz_set_mac_eee()
Message-ID: <aAu41tjRIir8oMK7@pengutronix.de>
References: <20250425110845.482652-1-o.rempel@pengutronix.de>
 <aAuRAadDStfwfS1U@shell.armlinux.org.uk>
 <aAubnUSDpwtfuCrm@pengutronix.de>
 <aAufpsLhs8GLMm_b@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAufpsLhs8GLMm_b@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2025 at 03:43:50PM +0100, Russell King (Oracle) wrote:
> On Fri, Apr 25, 2025 at 04:26:37PM +0200, Oleksij Rempel wrote:
> > On Fri, Apr 25, 2025 at 02:41:21PM +0100, Russell King (Oracle) wrote:
> > > On Fri, Apr 25, 2025 at 01:08:45PM +0200, Oleksij Rempel wrote:
> > > > KSZ switches handle EEE internally via PHY advertisement and do not
> > > > support MAC-level configuration. The ksz_set_mac_eee() handler previously
> > > > rejected Tx LPI disable and timer changes, but provided no real control.
> > > 
> > > Err what?
> > > 
> > > ksz does not set phylink_config->eee_enabled_default, so the default
> > > state in phylink is eee_enabled = false, tx_lpi_enabled = false. It
> > > doesn't set the default LPI timer, so tx_lpi_timer = 0.
> > > 
> > > As the driver does not implement the ability to change the LPI timer
i > > enable nor the timer value, this seemed reasonable as the values are
> > > not reported (being reported as zeros) and thus prevents modification
> > > thereof.
> > > 
> > > Why do you want to allow people to change parameters that have no
> > > effect?
> > 
> > The original ksz_get_mac_eee() used to report tx_lpi_enabled = true,
> > which correctly reflected the internal EEE/LPI activity of the hardware.
> 
> Are you sure it did _actually_ did return that?
> 
> Yes, ksz_get_mac_eee() set e->tx_lpi_enabled = true, but if you read the
> commit 0945a7b44220 message, you will see that DSA calls
> phylink_ethtool_get_eee() after this function, which then calls into
> phy_ethtool_get_eee(), and phy_ethtool_get_eee() overwrites *all*
> members of struct ethtool_keee.
> 
> Thus, userspace doesn't see tx_lpi_enabled set.
> 
> Please wind back to before commit 0945a7b44220 to confirm this - I
> think you'll find that this bug was introduced in commit
> fe0d4fd9285e "net: phy: Keep track of EEE configuration".
> 
> > After commit [0945a7b44220 ("net: dsa: ksz: remove setting of tx_lpi
> > parameters")], ksz_get_mac_eee() was removed, and now tx_lpi_enabled defaults
> > to false via the phylink fallback.
> 
> As stated above, I think this driver has had a problem for over a year
> now, caused ultimately by the incomplete submission of Andrew's patch
> set. I think you'll find that if you try the comparing the ksz behaviour
> of commit fe0d4fd9285e^ with commit fe0d4fd9285e, you'll find that's
> where this behaviour changed.

thank you again for your detailed explanations.

After carefully analyzing the situation, I fully agree with your
assessment.

The key point is that the change in behavior was introduced already by
commit [fe0d4fd9285e ("net: phy: Keep track of EEE configuration")],
where phy_ethtool_get_eee() started overwriting the complete
ethtool_keee structure based on phydev->eee_cfg.

Since the KSZ DSA driver and the DSA framework do not request the
PHYlink framework to enable EEE by default, tx_lpi_enabled correctly
remains false.  However, because of how phy_probe() initializes
eee_enabled based on PHY advertisement, userspace will observe that EEE
is enabled, but Tx LPI is disabled, leading to an inconsistent state.

Thus, the current driver behavior is consistent with the framework
expectations.
My initial concern was based on the assumption that we still reported
EEE active by MAC default, which is no longer the case.
Therefore, there is no need to adjust ksz_set_mac_eee(), and I will
withdraw the patch.

Additionally, it seems that setting eee_enabled automatically based on
advertisement in phy_probe() is no longer appropriate.
If you agree, I would propose a patch to remove this initialization.

Thank you again for your patience and for helping to clarify this
situation.

Best regards,
Oleksij

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

