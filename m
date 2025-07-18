Return-Path: <linux-kernel+bounces-736690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A87B0A08C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6C61AA7A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB77729A331;
	Fri, 18 Jul 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RrYBf4Lu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78475BA27
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752834183; cv=none; b=AEei1+V2EtpqGYfeV8WH/oXQxslcfao/8C7wj7D8r1Yt/1EDvqep/Yjiei7f0l2cHhJcnKB1aZWMy5MovmUUzEDN1ebys6Vr9S/5BGAQ4m9k62OTgUUfB1tz+j9W30SiRWTbwl5CdAdoYHSyPczk3I/ZUEf8JWWZLKkposEvctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752834183; c=relaxed/simple;
	bh=0K+PWnlknbuLrkGKVE9wT/E+DryHu1Blg4zLy/8QVAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4MTfszoIFY5zP/Kc9l4/p268gFyXNLRF+nIlfs4yA0pe4DjPBS1yR29xqzXQsyEltyltpdkbejl1p2Sbqa8Xb5wv9biakoWfqlzRsn5VzzP3N//zO1eBl7Ch+frasxIT6obtzM+tNGdjBp2qwkr9OogGTVEFHVqCNhDp3A8iaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RrYBf4Lu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4561b43de62so71545e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752834180; x=1753438980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kvcvr0AK6YSE0JbmZUfdczos7CJhlpqAGW0SyiAlvmQ=;
        b=RrYBf4LunI8kZaXDvbvZIenaDjn3HXPLlJMG7QWIHOip3JTn+NjRoevIRThHVSwykx
         11QFZRL/D5pfBdn/1QhQ7BYF1K9cK1+f+tcBBa4j6Yz4UqUnFmA8wIt49cpoDMHaFIX+
         ixEb7vJ+RPExKYhr4NcSLw/A+A9MlfaSJ7/hSU0E71cogctSCPUGFTNx4VckDP+2m8gi
         Ds0BuaiYxOG1zmqpWRSUhdLr/iGrpBQovnSmfSC7/9biZp75ZUNBAepZuy43L+OrpLIs
         gEKqNKUWM8iMbZOG4+yzV2YOpsSjVD674NnWp5aHCpESnN9coJ5TxKbVCQ2KprmjPgHo
         E5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752834180; x=1753438980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvcvr0AK6YSE0JbmZUfdczos7CJhlpqAGW0SyiAlvmQ=;
        b=LW8t312O60eHN9JuJs+ShV7SZPb582wtiQGv6M+H825a0c0W+F5V9S1vkpYHsNDYsI
         sAw+a6JcLAgevxyUNMZo+v0PiuDTkUqi5wxkzHQUAPN1ByJA1hKdBiD6fLPCZwXd1DcM
         Ma0typoQu9Bp3aejGE4CqletSJgz4q+eK8DgPRB1P5Dmw+5323NaTamnxoShIs3Xo0zn
         BPmIgGd5YlrlDyPhm55jvGnJ1V7PoQf1uDeTAetMgyzKT/rv0JBy2LciBWgf0+p2r3Ls
         rbnctU5Agp2jNaju0DfAlcGwtgO/TC+BjQswT+qCbXV7Tm6n1i7cgdOiHXDIFDElQQo0
         u4kw==
X-Forwarded-Encrypted: i=1; AJvYcCUtsDCjUnxvl/0yB0WRBeVpsd0h/ZzMfGO/2xduOfyrCLhBdfLy2hhEouOI5GQt6eN1Holwnki1PMBERFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRfXq69Y+ibY95Zvh0x9lH8dunUAVcQnAqktOaYXFIv55uGuT8
	IwCsuU4FdEqP0Ms7vQLrymN3wENOaX2bpsQ5i4DTzFmLNWmpTxZOHiuzL2j9N2Q6kA==
X-Gm-Gg: ASbGnctF4BaXQCBb/6jrIUMYAzWtnneK2+/kwuyXtZZbjSJMCEiCu1+XJ9Ze2aGkGbN
	Fe0KC0X3XubDFhuapJVD1t7l4ThYkmQdl6FKlNO6mup7GUOxEB9BYMU+FwS0RUtQvfu8OnCS760
	TnbV5KtTTbwghMT8Mx7K+0DIxFE8u6Jjt/dRkInlZI4Q0/oS6wJD9+RrUCuJmWr2rc4ME0laLxk
	nCmAcR/s8T9ZZWnEDTB0o9dSB2DugjfV8U1V0aS+sIIRcPQYciWtU1x7TthU2viUg92lR+QlVw9
	+OVZqxIbD8+cC1/1q/9ySjBexWSUt2m44cuSjHdWvjzBaptxxJh0iPP9F+Ic4GIikX1dQb8l8aI
	0xVyZNLQolewGxPdoBQ5JMlcLP+c74aQx0OyQLO1TxK4iSpXU5yA2hYLsAu2ErAVeCkRp
