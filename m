Return-Path: <linux-kernel+bounces-783366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3783B32C9B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 01:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E110A00764
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 23:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3811624A069;
	Sat, 23 Aug 2025 23:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icZkqdgh"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3555C1D5CD4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 23:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755993468; cv=none; b=ii5jWTRETPwO/Q9UtjQPKuFX7TvC+zy09VNG/jukNETDpdOjw6Uvv8ani8MncXvkydAF72ketxCm/bCCY2b6bxMaThx2PlqiRCQ6BpkKjVyE6QYjjS6BRbw43UZCIwbs5MO+ojx/HSp9zIor7N5uT1+lbLM8I5Cuk38ZvM5mhYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755993468; c=relaxed/simple;
	bh=rgDQCmVHVf2Eabuxthsmlr36gCWfIIR4SdkfYT1qJjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfHY+uA+IYpoW1NKZ0/j2aupXUkoRr63A5zKlCJwrHOY6PSX2lp0UGZfNRnkRoR9enzL2rGuaS/wktnXoTJAmqTMTAZkdVE5PqchCdcigK4K8ZaeY81RqMgXSll6TGvlDoq9nUPP8REgdqmrFb3KKfrE04YT0uaDCqzk0DQcJ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icZkqdgh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c763484ccdso415807f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755993464; x=1756598264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBWpk9pMFHao0No417vuFErr71wabiTatKoA7g+XDV0=;
        b=icZkqdghrEjlQj6bzUKI6PjRShz7KtL7zYxC3OXGsdWKwF9DjRe+/keNQwLDiX7H0q
         od0ma8GPn/p3MDK0dfPpD1l9k3zLG2juGdMyC/cEGCmPtePzODCKXjHsXXmj03oYO9Pc
         ewkXfDia5A7JJLYkhnh7msRaz0NqIts0HeuXLiv5KYEmyGMGM72V5vPXKK/sg7ytM8F4
         odrRqyPRlclYwd6iH5B+aHZMIDzkl9IIqprG4A5Erizt6pTVtSOMipbzp4UzTo3TKBWK
         nC1BAuGomXI0aDGYenP/m9dLyrbwKaSUGjFMxS9PYolD2y/Q1v5GXfIVo5dX2tY3hiAh
         YjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755993464; x=1756598264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBWpk9pMFHao0No417vuFErr71wabiTatKoA7g+XDV0=;
        b=Wwm5J3QMHc7hGJQYOblgV84Da2xCcjpgdyWkZZZaYO3ohQWP0LsQe7UiY3r5qrE/iJ
         AqM+6RiWwHseTM24UJ/BmnHx5EjpgIWa+pdwBkaOpUV6RhccP0vuCqVkh86FusyFDc6T
         X4ZR0Y6SuLYV13QNF9sZHa8tfMG2LHaZOibys0UVoddg9tliQqr1VxLfJuSrI9bK6za7
         JVCSmujx9tdccTKBVndT6ZxHr+m/EOcBQRs3V0lr7TKptO8I893YVmy5t5ttXTvhihBO
         hec3G60C7nc3GFzCMV183Byn0yomWmCFE1o4baiy8gzCIRjiajpK7d+gWTGH0dO2lEGS
         8OmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTGWq/JWDMD2cRFuO4w1/Fp37h6pdsWdNlkN8sv9knBjTcwkQoceZoUNAE84FLRXPMMo1/NPx8cc210i0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn/SA2gxXiC9t/2layEoF9daukV8FMDHAyGq5fFhMpy4s3vILj
	idKTyGDeCsCkMt5dmfmYSkqJX44E++NDobvXyXUFtRrqlvQqTMUlcfOOBCdamJ36RBYG64K9WBY
	a3jCzhKJSSeN9zy7jvmYsuivKjOBnzJc=
