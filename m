Return-Path: <linux-kernel+bounces-800050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9A4B432C9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97603582BBB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8992857E2;
	Thu,  4 Sep 2025 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDSlozPx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19E27932D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968642; cv=none; b=ZGA0RnktkeL3iLId8wb5ZXjc44ZptgkFNLu2YYZN0meMrLwH08hgDJweyzQOecPAJVSJXuFi18ct/14bST4V1j+iejKVPALDO3e80ldoSlgA1uAItGJ9WBmJNYOVHTTeZqS8arvocBTul8QnbYFGf3+ltjT0TGTPSFh1EW4hYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968642; c=relaxed/simple;
	bh=ufVzcq8zm3A0Ht5VXxE6QoMNGE1Z254EF2tmVFoc4DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLGnBrpDiMoXWtnwfRrWI1tWwn/DYY7Tgpnhf25Bc4o+uObLCKyzB99pzx7tHfrvSgPIVyUvAU0CiiBPvIp8QxWfebm3wYT0OHBY6nolbS0WpZ9+nmNURO6xz1pzcEl39AkVfw/Rlt276lR1yhODaKc+YMJuTbUlGIxyF/XQrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDSlozPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86130C4CEF7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756968641;
	bh=ufVzcq8zm3A0Ht5VXxE6QoMNGE1Z254EF2tmVFoc4DU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RDSlozPxIPfc6Ho7vhX6r4Ib3+NiyO2Yzq2jQDrGjDYJvBZX4N66OiK/Sr2F/x4uT
	 oL3x6YMKzhJEeD/4WXh/Q/D7+e/Cs3Te5Z8/t7I6n4kF34Y0A9AXiMXVKIOAmWl4ol
	 XLPZ32KZ6M+a1wao+aCl0TI2U07g89vH1mGt9KFtxl/OdFb43A2wkF47/FyucIRs5l
	 Zu1ppZRb6jea6V3QZClTnaN7df9nMrP5BXaRLjpA9heJV7wSFdmnZQhCq4gjEzvZLb
	 8FWhnQvllBt+bfqityfFO4s21+7a2s7R9nA9/KkUGGZ+RYJcUcmdsTj5TgFjfT6rxb
	 scAyFJNSg//KA==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d71bcac45so7355017b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:50:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXp52hnuczf6vtFfWg2mWQDOjAlUdxr8/BDfC/uKzyIPC6+evaPjecCzPVoU1quPfIAR84KrnV07GrprkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkuP9Ze59X2uuDjcSE9FGXiFRCF3bwHUsQTO+G5p6poXlO93Xb
	jETW96BPFNxn02ISb4bw7XJPERQcoCpke2577Gyiux6WI6/tfY8lZEHBB9QR2VvlPr/uwnEikOp
	Vhy/CcX6a1abmwCkxbw29AkVBQE+3gI5RJ14YLgHAPw==
X-Google-Smtp-Source: AGHT+IFhEKVdKiOgUb1HTDtx+Ip1bxA8hKxDH7kCW9l/rVvtQc/1r/5b1lwTccJNO47HGH9k3FQotKLzDfWksD0QlG0=
X-Received: by 2002:a05:690c:ecc:b0:71e:76e8:2457 with SMTP id
 00721157ae682-72276387388mr222815057b3.22.1756968640654; Wed, 03 Sep 2025
 23:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-9-ryncsn@gmail.com>
 <CAGsJ_4xON7fYg1VvcjLOsgBb_Wp4ruC+vdA4Q496GH1jXunU1A@mail.gmail.com>
 <CACePvbUVK45uRPVoO3ubDfQHikebSHFNQOsMTMvJ91QQZH2HwQ@mail.gmail.com>
 <CAGsJ_4we4ZfNqJ+v7+=0hjNKLakJ-s8qtRsGo_kp0R_th7Xvkw@mail.gmail.com>
 <CACePvbXjbtowr5wSKR_F_2ou6nVhxK3-+HvSs+P71PYOo0h3UA@mail.gmail.com> <CAGsJ_4wK2vXzc0z7+JNwChhtk2gSPcrZ=vHJx=qfXcr+cZiTgw@mail.gmail.com>
In-Reply-To: <CAGsJ_4wK2vXzc0z7+JNwChhtk2gSPcrZ=vHJx=qfXcr+cZiTgw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 3 Sep 2025 23:50:29 -0700
X-Gmail-Original-Message-ID: <CACePvbWhxBVkZtTYumjiyufYzZHeYq0oVQBLoHBghYO1P_e1=Q@mail.gmail.com>
X-Gm-Features: Ac12FXyKJVNh2EtzlqV9oVTXA2V2P4p32K8I_rvJswW67hlQD6kUeMFJjVHTzGo
Message-ID: <CACePvbWhxBVkZtTYumjiyufYzZHeYq0oVQBLoHBghYO1P_e1=Q@mail.gmail.com>
Subject: Re: [PATCH 8/9] mm, swap: implement dynamic allocation of swap table
To: Barry Song <21cnbao@gmail.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:52=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Wed, Sep 3, 2025 at 8:35=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
> >
> > On Tue, Sep 2, 2025 at 4:31=E2=80=AFPM Barry Song <21cnbao@gmail.com> w=
rote:
> > >
> > > On Wed, Sep 3, 2025 at 1:17=E2=80=AFAM Chris Li <chrisl@kernel.org> w=
rote:
> > > >
> > > > On Tue, Sep 2, 2025 at 4:15=E2=80=AFAM Barry Song <21cnbao@gmail.co=
m> wrote:
> > > > >
> > > > > On Sat, Aug 23, 2025 at 3:21=E2=80=AFAM Kairui Song <ryncsn@gmail=
.com> wrote:
> > > > > >
> > > > > > From: Kairui Song <kasong@tencent.com>
> > > > > >
> > > > > > Now swap table is cluster based, which means free clusters can =
free its
> > > > > > table since no one should modify it.
> > > > > >
> > > > > > There could be speculative readers, like swap cache look up, pr=
otect
> > > > > > them by making them RCU safe. All swap table should be filled w=
ith null
> > > > > > entries before free, so such readers will either see a NULL poi=
nter or
> > > > > > a null filled table being lazy freed.
> > > > > >
> > > > > > On allocation, allocate the table when a cluster is used by any=
 order.
