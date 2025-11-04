Return-Path: <linux-kernel+bounces-884328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47694C2FE85
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A18481940898
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE29B312827;
	Tue,  4 Nov 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjZzRp/T"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595562BEC4A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244831; cv=none; b=N5gaNrBbNmNqowKyft7AukVZh2mPCWS3Bi4OrhSkvHI62YLQAGFpUng/zgjhPL8gZ7k54o7xyCi5+HVkgGSJnOFXDd3CQL3BYJ6WcUIx97NC51J7kotb3t4WHtsfebq7sgRJrhNjM2sZncZ0c9fZ3hoiSOKe7FCNsIJymmb0jMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244831; c=relaxed/simple;
	bh=tWqVe3wjMknEV0iwFQ51DPhjCYN5DnV9LRUBbfeGGFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfdVCAYSMV08X3V0fY4EshYe59JMNkVs9eoKQs9niB9iDgKIoxXdhjQzZ+bNrZagzQzL0/Yxws1EO89e/6qT+fcrnm5hLv1Z4e3C2SuN/DKYQXvuDfESHvFDJKIqmy0vXJ31vSNDhpvrKMDkLEtiDkZ4czVXjS05dAEKkwdNER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjZzRp/T; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed101e8496so37981721cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762244828; x=1762849628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dsl3eSPMGHDSeCMQfe8F9VblZgjTpAHCpZj1US9DKJU=;
        b=WjZzRp/TQ937s1Gg4bW2MzzK6FmhqLDy5HyljjLDwR7gSP4fn1N3nEis5DuZ0rrMql
         x3U8F3JYGhA1m1/9tQDD0JK6WYsjL8rfSq0yDFDvslBGnTYpxvr34s9v7mKjRgASkV/B
         FuPvfZ0iDB/VeruqEFN0lJsA0wtS19UQZ7ANpUQiYEqxgILDIqQBn7ZabiVmG17IuRd8
         rba4AwkJzfnpw9475WC1cZCukaNhbHgaRQLwkKe27dNliJo1F73XXfpMRcipqkXhAebX
         jiLghMyW71zJw1V7oZeNyFm7m+9Pd636Bt0IbBRdY8bI5WZhCg+HiORgN7mfkBiShCwi
         VdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762244828; x=1762849628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dsl3eSPMGHDSeCMQfe8F9VblZgjTpAHCpZj1US9DKJU=;
        b=Ap/1fUGKtfVVOmyvQVHAR/mxqYU18lA2QrpwsjMMrYELZIphKkvrnkX1VKp2U/EWyp
         42hAWopxvDo5J5j8wjY8OeyCruxKeNsLG/IVz4+7LYcLHOqObtD4zeHtC1zh5GEHrb3F
         AoaU274Zn6c3+gdemO/Y83KUClBWEeKJywgn+blku+OnWdImR4I/J+eXt+4sodI00dco
         AA22mnIcfM61J6hXBev11aMcUPIRE2HT0LisQVG5fiwwHqb+7Ef8Arp9wbR+OEv7cI5T
         rVjZSTYu/kKw1pc2U5FTSiGQuDTv9Ij2hpsHu6fWJ64Xd3Tt0UDzwyqwzCv/vgvBx3gX
         cshA==
X-Forwarded-Encrypted: i=1; AJvYcCUlHjTj5JwHVuOSrBMo8pP6bNjE+9IRCMSWxzyG4a1ZPD5UANKp7afDgcBoAo3RTY91HDrfnKgzNSl5ZK0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0x/kTNUxjfibpNU5NU+SNCQtfWeJMnxVj1jrqS6MGrqNt8kIY
	Wdpa+59KgdR6tg9emZRZsSCNGMcCfOdIpq0M3FZ9+3bFwEmzsi1EonShE7Lh4w48u1Pykn4RUuS
	0948VACglL/i4P0NF94pCtUg4bn0yHsI=
X-Gm-Gg: ASbGncuxDG/k5OsBuTIAj3sEpwdqefYyqstnLMQl9EqL+j9oX0QU098Ad1kJC4kIU6N
	u4247Dcrk8msoWOwIqenq8cgRNGkj6dfr7nllEyeecGTSSgKXhFeR2QpCVrK1tP7UkdiUC7/NKf
	Yzyw2WVpjGRkSIc02gcPJ7H4o1qA7fIm7ehZD4G53e8KmYOFkl7T2S9qGvCtaWSuqmRKCQ/zSvz
	Sc0V/uUe5se2ksXZKjjMDPbuS6cc191sCkjFso5Gk5XmaDVvqn7ESQby6hIjUEG5v0au1iSrDF6
	AmpOC+TN/ARho4Z1