X-Google-Smtp-Source: AGHT+IEXgWSB+NQ1xhdND89MDLioany2VPotHUOmf388VpQypRg114G/u7aLbJeTYE+lqaAILAgn1Q==
X-Received: by 2002:a05:600c:1c11:b0:450:ceac:62cf with SMTP id 5b1f17b1804b1-4563a79cddbmr1480885e9.5.1752834179584;
        Fri, 18 Jul 2025 03:22:59 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48991sm1423585f8f.44.2025.07.18.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 03:22:59 -0700 (PDT)
Date: Fri, 18 Jul 2025 10:22:55 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Ben Horgan <ben.horgan@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, qperret@google.com,
	keirf@google.com
Subject: Re: [PATCH 2/2] KVM: arm64: Map hyp text as RO and dump instr on
 panic
Message-ID: <aHogf50CvjeSklRo@google.com>
References: <20250717234744.2254371-1-smostafa@google.com>
 <20250717234744.2254371-3-smostafa@google.com>
 <38b08607-b9d9-425b-81c4-b227dda427b3@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b08607-b9d9-425b-81c4-b227dda427b3@arm.com>

Hi Ben,

On Fri, Jul 18, 2025 at 11:16:18AM +0100, Ben Horgan wrote:
> Hi Mostafa,
> 
> On 18/07/2025 00:47, Mostafa Saleh wrote:
> > Map the hyp text section as RO, there are no secrets there
> > and that allows the kernel extract info for debugging.
> > 
> > As in case of panic we can now dump the faulting instructions
> > similar to the kernel.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   arch/arm64/kvm/handle_exit.c    |  4 +---
> >   arch/arm64/kvm/hyp/nvhe/setup.c | 12 ++++++++++--
> >   2 files changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> > index de12b4d4bccd..d59f33c40767 100644
> > --- a/arch/arm64/kvm/handle_exit.c
> > +++ b/arch/arm64/kvm/handle_exit.c
> > @@ -566,9 +566,7 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
> >   	kvm_nvhe_dump_backtrace(hyp_offset);
> >   	/* Dump the faulting instruction */
> > -	if (!is_protected_kvm_enabled() ||
> > -	    IS_ENABLED(CONFIG_NVHE_EL2_DEBUG))
> > -		dump_instr(panic_addr + kaslr_offset());
> > +	dump_instr(panic_addr + kaslr_offset());
> This makes the dumping in nvhe no longer conditional on
> CONFIG_NVHE_EL2_DEBUG. A change from what you introduced in the patch.
> Perhaps it makes sense to reorder the patches; do the preparatory work for
> instruction dumping before the enabling.>

Yes, I thought about squashing both patches, but I was worried this patch
might be more controversial, so I split the code into 2 patches, where the
first one can be merged separately if needed. But no strong opinion.

Thanks,
Mostafa

> >   	/*
> >   	 * Hyp has panicked and we're going to handle that by panicking the
> > diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> > index a48d3f5a5afb..90bd014e952f 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> > @@ -192,6 +192,7 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
> >   	enum pkvm_page_state state;
> >   	struct hyp_page *page;
> >   	phys_addr_t phys;
> > +	enum kvm_pgtable_prot prot;
> >   	if (!kvm_pte_valid(ctx->old))
> >   		return 0;
> > @@ -210,11 +211,18 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
> >   	 * configured in the hypervisor stage-1, and make sure to propagate them
> >   	 * to the hyp_vmemmap state.
> >   	 */
> > -	state = pkvm_getstate(kvm_pgtable_hyp_pte_prot(ctx->old));
> > +	prot = kvm_pgtable_hyp_pte_prot(ctx->old);
> > +	state = pkvm_getstate(prot);
> >   	switch (state) {
> >   	case PKVM_PAGE_OWNED:
> >   		set_hyp_state(page, PKVM_PAGE_OWNED);
> > -		return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
> > +		/* hyp text is RO in the host stage-2 to be inspected on panic. */
> > +		if (prot == PAGE_HYP_EXEC) {
> > +			set_host_state(page, PKVM_NOPAGE);
> > +			return host_stage2_idmap_locked(phys, PAGE_SIZE, KVM_PGTABLE_PROT_R);
> > +		} else {
> > +			return host_stage2_set_owner_locked(phys, PAGE_SIZE, PKVM_ID_HYP);
> > +		}
> >   	case PKVM_PAGE_SHARED_OWNED:
> >   		set_hyp_state(page, PKVM_PAGE_SHARED_OWNED);
> >   		set_host_state(page, PKVM_PAGE_SHARED_BORROWED);
> -- 
> Thanks,
> 
> Ben
> 

