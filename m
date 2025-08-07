Return-Path: <linux-kernel+bounces-759557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D10C7B1DF35
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 00:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09075582BED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0A51E5B94;
	Thu,  7 Aug 2025 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2biy0is"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E11482EB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754604149; cv=none; b=g/0GxHpA5EA3LhtoL7MkHPecNKBWm6NwCeMuRdVI5j3p4qveXOdd8wUiHsuZhI+U8Dh0Mmjr+1zJMBxFh6OAJFxW7e5m+D9Bc+m6oKH8V62Cs3T+lkm0CePlLNkM0wVPKeN7lJT/GDzy89HFQGDXD6t3MzkgH0HvwmzaKZ9kXWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754604149; c=relaxed/simple;
	bh=PEzSLKJHq1B3uJLxOvBXRklrXL5wkBhF7A4Yun9c59Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3U3FVHwNIKRh2jqrOqZwk5+gkQUllaGqj2RT9WG5Yur9qLdbg0ZXgxSflHi/GqMb5nXC0Vf62iP/3LbPV/raCixKMENx8Cas6fDpkJNZ+cH5o290ulpVMs3Gy+4ewC6h0NJq0G8l4IoVMtPij/6jlw3RYCQovqOuqbArUF6N0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2biy0is; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55b823c9129so1543835e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 15:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754604146; x=1755208946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=avU98ttBLtIvdyvPJMGprxMYrTMdHK1g7EvVWfIGfOU=;
        b=m2biy0issmmRiOPZfirYPlEuR1ETAI2AcALlKKbgTzW9tj+iBXyuuOTo556GBMd6za
         AjuLmYqfyJDEPbK1gV7/c1vSB7zyaV+4hn/PMN9HBHyA37XkHeB+YxePOQWkxsHy3lzY
         ZdUXXJxUsOy6ypb714gMCtZVYAtrzcKRT1j2a+/HfIU6ufoU43mGg4B7ZFCisRqzzrDR
         O1IU3zBLuJD0tDqoTmA6mYbBrN84fRWlpYuQtwDbrhzs7RriIERvS6AAoYx3/XKcKPRG
         pVah6/cMmUZZDU1h/WwtCIqXPIhs++EQculY3HrHYCri+14nInT5w5w4NpKVgJppiw8b
         6Emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754604146; x=1755208946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avU98ttBLtIvdyvPJMGprxMYrTMdHK1g7EvVWfIGfOU=;
        b=P8HSoHtUmxF7d8XHU1jGAh9LT6A9msAAHvHbXggmoiIMOBpmNn6+GiH3/RWmD4MKki
         L4OO/I85PR/f3xq1JPIMMpc+tWynNAMVPucMZ1wrbBVIx19pMlZfePDfwO2uBOpVqJPn
         oyYfRh03KDulA6GIHlXyoQF/n3P48dsMjsLsJNH/rpVniJLOcm+gxCJSGbWcgzZxbqXx
         rSOKwuU4J/MN+W1Q+PMo9UEabpwuFq0fJc5BqSmGDJ/Gtg4zd3HB7qYOHII/tog1gwOo
         0rqRnCQ5pMempL+tDDe6ApXHy0QB89tS7Gg2nayZrpy+Wrx4uxT6moXuWEOhgSbGmzLq
         TEvg==
X-Gm-Message-State: AOJu0Yw/gAr0NGwGxxVlfcMOfZPoNm7LQj5MT5JLYBNAcGXXaWjS08eC
	FcEtMEEQF6yy3FMsIhiyyjdwq7MlKBI12+XSl42RLH6WhiLg3it6aQ1R
X-Gm-Gg: ASbGncsscQUmUCPbv/vbihCO7Ia/dwdNn9nb8J1GemJbyL66yNzcpmQvk54CQCQumpi
	Qlw3DeT7coZgTubZIhpacCeoCijEswPQJbuA6OC0zAi8hvGWAbLM2Y4o8zMM6wTC1lUgMoikrqY
	zDYpssLKi5or+fZoPqIB9026N54eGlhOVZDqSncbhPrMK1C5BPB60/MIS8R1bJI2xsHWjiVLCEO
	agg7FfBbi+amslJKutMMF19IZWgzSjbmfI4km7Nyon59VGHR2wb7paJDxr4gRQ3PBhJpyU/KFC+
	AXJTeu2coGRxCuIJ9od67/xQt2XgLU/TypptaZoN2v/3cd05i7um3KRF9bLOV02TFOEOljJTvN/
	KYYnmTTDot0cyPgE6oyYuRr3ypvpeJdZf
X-Google-Smtp-Source: AGHT+IHrSlgT91DmFGc7QbYqpGLkkw0UvA0xvI/15T5zYAmuonH256/5HgVY0NHOfuAFPEwun5hM6Q==
X-Received: by 2002:a05:6512:3f10:b0:55b:842d:5825 with SMTP id 2adb3069b0e04-55cc0135fc8mr109358e87.43.1754604145361;
        Thu, 07 Aug 2025 15:02:25 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-55b88ca35e7sm2752896e87.134.2025.08.07.15.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 15:02:23 -0700 (PDT)
Date: Fri, 8 Aug 2025 06:01:39 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Nam Cao <namcao@linutronix.de>, Inochi Amaoto <inochiama@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Respect mask state when setting
 affinity
Message-ID: <nowqjgxmomniw624avrizohwzzq7ebkznb64m25qim3zgxjacn@oizd7ngxjd6a>
References: <20250807111806.741706-1-inochiama@gmail.com>
 <87fre3mhkh.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fre3mhkh.fsf@yellow.woof>

On Thu, Aug 07, 2025 at 02:39:42PM +0200, Nam Cao wrote:
> Inochi Amaoto <inochiama@gmail.com> writes:
> 
> > The plic_set_affinity always call plic_irq_enable(), which clears up
> > the priority setting even the irq is only masked. This make the irq
> > unmasked unexpectly.
> >
> > Replace the plic_irq_enable/disable() with plic_irq_toggle() to
> > avoid changing priority setting.
> >
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index bf69a4802b71..5bf5050996da 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -148,6 +148,7 @@ static void plic_irq_enable(struct irq_data *d)
> >  
> >  static void plic_irq_disable(struct irq_data *d)
> >  {
> > +	plic_irq_mask(d);
> >  	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
> >  }
> 
> This part is not required for the problem you are addressing, right?
> 
> I do not oppose the change, I'm just curious if I miss something here.
> 

It is true, this is added because it is needed to follow
the disable required of the irqchip. I think it is better
to split to a separate one.

> >  
> > @@ -179,12 +180,14 @@ static int plic_set_affinity(struct irq_data *d,
> >  	if (cpu >= nr_cpu_ids)
> >  		return -EINVAL;
> >  
> > -	plic_irq_disable(d);
> > +	/* Invalidate the original routing entry */
> > +	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
> >  
> >  	irq_data_update_effective_affinity(d, cpumask_of(cpu));
> >  
> > +	/* Setting the new routing entry if irq is enabled */
> >  	if (!irqd_irq_disabled(d))
> > -		plic_irq_enable(d);
> > +		plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 1);
> >  
> >  	return IRQ_SET_MASK_OK_DONE;
> >  }
> 
> This part makes sense:
> 
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Tested-by: Nam Cao <namcao@linutronix.de> # VisionFive 2

