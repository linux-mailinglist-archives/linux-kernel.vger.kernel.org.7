Return-Path: <linux-kernel+bounces-784359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA700B33A71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1970D200917
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538AE2C0F95;
	Mon, 25 Aug 2025 09:14:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106042D0C6F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113269; cv=none; b=j0lRauOexkTEVvR/g28ToV6Cs11hbddMuJELqoSDNnwWcPyCUHAtDY3mb4yrt5K7G38fyx4cQyoI8uujYJG/d6nd29tyE62Cq/gexN1j3DZEQgHfa25Vx3O8u5klT+KrbxrAE2rjq+sPhWIjXNGDSO5IXDxRj8Y6g0hFdnO4+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113269; c=relaxed/simple;
	bh=IZE2IObkGus8MxAtOBzoPr06fFPibuycSoUDGf/CF4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXtKmyYbNlDb4VUQUGE8L1yONHIgBkOzp1NXLqmZ6fAaa5t/20IfKWEowiwTcGyiWbjMsRtJFmvUrRjTloWuXY8LvmUOqUIwj/Ip51Ha1Gpg36VCT1T3p6ooBzzAlg6oygzCg/sUPk/MBw4T1MYMRZawmWD30Cht+Zb+tNH74KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uqTHB-0007QK-A7; Mon, 25 Aug 2025 11:14:05 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uqTH9-0022kd-2f;
	Mon, 25 Aug 2025 11:14:03 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uqTH9-00GI4f-2J;
	Mon, 25 Aug 2025 11:14:03 +0200
Date: Mon, 25 Aug 2025 11:14:03 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de,
	Dent Project <dentproject@linuxfoundation.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next 2/2] net: pse-pd: pd692x0: Add sysfs interface
 for configuration save/reset
Message-ID: <aKwpW-c-nZidEBe0@pengutronix.de>
References: <20250822-feature_poe_permanent_conf-v1-0-dcd41290254d@bootlin.com>
 <20250822-feature_poe_permanent_conf-v1-2-dcd41290254d@bootlin.com>
 <d4bc2c95-7e25-4d76-994f-b68f1ead8119@lunn.ch>
 <20250825104721.28f127a2@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825104721.28f127a2@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Kory,

On Mon, Aug 25, 2025 at 10:47:21AM +0200, Kory Maincent wrote:
> > I've not looked at the sysfs documentation. Are there other examples
> > of such a property?
> 
> Not sure for that particular save/reset configuration case.
> Have you another implementation idea in mind?

My personal preference would be to use devlink (netlink based)
interface. We will have more controller/domain specific functions which can't
be represented per port.

PS: if you are on the OSS Amsterdam, we can talk in person about it.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

