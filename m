Return-Path: <linux-kernel+bounces-819974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6543B7C422
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E69962A8519
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 04:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A2D23D7EB;
	Wed, 17 Sep 2025 04:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOrigsEM"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151722367AC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084657; cv=none; b=DFSm8GMh9wNIiyORvrT29ugqgAROQ+QZ8AW75vSaVkRgsZne+20vYMCA34BM4Ob+KNuBTMGGVzod6OOtULeTP8dzdCqUHZ0FWhR/ot33xYvNOppdka/rorF8vGwrl0tYbquBqPskd3EQPbYeKepH5aGQ8HmYgCSXHW1g9pmDze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084657; c=relaxed/simple;
	bh=KcaYH/EMJc1VN5RmlOp3GJDYxoqnU2n0TRiOQzHOZeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bX3PKUhw3ku3M1DmTSIkjREpk9PvklHY/4JpPmwhzFlbi10Sr9n/jDA+nP54uipgr7BFf8Np+Pw/19Tyv7jfIgp9BgaXQ6phMSZTPwja/fR80Z5JxNLnaMt99KYMCT8XH7suXaSpWzJX1bXTeq4fqtZgASoOqUpWoTMsxjy8cSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOrigsEM; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-80bdff6d1e4so626240585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758084655; x=1758689455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXrprAAgFwNg+pFvYSf0/2T4yNRqYcxih/vGGHapvw4=;
        b=KOrigsEM0ixpR4bQfF5zDj39HpTRYy4+9ieNHP7Ha7Y1g2epeqad4rS/Lv++5ZZly6
         nx1woCSX/rBJ/h0DoHzxH7WumXa2OHt8+jxgc157xB9DnL7M4vZWfvwYQxMoUYGOBrgZ
         ejS44NI3cbSctiByqKBq59jAYl+5/KmBYyU6SDbP5DkwEBk7m41zJi78eB0EDvBO1ZnA
         X90Wyi1/e3zohZaQNRsPGQMcWKYGs++B/94RPlpIgSobYhPCdPnSpJAspoUyYKDpg53a
         OSBam20GHsWm1N4z9jJVbT8MayCUDkgtbey2uxWZw7FYG4sO6SokFJwibrm/eIlInxHf
         QJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758084655; x=1758689455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXrprAAgFwNg+pFvYSf0/2T4yNRqYcxih/vGGHapvw4=;
        b=I/eT9NXrVmqrMIXgj8+gymenvbbkoE4mOFDv/I03PuZTNF03PlGwX138gUf0hkr2aS
         qH+Y/rJptLaqQWQIQLK5Wx5aXBgTPI/EeKidrj8ut0bd8UvQtcRsfN23YUweOq44SU2I
         GSr+sBPKRVgcV+QnQMfvQYhz2C0qKXFVEIO3Gm3ZCms16mKi2LXzaxKDPwjjlyYS518O
         jG4EbC3ifhz2OzUV9BgyeLmTIrqQHC9WzzV7oH+SVLgnrUc1Ws4JTVulkCwgoEsB/GMe
         UVJYKyPm2RncrYMSFsHwFnMlsp7VYVk9DSZ+cfn0BNs1Nf+Tc39+4TvS/5rIpJ23sG9b
         J3lA==
X-Forwarded-Encrypted: i=1; AJvYcCWEZjVidlGE7ejjcsLenerEMW6JwnSV57YE3vYSqbbyqGglcpv9Y7oTslLeFwyUfV6MuYnWe4rH7ubnrXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRylM4gnZntxCIb65H53pGe/tbejZ4i0ErVLxcqB/R00zHR2Xr
	QCyWGupMBIHJgeL2dePNwKKXGuqAINFOkwKSoj37sFWB5szAhNXFly19Jp4n/CIhVS5HSleg2/e
	sHGHSCMv2pPmxwvQDm/T2o9jlCxh2tSo=
X-Gm-Gg: ASbGncvoSuSb9NJyr00B2bxIktn6/jkW7IX4aUK6ewv7RY9t8kAg8CYE6Asi2Xbqith
	gcM+uXdL0sw3zfv7j9Gm2hY8/6SP9T47J4VY4wE3J9ZZUdQHJhSlqJnw3gOLJTfqlzCf1d5PIEs
	3cN+Di/ErdKDwUDda6unQNsafJjAVkXfAfchmQbla5Idi5SVsskX3Zy1VRyNiIhRaErtMUgoA2i
	nQ/MODPje/d3SiJ5hyJFquciUm42bOheuMKKtmZeQ==
X-Google-Smtp-Source: AGHT+IFKJ8xQpx4x8yXEa5+IOeW7FFAAV7YSxhGyg1VBCB4k9GdA4brglljsJuH7OXc84cuVlwYZpboh7wIUOPsKlbw=
X-Received: by 2002:a05:620a:700c:b0:80c:e95f:8a54 with SMTP id
 af79cd13be357-83108e4cd45mr76256485a.29.1758084654868; Tue, 16 Sep 2025
 21:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-16-ryncsn@gmail.com>
 <CAGsJ_4yrDFAe-3sMj1K2JeWrqNXCBvYvULY06b6B3ogSYjqasg@mail.gmail.com>
 <CAMgjq7AJ1=ji4iw03JmdN07MpY8V0CFdtUHpF58mTnSjGf=rGA@mail.gmail.com> <CAGsJ_4wH8ATOQLodxm7fEZb7Nt0oCxeyuiiUcf3ZYBpyC0kiFA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wH8ATOQLodxm7fEZb7Nt0oCxeyuiiUcf3ZYBpyC0kiFA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 17 Sep 2025 12:50:42 +0800
X-Gm-Features: AS18NWCiSnRJzKpUj8fDfFvjwQx63dGbAKROP5LujvWrwk9OWlY3tSO08qEUO-A
Message-ID: <CAGsJ_4xuV3SsJo0qN6HZxcJMAb2KX8UzZmrYkduLyKn46BrGQw@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] mm, swap: use a single page for swap table when
 the size fits
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 12:41=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> > >
> > > > ---
> > > > +static void swap_table_free(struct swap_table *table)
> > > > +{
> > > > +       if (!SWP_TABLE_USE_PAGE) {
> > > > +               kmem_cache_free(swap_table_cachep, table);
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       call_rcu(&(folio_page(virt_to_folio(table), 0)->rcu_head),
> > > > +                swap_table_free_folio_rcu_cb);
> > > > +}
> > >
> > > Can=E2=80=99t it simply be:
> > > virt_to_page(table)->rcu_head ?
> >
> > I'm not sure if we prefer folios when possible?
>
> Not sure either, but even Mathew still sometimes suggests using PAGE:
>
> https://lore.kernel.org/lkml/aLrrQDCBzaMwwmA-@casper.infradead.org/
>
> BTW, "(folio_page(folio), 0)" looks quite strange. I mean, why is it 0
> instead of 1?
> Although we know it=E2=80=99s always one PAGE, 0 still seems strange.

I mean, we should always free an entire folio, right?
It=E2=80=99s impossible to free just one page from a folio unless we split =
a THP, etc.

So it seems more correct that rcu_head should also be promoted to the folio=
.

/** @rcu_head: You can use this to free a folio by RCU. */
struct rcu_head rcu_head;

Definitely outside the scope of this patchset, so not a blocker :-)

>
> >
> > Either way is fine, they are identical for this use case.
> >
>

Thanks
Barry

