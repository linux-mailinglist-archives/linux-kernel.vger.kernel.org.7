Return-Path: <linux-kernel+bounces-683361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4629AD6C74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 11:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3FE716317A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 09:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C23222AE76;
	Thu, 12 Jun 2025 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BhV7Lz6X"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E0222A1E6
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749721348; cv=none; b=eLI8H2JeCw42MuwXix2rDRD+ADH5ehAH3Yy40YPGwo0MYXm2l75PJ9X6rgsTQNitOWxAu/6If/CAhVhjlOWBFI3ko/1XN/jURfClG8YvWCuC0ua7O1LUpgCDk162gmAt3fojPZUSCpZ+Sy0+lluipm4EWE6+SeO9tIUqMpaQvQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749721348; c=relaxed/simple;
	bh=B6i1/NKZAycwMjIJfc+svgVEj0HsKhfaaM+rxiJwbYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q17X2rD4JGc8rSPWSkyGGY6P9imTtNtuR7vxCDge6KWk1fRTz4m2jWL30Bw+cUfXAE4Rq9VbhXj90unm6zUhsubjVxrSVEMUeq6PgA6MN8dXoPWG3qSsd8Kz3x3YFBlttU68vy335dQ3wvU0WZB17I35Fbn55JfZ2OgbBdcKzgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BhV7Lz6X; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4532ff4331cso971465e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 02:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1749721345; x=1750326145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MGCZJff9QsWdyC25gI2iQ7ufzGiMMYlGPI7zLficnT8=;
        b=BhV7Lz6Xmbqbkf0y2iNf7fCJbfz1FeORDe91QHHVO74H6AyPjWYxdPwYKyVNTS20C6
         7BlhKWowjr1ANPKXF8VzGOQr6eo99x5Pm+MO3lZOQWO8H9H/zaMy2rbdrIz9pjkwBZkv
         FYl5kThsA0cFWnctvHI+aIHEYbxxMw/vpvB6WI7b0mZRRk6ySnRVUpjdagYECbfdgjEM
         xV4MZvhYspdKtfDKyxy49XeLuoQkJm8Bts0b613hDHe9Juwu5PU4Fb3vm1Vxu5AeKJ9B
         x8fEJhXkADYlQKApyevhg38hsFRXGu7r6K46Dlh3Q5KuvRsNyhk3tVnOmFgLehGsA30w
         3csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749721345; x=1750326145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGCZJff9QsWdyC25gI2iQ7ufzGiMMYlGPI7zLficnT8=;
        b=vUj1UbQXBdSA3Iloen7hdfwOGKnwnjOBwWg9dlJGpM9T2Dmf/8U4V2mRE4N16pNB1I
         l4mxuXqAwJthvj2J81nsb6MuZQWhkbQm+Nx/WUSWR4XxdM3CnqfQJFfGrabwn1X7RNPW
         F36i8Pzi1Dm6IPyyVG/UHQk64mYfl873nNs19kDn4JRzadCVVRhlz98Rz2wn91KU37/R
         xGOta3qkx5QbBI/yO+JvAmHhmNIdWTfnSAJQiDoBtszvyMvjHXMwU49VfP9RAVoUfnkI
         T4PHV8GGLWOqcD+wcVjSvlIzsJU2e2r0sgrG6CjjCVsY0TPMBI+Ub1cFFsbAfJOdvJx4
         LFCw==
X-Forwarded-Encrypted: i=1; AJvYcCXG4twCW/VTkPsfWNro7Mpb9amaRfWK4Gv3iA/2Qn5zn38ugHiN3w28JJQldPCI0HimMlmkKBreEgu62GY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw74/AWIMObFcEAG0N1x0pOtZAtFH2KxIC90aLyx4sLh0zAi68s
	VmUnCzmx47sF6Qxl0ddB3zgrXPaeRICfDU/eDa7KmszmVO89UEwCzkV3Cm+06+8LBOU=
X-Gm-Gg: ASbGncs0mngV12K881VLKXsZYUQs59w+pFRuKioAzfSeMZrpMgBwMfYh4USrGwlGpHb
	lkO7BlfCz8vQDNMytndbidYe83oIcnCLxqne2XJseANEahNhYcQ1qDpKVnmNLZam+Ht95cFt+AB
	HenumZMtGo3A9l02A6ycALTx6dCVzMz/79FxOs69Dw6R52LStFkOodJV6SfUH+OcW4ubssafEPt
	ZIMspMgt4cKrRMjyQ6DX2wA8z+HXxwpfjAdrn9P+o4GAgHAF8Ie04++aXZGjO/td+JWQXF8JuVQ
	FbNkFR01atyXM8ireIWDuO9vueEV5rCQ525XIS21KktKwXkurg==
