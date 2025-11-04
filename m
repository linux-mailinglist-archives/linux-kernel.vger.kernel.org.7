Return-Path: <linux-kernel+bounces-884630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A48C309D1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9522D18840CF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510542DAFDF;
	Tue,  4 Nov 2025 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYS5N4vq"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E52D8DD3
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253752; cv=none; b=q7eoT44jlm/h9XitUtdYPXRcjQJrFTYnIjTyR12zwyt4/M07NccAXtLprotpZVy0C3kNYYGOuYmmqDWMEMnDfGwN17hZcqnC7WH2rJu6cVXfF1Auqz5yakqFkmci2Xs6aUex6pXmsxgFKelPgYhP7Bj/KyJrEu/qM3ofxTxgLYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253752; c=relaxed/simple;
	bh=WUWgd+l5bNXHq4r6lAiWhkaKgnBt9bwAhSXObF+7x3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXNdWzFgzTUSQhIvAevcsaet4pAmSIc3C5YpNKB8EJZm5x/3aF2Pi/tMREhdCt/HayQ+kufbt0XYJejvmFb46Lkx+2Xg9I2nfb47Dp58XPciQrOmBJ6h9z7jrbf5v4CnNl6rXdBpI242X3tlDH5rx0vDj7AIFsWLfbPeI8a5kvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYS5N4vq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b710601e659so280632566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762253746; x=1762858546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYx65Ajs81HOm10wh2za1FtmkK5GGLky+6Z7TY2nQnw=;
        b=SYS5N4vqet13kYhQcUe9LLXEPgJMfOQk8LdwMMGbRovbEyUftu1LtzI2f5IX9/z/Ge
         6RwhnH2pIYZ0e0TVIP9RlAm4v0XsGRi7tUANPDv/oTnbsDkeN5b3lLfRQ5y8eSWmG59k
         Pcx6KheCtegl1xb51uzg9c3tIIBwpfpihWB+LeAj+ZqBmZEZqbpxhxInh34Yotd4PlA4
         5KXrw0Z807UFoYx+5MuhoQL5LYHeB69iQwcjCmwS0Vqkqba5otza5XnyplRNSAWWX5bH
         XuHuZ0ugCwIIAqkkD5LtsHD6KFpUyViM6B8qUNtVr+fuIl+dBqagZmpCzU+M4FkBF277
         Zqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762253746; x=1762858546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYx65Ajs81HOm10wh2za1FtmkK5GGLky+6Z7TY2nQnw=;
        b=M53veC1wgQEIfeEgDBd8v8vz9zW7oITPj3ZqV3MXk4UpakRrtP6D9wrnR4Yv81ld9Y
         jWBpbwfIqznYvw780VC36y+LOJ5g1MaNFoK+OnWTTMswoJN6MkeuuYePAbDS8JHHHCd2
         PqbIivmhHLSt/GCHxwwFOUoQVcxozmmgUo6nnulmyvvpagg3oIigD2ZCa7Cn5e5L537W
         Ja+3kp+3GeoDxUEHPDXlLKhMdcS0mj3Bz9VkFLFU+6JZgZ5d6Bb53bfMRlgkUs6UJo2m
         1klQFboC0SS60O2PSvau7rMHbO3dJJZWgJAbN3YM3Z57oUNCc9b0eBytE8Xathuz14vK
         SZwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAsbrJKq2pCWjvWyqR3QOSloiKNK6ECFAo8WK7/PkAenUft7A+88LM6OEC1QmyT/TW856FWT48WUcYtGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZdnqfJE7jY7qFvXO3nYkihsroJq/ttG8hSo42HA3X87QBCLr
	QsAapm9+xUUQXan1Q3A2pVwYl0r7fkaTLvqKRPRs7C3lkoFBuqg/NXic+T7qqNFJnVy0yuJYe/Y
	AxCQQN+InsmcB2KT0vXRMIYdXoyC46+g=
X-Gm-Gg: ASbGncvPHiseLNtycqjBPgTcIhFOEPXD9AcK0/1mr58ijfemMRxw9a2ouE7CGYgCibA
	n3thl05gWW7R0ro2U7EwHQrDkJjJ0/HqsU/OftdrB4XUKdPxw1DBDR+7rtwLE8sWTRBGmYw0dhZ
	2cYIY4BvXFD8f6FKbcdgPBWvjU870tQ2FKaNAE0D6PnFdEq50RPXIPrS0MaqPCedwzQSZehCEI/
	1SHTDu1IuEI+67P36tCR6x+FJF52WN7Tg29jsFQjZ8CSZqJ1GQvw++IQyq+cEaX