X-Gm-Gg: ASbGncsYobgT9Q89xM8wQYxsaIxIc+dH9jL0fCRJ0QyxK7U6oxaa7xsI9jiGzE4UDhG
	wOjI0BLZ7rzytJk/9EtIjwd+aBepeOGkYoeNsfMDfcq3/fSHHcq8JDHeMhzQ4eFDGP/rOQ+nVUy
	0UGrgcO1VUWOP6JieZjdNe15vHjFURLcbGeQu/GPig5M6UPEzlugSGT0sHekKfOGYsoU2xOxjlT
	mDmEgmutRmn+KvgHCm/7pQ9iwysIVVbFiYccTPf2l/Vgh8Jef3yQ6N01VuHRc3Fonpr9qhY
X-Google-Smtp-Source: AGHT+IFhc1jFZKivVpya3fI65qV0tE23a94OokTjPmFW6yC9nw0tHu2XPxdVBbt2o30eV+v4k6RZOzXJ8kN4RTgDs2E=
X-Received: by 2002:a05:6000:2382:b0:3c7:9b1b:e28f with SMTP id
 ffacd0b85a97d-3c79b1be80emr2333564f8f.21.1755993464377; Sat, 23 Aug 2025
 16:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822041538.467514-1-CFSworks@gmail.com> <20250822041538.467514-4-CFSworks@gmail.com>
