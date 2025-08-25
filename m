Return-Path: <linux-kernel+bounces-784422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FA4B33B9E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA66B7AF2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A212A2D1931;
	Mon, 25 Aug 2025 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn6sxYVd"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733CF2D12ED
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115187; cv=none; b=t2tf+Vvemqif+J6ap87+DLiqLzdOc1IysIiTJHclGtjPQ9dEyX2w9rHDsyBG/KDOBR3YVeUVUYvL+fIgrzNe29QYFBNcIMpkYNkbdto091kj2UWMmlTQmZqevdVu0jUOEBMGM1lqptz3Ctjn9I/lMHhg8y2lURJ6Ovj+igEY8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115187; c=relaxed/simple;
	bh=jOS7Mf0oStxm1Aw/0K5Du6xrfPzcoManAwmD48HIARQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdX2hjQAcsZ5bggf1yDdhbQqSW0gVxnsssagexd+6flGhAS+xuuLD3Bsh4AUDPDb7UzhsKa8PMCwnRFSWDZytUd2gECA8vcYnc1dvRXS6FWTojShsaPv92ouxF3245q/vXZZLpKPjIurwqZ8oObUwJLLJ3UwLIuDN2G9fQyC7vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn6sxYVd; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ea8b3a64b8so22289805ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756115184; x=1756719984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85vlzJV0/y5OBvRtH7AoGcRMx7r7vPAIreX71H+x3bg=;
        b=hn6sxYVdw+BEqjbuvBO40BLb2srk70p8Ce1wAAHJIW/VF2xvcTG0Kbm7tBcw7HiM5z
         0oEVrNC4RQB4PnDi0fi7PJV1AKhciCLhpeiWCZveVixRYakghSC3E6r1lNspxbYV+U5Q
         GQZuGvqqJTYxohaFYxRVC8/mVE0CCoTJIgUA1Wkhxs4NUYrDnJBJamiHG2ZlDmTdiOEz
         vPYnWkGKveDQd9gXOLWV3g1BZTYoNc1hpiimTIMK+lkhPDmm4AaIth0mpqYusuRmMEti
         fok+sFm7cCdAmLexIUH1iLIQhDQ08T6AV4TSf9liu/4wZqJKMmje8Bv4o8e2JYg8ceMJ
         smDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115184; x=1756719984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85vlzJV0/y5OBvRtH7AoGcRMx7r7vPAIreX71H+x3bg=;
        b=YREnPIxvVE+s/KWiw1entiVHhM+KJFWP565AP4/boKmlQRHoQ+Y4a3dAEKwRaXl3cy
         rrRSeNoFuCL5JlERVhhsFKF1u5xI2WZQ6Nn58wl0PqkIvtcmrnr0D2J4dH6GPJxL1B5a
         P3qG0xgEF/6HuR0eZ+kLkPy4cZMXWlMl+zs1gORRDLto1Nso8o4XUj5dL79AOvOCf+38
         +YjAnsNkGEpXipWovh8JStl4Ys0wQfprv5I6SmpfN7EXLpOrZHqeYRscOdmxIVMuDBhO
         PK4EY0KgdsH7+0UwnQi+R2PqYO/r29FXArGaZu2wgTKx9/pVrPd27Gl5Ui+j0q1IHhTz
         C8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXlcvd3tW9GKx5wkVH7d590+9OwYduJgwmpV18wKdANZePXFC7pJcOT6xEDzZh2TRaebdtmBEce6RKXSYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhHhn/DDxb3hJL5TAp9oa+mVKwEnuHKtEVDQk3roqsA9kT8sxn
	rVk2rj+KiOG7NkLLwdR8vaS43FfhEEGY+CoXnMLAb5kQm/LkPaqRZNrrov2O3Yc0Alg2Jjllw7x
	9rmNvRIXHRXtujlaLaF04lq1JUZcCvJB39c+e7/c=
