Return-Path: <linux-kernel+bounces-737414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4B7B0AC35
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889505A5DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A7C221FDA;
	Fri, 18 Jul 2025 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUGBRMlC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAC81F92A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878111; cv=none; b=N2tRukC6Ta8EwBH5XFYLx2Qy7325vetGDyIBHpvJHy0wcdN4EXxs2KaZLf6TxBKSNHV0qFJBZHt+qxVa03JNZvlQ3j1ELJdTN/6ucll7lNyPUPi3rvXfrCHN/Rc9o4cyXHjXT7h/JAS28bkNweAuxAaNF/HLgIKfmS1kdJxzQQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878111; c=relaxed/simple;
	bh=tkPTSQAd9h2DNl7pRHlG+8OmpNzmu5y8PbLNUmZaSpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcPdGLGTOa8LwWhpkNxBLSpIPiKt2c3MTqR2vdDeB2+aU1d2Cyh2GNXA0QjHU1tmDmTSPnrsLlBkoKCmpAWzKA7jTu9CwRmibG6wEGvAKF/EFrHI1Sq5g1ugVQbwZu2wS301BaRQLeGXWtaLYZ+7mREOydVxuhwS4+p220ROuvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HUGBRMlC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752878108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeNgxF5UCBfEjQZZt/3dunIhv4OxleQp/vJtVa2lu7w=;
	b=HUGBRMlCCvBJy//AKU6OvHH23iZ9rOFU3ndmrSw/LJR9Jghz0ao+f8CLqeVvgOOGjkSm1Q
	krfCrMmzbbj0fsyj6Ekl30gGJ38wTw2vJfoYDyLSs5/zWvjWTpXOzfL2xqn1Md0xHlagMn
	mQEp3yhNpdv0mSNCbRNxO50OOaps1o0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-VHRwPcHsOuuTP27tmFE7Vg-1; Fri, 18 Jul 2025 18:35:06 -0400
X-MC-Unique: VHRwPcHsOuuTP27tmFE7Vg-1
X-Mimecast-MFC-AGG-ID: VHRwPcHsOuuTP27tmFE7Vg_1752878106
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-711a46ce053so33547687b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752878106; x=1753482906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeNgxF5UCBfEjQZZt/3dunIhv4OxleQp/vJtVa2lu7w=;
        b=fEQGjTaMAo0QLNM6a7hWoYOcIsqTwSwyLe1T6rahxeDyuRpzYAGG7wPCaR+8L8KEWQ
         /lGLVg0ezmllq1DG70JN2AmBsxcp/1K2GCgIr9wffyVFasjXW/qf1FNedFp/UTm57Uhf
         cOYETvE+jEZ9r4eavS7HKT2SeBUELsL4LTJM/z1ufS98zIJ4PjQXKv178z177b2yH7nS
         CzRKmUlAuhoV7uZnzXXDyoofJiy8PBF102ndsqnab3vtQIKbCU26tC1TuA7CNvpZnjDu
         EhRbm2t1QgaWXeHmAckqoJFn7ZS2K39vvR8vjw2YW/zu1YlmIaaxpvXsKOQfJ5+bT4Al
         AihQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIDCL/WR9TL7h2FBhZ3tUexzoT0/dcbUY+y0IqKHpMjyE0lHsYoNHVQ0guc5Wa5R6VxeMLocS7JY2HTPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUiv7vd300Ch9Y4+nYwc92tk/uCVJfmtqNftWojZcebez6rbk
	ZpK5hDsdmZKzAITAeIYcynvLagJjyfLvzOzmf1hfz9BhV2HhtofBIOnlC8pAI6jX+UGIWKXHb+/
	vbYo7LynMpw2f17g2W3/Ukr0c5KeZxFGZN9OfkxcmX2VYCNbxnAMAyxZSXyfvuAHKTzHdHkb57V
	9RRcI+6iPJReGFm+chwfzzmcjT7bR7wezmoMeGUiDU
X-Gm-Gg: ASbGncsaoX3sFoXdLl15y0gmOn22sAH/tFS7p0y91IKOxcseYKU2Wc0I/So1Y7JRe28
	jUy9YZZl1XYWqfE7Vm7ADukzeimxEcPGvp/dIbah1vRivZvcbZ0sp4ollj7VCOaywaXuHSEKmRG
	1vtxf9/oYBzzEC7+OHCHbLyAQ=
