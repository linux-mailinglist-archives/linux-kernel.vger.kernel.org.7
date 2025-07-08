Return-Path: <linux-kernel+bounces-720887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F11AFC1B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0544A78A4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2213215F7C;
	Tue,  8 Jul 2025 04:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7Qv10m8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777C31EB36
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 04:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751949459; cv=none; b=Bo9+X5IZAtdPuaodjbSAiTpBirQ/y767Zlrrvjfgu3vH9y7Or0vkKom2qvlObD1x9/rHnWkUaAu/AFkeIAzc+4TiYaKXsluLW7DGzn6Bg8MnP6qhyfgJBZk9bKulLi8hdQ6wT0HP6AdMRqIFcSm03foZHWxLWcgwhIj8V1YpFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751949459; c=relaxed/simple;
	bh=b5vO5xEj60Grv2Tz4UL3AbMISKiZmYV9+f1qywuzGCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKQLSKnUwseroRrIBzPK95GqKSBwQivr975sFnGVTOG2AxGAwBV1MfTXnnzjimj5eDut1DsEtwrqSk1Y10Sqi5yZ67H61/DqUH8C5nfb+6dVL38xeUgiwoA4chICaIMGbBoFqm+3Ajyb0/nOAcVfpuH3cZCuo/blLNmRP30iAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7Qv10m8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751949455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vcnyx0JysJh5mE8hUE/Z7n/Nl7TxrgUShK09fRyB/o0=;
	b=Q7Qv10m83IeHeKw20lxnxzLfPQG7F59Jyz5Yo0QsIfzRv19b2xvaJ1wkORz+ZJb3wYqeyq
	mVPtCtOqmnVwGLg4BGqx9Zndo/OmCi8uRHU3lmYRtI/J8iOnLrfysCbs0RlWlwks8AhrV4
	nHGzcWx5y0PqTInVYAdkwXicOp5++rE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124--RDMwpq3PUOZFxZLbbwPkA-1; Tue, 08 Jul 2025 00:37:33 -0400
X-MC-Unique: -RDMwpq3PUOZFxZLbbwPkA-1
X-Mimecast-MFC-AGG-ID: -RDMwpq3PUOZFxZLbbwPkA_1751949453
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7111c6e53a6so55484767b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 21:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751949453; x=1752554253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vcnyx0JysJh5mE8hUE/Z7n/Nl7TxrgUShK09fRyB/o0=;
        b=UNhBQC7a8a1+JprLy4xDM+PU6nFfXKYBGa9sdTaTDkyRDpyQjfdPNSlHbjVpwinCas
         bGE/DnFDgMHUB0SGK2ITWv+C+GFWT1KMa/m1Eth3u07SbrCnwUjW+i3q3wPgvrmTgNZR
         Cr7YBme6lC8tk5M9h/nOG5H3ttp2Nl8+03WFGsQIN7N5lKIzUEHkuYjxw9U460DKsqjp
         QzGaEtU0+D+JYdKVFIixwc7DOPSPD2GhbM2M11YMIec7UAPZNUmxf4nXLP74E8Wt95/h
         FiSj42HzL6oKrVJZYAgZuJ7MV9Loonj4LZ3QEurtxDn7ZMc1QXLz7xKRDhpdC6RWa9yV
         HKEw==
X-Forwarded-Encrypted: i=1; AJvYcCWjawYl7YLK5/r9hxtfYpWpn1FlCCAkpVqvCKbbzw0YYDcgZ53JvhHtaqn4kucEiDWIaZZwuASRXPYrYM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ3iqD8bZ8fWn9y7LQWok6i4evZWH6UqcFfZa9i7a4VWT3bikr
	vntVGFeEf7rDs114odVyF5fwXbTWQx3QE8ieb+s1IOT760OJAXQxNxcBmemJKtXE7qW2sbKtCeQ
	uOKNzTjjwITxEv7S3Jm2w8eR/Lhz3ofD2vn0O3GZqwuLsGB5BxrkVGcYJIhxoXzN7GSuKInJX2u
	xGkMf0F9Sw9LdhBdud7QLa8KB0I1cql82LHXOA/ZqA
X-Gm-Gg: ASbGncuJMer71zKhqltNQd0wCjGfMO5r1wVYMIl7NnginEoDxR5Vsz3oW4Y1+JUxqcP
	glP2e4t+jIfpPY2miOd/++2BrO6/ZkrZwdEHUNvMUqDWCAQlsyk0RGxPYMvrWPvSgEcsw1jFiuM
	5LkexOdg==
