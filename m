Return-Path: <linux-kernel+bounces-816829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEA8B578B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B1B1889E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCD82FE071;
	Mon, 15 Sep 2025 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAdJy6B3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6AD2FDC5B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936525; cv=none; b=Aqwf9fkGoKkogNHa5VXI0UczE6+fFd9wcobFpkLGPgsrK28JJSS2/9iH3Kq6Osg3gCRATaR5Mfg9LUWTHalLzP3uXhY5Kd4+CKli69ioYjE4bP6tpUOUEg7zgMbE42hfGJmBjQSh3MDx5mFh9vjKVVT+oILHJIVutqoQli8tHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936525; c=relaxed/simple;
	bh=9j72QmhsqB74V4C6qWKqtBe8qEQaSrBhHkbtgRSnVec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0m4P79xiZtu46LGfHkEpDAmR3NEOnkb3YFAbMMx1YB3Fc8QYeF55ByW28I0qaF0qx5lp0s4BTY/C2GTOourv/v6U6K5hRaVesDqwnMFTvAy5RHR9/9416p6uUTD29eDNzUjg3u2PmMepoC5kPEJyay5aVDSfCnDmZC6n9H2IX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAdJy6B3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757936521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jetKzgnC0kf/tMxkplSpD2U5KJC1XxnyLmVwB6VPHc8=;
	b=AAdJy6B3LCo/c8gyzNPuXdrWjkeneRgY8H9nRPnfL6KkrmguJlJ9V9JolAB+8rXeBF0Svj
	DUgy6D0mz+EXxdGyxTCYQWNygfOba3Wm0Bqy7FYR2tT3FW+gcsy/oibUT80Q51mKSgoBf8
	GmhJ5A+/dSz6QXGpco86UOfvBXZvolE=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-wSZhr9g1OXeyFZqtC53vpA-1; Mon, 15 Sep 2025 07:42:00 -0400
X-MC-Unique: wSZhr9g1OXeyFZqtC53vpA-1
X-Mimecast-MFC-AGG-ID: wSZhr9g1OXeyFZqtC53vpA_1757936520
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-62ee449104bso1030315d50.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757936520; x=1758541320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jetKzgnC0kf/tMxkplSpD2U5KJC1XxnyLmVwB6VPHc8=;
        b=VB+AR3TnBNwO3rXPgTtlcNiUD+tYQuucsE0pBMieohR8RimZHhwGN3J4hiRpoyyEgw
         bnIPio541ZAR8PER6kh8a0Sm4ET+8WbC72E9bwX6/oYaeQJXtN5Xxrzu44Vqr1V0TTYj
         HSH8tPMbKulsMejzJ6eg1cKOdpQDBkPNIo8w6ydXidVwgJ+s/Hh1H7Boljr5vhNBdk7n
         Ou+xsu2Z/Hwo0gYNR7DI8Wtr+fpddDl7nGngWetv1rJwoTLaZQ/5RJ+MFrR1RU5pih4i
         6uyP4SLzMgbUkLhM9+LfRYVPSISk+spgaTsz3OG3Emq5W08bcsTmS/8Fo7mxjZzLBaUW
         tE/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDO+65Bd42zKSCEl6rIs86/irN0nloTjbR8/AB/nWKcBOMn9C7HPaDdaUhEeDsE901rkK/ccISr8Yw6tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytHaKR+y/BcGlMuZfDqcZDkVunSXzHHNRcvqRQwFQ4slnS7ZpU
	Qi73CYO5p9j1GqXrpUYmcHJpXHIsVZqqvuJK2ynDegcefVrTWhXA0OuraIuxPP2wKLP7lITOLFj
	XNuSK8Zex/MQwkJvRWgSzajsvnW//S45Mup8QNP51sNeiN6EJDK05i6GIEskE0+XVVbUFeGga5G
	hhmcUhzQ4DHiuHI52iuUn+p1RH/j9pyvEy5F6/wZp8
X-Gm-Gg: ASbGncuhn5Pd3iQRDRH5EmqLaOt3wNt3/y4eEBUmbc3ipzt3/MmTDad1xTuj1TJWnCN
	yfyOB3klx+cJPG5HxB7fR+OtudpHJISh7o88apSZFJYZGpHD0nvO+ZO9HJ6/Iowkh1SvTIDC76d
	6op0jOjLBLI4TUqQCVMRoSmoAr7optRfBrPzE=
X-Received: by 2002:a05:690e:154f:10b0:600:f8c2:2264 with SMTP id 956f58d0204a3-6271e757025mr8221734d50.7.1757936519610;
        Mon, 15 Sep 2025 04:41:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+2fM9emJqvUpuZ268rgUX/jln8QeTUIjYl3juPQj3Z71mljgmQdIGdpez0kkKWnT/IJwGwmxXt26NdlfJBT0=
X-Received: by 2002:a05:690e:154f:10b0:600:f8c2:2264 with SMTP id
 956f58d0204a3-6271e757025mr8221675d50.7.1757936519121; Mon, 15 Sep 2025
 04:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912032810.197475-1-npache@redhat.com> <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com> <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>
 <enrgrocqajwu5d3x34voghja7pbvau45oobxgabawrly44ld4u@ahch3xn6rtq5> <cd8e7f1c-a563-4ae9-a0fb-b0d04a4c35b4@redhat.com>
