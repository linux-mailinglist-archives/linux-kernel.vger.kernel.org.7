Return-Path: <linux-kernel+bounces-829811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25426B97F53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3071AE1F74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D07E4317D;
	Wed, 24 Sep 2025 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNiQEHZf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BE81C6FF4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758675443; cv=none; b=FhC9BR/J22lvoJ1H+eswojV5PVje969nII4UROyBk1HztOojS6wOEiEPu3/1NA3+z3e3N0HopPRqupQTFuBaAyO6btizsS1bHgIQRgR+rkNmE1Xz23lq7fAp0gV2T2VnQMH+AB5RbXfvj6PEXMi4xuncJEaHfTT7n/6Q9d4orhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758675443; c=relaxed/simple;
	bh=2meMIq0xvNpsd0C3TfnyRygJ3hyz9WrQ2mbRdwrlQNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3vuCQBjx9IjpDEr5aXu/L5lTioP8vgztIR8Mc7MDdxzntsPlyghaOvvh9VTS+WEUt9zEgHt3DgraiNuPClFnBcyIX8es8xmr1v2fu8PFL6GWSg6niRFkakmNeSeLEbnofh4/MtbTLnjSHLV/PYDwlw030kDjvdSn+zgGfmnhvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNiQEHZf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758675441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mna5fc8+pkr3kffYlRCUCjSYLNXJLdLSL+XsAUmGPn8=;
	b=SNiQEHZfnHPlc12UJcUcbY/EHBYMzUwyyGSz3SthdXe0Jo33h1haiBZ7Okd7VBuFTdvRCb
	DpvRdxNlJ42CC1ofJT44RJLwD+skglwQkqGRJABHUUiK5aIQk0FSbKPl8ik0Hqf94lWyYV
	xv0G9r1+9gSYIzkBPTv3pNO1DVbRR+c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-IW4JqLS5Ns-LNIosuNCFlw-1; Tue, 23 Sep 2025 20:57:20 -0400
X-MC-Unique: IW4JqLS5Ns-LNIosuNCFlw-1
X-Mimecast-MFC-AGG-ID: IW4JqLS5Ns-LNIosuNCFlw_1758675439
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3304def7909so6161564a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758675438; x=1759280238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mna5fc8+pkr3kffYlRCUCjSYLNXJLdLSL+XsAUmGPn8=;
        b=ZHjH9TsK10QuiAvUxwEHfP94uOxlhDSz1Yli5+rtwpjSnH3hL6bt9DADykToBnCzgY
         CnYLIgTGorCn6z/82QuHS1RHrmHJob+/rlxsSrGHSh0UQckILp3qvDLnXo+NcH1CCRBI
         bl0bGwMR423ag9JVwE1IxP4Whny0zFH1egzt8TOMhFpjNwd0l4PndY8akRHiQHHHy/Yy
         9Jzsecnm8WOyITXp8zIGPmy5FUljW3HU2+4Yjg5yQxHfg6heNKFHkqM1RswEpnzwTwXZ
         o5sYY6AI9me9ZKAxBTbam4mBYYuGjnhu3HipD0+2v5Pd04qgvvpl9E5bBrcTcmW+GX62
         isyg==
X-Forwarded-Encrypted: i=1; AJvYcCWKcqidTT+khGG9FpKe83YBTTRKZCFVYe0z+zqXNDwihqwt7VTVRhveoyVXiPi5FCA2Xw5T9ZryYBDqoOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQwxBOUahey9B+L5MSU5oHzKFHK2VeUJxhS0btpYXkw1b59YrH
	Qtg5YRu1917fDiqi3jLeEmLp2VLCuANOeVOuBdiAjfrYx7nGcjip8g5AR4e8Og/23Ujq7gveIb4
	DoNIsACEomfWNh3JRTVqTeRHgg3txxq3yFPgflviYcHvCRgUjiJki7dPLkHeIpoQw/6A6as9W9t
	CMrt1AJ+T+LUCr97v6Txp2FKzzs5vS/1YdfwS36OweJ7lFFQLv
X-Gm-Gg: ASbGncvCQR8aFpkCxam7JtjYD6KMCgTtAHCA8UmNM0LDenR/wuRdSym2AcwENI90imn
	SbSvPr97IH1DrX/vJQKh16CRP1l2w4HXwtEYJ1HNjcQK952M1dZn8Ox5WcC6yH3bgod34weKv1v
	0lRDEimapo63BAbUQuJA==
X-Received: by 2002:a17:90a:c484:b0:330:84dc:d129 with SMTP id 98e67ed59e1d1-332a97051e0mr3951543a91.36.1758675438311;
        Tue, 23 Sep 2025 17:57:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTV0R++YsWMVOlEFmppKwBiFSD4CRSUaeq9TRbxN7oL1yQIoluQr0UeLa4xvqZUE85brDoaQoOyIu6r8dY1Mo=
