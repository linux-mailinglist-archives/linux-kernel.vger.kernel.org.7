Return-Path: <linux-kernel+bounces-733690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 635D6B077E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5392E1C41C92
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482AD2580F3;
	Wed, 16 Jul 2025 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ie2d4wt9"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8022376F8
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675635; cv=none; b=SnW3WDY974hTYUeLR8yuZI4mGjdj4YM8aSJ9q7YwJGAYlgscCLN67EDXj/uQ/5Bq5apMputelCAFbu3tGtpE0avrXwZ/uOBQjKlnOOSvrbg2qbMBXI5/gE4fdz6oL+ZfXDDVNDEkWAQo4Y+zOqBnq/p7C4PJxxFAnGasM3G/AKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675635; c=relaxed/simple;
	bh=ssNd0mJRa1pJHDoPpoaDkjEJBefIzfkR4+Ha3JANNQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChO1HgNQxyESOh/9clxO4CjR17qC6RjgcvpCaIxYWRl5PjUjPsCipTMwdlAJiDe8l0AgQw/58MqXAnkY21qM2UMCHwVomSD2cvGQx2KByX4PmbmHwesj40n/AAtGJN/32fApwkc0KKLnOPzpg4Oh+3YaOcb9YzIa0aTHOCzZ0Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ie2d4wt9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso8780a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752675631; x=1753280431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIOphgqPm5lvaWbkIykektdEvrtd9usWnWnUZ8I8HvY=;
        b=ie2d4wt9HNP9/jNuyvLjMxGIK5vfNJsum1hD3UoasrT6wPV5/l+Il+9AJ87bLfaYD8
         uEq1wr1eMC/GJkBwIARNGZU8cpAG63nngu2POc/9QAq1wQO7lwDio749RZ9zyE1RZvjn
         Ss6Af+sHJvUzXZdvynQr7RFl4ZfoQsYhUbGM+TXbmwvVEzBxK+lc+Qeaw8crlb8cX5pJ
         bYz1b+RagkV62wpXI6uk86SNsmySDMS+B8T9tCWzzfJOcyRAKCmZx/YOOGu2uIoxUXx6
         oa5ZhFwKfKMtXNP0gWZqboEQ4KyqdcjVoS9FFq8x+z3GLVUkDcnUe1wSf0nxzVUl1blo
         PXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675631; x=1753280431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIOphgqPm5lvaWbkIykektdEvrtd9usWnWnUZ8I8HvY=;
        b=Fl8dgXF6kLGNDe/F9sVaX78UkmzOEK/xaxDEs1++ib2p4nWL3WjQMDtr9IPxK8UlqW
         0AmHgJLUbUykYz0C6JjxM4WKdnnxI1K7aWEwTAqPA5KrkkJahDtuLXzxZ6TnU2RjBFmF
         53rYQKrjtB+2m7uyQfW60AzeoiDwD3GK+pb2j2Lb6D5XYYwE/6/tqMYqskfxyFM14A/c
         Md2ejbQdfPn8sOa3VWWqFAO7kjXs1oAjUtLA9lFCoF29wG8ZH2iFgUs4dJyBdRcuZGmn
         CxYbDEdBSp7nmIPOs+8rGS1FLD/y7OeLJ2g9IPcaxAzXGdivnCZJ+GeSe9Tm3A+Lz9m9
         6u0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7u/+X9LdoQH/mw83VlvGhElg0I/SADUDyqBB+0JmjHpf0U1VbShCJJH27kBS0wg5GtziXigRoS7pRQVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQS/uKZAfblHjalQiH+0zDLqcng1Em3IzIu9PntC7DWwUnVOVR
	f9d+/EoEzrNDyaA0wdol6zXaWO/J9xg2AVL9Ox42aEsgMu7Fr6oJdzBYN8t0yigA4YRbtJuRcCM
	IceXSuT4ZDV1zr0QGMMK+vCHM7/t5Ds7WoLs1kFhp
