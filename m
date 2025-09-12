Return-Path: <linux-kernel+bounces-814011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF69B54E42
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298EE18941D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC6B27E045;
	Fri, 12 Sep 2025 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAjmHX92"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335CD15E5D4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680639; cv=none; b=WAT/dAW3kJFHv9Zxc8Y6cqe3zbX/Af7Rlzu+9JRImG/guBl5yFprRB5V5FCykkhxvm5+focS1Hx9Y1s8HaJbE77ZXQ7w+qaZ3cW32EqXzxGyaadOpNtHk34tmW79qqVbXPRg5eomvtFpErqJFd4HohV040mLRF38FAAJBEJpowo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680639; c=relaxed/simple;
	bh=u7Wt5iH+99TvbKypv25kcEbhf8RK+DTPuRCkZ4Of0lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIHoYSUWjRjr2wWqNeYRULmH1RFAjUPuzvDsbBuxJWAsGaxLxPHBrGPNIjH1aXbTZd6Nx2Sa40VQYAi5nISAuFBsFUfej9k8n4XJyWVDjfzLokx1nUFJ4Njt1jtwgCV2J+g3TdD8SOdR+wt+Ijnp6yrtaW5fUGO1cYKhXVbWE1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAjmHX92; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62ed3e929d1so2157699a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757680635; x=1758285435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz/C46Psvq2kfhwsNdlDHKUjeKS7S+kzKfzTRC5fRVY=;
        b=kAjmHX92ZMasBZYNOP57qAUY1dRq1q5Oe28iEmrVQ/Dx2Dpfq+uWk1PD1xcoWNtQQm
         IpclsjvoPmJwLybLUsobdtksYenf5d4MScTbDWeCa1yy5Mv7EUCskTkUL+CpMV7tIcda
         T8siaB4hE79DRpcik61TOARt7qMbHgTHWpMKbTY1IKCFahEooJ4mYxr4Cq6DL8iBT/Bz
         NAVZSgd6gmxF33Ja0TwspVXVr8oEtSN9pT7yBpRh1AXKeiNES1hvspfXFca3RAwVZLDU
         q60DH01hOQCg6yAlmWdA7ViAizyrsY6DJhSmVhI3FqxUCJQlhHd3uO+3tGLn4dxYcGB+
         hy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757680635; x=1758285435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wz/C46Psvq2kfhwsNdlDHKUjeKS7S+kzKfzTRC5fRVY=;
        b=pUKC0OnPKdNvBmTLAygFGF6Ha+V971Ulx30I3vaiS2O0lvSKXOMx+9lqLB8xBPY/zJ
         /aRewFLAzuGGhxSp9Q4fnm/1isoXODrcLgforAbxgjX27VElcsfc8wj0DGlx/h7DOfpM
         XnkurX5+VgqbaVIqDs/2f6C4F6NchHUtDK5RSV+sTFaB7T0qS+RVwpsIM4Po+nOObp/Q
         a7dde+9JDn9SMgJGo1mTAxsBCNRJK9ZwI77Ab00iT9iUNBhFLS8UXKjphzNDvuFfqLxf
         2xtrsM4yzFtievw2wClqLYWOkLBtZ7Sl9zIITUkrGwKv+Nivyr8HRguIG38GUFWoS4DF
         cKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGgvHqy7+BUawDZqTkZi6oNg5S7AcqmY3cUG9kL90zKYtBQPIzeVPmpRBMVO088oy1Ozjf1Gno9ZUfh94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOrGpBScEQs6Wucv1X2wTMlilyeT5IT9KQPoFGDXxGA3lc4Ubs
	Ds1Yk0Ro2FeXDZhQT4aan6nldE4wdlgGPC7CNtYDxiQ83FTOxcOYJEe58MR2lmdorFR6fDF0zXz
	GOHE0/hNtmveV29MYUpr5DP2hlg2f8N8=
X-Gm-Gg: ASbGncsKO4j9tovIgu7TpOXb1Iq4lNcA8HzZ5aqigt0Nj2fqup04gSBbZPRrITzyyJ0
	vT1iNl6SKHMumCelaHA3yk4zWD+K65+AIc8wrsMkh7y/XfuZG85jqF3uSTJbTHelPjV9ow82BfJ
	WUUgnZ0yx6YilB95ja/MPkJ7KW5a94a1uwx3ngbSW7gjq7cJcxidZN/n9k/aCzNZ/dO5+6tGnks
	Vh0vjelRaKCSmzqjBz6aw==