X-Received: by 2002:a05:690c:6f83:b0:70f:751c:2d8a with SMTP id 00721157ae682-7179e37cd3fmr32458527b3.3.1751949452965;
        Mon, 07 Jul 2025 21:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbO6Izd1pPXIOqZntc0uu12GmXD8DRIghOcq4/FPxcWuJc0kOyYzeWaxrjFUAr/IBNtPUh2LiSWdlv1rQ3kY4=
X-Received: by 2002:a05:690c:6f83:b0:70f:751c:2d8a with SMTP id
 00721157ae682-7179e37cd3fmr32458287b3.3.1751949452399; Mon, 07 Jul 2025
 21:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702055742.102808-1-npache@redhat.com> <20250702055742.102808-12-npache@redhat.com>
 <2f6d9541-8083-4d3c-a9c1-cba0d5bf98a0@linux.alibaba.com> <20250704141422.359c89146ad69512b9be4902@linux-foundation.org>
In-Reply-To: <20250704141422.359c89146ad69512b9be4902@linux-foundation.org>
From: Nico Pache <npache@redhat.com>
Date: Mon, 7 Jul 2025 22:37:06 -0600
X-Gm-Features: Ac12FXyt1IXC4VHFfBXrxUd6UW59TrJJWs8JdbZTinihEwjJ8-ZwuAsNadFXc9I
Message-ID: <CAA1CXcDkr8itrXiuVq+Tck1hkRwgq-byXCcM3oHqy1dXOhhTTg@mail.gmail.com>
Subject: Re: [PATCH v8 11/15] khugepaged: allow madvise_collapse to check all
 anonymous mTHP orders
To: Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	david@redhat.com, dev.jain@arm.com, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ziy@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 3:14=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Fri, 4 Jul 2025 14:11:13 +0800 Baolin Wang <baolin.wang@linux.alibaba.=
com> wrote:
>
> > On 2025/7/2 13:57, Nico Pache wrote:
> > > Allow madvise_collapse to scan/collapse all mTHP orders without the
> > > strict requirement of needing the PMD-order enabled.
> > >
> > > Signed-off-by: Nico Pache <npache@redhat.com>
> >
> > I am afraid we should drop this patch from the series, since Hugh
> > explicitly opposed my modification of the madvise_collapse control logi=
c
> > in this thread[1].
>
> Well it drops easily enough.  I don't know if it compiles yet.
>
> Nico, can you confirm that you're OK with the droppage and that the
> series is still good without this patch?
Yes that is fine, it shouldn't conflict at all. Although this isn't
the only patch that will need modification... Ill reply to Baolin
inline here.
>
> > Moreover, since we have not yet clarified how to handle the conflict
> > between the semantics of madvise_collapse and the THP interfaces, we
> > should keep the current logic[2] (means madvise_collapse still only
> > allows PMD collapse).
Hi Baolin,

Sorry I saw most of that discussion but missed that point by David.

We should come to an agreement on what the proper approach is, because
if not we'll ALWAYS have this problem and NEVER solve it (pun
intended).

Jokes aside, if we are leaving MADV_COLLAPSE untouched then I need to
make some slight modifications to this series so that MADV_COLLAPSE
never tries anything other than PMD collapse (should be a pretty small
change). Dropping this commit alone does not achieve that, but rather
just allows MADV_COLLAPSE to work if PMD is disabled, and one other
mTHP size is enabled. On second thought this isn't great either as
MADV_COLLAPSE ignores sysfs, so if you have any mTHP size enabled, it
will still continue to collapse to other PMD+mTHP sizes... wow this
really is a mess.
> >
> > If madvise_collapse is to support mTHP collapse, there will be more
> > semantic conflicts to discuss.
I guess a V9 is inevitable, I will drop mTHP support for
MADV_COLLAPSE, and drop this patch too. I'll let this series sit for a
week or so to gather reviews (and make sure nothing else is missing).

Thanks,
-- Nico
> >
> > [1]
> > https://lore.kernel.org/all/cover.1750815384.git.baolin.wang@linux.alib=
aba.com/
> > [2]
> > https://lore.kernel.org/all/23b8ad10-cd1f-45df-a25c-78d01c8af44f@redhat=
.com/
>


