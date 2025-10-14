Return-Path: <linux-kernel+bounces-852602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0A9BD96E6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3B81927626
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B13313E10;
	Tue, 14 Oct 2025 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl2YBOjt"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F130594D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445867; cv=none; b=RYD1AQGYW2M9141N/U2CoL/RQaB3rav4ewIFToRPqwGNFv+EVHCwLiPyEvPxmCQkXQBMmaEf6wL16h7lvLWgiZNcMfG1N884mOwbJ0w9Ee/gawA0a0EdKPHu/Mz+eob2UgDP5thXT07zsPbITEEy+6d2ynTG/Q1iWVJdiP5Y0Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445867; c=relaxed/simple;
	bh=QyzRDHjbSAqNA3CNAxYa6LI244O6yFvaYevkEhd1FMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCfizum2EElT4Y/ZFGO/Z+Xr+iaoHWoj1tzyO59Lv+aORdik5QLnJaEl6iVZuRj2oV08aQQP+xvZr8aIwory9En3rcx4b6YNseSN4X3/DbUgxdwZ6jLmtnO95W8ZfsHLF7WQTsn38BcGVX9A+Qb4MVu2m06eL+YQiRX7vJUNQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bl2YBOjt; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57a8b00108fso999129e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760445862; x=1761050662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oo6cb/h2//KSAhz8PhrLQfUB6XAbYAkngZFzEqMMVw=;
        b=Bl2YBOjtM/gbRX0TYP8aRoMLdW8da2JME6geIo61xRvUBJ+wXufILVV2+2myv0iuMw
         nWDkSHWcuyPgERPdbLcvpCIv4xDrwOOli70898cNjWXxCyCEgLsNsmsVQI9SNcZ5nDJS
         nbM0baR56px4Z76do1TDmXikpUlOfTfE3AR3egmb2wnqIvYKyKBiCmIO48OUKoaAX0z3
         nXLbi8Au1CdxrUSLbex4KvoWoRixrBm0/tG9ztq3FX0d7bJk1neyyathjDZ/5/yC+Obo
         xI9ENu4XagHCLB+1evm8/UrftoVAEM+9JD7EdF/+AiXtINimbaJGAJ3QZ48FG7iATfJj
         uF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445862; x=1761050662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oo6cb/h2//KSAhz8PhrLQfUB6XAbYAkngZFzEqMMVw=;
        b=LTwa/b7gKV352ZfDv7uJGy5WyKkgqxZ0EfrEABzx57wkHrufrgzW5NgbFU8+SxVm/d
         Qt+KBc1/tR3zEbJSIt3cMj8rAvX7g4RMaGjj9Yai/fkrMVT9lJLCIyhc21ffkCDg8FxQ
         1N2FGTV9CWCiJISFNus7krBKzZWHxGOlOnbW2jYsLw37uxzTUOsFa8WouKcra/tsTYFX
         RQxGPncf77MdFcQQbqRUIKMpMdhDyHY3qfmEtKbEbkZKNYa6suC4i7Vsup4SAA05hILt
         QxAZm+RstAp9Av65EnfRCtUpc0WsZe14Ic5Q95xauw2GnHtvrvkQaxN5cNvCraVrs3U0
         Uouw==
X-Forwarded-Encrypted: i=1; AJvYcCV4Nv1k+pp6UwS647n1b3+/u8dQnQfOsyZu+7owWY0P1iy2MPZS2EBdQEDeP6RYyhm4DzZJPAl+JPZ/4N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQ94lR7NxvgMde+gftHi+D6GihuhCLJ7QyuC8+S59vuLGlXRT
	D7Kf0fW9ulC2B2VfP01NS8UCUR+R1KlxMH6YYU0tGnIuWmCYST+CtV8Sv5mV4T/Z9M42m8PEGa5
	MRd6NotXellgRPoh4VAdOLRd8V4ysB3w=
X-Gm-Gg: ASbGncs2c8BE9dZrpyPkNNIArmIEOdMiSLRpPUwZAQ7aV5ebXoujVhkessCb9IbbqYf
	UQyJ+IpuiMgcNNjyKrpjzPux2KmPSyUdUfQS3WfPuKROnD7R2uWWoch5M4nyqQTA6Tiu1Ozr1tW
	foQEspT40CIchRuo/+NQigNRPITKbioAaNNnlKCIv2wP1nnYt5q2WRnJfMEYaD4B9lfRDZk8mpz
	Hx3Ipc4xEhk5JFyzxw57HH93MaNw2ndndAV0tQE/FuJdoJ/
X-Google-Smtp-Source: AGHT+IE6ZX1VGaVslNv8ZPr/UKniSljm0zQJqyI+Plq3kYLvNFNlsMtuo7K/t2++yV4p4PZdglaVsxwNfABC8vF2f6w=
X-Received: by 2002:a2e:beab:0:b0:36b:d9d2:7352 with SMTP id
 38308e7fff4ca-37609cebacdmr36927351fa.1.1760445862122; Tue, 14 Oct 2025
 05:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014083230.1181072-1-zhaoyang.huang@unisoc.com>
 <20251014083230.1181072-3-zhaoyang.huang@unisoc.com> <87953097-a105-4775-88a5-9b3a676ff139@amd.com>
