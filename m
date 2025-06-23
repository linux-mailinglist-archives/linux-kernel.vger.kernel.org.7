Return-Path: <linux-kernel+bounces-698933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EBCAE4BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 19:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA11189DD57
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5752BDC21;
	Mon, 23 Jun 2025 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aqRm8aGZ"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861562BDC11
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699753; cv=none; b=VCR+XxRRjm0u2cKPiQHWLUwQHjZHDU57TwLCKlxpBglTGFm8TOYCHHPbIfgRGMawn9IkuxaX5Qvojtnc5QgQUrtAPuZo1f4CDdIt6PQdhmhguJQCvsLr98EbfSm8if4svtWZLXJawr322CnqfAe5xLfQekA0jMs/gnZW3AVr3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699753; c=relaxed/simple;
	bh=9VJr66AymgyrWSqzi9KM6q7jBDUmUFepkatWROn4V+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aobof+quv/bEkID1k2kd67o0fPFLfcxVL2yDj7M7bYeR2O8TCG3nUdAo6ZdbHlvcG1+zQTCKvyMGER5XVddt4KEMtsMM/DmciOsx9ConBASmlBIjc4/sXStaR0Di4OTZG8oqQV1ScIkp4lGu3xpX7lAv61l71afgnJcNc/riBZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aqRm8aGZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-237f18108d2so13605ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750699751; x=1751304551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ih7l7aGR3GQBtt1mBj++NsVHfE7pPQqbo93fSE/REN0=;
        b=aqRm8aGZF/vuTwPC0skz775rJiLilO8+IWlpC1vtIwaVePWpr+CSxuLDs50i2D09yY
         +3TlOe/e+Qgff1iwuDso6/0Aj0c72cpQzU8YROj/QC60lJHYc6V9DJ5lh/WN8RAivVg2
         X2U56sNlyAf9gI21l9EZ/WElYMsUTbyc1viDHY0+362nCmcFL8xzq9W76uHdi2X8BDhM
         MtOzpil36fMlOC7LCw29fXi+iRR+5A3Y8QewFFwkCZuwdCdfoVkXfl2I3bjxWpOdmE38
         ELbuwDzNbY/49DtvBpSGgkzp1YTaRdDmRDM2GBYVqvPI55Wzf8VdoUa03v4dasA/wC89
         YTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750699751; x=1751304551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ih7l7aGR3GQBtt1mBj++NsVHfE7pPQqbo93fSE/REN0=;
        b=EzT7DA1PzkcGdPd2TuBLfRYgvYCa2VHZutTa5w/JQ/TND/z8/QOeE9M60h3XCjOW5x
         E9YmqzgLJfMOoWWOEydWYokP1ni6Dc+aml4euJ6OBldoTnfKv7AIF4VWomsjNsV0gkXI
         vRRScFk2yBkNsQ9vuLjOTFjTI6wLmefgau0VIf7GZ2X3d0TP39WvF8Z/k3qxnhjgeNsJ
         QxfiwqEKkjRUOCAiIakEjlNYgIFHr+SKZ75gqDkloXioLtZ62GylvQKC1/J9pB+lzxPV
         9EEkW01huYl+LYCsljVmYo8Y1vSKh3kYBp6iYc8nKps8oflcv/KG/j0h5RZFWBFdv4qS
         5yJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcotWjcOsq62wQcw7Pz9/6x4YFNMzczgL9kZ9JEsthjsRqgnEouUQhjgoLBkoaZ3aJtcSZaXy1Cvac698=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGiV2GNVDla54+NtQYuueBjJsG0jduaEasSPw974SgKK6FO5ZK
	9O4o8YoGz00QbT1EyeEZDvI2QDndWBPoUach6RF7Q5JweEVGYlzcnfny7IYKhBYYxBRjto5RZgr
	wl34VF6F0Iqf8VHLOTqm3FKNLxdXTMx76op7bQK8m
X-Gm-Gg: ASbGncvVNn4sWxwbJsJNiW3XXhJOiqv8LbQMYwMLxYG1nRScK5Jgu7O6y1CWCNErey2
	1i4cMhanjsWhJTjAiIO3tmAJ9JoUcKmB3W2d2V2nbZi0U98p9ZJ/0XInK+RMIl7LQep7yoS8cQ9
	ndO9oXx/QXUebmwde/iaA7dQ/azVwJlb1moQyxPm2G0FVz9shUoMTXKXIAeU7K7OYWJRXLjWnN
X-Google-Smtp-Source: AGHT+IHIz3m807Q22lF6oC6dBirj1kMW3oRTCSHc3amqhbrzf7C+H/Ag+dMxGhkxJLFATRZHjXv5ZTgwnpv8fDxM7rQ=
X-Received: by 2002:a17:903:1249:b0:234:b2bf:e67f with SMTP id
 d9443c01a7336-237e574becdmr4816395ad.9.1750699750291; Mon, 23 Jun 2025
 10:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620041224.46646-1-byungchul@sk.com> <20250620041224.46646-10-byungchul@sk.com>
 <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com> <20250623101622.GB3199@system.software.com>
 <460ACE40-9E99-42B8-90F0-2B18D2D8C72C@nvidia.com> <a8d40a05-db4c-400f-839b-3c6159a1feab@redhat.com>
 <41e68e52-5747-4b18-810d-4b20ada01c9a@gmail.com>