X-Gm-Gg: ASbGnctXHCr3K4aYT7F0UiX7zEUUdQtaoqSwb+9FWBXbJMblFuXTDG7eD1SJb1r1pCg
	ll2FDYOGApbXqLU0EXLOW9FZN5zrjjihOMSih2bm0MX7RS/rXxL1+j8xs2EyyZ5JGy0t9EUN6j0
	86I5K3840Vwqij1OKHiguVtkXkZLrR0GEBmKAr7W++2IGCOOeQUyNtCVJrnbWlqACaL8jMsT6LH
	CpqRLvmFX7WtoCGho5h44vTAiElM8p6trhx
X-Google-Smtp-Source: AGHT+IF0KH9bDS2sqMIF1uloGs4FGACZhag7lE+PKo4FcniegeHB52YqSj5sS2l+sL+kSLOceI4mVmdKMq1e0f4po2w=
X-Received: by 2002:a05:6402:b04:b0:611:ff6c:50de with SMTP id
 4fb4d7f45d1cf-61287aba924mr66193a12.4.1752675630924; Wed, 16 Jul 2025
 07:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com> <20250716030557.1547501-2-surenb@google.com>
 <f041e611-9d28-4a30-8515-97080f742360@redhat.com> <ac9c5912-e19e-4653-9b6c-e68ca3a058f7@lucifer.local>
In-Reply-To: <ac9c5912-e19e-4653-9b6c-e68ca3a058f7@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Jul 2025 07:20:16 -0700
X-Gm-Features: Ac12FXwnoUYNXMD4XFIyUdZfEVH6BNOuC4bDqEgFyq4aGoHDoTIObxbq-deP8uQ
Message-ID: <CAJuCfpE+Nj9rQL=_pOtnAXSDnd9xEZt=r-j7guJnkXSy8wFNrw@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] selftests/proc: add /proc/pid/maps tearing from
 vma split test
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 3:50=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Jul 16, 2025 at 12:44:23PM +0200, David Hildenbrand wrote:
> > On 16.07.25 05:05, Suren Baghdasaryan wrote:
> > > The /proc/pid/maps file is generated page by page, with the mmap_lock
> > > released between pages.  This can lead to inconsistent reads if the
> > > underlying vmas are concurrently modified. For instance, if a vma spl=
it
> > > or merge occurs at a page boundary while /proc/pid/maps is being read=
,
> > > the same vma might be seen twice: once before and once after the chan=
ge.
> > > This duplication is considered acceptable for userspace handling.
> > > However, observing a "hole" where a vma should be (e.g., due to a vma
> > > being replaced and the space temporarily being empty) is unacceptable=
.
> > >
> > > Implement a test that:
> > > 1. Forks a child process which continuously modifies its address spac=
e,
> > > specifically targeting a vma at the boundary between two pages.
> > > 2. The parent process repeatedly reads the child's /proc/pid/maps.
> > > 3. The parent process checks the last vma of the first page and
> > > the first vma of the second page for consistency, looking for the
> > > effects of vma splits or merges.
> > >
> > > The test duration is configurable via the -d command-line parameter
> > > in seconds to increase the likelihood of catching the race condition.
> > > The default test duration is 5 seconds.
> > >
> > > Example Command: proc-maps-race -d 10
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Why is this selftest not making use of any kselftest framework?
> >
> > I'm sure there is a very good reason :)

It used to be a part of proc-pid-vm.c and after the split I kept its
overall structure. I'll look into using the kselftest framework.
Thanks!

> >
> > Reading assert() feels very weird compared to other selftests.
>
> Sorry to meta-review via your review again David :P
>
> But just to say tools/testing/selftests/kselftest_harness.h is really goo=
d, and
> makes life simple. See tools/testing/selftests/mm/guard-regions.c for an =
example
> of how they can be used - pretty straightforward and avoids a lot of ksel=
ftest
> boilerplate.

Thanks for the pointers. I need to figure out a way to pass
command-line parameters to my test. Maybe I can use fixtures for
that... Let me read more about it.

>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
> >

