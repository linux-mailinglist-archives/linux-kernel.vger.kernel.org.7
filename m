Return-Path: <linux-kernel+bounces-814598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C491B5563E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B243AEFC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302EB314A94;
	Fri, 12 Sep 2025 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ta+7Z07a"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189F18E25
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702048; cv=none; b=cyaRaLtIA4iqAJJYqsNO3gkvKFiK0D02X9L0JwFL2vA3wZZCrJGn4R3HTHoTB1THgK5ipMZLAPIPV9AboKFN71+1QtdteqpEmEDqfry6C+4dwawEDdX9/gq/BI8ZiAtLpDfqy/fn1GxfQKQ1/42CypnmLvOto13tC2N5jhKzbHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702048; c=relaxed/simple;
	bh=v5FVcC8hgZ/p+a0lbHORb4niU4q1wCJsNavaGkYebHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FVjJxDS5PiokVakmp2P8TI9NxhbRDh3kaOrloXuH1byH9uNodDxYvaoIgXXcChuwZKLIedgoYjzygpjwhdFfrR4QG+yw+1Bw7FloARcSsbPomWruXQc4D5X6Q21ShX4TFiMS3kXbGumjbKrBN8w7AGx/xAwhmi3b3rH+iKdiBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ta+7Z07a; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323766e64d5so2831948a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757702046; x=1758306846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlhPWLmUue00CiOxFvUNznMlr4ctvmMFViLBjGFh5aE=;
        b=Ta+7Z07aX/XmKlaS6kgQniPSXSSse7gK2/vyNkgTaWHah41wCHrEypIOaGH3StoYQR
         4+Dv8bw+Vdbo70b0smLqk7DIxK2b0KDi95R4TIEC1cthWlKz61nW2fj0vvbcbvAauDby
         vR8v2nj3YcNejqWmbIsu07JLa+WUtNiQIRsLo23bBAC5BUQSHfweiUFg8vHLwdo9x4sZ
         weMWSl07D1p72GoDxRi626LBielC8B52iLRp0yNemMIkOzl6/ZeOvjKhDOEH/hNkwmDf
         bJimQQst9X6jarSlcgRrDoTMwPllvsSoa21HH/6Nh3hkT4qBQAuIJI2HQsrvLCa2YGWU
         dlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757702046; x=1758306846;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tlhPWLmUue00CiOxFvUNznMlr4ctvmMFViLBjGFh5aE=;
        b=Uofwy1ztegqZEIZigDOGwDuQxiVgXl5AOVZTXZpAQz8vchxlgYj//tup4yVgB2eseQ
         Ho/dDb16OAuy+O2la3pavBSbwGjDXNn9yOrnfu7Vs89B4rSM7SaER49u50L8yrLRNXNU
         unPOi8LkuzrEf6s7UXyMAbdGA1Uhr7/GddZwmuXfAxvBVsM1d9CM8pmZFU8hmd6A6R2H
         AqUiW+2QDRvfS+gE1n0PRCya/SUMbb2mamfXHWAucAMVFAGTi/z23YX/LCwHYpndxNEt
         gJUOhiiiABqPrEX4uSIGH4uX+Qc55xvQ4KE1mDrcVrLo9xz7MDamQ8pMTKfJhkbZWxtW
         z5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUo3Pq7Iu2e7nfDhqgM5uPLACKmUZr4uK3L3SE4S7PLSfuYOuEsPE53ae+9gzLwV/A+0Uvlr7O/gWiEkUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5VVytyhHlapH2uz8GQzLWSqEyeL+CYJOHWeFDVb/L/2pOPVPO
	+aUoEOLk+yf1i7IGa9jSbLZJZ5YHvknDWc8gHFXRpJUsUi1D/QNkHNgFgyzsxa7jJs2l7YUS+Tg
	ufl5hcw==
X-Google-Smtp-Source: AGHT+IFkjA4Yytqm3FFtm5CKt77K8SX2eP0ZGGmXPW8IcXnFSSTQ7TlT5fqN5rSSfLmzpZPc20T/4sMe+jo=
X-Received: from pjbsu16.prod.google.com ([2002:a17:90b:5350:b0:32d:f25c:6a58])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3851:b0:329:8520:cee7
 with SMTP id 98e67ed59e1d1-32de4c44ae9mr4236965a91.14.1757702046207; Fri, 12
 Sep 2025 11:34:06 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:34:04 -0700
In-Reply-To: <c6d2fbe31bd9e2638eaefaabe6d0ffc55f5886bd.1757543774.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1757543774.git.ashish.kalra@amd.com> <c6d2fbe31bd9e2638eaefaabe6d0ffc55f5886bd.1757543774.git.ashish.kalra@amd.com>
Message-ID: <aMRnnNVYBrasJnZF@google.com>
Subject: Re: [PATCH v4 1/3] x86/sev: Add new dump_rmp parameter to
 snp_leak_pages() API
