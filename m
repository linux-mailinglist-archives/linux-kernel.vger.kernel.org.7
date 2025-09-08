Return-Path: <linux-kernel+bounces-805589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 701D9B48A94
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A711B24DC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F79222594;
	Mon,  8 Sep 2025 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F8UZ8Jzb"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA51189
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757328834; cv=none; b=UDRi3wBqEFdXYboYmM2LJa/d4DG+ccdLbk5hmAR5eiu4GG0fTHvKeUosMrS0370GKBgV97ZVnB0k9N4dBcxjerTBEcrRhanbozfmRqB+GCjQFW7jPEvgLondc64u+ZmvA+yiDMGtOea/q04oOV6dchnJbzK2T8K9Y9o3lCJtV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757328834; c=relaxed/simple;
	bh=XWH35Iuc4hlF1ItoaeYoOfiJpKdag0v0G7DIFDe9bB0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o6E11iZNZBCJnP11lstiJzBNxBrMmDeqNxNapFImeazmQInQPP3idYmPbjVbBAzRGJ2i1k6Pn8toN7R4TX4qVbFHNnY0uHe3wmhoBDOP0OYnw6HV8fidpvQ50wR22hJLtb/MCxEPIhq6CptQ9L3ecsQnekBpAW7i4AH6wdeGXP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F8UZ8Jzb; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d6014810fso38382907b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 03:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757328832; x=1757933632; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hgsaZMjtQ1nfPWVLymR5YRqCNScFdlNY/fedrrZ30qw=;
        b=F8UZ8Jzb4EfPPqFT6aLtWHd3kFFFd2yeqIRI+skrfLgblCsPKbz3azVlIZwP7BsTR3
         yAj5NIwTclEsqb7+vcK1fOr+E6bRI9DvTnPlMPv+Og7ChyTdd2ntlnBY+i4ZMIHeOaZ6
         YTeCEoIleK1gM8PtoRuydRXqafC3q0o/eseOSoZMoDgTwt6WUnoIjr67kS35pt5j//YU
         MWWUCVqQNF8uNVZYicdEdN0CzwNpUxgGA31GsrptJHEy+kiZPJLPxnUd+cxdcNOG42hL
         vG+Y715dNvAqTgzOWrur4AzkeGAdzT7xW0Y5T/Rqlx2gYoQkeHj2+N6KRTMcZJLdKa8/
         DZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757328832; x=1757933632;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgsaZMjtQ1nfPWVLymR5YRqCNScFdlNY/fedrrZ30qw=;
        b=NyXuZq8cknR89/zWSqY1kpuUMbCjrf8/hC5TcaEZKOMNgkqRyZtcoT3AXEPzZvJb+7
         zt3CYHO48RB2Fa/cVRV7W96aTCRxmyjMoVj3eOkZOgFbQhFcACXS3rrkEtHlfVuXInET
         XBzZ7jn1+UbsNqsU3EorDeR3yELmmux7ST3Qra911AB9r8OEaGo/3mZIrkWMYrulIQo5
         XC/Sqtl9l6M/+iAndsu4M/yiYgdQ3DrUj+6waIJLm+cdwriIIu36OESUF43P/mWF8HnQ
         cYAdKFnJsrS0q9PDp1REbUMPnoxm2M6Zlw51LjIZCVSljrCzSFZ5gFpw77lbqZnEhwSx
         dzIg==
X-Forwarded-Encrypted: i=1; AJvYcCXH+50WFsm1nfpnPpU7MrSZK0PqTAz9O39Ak8pxJsv73AcVhs7AfQagCfN9BAVHtUya/xZgAzU6VWe/U8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDET8pPu0QiGnGkQo0D8S7Kyz1odGBHe2QY2mwh2GLpijzFtb
	RD87dVNOSwpXd5LvBoSeo9NKWOeDR5UqZXEiSqEM0XzvXo65fzAXsQFIzJFvNVB8hw==
