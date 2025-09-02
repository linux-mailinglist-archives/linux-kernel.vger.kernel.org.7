Return-Path: <linux-kernel+bounces-797476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C047B410E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C387205B6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1504A2C11C9;
	Tue,  2 Sep 2025 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acVDJz1M"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9526D4E2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856669; cv=none; b=ubnDdSoqBVU/j9hsysig5MjmsaP5PgCJhjnxNzuCEF3kU+zziqcfbRaYNZO5nGiTggn6NgskIZ+5Zc3JM0MALUk9qckmtwAv7bfor/M6s/d+DCW0JJqK4nYvDxa/53l5syb4zxQLRvkqgrtNs4ZuqD+3KBG+nmW2RJEXuV/ThKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856669; c=relaxed/simple;
	bh=LO4f64pAYv6PjEhPIN0MCU11QZCpum0wrzzfA3N+i5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oy+0YZdahY6k8xcoZT9paOu8fdMylossIp/QbHQdwlK16eHeQBS1snYYMd1JERLZ0K5UrShQs6sK01jPoW1uE54SCjPPr9ZcY0C7RwZhzghdWshruowsHKY3Bv5C0lMfkmjxFYS6CJbfeNOybNmLlribz5CQlstMKz2v4GrYbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acVDJz1M; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e870689dedso359206585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 16:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756856667; x=1757461467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4gypALbh/DCtbuR4Owfnzd4p8s7lS4q6xKY8wUJafA=;
        b=acVDJz1M6KLJxGtduGVu1tzLJf/cYVgcQ4WpuIe0FVn95Vtb7VYnetGF42iHbsW3++
         pbKYi/5qsUOP37BesKyGixlfz2HkQdy+zz+DWw1JoS3Hjj7NIGEctTjoChBIegMNiWEr
         tQKk+7ZtDA3zweHiZd9KXRKb00CDc4i9Q7vEwXBwxhZUlAeULaUkuJd+64HWR2G5h2F3
         bmlH7XamLLJjzS+Tn565WI4uBnmC4istnCpVKZqWq7128X4pfA5DYrUCtagdfNl1Hmjs
         fSAJRKqnjwqywIh/hDhui64isF4CthSacXVJkXrJj81/guMfeRaOiVV7G125FicdeOr8
         f91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756856667; x=1757461467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4gypALbh/DCtbuR4Owfnzd4p8s7lS4q6xKY8wUJafA=;
        b=XRbx+O6qe2CpE89HQIjsFj3ZarP2UZsfsOYqfYBTg4HWWq/nWE+2prxgEWC2UALAe3
         w8TsdMiqsXTlGrF+4r46frwX0lcUxnVK52E6BTGjf/bQZCjEtcuik+qHS4I0TXnwLUol
         mGJcEBfxJokh38NMHW1YLrkWzhcH7GtZdEZQ/hGH5JTApEInDOlW2mzkVSnNOkgryVS9
         0fUErqqTB80dhxU9P/h328xyaJT6+Dlzoga9PZL9BFFf4JQtn8hw+WsAgB6GATDJXJWN
         a26v6Pb2DQ2hgQRRl38v5z8DfgoSFK+5eaQ0riko0BQsZPEK8sA8IIUTwFphJ8JmEcMj
         u6Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUtSIIqxF/4ozbGf6qsjl9oPjAXdrcaCa7XOXDoxeMJtxWlQXvZsehMZLTsyWK7jxxN1pGecgnPR4nLZHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CfJaYMOrL88bwNR0X0LM+D+p6MJAGLbPc1VObI/eGw/Cg2eO
	GulDLSwJc7RbOanvS594ljN0ASW/68v7Yv1j/NKe42VLixg6t3/mtroBDuzt0RxcCY5Runcp2Sg
	fANqH39xX0rU7dBqRxIrUHR2ATLbccqo=
X-Gm-Gg: ASbGncteUe2Z3IVVYKHN/px4lT35u9CG3+iDdk4zoHOSo7W59DDTOuMqOWFOosUVEtS
	LXD2I/VIja72KKFdT1hVeV1lMsm/Z57m8xBy+eXkR628YaJXBcqOpHVo26YHyR9g96kNjhyvxxW
	Sgq/mpTKuEgDX/U1KFyoe0gWVHI7PCEV5EAKaMk+JlgwLq/UJRYWuU5S8c0mSjHCWxwPgChSF+o
	2XRgg/sm+QlNWKCTg==
