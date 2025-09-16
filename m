Return-Path: <linux-kernel+bounces-818883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4198CB5979C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D08C7A47C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F861307AF9;
	Tue, 16 Sep 2025 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LXTUNt3a"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45730F529
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029267; cv=none; b=gc+0i4mHWRF9Xck9Rs69wgEO6xA9R0FKgFMmRH2z3e32dSPPoaaapM5iVOyh7cz3BvpSena2SnTv4U5X/6yzu9zsVLKt0bFsKeMU/HaTEParnmBVPXoXuMAKMobuRUt0G8TbifRVrdcX0mAoIXGkskJXsOamqfOqketUgv5GZrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029267; c=relaxed/simple;
	bh=CsQmZXv/AtyfZ974RJzjtLxZSNyHjA0lO/gWcn54LXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7VHzR3mFxR07YTdeaFgMBy9OayN/9VXdATy8Sss26rrAebglPpeCgGEYqJIzMtZ4zoqix1HfU6AvI7KMo9HieJF0fe9nY86l9ZgibR0xmmOYz7pfmb6m652JIV6bUg+ha8bdy7BGjep2lAywSinESlffr7SaDxkUd/bXl1f4LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LXTUNt3a; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45f28aba94cso50045e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758029264; x=1758634064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1BHOalff8m1sEtBaAy0omnedb+cWGI69lbfkwDKZ9kc=;
        b=LXTUNt3aobBneDquZzDkWLtX719eR0nXMu5y40cjH7x8mbk2wUNyhe16j97zELO8Vk
         ARyKkqIdYYVUW7ByV2jWvqvEJ8THEKK8M8Kr9+yHTscQAb55AmkkjBlIehurbsCD7sKU
         zaOBs2RhcaTZhxl2blvqiEDtVtp+88n4FRBWtnOLee485OU9AiFSHdSpnuLQ3kctt0sx
         jEgHK8uUduIM4dF1T3vPRnnSMFn1AGce2PWgiZH3w1bILKJpR/iBjGRw9C3KSbn9ZiGd
         MaLLCnvsS9NzlxfDjuaoaPJF24/2AewZfcnXl/DXk6hdJtWVi/Uz0/iotiJilD4tH4n/
         euZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758029264; x=1758634064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BHOalff8m1sEtBaAy0omnedb+cWGI69lbfkwDKZ9kc=;
        b=XKdzh3IrOsMxJqun2XkGQ1FqqCdwKMhdObQA+Vqq2+zAzFEyI4PdMbbpnemqhZlwlY
         M5LuPTFckwvngzxhFnd48TS0RmkHBT0B/MxZXBlfzUCxK18cEQbXCAF+3zd4WYMLfPPs
         64DX3FS9C/R1nogTZhn8QvWoJ6tHP57oYFFubYFpwgNyT3zhN5gpfnCJ35SigM7d1f9J
         6Hj6zk9zzsvT3Gakjg8J+9gd0rxZpt7zuxI8gHjnt9BhHlrjR8+sm8GjFk1OTo8BeQBo
         48sM/9W35tDVNBTsSc+5myQizPw1q+Qk/7/7MzOCLYAu7RlEZlgXribOSEzbUo+oZOJj
         BB2w==
X-Gm-Message-State: AOJu0YzJLvG2VWXPQq8VuWbc6KCHRzavsql4u+1tbNLENNq3WHnplsMQ
	SBFSjF096I4jue3INMOvR/FeGdRuD9bFPgfJ3Qj2ZO9u2BAmCLqg21cyhcm4wbVnJQ==
X-Gm-Gg: ASbGnctSyEYPeN8ADO9XDav+M19956Doari/gLQqUpgnblkZFTMMP6e1tQdFvyup4+5
	bitX1nj06xv7wyDLJCg8mgnbp1bJoVtvJb8tcaY2bMf77QeSQyx4NAYwZL71D8xTgSPKyt+phDu
	hyQV8MoUuj9wRObAJRPxpOLZ6PoZEJUS2qNY76yFBd9AXyqDAhjAHUIS2YkNwaahP3IY0qJxqtm
	hoOtbOdCef9FMKhbSIS1CzUTcGzX5feS26TjU0XNAycwd9rnihhkhBTMx8YMqlYGkhA2sCLF3X5
	XUtbTaRplQZ7FecJNrJ+eoHjy/PNR7ZxC7DZwaZGX6F/O4R4dgD8TsrOD7grknespR3NExJ5eys
	JiJIr428GslS6o6Sv3YcGdSHChEBN2G/ztyDcYQS8k0REa1pFB80LDqj7cHWDz8sUXdLKlP0267
	k/VMCv
