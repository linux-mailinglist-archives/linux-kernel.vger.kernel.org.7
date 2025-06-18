Return-Path: <linux-kernel+bounces-691330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA61ADE36C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 08:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE9F172BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 06:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BFD202C26;
	Wed, 18 Jun 2025 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T6denvIw"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC421EB195
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750227114; cv=none; b=A/kejeXiBlECRlxnQQLGnCQCxLlfYDdQ8jZbzMnshz6y2qat5NNFSXR0jMnbOs+id/5JHFKr9rcaIWWZHzvTh/qCMX/Z9IU6+DpmGyHzfnoGzqDwP0MwmTlsMUNsOHN24VXfaG27ro4W2L+xt86Ll9JGJOJpJdWqsu5gOZImwcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750227114; c=relaxed/simple;
	bh=PV3RfHpZjCKWdH+IzxbEBNpRgM9p9sr1JimZBDuNOZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NV5CRAJtF45CcmH/dZlmmEsnUtu0fTqJ6yVC7YTkLckJ0H5BXximdkJG5eXkH//kkX/YnPSosRtWn2iR5ggheuLUeuI2HxPL1wVubK/IsEiQxP6S13E0qoLJ7kVsNOdHNVfERsFHYo0fxgBwnRB1kS1RHwcordTScjzTRGZFl5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T6denvIw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23694cec0feso13304415ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 23:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750227111; x=1750831911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn7q+LZ4zA2xL1SK3J/9rIfQd9cYihtR+w0HeyZNGvc=;
        b=T6denvIwaeieRz615Z90emzHCojhU5ZGPTOZOCYbeTIX3Cnwej8X7GLaVbt8CTg32S
         K+cbnnoirDrMk0eCao/ON58dYAdfu7s+VMA7NovymV8hJB/Rh5+vb1xOKhHle7Stm0NX
         6YvBLvlzZdYbzoFFOSArNB3wDiDKKvTyR7Z0eipMNnCM5MltYTzJl7Fhx/eJXoDZzaWW
         CuwhifO5PWm85OdhgBLfCY82waT4dpOetze/f5KpEuNjtRxnAkLDcGjfFkAPtbs+oOB9
         tq13UyDs5gdkElaIGc3qOSCp+b5nnhuyRV6TsgLgiGRLaBUjkKXb5zIdIUdyL+ixSjiu
         6/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750227111; x=1750831911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xn7q+LZ4zA2xL1SK3J/9rIfQd9cYihtR+w0HeyZNGvc=;
        b=fuAcjdfgbZ5PERdnb/RnCOoLtnQm9odtjvLGk+KuX+Q/OwwHZ7S4B3Fj8W8cR26mPy
         AyTePRHBHSPO9C2oVtVdCk3xwevjh+FUyRHLQ0hMXtHpTN38Bq9ufcQXkk05gUg0cqSy
         dn1skIEB+cNGjg58DF7rk74Fa6SS2LEApWNNcZvllrJp+mStLgQBCaUZCGZ1jMpL0cOP
         gZzZ0JzWoE4Q8RyQF+QMvZ1hKrpExj2IqAOMqXyD0s+wqd9yN6nmvZB5xkwrA1dBvlmF
         S03p2CH7cD/B5R5DWdq7skc+DSJzcHQH+va5oHCCYtANgIOzXyY8QjSu5fno8/vST7+o
         KlWg==
X-Forwarded-Encrypted: i=1; AJvYcCVona2MHKc9hEhUMtEodDZckCwuWxubozcPRhPUhxHT+JyjB3ilViz57hp9EEjz0i/GHnviCu8RhUDj6+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YynM3CK99kYECSnefHAjkoPOtYHGmMbCav1kqhFTjjz2qfCCxf0
	r09GFzdazfk/ioD2d29hZRz4ijiqk0IIOqD6EEIp++xsinC0vKUVEmK92RSmYShuItg=
X-Gm-Gg: ASbGncsoKjj5fCPv+Z05DHAhRXJ2xCjHFWWJ8VZrLJ6SVp4QbWEu+WFpEcAmXbfa0/g
	IeTBU4+9VlnY6VQVkXZr2ayVfnBNaB8fX1auhBMQeM9TeVQiicLLm21zOEeGFCqCDNpe8SD7FEC
	GgGCSu89Ci8/s87ksjV4H3E+E8/T5c+DrUeaQ5xCCusP17Wm+ATVkrx+iOREdoWHDpl6823/+Cg
	s5vL2Lcm8JZkhww0/C+1m5ZkbAmzoINwQ5ZyQK3v5ab7NswopuecUOSEFQQ/rxClyo91Ux2J0B4
	SVPYbayod0S6tmeh+yeo0cCjdEJkidkzPD/WovTh9jnpFRNjIJT/Lq1+i/RCehzOcwcvGHQpImH
	Ycnyk17BPsfFIQQ==