X-Gm-Gg: ASbGncsWpgdC4b3S6XMcxjPxyPh8PbBa/ysMnETsuyRAekzcgbajJE6SxOk04W6ON6K
	cTJfd+SA+GZ7J9Zgo+D9M6P6DIHtLhAttuoYKl2Zyd0dmCrJAryL9fIRHJvFluvknfb8FW4Sl16
	iCJOEeV/ZFlAIS5dtRx4nK5cypYNK4zxbNl4Vrn5XzuQ6ZxLXR6Ndoq6ngieqxzVyQuKnkwA3Sm
	6Rs7hU=
X-Google-Smtp-Source: AGHT+IFAikaEYsWSht+/wJX3ArSZEhVcZhprdsD3mK3udXZtsifbgz8EMPUifSFtpWWEExAg/dCHwUQXkLQBVXtvV2I=
X-Received: by 2002:a05:6e02:1988:b0:3e5:3521:46e3 with SMTP id
 e9e14a558f8ab-3e9228e492amr4932105ab.23.1756115184473; Mon, 25 Aug 2025
 02:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-6-ryncsn@gmail.com>
 <0fc6e083-b7be-4144-a50c-d1a7a2e1c3a5@linux.alibaba.com>
In-Reply-To: <0fc6e083-b7be-4144-a50c-d1a7a2e1c3a5@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 25 Aug 2025 17:45:46 +0800
X-Gm-Features: Ac12FXxCEasX7WZXCdIE6kaZfUf7KCWB60OtwzH07oeIYEid6isVhNYOyBR6OGo
Message-ID: <CAMgjq7A7_ZbSWJQj8wjhPb6vt=iLhHc5r=cJdzMeNpog-PcstQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] mm/shmem, swap: remove redundant error handling for
 replacing folio
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:09=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/8/23 03:20, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Shmem may replace a folio in the swap cache if the cached one doesn't
> > fit the swapin's GFP zone. When doing so, shmem has already double
> > checked that the swap cache folio is locked, still has the swap cache
> > flag set, and contains the wanted swap entry. So it is impossible to
> > fail due to an Xarray mismatch. There is even a comment for that.
> >
> > Delete the defensive error handling path, and add a WARN_ON instead:
> > if that happened, something has broken the basic principle of how the
> > swap cache works, we should catch and fix that.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >   mm/shmem.c | 28 +++-------------------------
> >   1 file changed, 3 insertions(+), 25 deletions(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index b4d39f2a1e0a..e03793cc5169 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2158,35 +2158,13 @@ static int shmem_replace_folio(struct folio **f=
oliop, gfp_t gfp,
> >       /* Swap cache still stores N entries instead of a high-order entr=
y */
> >       xa_lock_irq(&swap_mapping->i_pages);
> >       for (i =3D 0; i < nr_pages; i++) {
> > -             void *item =3D xas_load(&xas);
> > -
> > -             if (item !=3D old) {
> > -                     error =3D -ENOENT;
> > -                     break;
> > -             }
> > -
> > -             xas_store(&xas, new);
> > +             WARN_ON_ONCE(xas_store(&xas, new));
> >               xas_next(&xas);
> >       }
> > -     if (!error) {
> > -             mem_cgroup_replace_folio(old, new);
> > -             shmem_update_stats(new, nr_pages);
> > -             shmem_update_stats(old, -nr_pages);
> > -     }
>
> It looks like the shmem statistics update was mistakenly deleted?

Ah, you are right, I'll need to add it back. I somehow misread this as
the error handling path. Need to add it back just drop the !error
check.

Thanks for the review.

>
> ( Continue to understand the whole series:) )
>
> >       xa_unlock_irq(&swap_mapping->i_pages);
> >
> > -     if (unlikely(error)) {
> > -             /*
> > -              * Is this possible?  I think not, now that our callers
> > -              * check both the swapcache flag and folio->private
> > -              * after getting the folio lock; but be defensive.
> > -              * Reverse old to newpage for clear and free.
> > -              */
> > -             old =3D new;
> > -     } else {
> > -             folio_add_lru(new);
> > -             *foliop =3D new;
> > -     }
> > +     folio_add_lru(new);
> > +     *foliop =3D new;
> >
> >       folio_clear_swapcache(old);
> >       old->private =3D NULL;
>
>

