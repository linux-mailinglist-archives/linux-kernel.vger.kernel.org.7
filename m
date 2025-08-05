Return-Path: <linux-kernel+bounces-756119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B189B1B03C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 682FE4E22F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE0F243376;
	Tue,  5 Aug 2025 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrxJovKJ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B440190472
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754382729; cv=none; b=I7SQBMVGsXVilpE+6LpWKL4IhzJeuw6PZwb2WnJlzFAzgukF92Zdyllk+KKfGKGg+LivCBU754p4tB/ledhpbo0CrFjTejOkGp9slQD75ziNm36eSCKAnZQA3kBXl7FWZ00YxthRumxfLTK/GpnuSfOa2du0il6hrML/U63ZJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754382729; c=relaxed/simple;
	bh=fHmpaIOPjkyexmjJ3+L8AA+pWZ8k+h7xPPc0/QhT1+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVXZEvuY8dnfJNIeVvVnqUnZ/kcco21eFXP13XgXCgtE1sSMOHiafEFe8t/ohiWCjhCFwR6zlb9XDtGBeHWCnDz85ufNUKzrA1ZoEFp9YyDV81HJ2i8Klqv67h5Mk2bXEnZ8ObqHKE7VpFMFJzyVgTXT5S0DcSfKlGWqgN1DmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrxJovKJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-458bf57a4e7so63985e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 01:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754382725; x=1754987525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BWA0STOcqIUzpFQVaS5UHy7SE6OJhVfIhAfBgcIup8=;
        b=RrxJovKJuYYk/6DxAc/CBB5JYgSngBkdoMFktyCLSh/g1x+r5JleGwKuQIB65Smqib
         E15WtgGnUmEEXuR3YFLL+v22OvfSauBa5K/ixU5rXDqLvPP3zC3Q5nkhZ6IM7bVd2Ru+
         gzq5c1dxX5nDxfkoiH9kuRL525TO3A9tAS9rME+5EJuKYN5smTyENNdQrTPwDjQRvJAG
         M4TSFrps+Aj2sn1iXYKfDdTsSizfqRoHmXvKWfYUXrtlGnjALnrTgnMVrs+2w+s0dMty
         xuejJDrBchr4nf6Xc1cD84bc5BFiUte7aGlYC7z0fEP21uVFTdJmPg+P8AoBWk+yEV8w
         Dzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754382725; x=1754987525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BWA0STOcqIUzpFQVaS5UHy7SE6OJhVfIhAfBgcIup8=;
        b=kBFHHWIBmXrDp9vJnOpzG6G5yJ5GYddvl0uFq16OZaIZ/doI3rIkQgwXxg5fQonY8t
         JckeVjUbl+U/79uL+DAKN88pUUeJhW/ZxnuM3inMhCfLmBWh5yr9EyhNZZSwJO43YpOo
         8WpNVhs4mYoCro4q7zB9KTmgIsch73+ARmv5sINl5fXXhcqAEKCo0mLp0sZpyRnCQ6ji
         /i77MaVNKug0ZqVj01/lnQO9M6Qtpzdl0aCvOv1wf+OZxPSJsqz82L3Ty0eoE1QJk/lJ
         rB4dq9R61PizL2cNPHgsbthDPWE8I9ja4ItlSYUFtip1v2+GmHvRcZTn09o6gI/FB+HH
         FWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhmLvCOUx7biFCkWRkfwc6QV5xNIFngT/oFAbJfiAwNr3wHggZtp4fp3tGrOxgNAJatrqqFLDFe57OjlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh2eljO0RQbZEpbqr6Bnmbr6yUfVxOeaIXLvwMGFfa3c4cjXmI
	7v19JjR2vf+ooRiM9VqCPCPsebksVlzU9jHNIfkEUFWqrGuLqW9ljSD4Le6LejgA3w==
X-Gm-Gg: ASbGnctHuREP+TVyWVut0Alz+YIoGnL+GeoXyjDUqQx1t58RpWe6sWDJI7Jc5z/8BXg
	zWHoFd38bzMl97YlLWt5CtbOEwenFSXv5uUpn+D6EZxJfpZjpFvA82gGJm36j5iWoDe8yt3g3Fq
	pgWn4NzRavhj56Bf2P+eoHOFLftvkYbCR3cUqTyopMwBd2Wqk644jvt5M2IoUULwIBDc56hfWHJ
	+FhYsb0fe/vXWFmAhC5+53r8IRfhxVvZteoL16WaVAyIdfUSalWzH7FE1DR0tNMW9UGMbjWfFKK
	a3olIVjXEmjTzWDopgPNqJUoiF+xMs+ZvnMduywPCKNdatdjzZuMmFImnsM5SRIFkRIB/JpgySg
	kMKosqqbigfcBOlf8oK5G1PVejJ54sImo2MXWF8mi0zKVq6I7cYE6OZHFc0G4gOE=
