Return-Path: <linux-kernel+bounces-797591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE6AB4123A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B631A8813E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9E31E5B72;
	Wed,  3 Sep 2025 02:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+gpid+7"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399CA1E6DC5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 02:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756865627; cv=none; b=GjGCENOSy/pGhscUhnmG+s13pUjmKwNQg2/UMvIZHQyBqGagiMkD6aNoNQvU461BFyjP8n/IKiCn53j/WOzsMZpncMWcN4hoBTMO/wMZqEJFJiG7qYYh+cZbMZS/zJH8lE7FJloidilxziZXGonhuiztyHvHUUZmq9sRp8Y5mfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756865627; c=relaxed/simple;
	bh=gENk5oy3VPH1iTtwOCQdC87R/NjbhqCM6vXEQKfriYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKn46hjSXzbxPUoVzP5QdyIKXkt+/YGAmwOTxUn/Q8HoII/f8f1WsG8CmeA9yvf9VpRziBmhOrz74OGOL7FoVcJEMw/uGJRBXknSV+5oufdNRtNnE0KHsxDgljyP2G+9u3lcSY4GIGAPlk+CbXck5tHi+dd8JSuDBQnhJ/jjvVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+gpid+7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61e425434bbso4744171a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 19:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756865623; x=1757470423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gENk5oy3VPH1iTtwOCQdC87R/NjbhqCM6vXEQKfriYA=;
        b=g+gpid+7msCF6p3Jnmtt9Z7uFLi4GgaQmoddDOiew7iunDuwCIniKqAmNLXyzGhL1i
         dTMEwCx6wLriYjRnJ5vh284o34p56S5IQfW2HlUoBl7mjl2JTABzfKLE+pehbc3HyhBR
         AhK3gE5OKk2I15Z51PHWLKkvnBhbleNx3wgKXfPuMdKZy+i0JZ1CvvkO6G23JjFELzQc
         vmsD/ONxB3JTTkF+9xMNXbZIkf4ljNFq+ksXYVU9CyYgTJAJi4YGT6w1QxsV0qRrGoNy
         ZZkulyp171JcZ1Bk/EjNldoUkipemLWrqDaQaKeTrDej2TljFWzInh0wUfzMZhg8TfoM
         4y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756865623; x=1757470423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gENk5oy3VPH1iTtwOCQdC87R/NjbhqCM6vXEQKfriYA=;
        b=iYD6TxUfaA2heFpeqscRNxOc5gz/NEo33lyjgd5ljX8a04PnPBMuJbgcK4UwAVkSwE
         2mjzCcwIrvZADCm4oU05/8ShD9bScFS7zp5F2ryvruAt5HDTxa09DEQbVZG11q9NmSPW
         u7Z7+NMQzsPdcLf4A6TVwHMkXT/FtjD3SKGqKtTVXLpMX/kESjGiOUDMnJ8JU2DT3j+m
         Z2kXJ99BGRAHn0cY1j9L5RoIEllOeL0P41iO5jggvwOqPB3yK79s+by7GI/G3fsTDMyj
         6NgPy4KZecMmSNYViUl45aoWLfAok7+rew9f7lrsi6DyogKdO9ygWBq/nv3H+yy5pY+p
         5aGw==
X-Forwarded-Encrypted: i=1; AJvYcCUcFvIyvrmnRyIo+Lbtj1znG7YmN7mLsuOtCPktlCZJWGMNn06qouMOpJ2h1Vn9s5DpWw+JSjPM6GvJYyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0M7/Hh+kNQmhW5tqLnj7gZECFO1YsranzPhSS3ACRK3+uCYj/
	ZOuw8TCl2qwyyeo0/uk9/TXys2wVCGFKhupp5qtiBoXFiDP+wN8oD8b8HhBmSmD3GzezscJjA4Q
	a/9wqq5KA3TgHlBHWcMUaQzo6TUoKkJY=
X-Gm-Gg: ASbGnctUD11XFEkulf186JaGGZnePP97IE7Y/AN7zFeknVIJtNKajZ8EsAlC1KGJQXC
	2Gy9CY+G3SapveJzyCdN/WrEr7F/9f28tsthsBe55H2Ane/M7PVKeDFkNj9iwuzbDmW0XlXMGGt
	t90Yv4nkpXC5t7L7NUI053TEfzhVsgDGFxB5TzTxeD9xNc/DRqq/qDXWjy5oaZuXXfWGzH2bxMs
	mCfVg0mvzA=
X-Google-Smtp-Source: AGHT+IG6d+Qs7jEfLV+2GlfeM2NxgKykyZEZ8CaSTEyS6WNoJKY3VPzhv/tG8RqTorogqedmIV3bT8045r74TvWBm88=
X-Received: by 2002:a05:6402:40ce:b0:61d:cd5:8b6e with SMTP id
 4fb4d7f45d1cf-61d260cc220mr12247397a12.0.1756865623431; Tue, 02 Sep 2025
 19:13:43 -0700 (PDT)
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
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 3 Sep 2025 10:13:07 +0800
X-Gm-Features: Ac12FXw1AUa6fSBq5i5DCUWbpe7DiaS0JIvFp0rfOypSx71p22kxXjov0LKnUyI
Message-ID: <CAMgjq7Apnxx2GbTG5_dA+Vy1wGaxMHuS9APp0nny8tNURX8jDA@mail.gmail.com>
Subject: Re: [PATCH 8/9] mm, swap: implement dynamic allocation of swap table
To: Barry Song <21cnbao@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> =E4=BA=8E 2025=E5=B9=B49=E6=9C=883=E6=97=A5=
=E5=91=A8=E4=B8=89 08:03=E5=86=99=E9=81=93=EF=BC=9A
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
>
> One option is to organize every 4 or 8 swap slots into a group for
> allocating or freeing the swap table. This way, we avoid the worst
> case where a single unfreed slot consumes a whole swap table, and
> the allocation size also becomes smaller. However, it=E2=80=99s unclear
> whether the memory savings justify the added complexity and effort.
>
> Anyway, I=E2=80=99m glad to see the current swap_table moving towards mer=
ge
> and look forward to running it on various devices. This should help
> us see if it causes any real issues.

Thanks for the insightful review.

I do plan to implement a shrinker to compact the swap table of idle /
full clusters when under pressure. It will be done at the very end.
Things will be much cleaner by then so it's easier to do. And
currently it seems the memory usage is quite good already.

>>
> Thanks
> Barry
>