X-Google-Smtp-Source: AGHT+IHpO3TM6wn0wdYZvYreXHSvE8knSxzVulFeyjbb2VOK8rBqXdxwKd/PFHa+lbfy7DcIUz373Q==
X-Received: by 2002:a05:600c:8b6a:b0:45f:5b02:b0cb with SMTP id 5b1f17b1804b1-45f5b02b390mr1128685e9.0.1758029263552;
        Tue, 16 Sep 2025 06:27:43 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e95b111b68sm12008298f8f.32.2025.09.16.06.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:27:43 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:27:39 +0000
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
Message-ID: <aMlly_9kDE04Inn2@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-3-smostafa@google.com>
 <aMA13Sowq91XEqP9@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMA13Sowq91XEqP9@willie-the-truck>

On Tue, Sep 09, 2025 at 03:12:45PM +0100, Will Deacon wrote:
> On Tue, Aug 19, 2025 at 09:51:30PM +0000, Mostafa Saleh wrote:
> > Add a function to donate MMIO to the hypervisor so IOMMU hypervisor
> > drivers can use that to protect the MMIO of IOMMU.
> > The initial attempt to implement this was to have a new flag to
> > "___pkvm_host_donate_hyp" to accept MMIO. However that had many problems,
> > it was quite intrusive for host/hyp to check/set page state to make it
> > aware of MMIO and to encode the state in the page table in that case.
> > Which is called in paths that can be sensitive to performance (FFA, VMs..)
> > 
> > As donating MMIO is very rare, and we don’t need to encode the full state,
> > it’s reasonable to have a separate function to do this.
> > It will init the host s2 page table with an invalid leaf with the owner ID
> > to prevent the host from mapping the page on faults.
> > 
> > Also, prevent kvm_pgtable_stage2_unmap() from removing owner ID from
> > stage-2 PTEs, as this can be triggered from recycle logic under memory
> > pressure. There is no code relying on this, as all ownership changes is
> > done via kvm_pgtable_stage2_set_owner()
> > 
> > For error path in IOMMU drivers, add a function to donate MMIO back
> > from hyp to host.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  2 +
> >  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 64 +++++++++++++++++++
> >  arch/arm64/kvm/hyp/pgtable.c                  |  9 +--
> >  3 files changed, 68 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > index 52d7ee91e18c..98e173da0f9b 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> > @@ -37,6 +37,8 @@ int __pkvm_host_share_hyp(u64 pfn);
> >  int __pkvm_host_unshare_hyp(u64 pfn);
> >  int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages);
> >  int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot);
> > +int __pkvm_host_donate_hyp_mmio(u64 pfn);
> > +int __pkvm_hyp_donate_host_mmio(u64 pfn);
> >  int __pkvm_hyp_donate_host(u64 pfn, u64 nr_pages);
> >  int __pkvm_host_share_ffa(u64 pfn, u64 nr_pages);
> >  int __pkvm_host_unshare_ffa(u64 pfn, u64 nr_pages);
> > diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > index 861e448183fd..c9a15ef6b18d 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> > @@ -799,6 +799,70 @@ int ___pkvm_host_donate_hyp(u64 pfn, u64 nr_pages, enum kvm_pgtable_prot prot)
> >  	return ret;
> >  }
> >  
> > +int __pkvm_host_donate_hyp_mmio(u64 pfn)
> > +{
> > +	u64 phys = hyp_pfn_to_phys(pfn);
> > +	void *virt = __hyp_va(phys);
> > +	int ret;
> > +	kvm_pte_t pte;
> > +
> > +	host_lock_component();
> > +	hyp_lock_component();
> > +
> > +	ret = kvm_pgtable_get_leaf(&host_mmu.pgt, phys, &pte, NULL);
> > +	if (ret)
> > +		goto unlock;
> > +
> > +	if (pte && !kvm_pte_valid(pte)) {
> > +		ret = -EPERM;
> > +		goto unlock;
> > +	}
> 
> Shouldn't we first check that the pfn is indeed MMIO? Otherwise, testing
> the pte for the ownership information isn't right.

I will add it, although the input should be trusted as it comes from the
hypervisor SMMUv3 driver.

> 
> > +	ret = kvm_pgtable_get_leaf(&pkvm_pgtable, (u64)virt, &pte, NULL);
> > +	if (ret)
> > +		goto unlock;
> > +	if (pte) {
> > +		ret = -EBUSY;
> > +		goto unlock;
> > +	}
> > +
> > +	ret = pkvm_create_mappings_locked(virt, virt + PAGE_SIZE, PAGE_HYP_DEVICE);
> > +	if (ret)
> > +		goto unlock;
> > +	/*
> > +	 * We set HYP as the owner of the MMIO pages in the host stage-2, for:
> > +	 * - host aborts: host_stage2_adjust_range() would fail for invalid non zero PTEs.
> > +	 * - recycle under memory pressure: host_stage2_unmap_dev_all() would call
> > +	 *   kvm_pgtable_stage2_unmap() which will not clear non zero invalid ptes (counted).
> > +	 * - other MMIO donation: Would fail as we check that the PTE is valid or empty.
> > +	 */
> > +	WARN_ON(host_stage2_try(kvm_pgtable_stage2_set_owner, &host_mmu.pgt, phys,
> > +				PAGE_SIZE, &host_s2_pool, PKVM_ID_HYP));
> > +unlock:
> > +	hyp_unlock_component();
> > +	host_unlock_component();
> > +
> > +	return ret;
> > +}
> > +
> > +int __pkvm_hyp_donate_host_mmio(u64 pfn)
> > +{
> > +	u64 phys = hyp_pfn_to_phys(pfn);
> > +	u64 virt = (u64)__hyp_va(phys);
> > +	size_t size = PAGE_SIZE;
> > +
> > +	host_lock_component();
> > +	hyp_lock_component();
> 
> Shouldn't we check that:
> 
>   1. pfn is mmio
>   2. pfn is owned by hyp
>   3. The host doesn't have something mapped at pfn already
> 
> ?
> 

I thought about this initially, but as
- This code is only called from the hypervisor with trusted
  inputs (only at boot)
- Only called on error path

So WARN_ON in case of failure to unmap MMIO pages seemed is good enough,
to avoid extra code.

But I can add the checks if you think they are necessary, we will need
to add new helpers for MMIO state though.

> > +	WARN_ON(kvm_pgtable_hyp_unmap(&pkvm_pgtable, virt, size) != size);
> > +	WARN_ON(host_stage2_try(kvm_pgtable_stage2_set_owner, &host_mmu.pgt, phys,
> > +				PAGE_SIZE, &host_s2_pool, PKVM_ID_HOST));
> > +	hyp_unlock_component();
> > +	host_unlock_component();
> > +
> > +	return 0;
> > +}
> > +
> >  int __pkvm_host_donate_hyp(u64 pfn, u64 nr_pages)
> >  {
> >  	return ___pkvm_host_donate_hyp(pfn, nr_pages, PAGE_HYP);
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index c351b4abd5db..ba06b0c21d5a 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -1095,13 +1095,8 @@ static int stage2_unmap_walker(const struct kvm_pgtable_visit_ctx *ctx,
> >  	kvm_pte_t *childp = NULL;
> >  	bool need_flush = false;
> >  
> > -	if (!kvm_pte_valid(ctx->old)) {
> > -		if (stage2_pte_is_counted(ctx->old)) {
> > -			kvm_clear_pte(ctx->ptep);
> > -			mm_ops->put_page(ctx->ptep);
> > -		}
> > -		return 0;
> > -	}
> > +	if (!kvm_pte_valid(ctx->old))
> > +		return stage2_pte_is_counted(ctx->old) ? -EPERM : 0;
> 
> Can this code be reached for the guest? For example, if
> pkvm_pgtable_stage2_destroy() runs into an MMIO-guarded pte on teardown?

AFAICT, VMs page table is destroyed from reclaim_pgtable_pages() =>
kvm_pgtable_stage2_destroy() => kvm_pgtable_stage2_destroy_range() ... =>
stage2_free_walker()

Which doesn't interact with “stage2_unmap_walker”, so that should be
fine.

Thanks,
Mostafa


> 
> Will

