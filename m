Return-Path: <linux-kernel+bounces-753448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDCBB1832A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C08A7A2D9D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02CC266B64;
	Fri,  1 Aug 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhVN12b1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD82264628
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057099; cv=none; b=R2bgG1ZcM+hwmw7ZjZRHlKQyryKLWgG7xR9rTpAmpBOhCiAUrMrObsVBWB7g5X2/BCbzxO0LFIJLdCpT+hqUwB8giMookexgKEZRDvJuE7UtKIPwBOWsr97FV+OzHuD0Pu5TWNZ8+QzMs7/0QqUGDjeX/FDCIrBXcrPTXdjo2T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057099; c=relaxed/simple;
	bh=rhp32RlGZQWi0qaev57mn8Lf6Y/ncV8+flahaYlr1h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlYde2sOAWVyEEEZGAPn47SN+1rVFG0s2KL1OACiwp7Bl/gbxHYrdkgtomK4whPdUmpakUhuTISrhWQIPTVKCHb01502DaVf8WJtmICqxJ4HqksMlJlMkUvrjEFfarrCiXH5zSlNVTu3Ln42CLF6/H8SJ+zQ0f7VhNssDGSYTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhVN12b1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C909CC4CEE7;
	Fri,  1 Aug 2025 14:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754057098;
	bh=rhp32RlGZQWi0qaev57mn8Lf6Y/ncV8+flahaYlr1h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhVN12b1haQLw3UTPQ/OFTK0vLoR4Uo4zSoTd60d5dOaQ1WJlLYg7Qlx1xxKm5s9k
	 vhz9T8jXHuQw46BMDWAadLcZ1IorBaBgg5u4BIc+Rbw5viXuqUgmNNWcrSX++Ryku6
	 g1tsqfwMLbJ6pkrE1gQhSoahrjZ6YspUJh8sCxEI14tNJ7UBKK3imB4/A3PmcD20Qs
	 kLghoGA0WUoDvuDuJBSPaBFIxO14FLmvewJC78oc2WU44eI/REQTvu8QclIRV2Gmlg
	 B1zb/dnAKk2F48m7wtWXmbIUGfSbZ/BX7CqwcmINAjHnDR2dlHh+ChqRpY9Q6U4xK3
	 EmLnOzxuWHD1A==
Date: Fri, 1 Aug 2025 16:04:54 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] irqchip/gic-v5: iwb: Remove module boilerplate
Message-ID: <aIzJhqnooJ/hO2Tv@lpieralisi>
References: <20250801-gic-v5-fixes-6-17-v1-0-4fcedaccf9e6@kernel.org>
 <20250801-gic-v5-fixes-6-17-v1-2-4fcedaccf9e6@kernel.org>
 <86v7n76xgm.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86v7n76xgm.wl-maz@kernel.org>

On Fri, Aug 01, 2025 at 01:24:57PM +0100, Marc Zyngier wrote:
> On Fri, 01 Aug 2025 08:58:19 +0100,
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > 
> > The IWB driver cannot be compiled as a module and is as matter of fact a
> > builtin driver at present.
> 
> What is blocking that?

Yep, you read my mind I need to test this but AFAICS at the moment
the answer is: nothing.

> > Make it explicitly so by removing useless boilerplate and by using the
> > builtin_platform_driver() helper to initialize its registration
> > functions.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/irqchip/irq-gic-v5-iwb.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v5-iwb.c b/drivers/irqchip/irq-gic-v5-iwb.c
> > index ad9fdc14d1c6..c3a3b30e9f4e 100644
> > --- a/drivers/irqchip/irq-gic-v5-iwb.c
> > +++ b/drivers/irqchip/irq-gic-v5-iwb.c
> > @@ -263,7 +263,6 @@ static const struct of_device_id gicv5_iwb_of_match[] = {
> >  	{ .compatible = "arm,gic-v5-iwb" },
> >  	{ /* END */ }
> >  };
> > -MODULE_DEVICE_TABLE(of, gicv5_iwb_of_match);
> >  
> >  static struct platform_driver gicv5_iwb_platform_driver = {
> >  	.driver = {
> > @@ -274,4 +273,4 @@ static struct platform_driver gicv5_iwb_platform_driver = {
> >  	.probe				= gicv5_iwb_device_probe,
> >  };
> >  
> > -module_platform_driver(gicv5_iwb_platform_driver);
> > +builtin_platform_driver(gicv5_iwb_platform_driver);
> > 
> 
> I'd rather we make the driver buildable as a module if at all
> possible, instead of forcing it as built-in for everyone. It would
> definitely help pipe-cleaning the potential missing dependencies.

Yes - I took a shortcut by removing boilerplate (that the
compiler/linker remove anyway) - it makes sense to rework the
build to make it possible to build as a module instead.

This patch can be dropped then, I will work on the follow-up.

Lorenzo

