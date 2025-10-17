Return-Path: <linux-kernel+bounces-857774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE82ABE7E83
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF982620BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37562E22AB;
	Fri, 17 Oct 2025 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSMy7Vz9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A54B2DE700
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694844; cv=none; b=dK458e6koeQq3KGm+jwtOC0U2NTwp8fJwPtwUghJCV38DwkNef25tuEdL4DCwE44dCXwVVIJ95fgZH6UODhgER95RylUOqJWRPo64iGRq3H6n6w6hNfAB9K2XFz9Xtxx4ECddI7O08pFhmwtAlWoZmH4l6YxVySA6/HQJYLBh18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694844; c=relaxed/simple;
	bh=W5+0QfU+et/jmk6dv8dDZbEtFHejPJe/S2iTwGTeBuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaQeJogZvdXGBPxdRYkkqeqJ2tusOHCNucYNvn1tswzhb08FkIhJx2tl/khmWflHjnpIGnfIRQvXWeMS0XgABDeTpmSGo9qkgWNgczSD1QFQ2Vc4hbsbMRj5nOD2RLcfHTSgJX1heqF2hQ5LA6L0oETNQI/nUIX2vbq/dSHsaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSMy7Vz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D212EC116D0
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760694843;
	bh=W5+0QfU+et/jmk6dv8dDZbEtFHejPJe/S2iTwGTeBuw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nSMy7Vz9toIAs6m24dLgVSpDo12zo2Zpgid0GXKR7ZdYtK22fXqDZfdhgGsor3ZEm
	 QVBEzZtDhO50EaS90m0jYcYdw9GWFQj6Oi2A4f5jW++rDo7LZP+5bZf5gg8t1dzZB8
	 8YIpSYe2m4XaAWBGKiASQZVNdgGpc49rKszRJToKhtlOU3jdPH25ibogZRL/4qpAuG
	 RnzP98PAvtHj96CXvVa9Zq8SA3g8Tpk2Der86RkcHmf83Fjz+LuyGmp1vjfTZvcdod
	 VDyNHRJNcJVB1z29c7wRSWN88t349ScCTnKbOf7jYa7NcXHnpYrPmnEWXMxLnu3S9Z
	 eHBGQx9jbZZ5Q==
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-426ed6f4db5so1651305f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:54:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTZTU9/+S3zrirJ+1nUXL5811LdkC5QobF2PB28WzzUVZnfxF9ghndY7JsIwv1drVmx5BWr5ZJ3DFCxcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjJU8cCNI1JGdlpWqyy2dVhF/9Lm+OcasBOq4TbwpTgdixPtmK
	vYiORnnnks3M+SCa2ObShXRA7m09JQxQITNpRfMJSL1a4rRbjiCGOU/3bEUVpsQ+0YOseu5qvZn
	wTyy1ya8fc3DFg3CaQB7KbuyxficOKfc=
X-Google-Smtp-Source: AGHT+IHWrBERRiDikiFyahVcvqfNC9E1jn/3Y03EAsRAoR98IYfMEnrhuQ7z+aUULromw32VTBS2YkPTqxGKuCZ57Tw=
X-Received: by 2002:a05:6000:310c:b0:426:d51c:494a with SMTP id
 ffacd0b85a97d-426fb9ac11fmr4831717f8f.24.1760694842381; Fri, 17 Oct 2025
 02:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016012659.82998-1-fangyu.yu@linux.alibaba.com> <CAAhSdy2UcmoPLF0CGBrsF1bRdJe-X05YA7UQOVffxBjZTourMA@mail.gmail.com>
In-Reply-To: <CAAhSdy2UcmoPLF0CGBrsF1bRdJe-X05YA7UQOVffxBjZTourMA@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 17 Oct 2025 17:53:50 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS6FKdXhG3d944B+k8YLRw4JKLEnUtgeC2hDLUjLkhjbg@mail.gmail.com>
X-Gm-Features: AS18NWCPe1Ej6e6BmrPjRcgTihokl613hBi-ZkMtdBKcGiBrCmQW5r-Nein1AIA
Message-ID: <CAJF2gTS6FKdXhG3d944B+k8YLRw4JKLEnUtgeC2hDLUjLkhjbg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: Read HGEIP CSR on the correct cpu
To: Anup Patel <anup@brainfault.org>
Cc: fangyu.yu@linux.alibaba.com, atish.patra@linux.dev, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	liujingqi@lanxincomputing.com, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 2:59=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Thu, Oct 16, 2025 at 6:57=E2=80=AFAM <fangyu.yu@linux.alibaba.com> wro=
te:
> >
> > From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> >
> > When executing kvm_riscv_vcpu_aia_has_interrupts, the vCPU may have
> > migrated and the IMSIC VS-file have not been updated yet, currently
> > the HGEIP CSR should be read from the imsic->vsfile_cpu ( the pCPU
> > before migration ) via on_each_cpu_mask, but this will trigger an
> > IPI call and repeated IPI within a period of time is expensive in
> > a many-core systems.
> >
> > Just let the vCPU execute and update the correct IMSIC VS-file via
> > kvm_riscv_vcpu_aia_imsic_update may be a simple solution.
> >
> > Fixes: 4cec89db80ba ("RISC-V: KVM: Move HGEI[E|P] CSR access to IMSIC v=
irtualization")
> > Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> > ---
> >  arch/riscv/kvm/aia_imsic.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> > index fda0346f0ea1..168c02ad0a78 100644
> > --- a/arch/riscv/kvm/aia_imsic.c
> > +++ b/arch/riscv/kvm/aia_imsic.c
> > @@ -689,8 +689,12 @@ bool kvm_riscv_vcpu_aia_imsic_has_interrupt(struct=
 kvm_vcpu *vcpu)
> >          */
> >
> >         read_lock_irqsave(&imsic->vsfile_lock, flags);
> > -       if (imsic->vsfile_cpu > -1)
> > -               ret =3D !!(csr_read(CSR_HGEIP) & BIT(imsic->vsfile_hgei=
));
> > +       if (imsic->vsfile_cpu > -1) {
> > +               if (imsic->vsfile_cpu !=3D smp_processor_id())
>
> Good catch !!!
>
> I agree with Guo Ren. We should use "vcpu->cpu" over here
> instead of smp_processor_id(). Also, I think we should add
> some comments for future reference. I will take care of this
> at the time of merging this patch.
>
> Queued this as fixes for Linux-6.18
Thx Anup, then Fangyu needn't update v2.

This patch also reveals the idea of our CSR_HGEIP design - Per-CPU access.
Although arm64 & x86 don't have a similar problem by using a shared
memory address map, it would be a complex hw design. The RISC-V
CSR_HGEIP design is much simpler for hw, and vCPU migration on the
pCPUs could tolerate one additional VM_enter/exit cost for an idle
vcpu.

>
> Thanks,
> Anup
>
> > +                       ret =3D true;
> > +               else
> > +                       ret =3D !!(csr_read(CSR_HGEIP) & BIT(imsic->vsf=
ile_hgei));
> > +       }
> >         read_unlock_irqrestore(&imsic->vsfile_lock, flags);
> >
> >         return ret;
> > --
> > 2.50.1
> >



--=20
Best Regards
 Guo Ren

