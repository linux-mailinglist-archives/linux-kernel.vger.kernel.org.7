Return-Path: <linux-kernel+bounces-814916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF7AB55A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60754AE3C90
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC5229E114;
	Fri, 12 Sep 2025 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dHuSQE/5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F9265CC9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719943; cv=none; b=KuhfhMv4F5ut2E9iRf5h0Q3tMir/tyEDu95vVROg1/L68m3R4Apbhfskmv6Nli10W+zOrMX8rzJtrUSlCf4dr00UcslMNhkHNdi5hiNYwu0qipHYAXNMBiUGrulntWMs9x2AQPlV9pn7zOTwQ03HQ4cMlsRRRXOfazijB2MiYOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719943; c=relaxed/simple;
	bh=qeJiLUczh+jDUEzC4NUWxpIlCOTOGxO/IeLpeysMhqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikrYuxKxSu5Ro10O8Z3KTDIp0+gcaMIFXA5ODUsPmLdH/Y5blOYe19Cm7Ghj5BCAcFpvQk8lMDCnatIrQ2knc2NgqCpYkumw+SD8X0ROmIbsKA0Bjg4N9FaAu5wHFJ7RVp9QRRJp8/OExVZ5z6aXeJu3kKVRZulXV1w0orTjjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dHuSQE/5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757719940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeJiLUczh+jDUEzC4NUWxpIlCOTOGxO/IeLpeysMhqw=;
	b=dHuSQE/5siqG9tBlBOn2LMlAYiLRu1bp6AIk51BblBiW3eI4AX6vUYzD0eWlymm511Rp2R
	40Fo7kss/Gnp0VmdDr9rmlrC8EBPyMYubUniptmCw9fQ5DVkS4q/6FwUjKmp9Z7RitT08x
	gFaWFSaaZj5HvURG6vp2/usFaxrbQaE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-OCiJyBD7Plu3PL9R0PkD-A-1; Fri, 12 Sep 2025 19:32:18 -0400
X-MC-Unique: OCiJyBD7Plu3PL9R0PkD-A-1
X-Mimecast-MFC-AGG-ID: OCiJyBD7Plu3PL9R0PkD-A_1757719938
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-71d60163d68so36140237b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719938; x=1758324738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeJiLUczh+jDUEzC4NUWxpIlCOTOGxO/IeLpeysMhqw=;
        b=glRLA9XBFi4RslqkdBt+un80pk/pebtDdCyKZ9oeLB1Ov3UsOGxiWnCqy3iHSNr3KI
         Bp469aVxgLEZbDqUOWYsq8/bBF2lZ3NSuxeOx0MuB2CRfyrrf69dz+dYa1iEjRXHs631
         qdCPm3rD0ac1Fe6anq20FAhT5ifDXuhVW4WH1drK9P+68LYlLQ9IPhwJd1J8yeBWc79m
         9fRZEHyOwd8mVz1w19/2l86YA56hu8GsDQOe3DHFBHZByAK9FaVnHyo4YPBjPxoKbnyX
         Hau4HoKi8ZitANRazesvsD4E8EIiPb+B4LEJN4ZYU97ouZiFb5pq8f82OHYIJoYJf/0k
         TN9A==
X-Forwarded-Encrypted: i=1; AJvYcCU4hSaOk9C7BU34/PF+A8J3oE7ocIl1O0mjjnjkHJ/7MxWEns5Ivf2VGT55D616bEv+YfcK0CQstjfLKi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1yzRkJguPlVu7yylFaBB5CSlXoWOX12d1jgTmTIfygi/FLZa2
	c1VK7T1fq5MgaagcaI7uDtvKmeyTAd6FUx2nBxawaDQebDZRibR3eAu1GFhpl2RMSJzimKQIxyb
	+3PrSfKq2bt2Ew1oD/2lWzmJVJqy32KpgzprmcjQXCZuuRgJfBF9a9XivzSboYQ4xdGBMhSaIpS
	dqSCPNODWYyq7kPVlErIBsnC+VmD5FTjPxk7wdxhu0
