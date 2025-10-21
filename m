Return-Path: <linux-kernel+bounces-863751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6042BF9037
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48FB04E81AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CAC296BA9;
	Tue, 21 Oct 2025 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/W+7Lqs"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709BB1D799D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761084735; cv=none; b=oI9OT2+vEVaWsYt+90kLBSA5AqIAfN/Lyo+e+/NUjbnjrbppKZ0Yrmm443Hhh03dV4truTcJ7INdSS9+spYdoGVDCByr7JbD2Jmyqvcl4xAt09l4hREenqT3xCUPjUPkcm7tXPjvYdUVgikEJqavJ8+2Yu1VswQ04YrBUUMQdjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761084735; c=relaxed/simple;
	bh=XRVho6x3CAXpDYPRoaypne+v5vxgk7Rk+Y/8muoiTwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXE6WUonooBDoAYIDUBRYc8RIm2Ny5tybKaKBvmCYE3tVVeakSox0casqgxnTHQD8EEal+smSw7CqowZzKxiTPxK2r49ApdiZtakPRDPkB9BvidFI4r4deqGio6EY4IaPHFcqJhP6PfLZW3kEQgv6G+aLEtW/D3jO3AjzQaQXy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h/W+7Lqs; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c44ea68f6so4086a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761084730; x=1761689530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7eLrXTSNrcJmCzKV8hcGeZgYUynnNUc8ztGtDOV+aI=;
        b=h/W+7Lqsp6SzCfXytpOMgPlepll/2rc1igi6LKjua9y/JP/X9ORMR73SoScwwi5NhU
         dXnAU5Vw0eVu/B7hMNFUN06Op8LstoqlrNpoCvXWok2HWaoDn78UIg0p61Qc3xUfXINH
         DKlrQwPV+A1XGShajV7e17QAJc1h5xLDjRsAX3EMAKWx25JLaMeCrb8mwovn3xw9gi5V
         JFmaPN8UNADH5+8YUYlDOpQ3n4NCjUDjFPUN6hTreKwxTLphbpUNvnQqnaNAyN7dippW
         2OFJfsoipm69W0n8mMDdG0YtFTkZ5Oe9MLAtDWGZCXKJh7HQS4EIYurzr6KA9xEeoECo
         foqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761084730; x=1761689530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7eLrXTSNrcJmCzKV8hcGeZgYUynnNUc8ztGtDOV+aI=;
        b=SVIavhfFkk2HZsUOv3RnIvhFOdwhzb5PpRE+Sz3rg8WfVF0YnssFM89uWylSDRu5Sf
         i6Ee05Msms/aIcfEvXJbcM5i01llIJCLQ0ZtDz4V3Ls1hnnjz6Gj9xzDSCWnNSM5PC5f
         9wXYXWMoDEQOayLs8Mm9CjYO/8w6Vqhabg68mXp/L1WXlJBXUC7ND1cMVZnPuIAySv1w
         fpKbfGo5EgIINJMZIQeIxSqY5Yf1OJ8xmyRIQeYi0hKvcinp7hIKsD734DgG+IyJtxhj
         tAgI3pQ310b2sxAiRP46pq8uI9DwILce5C2ASVkp1FG0pVnz5SJOR5nW9UyJ0H+LNhLC
         jlfg==
X-Forwarded-Encrypted: i=1; AJvYcCUcNqj7Vs9VGQt4jT8Wwcxhucp62m5PjmoA+tCGksh3MZWp81HxFqPzSMr20qNXOarphSrZB3Rtp3iPeWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YydTqR8s6tyat+KiIhh7/q9RIH8xqHT5zitVNFrOIeDgc9YXzji
	i/Z9YSSDQ16hFqOwAVv8i1FfJ4cs2/mtdGIP3V5B/ssUFTgdt/cuvihL/Q5+jSOaTyrs2OZaBL7
	622zacTqydPYoHw6gIFJfXdZqkbLiTLSXXb2R1weN
X-Gm-Gg: ASbGncufN/x5abNcHz02mgQyvisnQF8vCWioH52HfFbFgPCOEbFpixIFXvw1Vrs283q
	Ch0mcCk977HNGilKWg0Mx31JbSQSclT5MR6+7Go0rkRhbWHxsdTS7wc70/Hi8UfDlROK1Jfz5V4
	rQnP2OY14nC8bw9KrbcU91U44HP1jWHp3UxoZWl+OFAMZtOp4GlyvO573iI6BxRsF1MLRdbfC3v
	NwRgg3sKeKnhrlGMF9Gufz+h2XNi8QUZDCVdqmGkn55kTvwHY5T4eVJ92ve
