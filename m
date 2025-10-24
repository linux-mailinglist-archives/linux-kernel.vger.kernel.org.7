Return-Path: <linux-kernel+bounces-868560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEEAC05789
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C73EB3596EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D68730E0D9;
	Fri, 24 Oct 2025 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkDYfGaP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E814E30AAC2
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300219; cv=none; b=HuYKyyxcV7Y3am4gETIIvORzA48YliITQSc/sagtzQ2uH8UJKaDx5oeR7Q94zHsHigcO8B9mjA+g/CS9BjRPXi3cy+Lxt2dullhIUeY+JlZNm4PeNAsZp5xX5E2aD+XyatyEjGF50dyhvlj+QvXRinTtAQR3re/b14VSoczIhx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300219; c=relaxed/simple;
	bh=OvBlFaevsT1aA4REwFPwyDUpfGwB/p8ycFjHvvBC4PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFMXzgPuUcIzd7omSEQD8URENMz4v2fG+5pt+S5F3nS7LLdJ80whpZFVDlCAVjep6Vjiuq9RtrqFtkIviNgy3I1tl8xmS0YCd7lf7orYMewf1+NsmcwOCs2s9seWKTq/yPVuXh/pRRkBHISlFmD7uL/+1NEGn+yRJXTiCS3Hv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkDYfGaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60875C116B1
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761300218;
	bh=OvBlFaevsT1aA4REwFPwyDUpfGwB/p8ycFjHvvBC4PM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UkDYfGaPl3QeT3lzukEEpYg3j7WqD67FkrFiw0qXNJ1OngbZ0ue7Z+oth7PF4a19e
	 6c4wW6rYWMOO3kGSqHqjs0gf2mZW3mpXB+go1zxx94lOAEG4QTcPJfgMqvwsgPaIdK
	 BGuApr7nzn9bW0K8lCpMUfc/MJQgyd8waGbSQlnbRLbpClBx+pBGPF2EJATb4y4zo2
	 5jJ3gXFhhuOnedfLTooQbJGt/cSwqO6xnxDjcnwBlBLjjt8yGJJNIvTqzknmd/Bi1h
	 5GPkIuPtWR7tRkNzHlBzI01FFlc8TU3KeX1lEFwfumePMr6CCvr55zSZdhFui7G3QY
	 Xpx0E3GuJ4KJA==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4270a3464caso826434f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:03:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaZIYJlXYyxB5aKE6OSTAnDsvmq4teKwHfziqWq/hINCmfG3ziNmkN7j6oQ8UqGGsKJaAQPEzQsvvzFqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpmsO/Rtbb0PVqAi1CYeMQAzZryMf8j/6eN5speRDCSX459ntO
	jiN5ORMnRv7ZjoOEgYI8wgt1Rja1+/Gk3ZVGZalV3kFh7IHD66XDLtZ/w4ZwDLZ9MiVrIf2mS+W
	oIcSSqT7uwbN9Hu4P3QW8BtwAPGfGVdc=
X-Google-Smtp-Source: AGHT+IHLVMglfM02a482Z0S013OS339/r6JWMeLQ6qF2S7OgbygGhNbTGwvWCNz8euYcwQmbbn1WPiA92/Bwgk0PmhM=
X-Received: by 2002:a5d:5f93:0:b0:427:4b0:b3f9 with SMTP id
 ffacd0b85a97d-4298a04071bmr4218935f8f.3.1761300216861; Fri, 24 Oct 2025
 03:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020130801.68356-1-fangyu.yu@linux.alibaba.com>
 <CAJF2gTRwHJsA7jFvAXbqy-6LyfaVTqfsFXgHfAeOZ8M3JNsikg@mail.gmail.com> <CAAhSdy1j4HZ86V6VsSF80LuNoxB3L3fmYYtvT7LU93fhbgCuug@mail.gmail.com>
