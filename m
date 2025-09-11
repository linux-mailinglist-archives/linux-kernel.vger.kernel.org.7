Return-Path: <linux-kernel+bounces-811392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B789CB52880
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9CE56837F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D1E25487B;
	Thu, 11 Sep 2025 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9fI4+Oy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E29247280
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757570946; cv=none; b=Quo5ot7KRbWHDcro0LidC4TEB07XoOSnv4r7eYxVrEeMBqfSr6vfSjz5nK0+gvJCmaWSGOT+mVPFTjgRzHI3tNtjjNJqCrSSxfFv/MpKWNmWvmhBwCRW7FgoR+E6EPAWDt3D+1N//NI15SfHk+NiliyuzL2QYfjTQjBSREYGoKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757570946; c=relaxed/simple;
	bh=4l/sgeuvL16E6QGwkt7DH8G9HIgPj/gFpODwQHwsK6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkOI7sS4umsVP5L/mgLYwjknEA2hRTbi5fyhww9yIFsGq4HV4KX1AxDE/KJOCGul1DyqwXA/nESuQ+5C6uAm/uxMHRDM01HO4KizODUmF8HSiz82CpUJimvXgfdCCYaBa6Wg87TkUm6WTxLJ/1+JNUvCBLjG6hW5saxX15q4yeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9fI4+Oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DCFC4CEF7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757570946;
	bh=4l/sgeuvL16E6QGwkt7DH8G9HIgPj/gFpODwQHwsK6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f9fI4+OysVwMD1AENPdmiefqzG9xXe2bb8ARx81JA/Q2xlbZkraX/LEMn7luvAazu
	 WE2AXeX45AiZDFn5NkrqDbofvxjmkNecWA9OcGy7QWVxdETVIRT7JDq2kNUQrdjq0X
	 CCcApAhkb0Tb0pnwTSOZVU+SqMT3r1U2VVFCsYXvK5H0LF9S6y/6+WpuxshEK3Gk7y
	 0rrlhunTlbHQB2l3fSyieArzqbWhMs8eqrIdcueE9LINW+7oVNeHmfYevLi5kpQyCr
	 YKiX85Ey3cIoOmQDOJ3+27F3gRI2F9rYJNQVquNZ1UA6CyOjTHIfzsvKOT0LWxOCgE
	 DeS1NPlxDXfGg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5608b619cd8so345491e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:09:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWc/yW46qTnUgzhWlBd7nzdKqM6UxzTR7kBBGqXT8R0bY8r8QXz9ehpErxfkgPV8O/Kid4QSEMJGy78XWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVKIhOJ50yjo2wbjkBLekzk22MvcuKADFnzaVBUqEXPWLHqXMj
	OUQ6A5RLJ2i3FufzkNDizJt8Fih6O6E2IB2beBiSOQ/BjMmE1lyEubAeY0RzSsas5+gMCiysDoS
	cqqF029MrVbsMdHzLk3KJ426q3J8YDgE=
X-Google-Smtp-Source: AGHT+IGY3WOjekJ6qJ43Jy5UpK9jc6qB/kaPrzvJn81RTPFSgaRCfsVXO4s4jdV6GhcnmLfJGQc0Rz9bHvxlBhkUN5A=
X-Received: by 2002:a05:6512:613:10b0:564:8df6:f0ca with SMTP id
 2adb3069b0e04-5648e063869mr5087250e87.51.1757570944528; Wed, 10 Sep 2025
 23:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910104454.317067-1-kevin.brodsky@arm.com> <41f3227e-b945-4303-90b7-732affb0a101@arm.com>
