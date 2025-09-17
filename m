Return-Path: <linux-kernel+bounces-819774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ED8B7F4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 634707A18B0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEBA1C28E;
	Wed, 17 Sep 2025 00:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lMGNRmiT"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E024738B;
	Wed, 17 Sep 2025 00:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067724; cv=none; b=tJwOSGTIXxkW4U01JmU8uTzGwjPd822vLDJfv5muLGcqWR5bcNhhW1JQdSN1TWG6KrrHapUiwCLNIPBWoMdYe7euBsL0HxDpLFezJTsmlkEbyJ+RHOpyX1ttzV09tYc09m+Z8XbUw2Y4kFlqx8VhO9zuFPCmWDxFbFO1Mbyasgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067724; c=relaxed/simple;
	bh=OC74HdkHSu0fNzteZin6vgvT5P9ck5s51EIpPDksXzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVTKaNu6KS4S+9zwsrM4iMXUX1tXIPudACsS7qHhP0tFTtuJYttSsyzLe7YjuVSyYTjlyLyEyltspukuKO1mdNW386TKORyUOUZIi/snxh4ig8R3v+ERsLnS/4sZ/7TXpNYMecmaVFMb49gGjAdUGzwQVtqpOak9Z81fViRm3pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lMGNRmiT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HhSodjO7+BLllzkoJSDhQVPsZqnYQB8PQbR2WvHcmbw=; b=lMGNRmiTtzKHeRkm6TOtq4Ff4L
	YiIsSJ3YJ9wwuxHF1Qd8sYHPdR8cWGJtUGZC8rnvyMIazSWNB+46mZuA1AftbqBIvxpH+cq9Re0uM
	YaDaMQ8b/IA6RCHYp5RtbnECzKdiY86f8U97ISX90XaiSlH7dR/puTNPFKedOmhsJLbI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uyfip-008d3V-IW; Wed, 17 Sep 2025 02:08:31 +0200
Date: Wed, 17 Sep 2025 02:08:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <b0fc2de5-bccc-4ef8-a04d-0c3b13cde914@lunn.ch>
References: <20250913044404.63641-1-mmyangfl@gmail.com>
 <20250913044404.63641-4-mmyangfl@gmail.com>
 <20250916231714.7cg5zgpnxj6qmg3d@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916231714.7cg5zgpnxj6qmg3d@skbuf>

> > +static int yt921x_reg_mdio_read(void *context, u32 reg, u32 *valp)
> > +{
> > +	struct yt921x_reg_mdio *mdio = context;
> > +	struct mii_bus *bus = mdio->bus;
> > +	int addr = mdio->addr;
> > +	u32 reg_addr;
> > +	u32 reg_data;
> > +	u32 val;
> > +	int res;
> > +
> > +	/* Hold the mdio bus lock to avoid (un)locking for 4 times */
> > +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> 
> Andrew, are you satisfied with this lock?

This is O.K. You snipped too much context. As the comment says, the
code is about to do 4 MDIO bus transactions. Each will take and
release the lock. By taking it now, and then using the unlocked
version for read/write, it will make it a tiny bit faster. The time to
do the bus transaction will however dominate.

> Perhaps I missed some part of
> the conversation, but didn't you say "leave the mdio lock alone"?

Yes, i did, but then the mdio lock was being abused as a DSA driver
lock. The DSA driver now has its own lock. So what we see above is
purely an optimisation, not a locking scheme.

	Andrew

