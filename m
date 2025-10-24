Return-Path: <linux-kernel+bounces-868262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 802E7C04BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD02219A00B1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2502E426B;
	Fri, 24 Oct 2025 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="dzvp6N8g"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D912E371D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291131; cv=none; b=lRffTEnLdBDGmS+8mH4WCPl+vrdSo879Y86gYKaBudhGFEoNuSmf6zYNjBcRMdf9IGm608TNIEJsYqcBTPw3PiFIU5riXmLmmj89++HZUyHtpoZxuSJuyieY/HKMFvvyHbh/DP7FHMW+kmsyC9hj7BrK3vTAgIAWB42OWvpFEIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291131; c=relaxed/simple;
	bh=dL3M7W63/HM9u/PVG56xwZ31tOE19K81D7nMJkjbwLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PI3oOym8xrtD5MxF3BuyVK6wLS2dBnCOAk6K4YiZbCrMy/+3ehKS3DhKiYJWJ930A1oGXuoeUnPPt6aDBavxJpVNQSHfmQo6EmWxIWY4FdAvuLgcczpucKW8Dp9cJYbV0ojYptu55rO1QE1flOdOMVJsEwGH8sNmo978lWlR5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=dzvp6N8g; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-94107531591so69800439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1761291129; x=1761895929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpBZbjtJGLMlozwkX0b76PHQF1zYhL0A3YtxCDGJbdU=;
        b=dzvp6N8glI5URtBMnlcEkFnoogatxaA2BzWNtPHtFJHHofdpOlbNVtzslnWydeNoj6
         0dM1uaDZu/SuZ6EFCkKl4jc51rw0XX8Cz+1t2U126igU01CVE4ZuAXNcBF4zmyeE95Uq
         7zFys/T9cmrxVurmp+LqhpQ+cygDu3wWvhiAABwb7+WtxWVcz2KLUPBn80YZ16E+vsra
         QfwZyw+6k3AAj7BHqA22fKOF4VATztH4o7T9YJxfLJ+ExZ4EGqGXXGfBjqitBNiZC+1S
         pm3zMBQMnVirLuYpQlkob+5MP1t4AyETAeJcF81O41ZX/bATsR9UDOP4D3D7uvALO9yT
         e6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291129; x=1761895929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpBZbjtJGLMlozwkX0b76PHQF1zYhL0A3YtxCDGJbdU=;
        b=i9d0ShzTHBSjAvjQliu6bmXApHX0VFnmnx8qhHQpdznaa1tr4O6z6Uv9LUpvMlLTiF
         otElUi3EBUwFijfmH3EuA4idJCGDffj7FGn3LZKAGYCbLlP/GW9r2g6muw6VXava+NCd
         NRLcleMYw2gjGRpzAuROzRO2Hnh3WW2NBor7Ygr5vuRzrCpjEx4aKXzU1GlAe/JvUxLI
         1A6mXriGjVvV6bpdrPPQnoOV5nrjndJhhmf9eroMb4gO1BgLKc2oCsbALD0R/p9fmkRX
         vx4Om6uP/EMdF0yO1xameRrx6kzDT4TGh7u0kZtufzGSc8WOvLFm/CS8AeP5qle2WfTZ
         /ycA==
X-Forwarded-Encrypted: i=1; AJvYcCVbZyrW89s82uoMGXAh7OBrnp2Xs2sg50mqEGTaplou7cwcBV7UGY1ZPzZUCsN9ZuPc1kTOnmJkPwYRrpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YM/ETQvDYgfTFu2PmYm7tDEX5S3K+OqzFleVShk5sFktKiI+
	mNqGCk9V1zr8AdQ4/QE6jEDWbhoKjPdEvZ5jymSTnPN/b87kUREzcGUP+PLftbCQForg2nGRHaU
	KEVZkIvsWW/S0oF3GFmg2yYbNDa/JfQU7+xrvI9J9iA==
X-Gm-Gg: ASbGncvGi+GMltco5PuhYZfiafH4z5pr2lt7EQKpnjwKKdDRJ63OQErvN8HNnA6vvjc
	wr1bw1Wl/1dkmyhMuE54PBpEjKhTsWFniQEKJlk4dK9OnLWko7V2s6eN1M21RnPZgVOwQYEDthE
	DJjkGkJVe7XYTrLRxwTNiuM0tc5pjTdz5AeBUfbbPvOZ5sN3h07xAv40eq5tERCZHsa0J2piThf
	FmL/8W5DBNgTI1Zu5XmLxkDr25AdrWaphqjukoJGKGM/Rkp3RMCfxiizdopZ0lIGoTsBVScQUtP
	sN4mYjN6hSUNVOMeFA==