From: Sean Christopherson <seanjc@google.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	pbonzini@redhat.com, thomas.lendacky@amd.com, herbert@gondor.apana.org.au, 
	nikunj@amd.com, davem@davemloft.net, aik@amd.com, ardb@kernel.org, 
	john.allen@amd.com, michael.roth@amd.com, Neeraj.Upadhyay@amd.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025, Ashish Kalra wrote:
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 00475b814ac4..7a1ae990b15f 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -635,10 +635,15 @@ void snp_dump_hva_rmpentry(unsigned long address);
>  int psmash(u64 pfn);
>  int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bo=
ol immutable);
>  int rmp_make_shared(u64 pfn, enum pg_level level);
> -void snp_leak_pages(u64 pfn, unsigned int npages);
> +void __snp_leak_pages(u64 pfn, unsigned int npages, bool dump_rmp);
>  void kdump_sev_callback(void);
>  void snp_fixup_e820_tables(void);
> =20
> +static inline void snp_leak_pages(u64 pfn, unsigned int pages)
> +{
> +	__snp_leak_pages(pfn, pages, true);
> +}
> +
>  static inline void sev_evict_cache(void *va, int npages)
>  {
>  	volatile u8 val __always_unused;
> @@ -668,6 +673,7 @@ static inline int rmp_make_private(u64 pfn, u64 gpa, =
enum pg_level level, u32 as
>  	return -ENODEV;
>  }
>  static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return=
 -ENODEV; }
> +static inline void __snp_leak_pages(u64 pfn, unsigned int npages, bool d=
ump_rmp) {}

This stub is unnecessary.  As pointed out elsewhere[*], I'm pretty sure all=
 these
stubs are unnecessary.

Oof.  Even worse, the stubs appear to be actively hiding bugs.  The APIs ar=
e
guarded with CONFIG_KVM_AMD_SEV=3Dy, but **KVM** doesn't call any of these =
outside
of SEV code.  I.e. if *KVM* were the only user, the stubs would just be dea=
d code.

But the below build failures show that they aren't dead code, which means t=
hat
kernels with CONFIG_KVM_AMD_SEV=3Dn will silently (until something explodes=
) do the
wrong thing, because the stubs are hiding the missing dependencies.

arch/x86/boot/startup/sev-shared.c: In function =E2=80=98pvalidate_4k_page=
=E2=80=99:
arch/x86/boot/startup/sev-shared.c:820:17: error: implicit declaration of f=
unction =E2=80=98sev_evict_cache=E2=80=99 [-Wimplicit-function-declaration]
  820 |                 sev_evict_cache((void *)vaddr, 1);
      |                 ^~~~~~~~~~~~~~~
  AR      arch/x86/realmode/built-in.a
arch/x86/coco/sev/core.c: In function =E2=80=98pvalidate_pages=E2=80=99:
arch/x86/coco/sev/core.c:386:25: error: implicit declaration of function =
=E2=80=98sev_evict_cache=E2=80=99 [-Wimplicit-function-declaration]
  386 |                         sev_evict_cache(pfn_to_kaddr(e->gfn), e->pa=
gesize ? 512 : 1);
      |                         ^~~~~~~~~~~~~~~
arch/x86/mm/mem_encrypt.c: In function =E2=80=98mem_encrypt_setup_arch=E2=
=80=99:
arch/x86/mm/mem_encrypt.c:112:17: error: implicit declaration of function =
=E2=80=98snp_fixup_e820_tables=E2=80=99 [-Wimplicit-function-declaration]
  112 |                 snp_fixup_e820_tables();
      |                 ^~~~~~~~~~~~~~~~~~~~~
arch/x86/mm/fault.c: In function =E2=80=98show_fault_oops=E2=80=99:
arch/x86/mm/fault.c:587:17: error: implicit declaration of function =E2=80=
=98snp_dump_hva_rmpentry=E2=80=99 [-Wimplicit-function-declaration]
  587 |                 snp_dump_hva_rmpentry(address);
      |                 ^~~~~~~~~~~~~~~~~~~~~
arch/x86/kernel/cpu/amd.c: In function =E2=80=98bsp_determine_snp=E2=80=99:
arch/x86/kernel/cpu/amd.c:370:21: error: implicit declaration of function =
=E2=80=98snp_probe_rmptable_info=E2=80=99 [-Wimplicit-function-declaration]
  370 |                     snp_probe_rmptable_info()) {
      |                     ^~~~~~~~~~~~~~~~~~~~~~~
  AR      drivers/iommu/amd/built-in.a
  AR      drivers/iommu/built-in.a
  AR      drivers/built-in.a

[*] https://lore.kernel.org/all/aMHP5EO-ucJGdHXz@google.com