X-Google-Smtp-Source: AGHT+IFsE+UUzTBnEhjz0fAD1lCkgGhafZx1Kl233Yf1560jOjMGEvqXgAj1E/rPotR+43710igd/8m1XiVQMmqan2M=
X-Received: by 2002:a05:620a:1a8b:b0:7f8:c51d:f42e with SMTP id
 af79cd13be357-7ff21df26a3mr1479006785a.0.1756856666709; Tue, 02 Sep 2025
 16:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-7-ryncsn@gmail.com>
 <CAGsJ_4yRa65ogB0d90LmtOigGTqQ9mM-eUU6VbmcX63j6vgHEg@mail.gmail.com> <CAMgjq7A5Gr2V9TDFg=_S+SjZ1r1gWXTtRGNofuzAgWNYLMW_DQ@mail.gmail.com>
In-Reply-To: <CAMgjq7A5Gr2V9TDFg=_S+SjZ1r1gWXTtRGNofuzAgWNYLMW_DQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 3 Sep 2025 11:44:15 +1200
X-Gm-Features: Ac12FXzzAbYcUk6ci8hyrQxV1ebiNF8fm7FKUh9xIW9YZAjH0WxMp39hD7KyfgY
Message-ID: <CAGsJ_4w7iV0YU+sXdYPrzqXAdaLncoP7bnGx8ELcpETL6y+cOQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] mm, swap: use the swap table for the swap cache and
 switch API
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

On Tue, Sep 2, 2025 at 11:59=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Sep 2, 2025 at 6:46=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > > +
> > > +/*
> > > + * Helpers for accessing or modifying the swap table of a cluster,
> > > + * the swap cluster must be locked.
> > > + */
> > > +static inline void __swap_table_set(struct swap_cluster_info *ci,
> > > +                                   unsigned int off, unsigned long s=
wp_tb)
> > > +{
> > > +       VM_WARN_ON_ONCE(off >=3D SWAPFILE_CLUSTER);
> > > +       atomic_long_set(&ci->table[off], swp_tb);
> > > +}
> > > +
> > > +static inline unsigned long __swap_table_get(struct swap_cluster_inf=
o *ci,
> > > +                                            unsigned int off)
> > > +{
> > > +       VM_WARN_ON_ONCE(off >=3D SWAPFILE_CLUSTER);
> > > +       return atomic_long_read(&ci->table[off]);
> > > +}
> > > +
> >
> > Why should this use atomic_long instead of just WRITE_ONCE and
> > READ_ONCE?
>
> Hi Barry,
>
> That's a very good question. There are multiple reasons: I wanted to
> wrap all access to the swap table to ensure there is no non-atomic
> access, since it's almost always wrong to read a folio or shadow value
> non-atomically from it. And users should never access swap tables
> directly without the wrapper helpers. And in another reply, as Chris
> suggested, we can use atomic operations to catch potential issues
> easily too.

I still find it odd that for writing we have the si_cluster lock,
but for reading a long, atomic operations don=E2=80=99t seem to provide
valid protection against anything. For example, you=E2=80=99re still
checking folio_lock and folio_test_swapcache() in such cases.


>
> And most importantly, later phases can make use of things like
> atomic_cmpxchg as a fast path to update the swap count of a swap
> entry. That's a bit hard to explain for now, short summary is the swap
> table will be using a single atomic for both count and folio tracking,
> and we'll clean up the folio workflow with swap, so it should be
> possible to get an final consistency of swap count by simply locking
> the folio, and doing atomic_cmpxchg on swap table with folio locked
> will be safe.

I=E2=80=99m still missing this part: if the long stores a folio pointer,
how could it further save the swap_count?

>
> For now using atomic doesn't bring any overhead or complexity, only
> make it easier to implement other code. So I think it should be good.

I guess it depends on the architecture. On some arches, it might
require irq_disable plus a spinlock.

Thanks
Barry

