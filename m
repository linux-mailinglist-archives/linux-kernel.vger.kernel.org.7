Return-Path: <linux-kernel+bounces-723441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CC1AFE6DA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FFF169262
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB780237713;
	Wed,  9 Jul 2025 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jDky5j9f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A56286892;
	Wed,  9 Jul 2025 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059067; cv=none; b=XyTgD4sN96YbK1iQ1MQAgg+QDhHhWGBMGjUyvw+hN+wzrPlbap5FDOFiKx1LxCDmvIfsHU/6nPsny0LyGp5Ivuc0eqjURfXb+L9tHUsizrD1PdpM9a/RdG4/8YCD1COlJQK4aLV9oymox6haYBojSW2g9FTOmLA7PSBPtrSBYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059067; c=relaxed/simple;
	bh=G9z/hxPCD8cUfyP4wAboIFpKkrFJ0muA+l4VWXBKGBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovlT+OFTKxEJCPrCZnhgBQQSyZtpAyfsjfjpuyBwAuHFI3XPu0T5jC7SxfMERMMvt3WYgieVY5HyCT43czZMEroB/R4xoIdLLHnJZ+mWs5ahy5f9gQCUydKWA3iHaOi08Blsz9d3pM+INs4naZKWpA6LCasRRmpwxgv8gGIdUsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jDky5j9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD3CC4CEEF;
	Wed,  9 Jul 2025 11:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752059066;
	bh=G9z/hxPCD8cUfyP4wAboIFpKkrFJ0muA+l4VWXBKGBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDky5j9fmCJBev2Gmm88KZP8/4w3PNlRZ6zKAZ2E8XmMoSG9oksxCOg2jLyOQ1U+/
	 5wZ8gEWvy3nNWiiUbgDsqau0D7QEkO1vUjU2saYuL7IupJZVN5oTnv+sGhqbuUD+np
	 Pe44+Tb2sJkpBv5OyeDFDQONykCQ0CSGs0VpZ9z8=
Date: Wed, 9 Jul 2025 13:04:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Penkler <dpenkler@gmail.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: gpib: Fix error handling paths in
 cb_gpib_probe()
Message-ID: <2025070900-founder-boastful-66cf@gregkh>
References: <bf89d6f2f8b8c680720d02061fc4ebdd805deca8.1751709098.git.christophe.jaillet@wanadoo.fr>
 <8f8130b2-fec1-48bc-944e-e676a1715c31@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f8130b2-fec1-48bc-944e-e676a1715c31@bootlin.com>

On Sat, Jul 05, 2025 at 04:17:35PM +0200, Thomas Richard wrote:
> Hi Christophe,
> 
> On 7/5/25 11:52 AM, Christophe JAILLET wrote:
> > If cb_gpib_config() fails, 'info' needs to be freed, as already done in the
> > remove function.
> > 
> > While at it, remove a pointless comment related to gpib_attach().
> > 
> > Fixes: e9dc69956d4d ("staging: gpib: Add Computer Boards GPIB driver")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Changes in v2:
> >   - Fix the Fixes tag   [Thomas Richard]
> >   - Synch with latest -next
> >   - no compile tested. I think, thanks to commit 79d2e1919a27
> >     ("staging: gpib: fix Makefiles")
> > 
> > v1: https://lore.kernel.org/all/459c267de8c9bf48fcb555364930ae7e3cdc798b.1729940596.git.christophe.jaillet@wanadoo.fr/
> > 
> > Compile tested only.
> > ---
> >  drivers/staging/gpib/cb7210/cb7210.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
> > index 298ed306189d..3e2397898a9b 100644
> > --- a/drivers/staging/gpib/cb7210/cb7210.c
> > +++ b/drivers/staging/gpib/cb7210/cb7210.c
> > @@ -1184,8 +1184,7 @@ struct local_info {
> >  static int cb_gpib_probe(struct pcmcia_device *link)
> >  {
> >  	struct local_info *info;
> > -
> > -//	int ret, i;
> > +	int ret;
> >  
> >  	/* Allocate space for private device-specific data */
> >  	info = kzalloc(sizeof(*info), GFP_KERNEL);
> 
> You should use devm_kzalloc(). The memory will be automatically freed by
> the core. So no need to call kfree() in case of error during the probe.
> And you can remove the kfree() in cb_gpib_remove().

Some people, myself include, hate the devm_*() apis, so no need to force
them on anyone please :)

thanks,

greg k-h