X-Received: by 2002:a05:690c:3381:b0:710:f39f:4d43 with SMTP id 00721157ae682-718370eebf5mr151640737b3.7.1752878106341;
        Fri, 18 Jul 2025 15:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtDqNhAwLC/pZ0SZYm/yFdraL0W/1wyk988LFZ3cFbmaM2zMi6HIsy7NS2kuQoOaJh3+sk3INvjvbsCfYcvCw=
X-Received: by 2002:a05:690c:3381:b0:710:f39f:4d43 with SMTP id
 00721157ae682-718370eebf5mr151640437b3.7.1752878105985; Fri, 18 Jul 2025
 15:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-10-npache@redhat.com>
 <85b2cfd8-4aeb-4e98-8065-b6594783de62@linux.alibaba.com>
In-Reply-To: <85b2cfd8-4aeb-4e98-8065-b6594783de62@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 18 Jul 2025 16:34:40 -0600
X-Gm-Features: Ac12FXxkomg9g29JxE95wSIPOgeRNYVw8gHZYEJGmZnbAnxw2JgSYGWV08AFQqU
Message-ID: <CAA1CXcCk5VTTs+cYtWSo_UC4eDBuUCa_2wrkiexDAS6HvvXiuA@mail.gmail.com>
Subject: Re: [PATCH v9 09/14] khugepaged: avoid unnecessary mTHP collapse attempts
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 8:15=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/7/14 08:32, Nico Pache wrote:
> > There are cases where, if an attempted collapse fails, all subsequent
> > orders are guaranteed to also fail. Avoid these collapse attempts by
> > bailing out early.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   mm/khugepaged.c | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index a701d9f0f158..7a9c4edf0e23 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1367,6 +1367,23 @@ static int collapse_scan_bitmap(struct mm_struct=
 *mm, unsigned long address,
> >                               collapsed +=3D (1 << order);
> >                               continue;
> >                       }
>
> After doing more testing, I think you need to add the following changes
> after patch 8.
>
> Because when collapsing mTHP, if we encounter a PTE-mapped large folio
> within the PMD range, we should continue scanning to complete that PMD,
> in case there is another mTHP that can be collapsed within that PMD range=
.
>
> +                       if (ret =3D=3D SCAN_PTE_MAPPED_HUGEPAGE)
> +                               continue;
Ah good call, this patch is meant to be an optimization to the formal
approach-- meaning there are cases where trying ('goto next') to
collapse to lower orders is pointless, but I didn't fully consider the
cases where trying the other items (sections of the PMD) in the stack
are viable (ie continue). I'm going to spend some time confirming all
the potential return values that can come from collapse_huge_page, and
which ones belong in each group (goto next, continue, break). This
will probably be turned into a switch statement.
>
> > +                     /*
> > +                      * Some ret values indicate all lower order will =
also
> > +                      * fail, dont trying to collapse smaller orders
> > +                      */
After reading this comment again, i realized it's rather confusing...
it makes it seem like these ret values are the ones that indicate that
we should not keep trying to collapse to smaller orders. I'll clean up
that comment too.
> > +                     if (ret =3D=3D SCAN_EXCEED_NONE_PTE ||
> > +                             ret =3D=3D SCAN_EXCEED_SWAP_PTE ||
> > +                             ret =3D=3D SCAN_EXCEED_SHARED_PTE ||
> > +                             ret =3D=3D SCAN_PTE_NON_PRESENT ||
> > +                             ret =3D=3D SCAN_PTE_UFFD_WP ||
> > +                             ret =3D=3D SCAN_ALLOC_HUGE_PAGE_FAIL ||
> > +                             ret =3D=3D SCAN_CGROUP_CHARGE_FAIL ||
> > +                             ret =3D=3D SCAN_COPY_MC ||
> > +                             ret =3D=3D SCAN_PAGE_LOCK ||
> > +                             ret =3D=3D SCAN_PAGE_COUNT)
> > +                             goto next;
> > +                     else
>
> Nit: the 'else' statement can be dropped.
>
> > +                             break;
> >               }
> >
> >   next:
While i'm at it i'll change this to next_order to be more clear.

Thank you !!
-- Nico
>


