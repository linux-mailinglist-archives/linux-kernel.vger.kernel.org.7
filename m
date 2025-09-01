Return-Path: <linux-kernel+bounces-795014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F64B3EBD6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 174264E2E40
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2248413B7AE;
	Mon,  1 Sep 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K8ROVbfe"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE14E1B3930
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742632; cv=none; b=f2kVcLJUZ6RZaVERoI9usizZSobv13tdYcZnN6rwWNVQ8w9glOMMHUUybScdUCsu8uoSAoRJdJs6srqSB+47/uA39bFXaMXvKYtU0jSFFlP/0UphV0OP/QrBBljJQAIF6DCuR3csHClwTunrh/EBqQVH1uie6UsOda0eINwJYVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742632; c=relaxed/simple;
	bh=tZoVkN1i6L77fLCD81NlkhWCUQUk6LgHlodZ+Eu+aKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSp+L/okI1bMDKSliV6qIkmGe0j7UtJaWffvZKboBbgdbiLPVr+3aJNPMw31xHqgQbSevG2YGCL4jsAGklf4z2hGn2GpWTpms9JI/LBUubwsE5+2nzeTsUzRt8rprSTkAMGvzgb0Y/DJ1Hwc3e1dz3o65tK5vfzabrR/Abj0AtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K8ROVbfe; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9A3474E40C0E;
	Mon,  1 Sep 2025 16:03:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 718FF60699;
	Mon,  1 Sep 2025 16:03:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7519C1C22C4CE;
	Mon,  1 Sep 2025 18:03:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756742625; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=h3AMFBS4pdqTPHb1xaEyon/Z/yyDiXoC6h3IkXj+6VE=;
	b=K8ROVbfek60Si5w/IjEyvjT+O0WeRGTQB7vScHeXPwkm4/BDz7rPAOwHbICA1SBIlmG1D3
	3h0PsmiuIgXJeOS5z6XATDL4jDtBuAeOs9qJVqYT29hhslKmUbDp4zU7f3YrU3AtnK4a4P
	gu8IRfN7S/lkQ68u9TmNJj1aRPtBOt1bY8kisXQGEuVNU7byY/T0uJLb9Cx4T+gJuIVj5E
	apiP6raO7AwA/0zrv1feGHukkxoIks//sweBk57dGtCrjau/YBdaSzEpJujuLYICPa3/3t
	4Gaki9w+bJK/Gpk+U0JfiPzBx2QdyajLvdAxj5TiXWLOF9YUI17BOqVxJA1KLA==
Date: Mon, 1 Sep 2025 18:03:25 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: nicolas.ferre@microchip.com
Cc: ARM Maintainers <arm@kernel.org>,
	Ryan Wanner <ryan.wanner@microchip.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] ARM: at91: enhance PM routines
Message-ID: <202509011603254b5f8ceb@mail.local>
References: <20250827145427.46819-1-nicolas.ferre@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827145427.46819-1-nicolas.ferre@microchip.com>
X-Last-TLS-Session-Version: TLSv1.3

On 27/08/2025 16:54:24+0200, Nicolas Ferre wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Low priority fixes to the PM code, in relation to recent addition of sam9x75 or
> sama7d65 SoCs.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> 
> Nicolas Ferre (3):
>   ARM: at91: pm: fix .uhp_udp_mask specification for current SoCs
>   ARM: at91: pm: fix MCKx restore routine
>   ARM: at91: pm: save and restore ACR during PLL disable/enable
> 
>  arch/arm/mach-at91/pm.c         |  2 +-
>  arch/arm/mach-at91/pm_suspend.S | 12 +++++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> -- 
> 2.43.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