In-Reply-To: <CAAhSdy1j4HZ86V6VsSF80LuNoxB3L3fmYYtvT7LU93fhbgCuug@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 24 Oct 2025 03:03:23 -0700
X-Gmail-Original-Message-ID: <CAJF2gTS-qZDgxsqxr7OjZijwxc4GY2MKCabMbE3wvtzx0TDixQ@mail.gmail.com>
X-Gm-Features: AWmQ_blhM55OVCZL-ZLmRVyNahAkanXv0XqjK7NIOuPTDZ21CIGaNvU6roof5hI
Message-ID: <CAJF2gTS-qZDgxsqxr7OjZijwxc4GY2MKCabMbE3wvtzx0TDixQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Remove automatic I/O mapping for VM_PFNMAP
To: Anup Patel <anup@brainfault.org>
Cc: fangyu.yu@linux.alibaba.com, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, pbonzini@redhat.com, 
	jiangyifei@huawei.com, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@nvidia.com, 
	alex.williamson@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 12:32=E2=80=AFAM Anup Patel <anup@brainfault.org> w=
rote:
>
> On Tue, Oct 21, 2025 at 8:58=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Mon, Oct 20, 2025 at 6:08=E2=80=AFAM <fangyu.yu@linux.alibaba.com> w=
rote:
> > >
> > > From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> > >
> > > As of commit aac6db75a9fc ("vfio/pci: Use unmap_mapping_range()"),
> > > vm_pgoff may no longer guaranteed to hold the PFN for VM_PFNMAP
> > > regions. Using vma->vm_pgoff to derive the HPA here may therefore
> > > produce incorrect mappings.
> > >
> > > Instead, I/O mappings for such regions can be established on-demand
> > > during g-stage page faults, making the upfront ioremap in this path
> > > is unnecessary.
> > >
> > > Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table progra=
mming")
> > The Fixes tag should be 'commit aac6db75a9fc ("vfio/pci: Use
> > unmap_mapping_range()")'.
> >
> > A stable tree necessitates minimizing the "Fixes tag" interference.
> >
> > We also need to
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > For review.
> >
> > > Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> > > ---
> > >  arch/riscv/kvm/mmu.c | 20 +-------------------
> > >  1 file changed, 1 insertion(+), 19 deletions(-)
> > >
> > > diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> > > index 525fb5a330c0..84c04c8f0892 100644
> > > --- a/arch/riscv/kvm/mmu.c
> > > +++ b/arch/riscv/kvm/mmu.c
> > > @@ -197,8 +197,7 @@ int kvm_arch_prepare_memory_region(struct kvm *kv=
m,
> > >
> > >         /*
> > >          * A memory region could potentially cover multiple VMAs, and
> > > -        * any holes between them, so iterate over all of them to fin=
d
> > > -        * out if we can map any of them right now.
> > > +        * any holes between them, so iterate over all of them.
> > >          *
> > >          *     +--------------------------------------------+
> > >          * +---------------+----------------+   +----------------+
> > > @@ -229,32 +228,15 @@ int kvm_arch_prepare_memory_region(struct kvm *=
kvm,
> > >                 vm_end =3D min(reg_end, vma->vm_end);
> > >
> > >                 if (vma->vm_flags & VM_PFNMAP) {
> > > -                       gpa_t gpa =3D base_gpa + (vm_start - hva);
> > > -                       phys_addr_t pa;
> > > -
> > > -                       pa =3D (phys_addr_t)vma->vm_pgoff << PAGE_SHI=
FT;
> > > -                       pa +=3D vm_start - vma->vm_start;
> > > -
> > >                         /* IO region dirty page logging not allowed *=
/
> > >                         if (new->flags & KVM_MEM_LOG_DIRTY_PAGES) {
> > >                                 ret =3D -EINVAL;
> > >                                 goto out;
> > >                         }
> > > -
> > > -                       ret =3D kvm_riscv_mmu_ioremap(kvm, gpa, pa, v=
m_end - vm_start,
> > > -                                                   writable, false);
> > > -                       if (ret)
> > > -                               break;
> > Defering the ioremap to the g-stage page fault looks good to me, as it
> > simplifies the implementation here.
> >
> > Acked-by: Guo Ren <guoren@kernel.org>
>
> I think you meant Reviewed-by and not Acked-by.
Yes,

Reviewed-by: Guo Ren <guoren@kernel.org>

>
> I have updated the Fixes tag at the time of merging.
Okay.

>
> Regards,
> Anup



--=20
Best Regards
 Guo Ren

