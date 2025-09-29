Return-Path: <linux-kernel+bounces-836177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B67BA8EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610C03C10B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483F92FDC41;
	Mon, 29 Sep 2025 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1cF5ZjU"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973F52FD7C7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143464; cv=none; b=K85RuY+DLH/1KbShks519yqOnwNU9MEieRVwm6r0yJWSq1xzlU4mvnBaCK4iBcbxSAyuLzLwu6MkijPLCzSnAevQNJqoFftDTpWAK6QRfJwm2zZib7DfLUyzolHj+G8XUt2gMLf7Yt6Tp5So8sAJPbWHzFfCIrvK+qWVK73qIIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143464; c=relaxed/simple;
	bh=4tYuwQTrO9BTMWGb6gaK1mGhCxypY1uT9TTbquG0wME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FejG2OWz4IVFbEty2GVGr2bWsAJei4d1WrhYN/rcqXnil0HtIrMzmVMDYZ4z7vROBxi+cVTx4qwAcNkKwqSB2C+feFA6oj+MjQXjPXNZt3tkvqIjoKu6kebaqD++RdKxDspSmMWt1hun4EP3q0X3bpH2cPjywoTr+Rf4C5Wz+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1cF5ZjU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e2b7eee0dso96045e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759143461; x=1759748261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O8UnufLq/Mcz1Rl9avuBFpaPVNHTq+GFP8JL6IXXjIo=;
        b=v1cF5ZjUj71SWz1cvg9wbVQkMNDJoWj6cCCjbUSC3uIijeIlp6GsEGvsjGPwZxEkUX
         hsh4JmWLfdx4W86l3KGmxmgNEBcoGWNnWTrmHVaQq4pLMNKNcvmfK/1q1jv0LGEzuUfT
         E5xj6CLmlQmapDJKfYRH/4GAJdIjBfv1bIrELQCDSadjwW/k7Po68YTDWbjwisrVVLlx
         aND/21xM92u/mqA77dPvnrBV6WE4dbV21Etqnj5KZmEfK82hRtGkS0sfv+zhE7sSnnwC
         v/D3u/PCfbPy/60+BZrGykV1joxTrWxL27kMeMRDVVs25SoTKxOd2GPGQZ0JfVdcGlo5
         zyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759143461; x=1759748261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8UnufLq/Mcz1Rl9avuBFpaPVNHTq+GFP8JL6IXXjIo=;
        b=j+0brmgUva1krh5zzq59jFNGWXMjDTglbPU+4Yaen+WNO0HlosQ2WlVfK9UOQclViO
         2kZqfMUCJF2SGE4qXLPv7K6xhhjJWcj2IGj+PwF9mQFuuu0cVFvB6J5CHbbBDrpZagNd
         mU/Wwsy9EjQhI4x2qVBqW2Hkb8Tf5e/bJC4h1oiE2IdgbUO0icHeEWhGcS4dWoNbI12U
         fqN9fo+JBrDPG3XD2vUO5mcYNzlSA5evTvLB1I/VDjQtic99Q42RAsIfOPRMW9BAXSN0
         TW8fL2ZgakU1OYbp12I0DU/4rvQ6D9HTET7Pem8jCjXfcFen7HEwg+XfgX/WpOAc5YNM
         cRPg==
X-Gm-Message-State: AOJu0Yz6uvSQ6ITGK7aOk5jeTWdkGHMEhWRSQb58v/XnWl81tNMEMD3v
	8GgID0qKI8gYN/552J8TXB/XuBycWUmHELVDQflWn4kGQpb4LFovyQYC3mYejZfHCg==
X-Gm-Gg: ASbGncsCfgWAVoW8RRRVaG5braozuNTjD7T5bDyE/Wvs5jMveUbgMvSj85uPl+20sr3
	sltgGhnE707xweKdSSz8uxKJ91SZgpPalMnsnhrTGVB7n4z2magEhMj95MePRIr42SAWowiViPD
	/Ez06QJOWuyrAfad8cP36V3lXlVvNxBTv6bfv5uYqZlb+8vVGRPDR8CcCQHfn5o5ziFD4E7ZYKe
	MI3IAMExRls1m9W6o3bRv6yDmyve4UdAI+DXj8r0IHfHhLDprWdFhnHP815VLvDM97cDqYefZJr
	+ouh/2kaIZsQ1N8q3tF9h7b2AkJqrqgTLJ6ybsJVghDWBtvHPgxFMHr//ttZh/GCobKxKvP64v+
	ZsSXpduFX/VSJnG/tkkA1Hgkgut2RV9fHlcsjK/GVcE6i5xhat382MwOjEFJwWHlumS4E0COwP+
	OfqpptMRjLM0Or
X-Google-Smtp-Source: AGHT+IFGle5uSDx6pJtL9z0dOczocAV6Sw1uDcPJYNHRfsKx0x2lgw6GyR50H0eIdWA6EZ8zfTw+TA==
X-Received: by 2002:a05:600c:a413:b0:45d:f6a6:a13e with SMTP id 5b1f17b1804b1-46e57589541mr240935e9.1.1759143460763;
        Mon, 29 Sep 2025 03:57:40 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab61eecsm220878875e9.20.2025.09.29.03.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 03:57:40 -0700 (PDT)
