Return-Path: <linux-kernel+bounces-854456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FF5BDE6E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F9B19284EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FC43277BA;
	Wed, 15 Oct 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GeT0aQvn"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED5732779D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530542; cv=none; b=G7DKS0gEz32AjL/YR4/pet1QX9J9ltHy6SLmIJCnCz3gjoKcJHtpzP6GolKSkg0s+pTcPjHViByiM9ifWEm8RuRmCqo5OKKzhVKZKuroHfqRUaKjVtav2SataiwjtoCMHQZBjGaYHKOchsLwC0CjG1KUG8QwwnyS2/4JSgYh0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530542; c=relaxed/simple;
	bh=VStyme2WGFC5nzLQgSu6EqVplLj1Zfy/hLTQGyfhIP0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=of6hmP+fJZ1UaUjJ7xu162iLStZdl8jCwo3BiWZVpsKtNKgPiM1kj/XV3h87EqUKoF7Bm0b1aBJLUBPqUgiRnWDXYqDONupb5etKUn/uzKDnbjrVyUMQ0O6aVD6Drl3FixkBjKSyqXKIP7LEPQBU8mjjhrnHqTh9FrgtHo1Bw5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GeT0aQvn; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso1065351766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760530539; x=1761135339; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S81YGrxPeLeHeMdfRUBH53cdbRUFL96MyZ7J9EKhJdo=;
        b=GeT0aQvnmCgdhdE/Rq+Li0jKkXgZbcM3AX6qRb3UoJPigTN7zzjZ5Z/zkDE+ZZJoOw
         aflUPSP4PoCnZJaErkoqPbkXr4TMmKS34nxNEyWUAX1c7ptkcnrQh1ZE0IsBe0CMwnRj
         AtanoTzdIWsr6Ka0RHZ2knzg6sMl4DapamQg1lPRCSBLA5lKnL5THdJwn50W8ojH5bRr
         IiQDWJOtIiMj27gErX0TtxRy1iqRqIw3umuouCghihI05ZMExf60SR1cMZCfoI+xeuBb
         X0NLxOIVB3xPXSH4TBrBasJWrcaAU41v3uiRBpEWHvEiyxJXyuFedSpkltq0mCko4mfd
         JGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760530539; x=1761135339;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S81YGrxPeLeHeMdfRUBH53cdbRUFL96MyZ7J9EKhJdo=;
        b=iz1HMqyBPRH/xWRkC94Vsn/r+2vAt3iVtGLNoNhbAPlhEeAdeUpKFpGRB+8Zi/vYsi
         oa6i1CI/a6bYP6n27Qo1IXkl572OuPeLrriZNxdAuHm2rQlJbwZG6wG9FfuH/5+4E65y
         OdxLZo5x4CklV8oKN/o+Di+N1+j5l8BgpGWjNlgEsELrqRuMIZ7BWwd+/DQEbUxdP+hN
         yKq5j0LnVbJY6r5XpvYJf6/Kfnh+hLf2K6RHF/AYJfqR0fMPyGSmmWZaSLXxTchnYMsG
         EedPLwq93p7miHPt60YP+YjJ9Iylv2xIAgut70hXhA3psNMkWdwEzOjRUVCun38Ej267
         5Z6w==
X-Forwarded-Encrypted: i=1; AJvYcCXArt/GKppCqqUI6MTp6R/P+oq/aJbysSjJFrHzZTbEf4lJ3Wx3ZydcZiGlni0vmWoKP1HTm0epjnrR51I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaM56UMuHtYqLiLL8SftWEYZNK+xD4V1y0gjyHWGjetTDR+o5d
	PxnX+yvOEnccnxf+sgi4kGqBizFqFlY9DOHvrtZkoeF8yahWOA3pjUz3T8fCuO9aKSA=
