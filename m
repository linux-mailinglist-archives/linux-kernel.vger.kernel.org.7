Return-Path: <linux-kernel+bounces-805583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED76DB48A79
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FD61B22953
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AC92FB08E;
	Mon,  8 Sep 2025 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjAdAEiN"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E68299920
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757328307; cv=none; b=pQz7EH/DIC4kzAxuBT3JGez3XkepPnyXanuwupusGAw979yU7QKTywiW2o3cYh/xi8czCHN2MUBOAlXTqToqLFeL4eCj92hR3NzQm13B2LhlJ3ZyAtAvHUQmJ+ahJ28zNgxPQ6ptGyuUWxGCvURzfD+5VkY1TVFbVf4t38YmnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757328307; c=relaxed/simple;
	bh=dGLXUrLdA0m82TGJHtE/TORH3KjKTlsR1gMqlN4pjO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpnhwpKAWnkhOB+b15oFtUtQmX/c8gEJswW484yUYujHLrhsJAngq9kYXbHdxbYe272RNUCcoVD0FlrZ43rAWT/E9SvCPDjWfSXG2cYatyYkfu5YXzkEFyieldHH42+KaHPY8UAEJF42oX+JAP4DyJRwugyzRE5c9O8o9Ima/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjAdAEiN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b0431c12df3so731368066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 03:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757328304; x=1757933104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8uzPYfPNYGeJvmQoJWthwwS6JgMfzyknVaJ66+yIXA=;
        b=gjAdAEiNbEh41klpHDzScqx9eBlNrxIuc95U8TqUaINAAgx2r3MsDEX7ro00+6RbKM
         0fNKtYQebg9sZOW1YvaGUeaV/DeFmG2Fx7NfV20jQIro9cKt0LSXAb9QjNT3gUOOMSZF
         /6YKDhnP0sxqC8QHDJkQzi871SjyXaOk4FClrjvJJS03Rm9vIqr5ZIR81Hkp7r8oTnyl
         VqKCgY3Q/SYd87Opildv6dPru0wNb1RXu44ADA9d90GeXYoUqNNRv6G6qBQGvDw1JtBD
         2Z5NFmFtGOyLPlQDPsQssKsK2j5W07+m5vXiJ9nVJyX78+T4VV4x5y6Xb8u5CTpzMXfK
         /yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757328304; x=1757933104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8uzPYfPNYGeJvmQoJWthwwS6JgMfzyknVaJ66+yIXA=;
        b=XxsAKXF3mpmMAqvrNsDEagJVtJEbPUadGQHu+Qc+CTyYUfRIBdk61hXglOIP2O2BPO
         +j31BpSxZHF81GA4wkT4uwo7L/U/e9m7AYCrUMaIkL14ocCTdnS/mKmlEqh61WGF/fPp
         O/2MrA14VTlAgdEjug7SbFUiEkn9RoD5BHYE/68PKGo/77zTFyb2zhXZo+kivxV9QWSP
         hnikRvotwvH+wGOGJ6vlGH1O3vasUb+jaSIYEkR8PdmFTNWUx/kEQ/Jeg8Ap5xDcRKmn
         v27wVnw0uV42IW8eOnhrxnKUZLrPhe8qzjHjyTK9mPYiBzsXQtHtK40BP9Fmm55C22Er
         YA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2Ja2JlU1o9luSQN7f4+2PoADYk3fDGH93SuI82mX+xGtuzu/8+7dSoTiBCkj+fuhX0HovEjUrx3OEFtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32Mdc4J7KFeMQTe1DRNND/Dl93bmbJD3wHBA+4gAN1A6ZVYEU
	lFq+lBSfz2Xx1GfdEmvbvnKoVazNvljn/Zt+QlZ6q9UKeDBVQvNNcTv/TQXY91JGvU4wyxcg31L
	+YugmKnt01eAMIgAK/gUk0hQMNgJFKm0=
X-Gm-Gg: ASbGncuUJ0NUS0DRqMwm1YiW9M2oQQlFV7zMqSk8O66PHWHrcJDbK4CydQ1QxrliAgd
	TEMOvyfLV0FGRnbxsPika/lyp3ew4+R+eNRx6oOc/Ihco7MXjqL8ob5KZPjpSINepzt+HtZuIRi
	qQ0cvQ3EijqAiCtWI0FLnKzIqZxkIfUYts3vDxAZDl2J8DsXzeiR2Bp3Vaf0ZBFGys0hCWEJJEZ
	gW49i29Ygw=
X-Google-Smtp-Source: AGHT+IEhewhMF1EpxVTUIFmPOKbYonEWPpE/6YTG3sbgSQmH0PJZ4v8XEyZlCGfbHvMJoYe8Yg+2JW96OMUzuO27KoE=
X-Received: by 2002:a17:907:6d20:b0:b04:616c:d74d with SMTP id
 a640c23a62f3a-b04b0ffc2e0mr729393766b.0.1757328303776; Mon, 08 Sep 2025
 03:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-11-ryncsn@gmail.com>
 <f8051ae4-1b9d-42dc-8272-24a05741d86e@linux.alibaba.com>
In-Reply-To: <f8051ae4-1b9d-42dc-8272-24a05741d86e@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 8 Sep 2025 18:44:27 +0800
X-Gm-Features: AS18NWCW8pRyKsBkR6B2COyqewa1UrnxjCbNfAp-Uy2-QjOXMA35_nPtuyLlG9c
Message-ID: <CAMgjq7CQSGAhah8xwzJJUOLYEEQer63ZERsP6W-JVDCt4mSFMw@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] mm, swap: wrap swap cache replacement with a helper
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

On Mon, Sep 8, 2025 at 11:52=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/9/6 03:13, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > There are currently three swap cache users that are trying to replace a=
n
> > existing folio with a new one: huge memory splitting, migration, and
> > shmem replacement. What they are doing is quite similar.
> >
> > Introduce a common helper for this. In later commits, they can be easil=
y
> > switched to use the swap table by updating this helper.
> >
> > The newly added helper also makes the swap cache API better defined, an=
d
> > debugging is easier.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >   mm/huge_memory.c |  5 ++---
> >   mm/migrate.c     | 11 +++--------
> >   mm/shmem.c       | 10 ++--------
> >   mm/swap.h        |  3 +++
> >   mm/swap_state.c  | 32 ++++++++++++++++++++++++++++++++
> >   5 files changed, 42 insertions(+), 19 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 26cedfcd7418..a4d192c8d794 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3798,9 +3798,8 @@ static int __folio_split(struct folio *folio, uns=
igned int new_order,
> >                        * NOTE: shmem in swap cache is not supported yet=
.
> >                        */
> >                       if (swap_cache) {
> > -                             __xa_store(&swap_cache->i_pages,
> > -                                        swap_cache_index(new_folio->sw=
ap),
> > -                                        new_folio, 0);
> > +                             __swap_cache_replace_folio(swap_cache, ne=
w_folio->swap,
> > +                                                        folio, new_fol=
io);
> >                               continue;
> >                       }
>
> IIUC, it doesn't seem like a simple function replacement here. It
> appears that the original code has a bug: if the 'new_folio' is a large
> folio after split, we need to iterate over each swap entry of the large
> swapcache folio and then restore the new 'new_folio'.
>

That should be OK. We have a check in uniform_split_supported and
non_uniform_split_supported that swapcache folio can only be splitted
into order0. And it seems there is no support for splitting pure
swapcache folio now.

Maybe we can try to enable and make use of higher order split
after this series for swapcache. I just had a try to use some hackish
code to split random folios in the swap cache to larger order, it seems
fine after this series.

