Return-Path: <linux-kernel+bounces-798522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A667DB41F2A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B5E168288
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0FF2FE574;
	Wed,  3 Sep 2025 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNCshDMl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B8B1C84DF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902935; cv=none; b=Pa2Es25/2w0jp1eNrOdfkeCFY/KG/t+AXaUty1js0QbPhGiSOK8jo+7Y7/vhwNnkHogj7rz36YWdPgGDwatOIJ5h73IxkcUb6/eCK8QO9TmjPIO8QFqRf1Tk16ssUIeLgtCLli6eNigJQPct3gwuP79WWLvLIr4Tibg+4XhiNCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902935; c=relaxed/simple;
	bh=DLEC9Evf5FlWOMlAZljYLeumaRL0HGk6iNDsEWfj9Yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O11LsYn6PGxNdM0dLsDmGTVK0FJZ68ZlLdLGv+5Kg0mJ3ts0/mXKQrYf2uDbuRcgTVCf29oIpngqiCihAfMzJs5DB+yqlx8/C8BUmYHFRfOdZuzmW78A/tuOXiVfzYZAM2b/HhYaFv9IFZhBIBzickMutbtu7/vzn/UmouXQ/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNCshDMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B7EC4CEFE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756902934;
	bh=DLEC9Evf5FlWOMlAZljYLeumaRL0HGk6iNDsEWfj9Yk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iNCshDMlH0PP+U9tYmnBYVOGgDIkcmqrwdh58SuD3jbDPCfT4moWf816Uj/eyH1S7
	 xr6Rsz3M4EqSRpcx0hvbNvyyWs5zwuoj/6hF5BVsUMOZf20AweHu2VMcIkWbDoEm6x
	 ylEuQbTRLsGKMC1RD+YXty13wYoqapj7BYfUc8Rf7KjNSN2Uu1AIJc2ww91TbO6kIC
	 eSHMsXBM//vvLNUR9i5Ca/bCJUbVtIFxo0QpsA86qs4I1iiybANMQtPVr33aeZzCgG
	 yTcC5kBMtuCaAl/492FDWR7eKBOjpJv2n4qd0EGNVANtGlWKdpGO2V5qyYACUqyXwk
	 /NzZXzwtJB3FA==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d60528734so50897987b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:35:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKlJPMZ+pHoV/avJRea0bANpyfNnsDMo2MDJ0yDdKt/at1yIsaZzEG3m3P0fmzEI8mWcVdmK5fdKn5N9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDHC31MeQ3ffRmFfW/5PIU9/S+2Twlynv2oWmbyoDxnIMWDhQw
	baaeW71AoBzKu8a/34DAiWeHKsTDmgRW1QoAb9PFe79NIuh0kyvAzQw7JD28gCIppP9ru+cwtG9
	HB6d7O3R4dKGn01wUJd+WMykfsXVD0MsJAAZ3aFsSKQ==
X-Google-Smtp-Source: AGHT+IGmgXA5iAxR2DYRbTXvmclzzmqAtU6Yh8IWC7J9OjhAjhsYHmOxUIuiq8Gsl1Ovbv6IdvDksI2ck1w83DXMZ4A=
X-Received: by 2002:a05:690c:6903:b0:721:40df:7383 with SMTP id
 00721157ae682-7227655ae4fmr199308807b3.41.1756902933940; Wed, 03 Sep 2025
 05:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-9-ryncsn@gmail.com>
 <CAGsJ_4xON7fYg1VvcjLOsgBb_Wp4ruC+vdA4Q496GH1jXunU1A@mail.gmail.com>
 <CACePvbUVK45uRPVoO3ubDfQHikebSHFNQOsMTMvJ91QQZH2HwQ@mail.gmail.com> <CAGsJ_4we4ZfNqJ+v7+=0hjNKLakJ-s8qtRsGo_kp0R_th7Xvkw@mail.gmail.com>
In-Reply-To: <CAGsJ_4we4ZfNqJ+v7+=0hjNKLakJ-s8qtRsGo_kp0R_th7Xvkw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 3 Sep 2025 05:35:22 -0700
X-Gmail-Original-Message-ID: <CACePvbXjbtowr5wSKR_F_2ou6nVhxK3-+HvSs+P71PYOo0h3UA@mail.gmail.com>
X-Gm-Features: Ac12FXzB2G67O6c2neqhsxxf2zRfAm25LgGfCqfNTYe7Va-TDT5xLTpHlg6jKIU
Message-ID: <CACePvbXjbtowr5wSKR_F_2ou6nVhxK3-+HvSs+P71PYOo0h3UA@mail.gmail.com>
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

