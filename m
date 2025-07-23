Return-Path: <linux-kernel+bounces-741858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52CCB0E9E0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73F4D7A64B1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8FE242D66;
	Wed, 23 Jul 2025 04:59:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3898E23816D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753246794; cv=none; b=HPQ2nMR6Dg52hK6x5Op4NQch6Cbkl0RrPi53Hb1MWM5uckfPWtVWHJxoeGLS6wIK1j/OkWnkU91DBsmpWTHIb88numaz10FEmh1PXu0nuUIaH4/qMvHryA5elfueKgN2SksR+4D2Um9XpNSQ9kjgo+gn3ij7mJl6nGhwTKzUt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753246794; c=relaxed/simple;
	bh=bUWkVDl1xsG0268an9XDncsjM9CP5KQHVRX4OUyWoHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi3Y3XmHIZ9DQGxc755If9YMi63r4fQQueVLFfb8Jd0l8zLhZE6h6U2S6p68B+tLTZ3BNjqU3mvNx3zw5ekVljafUmvxs46AlaA9WwZVZrM88qX3xHwSG8J5ZfR4xOKTF2GsMU1j84bTcH3fncqNCgF+Z3/PCSItnmNMUeedQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ueRZd-0006yY-RI; Wed, 23 Jul 2025 06:59:25 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ueRZa-009piQ-2a;
	Wed, 23 Jul 2025 06:59:22 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ueRZa-0010Bg-2C;
	Wed, 23 Jul 2025 06:59:22 +0200
Date: Wed, 23 Jul 2025 06:59:22 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tristram.Ha@microchip.com
Cc: Oleksij Rempel <linux@rempel-privat.de>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: Fix wrong rx drop MIB counter
 for KSZ8863
Message-ID: <aIBsKkTtNsA_J7AY@pengutronix.de>
References: <20250723030403.56878-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723030403.56878-1-Tristram.Ha@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Tristram,

On Tue, Jul 22, 2025 at 08:04:03PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> When KSZ8863 support was first added to KSZ driver the RX drop MIB
> counter was somehow defined as 0x105.  The TX drop MIB counter
> starts at 0x100 for port 1, 0x101 for port 2, and 0x102 for port 3, so
> the RX drop MIB counter should start at 0x103 for port 1, 0x104 for
> port 2, and 0x105 for port 3.
> 
> There are 5 ports for KSZ8895, so its RX drop MIB counter starts at
> 0x105.
> 
> Fixes: 4b20a07e103f ("net: dsa: microchip: ksz8795: add support for ksz88xx chips")
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you for your patch!

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

