Return-Path: <linux-kernel+bounces-771603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A69EB28944
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519DF5C1A44
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E1E1400C;
	Sat, 16 Aug 2025 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbOy036g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8728FD
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755304238; cv=none; b=ZCIT4+QR78kMARhhIx2H9gRZWjW5fn2owiD1s+DkcMsPXnLD6HnAxw7mrnzBSUmzuI0CnQIJQqHJX7VeG8VlY7TAYZB2dE0FRdXJqST890ozCl47XEWQWvrNnO/jRCMMj+M2hw2JcmF/ZfzdfpcD1flxEYD4OWRsw0a//6b0UW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755304238; c=relaxed/simple;
	bh=Z5e3w81i1QYEjP2t4DR+Nh/faS/BI9gAJ1KAWdhNjqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgR6JDKcghmnivozk2ovhdm/MYc0JzqC7n76tePLckPKlmF10GlWOVbsOxOXsymBVfX/oAwFWhSpPJVdEKiPkUKll31lgoy+Iw1zrrRhkQaFQdC19YebxZc8QtfLLizc8+raBwRi8njchSQWc+LGUV0btk1y3cgEBtbX3ey+jaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbOy036g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBC0C4AF09
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 00:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755304236;
	bh=Z5e3w81i1QYEjP2t4DR+Nh/faS/BI9gAJ1KAWdhNjqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mbOy036gTA6uXt69BED+6kidCAvFSV1H3+OfV++/w00gxVooz5YyVtVozeEQN/v/R
	 6fgMJAmY9vN7XK9t0nq+DClyGZccgJcR8bloRVs4AJtVuj69UhVn/AINnnp12JI9bd
	 wbKBeRaLkXtjITnSimWc5x0vXeS6MhiAh+2SSft4E8aZkz6lr5pinbAG+YpMuCLK8M
	 uXAxEbKENW5VE1a9gHF8pdV0mcJA2W/UOLm+8+mpR8NN8alQl5YIrCbfhkmy3WtGy6
	 ER8Xn49w8T504uYmZZ11If2BcYm+NokAXqNf4KMEOZXyaE/iclQTbLQWBmS0mE3aa3
	 1L2wnT17FdcoQ==
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459fc675d11so14125e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:30:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtF6+x2sZjKj7JGSbKGn5pSe1fLwrdGj4mK8MZasZyRVEqAK9UPkGYx5znFxl7zdSD9Kn8BMM7wMMhTcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyooo7tex48wApR1VxVtv3CjBgyddQzIWHmb+Qiy4KCSUd6dHxB
	hn5GzU2vH8mgM6lSuuc3KhxsTJuTNobedWHfecNucIl6bRXkyF8oblLJzCHXnP3bqGhHKS0bRqW
	ADaLXug+YbsPZcwloYkzMitUgyN3/WZhXN6/5wkNf
X-Google-Smtp-Source: AGHT+IFY1WRQdcnftxzS1o7/PUXOH44z2VYljrz9AIM/qLWltmOGHmMdSv3FrUflxQ5d7A923+VD54FYU6oDpi6eFAw=
X-Received: by 2002:a05:600c:4f0e:b0:453:65f4:f4c8 with SMTP id
 5b1f17b1804b1-45a26efa874mr355735e9.3.1755304234618; Fri, 15 Aug 2025
 17:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
 <20250813182024.7250-1-sj@kernel.org> <CAF8kJuONDFj4NAksaR4j_WyDbNwNGYLmTe-o76rqU17La=nkOw@mail.gmail.com>
 <CAKEwX=Mtu3KyNUv_oWFo9vNiWKkmbzMXmG3t=XgpVtG9C_v2mA@mail.gmail.com>
In-Reply-To: <CAKEwX=Mtu3KyNUv_oWFo9vNiWKkmbzMXmG3t=XgpVtG9C_v2mA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 Aug 2025 17:30:22 -0700
X-Gmail-Original-Message-ID: <CAF8kJuO3-Wuf567cLmudG9+ioaB+u8Yt7EiFaMMROK8R-2KCUA@mail.gmail.com>
X-Gm-Features: Ac12FXwN9TsUI5EtBxH8CEorrxtYJMzJGqp57urXPhBGDcsYR-3AyDVGZvRJrUs
Message-ID: <CAF8kJuO3-Wuf567cLmudG9+ioaB+u8Yt7EiFaMMROK8R-2KCUA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Nhat Pham <nphamcs@gmail.com>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:09=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>

