Return-Path: <linux-kernel+bounces-885647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3197EC33966
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 879D3342B0C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08E023ABB9;
	Wed,  5 Nov 2025 01:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQ7bTwEk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D098184540
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304879; cv=none; b=o73mb2gdXHFX0MLurSkRh4MRuqTOlGLTesT+Kk2MwDbswPI2n4CwfcDjcynXk1RoCUbz8TWf3Zl/O28bK8e7HdmQx7DBFyRfZQgtr0JhC30yVHE6FyeeEWTXas+Aj+Fljq0zdunWer4nm/y9Tjf+wudzDq/4DlAJDVcr+iQZD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304879; c=relaxed/simple;
	bh=ilr2K9gJuHu546RJYoC8JkD3WBGGz5MW/TcnmPpAqHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhGEbC8dPlmOtzuvQgAQIYc/rx1qloSz6O3TH9zdEOpEjk5z2z9aA9HkYCNdZ3f0TPilo9Jc/f0dvGW+gICZMg1t5alktFxt3JFH5inv/K+FgMJY1xZDujDF6O6vAHxCMDcuBwniOut7Vl5huqFn9aVPU9i2jjiK8tT8jC8s2Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQ7bTwEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4107C2BC87
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762304878;
	bh=ilr2K9gJuHu546RJYoC8JkD3WBGGz5MW/TcnmPpAqHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uQ7bTwEkSxG3O+wpJVz2wgHSxrMjLHmcv9i/4Jas0auXxg4LOJMqFoAfRP7hOM3EP
	 lhKkXwaHhMBx5y3t1qHu6szpp7B7VDzn1ZT+TLGpnt66P/+Hq+j87KHaiauPaTXA/5
	 rCfZWzkV1Cc8PFgQynR1+REz6FDN9qbq3yG9wck3NEdJDJTPunZUEc1j0nDXtVCMQ0
	 8ZV1m6nPz0XZ1chkdiCobZrhmEeSdr6l9hXgn2ra/2BBLqHjmxvA6ZFfK5o/0ArAeN
	 2vmAXAVa7ELOCUzvgGd1DQP/MdG84Q15bzLUzKG7NIGpp3TqEuSJe4AUubECu6je7Y
	 iUjUgpjqQvMsA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso10330521a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:07:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLSjRP8eybS+34rFrGqjEY8IqFj747vEZ61HHldRlhHuZmnElaFCW+zGr7WPnODz/n+q8VG3VRSfbMMYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYOgNszItR3YZeECSFrw/GAMLPRo25PBysJ5D70nPHzbjGX4B
	kt033xoma+PnFJ2PJFpJ6n2CSFwp/wqxH9kxisXmOjl0MihgFR1Cje2hdCzKYOywp6nNUzqzMPe
	OVcCZ4laGMsFl5s0TIamUEoTObvBOXS4=
X-Google-Smtp-Source: AGHT+IFFm6EM5n08GOxTfEKlsUKIK572RyRhNYKmqXy1KMmkIGLteY1MmUaGQfeyEbd2XXI7rhCbSjzCsvpH3olAxkw=
X-Received: by 2002:a17:906:c10c:b0:aff:fe6:78f0 with SMTP id
 a640c23a62f3a-b726553bd09mr126618366b.54.1762304877244; Tue, 04 Nov 2025
 17:07:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104073006.1764241-1-zhangtianyang@loongson.cn>
 <CAAhV-H5JnmJqTZ1GnhcgODtjL5FLy8x5HNRJxs6us=gzcFon5Q@mail.gmail.com> <95e6f0a6-fd6c-a85f-5983-5a37eaf960a2@loongson.cn>
In-Reply-To: <95e6f0a6-fd6c-a85f-5983-5a37eaf960a2@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 5 Nov 2025 09:07:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4WrphWQqW7HoeD7xSvRuHV1KBt7jgESQU7N-y1HrSVVw@mail.gmail.com>
X-Gm-Features: AWmQ_bmfgS4IrtLUxWGxshr7TnFNp6zw14tLIui5uCmLNt_hfBIr6fEunSdbzaw
Message-ID: <CAAhV-H4WrphWQqW7HoeD7xSvRuHV1KBt7jgESQU7N-y1HrSVVw@mail.gmail.com>
Subject: Re: [PATCH] Loongarch:Make pte/pmd_modify can set _PAGE_MODIFIED
To: Tianyang Zhang <zhangtianyang@loongson.cn>
Cc: kernel@xen0n.name, akpm@linux-foundation.org, willy@infradead.org, 
	david@redhat.com, linmag7@gmail.com, thuth@redhat.com, maobibo@loongson.cn, 
	apopple@nvidia.com, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Liupu Wang <wangliupu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:57=E2=80=AFAM Tianyang Zhang <zhangtianyang@loongs=
