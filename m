Return-Path: <linux-kernel+bounces-826442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D64B8E8A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07851164B66
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DDA25A642;
	Sun, 21 Sep 2025 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PYp+qLmQ"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411FE25785F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758493289; cv=none; b=ucdq01GuIs3fCa3k99VotdFaM6/m0F+iGf7sgOjiQEecbc8gAznUVNkSXZB8mC2StV8vOJGNn0HDVa+/lwoNbrGDTK0jK3WN2ZAUSicaj795vhdgxI0NHYFsyLwwqMKJK6BdqxEKtyamExD5TbWbgG6diJR9UYxt+rM5qBcqLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758493289; c=relaxed/simple;
	bh=6oei0aWXFhVRzFAC+ZsItJg6xnA+dZu9f+eLcagd27c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxUsQ5ORQJ06rKJI79Xqx21dKfdRTR/LNbGnoyRLUY5/BAOncMunJ3zJqcQLCGR4CazinKSkU3mgR/zmMDszzeMVjYN9QwiLtdymsIxq/ykQLxRtlPaCQgTQK7KLKP+l6ky4SexRQMP/zDivgOIICx0Zeg7hwfdZULapwOAP8Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=PYp+qLmQ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b3d3f6360cso37567951cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758493287; x=1759098087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHLyAWNRRvZ698aiszn9fxUOIJUP3t6BL2WpPwYPRag=;
        b=PYp+qLmQxDpcmaKJAmXMNT4GUpKlnhY6sJMKA98L5JO9raId4BOtZqe4WvAc8WA1zg
         tPLT7hLlrHPZWi7qcn9VILdX7yuKmgioYSnnb6UVNzkerEruUta/TsokQD6GY3314ZLk
         PpFK6/80wRa8dfWftRO3ku1Ayr/N3gSR1QeuLFUNLW0QEChYKfSRh4UDtSAy10HGjtFx
         8U15lT76FdDnIJqfvDxXx+5aBa/a2jzoc8JBxh6ggMbtcG3XqkYEGyRbJPYeEXA9ae9d
         mW9rrKbYxoZ2k9LtHic6v7oeBw3FTSwXE8PjL8G/hukziGsKDx+P5tU46dvcVEIuNl1J
         bDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758493287; x=1759098087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHLyAWNRRvZ698aiszn9fxUOIJUP3t6BL2WpPwYPRag=;
        b=jg9DKLsBegWPMLbPbdnCOKtGgncLT/nfKK8omNOZrTL8JBOCF9qbQHoZJQa6Vx/4ct
         fvWdOEPPOwxkMVVw/ZmVBgN0xqve3tCn1QRT/hnk61evR6O0EWdXwR3RxTQFUJqafOvP
         Vo9JxYvoSW18fQC97dSx7Wacyz8Y2DdVJCjl4tdcud0M/+FB1d9E6EEYwKBuPPwiFJi3
         yM0ClAfdoV1tf9widTLkPIS25an5L2Y+D1hRKPEwoLzsmGSawx8q+Af8MDShNJ5NQmZo
         l8tE+2tya2HrDScrm7VFpvC45ID9H6cMr2CQxFqitOvy5/flqLl2RHf7Iv0QumiQsIJ3
         prIw==
X-Forwarded-Encrypted: i=1; AJvYcCUsU0FzJ2VZGwdupsWJLekYFmELkm4QIzO+9cIy6FJBDjw8l3B0IWD7x+dkjBUW2gle1hj6KXqk93dmnbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbsGMKy7j1aWOTrwMj6Bdw27IYeYmpbgK4yKRkQ32eDjsdCgSl
	VovUV6s2tD1yixJLxpnvIP2Cs9Q7mYxgkreFVD5slAlIRQHc4YliBX4MQ+ZAQV2i0/JYbFpJUpq
	MeZVd+ljttIyn0g14vYlgsBdufjzwKmsXSzjPzODC0w==
X-Gm-Gg: ASbGncvVYnfBeF1CaIxBKSqcZkrh7iBwIGuCtTXSIU3G9Ll2WpFWAg4a3xyLoMtcvqt
	fMhLdwabp9o678ojhk3n0jgh57vnmoFnFj5Ex+77vUvN8K+Uz8VjTKvw6mbbqhBi2+zq0uPYiFQ
	3ANZuwvjuNDcK1fjkSs1+fd4Vs5eZ+l+N9z3WkurE/aHpFAHznfshQ5eXiEZtYP+g9Yn5yFKDq8
	7KYbKc=
X-Google-Smtp-Source: AGHT+IF9Bd/LCK7h6/iC83qqAy9wLiFHaZDvz7ruwA4mtaZ7EwXHPx8srwbwmVkArl3yVoSLBLTkv5dGYhCDZ5ZrJps=
X-Received: by 2002:a05:622a:4c06:b0:4ca:10bd:bae5 with SMTP id
 d75a77b69052e-4ca10bdc5dfmr21648151cf.81.1758493287147; Sun, 21 Sep 2025
 15:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <20250807014442.3829950-8-pasha.tatashin@soleen.com> <20250814132233.GB802098@nvidia.com>
 <aJ756q-wWJV37fMm@kernel.org> <20250818135509.GK802098@nvidia.com>
In-Reply-To: <20250818135509.GK802098@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 21 Sep 2025 18:20:50 -0400
X-Gm-Features: AS18NWCcd-5oq0uHFf03h4LWbprCKHRBHh45SwiCRQil-ZYQKwKcHW5Zv6e3HKA
Message-ID: <CA+CK2bDc+-R=EuGM2pU=Phq8Ui-8xsDm0ppH6yjNR0U_o4TMHg@mail.gmail.com>
Subject: Re: [PATCH v3 07/30] kho: add interfaces to unpreserve folios and
 physical memory ranges
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mike Rapoport <rppt@kernel.org>, pratyush@kernel.org, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 9:55=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Aug 15, 2025 at 12:12:10PM +0300, Mike Rapoport wrote:
> > > Which is perhaps another comment, if this __get_free_pages() is going
> > > to be a common pattern (and I guess it will be) then the API should b=
e
> > > streamlined alot more:
> > >
> > >  void *kho_alloc_preserved_memory(gfp, size);
> > >  void kho_free_preserved_memory(void *);
> >
> > This looks backwards to me. KHO should not deal with memory allocation,
> > it's responsibility to preserve/restore memory objects it supports.
>
> Then maybe those are luo_ helpers
>
> But having users open code __get_free_pages() and convert to/from
> struct page, phys, etc is not a great idea.

I added:

void *luo_contig_alloc_preserve(size_t size);
void luo_contig_free_unpreserve(void *mem, size_t size);

Allocate contiguous, zeroed, and preserved memory.

Pasha

