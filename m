Return-Path: <linux-kernel+bounces-797586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA59B4122E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069DC48250E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072A51E6DC5;
	Wed,  3 Sep 2025 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+Hhg7cX"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78671B960
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 02:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756865569; cv=none; b=U2vkXugtL1lFelLj3J9/xdSosREWgRK+18gKCwgu0Kmbuudc4iAYxuH6jKSV+bj982U8gnr3GjRFiAOzORY3bT57Ya6/h48hpZqMxNXNdI+277zYHN1P/qGALp8bpX/3a0Gz7r2dy4YeaoVPsu810j45j1sHJzJrUNqeMg+Upxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756865569; c=relaxed/simple;
	bh=ANkHI+ANLJGAtJnAV02+iMqH7eXOl0hw9KqpkDW9FFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcwQLeyi7vhRQJJtH2KSPIaKERHEM2sUTDR5m/e6BgVNBp5sUZewuIuQOPdzE2Qo7cG8NG/Hs7s/bdgMb7lkT6moqGvmEk84oqFT35KxAa7N5qhxFPqxx+wrhVoRzJ3VzmwfnSdY3ges5KI06IGPnCL339unc9E1l1W7fCEOCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+Hhg7cX; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61cd1046d42so7313541a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 19:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756865566; x=1757470366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHNEMXnQPJ7mnboxGgw4UKiDM5+vXgQtKv2FqnlXfUU=;
        b=j+Hhg7cXZs+BI5ulQT2cEh80jySJgY08j8vIKcxZgXdN3RHJubNFpuMdc9Fk4sEgmr
         fJmb/j0FCOt2TXnKlfFjYEPuMF3Tg+DukNafZAYLKSdN8h/QUNyZIDXbCXbmGD75lPA8
         Es3UZvBrP6a85lIx+TvDYs1x5HeUAWHQyr7M1Fae6/kCxOJhMepUPs4+GquqYmlYDMlh
         1UOqSUHc4++DhSPbTup8c/rqoV7svjs50LiEL7QwgPTo2k06SgDx58goW5oyGy6OM6Pg
         m6AHaHvMBv4KRsHn0qEWSDPXAQuwcZvvOTdJdnTqx2037mUDD85xsWwO2Wl9CWvLFctN
         NKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756865566; x=1757470366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHNEMXnQPJ7mnboxGgw4UKiDM5+vXgQtKv2FqnlXfUU=;
        b=sm7hTgUuy6R3S+60Hwii9p3BsZ2sl0PY52thq4/lpxI8XCvTlInn0n81svIMLNAhkg
         /GaeGxkfnIABa6gmALgASxntPsGEbbSTGWfbA1SRM5pJEI5ICyDZh/8gyv7BVGYFlPzH
         pqu/PHUd6Gm1seAmrpUGM2v2ntrisTvN+08zGmh35qCn85CucVcoZg0v5tOOq4Xw384/
         k1rw6w54jnnAyFaWCT+f+4vsmUu3WDictGFBrDiro10+3UJp8sRy8MPuzvIUinVUo5bT
         I2Cc/18PbhDR8tyetoXq/ZLS0Ej+3M0cPEQeUrpZqgfH5jEK8r/tFLcMeC2Gd9W/Yxnu
         /WFg==
X-Forwarded-Encrypted: i=1; AJvYcCVjj+8pQigD+xbcetn25NNneKWCNNSb3VNTREvCRlt3tH/0rGsn3Pf2vE91bxF4DuDmfhMxj5k13xgbkj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrqOyKukVGVhZBv8TTJYcDW4r1OQyWOnhTDsWGPD/g/t3DxEhp
	AQvROqOeOHEhY9u1KihV5DUZhxXs3SLId2b4p97we+A1i4rttI4PBCENUnrnjop9JBS7MG4FhiH
	wVdCnfc49blVND2Q+/TAY640r9EzQflI=
X-Gm-Gg: ASbGncuabEteoiC8fztPtczp1ZN17XKHEMKh3nJQuJwNhr+q70Ao8FNo1+MqcFjjBy3
	cQxNnVihbiLDMJI1Rx8sM9GjN4+dK0I5p7u3VFhLj0Q+JfAJ/TTBT0e0ukZ0LyjACPX+mmUaiZS
	tEZTubk924RwLhtxa2ybDMjHDlHUPnygVstddqa3Lt14dDdwrsJPiQ/X4NLuN1QeZ63g9xxDBs3
	gPqS4ybXGR1hzn2kmuLrA==
