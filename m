Return-Path: <linux-kernel+bounces-643223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA15CAB29B5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 May 2025 18:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55DAA7A77D1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 May 2025 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4D425CC72;
	Sun, 11 May 2025 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RU5qdjuY"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A242AAF;
	Sun, 11 May 2025 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746981928; cv=none; b=oePP0olUBAIyDfztU9xX02tmDJ9hVQsU1rI9XA0J+ZadeWa3ss7PFUamzBUn6/buYpRxBT8wrw/2+n2Cx1+hAzC6f6a+TQl9bUO0VtcwJt0cvSWPuY31hANvqZZ+08Ur/nA9dKnsD/KxOTafP1u2PAJyMF550mUcxbDy3g7A/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746981928; c=relaxed/simple;
	bh=A8puHkiDEsUG3Tld6h6c2MmtFV01PzvaDA0SYCPSGhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5NsdU1urkSux8vsHjOQ4E3ipWLuUjO9a71ZUU9LhqT3RsG1ELcQsJz8w7XVbwbwum9z13ckSyOEMFzj57+bmWfSAtOWgzqqV/tZSHS+Y6YrDo8kJIb6bgWOOyIeYvMm3KkDA1pMd0w/ZCJTMtjpgSL3qMWeIX7q06Z35c1oO9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RU5qdjuY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=l1o8V806NFIConNLc8885KE8QTfy5R2bUMg4nOs6tmA=; b=RU5qdjuYx/ZXxe1RsvJ5AAlyqQ
	rS5lQCz+T06UioQDRdgpCw+rL42X4dSMWmftAwOIhOulLbeweA1hCKgpeeNtpV/3mjtns7eAMoKpz
	GZXzCNb9pRwoyrF/HlZflmUxf5ppnbNEdwVnWr+aE1p2S4gofevRViv0nhFrppycwpAA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uE9nc-00CGLD-HX; Sun, 11 May 2025 18:45:12 +0200
Date: Sun, 11 May 2025 18:45:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 02/14] dt-bindings: net: dsa: mediatek,mt7530: add
 dsa-port definition for mt7988
Message-ID: <88d93b58-84f3-4394-80ed-9adf67d525f4@lunn.ch>
References: <20250511141942.10284-1-linux@fw-web.de>
 <20250511141942.10284-3-linux@fw-web.de>
 <043d1a0a-1932-42f3-bcd8-17fad10c5543@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <043d1a0a-1932-42f3-bcd8-17fad10c5543@lunn.ch>

On Sun, May 11, 2025 at 06:34:30PM +0200, Andrew Lunn wrote:
> On Sun, May 11, 2025 at 04:19:18PM +0200, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> > 
> > Add own dsa-port binding for SoC with internal switch where only phy-mode
> > 'internal' is valid.
> 
> So these internal PHYs don't have LEDs?

Ah, i got that wrong, sorry.

What i don't know about here is if you should be defining your own
ds-port binding, or taking the existing binding and add a constraint.

	Andrew