X-Received: by 2002:a17:90a:c484:b0:330:84dc:d129 with SMTP id
 98e67ed59e1d1-332a97051e0mr3951527a91.36.1758675437774; Tue, 23 Sep 2025
 17:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915073429.54027-1-sheng.zhao@bytedance.com>
 <CACGkMEuvT3=a+6LyaFZFmCZzGS5tntPSbSJg=h6FAHdk89pC8g@mail.gmail.com> <2739dcc3-7c38-492c-854a-731298396a0c@bytedance.com>
In-Reply-To: <2739dcc3-7c38-492c-854a-731298396a0c@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Sep 2025 08:57:05 +0800
X-Gm-Features: AS18NWA2T2FJ5WODRMOqku7-Gx51ufQZ-1bBtbD01K3KvreFoFw78gqxKSyLVs4
Message-ID: <CACGkMEv3pUBF3Uv2s3MM0Qn--fP3mwN92SqE9NX4gNuMALBTUg@mail.gmail.com>
Subject: Re: Re: [PATCH] vduse: Use fixed 4KB bounce pages for arm64 64KB page size
To: Sheng Zhao <sheng.zhao@bytedance.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 8:37=E2=80=AFPM Sheng Zhao <sheng.zhao@bytedance.co=
m> wrote:
>
>
>
> On 2025/9/17 16:16, Jason Wang wrote:
> > On Mon, Sep 15, 2025 at 3:34=E2=80=AFPM <sheng.zhao@bytedance.com> wrot=
e:
> >>
> >> From: Sheng Zhao <sheng.zhao@bytedance.com>
> >>
> >> The allocation granularity of bounce pages is PAGE_SIZE. This may caus=
e
> >> even small IO requests to occupy an entire bounce page exclusively. Th=
e
> >> kind of memory waste will be more significant on arm64 with 64KB pages=
.
> >
> > Let's tweak the title as there are archs that are using non 4KB pages
> > other than arm.
> >
>
> Got it. I will modify this in v2.
>
> >>
> >> So, optimize it by using fixed 4KB bounce pages.
> >>
> >> Signed-off-by: Sheng Zhao <sheng.zhao@bytedance.com>
> >> ---
> >>   drivers/vdpa/vdpa_user/iova_domain.c | 120 +++++++++++++++++--------=
--
> >>   drivers/vdpa/vdpa_user/iova_domain.h |   5 ++
> >>   2 files changed, 83 insertions(+), 42 deletions(-)
> >>
> >> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_=
user/iova_domain.c
> >> index 58116f89d8da..768313c80b62 100644
> >> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> >> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> >> @@ -103,19 +103,26 @@ void vduse_domain_clear_map(struct vduse_iova_do=
main *domain,
> >>   static int vduse_domain_map_bounce_page(struct vduse_iova_domain *do=
main,
> >>                                           u64 iova, u64 size, u64 padd=
r)
> >>   {
> >> -       struct vduse_bounce_map *map;
> >> +       struct vduse_bounce_map *map, *head_map;
> >> +       struct page *tmp_page;
> >>          u64 last =3D iova + size - 1;
> >>
> >>          while (iova <=3D last) {
> >> -               map =3D &domain->bounce_maps[iova >> PAGE_SHIFT];
> >> +               map =3D &domain->bounce_maps[iova >> BOUNCE_PAGE_SHIFT=
];
> >
> > BOUNCE_PAGE_SIZE is kind of confusing as it's not the size of any page
> > at all when PAGE_SIZE is not 4K.
> >
>
> How about BOUNCE_MAP_SIZE?

Fine with me.

>
> >>                  if (!map->bounce_page) {
> >> -                       map->bounce_page =3D alloc_page(GFP_ATOMIC);
> >> -                       if (!map->bounce_page)
> >> -                               return -ENOMEM;
> >> +                       head_map =3D &domain->bounce_maps[(iova & PAGE=
_MASK) >> BOUNCE_PAGE_SHIFT];
> >> +                       if (!head_map->bounce_page) {
> >> +                               tmp_page =3D alloc_page(GFP_ATOMIC);
> >> +                               if (!tmp_page)
> >> +                                       return -ENOMEM;
> >> +                               if (cmpxchg(&head_map->bounce_page, NU=
LL, tmp_page))
> >> +                                       __free_page(tmp_page);
> >
> > I don't understand why we need cmpxchg() logic.
> >
> > Btw, it looks like you want to make multiple bounce_map to point to
> > the same 64KB page? I wonder what's the advantages of doing this. Can
> > we simply keep the 64KB page in bounce_map?
> >
> > Thanks
> >
>
> That's correct. We use fixed 4KB-sized bounce pages, and there will be a
> many-to-one relationship between these 4KB bounce pages and the 64KB
> memory pages.
>
> Bounce pages are allocated on demand. As a result, it may occur that
> multiple bounce pages corresponding to the same 64KB memory page attempt
> to allocate memory simultaneously, so we use cmpxchg to handle this
> concurrency.
>
> In the current implementation, the bounce_map structure requires no
> modification. However, if we keep the 64KB page into a single bounce_map
> while still wanting to implement a similar logic, we may need an
> additional array to store multiple orig_phys values in order to
> accommodate the many-to-one relationship.

Or simply having a bitmap is sufficient per bounce_map?

Thanks

>
> Thanks
>