X-Gm-Gg: ASbGncsBhWlDpYTnM+N035XKwzOvpoBnRHZGKYZmmZ15uUBYrBA9shUKeAAf3QMMuHM
	noPUl31yYJUCPtA/1NycdEuP6snGiseeaJCxDJco/djFwNwVxPoxM5qmv+hirjuxy5KiRulXfez
	lC28iFTdmJQwDv20mhbLnmZ/zOILVOmCHdGQamZnR7vmDV8PQLhZlz2tfl2dtQ8HGT+ccen36En
	0uv6PRuxuwZdgCXQfVprEVci4ceXKC7mZSHcOz+ngv6cPdvvoVaonlLpytrSvRJit14UANqLbof
	iMSTcUH3FI663xD457cjyatmjHxdgdG5frxrA8tFZ2le1xFzyywCOLd1JuDRZeQqO5XpH9jXBkG
	WZp01G3ea3W5cMfXRxfdOwVxSxIPriTyoYXnxOxeBKvc9CpYRNyUjSCo6ZQyq9p2/vxDf0G2hOz
	20Z7soc6ff/Qlp70nit8Srl3I4
X-Google-Smtp-Source: AGHT+IEKWzx9Hc2XCk5oIcV+B3S/rNO3qOJ8GVrhjQ0LXcFxCv/BtadhhiEaA1CrBuEKAraRp6Gazw==
X-Received: by 2002:a05:690c:940a:20b0:729:df2d:4a23 with SMTP id 00721157ae682-729df3c9addmr27962547b3.32.1757328832031;
        Mon, 08 Sep 2025 03:53:52 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm52211527b3.28.2025.09.08.03.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 03:53:50 -0700 (PDT)
Date: Mon, 8 Sep 2025 03:53:48 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: David Hildenbrand <david@redhat.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Will Deacon <will@kernel.org>, Shivank Garg <shivankg@amd.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Christoph Hellwig <hch@infradead.org>, Keir Fraser <keirf@google.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
    Frederick Mayle <fmayle@google.com>, Peter Xu <peterx@redhat.com>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Alexander Krabler <Alexander.Krabler@kuka.com>, 
    Ge Yang <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>, 
    Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
    Konstantin Khlebnikov <koct9i@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH 3/7] mm/gup: local lru_add_drain() to avoid
 lru_add_drain_all()
In-Reply-To: <e3922760-b074-4d5a-bf4a-9d7cf7f5f914@redhat.com>
Message-ID: <b2aca727-ecb8-5429-e418-e8bcbc8df070@google.com>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com> <165ccfdb-16b5-ac11-0d66-2984293590c8@google.com> <e3922760-b074-4d5a-bf4a-9d7cf7f5f914@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 1 Sep 2025, David Hildenbrand wrote:
> On 31.08.25 11:08, Hugh Dickins wrote:
> > In many cases, if collect_longterm_unpinnable_folios() does need to
> > drain the LRU cache to release a reference, the cache in question is
> > on this same CPU, and much more efficiently drained by a preliminary
> > local lru_add_drain(), than the later cross-CPU lru_add_drain_all().
> > 
> > Marked for stable, to counter the increase in lru_add_drain_all()s
> > from "mm/gup: check ref_count instead of lru before migration".
> > Note for clean backports: can take 6.16 commit a03db236aebf ("gup:
> > optimize longterm pin_user_pages() for large folio") first.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >   mm/gup.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 82aec6443c0a..9f7c87f504a9 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2291,6 +2291,8 @@ static unsigned long
> > collect_longterm_unpinnable_folios(
> >    struct folio *folio;
> >    long i = 0;
> >   +	lru_add_drain();
> > +
> >    for (folio = pofs_get_folio(pofs, i); folio;
> >         folio = pofs_next_folio(folio, pofs, &i)) {
> >   
> 
> Do we really want to drain all the time we enter
> collect_longterm_unpinnable_folios(), or only if we detect an actual problem?
> (unexpected reference?)

It looked nice and simple to me (hmm, where's the blank line before
lru_add_drain() gone? weird, something wrong with my mail setup),
I've never avoided an lru_add_drain() before; but you're right,
we dom't need to do that every time, fixed in v2 - thanks.

Hugh

