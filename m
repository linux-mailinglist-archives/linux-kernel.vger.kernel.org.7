Return-Path: <linux-kernel+bounces-818912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB75EB597FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DC03AEAFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3969F3191B0;
	Tue, 16 Sep 2025 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2oVxP6Z"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8A315D5E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030218; cv=none; b=M3ltjUWJ9NgbzVrOGiaVEGrpihxcG73g4v2M2G2MHSIGf+yTINTF6srLje0lzTVfWGt1m4NII6pwKNbAzhLLNUs+48LQfHBZABWOta2jQi9XEgYvmF9z5SwhOBSUxzU1Fs8qE/7vz69Mah2mPGKw4z0Y64HgJQNGcCvDk8pLSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030218; c=relaxed/simple;
	bh=aG0N8krrxMi6bz+piP0pXqzq+j6GXftkDiR9JS3f4po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ylcdsswkg4eiBfg1UHzVtqpc1F/ULl2kstU/XTsHokgE6e1OLnbSdS44d9yuFHgYnLJXMCfH17riHWTRDevf4C7UEd1zrUs/46A/lc7pj0xkxh1NTk7mBz44Je/EGYosWmFpD65nRSIyoDD6BcfOH98mL5uO1aLTDNwKncFZpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2oVxP6Z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f2f894632so52865e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758030215; x=1758635015; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfWHeFBkMHYJw5QiRGsKUIxVRqYkPAcQ5KBzj6Wt0do=;
        b=i2oVxP6ZW/PPZPeH+methff8IPZxi3WuV0Ikm52XDsvZKFvCsIaG9iMvY8B2MPW88c
         20NSdJ6/jsC7tp/kO8VOagkFRF4jANBuF2F5SMdO4Q3qmIMT9AwxzzUkPxLejBZ6oOec
         lUKgtYJBt9509MqbmCgAzakzE+Lelu/KBIJuC2NXibWkop8i3CfdDI75fH7wRO4THFOl
         JgAbqaoOm9Z4fkvsTc9SrTz5+bwx/8uRIZTGw5AZvXPrFs2/mf1IIhL4+9hhZC+YDI7p
         H9Kci57Y0ci+LruM3522bgshFnuKSH9IDyda3JldKyE4YFGAPzMueExtksy4AOo/gyZh
         n3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758030215; x=1758635015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SfWHeFBkMHYJw5QiRGsKUIxVRqYkPAcQ5KBzj6Wt0do=;
        b=WNvtBlxgMUSL/TNwyS3i1W7iiI0QaFRit+5uRp9xvLiDsIfqHScHjrLYDc499XhXY8
         JaZ/n2oT9C7XV7evKN3Pra7H9PCREztz3M96W4BNaFL4CI3rWNTBhWYrfmAXOHsC6Z37
         nbfq/GoQxoOXfurpMY1CvBpwc76kJx9c8ZL2548GR2lbssqooEXLZv7LIY/qCajuK1JV
         a1glxchRwrzzaZk8DxdMFNCzq/c0yuAsbhLH/AjdU7yEOGxraaenTQb0MsVCZSJU6O6N
         RitZ92y8wk/iIIRZdgdSVSNbb0fKzyDXaPFyU9HQBR1R3V1Dmn55tT7fdjuSnxX/wbi9
         z/eA==
X-Gm-Message-State: AOJu0Ywe8tkdHcyUTHL7sGWLNYkk8sO3B5ljX9v1cy5SRxnFS5JsW0Mj
	zqOlNmhgUDERN7ybuNR0upXfSXuUeVBWgrr1FCKVpAIb4TSuDBAAyio7m8/ul+YHvA==
X-Gm-Gg: ASbGnct1plazAF1uyCB4Ojp8nTGLDfm4l3CQnHG2FK5AR7ZSmtigBHKoChqu9MXS/HB
	fG7mafRsXCJ1BW89W0XQoTT4Bt/exnHqGqJHmCIQ2z9Dc2h6sUCaqR5CKQapCzIFvkcYjZQypkh
	IgFarCyRrwiBRlai7Zcl6o+9sgK5mwqVDuH2eQE+QgaR85/Wl0IUDMw6IbCA9FAOjYLeGHqq1rL
	/4u5BnKgTaClIIM1JM3YymrsXrYnCUikk3eobgxgOKgkM06SvJIUTKzscmXdqW10gSh1JNYGOkB
	I+BLmZWWDzw7YmsPG8midpWBMPPPXEX9NnZyg3QQunqDjBvAhmR9d1Or558FfuaONPRcl+bOxBQ
	0TX2OSa80bhioRVH2YMYY7KmccaB7PkoZAhGD0aTj/jc0te5swxALnSsPdWkbpff7AWAcRw==
X-Google-Smtp-Source: AGHT+IHpXz7Rl+QKYOCiUh0stE/LvQiGqQu2cCoRgHmA+CQxnORb4ciGuF1F6j581pn63hwwkNtSVg==
X-Received: by 2002:a05:600c:a10d:b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-4601d6b4da8mr520345e9.2.1758030214403;
        Tue, 16 Sep 2025 06:43:34 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e016b5a16sm223228305e9.12.2025.09.16.06.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:43:33 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:43:30 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com
Subject: Re: [PATCH v4 02/28] KVM: arm64: Donate MMIO to the hypervisor
Message-ID: <aMlpghG9s3hl9G3Q@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-3-smostafa@google.com>
 <aMcoYCcJXjN64cOE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMcoYCcJXjN64cOE@google.com>

On Sun, Sep 14, 2025 at 08:41:04PM +0000, Pranjal Shrivastava wrote:
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
> > +
> > +	ret = kvm_pgtable_get_leaf(&pkvm_pgtable, (u64)virt, &pte, NULL);
> > +	if (ret)
> > +		goto unlock;
> > +	if (pte) {
> > +		ret = -EBUSY;
> > +		goto unlock;
> > +	}
> 
> I'm thinking of a situation where both of these checks might be
> necessary.. The first check seems to confirm if the page being donated
> isn't set up to trap in the hyp (i.e. the donor/host doesn't own the
> page anymore). 
> 
> However, the second check seems to check if the pfn is already mapped
> in the hyp's space. Is this check only to catch errorneous donations of
> a shared page or is there something else?

The first check confirms that the host kernel owns the page, so it can
donate it.
The second check checks that the hypervisor doesn't already have something
mapped at this point.

I can't find a case where this happens, I believe the second is mainly a
debug check (similar to __pkvm_host_donate/share_hyp for normal memory.


Thanks,
Mostafa
> 
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
> > +
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
> >  
> >  	if (kvm_pte_table(ctx->old, ctx->level)) {
> >  		childp = kvm_pte_follow(ctx->old, mm_ops);
> > -- 
> 
> Thanks
> Praan