In-Reply-To: <cd8e7f1c-a563-4ae9-a0fb-b0d04a4c35b4@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 15 Sep 2025 05:41:33 -0600
X-Gm-Features: Ac12FXyJM85m-bPFRumN9WnXWH69lYhLxvXB956KqiAEAlRwvSQY7icqmcQvpts
Message-ID: <CAA1CXcD1BhXqYM7oOTLuqPHyWSztdCEk462sYXFXxJCmOpe_Rg@mail.gmail.com>
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
To: David Hildenbrand <david@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 4:22=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 15.09.25 11:22, Kiryl Shutsemau wrote:
> > On Fri, Sep 12, 2025 at 05:31:51PM -0600, Nico Pache wrote:
> >> On Fri, Sep 12, 2025 at 6:25=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 12.09.25 14:19, Kiryl Shutsemau wrote:
> >>>> On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
> >>>>> The following series provides khugepaged with the capability to col=
lapse
> >>>>> anonymous memory regions to mTHPs.
> >>>>>
> >>>>> To achieve this we generalize the khugepaged functions to no longer=
 depend
> >>>>> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track in=
dividual
> >>>>> pages that are occupied (!none/zero). After the PMD scan is done, w=
e do
> >>>>> binary recursion on the bitmap to find the optimal mTHP sizes for t=
he PMD
> >>>>> range. The restriction on max_ptes_none is removed during the scan,=
 to make
> >>>>> sure we account for the whole PMD range. When no mTHP size is enabl=
ed, the
> >>>>> legacy behavior of khugepaged is maintained. max_ptes_none will be =
scaled
> >>>>> by the attempted collapse order to determine how full a mTHP must b=
e to be
> >>>>> eligible for the collapse to occur. If a mTHP collapse is attempted=
, but
> >>>>> contains swapped out, or shared pages, we don't perform the collaps=
e. It is
> >>>>> now also possible to collapse to mTHPs without requiring the PMD TH=
P size
> >>>>> to be enabled.
> >>>>>
> >>>>> When enabling (m)THP sizes, if max_ptes_none >=3D HPAGE_PMD_NR/2 (2=
55 on
> >>>>> 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - =
1 for
> >>>>> mTHP collapses to prevent collapse "creep" behavior. This prevents
> >>>>> constantly promoting mTHPs to the next available size, which would =
occur
> >>>>> because a collapse introduces more non-zero pages that would satisf=
y the
> >>>>> promotion condition on subsequent scans.
> >>>>
> >>>> Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
> >>>> all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
> >>>>
> >>>
> >>> I am all for not adding any more ugliness on top of all the ugliness =
we
> >>> added in the past.
> >>>
> >>> I will soon propose deprecating that parameter in favor of something
> >>> that makes a bit more sense.
> >>>
> >>> In essence, we'll likely have an "eagerness" parameter that ranges fr=
om
> >>> 0 to 10. 10 is essentially "always collapse" and 0 "never collapse if
> >>> not all is populated".
> >> Hi David,
> >>
> >> Do you have any reason for 0-10, I'm guessing these will map to
> >> different max_ptes_none values.
> >> I suggest 0-5, mapping to 0,32,64,128,255,511
> >
> > That's too x86-64 specific.
Its technically formulated from:

X =3D ( HPAGE_PMD_NR >> (5 - n) ) - 1
where n is the value of eagerness and X is the number of none_ptes we allow
so 5 =3D=3D (512 >> 0) - 1 =3D 511
     4 =3D=3D (512 >> 1) - 1 =3D 255
     3 =3D=3D 128 - 1 =3D 127
....

Any scale we use will suffer from inaccuracy
Currently this fits well into the bitmap algorithm because the lower
you go in the bitmap (smaller orders), the more inaccurate the
max_ptes_none (or any scale to that matter) will have on the value.
for example: a 16kB mTHP is 4 pages. you really only have 4 options
for the number of none_ptes you will allow, so any scale will be
rounded heavily towards the lower orders.
128 (max_ptes_none) >> (9 (pmd_order) - 2 (collapse order)) =3D 1 none pte =
allowed
255 >> 7 =3D 1 none_pte allowed
no value inbetween these has any effect
where as
127 >> 7 =3D 0

So using a consistent scale that is relative to the number of PTEs in
a given mTHP I think is the most straightforward approach.


> >
> > And the whole idea is not to map to directly, but give kernel wiggle
> > room to play.
>
> Initially we will start out simple and map it directly. But yeah, the
> idea is to give us some more room later.
>
> I had something logarithmic in mind which would roughly be (ignoring the
> the weird -1 for simplicity and expressing it as "used" instead of
> none-or-zero)
>
> 0 -> ~100% used (~0% none)
> 1 -> ~50% used (~50% none)
> 2 -> ~25% used (~75% none)
> 3 -> ~12.5% used (~87.5% none)
> 4 -> ~11.25% used (~88,75% none)
> ...
> 10 -> ~0% used (~100% none)
I think this scale is too specific, I think it would be easier to map
to the one above for the reasons stated there. There would be little
to no benefit to having such small adjustments between 4-10

Let me know what you think
-- Nico
>
> Mapping that to actual THP sizes (#pages in a thp) on an arch will be eas=
y.
>
> --
> Cheers
>
> David / dhildenb
>