X-Google-Smtp-Source: AGHT+IF5zKXW7+MBEotJUUCGt2uWsAMvwtWdDJrZZChMjo4YtbUSO3QK36jfNoOmtsRFwibuOJQU+w==
X-Received: by 2002:a05:600c:8b58:b0:450:d019:263 with SMTP id 5b1f17b1804b1-4532b9076acmr34955535e9.18.1749721344537;
        Thu, 12 Jun 2025 02:42:24 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::5485])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a561976048sm1449140f8f.8.2025.06.12.02.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 02:42:23 -0700 (PDT)
Date: Thu, 12 Jun 2025 11:42:23 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sean Christopherson <seanjc@google.com>
Cc: zhouquan@iscas.ac.cn, anup@brainfault.org, atishp@atishpatra.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: KVM: Avoid re-acquiring memslot in
 kvm_riscv_gstage_map()
Message-ID: <20250612-70c2e573983d05c4fbc41102@orel>
References: <50989f0a02790f9d7dc804c2ade6387c4e7fbdbc.1749634392.git.zhouquan@iscas.ac.cn>
 <20250611-352bef23df9a4ec55fe5cb68@orel>
 <aEmsIOuz3bLwjBW_@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEmsIOuz3bLwjBW_@google.com>

On Wed, Jun 11, 2025 at 09:17:36AM -0700, Sean Christopherson wrote:
> On Wed, Jun 11, 2025, Andrew Jones wrote:
> > On Wed, Jun 11, 2025 at 05:51:40PM +0800, zhouquan@iscas.ac.cn wrote:
> > > From: Quan Zhou <zhouquan@iscas.ac.cn>
> > > 
> > > The caller has already passed in the memslot, and there are
> > > two instances `{kvm_faultin_pfn/mark_page_dirty}` of retrieving
> > > the memslot again in `kvm_riscv_gstage_map`, we can replace them
> > > with `{__kvm_faultin_pfn/mark_page_dirty_in_slot}`.
> > > 
> > > Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> > > ---
> > >  arch/riscv/kvm/mmu.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> > > index 1087ea74567b..f9059dac3ba3 100644
> > > --- a/arch/riscv/kvm/mmu.c
> > > +++ b/arch/riscv/kvm/mmu.c
> > > @@ -648,7 +648,8 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
> > >  		return -EFAULT;
> > >  	}
> > >  
> > > -	hfn = kvm_faultin_pfn(vcpu, gfn, is_write, &writable, &page);
> > > +	hfn = __kvm_faultin_pfn(memslot, gfn, is_write ? FOLL_WRITE : 0,
> > > +				&writable, &page);
> > 
> > I think introducing another function with the following diff would be
> > better than duplicating the is_write to foll translation.
> 
> NAK, I don't want an explosion of wrapper APIs (especially with boolean params).
> 
> I 100% agree that it's mildly annoying to force arch code to do convert "write"
> to FOLL_WRITE, but that's a symptom of KVM not providing a common structure for
> passing page fault information.
> 
> What I want to get to is a set of APIs that look something the below (very off
> the cuff), not add more wrappers and put KVM back in a situation where there are
> a bajillion ways to do the same basic thing.
> 
> struct kvm_page_fault {
> 	const gpa_t addr;
> 	const bool exec;
> 	const bool write;
> 	const bool present;
> 
> 	gfn_t gfn;
> 
> 	/* The memslot containing gfn. May be NULL. */
> 	struct kvm_memory_slot *slot;
> 
> 	/* Outputs */
> 	unsigned long mmu_seq;
> 	kvm_pfn_t pfn;
> 	struct page *refcounted_page;
> 	bool map_writable;
> };
> 
> kvm_pfn_t __kvm_faultin_pfn(struct kvm_page_fault *fault, unsigned int flags)
> {
> 	struct kvm_follow_pfn kfp = {
> 		.slot = fault->slot,
> 		.gfn = fault->gfn,
> 		.flags = flags | fault->write ? FOLL_WRITE : 0,
> 		.map_writable = &fault->writable,
> 		.refcounted_page = &fault->refcounted_page,
> 	};
> 
> 	fault->writable = false;
> 	fault->refcounted_page = NULL;
> 
> 	return kvm_follow_pfn(&kfp);
> }
> EXPORT_SYMBOL_GPL(__kvm_faultin_pfn);
> 
> kvm_pfn_t kvm_faultin_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, bool write,
> 			  bool *writable, struct page **refcounted_page)
> {
> 	struct kvm_follow_pfn kfp = {
> 		.slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn),,
> 		.gfn = gfn,
> 		.flags = write ? FOLL_WRITE : 0,
> 		.map_writable = writable,
> 		.refcounted_page = refcounted_page,
> 	};
> 
> 	if (WARN_ON_ONCE(!writable || !refcounted_page))
> 		return KVM_PFN_ERR_FAULT;
> 
> 	*writable = false;
> 	*refcounted_page = NULL;
> 
> 	return kvm_follow_pfn(&kfp);
> }
> EXPORT_SYMBOL_GPL(__kvm_faultin_pfn);
> 
> 
> To get things started, I proposed moving "struct kvm_page_fault" to common code
> so that it can be shared by x86 and arm64 as part of the KVM userfault series.
> But I'd be more than happy to acclerate the standardization of "struct kvm_page_fault"
> if we want to get there sooner than later.
> 
> [*] https://lore.kernel.org/all/aBqlkz1bqhu-9toV@google.com
> 
> In the meantime, RISC-V can start preparing for that future, and clean up its
> code in the process.
> 
> E.g. "fault_addr" should be "gpa_t", not "unsigned long".  If 32-bit RISC-V
> is strictly limited to 32-bit _physical_ addresses in the *architecture*, then
> gpa_t should probably be tweaked accordingly.