X-Google-Smtp-Source: AGHT+IE8lJniclhto/l+RH48c18UKMSGetx2EifcCSozWch7G7Fgd/VVGLw9VfrEOhdG/fnB1nKrZd3e4LUYvBidL4I=
X-Received: by 2002:a05:6e02:156c:b0:430:ad98:981f with SMTP id
 e9e14a558f8ab-430c524b96bmr356886075ab.4.1761291128790; Fri, 24 Oct 2025
 00:32:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020130801.68356-1-fangyu.yu@linux.alibaba.com> <CAJF2gTRwHJsA7jFvAXbqy-6LyfaVTqfsFXgHfAeOZ8M3JNsikg@mail.gmail.com>
In-Reply-To: <CAJF2gTRwHJsA7jFvAXbqy-6LyfaVTqfsFXgHfAeOZ8M3JNsikg@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 24 Oct 2025 13:01:57 +0530
X-Gm-Features: AWmQ_blwhFmtWb2XCxa4JYOc1i2equWNv_ps6eVK8LyUUbV_-WLoCb0ZdIQIWZo
Message-ID: <CAAhSdy1j4HZ86V6VsSF80LuNoxB3L3fmYYtvT7LU93fhbgCuug@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Remove automatic I/O mapping for VM_PFNMAP
To: Guo Ren <guoren@kernel.org>
Cc: fangyu.yu@linux.alibaba.com, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, pbonzini@redhat.com, 
	jiangyifei@huawei.com, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@nvidia.com, 
	alex.williamson@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:58=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, Oct 20, 2025 at 6:08=E2=80=AFAM <fangyu.yu@linux.alibaba.com> wro=
te:
> >
> > From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> >
> > As of commit aac6db75a9fc ("vfio/pci: Use unmap_mapping_range()"),
> > vm_pgoff may no longer guaranteed to hold the PFN for VM_PFNMAP
> > regions. Using vma->vm_pgoff to derive the HPA here may therefore
> > produce incorrect mappings.
> >
> > Instead, I/O mappings for such regions can be established on-demand
> > during g-stage page faults, making the upfront ioremap in this path
> > is unnecessary.
> >
> > Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programm=
ing")
> The Fixes tag should be 'commit aac6db75a9fc ("vfio/pci: Use
> unmap_mapping_range()")'.
>
> A stable tree necessitates minimizing the "Fixes tag" interference.
>
> We also need to
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> For review.
>
> > Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> > ---
> >  arch/riscv/kvm/mmu.c | 20 +-------------------
> >  1 file changed, 1 insertion(+), 19 deletions(-)
> >
> > diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> > index 525fb5a330c0..84c04c8f0892 100644
> > --- a/arch/riscv/kvm/mmu.c
> > +++ b/arch/riscv/kvm/mmu.c
> > @@ -197,8 +197,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
> >
> >         /*
> >          * A memory region could potentially cover multiple VMAs, and
> > -        * any holes between them, so iterate over all of them to find
> > -        * out if we can map any of them right now.
> > +        * any holes between them, so iterate over all of them.
> >          *
> >          *     +--------------------------------------------+
> >          * +---------------+----------------+   +----------------+
> > @@ -229,32 +228,15 @@ int kvm_arch_prepare_memory_region(struct kvm *kv=
m,
> >                 vm_end =3D min(reg_end, vma->vm_end);
> >
> >                 if (vma->vm_flags & VM_PFNMAP) {
> > -                       gpa_t gpa =3D base_gpa + (vm_start - hva);
> > -                       phys_addr_t pa;
> > -
> > -                       pa =3D (phys_addr_t)vma->vm_pgoff << PAGE_SHIFT=
;
> > -                       pa +=3D vm_start - vma->vm_start;
> > -
> >                         /* IO region dirty page logging not allowed */
> >                         if (new->flags & KVM_MEM_LOG_DIRTY_PAGES) {
> >                                 ret =3D -EINVAL;
> >                                 goto out;
> >                         }
> > -
> > -                       ret =3D kvm_riscv_mmu_ioremap(kvm, gpa, pa, vm_=
end - vm_start,
> > -                                                   writable, false);
> > -                       if (ret)
> > -                               break;
> Defering the ioremap to the g-stage page fault looks good to me, as it
> simplifies the implementation here.
>
> Acked-by: Guo Ren <guoren@kernel.org>

I think you meant Reviewed-by and not Acked-by.

I have updated the Fixes tag at the time of merging.

Regards,
Anup