Date: Mon, 29 Sep 2025 10:57:36 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 02/28] KVM: arm64: Donate MMIO to the hypervisor
Message-ID: <aNpmIC-ywzIJCTAq@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-3-smostafa@google.com>
 <aMA13Sowq91XEqP9@willie-the-truck>
 <aMlly_9kDE04Inn2@google.com>
 <aNakIop0jdz9gH-t@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNakIop0jdz9gH-t@willie-the-truck>

On Fri, Sep 26, 2025 at 03:33:06PM +0100, Will Deacon wrote:
> On Tue, Sep 16, 2025 at 01:27:39PM +0000, Mostafa Saleh wrote:
> > On Tue, Sep 09, 2025 at 03:12:45PM +0100, Will Deacon wrote:
> > > On Tue, Aug 19, 2025 at 09:51:30PM +0000, Mostafa Saleh wrote:
> > > > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > > index 861e448183fd..c9a15ef6b18d 100644
> > > > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > > > @@ -799,6 +799,70 @@ int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot)
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +int __pkvm_host_donate_hyp_mmio(u64 pfn)
> > > > +{
> > > > +	u64 phys = hyp_pfn_to_phys(pfn);
> > > > +	void *virt = __hyp_va(phys);
> > > > +	int ret;
> > > > +	kvm_pte_t pte;
> > > > +
> > > > +	host_lock_component();
> > > > +	hyp_lock_component();
> > > > +
> > > > +	ret = kvm_pgtable_get_leaf(&host_mmu.pgt, phys, &pte, NULL);
> > > > +	if (ret)
> > > > +		goto unlock;
> > > > +
> > > > +	if (pte && !kvm_pte_valid(pte)) {
> > > > +		ret = -EPERM;
> > > > +		goto unlock;
> > > > +	}
> > > 
> > > Shouldn't we first check that the pfn is indeed MMIO? Otherwise, testing
> > > the pte for the ownership information isn't right.
> > 
> > I will add it, although the input should be trusted as it comes from the
> > hypervisor SMMUv3 driver.
> 
> (more on this below)
> 
> > > > +int __pkvm_hyp_donate_host_mmio(u64 pfn)
> > > > +{
> > > > +	u64 phys = hyp_pfn_to_phys(pfn);
> > > > +	u64 virt = (u64)__hyp_va(phys);
> > > > +	size_t size = PAGE_SIZE;
> > > > +
> > > > +	host_lock_component();
> > > > +	hyp_lock_component();
> > > 
> > > Shouldn't we check that:
> > > 
> > >   1. pfn is mmio
> > >   2. pfn is owned by hyp
> > >   3. The host doesn't have something mapped at pfn already
> > > 
> > > ?
> > > 
> > 
> > I thought about this initially, but as
> > - This code is only called from the hypervisor with trusted
> >   inputs (only at boot)
> > - Only called on error path
> > 
> > So WARN_ON in case of failure to unmap MMIO pages seemed is good enough,
> > to avoid extra code.
> > 
> > But I can add the checks if you think they are necessary, we will need
> > to add new helpers for MMIO state though.
> 
> I'd personally prefer to put the checks here so that callers don't have
> to worry (or forget!) about them. That also means that the donation
> function can be readily reused in the same way as the existing functions
> which operate on memory pages.
> 
> How much work is it to add the MMIO helpers?

It's not much work I guess, I was just worried about adding new helpers
just to use in a rare error path.
I will add them for v5.

Thanks,
Mostafa

> 
> > > > +	WARN_ON(kvm_pgtable_hyp_unmap(&pkvm_pgtable, virt, size) != size);
> > > > +	WARN_ON(host_stage2_try(kvm_pgtable_stage2_set_owner, &host_mmu.pgt, phys,
> > > > +				PAGE_SIZE, &host_s2_pool, PKVM_ID_HOST));
> > > > +	hyp_unlock_component();
> > > > +	host_unlock_component();
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
> > > >  {
> > > >  	return ___pkvm_host_donate_hyp(pfn, nr_pages, PAGE_HYP);
> > > > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > > > index c351b4abd5db..ba06b0c21d5a 100644
> > > > --- a/arch/arm64/kvm/hyp/pgtable.c
> > > > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > > > @@ -1095,13 +1095,8 @@ static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
> > > >  	kvm_pte_t *childp = NULL;
> > > >  	bool need_flush = false;
> > > >  
> > > > -	if (!kvm_pte_valid(ctx->old)) {
> > > > -		if (stage2_pte_is_counted(ctx->old)) {
> > > > -			kvm_clear_pte(ctx->ptep);
> > > > -			mm_ops->put_page(ctx->ptep);
> > > > -		}
> > > > -		return 0;
> > > > -	}
> > > > +	if (!kvm_pte_valid(ctx->old))
> > > > +		return stage2_pte_is_counted(ctx->old) ? -EPERM : 0;
> > > 
> > > Can this code be reached for the guest? For example, if
> > > pkvm_pgtable_stage2_destroy() runs into an MMIO-guarded pte on teardown?
> > 
> > AFAICT, VMs page table is destroyed from reclaim_pgtable_pages() =>
> > kvm_pgtable_stage2_destroy() => kvm_pgtable_stage2_destroy_range() ... =>
> > stage2_free_walker()
> > 
> > Which doesn't interact with “stage2_unmap_walker”, so that should be
> > fine.
> 
> Fair enough. I feel like this might bite us later on but, with what you
> have, we'll see the -EPERM and then we can figure out what to do then.
> 
> Will