X-Google-Smtp-Source: AGHT+IE6QHqF5cRG4JjJmwec3MCxJQBktPbBLGT04dKoF50/oeGUlWRe2hxM1IPr9OMe35BOwAM1yw==
X-Received: by 2002:a17:903:24f:b0:234:bca7:292e with SMTP id d9443c01a7336-2366afe6223mr256773915ad.14.1750227110691;
        Tue, 17 Jun 2025 23:11:50 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a4d3fsm91393555ad.64.2025.06.17.23.11.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Jun 2025 23:11:50 -0700 (PDT)
From: lizhe.67@bytedance.com
To: david@redhat.com
Cc: akpm@linux-foundation.org,
	alex.williamson@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com,
	peterx@redhat.com
Subject: Re: [PATCH v4 3/3] vfio/type1: optimize vfio_unpin_pages_remote() for large folio
Date: Wed, 18 Jun 2025 14:11:43 +0800
Message-ID: <20250618061143.6470-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ce2af146-499b-4fce-8095-6c5471fdf288@redhat.com>
References: <ce2af146-499b-4fce-8095-6c5471fdf288@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 17 Jun 2025 15:47:09 +0200, david@redhat.com wrote:
 
> > How do you think of this implementation?
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 242b05671502..eb91f99ea973 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2165,6 +2165,23 @@ static inline long folio_nr_pages(const struct folio *folio)
> >          return folio_large_nr_pages(folio);
> >   }
> >   
> > +/*
> > + * folio_remaining_pages - Counts the number of pages from a given
> > + * start page to the end of the folio.
> > + *
> > + * @folio: Pointer to folio
> > + * @start_page: The starting page from which to begin counting.
> > + *
> > + * Returned number includes the provided start page.
> > + *
> > + * The caller must ensure that @start_page belongs to @folio.
> > + */
> > +static inline unsigned long folio_remaining_pages(struct folio *folio,
> > +               struct page *start_page)
> > +{
> > +       return folio_nr_pages(folio) - folio_page_idx(folio, start_page);
> > +}
> > +
> >   /* Only hugetlbfs can allocate folios larger than MAX_ORDER */
> >   #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
> >   #define MAX_FOLIO_NR_PAGES     (1UL << PUD_ORDER)
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 15debead5f5b..14ae2e3088b4 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -242,7 +242,7 @@ static inline struct folio *gup_folio_range_next(struct page *start,
> >   
> >          if (folio_test_large(folio))
> >                  nr = min_t(unsigned int, npages - i,
> > -                          folio_nr_pages(folio) - folio_page_idx(folio, next));
> > +                          folio_remaining_pages(folio, next));
> >   
> >          *ntails = nr;
> >          return folio;
> > diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> > index b2fc5266e3d2..34e85258060c 100644
> > --- a/mm/page_isolation.c
> > +++ b/mm/page_isolation.c
> > @@ -96,7 +96,7 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
> >                                  return page;
> >                          }
> >   
> > -                       skip_pages = folio_nr_pages(folio) - folio_page_idx(folio, page);
> > +                       skip_pages = folio_remaining_pages(folio, page);
> >                          pfn += skip_pages - 1;
> >                          continue;
> >                  }
> > ---
> 
> Guess I would have pulled the "min" in there, but passing something like 
> ULONG_MAX for the page_isolation case also looks rather ugly.

Yes, the page_isolation case does not require the 'min' logic. Since
there are already places in the current kernel code where
folio_remaining_pages() is used without needing min, we could simply
create a custom wrapper function based on folio_remaining_pages() only
in those specific scenarios where min is necessary.

Following this line of thinking, the wrapper function in vfio would
look something like this.

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -801,16 +801,40 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
        return pinned;
 }
 
+static inline unsigned long vfio_folio_remaining_pages(
+               struct folio *folio, struct page *start_page,
+               unsigned long max_pages)
+{
+       if (!folio_test_large(folio))
+               return 1;
+       return min(max_pages,
+                  folio_remaining_pages(folio, start_page));
+}
+

---

Does this approach seem acceptable to you?

Thanks,
Zhe