X-Google-Smtp-Source: AGHT+IEDfmQOTJ5uUHv+b9t2BTyp4nF+vwssE+QpElDc/3BLDlaDr87JmIuKIzE91n4JGIZIVijGfX21oevNWu7t2CU=
X-Received: by 2002:a05:6402:1609:b0:634:b4b5:896f with SMTP id
 4fb4d7f45d1cf-63e19703191mr36229a12.4.1761084729562; Tue, 21 Oct 2025
 15:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917215031.2567566-1-jmattson@google.com> <20250917215031.2567566-3-jmattson@google.com>
 <o7m5gh76crbgzlfvq4lbp6ymuzbgze25qphlhsezl2ox5rfjuv@3xh7gqh5dmlt>
In-Reply-To: <o7m5gh76crbgzlfvq4lbp6ymuzbgze25qphlhsezl2ox5rfjuv@3xh7gqh5dmlt>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 21 Oct 2025 15:11:56 -0700
X-Gm-Features: AS18NWCZB-uPByh2zmyeyJUrBhWozotqzpuihhT1Sdzsic8Gvc4nBEp7Rj2-7nI
Message-ID: <CALMp9eRK7d1GF6Kqhji_KFz2+5jEs5JgbvyiCrqCiW_ZZiaoWQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] KVM: selftests: Use a loop to walk guest page tables
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Pratik R. Sampat" <prsampat@amd.com>, 
	Kai Huang <kai.huang@intel.com>, Eric Auger <eric.auger@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:21=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev=
> wrote:
>
> On Wed, Sep 17, 2025 at 02:48:38PM -0700, Jim Mattson wrote:
> > Walk the guest page tables via a loop when searching for a PTE,
> > instead of using unique variables for each level of the page tables.
> >
> > This simplifies the code and makes it easier to support 5-level paging
> > in the future.
> >
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  .../testing/selftests/kvm/lib/x86/processor.c | 21 +++++++------------
> >  1 file changed, 8 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/te=
sting/selftests/kvm/lib/x86/processor.c
> > index 0238e674709d..433365c8196d 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> > @@ -270,7 +270,8 @@ static bool vm_is_target_pte(uint64_t *pte, int *le=
vel, int current_level)
> >  uint64_t *__vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr,
> >                                   int *level)
> >  {
> > -     uint64_t *pml4e, *pdpe, *pde;
> > +     uint64_t *pte =3D &vm->pgd;
> > +     int current_level;
> >
> >       TEST_ASSERT(!vm->arch.is_pt_protected,
> >                   "Walking page tables of protected guests is impossibl=
e");
> > @@ -291,19 +292,13 @@ uint64_t *__vm_get_page_table_entry(struct kvm_vm=
 *vm, uint64_t vaddr,
> >       TEST_ASSERT(vaddr =3D=3D (((int64_t)vaddr << 16) >> 16),
> >               "Canonical check failed.  The virtual address is invalid.=
");
> >
> > -     pml4e =3D virt_get_pte(vm, &vm->pgd, vaddr, PG_LEVEL_512G);
> > -     if (vm_is_target_pte(pml4e, level, PG_LEVEL_512G))
> > -             return pml4e;
> > -
> > -     pdpe =3D virt_get_pte(vm, pml4e, vaddr, PG_LEVEL_1G);
> > -     if (vm_is_target_pte(pdpe, level, PG_LEVEL_1G))
> > -             return pdpe;
> > -
> > -     pde =3D virt_get_pte(vm, pdpe, vaddr, PG_LEVEL_2M);
> > -     if (vm_is_target_pte(pde, level, PG_LEVEL_2M))
> > -             return pde;
> > +     for (current_level =3D vm->pgtable_levels; current_level > 0; cur=
rent_level--) {
>
> This should be current_level >=3D PG_LEVEL_4K. It's the same, but easier
> to read.
>
> > +             pte =3D virt_get_pte(vm, pte, vaddr, current_level);
> > +             if (vm_is_target_pte(pte, level, current_level))
>
> Seems like vm_is_target_pte() is written with the assumption that it
> operates on an upper-level PTE, but I think it works on 4K PTEs as well.

I believe it does. Would you prefer that I exit the loop before
PG_LEVEL_4K and restore the virt_get_pte() below?

> > +                     return pte;
> > +     }
> >
> > -     return virt_get_pte(vm, pde, vaddr, PG_LEVEL_4K);
> > +     return pte;
> >  }
> >
> >  uint64_t *vm_get_page_table_entry(struct kvm_vm *vm, uint64_t vaddr)
> > --
> > 2.51.0.470.ga7dc726c21-goog
> >