X-Google-Smtp-Source: AGHT+IHCPOnCh3IGY2Eq6cNtPlJHDt91gY7lJFsQg4HRVsucdlISL7TQnSu2L7dI1JasQLApmSCul7dtUqQElSLk/vg=
X-Received: by 2002:a17:906:3950:b0:b70:ac48:db8d with SMTP id
 a640c23a62f3a-b70ac48fb80mr718240366b.28.1762253746475; Tue, 04 Nov 2025
 02:55:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-4-3d43f3b6ec32@tencent.com> <CAGsJ_4xOd0CJLZvzvZu9mRLjVvV0OSKE8NcBAYe3wvHFtLjWyA@mail.gmail.com>
 <CAGsJ_4z9xTd=oHDuzLbdkyhd_F=tj2A3K_dsp33dXad6pvVZpA@mail.gmail.com>
In-Reply-To: <CAGsJ_4z9xTd=oHDuzLbdkyhd_F=tj2A3K_dsp33dXad6pvVZpA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 4 Nov 2025 18:55:09 +0800
X-Gm-Features: AWmQ_bkhlu705Rg4epmhOhTM7qF-S9lFO_ydWRgeH2VOBr0FVTh1QNgdWHU5P3Y
Message-ID: <CAMgjq7DJMtN9_r9L5jatZN8_0GS=pKYLPcArd=ie4rBSwHWXGw@mail.gmail.com>
Subject: Re: [PATCH 04/19] mm, swap: always try to free swap cache for
 SWP_SYNCHRONOUS_IO devices
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 4:27=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Tue, Nov 4, 2025 at 12:19=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Wed, Oct 29, 2025 at 11:59=E2=80=AFPM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Now SWP_SYNCHRONOUS_IO devices are also using swap cache. One side
> > > effect is that a folio may stay in swap cache for a longer time due t=
o
> > > lazy freeing (vm_swap_full()). This can help save some CPU / IO if fo=
lios
> > > are being swapped out very frequently right after swapin, hence impro=
ving
> > > the performance. But the long pinning of swap slots also increases th=
e
> > > fragmentation rate of the swap device significantly, and currently,
> > > all in-tree SWP_SYNCHRONOUS_IO devices are RAM disks, so it also
> > > causes the backing memory to be pinned, increasing the memory pressur=
e.
> > >
> > > So drop the swap cache immediately for SWP_SYNCHRONOUS_IO devices
> > > after swapin finishes. Swap cache has served its role as a
> > > synchronization layer to prevent any parallel swapin from wasting
> > > CPU or memory allocation, and the redundant IO is not a major concern
> > > for SWP_SYNCHRONOUS_IO devices.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  mm/memory.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 9a43d4811781..78457347ae60 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -4359,12 +4359,21 @@ static vm_fault_t remove_device_exclusive_ent=
ry(struct vm_fault *vmf)
> > >         return 0;
> > >  }
> > >
> > > -static inline bool should_try_to_free_swap(struct folio *folio,
> > > +static inline bool should_try_to_free_swap(struct swap_info_struct *=
si,
> > > +                                          struct folio *folio,
> > >                                            struct vm_area_struct *vma=
,
> > >                                            unsigned int fault_flags)
> > >  {
> > >         if (!folio_test_swapcache(folio))
> > >                 return false;
> > > +       /*
> > > +        * Try to free swap cache for SWP_SYNCHRONOUS_IO devices.
> > > +        * Redundant IO is unlikely to be an issue for them, but a
> > > +        * slot being pinned by swap cache may cause more fragmentati=
on
> > > +        * and delayed freeing of swap metadata.
> > > +        */
> >
> > I don=E2=80=99t like the claim about =E2=80=9Credundant I/O=E2=80=9D =
=E2=80=94 it sounds misleading. Those
> > I/Os are not redundant; they are simply saved by swapcache, which preve=
nts
> > some swap-out I/O when a recently swap-in folio is swapped out again.
> >
> > So, could we make it a bit more specific in both the comment and the co=
mmit
> > message?
>
> Sorry, on second thought=E2=80=94consider a case where process A mmaps 10=
0 MB and writes
> to it to populate memory, then forks process B. If that 100 MB gets swapp=
ed out,
> and A and B later swap it in separately for reading, with this change it =
seems
> they would each get their own 100 MB copy (total 2 =C3=97 100 MB), wherea=
s previously
> they could share the same 100 MB?

It's a bit tricky here, folio_free_swap only frees the swap cache if a
folio's swap count is 0, so if A swapin these folios first, the swap
cache won't be freed until B also mapped these folios and reduced the
swap count.

And this function is called should_try_to_free_swap: it's only trying
to free the swap cache if swap count =3D=3D 0. I think I can add some
comments on that.