In-Reply-To: <41f3227e-b945-4303-90b7-732affb0a101@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Sep 2025 08:08:53 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEmfCHpssFjn_+4ZjKCUaWPeiVwznCpGumTfz33k-rfkg@mail.gmail.com>
X-Gm-Features: Ac12FXxGPiAiUgpISOErtzNQVo4vC18qMAWqqG4GDTeh8bKldkAYztNZVWFIs-I
Message-ID: <CAMj1kXEmfCHpssFjn_+4ZjKCUaWPeiVwznCpGumTfz33k-rfkg@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: Move KPTI helpers to mmu.c
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 07:13, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 10/09/25 4:14 PM, Kevin Brodsky wrote:
> > create_kpti_ng_temp_pgd() is currently defined (as an alias) in
> > mmu.c without matching declaration in a header; instead cpufeature.c
> > makes its own declaration. This is clearly not pretty, and as commit
> > ceca927c86e6 ("arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc
> > function signature") showed, it also makes it very easy for the
> > prototypes to go out of sync.
> >
> > All this would be much simpler if kpti_install_ng_mappings() and
> > associated functions lived in mmu.c, where they logically belong.
> > This is what this patch does:
> > - Move kpti_install_ng_mappings() and associated functions from
> >   cpufeature.c to mmu.c, add a declaration to <asm/mmu.h>
> > - Make create_kpti_ng_temp_pgd() a static function that simply calls
> >   __create_pgd_mapping_locked() instead of aliasing it
> > - Mark all these functions __init
> > - Move __initdata after kpti_ng_temp_alloc (as suggested by
> >   checkpatch)
> >
> > Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> > ---
> > Note: as things stand, create_kpti_ng_temp_pgd() could be removed,
> > but a separate patch [1] will make use of it to add an
> > assertion.
> >
> > [1] https://lore.kernel.org/all/20250813145607.1612234-3-chaitanyas.prakash@arm.com/
> > ---
> > Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Kees Cook <kees@kernel.org>,
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >  arch/arm64/include/asm/mmu.h   |   6 ++
> >  arch/arm64/kernel/cpufeature.c |  97 ------------------------------
> >  arch/arm64/mm/mmu.c            | 106 ++++++++++++++++++++++++++++++---
> >  3 files changed, 103 insertions(+), 106 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> > index 49f1a810df16..624edd6c4964 100644
> > --- a/arch/arm64/include/asm/mmu.h
> > +++ b/arch/arm64/include/asm/mmu.h
> > @@ -104,5 +104,11 @@ static inline bool kaslr_requires_kpti(void)
> >       return true;
> >  }
> >
> > +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> > +void kpti_install_ng_mappings(void);
>
> Could the declarations be moved here instead ?

Why?

