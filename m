Return-Path: <linux-kernel+bounces-754205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AA9B18FB8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51A007A9576
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938ED256C9B;
	Sat,  2 Aug 2025 18:59:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993D718CC13
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754161198; cv=none; b=JqQLroY1cC815ZMDWxihV86qL1PcD5ni/KRgKWX4PgfYeMZT6+/ywXVmKQezu64BcpZtaIK7p465Igro4/GOHRKaSnbOvu302Tr6sf3mgOlDYVzgiMk3UpMrMwHp3zabpksLbk85ROYa735fNe3keODE31Fp8e66vuqwG/8V1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754161198; c=relaxed/simple;
	bh=zS0HkYliP/Jb4w/PyKaW2rKnqoeREt2JEBWd2hTP/hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plBHbtDFcAQbxnQuvV6t1M5F42W5MSF2dVL0FSm/+6vcSlNSCTUalJTpkKy1O57HP2nlxMTPw3ePphWhocF17Z764a5V4CpEC4VswZGgHJvZsyX7415O67K3CHRAlZXcxWcf6A5qM/y/BJsgLY8yBzgOyEmBA8PhKYIjJqWsXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uiHS5-0003Rb-Br; Sat, 02 Aug 2025 20:59:29 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uiHS2-00BaKR-05;
	Sat, 02 Aug 2025 20:59:26 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uiHS1-0044Ok-2p;
	Sat, 02 Aug 2025 20:59:25 +0200
Date: Sat, 2 Aug 2025 20:59:25 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tristram.Ha@microchip.com
Cc: Oleksij Rempel <linux@rempel-privat.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: Fix KSZ8863 reset problem
Message-ID: <aI5gDWqMBBtESscm@pengutronix.de>
References: <20250802002253.5210-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250802002253.5210-1-Tristram.Ha@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 01, 2025 at 05:22:53PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> ksz8873_valid_regs[] was added for register access for KSZ8863/KSZ8873
> switches, but the reset register is not in the list so
> ksz8_reset_switch() does not take any effect.
> 
> ksz_cfg() is updated to display an error so that there will be a future
> check for adding new register access code.
> 
> A side effect of not resetting the switch is the static MAC table is not
> cleared.  Further additions to the table will show write error as there
> are only 8 entries in the table.

Thank you for fixing it!

> Fixes: d0dec3333040 ("net: dsa: microchip: Add register access control for KSZ8873 chip")
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
>  drivers/net/dsa/microchip/ksz8.c       | 7 ++++++-
>  drivers/net/dsa/microchip/ksz_common.c | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index 76e490070e9c..6d282a8e3684 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c
> @@ -36,7 +36,12 @@
>  
>  static void ksz_cfg(struct ksz_device *dev, u32 addr, u8 bits, bool set)
>  {
> -	regmap_update_bits(ksz_regmap_8(dev), addr, bits, set ? bits : 0);
> +	int ret;
> +
> +	ret = regmap_update_bits(ksz_regmap_8(dev), addr, bits, set ? bits : 0);
> +	if (ret)
> +		dev_err(dev->dev, "can't update reg 0x%x: %pe\n", addr,
> +			ERR_PTR(ret));

Better using ksz_rmw8() instead. It is already providing error message.

In this file there is 4 direct accesses to regmap_update_bits() without
error handling. It would be great if you have chance to replace it with
ksz_rmw8() too.

>  }
>  
>  static void ksz_port_cfg(struct ksz_device *dev, int port, int offset, u8 bits,
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 7292bfe2f7ca..4cb14288ff0f 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1447,6 +1447,7 @@ static const struct regmap_range ksz8873_valid_regs[] = {
>  	regmap_reg_range(0x3f, 0x3f),
>  
>  	/* advanced control registers */
> +	regmap_reg_range(0x43, 0x43),

This register is no documented in the public documentation. Out of
curiosity, are there some where more information about this two
"reserved" register ranges: 0x3A-0x3E and 0x40-0x5F?

Best regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