In-Reply-To: <41e68e52-5747-4b18-810d-4b20ada01c9a@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 23 Jun 2025 10:28:57 -0700
X-Gm-Features: AX0GCFtw51Pg4R-sTvdTCfrVPdo1Tdq4h4FqSXVGmxppvQKlqjgu8IQOHqwvWOA
Message-ID: <CAHS8izPRVBhz+55DJQw1yjBdWqAUo7y4T6StsyD_dkL3X1wcGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 9/9] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, Byungchul Park <byungchul@sk.com>, 
	willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com, 
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, horms@kernel.org, linux-rdma@vger.kernel.org, 
	bpf@vger.kernel.org, vishal.moola@gmail.com, hannes@cmpxchg.org, 
	jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 10:05=E2=80=AFAM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 6/23/25 15:58, David Hildenbrand wrote:
> > On 23.06.25 13:13, Zi Yan wrote:
> >> On 23 Jun 2025, at 6:16, Byungchul Park wrote:
> >>
> >>> On Mon, Jun 23, 2025 at 11:16:43AM +0200, David Hildenbrand wrote:
> >>>> On 20.06.25 06:12, Byungchul Park wrote:
> >>>>> To simplify struct page, the effort to separate its own descriptor =
from
> >>>>> struct page is required and the work for page pool is on going.
> >>>>>
> >>>>> To achieve that, all the code should avoid directly accessing page =
pool
> >>>>> members of struct page.
> >>>>>
> >>>>> Access ->pp_magic through struct netmem_desc instead of directly
> >>>>> accessing it through struct page in page_pool_page_is_pp().  Plus, =
move
> >>>>> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_d=
esc
> >>>>> without header dependency issue.
> >>>>>
> >>>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
> >>>>> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >>>>> Reviewed-by: Mina Almasry <almasrymina@google.com>
> >>>>> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> >>>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >>>>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> >>>>> ---
> >>>>>    include/linux/mm.h   | 12 ------------
> >>>>>    include/net/netmem.h | 14 ++++++++++++++
> >>>>>    mm/page_alloc.c      |  1 +
> >>>>>    3 files changed, 15 insertions(+), 12 deletions(-)
> >>>>>
> >>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>>>> index 0ef2ba0c667a..0b7f7f998085 100644
> >>>>> --- a/include/linux/mm.h
> >>>>> +++ b/include/linux/mm.h
> >>>>> @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct tas=
k_struct *t, unsigned long status);
> >>>>>     */
> >>>>>    #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> >>>>>
> >>>>> -#ifdef CONFIG_PAGE_POOL
> >>>>> -static inline bool page_pool_page_is_pp(struct page *page)
> >>>>> -{
> >>>>> -     return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> >>>>> -}
> >>>>> -#else
> >>>>> -static inline bool page_pool_page_is_pp(struct page *page)
> >>>>> -{
> >>>>> -     return false;
> >>>>> -}
> >>>>> -#endif
> >>>>> -
> >>>>>    #endif /* _LINUX_MM_H */
> >>>>> diff --git a/include/net/netmem.h b/include/net/netmem.h
> >>>>> index d49ed49d250b..3d1b1dfc9ba5 100644
> >>>>> --- a/include/net/netmem.h
> >>>>> +++ b/include/net/netmem.h
> >>>>> @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_c=
ount);
> >>>>>     */
> >>>>>    static_assert(sizeof(struct netmem_desc) <=3D offsetof(struct pa=
ge, _refcount));
> >>>>>
> >>>>> +#ifdef CONFIG_PAGE_POOL
> >>>>> +static inline bool page_pool_page_is_pp(struct page *page)
> >>>>> +{
> >>>>> +     struct netmem_desc *desc =3D (struct netmem_desc *)page;
> >>>>> +
> >>>>> +     return (desc->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> >>>>> +}
> >>>>> +#else
> >>>>> +static inline bool page_pool_page_is_pp(struct page *page)
> >>>>> +{
> >>>>> +     return false;
> >>>>> +}
> >>>>> +#endif
> >>>>
> >>>> I wonder how helpful this cleanup is long-term.
> >>>>
> >>>> page_pool_page_is_pp() is only called from mm/page_alloc.c, right?
> >>>
> >>> Yes.
> >>>
> >>>> There, we want to make sure that no pagepool page is ever returned t=
o
> >>>> the buddy.
> >>>>
> >>>> How reasonable is this sanity check to have long-term? Wouldn't we b=
e
> >>>> able to check that on some higher-level freeing path?
> >>>>
> >>>> The reason I am commenting is that once we decouple "struct page" fr=
om
> >>>> "struct netmem_desc", we'd have to lookup here the corresponding "st=
ruct
> >>>> netmem_desc".
> >>>>
> >>>> ... but at that point here (when we free the actual pages), the "str=
uct
> >>>> netmem_desc" would likely already have been freed separately (rememb=
er:
> >>>> it will be dynamically allocated).
> >>>>
> >>>> With that in mind:
> >>>>
> >>>> 1) Is there a higher level "struct netmem_desc" freeing path where w=
e
> >>>> could check that instead, so we don't have to cast from pages to
> >>>> netmem_desc at all.
>
> As you said, it's just a sanity check, all page pool pages should
> be freed by the networking code. It checks the ownership with
> netmem_is_pp(), which is basically the same as page_pool_page_is_pp()
> but done though some aliasing.
>
> static inline bool netmem_is_pp(netmem_ref netmem)
> {
>         return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) =3D=3D PP_SI=
GNATURE;
> }
>
> I assume there is no point in moving the check to skbuff.c as it
> already does exactly same test, but we can probably just kill it.
>

Even if we do kill it, maybe lets do that in a separate patch, and
maybe a separate series. I would recommend not complicating this one?

Also, AFAIU, this is about removing/moving the checks in
bad_page_reason() and page_expected_state()? I think this check does
fire sometimes. I saw at least 1 report in the last year of a
bad_page_reason() check firing because the page_pool got its
accounting wrong and released a page to the buddy allocator early, so
maybe that new patch that removes that check should explain why this
check is no longer necessary.

--=20
Thanks,
Mina

