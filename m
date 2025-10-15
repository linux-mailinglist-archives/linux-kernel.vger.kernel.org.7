Return-Path: <linux-kernel+bounces-854866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB28BDFA04
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24171A21C05
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFCB338F30;
	Wed, 15 Oct 2025 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wtHq3Gd0"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82971337685
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545229; cv=none; b=bbd6TpEZ3LTuQ1BTLJ/tUZtCjuRAw3la5PHWjpCU8ptny48K3kwXk456F9aIy2DEJ8wAtg2dmki+ViGvpM8CyxPO7sVPIDDvJRy6Tf3KUIJr5pVEuejImq9kKvAXUy9lkO9MsEMKSK4ZiEjBUUJAilWfrY2v7iNGPLgYEkms28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545229; c=relaxed/simple;
	bh=0bPnnNJxYEoXI1b70YZlgulOQQNFqx0526wcE/urorU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqjBD9q+0V3bC0WiQKfy8dcKW01VJEJ0F2V3fMhl9grrB3j8kvIEFmLQ9jsEZBAhpitChddpsxvyJibfkqExU0VXT1drP4RUqH53jYfZdnp+XeRlCgYfTAmTKaXGW6HJVRmwpKij56f4IEx8KwJ/Z0/VvflnXiGHWc1i30vCCZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wtHq3Gd0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 82D1C1A1361;
	Wed, 15 Oct 2025 16:20:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 487D560673;
	Wed, 15 Oct 2025 16:20:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 138CA102F22DF;
	Wed, 15 Oct 2025 18:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760545219; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=JJ6rH+xzmRM4qbGD1O8szCgtSQ2QdUeo9drcU82TAhs=;
	b=wtHq3Gd0pQyjV6eyAK7fkRd9w/l0K0lC4FEfqkfWEo6k637Nboqx9312H1X9fnaRV/2wfb
	QaZ6QKn/SgxEG7NppA04nggZ69c6MQyB2QdfPZpPZs7aRKxHJD8eY66Gr283U2WCMTmDak
	88guPcGFdZVaksfpnPKksUJJnae0T4LLkdX0RllszUHzwp8koW7AkW3d42+ZT82a7iuP7G
	nDuOFOMUrmu/iMcqebvj3mX2x8m7+8+umoL7QjmNGO4Lxs1r06oZx9uCz+/jpvM07WporL
	jqoVHJIuWENfI7kHqcyASHjuMNN1yYfK86sc1rke62SvxbTpWJvvR1KIZpJ/0g==
Message-ID: <27800f8c-eb0d-41c2-9e45-b45cf1767c23@bootlin.com>
Date: Wed, 15 Oct 2025 18:20:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: stmmac: Move subsecond increment
 configuration in dedicated helper
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
 <20251015102725.1297985-2-maxime.chevallier@bootlin.com>
 <aO-4hnUINpQ0JORE@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aO-4hnUINpQ0JORE@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Russell,

On 15/10/2025 17:06, Russell King (Oracle) wrote:
> On Wed, Oct 15, 2025 at 12:27:21PM +0200, Maxime Chevallier wrote:
>> +static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
>> +{
>> +	bool xmac = priv->plat->has_gmac4 || priv->plat->has_xgmac;
> 
> Just to say that I have patches that get rid of these has_xxx flags for
> the cores, and these changes (and the additional platform glue patches
> that have been posted) will conflict with them.

Fair, I was in your position not so long ago :)

For this particular series, it should be straightforward to fix the
conflict, but for the pending new glue divers we'll have to
find the sweet spot for these changes.

Maybe send it as an RFC so that people can see what to expect ?

> Given the rate of change in stmmac, at some point we're going to have
> to work out some way of stopping stmmac development to get such an
> invasive cleanup change merged

Agreed.

 - but with my variability and pressures
> on the time I can spend even submitting patches, I've no idea how that
> will work... I was going to send them right at the start of this
> cycle, but various appointments on Monday and Tuesday this week plus
> work pressures prevented that happening.

To give your more visibility, that's the only work I plan to do on
stmmac for that cycle, the rest is going to be phy_port,
and probably some netdevsim-phy.

> So, I decided instead to send out the first stmmac PCS series... which
> means I now need to wait for that to be merged before I can think about
> sending out anything else stmmac-related. (and there's more PCS patches
> to come beyond the 14 I sent today.)

Do you plan to send the next round of PCS stuff next, or the cleanups
for the has_xxx flags you were mentioning ?

In any case, I'll be happy to help testing :)

Maxime

