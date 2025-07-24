Return-Path: <linux-kernel+bounces-743413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380D3B0FE5F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334EC3B6ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE514B08A;
	Thu, 24 Jul 2025 01:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEIFRTxt"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE5188000
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753320990; cv=none; b=lR65LIeuHxDwkopmZ5T5b9GX3xbKtnVaeS6yuEB7tKH0m05p0MAvGmDkWlJRH2Utm/IbymxQoGhgNX0UmjOO64av2gfx4UUUnQs10J/OH1s5kCBNbxEdJGOqUl43+KANKFPLNiQgVVE8QS31y1anxu6c6hA9rgrqYSSf4qLzfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753320990; c=relaxed/simple;
	bh=LpjMFbE0AWlFtI4ADPoDe4Yf9xZKpfvqrho3KD5mL8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVRSC3s8m/sr5V8Wte0c6rbktcuDF0UiT+D4lkL6fq24OsTEOcUZe/aixQvHNJan0DB/wQf04ZGy2Pi24/e+EAWd8yQttqCVF4woSDOlrPZkGeVgTzPy/UNTSDQ4SwA6hE5iYxpje0wEX88h8CzvWU4z80PKkvWJFmMBwdFApHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEIFRTxt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23e210ebd5dso12255885ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753320987; x=1753925787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+wZXwZrMhUJDKmhBPJ6rht7dEKowJUJhM6aMeIhgyo=;
        b=VEIFRTxttLYae3KbFqNE1SRRlmWH1v0WetUq1cYnz6hjZjwEkht7C1+/El+u/MXQQv
         gtdJPdIiD4I9cgXEFSQmX2f7Z45iyGb/iMAPWforegr/kequKnqWoHeuJvwB00fnEY/9
         Wl+hrlPqjB3lUxs1i2z6KSaYTIWepJWnA8TGxWEYzN6SNzjnbNON6wO5rldaLnyuke0J
         wvbaGWUP5ZFyBv3OCXJ/nBJGVMhGIsiC8u4XrLRG7m6+Q8E/FS/ZNEK/RrWFlKttpRT7
         5h/f4PdqAk63HXnhr4fRMYgnk9F+2ehJD04bCWGNEv/zd8sFJqyoxQIOoy5BtgK29GHq
         8fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753320987; x=1753925787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+wZXwZrMhUJDKmhBPJ6rht7dEKowJUJhM6aMeIhgyo=;
        b=Fh+j1kahh6XyzeQR6TvXstT3CIjBTrWoXGdBUQ7jNXEvMJ3BTdh4pIzC3gEKFb+bMz
         7wf415rBcOJT2BbqkvUHWhXKL26rS4JaEIVI0t362MuGLkSBFWeKil1MnHh17tRWVllf
         dtQZj9SYum1iqitgOVlUJFmpokXo3QKuDr6nZIlMlXoTtr84KBp7sYzAAj1or3NrhzYJ
         c96IXq2y9GOCbxGYEEh3od/PAWhxUWiTdD9v/24NwTkuuXVSfHpaXTJIvuN+E0jHWo9N
         BJFQD8kZGztGvSryfiv5aI4yrRtB11Eu13yucKu7RJ5yJxLhGL5e2uLm8iRQzoF12qTy
         CbiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGBL8z/SbUqAXBjlrgdqEJkbdXJu97r4HY5VQGXWIEvd2DDWVo+cbFILI2B2UIYTxboCA8yKMXRm07SOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+MhlQbL9NzcVda5WBSl8wgBA+VLNyA+zKFrDBawjDv0dQgX+U
	6CLTAYp44VheA04vLIv2hUGf4rUsK00ldIJp69Mz6eRlheTMY7PtAjdg
X-Gm-Gg: ASbGnctsMFOBoK+UBuxdX0vFPGmBux9HBIoD1ulGQAXsZd278n+dGe9KoqnqH63oO36
	8VA2MdoMUdHr52jSb9PEFvhWTiz7fs5Ge81ItAK3BbAsnw0hAkjqCIFqqWnqoAsOHh+IbKNgEMF
	7wIfo4W+IjmeOPdDmcyPwoTuVMANJkl7rf5OGzlo3Nm0c/QVaYrljNidLIkpCdV+pD3xuZ3kT8o
	lfXZnXy+MsKE6z1cWZxLWC+wZMdijThFE9k93sR0GEujWu9h8vIyG59KBAVhZ+sPAYkY4p5l6UX
	jz47tngQOjEcN1t6HKtSSASd5fqaK5GYPHsqaIV+yz55OytxsVOwQblfgfJtg8R0hBSgrVoXSvH
	JVxMQRdeg3AjzxX4j59cswQ==