In-Reply-To: <20250822041538.467514-4-CFSworks@gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Sat, 23 Aug 2025 16:57:33 -0700
X-Gm-Features: Ac12FXyQwqcUP-Y4py5hdYIVFsjstDj9Mv1n8N0f45wLrnmAeiZZw0lCwsMGrF8
Message-ID: <CAH5Ym4gOV_BJYuMgt+FgRE0WKJ9udnubv=Opw02hb14SGKTUow@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: mm: Represent physical memory with phys_addr_t
 and resource_size_t
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baruch Siach <baruch@tkos.co.il>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 9:19=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> wr=
ote:
>
> This is a type-correctness cleanup to MMU/boot code that replaces
> several instances of void * and u64 with phys_addr_t (to represent
> addresses) and resource_size_t (to represent sizes) to emphasize that
> the code in question concerns physical memory specifically.
>
> The rationale for this change is to improve clarity and readability in
> a few modules that handle both types (physical and virtual) of address
> and differentiation is essential.
>
> I have left u64 in cases where the address may be either physical or
> virtual, where the address is exclusively virtual but used in heavy
> pointer arithmetic, and in cases I may have overlooked. I do not
> necessarily consider u64 the ideal type in those situations, but it
> avoids breaking existing semantics in this cleanup.
>
> This patch provably has no effect at runtime: I have verified that
> .text of vmlinux is identical after this change.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  arch/arm64/kernel/pi/map_kernel.c | 26 +++++++++++++-------------
>  arch/arm64/kernel/pi/map_range.c  | 20 ++++++++++++--------
>  arch/arm64/kernel/pi/pi.h         |  9 +++++----
>  arch/arm64/mm/init.c              |  6 +++---
>  arch/arm64/mm/mmu.c               | 17 +++++++++--------
>  5 files changed, 42 insertions(+), 36 deletions(-)
>
> diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map=
_kernel.c
> index 5dc4107b5a7f..deb15074d289 100644
> --- a/arch/arm64/kernel/pi/map_kernel.c
> +++ b/arch/arm64/kernel/pi/map_kernel.c
> @@ -18,9 +18,9 @@
>
>  extern const u8 __eh_frame_start[], __eh_frame_end[];
>
> -extern void idmap_cpu_replace_ttbr1(void *pgdir);
> +extern void idmap_cpu_replace_ttbr1(phys_addr_t pgdir);
>
> -static void __init map_segment(pgd_t *pg_dir, u64 *pgd, u64 va_offset,
> +static void __init map_segment(pgd_t *pg_dir, phys_addr_t *pgd, u64 va_o=
ffset,
>                                void *start, void *end, pgprot_t prot,
>                                bool may_use_cont, int root_level)
>  {
> @@ -40,7 +40,7 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_=
offset, int root_level)
>  {
>         bool enable_scs =3D IS_ENABLED(CONFIG_UNWIND_PATCH_PAC_INTO_SCS);
>         bool twopass =3D IS_ENABLED(CONFIG_RELOCATABLE);
> -       u64 pgdp =3D (u64)init_pg_dir + PAGE_SIZE;
> +       phys_addr_t pgdp =3D (phys_addr_t)init_pg_dir + PAGE_SIZE;
>         pgprot_t text_prot =3D PAGE_KERNEL_ROX;
>         pgprot_t data_prot =3D PAGE_KERNEL;
>         pgprot_t prot;
> @@ -90,7 +90,7 @@ static void __init map_kernel(u64 kaslr_offset, u64 va_=
offset, int root_level)
>                     true, root_level);
>         dsb(ishst);
>
> -       idmap_cpu_replace_ttbr1(init_pg_dir);
> +       idmap_cpu_replace_ttbr1((phys_addr_t)init_pg_dir);
>
>         if (twopass) {
>                 if (IS_ENABLED(CONFIG_RELOCATABLE))
> @@ -129,10 +129,10 @@ static void __init map_kernel(u64 kaslr_offset, u64=
 va_offset, int root_level)
>         /* Copy the root page table to its final location */
>         memcpy((void *)swapper_pg_dir + va_offset, init_pg_dir, PAGE_SIZE=
);
>         dsb(ishst);
> -       idmap_cpu_replace_ttbr1(swapper_pg_dir);
> +       idmap_cpu_replace_ttbr1((phys_addr_t)swapper_pg_dir);
>  }
>
> -static void noinline __section(".idmap.text") set_ttbr0_for_lpa2(u64 ttb=
r)
> +static void noinline __section(".idmap.text") set_ttbr0_for_lpa2(phys_ad=
dr_t ttbr)
>  {
>         u64 sctlr =3D read_sysreg(sctlr_el1);
>         u64 tcr =3D read_sysreg(tcr_el1) | TCR_DS;
> @@ -172,7 +172,7 @@ static void __init remap_idmap_for_lpa2(void)
>          */
>         create_init_idmap(init_pg_dir, mask);
>         dsb(ishst);
> -       set_ttbr0_for_lpa2((u64)init_pg_dir);
> +       set_ttbr0_for_lpa2((phys_addr_t)init_pg_dir);
>
>         /*
>          * Recreate the initial ID map with the same granularity as befor=
e.
> @@ -185,17 +185,17 @@ static void __init remap_idmap_for_lpa2(void)
>         dsb(ishst);
>
>         /* switch back to the updated initial ID map */
> -       set_ttbr0_for_lpa2((u64)init_idmap_pg_dir);
> +       set_ttbr0_for_lpa2((phys_addr_t)init_idmap_pg_dir);
>
>         /* wipe the temporary ID map from memory */
>         memset(init_pg_dir, 0, (char *)init_pg_end - (char *)init_pg_dir)=
;
>  }
>
> -static void *__init map_fdt(u64 fdt)
> +static void *__init map_fdt(phys_addr_t fdt)
>  {
>         static u8 ptes[INIT_IDMAP_FDT_SIZE] __initdata __aligned(PAGE_SIZ=
E);
> -       u64 efdt =3D fdt + MAX_FDT_SIZE;
> -       u64 ptep =3D (u64)ptes;
> +       phys_addr_t efdt =3D fdt + MAX_FDT_SIZE;
> +       phys_addr_t ptep =3D (phys_addr_t)ptes; /* Stack is idmapped */

This comment is inaccurate: `ptes` is static. I've noted this to fix in V2.

>
>         /*
>          * Map up to MAX_FDT_SIZE bytes, but avoid overlap with
> @@ -232,7 +232,7 @@ static bool __init ng_mappings_allowed(void)
>         return true;
>  }
>
> -asmlinkage void __init early_map_kernel(u64 boot_status, void *fdt)
> +asmlinkage void __init early_map_kernel(u64 boot_status, phys_addr_t fdt=
)
>  {
>         static char const chosen_str[] __initconst =3D "/chosen";
>         u64 va_base, pa_base =3D (u64)&_text;
> @@ -240,7 +240,7 @@ asmlinkage void __init early_map_kernel(u64 boot_stat=
us, void *fdt)
>         int root_level =3D 4 - CONFIG_PGTABLE_LEVELS;
>         int va_bits =3D VA_BITS;
>         int chosen;
> -       void *fdt_mapped =3D map_fdt((u64)fdt);
> +       void *fdt_mapped =3D map_fdt(fdt);
>
>         /* Clear BSS and the initial page tables */
>         memset(__bss_start, 0, (char *)init_pg_end - (char *)__bss_start)=
;
> diff --git a/arch/arm64/kernel/pi/map_range.c b/arch/arm64/kernel/pi/map_=
range.c
> index 7982788e7b9a..de52cd85c691 100644
> --- a/arch/arm64/kernel/pi/map_range.c
> +++ b/arch/arm64/kernel/pi/map_range.c
> @@ -26,8 +26,9 @@
>   * @va_offset:         Offset between a physical page and its current ma=
pping
>   *                     in the VA space
>   */
> -void __init map_range(u64 *pte, u64 start, u64 end, u64 pa, pgprot_t pro=
t,
> -                     int level, pte_t *tbl, bool may_use_cont, u64 va_of=
fset)
> +void __init map_range(phys_addr_t *pte, u64 start, u64 end, phys_addr_t =
pa,
> +                     pgprot_t prot, int level, pte_t *tbl, bool may_use_=
cont,
> +                     u64 va_offset)
>  {
>         u64 cmask =3D (level =3D=3D 3) ? CONT_PTE_SIZE - 1 : U64_MAX;
>         ptdesc_t protval =3D pgprot_val(prot) & ~PTE_TYPE_MASK;
> @@ -87,19 +88,22 @@ void __init map_range(u64 *pte, u64 start, u64 end, u=
64 pa, pgprot_t prot,
>         }
>  }
>
> -asmlinkage u64 __init create_init_idmap(pgd_t *pg_dir, ptdesc_t clrmask)
> +asmlinkage phys_addr_t __init create_init_idmap(pgd_t *pg_dir, ptdesc_t =
clrmask)
>  {
> -       u64 ptep =3D (u64)pg_dir + PAGE_SIZE;
> +       phys_addr_t ptep =3D (phys_addr_t)pg_dir + PAGE_SIZE; /* MMU is o=
ff */
>         pgprot_t text_prot =3D PAGE_KERNEL_ROX;
>         pgprot_t data_prot =3D PAGE_KERNEL;
>
>         pgprot_val(text_prot) &=3D ~clrmask;
>         pgprot_val(data_prot) &=3D ~clrmask;
>
> -       map_range(&ptep, (u64)_stext, (u64)__initdata_begin, (u64)_stext,
> -                 text_prot, IDMAP_ROOT_LEVEL, (pte_t *)pg_dir, false, 0)=
;
> -       map_range(&ptep, (u64)__initdata_begin, (u64)_end, (u64)__initdat=
a_begin,
> -                 data_prot, IDMAP_ROOT_LEVEL, (pte_t *)pg_dir, false, 0)=
;
> +       /* MMU is off; pointer casts to phys_addr_t are safe */
> +       map_range(&ptep, (u64)_stext, (u64)__initdata_begin,
> +                 (phys_addr_t)_stext, text_prot, IDMAP_ROOT_LEVEL,
> +                 (pte_t *)pg_dir, false, 0);
> +       map_range(&ptep, (u64)__initdata_begin, (u64)_end,
> +                 (phys_addr_t)__initdata_begin, data_prot, IDMAP_ROOT_LE=
VEL,
> +                 (pte_t *)pg_dir, false, 0);
>
>         return ptep;
>  }
> diff --git a/arch/arm64/kernel/pi/pi.h b/arch/arm64/kernel/pi/pi.h
> index 46cafee7829f..08ef9f80456b 100644
> --- a/arch/arm64/kernel/pi/pi.h
> +++ b/arch/arm64/kernel/pi/pi.h
> @@ -29,9 +29,10 @@ u64 kaslr_early_init(void *fdt, int chosen);
>  void relocate_kernel(u64 offset);
>  int scs_patch(const u8 eh_frame[], int size);
>
> -void map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
> -              int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
> +void map_range(phys_addr_t *pte, u64 start, u64 end, phys_addr_t pa,
> +              pgprot_t prot, int level, pte_t *tbl, bool may_use_cont,
> +              u64 va_offset);
>
> -asmlinkage void early_map_kernel(u64 boot_status, void *fdt);
> +asmlinkage void early_map_kernel(u64 boot_status, phys_addr_t fdt);
>
> -asmlinkage u64 create_init_idmap(pgd_t *pgd, ptdesc_t clrmask);
> +asmlinkage phys_addr_t create_init_idmap(pgd_t *pgd, ptdesc_t clrmask);
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index ea84a61ed508..70c2ca813c18 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -243,7 +243,7 @@ void __init arm64_memblock_init(void)
>          */
>         if (memory_limit !=3D PHYS_ADDR_MAX) {
>                 memblock_mem_limit_remove_map(memory_limit);
> -               memblock_add(__pa_symbol(_text), (u64)(_end - _text));
> +               memblock_add(__pa_symbol(_text), (resource_size_t)(_end -=
 _text));
>         }
>
>         if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
> @@ -252,8 +252,8 @@ void __init arm64_memblock_init(void)
>                  * initrd to become inaccessible via the linear mapping.
>                  * Otherwise, this is a no-op
>                  */
> -               u64 base =3D phys_initrd_start & PAGE_MASK;
> -               u64 size =3D PAGE_ALIGN(phys_initrd_start + phys_initrd_s=
ize) - base;
> +               phys_addr_t base =3D phys_initrd_start & PAGE_MASK;
> +               resource_size_t size =3D PAGE_ALIGN(phys_initrd_start + p=
hys_initrd_size) - base;
>
>                 /*
>                  * We can only add back the initrd memory if we don't end=
 up
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 34e5d78af076..de463040582c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -794,17 +794,18 @@ static void __init declare_kernel_vmas(void)
>         declare_vma(&vmlinux_seg[4], _data, _end, 0);
>  }
>
> -void __pi_map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
> -                   int level, pte_t *tbl, bool may_use_cont, u64 va_offs=
et);
> +void __pi_map_range(phys_addr_t *pte, u64 start, u64 end, phys_addr_t pa=
,
> +                   pgprot_t prot, int level, pte_t *tbl, bool may_use_co=
nt,
> +                   u64 va_offset);
>
>  static u8 idmap_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) _=
_ro_after_init,
>           kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __r=
o_after_init;
>
>  static void __init create_idmap(void)
>  {
> -       u64 start =3D __pa_symbol(__idmap_text_start);
> -       u64 end   =3D __pa_symbol(__idmap_text_end);
> -       u64 ptep  =3D __pa_symbol(idmap_ptes);
> +       phys_addr_t start =3D __pa_symbol(__idmap_text_start);
> +       phys_addr_t end   =3D __pa_symbol(__idmap_text_end);
> +       phys_addr_t ptep  =3D __pa_symbol(idmap_ptes);
>
>         __pi_map_range(&ptep, start, end, start, PAGE_KERNEL_ROX,
>                        IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
> @@ -812,7 +813,7 @@ static void __init create_idmap(void)
>
>         if (IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0) && !arm64_use_ng_mappi=
ngs) {
>                 extern u32 __idmap_kpti_flag;
> -               u64 pa =3D __pa_symbol(&__idmap_kpti_flag);
> +               phys_addr_t pa =3D __pa_symbol(&__idmap_kpti_flag);
>
>                 /*
>                  * The KPTI G-to-nG conversion code needs a read-write ma=
pping
> @@ -1331,8 +1332,8 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsi=
gned long start, u64 size)
>  struct range arch_get_mappable_range(void)
>  {
>         struct range mhp_range;
> -       u64 start_linear_pa =3D __pa(_PAGE_OFFSET(vabits_actual));
> -       u64 end_linear_pa =3D __pa(PAGE_END - 1);
> +       phys_addr_t start_linear_pa =3D __pa(_PAGE_OFFSET(vabits_actual))=
;
> +       phys_addr_t end_linear_pa =3D __pa(PAGE_END - 1);
>
>         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>                 /*
> --
> 2.49.1
>