X-Gm-Gg: ASbGncsgr7X+mvT0ZV78fNUXhP9Cl01ci83YV2xAVlvy+IaARUPz1honZy4tRe+kpvB
	ENCnmfqi/ILecw/sAtqHg0wrYhVLmjEHid1uY7tdtm/iQZaq5H9DFfYzGpNkiLxM1phPKUzUZn6
	Pp58h+sLYlKd6gdL6K291oXnLdE6Gl6h/O2PKyepKL5jcQSxisbdZgNqVdpB9SmQ34W+P7xmnAU
	UmvfPd7banGHwvE6kRMJ/ti7KnF/7SzpgoEMMk5NZgcjYVda0BaXpgUdJYZDBxJUGedWJpmvPX4
	s3+pcFC22cA4KOoXVkQeyeJ+xJORYbtjOQloBUjk4jyCvWSNNmc8C/RjX9U+Z8IuYG13aLc7tzA
	a3gjZA+TZBrECZ/1+g3M4UUPsxuc292krqo16sPz5RGxF68zK2LIFI8UykIqAL5Wo3zB8J6IHj2
	M7LPkL1JyreQNSnvCD
X-Google-Smtp-Source: AGHT+IGkix6V3HHgZ9jFLmO3/fnOWGYAxFfttJM/PDcnY7nztBAeVvDuGIrDEMQI/LqfF2xlEMAlIw==
X-Received: by 2002:a17:906:ee89:b0:b04:25ae:6c76 with SMTP id a640c23a62f3a-b50ac8e51eamr2725062066b.47.1760530538553;
        Wed, 15 Oct 2025 05:15:38 -0700 (PDT)
