Return-Path: <linux-kernel+bounces-799418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3D1B42B5F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6971A86DBD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8262E764A;
	Wed,  3 Sep 2025 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH+JkBBS"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4BC292B44
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932769; cv=none; b=aVLIYgCFAYLdHKh0qnYIyHzoUwSx5H4bN1QMPxNx8jM4RHyLiReAv5llM7DfLCjPtnQ9eQ8MBQmmKYWCyHX72zzAqYzFKF/Q/psj6p5bdnaZnMs1tmbz3arK/b5ew5/v+jOzgBIpesanZHG40rQ3jioyG7EPAwCNXtzxq/KK18E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932769; c=relaxed/simple;
	bh=lrGbbZHkPmOkrhxaF1dT80bUwOd57ENAbsAwajvsVvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fqed+dH7ytigMqfJkMx+BzBzJM0gKWvmeHzCQqRKNWXa3A0Lz7lRcJ75DUR6l/DePTEQPBKVJfgHNbr4Lll+z4CgJPHJVjb8It0MKK8Wkp2dzTfcpIO43AZ1uWE9rxZk0ucVxwFWyeaODoOHEmk1Tkbv4wmHhakgu16d/0+OIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nH+JkBBS; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b2f4ac4786so3733131cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756932766; x=1757537566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrGbbZHkPmOkrhxaF1dT80bUwOd57ENAbsAwajvsVvg=;
        b=nH+JkBBST6Akfg006ZWF2qYg/p1bvdmj1TC42Ir1OqGT4iht/YEf268WiAe5mvZDkP
         KfHOSoX408uC03GhsRVqwf1f77CjyPNqMT3dDPlXUQK04hxwFNOSpu4YDCX80SqR6Gn4
         x4lZZ6+Mw7v7L1103v1Gc5AH2UF+t+gGj38JE4Gz3wDVR/oJrmy04jXfzfLbF6Tlbjen
         C/oIG1jR22PenNgCQyhy0cMT6croUQMPYs2sjKT+5972FQ1V7HVouw8/VWAhIbLYgtKE
         bQFStcJLV7SrVyLe/pYlJnOwEAbvX7GZOnMjerWw59KoourzTmX8I53K/+ILeFXDv4gA
         HhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756932766; x=1757537566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrGbbZHkPmOkrhxaF1dT80bUwOd57ENAbsAwajvsVvg=;
        b=jP/7mLWpQRucm1sOtPjyP/0rZzEoXLw0XdSGi+jWd+6kapbDEayavQhDfBZ/E7qKoo
         NZfutJ+TOBN3rvH4NLxG/MCZCNo4h0r+UgtDhRQ67bwMwys03U06b4L7eD+eJW2joZoH
         3aUCvrsT3peSqGSAsmBcY39EQ2Qn8SJI7oG9cg+rVIs61sMv5dK2PIX1RdztpFYQoDKZ
         ZvWoau/nMMWqP6SYbGA7IXmMasUwEJg7Z53OerZYbAz0mBQHDAvS46F0XKT3mOF8E+cr
         TSZ+Q+ME9Xco3noS6+Yh8ELbrikDVR0u5ymWrHqrcg6AcoXS16pm+OP9PiPzyDjRUf5v
         E1FA==
X-Forwarded-Encrypted: i=1; AJvYcCV43EePmnUjhlPd2/KTcSRTmqN1mL6qI/8ZaYit76tscmU7h6K4hKQiPLOmytwPXLNeQFUd5BqZikaeSeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3WsQGZtv7iz44gQ4J9LmeNDARlOghrr+Nc4hNS7CmgmH0IGU9
	YfnUwUgrl7IgGe9HqF8NvcIjx3InrRYpLfulbFAnyOVbSfNfSqSomguV+bfax8yFDVxMZbUD/Kf
	xl+scyT7ocOYjUxHKUZ4+wl1fkUnIQH8=