X-Google-Smtp-Source: AGHT+IEXdJoJvW3GTomdscmZ7eiD9XOvoqY091+jg51jVcWuUMkqZA11LP10M+lC0ki/1IzqNTT94B4N5DH/ISeL3v8=
X-Received: by 2002:a05:6402:50c9:b0:61c:3c58:7114 with SMTP id
 4fb4d7f45d1cf-62ed830166emr2931032a12.20.1757680635204; Fri, 12 Sep 2025
 05:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160833.3464-1-ryncsn@gmail.com> <20250910160833.3464-10-ryncsn@gmail.com>
 <0cb2bc82-1957-4efe-8c85-8558743dcf80@linux.alibaba.com>
In-Reply-To: <0cb2bc82-1957-4efe-8c85-8558743dcf80@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 12 Sep 2025 20:36:38 +0800
X-Gm-Features: AS18NWAeWgoeKJ1UdexxXGmEevDezdhBN-_bRlXVKFhBYiOsW0JEwkek48tjQ-E
Message-ID: <CAMgjq7Bc6r2=BcAPCeVPcVJ_hP8bXTs_pya2fWg8ZL-vTG9SAg@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] mm/shmem, swap: remove redundant error handling
 for replacing folio
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

On Fri, Sep 12, 2025 at 4:22=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
> On 2025/9/11 00:08, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Shmem may replace a folio in the swap cache if the cached one doesn't
> > fit the swapin's GFP zone. When doing so, shmem has already double
> > checked that the swap cache folio is locked, still has the swap cache
> > flag set, and contains the wanted swap entry. So it is impossible to
> > fail due to an XArray mismatch. There is even a comment for that.
> >
> > Delete the defensive error handling path, and add a WARN_ON instead:
> > if that happened, something has broken the basic principle of how the
> > swap cache works, we should catch and fix that.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > ---
> >   mm/shmem.c | 42 ++++++++++++------------------------------
> >   1 file changed, 12 insertions(+), 30 deletions(-)
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 410f27bc4752..5f395fab489c 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1661,13 +1661,13 @@ int shmem_writeout(struct folio *folio, struct =
swap_iocb **plug,
> >               }
> >
> >               /*
> > -              * The delete_from_swap_cache() below could be left for
> > +              * The swap_cache_del_folio() below could be left for
> >                * shrink_folio_list()'s folio_free_swap() to dispose of;
> >                * but I'm a little nervous about letting this folio out =
of
> >                * shmem_writeout() in a hybrid half-tmpfs-half-swap stat=
e
> >                * e.g. folio_mapping(folio) might give an unexpected ans=
wer.
> >                */
> > -             delete_from_swap_cache(folio);
> > +             swap_cache_del_folio(folio);
> >               goto redirty;
> >       }
> >       if (nr_pages > 1)
> > @@ -2045,7 +2045,7 @@ static struct folio *shmem_swap_alloc_folio(struc=
t inode *inode,
> >       new->swap =3D entry;
> >
> >       memcg1_swapin(entry, nr_pages);
> > -     shadow =3D get_shadow_from_swap_cache(entry);
> > +     shadow =3D swap_cache_get_shadow(entry);
>
> Again, there are still some issues with the patch split. The swapcache
> related APIs replacement should be placed in Patch 8, otherwise there
> will be buidling errors after applying Patch 8.
>
> With this issue fixed:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>

Hi Baolin

Yeah you are right, I need to move these few changes to patch 8.

BTW I also found that the WARN_ON and irq unlock needs following fix,
the stats update need to be done with irq disabled:

diff --git a/mm/shmem.c b/mm/shmem.c
index 957e40caba6e..c4d491c93506 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2121,14 +2121,14 @@ static int shmem_replace_folio(struct folio
**foliop, gfp_t gfp,
        /* Swap cache still stores N entries instead of a high-order entry =
*/
        xa_lock_irq(&swap_mapping->i_pages);
        for (i =3D 0; i < nr_pages; i++) {
-               WARN_ON_ONCE(xas_store(&xas, new));
+               WARN_ON_ONCE(xas_store(&xas, new) !=3D old);
                xas_next(&xas);
        }
-       xa_unlock_irq(&swap_mapping->i_pages);

        mem_cgroup_replace_folio(old, new);
        shmem_update_stats(new, nr_pages);
        shmem_update_stats(old, -nr_pages);
+       xa_unlock_irq(&swap_mapping->i_pages);

        folio_add_lru(new);
        *foliop =3D new;