On Tue, Sep 2, 2025 at 4:31=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Wed, Sep 3, 2025 at 1:17=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
> >
> > On Tue, Sep 2, 2025 at 4:15=E2=80=AFAM Barry Song <21cnbao@gmail.com> w=
rote:
> > >
> > > On Sat, Aug 23, 2025 at 3:21=E2=80=AFAM Kairui Song <ryncsn@gmail.com=
> wrote:
> > > >
> > > > From: Kairui Song <kasong@tencent.com>
> > > >
> > > > Now swap table is cluster based, which means free clusters can free=
 its
> > > > table since no one should modify it.
> > > >
> > > > There could be speculative readers, like swap cache look up, protec=
t
> > > > them by making them RCU safe. All swap table should be filled with =
null
> > > > entries before free, so such readers will either see a NULL pointer=
 or
> > > > a null filled table being lazy freed.
> > > >
> > > > On allocation, allocate the table when a cluster is used by any ord=
er.
> > > >
> > >
> > > Might be a silly question.
> > >
> > > Just curious=E2=80=94what happens if the allocation fails? Does the s=
wap-out
> > > operation also fail? We sometimes encounter strange issues when memor=
y is
> > > very limited, especially if the reclamation path itself needs to allo=
cate
> > > memory.
> > >
> > > Assume a case where we want to swap out a folio using clusterN. We th=
en
> > > attempt to swap out the following folios with the same clusterN. But =
if
> > > the allocation of the swap_table keeps failing, what will happen?
> >
> > I think this is the same behavior as the XArray allocation node with no=
 memory.
> > The swap allocator will fail to isolate this cluster, it gets a NULL
> > ci pointer as return value. The swap allocator will try other cluster
> > lists, e.g. non_full, fragment etc.
>
> What I=E2=80=99m actually concerned about is that we keep iterating on th=
is
> cluster. If we try others, that sounds good.

No, the isolation of the current cluster will remove the cluster from
the head and eventually put it back to the tail of the appropriate
list. It will not keep iterating the same cluster. Otherwise trying to
allocate a high order swap entry will also deadlooping on the first
cluster if it fails to allocate swap entries.

>
> > If all of them fail, the folio_alloc_swap() will return -ENOMEM. Which
> > will propagate back to the try to swap out, then the shrink folio
> > list. It will put this page back to the LRU.
> >
> > The shrink folio list either free enough memory (happy path) or not
> > able to free enough memory and it will cause an OOM kill.
> >
> > I believe previously XArray will also return -ENOMEM at insert a
> > pointer and not be able to allocate a node to hold that ponter. It has
> > the same error poperation path. We did not change that.
>
> Yes, I agree there was an -ENOMEM, but the difference is that we
> are allocating much larger now :-)

Even that is not 100% true. The XArray uses kmem_cache. Most of the
time it is allocated from the kmem_cache cached page without hitting
the system page allocation. When kmem_cache runs out of the current
cached page, it will allocate from the system via page allocation, at
least page size.

So from the page allocator point of view, the swap table allocation is
not bigger either.

> One option is to organize every 4 or 8 swap slots into a group for
> allocating or freeing the swap table. This way, we avoid the worst
> case where a single unfreed slot consumes a whole swap table, and
> the allocation size also becomes smaller. However, it=E2=80=99s unclear
> whether the memory savings justify the added complexity and effort.

Keep in mind that XArray also has this fragmentation issue as well.
When a 64 pointer node is free, it will return to the kmem_cache as
free area of the cache page. Only when every object in that page is
free, that page can return to the page allocator. The difference is
that the unused area seating at the swap table can be used
immediately. The unused XArray node will sit in the kmem_cache and
need extra kmem_cache_alloc to get the node to be used in the XArray.
There is also a subtle difference that all xarray share the same
kmem_cache pool for all xarray users. There is no dedicated kmem_cache
pool for swap. The swap node might mix with other xarray nodes, making
it even harder to release the underlying page. The swap table uses the
page directly and it does not have this issue. If you have a swing of
batch jobs causing a lot of swap, when the job is done, those swap
entries will be free and the swap table can return those pages back.
But xarray might not be able to release as many pages because of the
mix usage of the xarray. It depends on what other xarray node was
allocated during the swap usage.

I guess that is too much detail.

>
> Anyway, I=E2=80=99m glad to see the current swap_table moving towards mer=
ge
> and look forward to running it on various devices. This should help
> us see if it causes any real issues.

Agree.

Chris

