Return-Path: <linux-kernel+bounces-876528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D45CEC1BC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEAAD509513
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06243358C2;
	Wed, 29 Oct 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="txNTXsun"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02A933F6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751945; cv=none; b=U+2L3f8UhEr0rXEhUYOeLJX8hQkXVgMKuuJr1GKFC4Q13MzeO/GtgqbM1IDviNv6HZsJAfOhU1ilDy2acRs7yaxAD9+obbNWqBmXV9cKw7gYW28KbuyALojjzGudvUy9sQtTNjkM/jFMvvjMuo7QsATrJEKxt+BVaytdm1Tw4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751945; c=relaxed/simple;
	bh=rZ9KpwdCb25wLdoor5bEUUPNL0/IlGb9p3USmph/OTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5qVotbzQCof+cnyeItiCzNLO83BzIx8qzs0OsB/cquQsKQPm8hpFJ5X9VlzWE+S71h4i97BY+JZe+JvpsH3Q20/AszTTRtk9LMd2eMoQ128SQbduBLinF3vXRvDF36hq2Ws0UawN4oQZSUbLfQzFLzeM3UM3x+SZ1NGHOOvNck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=txNTXsun; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id EF2684E413CE;
	Wed, 29 Oct 2025 15:32:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3712606E8;
	Wed, 29 Oct 2025 15:32:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2E1C117F8299;
	Wed, 29 Oct 2025 16:32:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761751939; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=kMrJceTWmN53UT1PewSFVb4RviFH0RPzPzL22omqM6k=;
	b=txNTXsun1RNXE5oMhI32sx086EmmN/aHvNbQnBpoXl7AK4QbUQXEXBBNgqrfQw9zFIbdrN
	PX1LK3Ri1VKMgACDqen+T9kHRu2KJgZYbrRJXI+ga2qcV4P7wFLfnNb6+IGDeFhvva4O2T
	v/0X17NXSAOkbciY7T3+/0fRQq8cZzYjCQ6okWlw4ZGOi+jhGs1Pet0789auvh8JCg5gmi
	MhRl2YnCVf21nk8jtZHbqzIthM8w6wgLyXXyR5j9BxGzXH2poy/omzMcIuM66+Fd2SqK9L
	m+2r074paejLimn5tH61qhFJy6hx8rF+t54mXUQzIgM1XfK7gtoAoNTufq5h2A==
Message-ID: <7ba29151-699e-4e69-9826-9de05714a380@bootlin.com>
Date: Wed, 29 Oct 2025 16:32:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] net: stmmac: socfpga: Agilex5 EMAC platform
 configuration
To: rohan.g.thomas@altera.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251029-agilex5_ext-v1-0-1931132d77d6@altera.com>
 <20251029-agilex5_ext-v1-1-1931132d77d6@altera.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251029-agilex5_ext-v1-1-1931132d77d6@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Rohan,

As this patch also impacts other socfpga variants, I gave it a try
on Cyclone V, all is fine :)

On 29/10/2025 09:06, Rohan G Thomas via B4 Relay wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> Agilex5 HPS EMAC uses the dwxgmac-3.10a IP, unlike previous socfpga
> platforms which use dwmac1000 IP. Due to differences in platform
> configuration, Agilex5 requires a distinct setup.
> 
> Introduce a setup_plat_dat() callback in socfpga_dwmac_ops to handle
> platform-specific setup. This callback is invoked before
> stmmac_dvr_probe() to ensure the platform data is correctly
> configured. Also, implemented separate setup_plat_dat() callback for
> current socfpga platforms and Agilex5.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>

Thanks for your explanation about the TSE PCS,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime



