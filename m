Return-Path: <linux-kernel+bounces-857510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBAABE6FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDD994F89D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3C823EA9F;
	Fri, 17 Oct 2025 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rbgnTyiR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05ED23D7E7;
	Fri, 17 Oct 2025 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760687012; cv=none; b=DhVcHoLFJzmdD86pkR/ODAGzve4eBX/BOHyBXZQxlsubdfOWJz9IKwTaJkgORl6sAkSFeSH670HBMUyh6KFWFCYnj+/u+q7izlo9gKDHYGJPRDbiKUr1pLp3nPBhYG9sUQLaIUysBRDotTgTAx2zG882fxT/kvmnekh6YLcrfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760687012; c=relaxed/simple;
	bh=Ghawdb9l72IEZCfQwNVJ0wErDbWEow5FhFKT+ciucco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKQV21R9X9YZe7Rhgcu8MrDPCIs+LUfswhMkApl+CiNDuhkaCJCHFJeXLG6vzPrPj6by9uVe8xPnKRS+NrbfjdO9oqabQ9vugnxNf4i2iICVja1LAZbjXTYk3zDlwiA6jc/ce+s/8FD5UUa3+ivPXRdxmDWd168TmItxw2ZVZNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rbgnTyiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3942C4CEE7;
	Fri, 17 Oct 2025 07:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760687011;
	bh=Ghawdb9l72IEZCfQwNVJ0wErDbWEow5FhFKT+ciucco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbgnTyiRwNqzWTCsT9SFJ0M0y6ewfizs6HV6j9R9MCeXDn5I+PfLLTbX7sIZzLKdb
	 2CLT0UiaisCdgatT2tsNx53BuVw1axilp0cVSfN3oo61y9gcRgaA5AbPgN6rFvEW+K
	 y3LwXgi9MYsbutny94X7lRDSlaUPH76FX4X3wTQI=
Date: Fri, 17 Oct 2025 09:43:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Brian Masney <bmasney@redhat.com>,
	Iwona Winiarska <iwona.winiarska@intel.com>,
	Joel Stanley <joel@jms.id.au>, Maxime Ripard <mripard@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from round_rate()
 to determine_rate()
Message-ID: <2025101721-twiddling-huskiness-4852@gregkh>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
 <aMatZAX6eFI1RmDH@redhat.com>
 <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
 <aPEZSY6RC-UVclxN@redhat.com>
 <ba2e6b78e59afb7c89e5022770a142ec8c31659a.camel@codeconstruct.com.au>
 <2025101759-runner-landing-374b@gregkh>
 <2975918e3f3a7de245e93fbee52335acb78bb23a.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2975918e3f3a7de245e93fbee52335acb78bb23a.camel@codeconstruct.com.au>

On Fri, Oct 17, 2025 at 05:57:44PM +1030, Andrew Jeffery wrote:
> On Fri, 2025-10-17 at 08:41 +0200, Greg Kroah-Hartman wrote:
> > On Fri, Oct 17, 2025 at 04:52:37PM +1030, Andrew Jeffery wrote:
> > > Hi Greg,
> > > 
> > > On Thu, 2025-10-16 at 12:11 -0400, Brian Masney wrote:
> > > > Hi Andrew and Iwona,
> > > > 
> > > > On Mon, Sep 15, 2025 at 02:36:48PM +0930, Andrew Jeffery wrote:
> > > > > Hi Brian,
> > > > > 
> > > > > On Sun, 2025-09-14 at 07:56 -0400, Brian Masney wrote:
> > > > > > Hi Iwona, Joel, and Andrew,
> > > > > > 
> > > > > > On Sun, Aug 10, 2025 at 06:21:51PM -0400, Brian Masney wrote:
> > > > > > > The round_rate() clk ops is deprecated, so migrate this
> > > > > > > driver from
> > > > > > > round_rate() to determine_rate() using the Coccinelle
> > > > > > > semantic patch
> > > > > > > appended to the "under-the-cut" portion of the patch.
> > > > > > > 
> > > > > > > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > > > > > 
> > > > > > Would it be possible to get this picked up for v6.18? I'd
> > > > > > like to remove
> > > > > > this API from drivers/clk in v6.19.
> > > > > 
> > > > > My (strong) preference is that Iwona applies it, but I'll keep
> > > > > an eye
> > > > > out for any unusual delays.
> > > > 
> > > > This patch wasn't picked up for v6.18. Any chance this can get
> > > > picked up
> > > > now for v6.19?
> > > > 
> > > > I'm hoping to get this merged so that we can remove the
> > > > round_rate() clk
> > > > op from the clk core. The clk maintainer (Stephen) mentioned this
> > > > work
> > > > in his last pull to Linus.
> > > > 
> > > > https://lore.kernel.org/linux-clk/20251007051720.11386-1-sboyd@kernel.org/
> > > 
> > > Are you happy to pick this up directly in Iwona's absence?
> > 
> > Why me?
> 
> I figured that would be sensible since Iwona historically sent you PRs
> for the PECI subsystem.

I did not remember that, sorry.  The MAINTAINERS file does not mention
this at all, and it lists many other maintainers that should be able to
take this patch:
	$ ./scripts/get_maintainer.pl  drivers/peci/controller/peci-aspeed.c
	Iwona Winiarska <iwona.winiarska@intel.com> (maintainer:ASPEED PECI CONTROLLER)
	Joel Stanley <joel@jms.id.au> (maintainer:ARM/ASPEED MACHINE SUPPORT)
	Andrew Jeffery <andrew@codeconstruct.com.au> (maintainer:ARM/ASPEED MACHINE SUPPORT)
	linux-aspeed@lists.ozlabs.org (moderated list:ASPEED PECI CONTROLLER)
	openbmc@lists.ozlabs.org (moderated list:ASPEED PECI CONTROLLER)
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE SUPPORT)
	linux-kernel@vger.kernel.org (open list)
	ASPEED PECI CONTROLLER status: Supported
	PECI SUBSYSTEM status: Supported
	ARM/ASPEED MACHINE SUPPORT status: Supported

thanks,

greg k-h