X-Google-Smtp-Source: AGHT+IFKztsRYhYKwdwIDsCDgAVK6+r35a5h3+OYoOMO7aVdiPkoVmjrLzpy/fS3Hiy5FOXrT7eLpw==
X-Received: by 2002:a05:600c:888a:b0:439:8f59:2c56 with SMTP id 5b1f17b1804b1-459e269dbbamr469945e9.2.1754382724391;
        Tue, 05 Aug 2025 01:32:04 -0700 (PDT)
Received: from google.com (72.47.233.35.bc.googleusercontent.com. [35.233.47.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e075047fsm18416515e9.1.2025.08.05.01.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 01:32:03 -0700 (PDT)
Date: Tue, 5 Aug 2025 08:31:59 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] KVM: arm64: ptdump: Fix exec attribute printing
Message-ID: <aJHBf4KCUPpWbyU5@google.com>
References: <20250802104021.3076621-1-r09922117@csie.ntu.edu.tw>
 <d72b7928-8646-4616-a8f0-96b9d9bbaf09@arm.com>
 <z2hmwwmtgbrio2wv3sj2pc4zhxdjioorlhnm45o2arcsjahjni@xod435q26jqq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z2hmwwmtgbrio2wv3sj2pc4zhxdjioorlhnm45o2arcsjahjni@xod435q26jqq>

On Mon, Aug 04, 2025 at 08:41:35PM +0800, Wei-Lin Chang wrote:

Hi Wei-Lin,

> Hi Anshuman,
> 
> On Sun, Aug 03, 2025 at 07:33:04PM +0530, Anshuman Khandual wrote:
> > 
> > 
> > On 02/08/25 4:10 PM, Wei-Lin Chang wrote:
> > > Currently the guest stage-2 page table dump has the executable attribute
> > > printed in reverse, showing "X" for a non-executable region and showing
> > > " " for an executable one. This is caused by misjudgement of which
> > > string gets printed for the executable and non-executable case. Fix it
> > > by swapping the two strings.
> > > 
> > > Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
> > > ---
> > >  arch/arm64/kvm/ptdump.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> > > index 098416d7e5c25..99fc13f1c11fb 100644
> > > --- a/arch/arm64/kvm/ptdump.c
> > > +++ b/arch/arm64/kvm/ptdump.c
> > > @@ -44,8 +44,8 @@ static const struct ptdump_prot_bits stage2_pte_bits[] = {
> > >  	}, {
> > >  		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
> > >  		.val	= PTE_VALID,
> > > -		.set	= " ",
> > > -		.clear	= "X",
> > > +		.set	= "X",
> > > +		.clear	= " ",
> > >  	}, {
> > >  		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> > >  		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
> > 
> > Is not KVM_PTE_LEAF_ATTR_HI_S2_XN already in the reverse semantics aka
> > XN (Execute Never). Hence when KVM_PTE_LEAF_ATTR_HI_S2_XN macro is set
> > that means the entry is not executable and vice versa.
> 
> Yes you are correct. However in dump_prot() we have:
> 
> if ((st->current_prot & bits->mask) == bits->val)
> 	s = bits->set;
> else
> 	s = bits->clear;
> 
> Analysis:
> 
> 1. region is executable:
>     - st->current_prot == PTE_VALID (ignore other bits)
>     - st->current_prot & bits->mask gets PTE_VALID
>     - if condition is true (.val is PTE_VALID)
>     - prints bits->set
> 
> 2. region is not executable:
>     - st->current_prot == KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID
>     - st->current_prot & bits->mask gets (KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID)
>     - if condition is false
>     - prints bits->clear
> 
> Therefore we want .set = "X", and .clear = " ".


This seems correct but it will produce a different output than the
stage-1 ptdump. What if we drop the PTE_VALID from the mask & value as
Mark and Anshuman are suggesting and print NX when the bit is set and x
otherwise as the stage-1 ptdump does ?

> 
> Thanks,
> Wei-Lin Chang

Thanks,
Sebastian