> > Keep in mind that is more than just metadata. There is another hidden
> > overhead of using zpool to store your full page compared to directly
> > using the page.  When the page is read, because most likely the zpool
> > back end is not at a position aligned to the page. That zpool page
> > will not be able to free immediately, those fragmented zpool will need
> > to wait for compaction to free. it.
>
> It's been awhile since I last worked on zsmalloc, but IIRC zsmalloc
> handles these pages PAGE_SIZE sized object by just handing out a full
> page. I skimmed through zsmalloc code, and it seems like for this
> size_class, each zspage just contain one base page?

Yes, they have to be full size for the page class that contains the
full size. That is exactly what I expected. What I previously
mentioned the page might be fragmented and not able to release from
zpool is wrong, now you mention it due to the full size.  That is also
why I make the other point that the ideal cut off threshold can be
less than PAGE_SIZE. e.g. after compression 95% of a full page, you
might just as well store it as uncompressed. Those 5% will waste in
the class margin anyway.

>
> (check out the logic around ZsHugePage and
> calculate_zspage_chain_size() in mm/zsmalloc.c. Confusing name, I
> know).
>
> So we won't need compaction to get rid of these buffers for
> incompressible pages, at free time. There might still be some extra
> overhead (metadata), but at least I assume we can free these pages
> easily?

Maybe, or steal them into the swap cache.

> > We might still wait to evaluate the lost/gain vs store the
> > incompressible in swap cache. Google actually has an internal patch to
> > store the incompressible pages in swap cache and move them out of the
> > LRU to another already existing list. I can clean it up a bit and send
> > it to the list for comparison. This approach will not mess with the
> > zswap LRU because the incompressible data is not moving into zswap.
> > There is no page fault to handle the incompressible pages.
>
> We can always iterate to get the best of all worlds :) One objective at a=
 time.
>
> BTW, May I ask - how/when do we move the incompressible pages out of
> the "incompressible LRU"? I believe there needs to be some sort of
> scanning mechanism to detect dirtying right?
>
> >
> > > slightly improve it for incompressible pages case by skipping the
> > > decompression.  Also, if we take this way, I think we should also nee=
d to make
> > > a good answer to the zswapped-page migrations etc.
> >
> > Yes, if we keep the store page in the zswap approach, we might have to
> > optimize inside zsmalloc to handle full page storing better.

Sure. Ack.

>
> I believe it already does - check my response above. But I can be wrong.
>

> > I slept over it a bit. Now I think we should make this a counter of
> > how many uncompressed pages count stored in zswap. Preperbelly as per
> > memcg counter.
>
> Actually, yeah I asked about this counter in a review in an earlier
> version as well, then I completely forgot about it :)

Ack.

>
>
> > I saw that you implement it as a counter in your V1. Does the zsmalloc
> > already track this information in the zspool class? Having this per
>
> Kinda sorta. If we build the kernel with CONFIG_ZSMALLOC_STAT, we can
> get the number of objects in each size_class.
>
> Each time we read, I believe we have to read every size class though.
> So it's kinda annoying. Whereas here, we can just read an atomic
> counter? :)
>

The data compressible or not is very dependent on the job. A per memcg
counter will be more useful than a global overall counter. As a
devil's advocate to challenge the per memcg incompressible counter. If
most of the data is not compressible, the per memcg overall
compression ratio, compressed size vs before compress size can reflect
that as well. Depending on how fine grain we want this data.

> > cgroup information we can evaluate how  much zswap is saving. Some
> > jobs like databases might store a lot of hash value and encrypted data
> > which is not compressible. In that case, we might just pass the whole
>
> Hmmm actually, this might be a good point. Lemme think about it a bit mor=
e.
>
> (but again, worst case scenario, we can send a follow up patch to add
> these counters).

Agree.

Thanks

Chris


Chris