X-Gm-Gg: ASbGncsIGIlQY0l/c0RHLo98Nb7BKRO6L8egLTHhwJejs9ZdbjdNcL7HHCmVesZxTM1
	fjYVYBeoOP+CpZltAtku62FxL3PobL4jNjX5QEG2xYUfqQuJ1IrLKFiXPfg1XlbpUpTYfRf0UFv
	XI13stGTigkrRYHpA+sWnZ1p0+kJfGJg+vrN91PdQZtmrRaMqTDz0ZxkYxUi7gL7IWDLVjoalDn
	uIH9PQKIUfl/koBow==
X-Google-Smtp-Source: AGHT+IEeKTRk/jxWcQ9dPhf7ezzD2Bpp4UPWhsV8IsVl0FOkyOHHFGsrc13kHi1JV4+qraqX+0jyUZiSZbSXNsYcJ90=
X-Received: by 2002:ac8:5a91:0:b0:4b4:ff15:2c22 with SMTP id
 d75a77b69052e-4b4ff152eddmr23444781cf.15.1756932766141; Wed, 03 Sep 2025
 13:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-9-ryncsn@gmail.com>
 <CAGsJ_4xON7fYg1VvcjLOsgBb_Wp4ruC+vdA4Q496GH1jXunU1A@mail.gmail.com>
 <CACePvbUVK45uRPVoO3ubDfQHikebSHFNQOsMTMvJ91QQZH2HwQ@mail.gmail.com>
 <CAGsJ_4we4ZfNqJ+v7+=0hjNKLakJ-s8qtRsGo_kp0R_th7Xvkw@mail.gmail.com> <CACePvbXjbtowr5wSKR_F_2ou6nVhxK3-+HvSs+P71PYOo0h3UA@mail.gmail.com>
In-Reply-To: <CACePvbXjbtowr5wSKR_F_2ou6nVhxK3-+HvSs+P71PYOo0h3UA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 4 Sep 2025 04:52:35 +0800
X-Gm-Features: Ac12FXz0qfkg7F_ObHqoqis0mbjXyNQlDtGx4gRi-mD9FYViJi2Cg8w3R_9QaCs
Message-ID: <CAGsJ_4wK2vXzc0z7+JNwChhtk2gSPcrZ=vHJx=qfXcr+cZiTgw@mail.gmail.com>
Subject: Re: [PATCH 8/9] mm, swap: implement dynamic allocation of swap table
To: Chris Li <chrisl@kernel.org>
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

On Wed, Sep 3, 2025 at 8:35=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Sep 2, 2025 at 4:31=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > On Wed, Sep 3, 2025 at 1:17=E2=80=AFAM Chris Li <chrisl@kernel.org> wro=
te:
> > >
> > > On Tue, Sep 2, 2025 at 4:15=E2=80=AFAM Barry Song <21cnbao@gmail.com>=
 wrote:
> > > >
> > > > On Sat, Aug 23, 2025 at 3:21=E2=80=AFAM Kairui Song <ryncsn@gmail.c=
om> wrote:
> > > > >
> > > > > From: Kairui Song <kasong@tencent.com>
> > > > >
> > > > > Now swap table is cluster based, which means free clusters can fr=
ee its
> > > > > table since no one should modify it.
> > > > >
> > > > > There could be speculative readers, like swap cache look up, prot=
ect
> > > > > them by making them RCU safe. All swap table should be filled wit=
h null
> > > > > entries before free, so such readers will either see a NULL point=
er or
> > > > > a null filled table being lazy freed.
> > > > >
> > > > > On allocation, allocate the table when a cluster is used by any o=
rder.
> > > > >
> > > >
> > > > Might be a silly question.
> > > >
> > > > Just curious=E2=80=94what happens if the allocation fails? Does the=
 swap-out