X-Google-Smtp-Source: AGHT+IHGoXE+ack7oNwMlA4/Q2E95WB29LBaEnuKnKG4li283t1OpXFou2wgKtMuM/x5v3fOL3rLXA==
X-Received: by 2002:a17:903:15c7:b0:232:59b:5923 with SMTP id d9443c01a7336-23fa5d9867cmr2770275ad.23.1753320987089;
        Wed, 23 Jul 2025 18:36:27 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23fa4786017sm2757755ad.79.2025.07.23.18.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 18:36:26 -0700 (PDT)
Date: Thu, 24 Jul 2025 09:35:59 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Inochi Amaoto <inochiama@gmail.com>, linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Marc Zyngier <maz@kernel.org>, Nam Cao <namcao@linutronix.de>
Subject: Re: Affinity setting problem for emulated MSI on PLIC
Message-ID: <lsdrgyvr27saibfibbxrh732icm4ghumx5tuisdv7pvpmqfobi@un7wjzwabygw>
References: <20250722224513.22125-1-inochiama@gmail.com>
 <87tt32r082.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tt32r082.ffs@tglx>

On Thu, Jul 24, 2025 at 12:50:05AM +0200, Thomas Gleixner wrote:
> Cc'ing more people as this goes way beyond the SG204x driver
> 
> On Wed, Jul 23 2025 at 06:45, Inochi Amaoto wrote:
> > SG2044 and SG2042 has a msi controller that converts the PLIC interrupt
> > to a MSI one. It works at the most case, but failed when probing NVME.
> > The driver complains "nvme nvme0: I/O tag XXX (XXX) QID XX timeout,
> > completion polled". After some test, I found this is caused by some
> > broken interrupt, which is disable on the underlying PLIC chip after
> > setting affinity. As the MSI chip does not have a enable function,
> > irq_startup only calls irq_unmask. This make the underlying interrupt
> > at PLIC is not enabled.
> 
> So how did that stuff ever work?
> 
> > I have done a hack by changing the mask/unmask to disable/enable and
> > setting MSI_FLAG_PCI_MSI_MASK_PARENT to solve this and it works.
> 
> That flag should have been set from the very beginning - I missed it
> when merging the original SG2042 driver. :(
> 
> It needs that flag too. Otherwise the chip's irq_mask/unmask functions
> are never invoked from the PCI layer.
> 
> Aside of that SG2042 suffers from exactly the same enable problem as
> SG2044 because both rely on the sifive-plic driver.
> 
> May I ask the obvious question:
> 
>     How did this obviously disfunctional driver gain Tested-by and other
>     relevant tags?
> 
> > But I wonder whether there is something better to solve this problem?
> > (The hack I have done is at the end of mail)
> 
> It's a horrible hack as you know already :)
> 
> > --- a/drivers/irqchip/irq-sg2042-msi.c
> > +++ b/drivers/irqchip/irq-sg2042-msi.c
> > @@ -94,6 +94,20 @@ static const struct irq_chip sg2042_msi_middle_irq_chip = {
> >  	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
> >  };
> >
> > +/*
> > + * As PLIC can only apply affinity when enabling, so always call enable
> > + * when unmasking interrupt.
> 
> This comment is misleading at best.
> 
> The point is that PLIC needs two things to enable an interrupt:
> 
>     1) Enable the routing bit for the target CPU
> 
>     2) Unmask the interrupt by fiddling with the priority register
> 
> The PLIC driver does #1 and #2 in the irq_enable() callback, but only #2
> in the irq_unmask() callback. That's obviously done to avoid fiddling
> with the routing bit and the related lock for every mask/unmask
> operation.
> 
> > +static void sg2044_msi_irq_mask(struct irq_data *d)
> > +{
> > +	irq_chip_disable_parent(d);
> 
> This is a blatant violation of the interrupt hierarchy and you are well
> aware of it.
> 
> There is a reason why there are these different callbacks...
> 
> > +static void sg2044_msi_irq_unmask(struct irq_data *d)
> > +{
> > +	irq_chip_enable_parent(d);
> > +}
> > +
> >  static void sg2044_msi_irq_ack(struct irq_data *d)
> >  {
> >  	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
> > @@ -115,8 +129,8 @@ static void sg2044_msi_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *m
> >  static struct irq_chip sg2044_msi_middle_irq_chip = {
> >  	.name			= "SG2044 MSI",
> >  	.irq_ack		= sg2044_msi_irq_ack,
> > -	.irq_mask		= irq_chip_mask_parent,
> > -	.irq_unmask		= irq_chip_unmask_parent,
> > +	.irq_mask		= sg2044_msi_irq_mask,
> > +	.irq_unmask		= sg2044_msi_irq_unmask,
> 
> Again. Why only for SG2044?
> 
> Fact is that the PLIC requires irq_enable() to be invoked to get the
> interrupt started, which is never invoked as the PCI/MSI chips do not
> populate that callback. So SG2042 _must_ be affected as well, no?
> 
> PCI/MSI interrupts won't ever populate irq_[en|dis]able() because that
> prevents the core code from lazy masking the interrupt on disable_irq()
> in order to spare an enable_irq() when no interrupt is raised by the
> device between the disable and the enable operation.
> 
> That stays a fact unless someone rewrites the historicaly grown logic of
> that stuff from ground up, which requires to audit every single irqchip
> driver in tree. At some point we probably have to do that, but my
> copious spare time is definitely not going to be wasted on that.
> 
> As this is only related to the startup/shutdown phase of an interrupt,
> the obvious solution is to populate the irq_startup() and irq_shutdown()
> callbacks in the PCI layer.
> 
> That requires:
> 
>    - making the PCI/MSI code populate those callbacks with straight
>      forward helpers in the core interrupt code for startup/shutdown and
>      only invoke those helpers when MSI_FLAG_PCI_MSI_MASK_PARENT is set.
> 
>      That's also the proper mechanism to solve Marc's problem in
> 
>        https://lore.kernel.org/all/20250517103011.2573288-1-maz@kernel.org
> 
>      as it allows to conditionally overwrite the irq_[un]mask()
>      callbacks of the PCI/MSI[-X] chip with irq_chip_[un]mask_parent().
>      Obviously not based on MSI_FLAG_PCI_MSI_MASK_PARENT. That needs a
>      new flag to opt in, but that's a minor detail.
> 
>      This has no impact on any other driver AFAICT, but that obviously
>      needs to be looked at with a less sleep deprived brain.
> 
>    - the PLIC driver to switch the irq_[en|dis]able() callbacks over to
>      irq_shutdown/startup(), which needs some extra care to handle
>      interrupt affinity settings, which is an interesting issue by
>      itself. See the large comment I left in the patch below.
> 
>    - to update the SG204x driver accordingly
> 
> See below for a completely uncompiled and therefore untested patch,
> which needs to be split up into a gazillion of patches obviously. As it
> is uncompiled and untested, you can keep the bugs for yourself and fix
> them.
> 
> There is a big fat comment in the PLIC driver related section, which is
> just a notepad to dump my findings and thoughts for posterity. That part
> was broken before. It is really scary and needs some real scrunity
> beyond the "works for me" and "looks good" mindset. I don't care much as
> I wasted enough time on this already, but I have to admit that looking
> at this mess inspired me to find a non-horrible solution for the problem
> Marc is trying to solve (not that I tried really hard before...).
> 
> Obviously none of that PLIC/SG204x stuff is going near any tree anytime
> soon. The SG204x driver has been broken since it was merged half a year
> ago without anyone noticing, so there is no rush to fix it. Same for the
> PLIC muck.
> 
> The generic and PCI/MSI[-X] changes have a value on their own and are
> sane enough to go forward independent of that, once I come around to
> split them out with proper change logs unless someone beats me to it.
> 
> Thanks,
> 
>         tglx
> ---
> --- a/drivers/irqchip/irq-sg2042-msi.c
> +++ b/drivers/irqchip/irq-sg2042-msi.c
> @@ -86,6 +86,8 @@ static void sg2042_msi_irq_compose_msi_m
>  static const struct irq_chip sg2042_msi_middle_irq_chip = {
>  	.name			= "SG2042 MSI",
>  	.irq_ack		= sg2042_msi_irq_ack,
> +	.irq_startup		= irq_chip_startup_parent,
> +	.irq_shutdown		= irq_chip_shutdown_parent,
>  	.irq_mask		= irq_chip_mask_parent,
>  	.irq_unmask		= irq_chip_unmask_parent,
>  #ifdef CONFIG_SMP
> @@ -115,6 +117,8 @@ static void sg2044_msi_irq_compose_msi_m
>  static struct irq_chip sg2044_msi_middle_irq_chip = {
>  	.name			= "SG2044 MSI",
>  	.irq_ack		= sg2044_msi_irq_ack,
> +	.irq_startup		= irq_chip_startup_parent,
> +	.irq_shutdown		= irq_chip_shutdown_parent,
>  	.irq_mask		= irq_chip_mask_parent,
>  	.irq_unmask		= irq_chip_unmask_parent,
>  #ifdef CONFIG_SMP
> @@ -186,7 +190,8 @@ static const struct irq_domain_ops sg204
>  };
>  
>  #define SG2042_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
> -				   MSI_FLAG_USE_DEF_CHIP_OPS)
> +				   MSI_FLAG_USE_DEF_CHIP_OPS |	\
> +				   MSI_FLAG_PCI_MSI_MASK_PARENT)
>  
>  #define SG2042_MSI_FLAGS_SUPPORTED MSI_GENERIC_FLAGS_MASK
>  
> @@ -201,7 +206,8 @@ static const struct msi_parent_ops sg204
>  };
>  
>  #define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
> -				   MSI_FLAG_USE_DEF_CHIP_OPS)
> +				   MSI_FLAG_USE_DEF_CHIP_OPS |	\
> +				   MSI_FLAG_PCI_MSI_MASK_PARENT)
>  
>  #define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
>  				    MSI_FLAG_PCI_MSIX)
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -140,14 +140,16 @@ static void plic_irq_mask(struct irq_dat
>  	writel(0, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
>  }
>  
> -static void plic_irq_enable(struct irq_data *d)
> +static unsigned int plic_irq_startup(struct irq_data *d)
>  {
>  	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
>  	plic_irq_unmask(d);
> +	return 0;
>  }
>  
> -static void plic_irq_disable(struct irq_data *d)
> +static void plic_irq_shutdown(struct irq_data *d)
>  {
> +	plic_irq_mask(d);
>  	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
>  }
>  
> @@ -179,12 +181,57 @@ static int plic_set_affinity(struct irq_
>  	if (cpu >= nr_cpu_ids)
>  		return -EINVAL;
>  
> -	plic_irq_disable(d);
> +	/* Invalidate the original routing entry */
> +	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
>  
>  	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>  
> -	if (!irqd_irq_disabled(d))
> -		plic_irq_enable(d);
> +	/*
> +	 * Update the routing entry for the new target CPU.
> +	 *
> +	 * The below comment is not for a final patch, it's just
> +	 * documentation for this combo patch, which obviously needs to be
> +	 * split up into a gazillion of patches. So I use this as a notepad
> +	 * in order to not forget the gory details, which are changelog
> +	 * material :)
> +	 *
> +	 * This is on purpose not bug compatible with the current
> +	 * implementation, which unmasked the interrupt unconditionally due
> +	 * to:
> +	 *
> +	 *	if (!irqd_irq_disabled(d))
> +	 *		plic_irq_enable(d);
> +	 *
> +	 * which is broken as it unconditionally unmasks a masked
> +	 * interrupt. This was introduced with commit
> +	 *
> +	 * 6b1e0651e9ce ("irqchip/sifive-plic: Unmask interrupt in plic_irq_enable()")
> +	 *
> +	 * which in turn tried to fix the problem, which was introduced by
> +	 * commit
> +	 *
> +	 * a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask operations")
> +	 *
> +	 * 6b1e0651e9ce is probably harmless, but I'm too tired and can't
> +	 * be bothered to validate it. See below.
> +	 *
> +	 * This all needs real scrutiny and has to be validated against
> +	 * both specification and implementations.
> +	 *
> +	 * AFAICT, toggling unconditionally is the right thing to do, but I
> +	 * might be completely wrong as ususal. For me the two mentioned
> +	 * commits above seem to be contradictionary, but my tired brain
> +	 * can't decode it right now and therefore I leave that for the
> +	 * PLIC wizards as _their_ homework. Not that I have high
> +	 * expectations on that given the trail of Tested-by and other
> +	 * tags. "Works for me" by some definition of "works" seems to be
> +	 * the prevailing principle here. "Correctness first" is obviously
> +	 * overrated as usual up to the point where the real great hacks
> +	 * come along to "fix" the resulting sh*t. Unfortunately that costs
> +	 * the time of people, who have not been responsible for the
> +	 * problems in the first place...
> +	 */
> +	plic_irq_toggle(cpumask_of(cpu), d, 1);
>  
>  	return IRQ_SET_MASK_OK_DONE;
>  }
> @@ -192,8 +239,8 @@ static int plic_set_affinity(struct irq_
>  
>  static struct irq_chip plic_edge_chip = {
>  	.name		= "SiFive PLIC",
> -	.irq_enable	= plic_irq_enable,
> -	.irq_disable	= plic_irq_disable,
> +	.irq_startup	= plic_irq_startup,
> +	.irq_shutdown	= plic_irq_shutdown,
>  	.irq_ack	= plic_irq_eoi,
>  	.irq_mask	= plic_irq_mask,
>  	.irq_unmask	= plic_irq_unmask,
> @@ -207,8 +254,8 @@ static struct irq_chip plic_edge_chip =
>  
>  static struct irq_chip plic_chip = {
>  	.name		= "SiFive PLIC",
> -	.irq_enable	= plic_irq_enable,
> -	.irq_disable	= plic_irq_disable,
> +	.irq_startup	= plic_irq_startup,
> +	.irq_shutdown	= plic_irq_shutdown,
>  	.irq_mask	= plic_irq_mask,
>  	.irq_unmask	= plic_irq_unmask,
>  	.irq_eoi	= plic_irq_eoi,
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -148,6 +148,23 @@ static void pci_device_domain_set_desc(m
>  	arg->hwirq = desc->msi_index;
>  }
>  
> +static inline void cond_shutdown_parent(struct irq_data *data)
> +{
> +	struct msi_domain_info *info = data->domain->host_data;
> +
> +	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> +		irq_chip_shutdown_parent(data);
> +}
> +
> +static inline unsigned int cond_startup_parent(struct irq_data *data)
> +{
> +	struct msi_domain_info *info = data->domain->host_data;
> +
> +	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> +		return irq_chip_startup_parent(data);
> +	return 0;
> +}
> +
>  static __always_inline void cond_mask_parent(struct irq_data *data)
>  {
>  	struct msi_domain_info *info = data->domain->host_data;
> @@ -164,6 +181,23 @@ static __always_inline void cond_unmask_
>  		irq_chip_unmask_parent(data);
>  }
>  
> +static void pci_irq_shutdown_msi(struct irq_data *data)
> +{
> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
> +
> +	pci_msi_mask(desc, BIT(data->irq - desc->irq));
> +	cond_shutdown_parent(data);
> +}
> +
> +static unsigned int pci_irq_startup_msi(struct irq_data *data)
> +{
> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
> +	unsigned int ret = cond_startup_parent(data);
> +
> +	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
> +	return ret;
> +}
> +
>  static void pci_irq_mask_msi(struct irq_data *data)
>  {
>  	struct msi_desc *desc = irq_data_get_msi_desc(data);
> @@ -194,6 +228,8 @@ static void pci_irq_unmask_msi(struct ir
>  static const struct msi_domain_template pci_msi_template = {
>  	.chip = {
>  		.name			= "PCI-MSI",
> +		.irq_startup		= pci_irq_startup_msi,
> +		.irq_shutdown		= pci_irq_shutdown_msi,
>  		.irq_mask		= pci_irq_mask_msi,
>  		.irq_unmask		= pci_irq_unmask_msi,
>  		.irq_write_msi_msg	= pci_msi_domain_write_msg,
> @@ -210,6 +246,20 @@ static const struct msi_domain_template
>  	},
>  };
>  
> +static void pci_irq_shutdown_msix(struct irq_data *data)
> +{
> +	pci_msix_mask(irq_data_get_msi_desc(data));
> +	cond_shutdown_parent(data);
> +}
> +
> +static unsigned int pci_irq_startup_msix(struct irq_data *data)
> +{
> +	unsigned int ret = cond_startup_parent(data);
> +
> +	pci_msix_unmask(irq_data_get_msi_desc(data));
> +	return ret;
> +}
> +
>  static void pci_irq_mask_msix(struct irq_data *data)
>  {
>  	pci_msix_mask(irq_data_get_msi_desc(data));
> @@ -233,6 +283,8 @@ static void pci_msix_prepare_desc(struct
>  static const struct msi_domain_template pci_msix_template = {
>  	.chip = {
>  		.name			= "PCI-MSIX",
> +		.irq_startup		= pci_irq_startup_msix,
> +		.irq_shutdown		= pci_irq_shutdown_msix,
>  		.irq_mask		= pci_irq_mask_msix,
>  		.irq_unmask		= pci_irq_unmask_msix,
>  		.irq_write_msi_msg	= pci_msi_domain_write_msg,
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -669,6 +669,8 @@ extern int irq_chip_set_parent_state(str
>  extern int irq_chip_get_parent_state(struct irq_data *data,
>  				     enum irqchip_irq_state which,
>  				     bool *state);
> +extern unsigned int irq_chip_startup_parent(struct irq_data *data);
> +extern void irq_chip_shutdown_parent(struct irq_data *data);
>  extern void irq_chip_enable_parent(struct irq_data *data);
>  extern void irq_chip_disable_parent(struct irq_data *data);
>  extern void irq_chip_ack_parent(struct irq_data *data);
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -1254,9 +1254,47 @@ int irq_chip_get_parent_state(struct irq
>  EXPORT_SYMBOL_GPL(irq_chip_get_parent_state);
>  
>  /**
> - * irq_chip_enable_parent - Enable the parent interrupt (defaults to unmask if
> - * NULL)
> + * irq_chip_startup_parent - Startup the parent interrupt
>   * @data:	Pointer to interrupt specific data
> + *
> + * Invokes the irq_startup() callback of the parent if available or falls
> + * back to irq_chip_enable_parent().
> + */
> +unsigned int irq_chip_startup_parent(struct irq_data *data)
> +{
> +	struct irq_data *parent = data->parent_data;
> +
> +	if (parent->chip->irq_startup)
> +		return parent->chip->irq_startup(parent);
> +	irq_chip_enable_parent(data);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(irq_chip_startup_parent);
> +
> +/**
> + * irq_chip_shutdown_parent - Shutdown the parent interrupt
> + * @data:	Pointer to interrupt specific data
> + *
> + * Invokes the irq_shutdown() callback of the parent if available or falls
> + * back to irq_chip_disable_parent().
> + */
> +void irq_chip_shutdown_parent(struct irq_data *data)
> +{
> +	struct irq_data *parent = data->parent_data;
> +
> +	if (parent->chip->irq_shutdown)
> +		parent->chip->irq_shutdown(parent);
> +	else
> +		irq_chip_disable_parent(data);
> +}
> +EXPORT_SYMBOL_GPL(irq_chip_shutdown_parent);
> +
> +/**
> + * irq_chip_enable_parent - Enable the parent interrupt
> + * @data:	Pointer to interrupt specific data
> + *
> + * Invokes the irq_enable() callback of the parent if available or falls
> + * back to the irq_unmask() callback.
>   */
>  void irq_chip_enable_parent(struct irq_data *data)
>  {
> @@ -1269,9 +1307,11 @@ void irq_chip_enable_parent(struct irq_d
>  EXPORT_SYMBOL_GPL(irq_chip_enable_parent);
>  
>  /**
> - * irq_chip_disable_parent - Disable the parent interrupt (defaults to mask if
> - * NULL)
> + * irq_chip_disable_parent - Disable the parent interrupt
>   * @data:	Pointer to interrupt specific data
> + *
> + * Invokes the irq_disable() callback of the parent if available or falls
> + * back to the irq_mask() callback.
>   */
>  void irq_chip_disable_parent(struct irq_data *data)
>  {
> 

Hi, Wang

Would you like to explain something related to the SG2042?
I think it is also affected too.

Regars,
Inochi

