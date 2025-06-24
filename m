Return-Path: <linux-kernel+bounces-700023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61148AE62D5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 12:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E70404CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 10:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5492028641D;
	Tue, 24 Jun 2025 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNkLeoWX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4DF27A90F;
	Tue, 24 Jun 2025 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762060; cv=none; b=c6FT1pUBaQEoek3wqeGnMX/LCjvF37SZGV2YS7ChcwOLmLuCTMmr7Ozgbz0chSU/NZ+3h+5ikCHn7Qi5ugapsY2x+SybVP+wTRDZuDy1zkGvx2UNOhhrvEUPxgCjzSFvpT+S5cI5DA9Uyiv0U86saF5HlKlWO0lDutU7UiCRVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762060; c=relaxed/simple;
	bh=oDvB194LUMC8lVLAW2ksZ5zyAStqluCRp9yUkhSN6vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXq6gxGG1pG3HVwgOOjo2FsaIKPBnXmbBE2zwlEpx33r3R+jx+a0h9CIQNs1r4cHsaOMBf3jAYhF6hjQjNpXEkdvCzsnvg35VoT61t7unWyKkU2s+sY3XoVkzt+uHIP3VGSwijgmTF46k2TXAL0p93S47vcnIbAjbX2L4o+sai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNkLeoWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D08C4CEE3;
	Tue, 24 Jun 2025 10:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750762060;
	bh=oDvB194LUMC8lVLAW2ksZ5zyAStqluCRp9yUkhSN6vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNkLeoWX5Brsg8jmefTS3BhKcP4yHwsVQV97uEXhkEb99wKmDEdEQGpMou65IrWyu
	 KqoUeqBOgC0Z6QzvUy1PBMlW+Ntvcp2NHHW9MJTp3fTslJf805EOp+gzEiy3M85oHF
	 oU7UHxjfWPg0LQ9W3qCu4aUYySjtcEkrtPXqRWaAQAZHaowQ/ISL2oLkacMOhTPoYz
	 yoY0e4y08Fup2HHS0nDxD99SY2Dbk4SErlKvXcmW2FZZ7qb/GLVT8grCbAAGdww9qd
	 NfRBcwKsrLbTAXv6UJCGQ6OGKCt6lM3Q5H/1HzDsOt7w0QNvhYTgjZY74+iTH2P42+
	 YfVw58go9PkAg==
Date: Tue, 24 Jun 2025 11:47:35 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v1 1/1] net: usb: lan78xx: annotate checksum
 assignment to silence sparse warnings
Message-ID: <20250624104735.GD8266@horms.kernel.org>
References: <20250620084618.1857662-1-o.rempel@pengutronix.de>
 <20250623164913.474be2b3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623164913.474be2b3@kernel.org>

On Mon, Jun 23, 2025 at 04:49:13PM -0700, Jakub Kicinski wrote:
> On Fri, 20 Jun 2025 10:46:18 +0200 Oleksij Rempel wrote:
> > -		skb->csum = ntohs((u16)(rx_cmd_b >> RX_CMD_B_CSUM_SHIFT_));
> > +		__be16 csum_raw;
> > +
> > +		csum_raw = (__force __be16)(rx_cmd_b >> RX_CMD_B_CSUM_SHIFT_);
> > +		skb->csum = (__force __wsum)ntohs(csum_raw);
> 
> You can avoid the __force __be16 if you switch the variable to be u16
> and then htons instead of ntohs

Ok, now I am confused.
What is the endian of these integers?