> > > > operation also fail? We sometimes encounter strange issues when mem=
ory is
> > > > very limited, especially if the reclamation path itself needs to al=
locate
> > > > memory.
> > > >
> > > > Assume a case where we want to swap out a folio using clusterN. We =
then
> > > > attempt to swap out the following folios with the same clusterN. Bu=
t if
> > > > the allocation of the swap_table keeps failing, what will happen?
> > >
> > > I think this is the same behavior as the XArray allocation node with =
no memory.
> > > The swap allocator will fail to isolate this cluster, it gets a NULL
> > > ci pointer as return value. The swap allocator will try other cluster
> > > lists, e.g. non_full, fragment etc.
> >
> > What I=E2=80=99m actually concerned about is that we keep iterating on =
this
> > cluster. If we try others, that sounds good.
>
> No, the isolation of the current cluster will remove the cluster from
> the head and eventually put it back to the tail of the appropriate
> list. It will not keep iterating the same cluster. Otherwise trying to
> allocate a high order swap entry will also deadlooping on the first
> cluster if it fails to allocate swap entries.
>
> >
> > > If all of them fail, the folio_alloc_swap() will return -ENOMEM. Whic=
h
> > > will propagate back to the try to swap out, then the shrink folio
> > > list. It will put this page back to the LRU.
> > >
> > > The shrink folio list either free enough memory (happy path) or not
> > > able to free enough memory and it will cause an OOM kill.
> > >
> > > I believe previously XArray will also return -ENOMEM at insert a
> > > pointer and not be able to allocate a node to hold that ponter. It ha=
s
> > > the same error poperation path. We did not change that.
> >
> > Yes, I agree there was an -ENOMEM, but the difference is that we
> > are allocating much larger now :-)
>
> Even that is not 100% true. The XArray uses kmem_cache. Most of the
> time it is allocated from the kmem_cache cached page without hitting
> the system page allocation. When kmem_cache runs out of the current
> cached page, it will allocate from the system via page allocation, at
> least page size.
>

Exactly=E2=80=94that=E2=80=99s what I mean. When we hit the cache, allocati=
on is far more
predictable than when it comes from the buddy allocator.

> So from the page allocator point of view, the swap table allocation is
> not bigger either.

I think the fundamental difference lies in how much pressure we place
on the buddy allocator.

>
> > One option is to organize every 4 or 8 swap slots into a group for
> > allocating or freeing the swap table. This way, we avoid the worst
> > case where a single unfreed slot consumes a whole swap table, and
> > the allocation size also becomes smaller. However, it=E2=80=99s unclear
> > whether the memory savings justify the added complexity and effort.
>
> Keep in mind that XArray also has this fragmentation issue as well.
> When a 64 pointer node is free, it will return to the kmem_cache as
> free area of the cache page. Only when every object in that page is
> free, that page can return to the page allocator. The difference is
> that the unused area seating at the swap table can be used
> immediately. The unused XArray node will sit in the kmem_cache and
> need extra kmem_cache_alloc to get the node to be used in the XArray.
> There is also a subtle difference that all xarray share the same
> kmem_cache pool for all xarray users. There is no dedicated kmem_cache
> pool for swap. The swap node might mix with other xarray nodes, making
> it even harder to release the underlying page. The swap table uses the
> page directly and it does not have this issue. If you have a swing of
> batch jobs causing a lot of swap, when the job is done, those swap
> entries will be free and the swap table can return those pages back.
> But xarray might not be able to release as many pages because of the
> mix usage of the xarray. It depends on what other xarray node was
> allocated during the swap usage.

Yes. If we organize the swap_table in group sizes of 16, 32, 64, 128, and s=
o
on, we might gain the same benefit: those small objects become immediately
available to other allocations=E2=80=94no matter if they are visible to the=
 buddy
allocator.

Anyway, I don=E2=80=99t have data to show whether the added complexity is w=
orth
trying. I=E2=80=99m just glad the current approach is hoped to land and run=
 on
real phones.

>
> I guess that is too much detail.
>
> >
> > Anyway, I=E2=80=99m glad to see the current swap_table moving towards m=
erge
> > and look forward to running it on various devices. This should help
> > us see if it causes any real issues.
>

Thanks
Barry

