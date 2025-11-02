Return-Path: <linux-kernel+bounces-881853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A83C29117
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 16:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B445A188D2E1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E871E521E;
	Sun,  2 Nov 2025 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MQUuRtTo"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD12173;
	Sun,  2 Nov 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762097461; cv=none; b=UsLl/rpd4PIws94gWwpErAA4RsISs30juCJfESESirGZTwQB8JAlP6G26Yol99hJnNyrIbV5VobPCXy8o1pSa9cnYgz/KJf40qi4T0wuZ9zIu1MBttBnuU+Flovu/rgWayp/AQz5tsgwhVJD+okDAUO4+bGfJ/7FzZ3FBXFFRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762097461; c=relaxed/simple;
	bh=qnTK+aOU/vNr+ZxpzyZw3EjGpE1dHpLR9coBfnOFci4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsSK2QsS2apUVoyYE8x5lnFnOXliKo/D5v6zUPgj0+6quSHX1OsWdJzhPoPTTdRw0WB2rBbq3v7kO0+sNoX8JjjJI8ODlspzcTNL4zy563efqWBMW3fpydE5aX8TawTgAuSG42I0rGQpsdv61yJGHXRxtosvIX1e2R3lSAZWRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MQUuRtTo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VBQuMfcb9v6n/12qNVr+mvs1HdGo/dveo2cEaqi032I=; b=MQUuRtTo3eXnXA8tyg9AN1Ae2Z
	wTWExrS2kIPp3aSkAG/noSr9AF1cTKdwqVkDAx8ipr2sb6QfvhIthiPw2kRJtqAoU3T2XxUUFEmVR
	g73UnHeAhSVjRBKTF8GXRBk6G30pXHWqtmwIckiAzItb4XShjT7MfZYgU+tmHlpFU908=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vFa2K-00Chtb-36; Sun, 02 Nov 2025 16:30:32 +0100
Date: Sun, 2 Nov 2025 16:30:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Oleksij Rempel <linux@rempel-privat.de>,
	=?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: Fix reserved multicast address
 table programming
Message-ID: <9f8e7666-d78b-418d-b660-82af4d79983e@lunn.ch>
References: <20251101014803.49842-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101014803.49842-1-Tristram.Ha@microchip.com>

> +	/* The reserved multicast address table has 8 entries.  Each entry has
> +	 * a default value of which port to forward.  It is assumed the host
> +	 * port is the last port in most of the switches, but that is not the
> +	 * case for KSZ9477 or maybe KSZ9897.  For LAN937X family the default
> +	 * port is port 5, the first RGMII port.  It is okay for LAN9370, a
> +	 * 5-port switch, but may not be correct for the other 8-port
> +	 * versions.  It is necessary to update the whole table to forward to
> +	 * the right ports.
> +	 * Furthermore PTP messages can use a reserved multicast address and
> +	 * the host will not receive them if this table is not correct.
> +	 */
> +	def_port = BIT(dev->info->port_cnt - 1);
> +	if (is_lan937x(dev))
> +		def_port = BIT(4);

Why not just def_port = dsa_cpu_ports(ds)?

The aim here is to send frames to the CPU. You then don't need the
comment about different switch versions.

> +	for (i = 0; i < 8; i++) {

Please replace the 8 with a #define.

> +		if (ports == def_port) {
> +			/* Change the host port. */
> +			update = BIT(dev->cpu_port);
> +
> +			/* The host port is correct so no need to update the
> +			 * the whole table but the first entry still needs to
> +			 * set the Override bit for STP.
> +			 */
> +			if (update == def_port && i == 0)
> +				ports = 0;
> +		} else if (ports == 0) {
> +			/* No change to entry. */
> +			update = 0;
> +		} else if (ports == (all_ports & ~def_port)) {
> +			/* This entry does not forward to host port.  But if
> +			 * the host needs to process protocols like MVRP and
> +			 * MMRP the host port needs to be set.
> +			 */
> +			update = ports & ~BIT(dev->cpu_port);
> +			update |= def_port;
> +		} else {
> +			/* No change to entry. */
> +			update = ports;
> +		}
> +		if (update != ports) {
> +			data &= ~dev->port_mask;
> +			data |= update;
> +			/* Set Override bit for STP in the first entry. */
> +			if (i == 0)
> +				data |= ALU_V_OVERRIDE;

You have already made this comparison once before. Maybe

	update |= ALU_V_OVERRIDE

higher up?

	Andrew

