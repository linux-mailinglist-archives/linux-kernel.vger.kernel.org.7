Return-Path: <linux-kernel+bounces-897033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8C9C51DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4B53AA52F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDE7304BBF;
	Wed, 12 Nov 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/vrkDNk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8BE2D29AC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945302; cv=none; b=fsPpMcQuQ49OGdFp/QUFYrHVSWcPiBygXtaXSBEYLJFtglmdlsA6j17NOhp22fHUqhAREu0bskGKoG/0cZ+D5zaK96IPW6H3pa4h97vladQdKpzn9NkdOgyMQ70+V6clCpDvEmoSpht04fe8H2z4J5thUyDgExjWSk3kMYbtrts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945302; c=relaxed/simple;
	bh=pGr5SVip75wUoMzTM9YR3LZ6KFu1K7LtMkQ2aFfRkc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTLzw3auUBgvpOwbHChV3d7glDZKsHNdVYrGU8c95yQ2Mb0LrFvEh3a9UJ1O8EJwDSY2TJgiv5PbG4DNwu8SkvmJgpVoPmPF5vQSgUjz4+8ksYjTiUAKiSNXoI5DzPUQqGKjni8mnkAy3ifS/4oYsTpucR5e51b1C4IqUQlJUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/vrkDNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC61CC16AAE;
	Wed, 12 Nov 2025 11:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762945301;
	bh=pGr5SVip75wUoMzTM9YR3LZ6KFu1K7LtMkQ2aFfRkc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/vrkDNkpPbNqXhP0W09z4Ouqq4B3k5aNmNqwMhoLMEigBsGHAfa2BeN0lDINVbm3
	 tEsKhwoTGqC320uuEF7ZEc1JJ+Fz2zjxlLg9yGRWC4gVUUAvJjhX3v5HrNw6XXPF02
	 fxKeocRia2xDy/lXBC/oLPVbU7ILkSshZHjsQ/8RFSJsrgRyub1BzotQEi0OerO6Mc
	 cTX2h/Esh/Z3Q3V3eApemKwvvLJ2Vzq4FPtVqvi5KZuYar54xXCNcPC4iErQ6nbEp4
	 0mtiy+WQXJ2mSXiU2/xiwN9leo1N/lf5G34pRdxCKM1jjf5OTW1+Lq2KfRtvjxRLwP
	 pkzcpn7VnPtyA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vJ8bd-0000000029O-2I7V;
	Wed, 12 Nov 2025 12:01:41 +0100
Date: Wed, 12 Nov 2025 12:01:41 +0100
From: Johan Hovold <johan@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] clocksource/drivers/nxp-pit: Prevent driver unbind
Message-ID: <aRRpFWfgz0OYpdWy@hovoldconsulting.com>
References: <20251111153226.579-1-johan@kernel.org>
 <20251111153226.579-3-johan@kernel.org>
 <6336a324-3597-4726-b2ff-fe0f561c59bc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6336a324-3597-4726-b2ff-fe0f561c59bc@linaro.org>

On Wed, Nov 12, 2025 at 11:00:05AM +0100, Daniel Lezcano wrote:
> On 11/11/25 16:32, Johan Hovold wrote:
> > The driver does not support unbinding (e.g. as clockevents cannot be
> > deregistered) so suppress the bind attributes to prevent the driver from
> > being unbound and rebound after registration (and disabling the timer
> > when reprobing fails).
> > 
> > Even if the driver can currently only be built-in, also switch to
> > builtin_platform_driver() to prevent it from being unloaded should
> > modular builds ever be enabled.
> > 
> > Fixes: bee33f22d7c3 ("clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support")
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >   drivers/clocksource/timer-nxp-pit.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clocksource/timer-nxp-pit.c b/drivers/clocksource/timer-nxp-pit.c
> > index 2d0a3554b6bf..d1740f18f718 100644
> > --- a/drivers/clocksource/timer-nxp-pit.c
> > +++ b/drivers/clocksource/timer-nxp-pit.c
> > @@ -374,9 +374,10 @@ static struct platform_driver nxp_pit_driver = {
> >   	.driver = {
> >   		.name = "nxp-pit",
> >   		.of_match_table = pit_timer_of_match,
> > +		.suppress_bind_attrs = true,
> >   	},
> >   	.probe = pit_timer_probe,
> >   };
> > -module_platform_driver(nxp_pit_driver);
> > +builtin_platform_driver(nxp_pit_driver);
> 
> Do not use builtin_platform here. You can add the tristate Kconfig 
> option for this driver, I tested it.

As I just commented on the cover letter, that's not relevant here;
builtin_platform_driver() only prevents unloading a driver built as a
module (which is something we want to prevent for these drivers).

Johan

