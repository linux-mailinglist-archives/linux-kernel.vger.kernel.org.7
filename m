Return-Path: <linux-kernel+bounces-820916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A97B7FA60
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457C06230E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41E62FBDFC;
	Wed, 17 Sep 2025 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stFF1WiV"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B930130CB36
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117405; cv=none; b=jDmbwNvLUwqht3OlZh1g7XWJ24FPJawf/RMG3D5R/K+e/1M7XGLbgIxHZGndmkNWXNXk6on/fBjcrz6mfDgoTlYvLxlQDCFfS44D3sCAi1JGBv7rZJgVHpiHEmZ6tlDkZwt4VNsxxR5S/dAYxwfSdQv+If8netZ9quRNOHgwDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117405; c=relaxed/simple;
	bh=Y1QeQZTNUBe6dk9Rt2pcJ2gl3vvFLRhS6YdG3LZ+k88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkPronytf7awQ/YCrJ8PZdi6abhtA456EeeO3okb1u3s3qal3jgnrTuIfx2j6kDoWezvy/0SQFSFqbYCzjqgMZ5Zg/eXujQN8kJKg0K0S+QI3xXtLUssFJK0HS6tpWeusPMy87iNTGH5gmsQEENJ3Ep4lwb+nTFX2koudJyyrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=stFF1WiV; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-424122baf43so250475ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758117403; x=1758722203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEMbm9j4CeshvjtGmvTaFxMhMVyW+S0748f965m42aA=;
        b=stFF1WiVwigx8igIOablza+/LzNm/O7MVpVO3GnSUakC/A9hRGpwlWZ3IidAPoCHQe
         hNBHKg3V0Lx1GNpiEaoHkWTP/XY1hOhjzA6/ADf8C/o3vHmHZK3D7aHseFCOzTGr8gjD
         vTWyynIY4JoDpGhYXVfQQHxO2ta7L5gEnpON2st2pgFZ8HSPFQhDh1DrufZqPk86Nr2T
         qAazR2rbiLkB9oUnm8FeaW3g/YVIw/C2Jk7fhNgGvGB9NZgO+qwwL2aOypG+dHKVfDaU
         hjDwRm4xT8CQUcWew3DBHQ3NbuGXaY1tBT1lsu/1Cmv69iwjSuR0b643c59rj7aGoP2B
         0nCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117403; x=1758722203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEMbm9j4CeshvjtGmvTaFxMhMVyW+S0748f965m42aA=;
        b=ePIPj/P9tecSHDTpmphJK/e++IzDUmGUr/4iuMRMRKgxkyPckHA/jn/Of8nKQNnOG0
         nAvUhsXpyoo0kVCNvGBAhG0/dWDAPhSUKiYK47QXIKFZFkBcU3JCjsEpazGOo+8PxN/6
         IJtOzGhA/yzhTr6V6vcTirDnXuW4xwf9Zl20cALnVZH1mNUFIf3LYECP0QVtQfx+Vau0
         kWHZPSv5rvmBP+0bwxgux4okieh/V5wsnn7sHXineBjlgloIcSfSqfPrvwN/2GOxrBLo
         x+h9lU+31qzQmpynYojvhz5o5qITEygJZgt6omKL5FqlFJB7z6POe0p/g7yrnp2hjNg1
         +Uxw==
X-Forwarded-Encrypted: i=1; AJvYcCVZCbGcwVbEl14//Dvw1BNuhAQ+SPIs/J/CMkwoCayTwESjh/7nguKKbAOIyjZIA52+nwZItPXDV9wIm6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDeeka2pMJ2iXFg8fF482I+B+LVyeRkvs0aIU1n8eMku4Y6JXF
	GDqG7is6vNsuAFS3l64JeB6orJ6L82yo4cRb1QRDa9BcO4PpUTNgeTF1jon33hAqveAwu4s4UOt
	bms4fTK1JYW5HybWJmN/awDoMGoZTVWx69exIs+G2
X-Gm-Gg: ASbGncvo5areuffq2XJNfXgXsv5V7IT8gglid2cRWIG8xufsKCdWcY/eRxYPOKRxgEK
	SgZah4MK76NNhqmNwG3+NcqlOEXV5ainm0KzWDYB5hpvKSNlNSG4XCEyj8kvKLaYm3MDj727rL5
	OrqGcN43ed68W/eG0I4fDxmv1hPiwQqQEBRXrstb66ldc56uFyffpL0JjPvAKfE58UP7vgAELP4
	2NHx9ifODgBltw=