on.cn> wrote:
>
> Hi, Huacai
>
> =E5=9C=A8 2025/11/4 =E4=B8=8B=E5=8D=884:00, Huacai Chen =E5=86=99=E9=81=
=93:
> > Hi, Tianyang,
> >
> > The subject line can be:
> > LoongArch: Let {pte,pmd}_modify() record the status of _PAGE_DIRTY (If
> > I'm right in the later comments).
> Ok. I got it
> >
> > On Tue, Nov 4, 2025 at 3:30=E2=80=AFPM Tianyang Zhang <zhangtianyang@lo=
ongson.cn> wrote:
> >> In the current pte_modify operation, _PAGE_DIRTY might be cleared. Sin=
ce
> >> the hardware-page-walk does not have a predefined _PAGE_MODIFIED flag,
> >> this could lead to loss of valid data in certain scenarios.
> >>
> >> The new modification involves checking whether the original PTE has th=
e
> >> _PAGE_DIRTY flag. If it exists, the _PAGE_MODIFIED bit is set, ensurin=
g
> >> that the pte_dirty interface can return accurate information.
> > The description may be wrong here. Because pte_dirty() returns
> > pte_val(pte) & (_PAGE_DIRTY | _PAGE_MODIFIED).
> > If _PAGE_DIRTY isn't lost, pte_dirty() is always right, no matter
> > whether there is or isn't _PAGE_MODIFIED.
> >
> > I think the real reason is we need to set _PAGE_MODIFIED in
> > pte/pmd_modify to record the status of _PAGE_DIRTY, so that we can
> > recover _PAGE_DIRTY afterwards, such as in pte/pmd_mkwrite().
> Ok, I will adjust the description
After some thinking, your original description may be right. Without
this patch the scenario maybe like this:
The pte is dirty _PAGE_DIRTY but without _PAGE_MODIFIED, after
pte_modify() we lose _PAGE_DIRTY, then pte_dirty() returns false. So
we need _PAGE_MODIFIED to record _PAGE_DIRTY here.

But the description also needs to be updated.

> >
> >> Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
> >> Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
> >> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
> >> ---
> >>   arch/loongarch/include/asm/pgtable.h | 17 +++++++++++++----
> >>   1 file changed, 13 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/inc=
lude/asm/pgtable.h
> >> index bd128696e96d..106abfa5183b 100644
> >> --- a/arch/loongarch/include/asm/pgtable.h
> >> +++ b/arch/loongarch/include/asm/pgtable.h
> >> @@ -424,8 +424,13 @@ static inline unsigned long pte_accessible(struct=
 mm_struct *mm, pte_t a)
> >>
> >>   static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> >>   {
> >> -       return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
> >> -                    (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
> >> +       unsigned long val =3D (pte_val(pte) & _PAGE_CHG_MASK) |
> >> +                    (pgprot_val(newprot) & ~_PAGE_CHG_MASK);
> >> +
> >> +       if (pte_val(pte) & _PAGE_DIRTY)
> >> +               val |=3D _PAGE_MODIFIED;
> >> +
> >> +       return __pte(val);
> >>   }
> >>
> >>   extern void __update_tlb(struct vm_area_struct *vma,
> >> @@ -547,9 +552,13 @@ static inline struct page *pmd_page(pmd_t pmd)
> >>
> >>   static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
> >>   {
> >> -       pmd_val(pmd) =3D (pmd_val(pmd) & _HPAGE_CHG_MASK) |
> >> +       unsigned long val =3D (pmd_val(pmd) & _HPAGE_CHG_MASK) |
> >>                                  (pgprot_val(newprot) & ~_HPAGE_CHG_MA=
SK);
> >> -       return pmd;
> >> +
> >> +       if (pmd_val(pmd) & _PAGE_DIRTY)
> >> +               val |=3D _PAGE_MODIFIED;
> >> +
> >> +       return __pmd(val);
> >>   }
> > A minimal modification can be:
> > diff --git a/arch/loongarch/include/asm/pgtable.h
> > b/arch/loongarch/include/asm/pgtable.h
> > index 1f20e9280062..907ece0199e0 100644
> > --- a/arch/loongarch/include/asm/pgtable.h
> > +++ b/arch/loongarch/include/asm/pgtable.h
> > @@ -448,8 +448,13 @@ static inline unsigned long pte_accessible(struct
> > mm_struct *mm, pte_t a)
> >
> >   static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> >   {
> > -       return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
> > -                    (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
> > +       pte_val(pte) =3D (pte_val(pte) & _PAGE_CHG_MASK) |
> > +                       (pgprot_val(newprot) & ~_PAGE_CHG_MASK);
> > +
> > +       if (pte_val(pte) & _PAGE_DIRTY)
> > +               pte_val(pte) |=3D _PAGE_MODIFIED;
> > +
> > +       return pte;
> >   }
>
> +       pte_val(pte) =3D (pte_val(pte) & _PAGE_CHG_MASK) |
> +                       (pgprot_val(newprot) & ~_PAGE_CHG_MASK);
>
> After this step, _PAGE_DIRTY may have already disappeared,
> If no new variables are added, they can be modified in follow way:
>
>   static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>   {
> +       if (pte_val(pte) & _PAGE_DIRTY)
> +               pte_val(pte) |=3D _PAGE_MODIFIED;
> +
>         return __pte((pte_val(pte) & _PAGE_CHG_MASK) |
>          (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
>
>   }
OK, it makes sense.

Huacai
>
> >
> >   extern void __update_tlb(struct vm_area_struct *vma,
> > @@ -583,7 +588,11 @@ static inline struct page *pmd_page(pmd_t pmd)
> >   static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
> >   {
> >          pmd_val(pmd) =3D (pmd_val(pmd) & _HPAGE_CHG_MASK) |
> > -                               (pgprot_val(newprot) & ~_HPAGE_CHG_MASK=
);
> > +                       (pgprot_val(newprot) & ~_HPAGE_CHG_MASK);
> > +
> > +       if (pmd_val(pmd) & _PAGE_DIRTY)
> > +               pmd_val(pmd) |=3D _PAGE_MODIFIED;
> > +
> >          return pmd;
> >   }
> >
> > You needn't define a new variable.
> >
> >
> > Huacai
> >
> >>   static inline pmd_t pmd_mkinvalid(pmd_t pmd)
> >> --
> >> 2.41.0
> >>
> >>
> Thanks
>
> Tianyang
>

