Return-Path: <linux-kernel+bounces-771428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 808BCB28704
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384745E7C68
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 20:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ED223D7F4;
	Fri, 15 Aug 2025 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hJtqStVZ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96D3211F;
	Fri, 15 Aug 2025 20:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289037; cv=none; b=FH3Os3PHYw/BFmHclGUG5EiGllWI51YUqVABSRRsWcfCklvK06Q9QzCRWMqL2p5S/PSS+wGd1MbOY0pMtPDAOqZZ/hLr0hrPPKnjiJqh0D6Rj7SfmYhkwUvDx4cSlBU6m6CieugbNby7VID3a2u1MDxhrjYiJm157uCPkr+MjQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289037; c=relaxed/simple;
	bh=G/rob/GTNjt2wJX5/hzqmhL8r9vsWkTx19AIdgrVZcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhnygOCjNo0FL3Ptmcg1yi+BDEm0uza1Ai4GFNH14gzuNIfDzpI3j5BPaQuPk+XQsvKUA4JrbUhasJhqRXB7m/4YwaPA5dfMSnrUFX1ggS5/7HN1piDZfMyoitfRbuRTpg0JhbHkzKp/3c+mlPynLMOvJ1XYAk8GDes5Xz8xBYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hJtqStVZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RJtfD6O0v/vMVZV7rRp8xoe0rZWx5CKBjCuyZCCOCy8=; b=hJtqStVZeBdOLtswZKQ2O/4m9e
	28vUCh998ojDuVJN+3nhGYeb4fRcqmdLuQUaTtmI04WgvgQ7QtPClv8kb2WqfmbFlFY/I9kIc6q1W
	lgLulhbgO62eqDvneIZXmrguOHcsNvxNeHRmzZTGaZ+LLw8loMn7BG11EhdPuZ9E4c9w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1un0r8-004rL2-Om; Fri, 15 Aug 2025 22:16:54 +0200
Date: Fri, 15 Aug 2025 22:16:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Rob Landley <rob@landley.net>, Jeff Dionne <jeff@coresemi.io>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
Message-ID: <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815194806.1202589-4-contact@artur-rojek.eu>

> +static irqreturn_t jcore_emac_irq(int irq, void *data)
> +{
> +	struct jcore_emac *priv = data;
> +	struct net_device *ndev = priv->ndev;
> +	struct sk_buff *skb;
> +	struct {
> +		int packets;
> +		int bytes;
> +		int dropped;
> +		int crc_errors;
> +	} stats = {};
> +	unsigned int status, pkt_len, i;

netdev uses 'reverse christmas tree' for local variables. They should
be sorted longest to shortest. This sometimes means you need to move
assignments into the body of the function, in this case, ndev.

> +	jcore_emac_read_hw_addr(priv, mac);
> +	if (is_zero_ether_addr(mac)) {

It would be more normal to use !is_valid_ether_addr()

What support is there for MDIO? Normally the MAC driver would not be
setting the carrier status, phylink or phylib would do that.

    Andrew

---
pw-bot: cr