X-Gm-Gg: ASbGncuCaQmzKhV+HmLJ+Fb4cwKAuaTCh2yUkiAy0B6hBwe6VTmiwZSS6W3qCuuX9US
	IT4eI90cbk1P/hRZXIUlhr1mVXIoCH7D6iS6U7Q4V8mV7n4TQL9gVKSTO8EuaO6Df7t/8EAeueV
	L+rKd3GG9cBwcIwPc7luHIP+vQH2Pn7MFLVU0=
X-Received: by 2002:a05:690c:6d01:b0:71f:b624:323a with SMTP id 00721157ae682-730631915bcmr48747717b3.22.1757719937531;
        Fri, 12 Sep 2025 16:32:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK1z++fo1VlAXjdvZLZjfG0xFXeJ93pQE2PD3RXY0X2Ke9QcK3xuGmHvpnFUlHapj1cPtD8bnkIBPCoxV0I88=
X-Received: by 2002:a05:690c:6d01:b0:71f:b624:323a with SMTP id
 00721157ae682-730631915bcmr48747047b3.22.1757719937032; Fri, 12 Sep 2025
 16:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912032810.197475-1-npache@redhat.com> <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
In-Reply-To: <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 12 Sep 2025 17:31:51 -0600
X-Gm-Features: Ac12FXw_TS5TScQ8j1sWTJVRrVUFEA5RkwbW-1v00F8cU_6m8fECtZnnxeVB4sc
Message-ID: <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>
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

On Fri, Sep 12, 2025 at 6:25=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 12.09.25 14:19, Kiryl Shutsemau wrote:
> > On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
> >> The following series provides khugepaged with the capability to collap=
se
> >> anonymous memory regions to mTHPs.
> >>
> >> To achieve this we generalize the khugepaged functions to no longer de=
pend
> >> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track indiv=
idual
> >> pages that are occupied (!none/zero). After the PMD scan is done, we d=
o
> >> binary recursion on the bitmap to find the optimal mTHP sizes for the =
PMD
> >> range. The restriction on max_ptes_none is removed during the scan, to=
 make
> >> sure we account for the whole PMD range. When no mTHP size is enabled,=
 the
> >> legacy behavior of khugepaged is maintained. max_ptes_none will be sca=
led
> >> by the attempted collapse order to determine how full a mTHP must be t=
o be
> >> eligible for the collapse to occur. If a mTHP collapse is attempted, b=
ut
> >> contains swapped out, or shared pages, we don't perform the collapse. =
It is
> >> now also possible to collapse to mTHPs without requiring the PMD THP s=
ize
> >> to be enabled.
> >>
> >> When enabling (m)THP sizes, if max_ptes_none >=3D HPAGE_PMD_NR/2 (255 =
on
> >> 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 f=
or
> >> mTHP collapses to prevent collapse "creep" behavior. This prevents
> >> constantly promoting mTHPs to the next available size, which would occ=
ur
> >> because a collapse introduces more non-zero pages that would satisfy t=
he
> >> promotion condition on subsequent scans.
> >
> > Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
> > all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
> >
>
> I am all for not adding any more ugliness on top of all the ugliness we
> added in the past.
>
> I will soon propose deprecating that parameter in favor of something
> that makes a bit more sense.
>
> In essence, we'll likely have an "eagerness" parameter that ranges from
> 0 to 10. 10 is essentially "always collapse" and 0 "never collapse if
> not all is populated".
Hi David,

Do you have any reason for 0-10, I'm guessing these will map to
different max_ptes_none values.
I suggest 0-5, mapping to 0,32,64,128,255,511

You can take my collapse_max_ptes_none() function in this series and
rework it for the larger sysctl work you are doing.

Cheers,
-- Nico
>
> In between we will have more flexibility on how to set these values.
>
> Likely 9 will be around 50% to not even motivate the user to set
> something that does not make sense (creep).
>
> Of course, the old parameter will have to stick around in compat mode.
>
> --
> Cheers
>
> David / dhildenb
>