32-bit riscv supports 34-bit physical addresses, so fault_addr should
indeed be gpa_t.

> 
> And vma_pageshift should be "unsigned int", not "short".

Yes, particularly because huge_page_shift() returns unsigned int which may
be used to assign vma_pageshift.

> 
> Looks like y'all also have a bug where an -EEXIST will be returned to userspace,
> and will generate what's probably a spurious kvm_err() message.

On 32-bit riscv, due to losing the upper bits of the physical address? Or
is there yet another thing to fix?

> 
> E.g. in the short term:

The diff looks good to me, should I test and post it for you?

Thanks,
drew

> 
> ---
>  arch/riscv/include/asm/kvm_host.h |  5 ++--
>  arch/riscv/kvm/mmu.c              | 49 +++++++++++++++++++++----------
>  arch/riscv/kvm/vcpu_exit.c        | 40 +------------------------
>  3 files changed, 36 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index 85cfebc32e4c..84c5db715ba5 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -361,9 +361,8 @@ int kvm_riscv_gstage_ioremap(struct kvm *kvm, gpa_t gpa,
>  			     bool writable, bool in_atomic);
>  void kvm_riscv_gstage_iounmap(struct kvm *kvm, gpa_t gpa,
>  			      unsigned long size);
> -int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
> -			 struct kvm_memory_slot *memslot,
> -			 gpa_t gpa, unsigned long hva, bool is_write);
> +int kvm_riscv_gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
> +				struct kvm_cpu_trap *trap);
>  int kvm_riscv_gstage_alloc_pgd(struct kvm *kvm);
>  void kvm_riscv_gstage_free_pgd(struct kvm *kvm);
>  void kvm_riscv_gstage_update_hgatp(struct kvm_vcpu *vcpu);
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 1087ea74567b..3b0afc1c0832 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -586,22 +586,37 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>  	return pte_young(ptep_get(ptep));
>  }
>  
> -int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
> -			 struct kvm_memory_slot *memslot,
> -			 gpa_t gpa, unsigned long hva, bool is_write)
> +int kvm_riscv_gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
> +				struct kvm_cpu_trap *trap)
>  {
> -	int ret;
> -	kvm_pfn_t hfn;
> -	bool writable;
> -	short vma_pageshift;
> +
> +	struct kvm_mmu_memory_cache *pcache = &vcpu->arch.mmu_page_cache;
> +	gpa_t gpa = (trap->htval << 2) | (trap->stval & 0x3);
>  	gfn_t gfn = gpa >> PAGE_SHIFT;
> -	struct vm_area_struct *vma;
> +	struct kvm_memory_slot *memslot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
> +	bool logging = memslot->dirty_bitmap && !(memslot->flags & KVM_MEM_READONLY);
> +	bool write = trap->scause == EXC_STORE_GUEST_PAGE_FAULT;
> +	bool read =  trap->scause == EXC_LOAD_GUEST_PAGE_FAULT;
> +	unsigned int flags = write ? FOLL_WRITE : 0;
> +	unsigned long hva, vma_pagesize, mmu_seq;
>  	struct kvm *kvm = vcpu->kvm;
> -	struct kvm_mmu_memory_cache *pcache = &vcpu->arch.mmu_page_cache;
> -	bool logging = (memslot->dirty_bitmap &&
> -			!(memslot->flags & KVM_MEM_READONLY)) ? true : false;
> -	unsigned long vma_pagesize, mmu_seq;
> +	unsigned int vma_pageshift;
> +	struct vm_area_struct *vma;
>  	struct page *page;
> +	kvm_pfn_t hfn;
> +	bool writable;
> +	int ret;
> +
> +	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
> +	if (kvm_is_error_hva(hva) || (write && !writable)) {
> +		if (read)
> +			return kvm_riscv_vcpu_mmio_load(vcpu, run, gpa,
> +							trap->htinst);
> +		if (write)
> +			return kvm_riscv_vcpu_mmio_store(vcpu, run, gpa,
> +							 trap->htinst);
> +		return -EOPNOTSUPP;
> +	}
>  
>  	/* We need minimum second+third level pages */
>  	ret = kvm_mmu_topup_memory_cache(pcache, gstage_pgd_levels);
> @@ -648,7 +663,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>  		return -EFAULT;
>  	}
>  
> -	hfn = kvm_faultin_pfn(vcpu, gfn, is_write, &writable, &page);
> +	hfn = __kvm_faultin_pfn(memslot, gfn, flags, &writable, &page);
>  	if (hfn == KVM_PFN_ERR_HWPOISON) {
>  		send_sig_mceerr(BUS_MCEERR_AR, (void __user *)hva,
>  				vma_pageshift, current);
> @@ -661,7 +676,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>  	 * If logging is active then we allow writable pages only
>  	 * for write faults.
>  	 */
> -	if (logging && !is_write)
> +	if (logging && !write)
>  		writable = false;
>  
>  	spin_lock(&kvm->mmu_lock);
> @@ -677,14 +692,16 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>  		ret = gstage_map_page(kvm, pcache, gpa, hfn << PAGE_SHIFT,
>  				      vma_pagesize, true, true);
>  	}
> +	if (ret == -EEXIST)
> +		ret = 0;
>  
>  	if (ret)
>  		kvm_err("Failed to map in G-stage\n");
>  
>  out_unlock:
> -	kvm_release_faultin_page(kvm, page, ret && ret != -EEXIST, writable);
> +	kvm_release_faultin_page(kvm, page, ret, writable);
>  	spin_unlock(&kvm->mmu_lock);
> -	return ret;
> +	return ret ? ret : 1;
>  }
>  
>  int kvm_riscv_gstage_alloc_pgd(struct kvm *kvm)
> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 6e0c18412795..6f07077068f6 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -10,44 +10,6 @@
>  #include <asm/csr.h>
>  #include <asm/insn-def.h>
>  
> -static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
> -			     struct kvm_cpu_trap *trap)
> -{
> -	struct kvm_memory_slot *memslot;
> -	unsigned long hva, fault_addr;
> -	bool writable;
> -	gfn_t gfn;
> -	int ret;
> -
> -	fault_addr = (trap->htval << 2) | (trap->stval & 0x3);
> -	gfn = fault_addr >> PAGE_SHIFT;
> -	memslot = gfn_to_memslot(vcpu->kvm, gfn);
> -	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
> -
> -	if (kvm_is_error_hva(hva) ||
> -	    (trap->scause == EXC_STORE_GUEST_PAGE_FAULT && !writable)) {
> -		switch (trap->scause) {
> -		case EXC_LOAD_GUEST_PAGE_FAULT:
> -			return kvm_riscv_vcpu_mmio_load(vcpu, run,
> -							fault_addr,
> -							trap->htinst);
> -		case EXC_STORE_GUEST_PAGE_FAULT:
> -			return kvm_riscv_vcpu_mmio_store(vcpu, run,
> -							 fault_addr,
> -							 trap->htinst);
> -		default:
> -			return -EOPNOTSUPP;
> -		};
> -	}
> -
> -	ret = kvm_riscv_gstage_map(vcpu, memslot, fault_addr, hva,
> -		(trap->scause == EXC_STORE_GUEST_PAGE_FAULT) ? true : false);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 1;
> -}
> -
>  /**
>   * kvm_riscv_vcpu_unpriv_read -- Read machine word from Guest memory
>   *
> @@ -229,7 +191,7 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  	case EXC_LOAD_GUEST_PAGE_FAULT:
>  	case EXC_STORE_GUEST_PAGE_FAULT:
>  		if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV)
> -			ret = gstage_page_fault(vcpu, run, trap);
> +			ret = kvm_riscv_gstage_page_fault(vcpu, run, trap);
>  		break;
>  	case EXC_SUPERVISOR_SYSCALL:
>  		if (vcpu->arch.guest_context.hstatus & HSTATUS_SPV)
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> -- 

