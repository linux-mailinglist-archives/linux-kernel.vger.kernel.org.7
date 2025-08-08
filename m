Return-Path: <linux-kernel+bounces-759597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1455FB1DFE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 02:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283617A1C18
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 00:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD2020E6;
	Fri,  8 Aug 2025 00:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/wkwnEY"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B62B645
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 00:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754611760; cv=none; b=YScVH5l1wszfr9rr0jPGxcmlpbpveq66gX+aRXmW3DrvLomHE547iKl2JAOV5UA8VHUUrVi6ainFA/8MlkHH/PVca6B6Ap+AfOHxUlGKfKerzouVDCPij+JQnGi0rZLRukdPrSxnOljdDTSgW0sYwGwTsRTOVQBnbtmuLaZtLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754611760; c=relaxed/simple;
	bh=Do8ATne/4puM/pMo/8dRASuXLizb/3s8WlL7mdq3pBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f60IzpiDkqG5TiiICtwDse0ffD8KotkQQVUcL+z0+3ZiZGFzZkLkoruNv6hu2P4RYuXgL1Bvnl8wgCmlgNHzJ0F+2gYwl6NQE7ZABfn1IkVUv8I+e55grCe+XB3K3EMcNA+qGuLlbFC/+w/9dQUhNaK7JqgPEqVv6ELOoFPfn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/wkwnEY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b427094abdeso1460996a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 17:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754611758; x=1755216558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXd2+hikVHn0DCUK47UPFJHxdRXV/eWo/6UJdSdmyyg=;
        b=Y/wkwnEYmM8Ep5uoKx6A4nkGAUfmgvb2ylT48rlFK7QNlwK6XlO9c/YSK7lasjJNTt
         5bWqbGZjVDyNer1ckUbonyBJImJovPHQRIrzfJLLNQepGjJUnf8rDqtLCPkl8+TDWxgz
         ViPZ3V/FbyXjKPkgWx1tvqy6GabIwIoE8jrwAT+XzhHCjxMMXTdiS+Yy+k0nFZZeLUT9
         fHsH4pWM5b1jhTq1kDhde38QlPETU+8sAhOOyRoa1tdqhRCMG95l/VmsX8yLmZLcaNIR
         8ZxCuAVIRTYRPGetIeMjPyuf/80HkKhEaJQjIgbno1znyju6OugpXa07V4loSO4alGtY
         MKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754611758; x=1755216558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXd2+hikVHn0DCUK47UPFJHxdRXV/eWo/6UJdSdmyyg=;
        b=MqXQ3DTbOIerSyJ8ZCgxleauq43BdupvVc6QrWErDlWR4tMVvKCicmCJrZDHlKTh7k
         rW370KaCUaiv1OqFjBuBG6guMBCrMinR69CUFAPeRk8Eu/y4lIna/2WVXoi90g2K3CNh
         e+IGDONG2CD/zesvMKOhAFCIOdDy9BfpjjGmvgdrU9TEw/8iEWtqG6+qZgQ4rgy5kXyg
         ksqZnLRJce0nV0AUk9RQBCfKBhwIK4nlL0oWM4n3/i94i/WxZRvcxfGAIKQmkzOnRVSL
         C1jBbFdt0PMidl/8gM4p+hv9vsLU4C2W8IFFcf2deJ6kPUx36JLb1zynUzklVAxRtGEI
         NdoQ==
X-Gm-Message-State: AOJu0YzVGkNtpn4qTU1sw09h3PEkEfLK3BL39lH96nRxPiOnuefUh1YS
	mcR4phNcNXCnC+3p2cIKH1amylEm1oA8PTd16VTQhSRlS04v28GaFrHN
