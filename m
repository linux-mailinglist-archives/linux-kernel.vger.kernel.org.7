Return-Path: <linux-kernel+bounces-783111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC13B32979
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4895A3B2E95
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7362E7184;
	Sat, 23 Aug 2025 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gghw7yJs"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E02D6402
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755961636; cv=none; b=ugfGJe+L17Br0Ma2T6M1z6gXkgyvESDiwelIfo3UkAF9NYyYn7SEmLIscP/RacISCvOfPd5Wi+PMM4C/PZxWdc2jsHHFT5MHszyICOSAmUvbPSUOdFBgu83zWLgb71XWF0LjbzHVgEIaqIVZmnEuTdcPVNjkiSwE0uTSwZ28j3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755961636; c=relaxed/simple;
	bh=UpGNm1lJm++utdU9nsBZVWFBhfrHqvQSBBk+JG82FzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ibf91pB3p/B0TLYbmpK97xhDVzl9V4LmAqmCTmz8VGdjGG+sek0m27KbzauM3A3Mjpv5p2AXmLZQf9/zZT/Di5OHroeIwxV+Kh8sm9wUgXfwZpdE1ZbCPZY9jlPXly6hncvTv9yKF5pAp4oZ8863codKe/HI+AAvt96M8M71tAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gghw7yJs; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-323266d6f57so3221015a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 08:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755961633; x=1756566433; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I7pLQJXLP+/wh5RGo7QUOMgrfB1lGW/zUnYaj6G/Tnk=;
        b=Gghw7yJscryrzrsoGsAxe5mIODgiIVrL4/EDh3EQ9nyl9d0tOperWjNJ7hVXNAR092
         Y4Tb7rZwge2Q1HeBVLNNTqFgRxaYOCVqm4b3N4L2PTk0Q2fkOZL3pliwL6jVClpxCILD
         FNMBv/+DT0+S99FQlopHOg8xjmBkIuzDXlTmi85v7mlkgrFwA0IYQXbn9ut0ieSsi53O
         CZh0O2lICtI83hSFa9mcSVC+jp18zrTSFHvZYWJ+ZdhS/XW1UVyOrC2ZEMLFkxa5324E
         VnRb1gZw0NK7VQukHG7cwsPxsm24GSV625QnwJCFWXtOcrqczL3X46krN2j+0fvkW7AT
         B6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755961633; x=1756566433;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7pLQJXLP+/wh5RGo7QUOMgrfB1lGW/zUnYaj6G/Tnk=;
        b=A0lygQwn7Bs0mCTPQXX3vr7w0+Das0BgitYTZzUPCoZgVu9+/XFh/K1C/UIT+WNA89
         RREh0pemmlHteojTDKXbTXBmgTDkpFfPnl22QdLBAkV/tsXTqCT3l7+A/wOo2Z+ycROz
         T5INEbWECWBYOUPS2XwqFQDXLwB+NL5PEjTw2VnHbB4QI++w5UkRu86i5KHm65kJgTuI
         as+DBZhkf2L0apKexLstq/47/Vfh+o2+g9deJl3yHMDMGSKyIie86iiD+lxkNfgXrxYl
         fblsZEKAmZBuWbsX1bHjVF4w6788EBx518RdpfozLzGJGgfcTcY1DOEWkQuOpsKW1rmb
         pM0g==
X-Forwarded-Encrypted: i=1; AJvYcCVy/xq6a08ZeJcj/GEihZ+Fj1307VWIQ0uCfW0l/1r+EbO3R4FpDAXkM7XUfNcbpNRdGLKB6YVicOe9Btg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxWm9A/DNY8ZS68NnJNIeeqfIU1eu/fpGyP207udZpIBOw3ppd
	Ti29SbU3clLh6+eLioZevy/uBvct832WX0w2VlHPiFer/Bfbo12ShBdW08LGWgb++Q0QFmdN0sv
	XR6Ej3wcYNdQ2nrUn8L9GQXUBT3/m8UU=
