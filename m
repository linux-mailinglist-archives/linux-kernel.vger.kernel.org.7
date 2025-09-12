Return-Path: <linux-kernel+bounces-814918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE034B55A5E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85C51CC5121
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10EC2C0272;
	Fri, 12 Sep 2025 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScTQ65BQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465C283FC4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720136; cv=none; b=DYs1Xl8u56Z6cl3gt4sOJyCfc0fx0feyk9s7L+t5yVzgegyVgVn39c3dgBCIup6AMdAh4DrLWNN1B0JLCbq8rJgviJpgRdAujE6Itln/zMSBaBFUVgZ4QxXJ92+NH6iiS2ZdZSZZtu7RaudOOLoLG4bhXH94BXSvq43LTtgkp7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720136; c=relaxed/simple;
	bh=HPCu1pwVM4Drx10GdaCY7ng58mnQe58dpSzFUAkQI+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=clhSK8EyZ6/8v/VP5D9K36HWd79DV4zvGWb9Q7JROpA9p+x3P5jPymX9I4PirWPSYLFVRa/XZ6yOtxZxgMuSChMn5MoSrjfhzH8uP5a6zngO4YiSDeD62r498vFGraRRyFMqS3g5P9PogF5M9JXaBUtVX/LTe+cJZTuiaCUDriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScTQ65BQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757720134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPCu1pwVM4Drx10GdaCY7ng58mnQe58dpSzFUAkQI+A=;
	b=ScTQ65BQwwRj/Z5fI8iKcxH2hBZRQ3XNLOAYgWZr7KYBUWk1c+XwBOS57vv+oQ7l8RaDSG
	hxJ9w8njRSGtKzTeEl+pm8VNRK92WIVLwX0CApIn/iX9X2kexB2iYembG5C+ERsBrzyMvX
	4uFh9ZlvxPBbvPG3Z3YDz4LyTQO4gLc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-lMqAe8MZMUORXGyzsH14vg-1; Fri, 12 Sep 2025 19:35:33 -0400
X-MC-Unique: lMqAe8MZMUORXGyzsH14vg-1
X-Mimecast-MFC-AGG-ID: lMqAe8MZMUORXGyzsH14vg_1757720132
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-72390769037so24529887b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757720132; x=1758324932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPCu1pwVM4Drx10GdaCY7ng58mnQe58dpSzFUAkQI+A=;
        b=BMlrHodPVH07Zx84nfzUIRyRHKifkiwfkINJiGuCNUq89pq3NGfe79vTkhILrMMzXA
         F/yYzFdg3vIs+/tmAYO2yHbfVjhey/dAAjNXOU3hQU2dLKvLi3bMSOvaBiLE7yOKEwUM
         40ly5WZ/lu6tYt2PV1htWBRFh/0ERTzHIJut2q2A40AyyAcyHhbEtmjmc6+sHe0W1uzM
         yVV7WyaJXu0IkxWQ9f1P4PhqcB+RHq44EtfTN6g/c/CaIZ6HOSvpY+o5lZX4h/WMNR/S
         Dm8rPpAGOJIYg0cf1h7l+k3belJ4DsY+JV8zZqmWdm44SEW2mWfylOGH7rkd0jPeO4om
         u7lw==
X-Forwarded-Encrypted: i=1; AJvYcCWO8eG9O8GW/UfTWuR72srY4nd7nF28AAS01MhRX10AxPNqtow19B4Mz2hUtYqpGpwEuQKjry+HHkqQyd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuAkl5awjz/OZP6BliNl1Mfx2k3kNiKPVr5TLJMoMHUbskBBuB
	UW9+KZcbfbkoLeaOvA1Gq9stuwJGNFF4mZ1dU9yickMC65Yf2p13sh5CQZ+5ZLpmP+ih3lQTfO8
	Xe580mRxj8vt9G6AXsLo2YhapMrJ8+ZGa6Cpj1Xi6JHi9HlGjJiygJbO21puAu1BMvpgZQCnApC
	QQBgf+DIjyUJm7JKzqkm4uBO6gJ2oyUmTPMT+hjztn
X-Gm-Gg: ASbGncsUq3xPvUmgxoEiqOv5NbuAqST9Er3P2CVEp5hIg3RdU0tDA+pwnmHnvYfN4Sc
	od8hmlQi0jLsDnJoqyyQBdFfJiCtTSlWRDUZVhndu4ymszMyAHXCuANanO0YQkG71wSgXUNx++0
	26kep61sxji0gNSApi1IUx35HjHH4Wd7ZHD+I=
X-Received: by 2002:a05:690c:6ac2:b0:729:677e:b7b with SMTP id 00721157ae682-73065fa0c40mr46615307b3.47.1757720132260;
        Fri, 12 Sep 2025 16:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf6FRXt0puU/GkbiNMmkdOBMh3PmcUJa8ItdRIcV21DzC27xRjlQRyXSqK3+grheHlKb8t0P44+F+NVaC7sWY=
X-Received: by 2002:a05:690c:6ac2:b0:729:677e:b7b with SMTP id
 00721157ae682-73065fa0c40mr46614957b3.47.1757720131865; Fri, 12 Sep 2025
 16:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912032810.197475-1-npache@redhat.com> <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <43f42d9d-f814-4b54-91a6-3073f7c7cedf@redhat.com>
In-Reply-To: <43f42d9d-f814-4b54-91a6-3073f7c7cedf@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Fri, 12 Sep 2025 17:35:05 -0600
X-Gm-Features: Ac12FXwW-JyuDr21ldb1iQAOW2JaSV_ia9I1rYO-9C_34jUWMMoQfpgn4vajl84
Message-ID: <CAA1CXcAenBm4=V1=-bXmruL85MfyqTXu5_-BmzGfOEaQ4z-Tdg@mail.gmail.com>
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

On Fri, Sep 12, 2025 at 7:48=E2=80=AFAM David Hildenbrand <david@redhat.com=
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
>
> BTW, I thought further about this and I agree: if we count zero-filled
> pages towards none_or_zero one we can avoid the "creep" problem.
>
> The scanning-for-zero part is rather nasty, though.
IIRC me and David have discussed this in the past and decided to avoid
this approach at the moment because it would be complicated and
"nasty".
>
> --
> Cheers
>
> David / dhildenb
>


