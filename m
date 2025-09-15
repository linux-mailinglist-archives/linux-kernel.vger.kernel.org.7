Return-Path: <linux-kernel+bounces-817519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18932B58331
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8CE4C03F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F8527BF7E;
	Mon, 15 Sep 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tugri2f3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357922156D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956479; cv=none; b=flqPONNuYvFqhbOJopewXFQBqWoniCOsTUoshBskaJxHTXdtlPAnmeRR6SQtt9P8Gr5M0pJAePWdNuaqarAkXnFHj/Qisc126WTxO0DbUrERq6sGOUFi4j9YxxFI1eTCXG5ZqgxgHakrVKipxW/JO3xlHiX0Kumyh51hsV/cl+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956479; c=relaxed/simple;
	bh=D8vghLD5aofkfZWm+QHf/Np3Id/lFsIZkhAuaHbgmWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvJ9qE4V/rQhg2zEmSkRMd+2xgn/42ksHaJg5zS2OYqOLbe+jSaXyPtED03EmvDjSh0mIE0nXFUGhvzBR8gFNKJKvDtMfULpb+/yiGXTXCwcaZk90G2XvVN67FnHubijtZm8vPjOG2G0iWiqWDd3zZgeRFVavzCOBp8rt3ARkzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tugri2f3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32A4C4CEF1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757956478;
	bh=D8vghLD5aofkfZWm+QHf/Np3Id/lFsIZkhAuaHbgmWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tugri2f3kxqbUfFlU4YI+6/wjNNKm34ijZGfoaoKWksKKJHXEdpcigAIMzDlyeVx4
	 eqEbHXwppfjbelipqM2uL6uhSY7sm1VaOtsLvLylQzoC39vfWdZKhSYYVS7BlYhHQm
	 AeNG86Nb5teB8WF7b0OjJZEzWSwoho9EEPW5bkd+SnEGtN6l796LF8SbQg1WW7q/6q
	 tn4iVXkjfu713NeOZC+rGjjqpXYK9JpfiaZx0EXIlIaZbFUimdl2s+CKHmk60sPlZZ
	 ViulXB6HIrD12mrKRENL4snzmQJjW2kOgXRP+YBnaMx5kvYmYPYisEs6z62i0zanYN
	 pvuQlUDcbDm6g==
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-606b375eeb3so2124056d50.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:14:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPwUS1s/FgwR8w9At6YC2gmhLFG2iuAzZ24OkjOWL4oQmIsfh4xf+XAVbsY2yw18Bkb+RdbcbEL14yWKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzmWMkE1JL/WUpdkNKRT39nWJnNmVbv7XHvRIEwcUqlAwxDlOF
	PoNnfdX4nj2PVHwqkmw/+k1Ok0czYzctmeNnI/OuISK6Ms5z3YhOsaH6EGfTBj2+Hq2nX9L/HpH
	oFL+9j6MpCgrDPty6QYFg2cUxjTLETo4xTGoa+th4Xw==
X-Google-Smtp-Source: AGHT+IF4myrMUc66El4FGAdlIfJYMUaUupVH7LJ6OvKBZL7TB7Kw0evTg6GajF92fjSuFeSE2zB8FNEl1Xpe4O79P50=
X-Received: by 2002:a53:83d2:0:b0:624:628f:2979 with SMTP id
 956f58d0204a3-627229797b2mr9025390d50.17.1757956477693; Mon, 15 Sep 2025
 10:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160833.3464-15-ryncsn@gmail.com> <20250915150719.3446727-1-clm@meta.com>
 <CAMgjq7A1hqQ+yboCtT+JF=5Tfijph2s4ooSqNwnexQ9kwJOCtA@mail.gmail.com> <6466a351-4c3a-4a02-b76f-8785daf36c0b@meta.com>
In-Reply-To: <6466a351-4c3a-4a02-b76f-8785daf36c0b@meta.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 15 Sep 2025 10:14:26 -0700
X-Gmail-Original-Message-ID: <CACePvbUWGNq=TW2aP2zvcp9=Xt86hBPi3Ga1SLqjeZcyaKApoQ@mail.gmail.com>
X-Gm-Features: Ac12FXzXaVaP_4Ed-c2dW6uD3tDhb2D5b92TY1d296kBGC73QKkhKMAR95GFcwE
Message-ID: <CACePvbUWGNq=TW2aP2zvcp9=Xt86hBPi3Ga1SLqjeZcyaKApoQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] mm, swap: implement dynamic allocation of swap table
To: Chris Mason <clm@meta.com>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Nhat Pham <nphamcs@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:00=E2=80=AFAM Chris Mason <clm@meta.com> wrote:
>
>
>
> On 9/15/25 12:24 PM, Kairui Song wrote:
> > On Mon, Sep 15, 2025 at 11:55=E2=80=AFPM Chris Mason <clm@meta.com> wro=
te:
> >>
> >> On Thu, 11 Sep 2025 00:08:32 +0800 Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> [ ... ]
>              spin_lock(&si->global_cluster_lock);
> >>> +     /*
> >>> +      * Back to atomic context. First, check if we migrated to a new
> >>> +      * CPU with a usable percpu cluster. If so, try using that inst=
ead.
> >>> +      * No need to check it for the spinning device, as swap is
> >>> +      * serialized by the global lock on them.
> >>> +      *
> >>> +      * The is_usable check is a bit rough, but ensures order 0 succ=
ess.
> >>> +      */
> >>> +     offset =3D this_cpu_read(percpu_swap_cluster.offset[order]);
> >>> +     if ((si->flags & SWP_SOLIDSTATE) && offset) {
> >>> +             pcp_ci =3D swap_cluster_lock(si, offset);
> >>> +             if (cluster_is_usable(pcp_ci, order) &&
> >>> +                 pcp_ci->count < SWAPFILE_CLUSTER) {
> >>> +                     ci =3D pcp_ci;
> >>                        ^^^^^^^^^^^^^
> >> ci came from the caller, and in the case of isolate_lock_cluster() the=
y
> >> had just removed it from a list.  We overwrite ci and return something
> >> different.
> >
> > Yes, that's expected. See the comment above. We have just dropped
> > local lock so it's possible that we migrated to another CPU which has
> > its own percpu cache ci (percpu_swap_cluster.offset).
> >
> > To avoid fragmentation, drop the isolated ci and use the percpu ci
> > instead. But you are right that I need to add the ci back to the list,
> > or it will be leaked. Thanks!
>
> Yeah, the comment helped a lot (thank you).  It was just the leak I was
> worried about ;)

As Kairui said, that is not a leak, it is the intended behavior. It
rotates the listhead when fetching the ci from the list to avoid
repeatedly trying some fragment cluster which has a very low success
rate. Otherwise it can stall on the same fragmented list. It does look
odd at the first glance. That is the best we can do so far without
introducing a lot of repeating rotation logic to the caller. If you
find other ways to improve the reading without performance penalty and
make code simpler, feel free to make suggestions or even patches.

Chris