Received: from localhost (host-87-9-62-200.retail.telecomitalia.it. [87.9.62.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cb965c324sm212887566b.7.2025.10.15.05.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 05:15:38 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Wed, 15 Oct 2025 14:17:47 +0200
To: Rob Herring <robh@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iivanov@suse.de, svarbanov@suse.de,
	mbrugger@suse.com, Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH] of: reserved_mem: Add heuristic to validate reserved
 memory regions
Message-ID: <aO-Q6xMDd8Bfeww2@apocalypse>
References: <20251014073403.32134-1-andrea.porta@suse.com>
 <CAL_Jsq+CugQrswhOWntK5RiRBSKkWRNUoB0pB8HoKPmym2e65w@mail.gmail.com>
 <aO5dtNJrF3vduSyJ@apocalypse>
 <CAL_JsqKsK+Bf6n=5YHmC681wxJjszkrdiryhP2+02=KGgPcM9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKsK+Bf6n=5YHmC681wxJjszkrdiryhP2+02=KGgPcM9w@mail.gmail.com>

Hi Rob,

On 11:25 Tue 14 Oct     , Rob Herring wrote:
> On Tue, Oct 14, 2025 at 9:24 AM Andrea della Porta
> <andrea.porta@suse.com> wrote:
> >
> > Hi Rob,
> >
> > On 08:12 Tue 14 Oct     , Rob Herring wrote:
> > > On Tue, Oct 14, 2025 at 2:32 AM Andrea della Porta
> > > <andrea.porta@suse.com> wrote:
> > > >
> > > > When parsing static reserved-memory DT nodes, any node with a reg property
> > > > length that is not perfectly conformant is discarded.
> > > > Specifically, any reg property whose length is not a multiple of the parent's
> > > > (#address-cells + #size-cells) is dropped.
> > > >
> > > > Relax this condition (while still treating perfect multiples as having higher
> > > > precedence) by allowing regions that are subsets of the parent's addressable
> > > > space to be considered for inclusion.
> > > > For example, in the following scenario:
> > > >
> > > > / {
> > > >         #address-cells = <0x02>;
> > > >         #size-cells = <0x02>;
> > > >         ...
> > > >
> > > >         reserved-memory {
> > > >                 #address-cells = <0x02>;
> > > >                 #size-cells = <0x02>;
> > > >                 ...
> > > >
> > > >                 nvram {
> > > >                         reg = <0x00 0x3fd16d00 0x37>;
> > > >                         ...
> > > >                 };
> > > >         };
> > > > };
> > > >
> > > > Even though the reg property of the nvram node is not well-formed from a DT
> > > > syntax perspective, it still references a perfectly valid memory region of
> > > > 0x37 bytes that should be reserved.
> > >
> > > No it isn't. I could just as easily argue that the reserved size
> > > should be 0x37_00000000 because it's BE data. I have little interest
> > > in supporting incorrect DTs especially generically where we have no
> > > clue what platform needs it and whether we still have to carry the
> > > code. There's enough of that crap with ancient PPC and Sparc systems.
> >
> > I understand the pain, but IIUC the example you mentioned (0x37 0x00) deals
> > with an incorrect size value (due to endianness) over a correct size length
> > (#size-cells = 2), while the case this patch tries to address is the opposite,
> > i.e. correct size values (corrected by the fw) over an incorrect size length.
> > For the former issue, the actual kernel code does not have an answer yet. For
> > the latter I propose this patch.
> 
> No, my point was who is to say the error is not 'reg' was treated as
> if #size-cells was 1, but rather 'reg' was truncated by 1 cell by
> mistake. You don't know (in general) which one it is.

Ok, general case can have ambiguity, got it. Since this seems to be a dead end,
I will abandon the heuristic path in favor of fixing the specific (Rpi5) case.

> 
> > The point is that the potential erroneous regions we could introduce with this
> > patch are just a subset of the regions that can be erroneously introduced in
> > the actual kernel, so no additional harm could be done.
> 
> There's little reason for us to handle such an error as there is
> little excuse for getting it wrong. We have multiple tools that check
> this including the kernel evidently.
> 
> > > Furthermore, this looks like an abuse of /reserved-memory which should
> > > *only* be holes in what /memory node(s) define. I don't think we
> > > enforce that and I imagine there is lots of abuse.
> >
> > AFAIK the only enforcement in the kernel is being an integer multiple of the
> > root address + size cells. As you already pointed out, this means easy abuse
> > but this is still a fact with the current kernel, not something that would
> > be exploitable more easily with this patch.
> >
> > >
> > > > This has at least one real-world equivalent on the Raspberry Pi 5, for example,
> > > > on which the firmware incorrectly overwrites the nvram node's reg property
> > > > without taking into account the actual value of the parent's #size-cells.
> > >
> > > If we have to support this broken firmware, the kernel should fixup
> > > the entry to be correct.
> >
> > This is what I first thought of, but it has several issues that complicates
> > its implementation:
> >
> > - I guess there's no current infrastructure to execute fw specific code in
> >   the reserved-memory node (something that resembles PCI quirks?)
> 
> Not there specifically, but PPC does do a number of fixups.
> 
> > - Finding out whether a fix is required depends on identifying the fw, which is
> >   possible only reading its fingerprint through the reserved-memory region
> >   itself. This is kinda of a recursive problem...
> 
> If RPi5, then check and fix 'reg' length in /reserved-memory nodes.
> That doesn't seem hard.

Maybe we can workaround this by just checking if the reserved node has 
"raspberrypi,bootloader-config" in the compatible list *and* the reg property
is not aligned with the #size-cells advertised by the parent. In this case we
are surely dealing with the misbehaving fw and we can act accordingly.
Thanks for the heads-up.

> 
> > - The reserved memory parsing function is invoked very early in the boot process,
> >   so we cannot rely on a driver module to amend that
> 
> Does it need to be? If the region truly isn't in DRAM, then we don't
> really need to fix it early.

I think we should. The reseved memory regions are outlined during the first-pass
parsing of the fdt and the nvmem-rmem driver will not work if it wouldn't find
a matching region. I think there's no point in rewriting this logic, let's just
fix the entry sooner rather than later. As an added benefit, whoever will need
to dump the fdt at later time can do so and have the reg property matching its
live tree counterpart. Need to do some testing to verify whether its already doable
or if it needs some new helper functions to deal with the fdt.

> 
> > I will try to cook up something on this line, but I guess it will not be easy.
> 
> I pushed a branch, dt/fixup-infrastruct, to my kernel.org tree. It's a
> prototype that we ended up not using. It won't work for you if we need
> to fixup the fdt rather than the unflattened tree.

Thanks for that. As said above though, I'd rather fix it early in the fdt rather
than in the live tree, although the actions in your proposed branch have direct
equivalent in the fdt world (or at least they should, I need to verify), so the
trace is still good to follow.
I'll bake something and come back with a renovate V2.

Many thanks,
Andrea

> 
> Rob