X-Gm-Gg: ASbGncs6b87lQ9kjpN6zbl3wTovg0Io7Y7ZVQeTmKumnQsDOAdVbVn82LyOCDhk8KKn
	OuQBt8NDxhFNWpCXJNBrkY9gUQ5YyrWscdyImVRC73/yyfPzZWnK7TMj95EtqYIYsKFm9B8Hhtj
	qNDP3UhqIlSsxjSFL7bqhKFVrQuDhguCakGGcUD6AQdfh2aEqDnAr1qTAjx4okeKrCvDQoXLRCc
	CCFWlbaGA==
X-Google-Smtp-Source: AGHT+IEr9vKR7FtQhlrnd808SbbiUl6CKFWHZDUAlAzh/z9Y1MpYHYnvQ/j96L1se05nXwg7jYHjT7CC9iMKdtLAKvo=
X-Received: by 2002:a17:90b:2ccd:b0:312:e731:5a66 with SMTP id
 98e67ed59e1d1-32515ee159bmr8372285a91.3.1755961633212; Sat, 23 Aug 2025
 08:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822055857.1142454-1-aha310510@gmail.com> <20250822180708.86e79941d7e47e3bb759b193@linux-foundation.org>
In-Reply-To: <20250822180708.86e79941d7e47e3bb759b193@linux-foundation.org>
From: Jeongjun Park <aha310510@gmail.com>
Date: Sun, 24 Aug 2025 00:07:02 +0900
X-Gm-Features: Ac12FXzg9ES-N0zhJUF3GMAtH8ORLxjO5-PYPz_EOpxp6i0X4nmTNebz-VH131k
Message-ID: <CAO9qdTGKPQ=L2fMJ=oNz-7OG-9p+4VQz3+8-g7TRXJsqBC-6OA@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: add missing hugetlb_lock in __unmap_hugepage_range()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@redhat.com, 
	leitao@debian.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+417aeb05fd190f3a6da9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Andrew,

Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 22 Aug 2025 14:58:57 +0900 Jeongjun Park <aha310510@gmail.com> wrote:
>
> > When restoring a reservation for an anonymous page, we need to check to
> > freeing a surplus. However, __unmap_hugepage_range() causes data race
> > because it reads h->surplus_huge_pages without the protection of
> > hugetlb_lock.
> >
> > Therefore, we need to add missing hugetlb_lock.
> >
> > ...
> >
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -5951,6 +5951,8 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >                * If there we are freeing a surplus, do not set the restore
> >                * reservation bit.
> >                */
> > +             spin_lock_irq(&hugetlb_lock);
> > +
> >               if (!h->surplus_huge_pages && __vma_private_lock(vma) &&
> >                   folio_test_anon(folio)) {
> >                       folio_set_hugetlb_restore_reserve(folio);
> > @@ -5958,6 +5960,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >                       adjust_reservation = true;
> >               }
> >
> > +             spin_unlock_irq(&hugetlb_lock);
> >               spin_unlock(ptl);
> >
>
> Does hugetlb_lock nest inside page_table_lock?
>
> It's a bit sad to be taking a global lock just to defend against some
> alleged data race which probably never happens.  Doing it once per
> hugepage probably won't matter but still, is there something more
> proportionate that we can do here?

I think it would be better to move the page_table_lock unlock call after
the hugetlb_remove_rmap() call.

```
        pte = huge_ptep_get_and_clear(mm, address, ptep, sz);
        tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
        if (huge_pte_dirty(pte))
            folio_mark_dirty(folio);
        /* Leave a uffd-wp pte marker if needed */
        if (huge_pte_uffd_wp(pte) &&
            !(zap_flags & ZAP_FLAG_DROP_MARKER))
            set_huge_pte_at(mm, address, ptep,
                    make_pte_marker(PTE_MARKER_UFFD_WP),
                    sz);
        hugetlb_count_sub(pages_per_huge_page(h), mm);
        hugetlb_remove_rmap(folio);
```

In __unmap_hugepage_range(), after all of the above code has been
executed, the PTE/TLB/rmap are all properly cleaned up. Therefore,
there's no need to continue protecting
folio_set_hugetlb_restore_reserve(), which only sets bits of
folio->private, with a page_table_lock.

Regards,
Jeongjun Park