> Otherwise LGTM.
>
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 624edd6c4964..062465939192 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -106,6 +106,8 @@ static inline bool kaslr_requires_kpti(void)
>
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  void kpti_install_ng_mappings(void);
> +typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
> +kpti_remap_fn idmap_kpti_install_ng_mappings;
>  #else
>  static inline void kpti_install_ng_mappings(void) {}
>  #endif
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index eff3295393ee..1b5c3c590e95 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -750,8 +750,6 @@ static void __init create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys,
>
>  static int __init __kpti_install_ng_mappings(void *__unused)
>  {
> -       typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
> -       extern kpti_remap_fn idmap_kpti_install_ng_mappings;
>         kpti_remap_fn *remap_fn;
>
>         int cpu = smp_processor_id();
>
> > +#else
> > +static inline void kpti_install_ng_mappings(void) {}
> > +#endif
> > +
> >  #endif       /* !__ASSEMBLY__ */
> >  #endif
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index ef269a5a37e1..b99eaad48c14 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1940,103 +1940,6 @@ static bool has_pmuv3(const struct arm64_cpu_capabilities *entry, int scope)
> >  }
> >  #endif
> >
> > -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> > -#define KPTI_NG_TEMP_VA              (-(1UL << PMD_SHIFT))
> > -
> > -extern
> > -void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
> > -                          phys_addr_t size, pgprot_t prot,
> > -                          phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags);
> > -
> > -static phys_addr_t __initdata kpti_ng_temp_alloc;
> > -
> > -static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
> > -{
> > -     kpti_ng_temp_alloc -= PAGE_SIZE;
> > -     return kpti_ng_temp_alloc;
> > -}
> > -
> > -static int __init __kpti_install_ng_mappings(void *__unused)
> > -{
> > -     typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
> > -     extern kpti_remap_fn idmap_kpti_install_ng_mappings;
> > -     kpti_remap_fn *remap_fn;
> > -
> > -     int cpu = smp_processor_id();
> > -     int levels = CONFIG_PGTABLE_LEVELS;
> > -     int order = order_base_2(levels);
> > -     u64 kpti_ng_temp_pgd_pa = 0;
> > -     pgd_t *kpti_ng_temp_pgd;
> > -     u64 alloc = 0;
> > -
> > -     if (levels == 5 && !pgtable_l5_enabled())
> > -             levels = 4;
> > -     else if (levels == 4 && !pgtable_l4_enabled())
> > -             levels = 3;
> > -
> > -     remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
> > -
> > -     if (!cpu) {
> > -             alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> > -             kpti_ng_temp_pgd = (pgd_t *)(alloc + (levels - 1) * PAGE_SIZE);
> > -             kpti_ng_temp_alloc = kpti_ng_temp_pgd_pa = __pa(kpti_ng_temp_pgd);
> > -
> > -             //
> > -             // Create a minimal page table hierarchy that permits us to map
> > -             // the swapper page tables temporarily as we traverse them.
> > -             //
> > -             // The physical pages are laid out as follows:
> > -             //
> > -             // +--------+-/-------+-/------ +-/------ +-\\\--------+
> > -             // :  PTE[] : | PMD[] : | PUD[] : | P4D[] : ||| PGD[]  :
> > -             // +--------+-\-------+-\------ +-\------ +-///--------+
> > -             //      ^
> > -             // The first page is mapped into this hierarchy at a PMD_SHIFT
> > -             // aligned virtual address, so that we can manipulate the PTE
> > -             // level entries while the mapping is active. The first entry
> > -             // covers the PTE[] page itself, the remaining entries are free
> > -             // to be used as a ad-hoc fixmap.
> > -             //
> > -             create_kpti_ng_temp_pgd(kpti_ng_temp_pgd, __pa(alloc),
> > -                                     KPTI_NG_TEMP_VA, PAGE_SIZE, PAGE_KERNEL,
> > -                                     kpti_ng_pgd_alloc, 0);
> > -     }
> > -
> > -     cpu_install_idmap();
> > -     remap_fn(cpu, num_online_cpus(), kpti_ng_temp_pgd_pa, KPTI_NG_TEMP_VA);
> > -     cpu_uninstall_idmap();
> > -
> > -     if (!cpu) {
> > -             free_pages(alloc, order);
> > -             arm64_use_ng_mappings = true;
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> > -static void __init kpti_install_ng_mappings(void)
> > -{
> > -     /* Check whether KPTI is going to be used */
> > -     if (!arm64_kernel_unmapped_at_el0())
> > -             return;
> > -
> > -     /*
> > -      * We don't need to rewrite the page-tables if either we've done
> > -      * it already or we have KASLR enabled and therefore have not
> > -      * created any global mappings at all.
> > -      */
> > -     if (arm64_use_ng_mappings)
> > -             return;
> > -
> > -     stop_machine(__kpti_install_ng_mappings, NULL, cpu_online_mask);
> > -}
> > -
> > -#else
> > -static inline void kpti_install_ng_mappings(void)
> > -{
> > -}
> > -#endif       /* CONFIG_UNMAP_KERNEL_AT_EL0 */
> > -
> >  static void cpu_enable_kpti(struct arm64_cpu_capabilities const *cap)
> >  {
> >       if (__this_cpu_read(this_cpu_vector) == vectors) {
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 183801520740..eff3295393ee 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/kfence.h>
> >  #include <linux/pkeys.h>
> >  #include <linux/mm_inline.h>
> > +#include <linux/stop_machine.h>
> >
> >  #include <asm/barrier.h>
> >  #include <asm/cputype.h>
> > @@ -466,14 +467,6 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
> >       mutex_unlock(&fixmap_lock);
> >  }
> >
> > -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> > -extern __alias(__create_pgd_mapping_locked)
> > -void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
> > -                          phys_addr_t size, pgprot_t prot,
> > -                          phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> > -                          int flags);
> > -#endif
> > -
> >  static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
> >                                      enum pgtable_type pgtable_type)
> >  {
> > @@ -735,7 +728,102 @@ static void __init declare_vma(struct vm_struct *vma,
> >  }
> >
> >  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> > -static pgprot_t kernel_exec_prot(void)
> > +#define KPTI_NG_TEMP_VA              (-(1UL << PMD_SHIFT))
> > +
> > +static phys_addr_t kpti_ng_temp_alloc __initdata;
> > +
> > +static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
> > +{
> > +     kpti_ng_temp_alloc -= PAGE_SIZE;
> > +     return kpti_ng_temp_alloc;
> > +}
> > +
> > +static void __init create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys,
> > +                                        unsigned long virt, phys_addr_t size,
> > +                                        pgprot_t prot,
> > +                                        phys_addr_t (*pgtable_alloc)(enum pgtable_type),
> > +                                        int flags)
> > +{
> > +     __create_pgd_mapping_locked(pgdir, phys, virt, size, prot,
> > +                                 pgtable_alloc, flags);
> > +}
> > +
> > +static int __init __kpti_install_ng_mappings(void *__unused)
> > +{
> > +     typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
> > +     extern kpti_remap_fn idmap_kpti_install_ng_mappings;
> > +     kpti_remap_fn *remap_fn;
> > +
> > +     int cpu = smp_processor_id();
> > +     int levels = CONFIG_PGTABLE_LEVELS;
> > +     int order = order_base_2(levels);
> > +     u64 kpti_ng_temp_pgd_pa = 0;
> > +     pgd_t *kpti_ng_temp_pgd;
> > +     u64 alloc = 0;
> > +
> > +     if (levels == 5 && !pgtable_l5_enabled())
> > +             levels = 4;
> > +     else if (levels == 4 && !pgtable_l4_enabled())
> > +             levels = 3;
> > +
> > +     remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
> > +
> > +     if (!cpu) {
> > +             alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> > +             kpti_ng_temp_pgd = (pgd_t *)(alloc + (levels - 1) * PAGE_SIZE);
> > +             kpti_ng_temp_alloc = kpti_ng_temp_pgd_pa = __pa(kpti_ng_temp_pgd);
> > +
> > +             //
> > +             // Create a minimal page table hierarchy that permits us to map
> > +             // the swapper page tables temporarily as we traverse them.
> > +             //
> > +             // The physical pages are laid out as follows:
> > +             //
> > +             // +--------+-/-------+-/------ +-/------ +-\\\--------+
> > +             // :  PTE[] : | PMD[] : | PUD[] : | P4D[] : ||| PGD[]  :
> > +             // +--------+-\-------+-\------ +-\------ +-///--------+
> > +             //      ^
> > +             // The first page is mapped into this hierarchy at a PMD_SHIFT
> > +             // aligned virtual address, so that we can manipulate the PTE
> > +             // level entries while the mapping is active. The first entry
> > +             // covers the PTE[] page itself, the remaining entries are free
> > +             // to be used as a ad-hoc fixmap.
> > +             //
> > +             create_kpti_ng_temp_pgd(kpti_ng_temp_pgd, __pa(alloc),
> > +                                     KPTI_NG_TEMP_VA, PAGE_SIZE, PAGE_KERNEL,
> > +                                     kpti_ng_pgd_alloc, 0);
> > +     }
> > +
> > +     cpu_install_idmap();
> > +     remap_fn(cpu, num_online_cpus(), kpti_ng_temp_pgd_pa, KPTI_NG_TEMP_VA);
> > +     cpu_uninstall_idmap();
> > +
> > +     if (!cpu) {
> > +             free_pages(alloc, order);
> > +             arm64_use_ng_mappings = true;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +void __init kpti_install_ng_mappings(void)
> > +{
> > +     /* Check whether KPTI is going to be used */
> > +     if (!arm64_kernel_unmapped_at_el0())
> > +             return;
> > +
> > +     /*
> > +      * We don't need to rewrite the page-tables if either we've done
> > +      * it already or we have KASLR enabled and therefore have not
> > +      * created any global mappings at all.
> > +      */
> > +     if (arm64_use_ng_mappings)
> > +             return;
> > +
> > +     stop_machine(__kpti_install_ng_mappings, NULL, cpu_online_mask);
> > +}
> > +
> > +static pgprot_t __init kernel_exec_prot(void)
> >  {
> >       return rodata_enabled ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
> >  }
> >
> > base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
>