> > > > > >
> > > > >
> > > > > Might be a silly question.
> > > > >
> > > > > Just curious=E2=80=94what happens if the allocation fails? Does t=
he swap-out
> > > > > operation also fail? We sometimes encounter strange issues when m=
emory is
> > > > > very limited, especially if the reclamation path itself needs to =
allocate
> > > > > memory.
> > > > >
> > > > > Assume a case where we want to swap out a folio using clusterN. W=
e then
> > > > > attempt to swap out the following folios with the same clusterN. =
But if
> > > > > the allocation of the swap_table keeps failing, what will happen?
> > > >
> > > > I think this is the same behavior as the XArray allocation node wit=
h no memory.
> > > > The swap allocator will fail to isolate this cluster, it gets a NUL=
L
> > > > ci pointer as return value. The swap allocator will try other clust=
er
> > > > lists, e.g. non_full, fragment etc.
> > >
> > > What I=E2=80=99m actually concerned about is that we keep iterating o=
n this
> > > cluster. If we try others, that sounds good.
> >
> > No, the isolation of the current cluster will remove the cluster from
> > the head and eventually put it back to the tail of the appropriate
> > list. It will not keep iterating the same cluster. Otherwise trying to
> > allocate a high order swap entry will also deadlooping on the first
> > cluster if it fails to allocate swap entries.
> >
> > >
> > > > If all of them fail, the folio_alloc_swap() will return -ENOMEM. Wh=
ich
> > > > will propagate back to the try to swap out, then the shrink folio
> > > > list. It will put this page back to the LRU.
> > > >
> > > > The shrink folio list either free enough memory (happy path) or not
> > > > able to free enough memory and it will cause an OOM kill.
> > > >
> > > > I believe previously XArray will also return -ENOMEM at insert a
> > > > pointer and not be able to allocate a node to hold that ponter. It =
has
> > > > the same error poperation path. We did not change that.
> > >
> > > Yes, I agree there was an -ENOMEM, but the difference is that we
> > > are allocating much larger now :-)
> >
> > Even that is not 100% true. The XArray uses kmem_cache. Most of the
> > time it is allocated from the kmem_cache cached page without hitting
> > the system page allocation. When kmem_cache runs out of the current
> > cached page, it will allocate from the system via page allocation, at
> > least page size.
> >
>
> Exactly=E2=80=94that=E2=80=99s what I mean. When we hit the cache, alloca=
tion is far more
> predictable than when it comes from the buddy allocator.

That statement is true if the number of allocations is the same.
However, because the xarray node size is 64, xarray needs to be
allocated a lot more often than swap tables which is page size.

From the page allocator point of view, these two should be similar.
Basically every 512 swap entry allocates one page from the page
allocator.

> > So from the page allocator point of view, the swap table allocation is
> > not bigger either.
>
> I think the fundamental difference lies in how much pressure we place
> on the buddy allocator.

Should be about the same. About every 512 swap entry allocates a page.
That does not consider xarray has an internal node as well. Can you
help me understand why you think xarray has less allocation pressure?

> > > One option is to organize every 4 or 8 swap slots into a group for
> > > allocating or freeing the swap table. This way, we avoid the worst
> > > case where a single unfreed slot consumes a whole swap table, and
> > > the allocation size also becomes smaller. However, it=E2=80=99s uncle=
ar
> > > whether the memory savings justify the added complexity and effort.
> >
> > Keep in mind that XArray also has this fragmentation issue as well.
> > When a 64 pointer node is free, it will return to the kmem_cache as
> > free area of the cache page. Only when every object in that page is
> > free, that page can return to the page allocator. The difference is
> > that the unused area seating at the swap table can be used
> > immediately. The unused XArray node will sit in the kmem_cache and
> > need extra kmem_cache_alloc to get the node to be used in the XArray.
> > There is also a subtle difference that all xarray share the same
> > kmem_cache pool for all xarray users. There is no dedicated kmem_cache
> > pool for swap. The swap node might mix with other xarray nodes, making
> > it even harder to release the underlying page. The swap table uses the
> > page directly and it does not have this issue. If you have a swing of
> > batch jobs causing a lot of swap, when the job is done, those swap
> > entries will be free and the swap table can return those pages back.
> > But xarray might not be able to release as many pages because of the
> > mix usage of the xarray. It depends on what other xarray node was
> > allocated during the swap usage.
>
> Yes. If we organize the swap_table in group sizes of 16, 32, 64, 128, and=
 so
> on, we might gain the same benefit: those small objects become immediatel=
y
> available to other allocations=E2=80=94no matter if they are visible to t=
he buddy
> allocator.

The swap table is page sized. One cluster still has 512 entries, If
you make the swap_table smaller, then you need to have more of
swap_table for one cluster. The swap table for one cluster needs to
add up to 512 entries anyway. Smaller size swap table does not make
sense to me.

Chris

