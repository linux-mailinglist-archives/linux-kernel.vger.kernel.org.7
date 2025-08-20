Return-Path: <linux-kernel+bounces-776878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9F1B2D277
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DD41703E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5907326B777;
	Wed, 20 Aug 2025 03:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ArDBiekE"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3F813B58D;
	Wed, 20 Aug 2025 03:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659702; cv=none; b=cCZq0nWQngVXsteljMBdBf5AMX/EKlE6GoSuApRR4XU3OdLSEFiwP5tTbF2dCV9nrjeFxxhCcLXW4dd6lhOPxNiT/sy595RAnuncEHKixAlSY1Kz66O8rGGFXHbN8gY6oNjO5lFrP8B8aXjbDyXaUN/NOvehfDS68AGucbtb2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659702; c=relaxed/simple;
	bh=yE7HVj3JqidbybQxQNOHYMSJqjK4Qyy9o5TFmSlx49I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGxHMVuvEriuP/nMNN16JNvGwZrPNrWH3WM8aCpQxQpcvYmHncdkvfHZJqog8nmFtz8l7/ROzN0Rv+OVmA9Dn6zLiJKMIkauhc8VxCru7R+DeXoH1BixNtBRz0Zxye66klc038hkKYFHPh8my+bO2wISjV3GdrSETcjHEatg0Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ArDBiekE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9g7QJpg9GoK5Nz7zmPqlAt833Gnrs2pRTsimklwwUq0=; b=ArDBiekE9y1OobdjjW6hvnxn4S
	QTUU0RuSx9D1yOtEJaDn0kHW9Esmr3egZUd76w3pxwh6AX1BgESShHn+solUGLpElIJqzlfrUSjZB
	NN7khvHMN3SK3iz2aksBs70QkCJQkNz8rxWgsfVG73K7OtXE2cNhnn1Ml80SP/jOggAM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uoZHk-005GtQ-Tr; Wed, 20 Aug 2025 05:14:48 +0200
Date: Wed, 20 Aug 2025 05:14:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, o.rempel@pengutronix.de,
	alok.a.tiwari@oracle.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/4] net: phy: micrel: Start using
 PHY_ID_MATCH_MODEL
Message-ID: <585233b2-0462-4815-bdcc-b91460e1cac5@lunn.ch>
References: <20250818075121.1298170-1-horatiu.vultur@microchip.com>
 <20250818075121.1298170-2-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818075121.1298170-2-horatiu.vultur@microchip.com>

On Mon, Aug 18, 2025 at 09:51:18AM +0200, Horatiu Vultur wrote:
> Start using PHY_ID_MATCH_MODEL for all the drivers.
> While at this add also PHY_ID_KSZ8041RNLI to micrel_tbl.
> 
> It is safe to change the current of 0x00fffff0 to PHY_ID_MATCH_MODEL
> because all the micrel PHYs have in MSB a value of 0.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