X-Google-Smtp-Source: AGHT+IH54lOo5tAxFPzTKicKk8Nsp5PjK919P2Qv1+RMdVTWh/6suOqv/WwtVlocAeLMNNVnJWcFQzgwmq8811VHRig=
X-Received: by 2002:a05:6e02:12e8:b0:408:1624:b2fe with SMTP id
 e9e14a558f8ab-4241972e618mr4622285ab.19.1758117402484; Wed, 17 Sep 2025
 06:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <v5ivpub6z2n2uyemlnxgbilzs52ep4lrary7lm7o6axxoneb75@yfacfl5rkzeh>
 <ecac1e7f-1709-4348-b8ff-fa1c0f087548@lucifer.local> <CAAa6QmRaiKB2OOpZYjRx3EAQ+d8_G=MsVmV=9cc_MmHOYsikow@mail.gmail.com>
 <j5pf6l745hp4r56fndlshzcjpyi3nttgywouowhmfiewx6p56j@b64l6tmupykt>
In-Reply-To: <j5pf6l745hp4r56fndlshzcjpyi3nttgywouowhmfiewx6p56j@b64l6tmupykt>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Wed, 17 Sep 2025 06:56:06 -0700
X-Gm-Features: AS18NWD6_SfLOiTUQ_UY5m4VYnC4sMHbvOvNHRcK4iL_zjl8AWSf_Ml8a3TyFUU
Message-ID: <CAAa6QmQY=0J=L2=NaYfwHeqV=JtknA2wwPvNJBvWreq5GXXv-g@mail.gmail.com>
Subject: Re: [PATCHv2] mm/khugepaged: Do not fail collapse_pte_mapped_thp() on SCAN_PMD_NULL
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:52=E2=80=AFAM Kiryl Shutsemau <kirill@shutemov.na=
me> wrote:
>
> On Tue, Sep 16, 2025 at 11:06:30AM -0700, Zach O'Keefe wrote:
> > So, since we are trying to aim for consistency here, I think we ought
> > to also support the anonymous case.
> >
> > I don't have a patch, but can spot at least two things we'd need to adj=
ust:
> >
> > First, we are defeated by the check in __thp_vma_allowable_orders();
> >
> >         /*
> >          * THPeligible bit of smaps should show 1 for proper VMAs even
> >          * though anon_vma is not initialized yet.
> >          *
> >          * Allow page fault since anon_vma may be not initialized until
> >          * the first page fault.
> >          */
> >         if (!vma->anon_vma)
> >                 return (smaps || in_pf) ? orders : 0;
> >
> > I think we can probably just delete that check, but would need to confi=
rm.
>
> Do you want MADV_COLLAPSE to work on VMAs that never got a page fault?
>
> I think it should be fine as long as we agree that MADV_COLLAPSE implies
> memory population. I think it should, but I want to be sure we are on
> the same page.

Exactly. I'm always a little embarrassed when telling people about how
to successfully use MADV_COLLAPSE, "oh, but makes sure you fault at
least one page beforehand because of ~reasons~"

> I also brings a question on holes in the files on MADV_COLLAPSE. We
> might want to populate them too. But it means the logic between
> MADV_COLLAPSE and khugepaged will diverge. It requires larger
> refactoring.

Yeah, and taking a look more thorough am perhaps reminded why I didn't
pursue this yet.

> > And second, madvise_collapse() doesn't route SCAN_PMD_NULL to
> > collapse_pte_mapped_thp(). I think we just need to audit places where
> > we return this code, to make sure it's faithfully describing a
> > situation where we can go ahead and install a new pmd. As a hasty
> > check, the return codes in check_pmd_state() don't look to follow
> > that, with !present and pmd_bad() returning SCAN_PMD_NULL. Likewise,
> > there are many underlying failure reasons for
> > pte_offset_map_ro_nolock()=3D>___pte_offset_map() that aren't "no PMD
> > entry".
>
> Sounds like a plan :)

:) Frankly, I don't have cycles to tackle this at the moment, and
unfair to push the work on you, given it's non-trivial, so can have my

Reviewed-by: Zach O'Keefe <zokeefe@google.com>

For this patch ; though Andrew has already taken it

Hopefully I can look and sneak improvements into 6.18 -- but wouldn't
hold my breath.

> --
>   Kiryl Shutsemau / Kirill A. Shutemov

