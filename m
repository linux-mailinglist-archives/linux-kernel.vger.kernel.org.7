Return-Path: <linux-kernel+bounces-753444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441EEB1831E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658BA540827
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A226264A7F;
	Fri,  1 Aug 2025 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNi39Z27"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD122586EE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056875; cv=none; b=REOjd+VmJO2gIHJeksmeYS0blNWHslRjUDmWXIcOQJL1YBdhqsKNhv6A8zSJOzWN1S9OXlNDsgBSSnQJ99OYVhL0vezO3LPymG0ds7JdWBEWrV66aB1UJJ1k2QRgDqj+GCwSn6edvGkP8Zk8AMAX+sTe8WdzS3sVjeF3KerMfIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056875; c=relaxed/simple;
	bh=1A0vKq6aLyn928rq+rEroQrfD5FWW0QJIKoi9NpxWDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fie2p48MC3Q04my60FeW8mUz0e9J9FxlBCIou+fap/nN2iBNpHwEgmP/Qwi+lBA+vZsoxReW5qMY/DkeWfsoMPgKPJ0ihTd/+IPiKCFFvuL7HwpLEozZVmQPJ+vH04XT9SyHkFzy1xhf4cNEk0ZOHRwQWKKSPBAI0WL6jykzyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNi39Z27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8757CC4CEF8;
	Fri,  1 Aug 2025 14:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754056874;
	bh=1A0vKq6aLyn928rq+rEroQrfD5FWW0QJIKoi9NpxWDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNi39Z27XOtOYfhgN5Ub2eAx5kpsGAuTxmwMUBwfEjqfBW3BFQbcRxy0Eh1l0Je8l
	 SjJdF/jNlwn2UzmIyeb5YAzy3KgaB/AyiS1sY6WYM8x29ZmoggBWZ3SvfrS1K2+Nhd
	 UT3dtwVpBvI7OkNLTlBNgPfFlfLBh+VsDwnMUhF9GAfJK4Mkp5t6Zkriwvo6Gyuh4A
	 Jq/6/lqJcPLki7/VM6q0GXje61SfXII/sMxoYTPdxUzKoXOeFEj76yQP63wqQ2M8uf
	 AhmBNb4pZ4jtFZg8jjRGUGzrzKL0klu74psO2SzsvQoM+SYKlvGPwWjLIFBy/r5k/3
	 4e5WAuxMAPgqw==
Date: Fri, 1 Aug 2025 16:01:09 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] irqchip/gic-v5: Remove IRQD_RESEND_WHEN_IN_PROGRESS
 for ITS IRQs
Message-ID: <aIzIpbQOcxmWOwvs@lpieralisi>
References: <20250801-gic-v5-fixes-6-17-v1-0-4fcedaccf9e6@kernel.org>
 <20250801-gic-v5-fixes-6-17-v1-3-4fcedaccf9e6@kernel.org>
 <86seib6x7b.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86seib6x7b.wl-maz@kernel.org>

On Fri, Aug 01, 2025 at 01:30:32PM +0100, Marc Zyngier wrote:
> On Fri, 01 Aug 2025 08:58:20 +0100,
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > 
> > GICv5 LPI interrupts have an active state hence they cannot retrigger
> > while the IRQ is being handled.
> > 
> > Therefore setting IRQD_RESEND_WHEN_IN_PROGRESS for GICv5 ITS
> > interrupts provides no benefit and it is useless (and confusing),
> > it solves an issue that cannot happen.
> 
> This doesn't read very well. How about:
> 
> "Therefore, setting the IRQD_RESEND_WHEN_IN_PROGRESS flag on LPIs
>  is pointless, as the situation this flag caters for cannot happen".

Yes it is clearer, I can respin a v2 unless Thomas can update the log
please while applying it ? Just let me know.

Thanks,
Lorenzo

> > Remove it.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/irqchip/irq-gic-v5-its.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
> > index 340640fdbdf6..9290ac741949 100644
> > --- a/drivers/irqchip/irq-gic-v5-its.c
> > +++ b/drivers/irqchip/irq-gic-v5-its.c
> > @@ -973,7 +973,6 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *domain, unsigned int vi
> >  		irqd = irq_get_irq_data(virq + i);
> >  		irqd_set_single_target(irqd);
> >  		irqd_set_affinity_on_activate(irqd);
> > -		irqd_set_resend_when_in_progress(irqd);
> >  	}
> >  
> >  	return 0;
> > 
> 
> With that,
> 
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