In-Reply-To: <87953097-a105-4775-88a5-9b3a676ff139@amd.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 14 Oct 2025 20:44:10 +0800
X-Gm-Features: AS18NWC91XO6vcqGgvJynO5q8vzT5cvKYOwtu3JK2ou4LVmpJ0_YPTlGMwJ6WAA
Message-ID: <CAGWkznGN7W-txq_G+xpZ6DtH_1DNorYc=CxqUjebo7qfB4Sxsw@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver: dma-buf: use alloc_pages_bulk_list for
 order-0 allocation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Mel Gorman <mgorman@techsingularity.net>, Vlastimil Babka <vbabka@suse.cz>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 7:59=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 14.10.25 10:32, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > The size of once dma-buf allocation could be dozens MB or much more
> > which introduce a loop of allocating several thousands of order-0 pages=
.
> > Furthermore, the concurrent allocation could have dma-buf allocation en=
ter
> > direct-reclaim during the loop. This commit would like to eliminate the
> > above two affections by introducing alloc_pages_bulk_list in dma-buf's
> > order-0 allocation. This patch is proved to be conditionally helpful
> > in 18MB allocation as decreasing the time from 24604us to 6555us and no
> > harm when bulk allocation can't be done(fallback to single page
> > allocation)
>
> Well that sounds like an absolutely horrible idea.
>
> See the handling of allocating only from specific order is *exactly* ther=
e to avoid the behavior of bulk allocation.
>
> What you seem to do with this patch here is to add on top of the behavior=
 to avoid allocating large chunks from the buddy the behavior to allocate l=
arge chunks from the buddy because that is faster.
emm, this patch doesn't change order-8 and order-4's allocation
behaviour but just to replace the loop of order-0 allocations into
once bulk allocation in the fallback way. What is your concern about
this?
>
> So this change here doesn't looks like it will fly very high. Please expl=
ain what you're actually trying to do, just optimize allocation time?
>
> Regards,
> Christian.
>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  drivers/dma-buf/heaps/system_heap.c | 36 +++++++++++++++++++----------
> >  1 file changed, 24 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heap=
s/system_heap.c
> > index bbe7881f1360..71b028c63bd8 100644
> > --- a/drivers/dma-buf/heaps/system_heap.c
> > +++ b/drivers/dma-buf/heaps/system_heap.c
> > @@ -300,8 +300,8 @@ static const struct dma_buf_ops system_heap_buf_ops=
 =3D {
> >       .release =3D system_heap_dma_buf_release,
> >  };
> >
> > -static struct page *alloc_largest_available(unsigned long size,
> > -                                         unsigned int max_order)
> > +static void alloc_largest_available(unsigned long size,
> > +                 unsigned int max_order, unsigned int *num_pages, stru=
ct list_head *list)
> >  {
> >       struct page *page;
> >       int i;
> > @@ -312,12 +312,19 @@ static struct page *alloc_largest_available(unsig=
ned long size,
> >               if (max_order < orders[i])
> >                       continue;
> >
> > -             page =3D alloc_pages(order_flags[i], orders[i]);
> > -             if (!page)
> > +             if (orders[i]) {
> > +                     page =3D alloc_pages(order_flags[i], orders[i]);
> > +                     if (page) {
> > +                             list_add(&page->lru, list);
> > +                             *num_pages =3D 1;
> > +                     }
> > +             } else
> > +                     *num_pages =3D alloc_pages_bulk_list(LOW_ORDER_GF=
P, size / PAGE_SIZE, list);
> > +
> > +             if (list_empty(list))
> >                       continue;
> > -             return page;
> > +             return;
> >       }
> > -     return NULL;
> >  }
> >
> >  static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
> > @@ -335,6 +342,8 @@ static struct dma_buf *system_heap_allocate(struct =
dma_heap *heap,
> >       struct list_head pages;
> >       struct page *page, *tmp_page;
> >       int i, ret =3D -ENOMEM;
> > +     unsigned int num_pages;
> > +     LIST_HEAD(head);
> >
> >       buffer =3D kzalloc(sizeof(*buffer), GFP_KERNEL);
> >       if (!buffer)
> > @@ -348,6 +357,8 @@ static struct dma_buf *system_heap_allocate(struct =
dma_heap *heap,
> >       INIT_LIST_HEAD(&pages);
> >       i =3D 0;
> >       while (size_remaining > 0) {
> > +             num_pages =3D 0;
> > +             INIT_LIST_HEAD(&head);
> >               /*
> >                * Avoid trying to allocate memory if the process
> >                * has been killed by SIGKILL
> > @@ -357,14 +368,15 @@ static struct dma_buf *system_heap_allocate(struc=
t dma_heap *heap,
> >                       goto free_buffer;
> >               }
> >
> > -             page =3D alloc_largest_available(size_remaining, max_orde=
r);
> > -             if (!page)
> > +             alloc_largest_available(size_remaining, max_order, &num_p=
ages, &head);
> > +             if (!num_pages)
> >                       goto free_buffer;
> >
> > -             list_add_tail(&page->lru, &pages);
> > -             size_remaining -=3D page_size(page);
> > -             max_order =3D compound_order(page);
> > -             i++;
> > +             list_splice_tail(&head, &pages);
> > +             max_order =3D folio_order(lru_to_folio(&head));
> > +             size_remaining -=3D PAGE_SIZE * (num_pages << max_order);
> > +             i +=3D num_pages;
> > +
> >       }
> >
> >       table =3D &buffer->sg_table;
>