X-Google-Smtp-Source: AGHT+IEKVcw2eH6PyJhOzgmbwq21XNi3dsg13Rpx8YePsUrKcKLMXD7+fM0/Ai7dsMB3cQA/RENWt65njrN+60ehur0=
X-Received: by 2002:a05:622a:8d11:b0:4ed:3e3e:a295 with SMTP id
 d75a77b69052e-4ed3e3ea737mr158504211cf.26.1762244827989; Tue, 04 Nov 2025
 00:27:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-4-3d43f3b6ec32@tencent.com> <CAGsJ_4xOd0CJLZvzvZu9mRLjVvV0OSKE8NcBAYe3wvHFtLjWyA@mail.gmail.com>
In-Reply-To: <CAGsJ_4xOd0CJLZvzvZu9mRLjVvV0OSKE8NcBAYe3wvHFtLjWyA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 4 Nov 2025 16:26:57 +0800
X-Gm-Features: AWmQ_bmuf89iPst2Ey-dfW5gYteUGfZvgjEHk6ux4Rp2snZpFJr3WPiwVrf2uoM
Message-ID: <CAGsJ_4z9xTd=oHDuzLbdkyhd_F=tj2A3K_dsp33dXad6pvVZpA@mail.gmail.com>
Subject: Re: [PATCH 04/19] mm, swap: always try to free swap cache for
 SWP_SYNCHRONOUS_IO devices
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 12:19=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Oct 29, 2025 at 11:59=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Now SWP_SYNCHRONOUS_IO devices are also using swap cache. One side
> > effect is that a folio may stay in swap cache for a longer time due to
> > lazy freeing (vm_swap_full()). This can help save some CPU / IO if foli=
os
> > are being swapped out very frequently right after swapin, hence improvi=
ng
> > the performance. But the long pinning of swap slots also increases the
> > fragmentation rate of the swap device significantly, and currently,
> > all in-tree SWP_SYNCHRONOUS_IO devices are RAM disks, so it also
> > causes the backing memory to be pinned, increasing the memory pressure.
> >
> > So drop the swap cache immediately for SWP_SYNCHRONOUS_IO devices
> > after swapin finishes. Swap cache has served its role as a
> > synchronization layer to prevent any parallel swapin from wasting
> > CPU or memory allocation, and the redundant IO is not a major concern
> > for SWP_SYNCHRONOUS_IO devices.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/memory.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 9a43d4811781..78457347ae60 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4359,12 +4359,21 @@ static vm_fault_t remove_device_exclusive_entry=
(struct vm_fault *vmf)
> >         return 0;
> >  }
> >
> > -static inline bool should_try_to_free_swap(struct folio *folio,
> > +static inline bool should_try_to_free_swap(struct swap_info_struct *si=
,
> > +                                          struct folio *folio,
> >                                            struct vm_area_struct *vma,
> >                                            unsigned int fault_flags)
> >  {
> >         if (!folio_test_swapcache(folio))
> >                 return false;
> > +       /*
> > +        * Try to free swap cache for SWP_SYNCHRONOUS_IO devices.
> > +        * Redundant IO is unlikely to be an issue for them, but a
> > +        * slot being pinned by swap cache may cause more fragmentation
> > +        * and delayed freeing of swap metadata.
> > +        */
>
> I don=E2=80=99t like the claim about =E2=80=9Credundant I/O=E2=80=9D =E2=
=80=94 it sounds misleading. Those
> I/Os are not redundant; they are simply saved by swapcache, which prevent=
s
> some swap-out I/O when a recently swap-in folio is swapped out again.
>
> So, could we make it a bit more specific in both the comment and the comm=
it
> message?

Sorry, on second thought=E2=80=94consider a case where process A mmaps 100 =
MB and writes
to it to populate memory, then forks process B. If that 100 MB gets swapped=
 out,
and A and B later swap it in separately for reading, with this change it se=
ems
they would each get their own 100 MB copy (total 2 =C3=97 100 MB), whereas =
previously
they could share the same 100 MB?

Thanks
Barry