X-Gm-Gg: ASbGnctFCAOQCwK2Z3GEWDpDYjtHdsZwUUq4FG/ixHWx44k52ZIRPSombwLF+fgeC2M
	/I98pFc7iifxHvCn/bZ2vPb63o6yACBKk+lt0AUg4JSg/ns6AAQRjART9sNioDU64b3un7UEi+A
	jQ6MaYSat2qDuZ4CK2gT3T85T6evmAaM4I0mnO3HtMmBaH75p8P9y+iOYABwpzPothbR40LyUZ3
	7cF6M26NLudyK65gy8RJA1xMPjSOiI6TaBEARNtwWPFe4yj7wY2/FAoYC7+nwq97+FRgxf7CVDy
	vho79n5g36Rc6oz6jvnZNKpATFNdmXbZIWkQVLhQxqsiIkHL/2f2d4AHEZbimitQeOdtNAKFZYG
	NwRQVJtmfp4+FQZkyycR9nA==
X-Google-Smtp-Source: AGHT+IEYZa7c6DgRkIA/IyVY7kXZKzb4NOGAiFrm0H6w/sJuK+opnTwKBJhZcOZBLBQYwP9x2EHNqA==
X-Received: by 2002:a17:903:1103:b0:240:3ed3:13e7 with SMTP id d9443c01a7336-242c2228d0bmr13612495ad.42.1754611758173;
        Thu, 07 Aug 2025 17:09:18 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241d1f1ececsm194004595ad.68.2025.08.07.17.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 17:09:17 -0700 (PDT)
Date: Fri, 8 Aug 2025 08:08:34 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Nam Cao <namcao@linutronix.de>, Inochi Amaoto <inochiama@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Respect mask state when setting
 affinity
Message-ID: <prnjyu7ev5scocf4jh5jikox3niftje364lf3bjvizppxamdov@hbizpiazqual>
References: <20250807111806.741706-1-inochiama@gmail.com>
 <87fre3mhkh.fsf@yellow.woof>
 <nowqjgxmomniw624avrizohwzzq7ebkznb64m25qim3zgxjacn@oizd7ngxjd6a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nowqjgxmomniw624avrizohwzzq7ebkznb64m25qim3zgxjacn@oizd7ngxjd6a>

On Fri, Aug 08, 2025 at 06:01:39AM +0800, Inochi Amaoto wrote:
> On Thu, Aug 07, 2025 at 02:39:42PM +0200, Nam Cao wrote:
> > Inochi Amaoto <inochiama@gmail.com> writes:
> > 
> > > The plic_set_affinity always call plic_irq_enable(), which clears up
> > > the priority setting even the irq is only masked. This make the irq
> > > unmasked unexpectly.
> > >
> > > Replace the plic_irq_enable/disable() with plic_irq_toggle() to
> > > avoid changing priority setting.
> > >
> > > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > > ---
> > >  drivers/irqchip/irq-sifive-plic.c | 7 +++++--
> > >  1 file changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > > index bf69a4802b71..5bf5050996da 100644
> > > --- a/drivers/irqchip/irq-sifive-plic.c
> > > +++ b/drivers/irqchip/irq-sifive-plic.c
> > > @@ -148,6 +148,7 @@ static void plic_irq_enable(struct irq_data *d)
> > >  
> > >  static void plic_irq_disable(struct irq_data *d)
> > >  {
> > > +	plic_irq_mask(d);
> > >  	plic_irq_toggle(irq_data_get_effective_affinity_mask(d), d, 0);
> > >  }
> > 
> > This part is not required for the problem you are addressing, right?
> > 
> > I do not oppose the change, I'm just curious if I miss something here.
> > 
> 
> It is true, this is added because it is needed to follow
> the disable required of the irqchip. I think it is better
> to split to a separate one.
> 

After some dig in, I found it is not very necessary to add this,
When all enable bit is clear, the PRIORIT register of irq is
not functional, so only umask the irq does not make sense. Only
calling irq_enable does enable the irq.

I prefer to add a comment to describe this behavior, instead of
adding this change in a separate patch.

Regards,
Inochi