X-Google-Smtp-Source: AGHT+IHJvSP0ZDGFIfI+a5x+hY3UFf7dXrZwZcpOSVJter6Xgczmltyt1tECkViagWTXnDDgWy36JsqoLxz8HOvYWbw=
X-Received: by 2002:a05:6402:2787:b0:61c:fb8e:ab6e with SMTP id
 4fb4d7f45d1cf-61d26d923famr10793090a12.32.1756865565722; Tue, 02 Sep 2025
 19:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-7-ryncsn@gmail.com>
 <CAGsJ_4yRa65ogB0d90LmtOigGTqQ9mM-eUU6VbmcX63j6vgHEg@mail.gmail.com>
 <CAMgjq7A5Gr2V9TDFg=_S+SjZ1r1gWXTtRGNofuzAgWNYLMW_DQ@mail.gmail.com> <CAGsJ_4w7iV0YU+sXdYPrzqXAdaLncoP7bnGx8ELcpETL6y+cOQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4w7iV0YU+sXdYPrzqXAdaLncoP7bnGx8ELcpETL6y+cOQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 3 Sep 2025 10:12:09 +0800
X-Gm-Features: Ac12FXwXU3cGEpdDG2B4PbKuGKDDUeEJi395AB_neJedEa8KRWW3ViJ9k_m11YE
Message-ID: <CAMgjq7AWQtbXMH4iOoV473wJj0TA8SEUyvsWKvsUP_=1oRuH9w@mail.gmail.com>
Subject: Re: [PATCH 6/9] mm, swap: use the swap table for the swap cache and
 switch API
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> =E4=BA=8E 2025=E5=B9=B49=E6=9C=883=E6=97=A5=
=E5=91=A8=E4=B8=89 07:44=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Sep 2, 2025 at 11:59=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Tue, Sep 2, 2025 at 6:46=E2=80=AFPM Barry Song <21cnbao@gmail.com> w=
rote:
> > >
> > > > +
> > > > +/*
> > > > + * Helpers for accessing or modifying the swap table of a cluster,
> > > > + * the swap cluster must be locked.
> > > > + */
> > > > +static inline void __swap_table_set(struct swap_cluster_info *ci,
> > > > +                                   unsigned int off, unsigned long=
 swp_tb)
> > > > +{
> > > > +       VM_WARN_ON_ONCE(off >=3D SWAPFILE_CLUSTER);
> > > > +       atomic_long_set(&ci->table[off], swp_tb);
> > > > +}
> > > > +
> > > > +static inline unsigned long __swap_table_get(struct swap_cluster_i=
nfo *ci,
> > > > +                                            unsigned int off)
> > > > +{
> > > > +       VM_WARN_ON_ONCE(off >=3D SWAPFILE_CLUSTER);
> > > > +       return atomic_long_read(&ci->table[off]);
> > > > +}
> > > > +
> > >
> > > Why should this use atomic_long instead of just WRITE_ONCE and
> > > READ_ONCE?
> >
> > Hi Barry,
> >
> > That's a very good question. There are multiple reasons: I wanted to
> > wrap all access to the swap table to ensure there is no non-atomic
> > access, since it's almost always wrong to read a folio or shadow value
> > non-atomically from it. And users should never access swap tables
> > directly without the wrapper helpers. And in another reply, as Chris
> > suggested, we can use atomic operations to catch potential issues
> > easily too.
>
> I still find it odd that for writing we have the si_cluster lock,
> but for reading a long, atomic operations don=E2=80=99t seem to provide
> valid protection against anything. For example, you=E2=80=99re still
> checking folio_lock and folio_test_swapcache() in such cases.
>
>
> >
> > And most importantly, later phases can make use of things like
> > atomic_cmpxchg as a fast path to update the swap count of a swap
> > entry. That's a bit hard to explain for now, short summary is the swap
> > table will be using a single atomic for both count and folio tracking,
> > and we'll clean up the folio workflow with swap, so it should be
> > possible to get an final consistency of swap count by simply locking
> > the folio, and doing atomic_cmpxchg on swap table with folio locked
> > will be safe.
>
> I=E2=80=99m still missing this part: if the long stores a folio pointer,
> how could it further save the swap_count?

We use PFN here, it works very well, saves more memory and the
performance is very good, tested using the 28 series patch which have
already implemented this:
https://lore.kernel.org/linux-mm/20250514201729.48420-25-ryncsn@gmail.com/

>
> >
> > For now using atomic doesn't bring any overhead or complexity, only
> > make it easier to implement other code. So I think it should be good.
>
> I guess it depends on the architecture. On some arches, it might
> require irq_disable plus a spinlock.

If an arch can't provide atomic for basic access to a long, then that
justified the usage of atomic here even more.. The read has to be
atomic since swap cache lookup is lockless, so the write should be
atomic too.

Xchg / cmpxchg is a bit more complex on some arches, they are optional
in the swap table anyway. We can use them only on arches that provide
better performance with atomic. I believe most arches do. For the xchg
debug check, it can be dropped once we are confident enough that there
is no hidden bug.

>
> Thanks
> Barry

