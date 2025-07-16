Return-Path: <linux-kernel+bounces-733975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896A0B07B70
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6707F16323F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA60433AC;
	Wed, 16 Jul 2025 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHQ6Y515"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDF92F548A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684282; cv=none; b=ij+vca+zO3EnS/ROk75c5QchfHnqc6VhlHNAUnG5j4uFHJwKLuBUmzmNUfsqU7oa/6+D42mwKeCOiBzjalFVGB6dUiWWcHEeHXTtLag4DePfToWezkqXjYFTQYXjAxraqytLhNxgz+vrn3/qMQB3l7OnlJ3GXz0DGcWmNwUrB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684282; c=relaxed/simple;
	bh=om9te+97F76PGNBhbFcuJXmcwMoZvSGcYcM1x3bmX70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ori2IFsHAzSofqLMDYBYkKquhlguDjPy17dyKJXEknFTT5Ll4H9d0TkTR0hEkYmBohCqtEraeSz4X62m4U33hyKKCnheqJo0KJMSdITtKx53/5smq7cddw14Xd0cb6GIoQlKg0l8V0CiUXXkOKo/mLHiRvqx1n5kE1ujZNeU+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHQ6Y515; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab3855fca3so741cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752684279; x=1753289079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pr8a/nJOVFR57sghJCiLBSkmwBnZhxckE8XZH1omS8M=;
        b=fHQ6Y5157xD0wxpr686hYE8yTu0t+esN/CUvuJ6OVtzvxUQEcWmBZPw7Yc5Vyel9j4
         hmLioYJf93F5P52/1Ccqj6CxT2uuOPA0fFV+783WEvxPCsw+kqEffPxZifpxzDPocdye
         uHckitaeOUT2+Lb4N1L8enqVi4Y4JqnXIhhlxrUjO0X11XBRXDdAWelrQipvBsdxAbKk
         yp5ikSMcraf0uqwz9goQ5gROJ5LF+TbeCsZJwfONk33tqItMXxTADS6dlUGFZGG9S1ZB
         P+1OH6D9eUNIbraRh75eoTHpGeFPy7M+jjV316stjkqakX65S1SsW/u0ty9KDwuH8lpE
         M3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752684279; x=1753289079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pr8a/nJOVFR57sghJCiLBSkmwBnZhxckE8XZH1omS8M=;
        b=f3ZJxfqM52NrCOdxLcBoIjmeRugNBYSQ2VUVBveXLFWAXwer+di/ICd0I+otYblFSz
         RX1NyqNnW4zZI9UR1O61zUZa2Qn9WZGMSvBF4SFVsgquo46mYlXDOf73pE2GA3Vj3Cf3
         jeH7hFOx5lK/ICCgzhpa/mfQWerqUgFKmQZzHIqU043OOytbQ09HmCOZ+EljJXEsvxz1
         Ag+qMMy6jlyDxTgoiLgzjz6iknm3S3tz9HqjrufneRnGWOfi15Uo6XONsShrH5rmfnrs
         1Pb4BxBEgU1ZD9UQ165/+1gdgHJ6RrTiIdi87//sNTa7UqqN9L6HxxXoaoU+pLWW4DbG
         VpZg==
X-Forwarded-Encrypted: i=1; AJvYcCUxOk4KS78yQjzCp8xDJn9qZGXsiAuMEbdQeLIk+B9EZudTDGaP9aaj7R7XJKF4mkiSUrsUC/gPyBdym9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzGiYMkD6Kve29A7IJYWsITKyh66K7XK/0YiaKFF/5dXDvGt9t
	MD0omEpBJWpR7Kt4InJoPfpz4k2XQCSfc8WKoYM7WJJvkml4rJIC+fWzKRSQWHyZTv/z7ae81RG
	Tmg6UpUMa2xRMYKUM0cdR5WVwBYUEhh/jBkNYej68
X-Gm-Gg: ASbGncs6GsQ57A6nhb7eN3T9/0KkHIK9C2T6RKowPs5+uVARPF7THwoxtu3Tv8LVsIK
	IhhqE0b2tfJrWgxWcyNvJXCYA68615nZ3ZatKIOMTuE+byGkEyMyP0PlEpvLI5JixaSIm7EB14Y
	oAoxZWartOhwBax4RPMMbXVobu5TNpIOTeMu26tuvC5h7o7VAMgWVQcLLwT+2urBXf2WDPlZnpI
	A4gfy1jRsfygqdkWNjjIUkwZi0Y7wth4SM=
X-Google-Smtp-Source: AGHT+IG+ehUHUArWfJVHAp+OzP5yI34RIUIkLr/x2rq0UCqLebrEaMpW3c9cNGLeH/AY19CGqIu0yi2B1KpZNp4PSHU=
X-Received: by 2002:a05:622a:a38d:b0:479:1958:d81a with SMTP id
 d75a77b69052e-4ab953aab8amr3489301cf.6.1752684278667; Wed, 16 Jul 2025
 09:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com> <20250716030557.1547501-2-surenb@google.com>
 <f041e611-9d28-4a30-8515-97080f742360@redhat.com> <ac9c5912-e19e-4653-9b6c-e68ca3a058f7@lucifer.local>
 <CAJuCfpE+Nj9rQL=_pOtnAXSDnd9xEZt=r-j7guJnkXSy8wFNrw@mail.gmail.com>
In-Reply-To: <CAJuCfpE+Nj9rQL=_pOtnAXSDnd9xEZt=r-j7guJnkXSy8wFNrw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 16 Jul 2025 09:44:27 -0700
X-Gm-Features: Ac12FXwMqgI_Oz3q7ppzUAq9TXL2qBpNKmPsgpp-I-Bf07X3_mrNGzIRSlP7_bg
Message-ID: <CAJuCfpHQf6oVx44VaiyVOb4ABAkhGe8NAN+juU-q99OhJCFhUQ@mail.gmail.com>
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

On Wed, Jul 16, 2025 at 7:20=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Jul 16, 2025 at 3:50=E2=80=AFAM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Jul 16, 2025 at 12:44:23PM +0200, David Hildenbrand wrote:
> > > On 16.07.25 05:05, Suren Baghdasaryan wrote:
> > > > The /proc/pid/maps file is generated page by page, with the mmap_lo=
ck
> > > > released between pages.  This can lead to inconsistent reads if the
> > > > underlying vmas are concurrently modified. For instance, if a vma s=
plit
> > > > or merge occurs at a page boundary while /proc/pid/maps is being re=
ad,
> > > > the same vma might be seen twice: once before and once after the ch=
ange.
> > > > This duplication is considered acceptable for userspace handling.
> > > > However, observing a "hole" where a vma should be (e.g., due to a v=
ma
> > > > being replaced and the space temporarily being empty) is unacceptab=
le.
> > > >
> > > > Implement a test that:
> > > > 1. Forks a child process which continuously modifies its address sp=
ace,
> > > > specifically targeting a vma at the boundary between two pages.
> > > > 2. The parent process repeatedly reads the child's /proc/pid/maps.
> > > > 3. The parent process checks the last vma of the first page and
> > > > the first vma of the second page for consistency, looking for the
> > > > effects of vma splits or merges.
> > > >
> > > > The test duration is configurable via the -d command-line parameter
> > > > in seconds to increase the likelihood of catching the race conditio=
n.
> > > > The default test duration is 5 seconds.
> > > >
> > > > Example Command: proc-maps-race -d 10
> > > >
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > >
> > > Why is this selftest not making use of any kselftest framework?
> > >
> > > I'm sure there is a very good reason :)
>
> It used to be a part of proc-pid-vm.c and after the split I kept its
> overall structure. I'll look into using the kselftest framework.
> Thanks!
>
> > >
> > > Reading assert() feels very weird compared to other selftests.
> >
> > Sorry to meta-review via your review again David :P
> >
> > But just to say tools/testing/selftests/kselftest_harness.h is really g=
ood, and
> > makes life simple. See tools/testing/selftests/mm/guard-regions.c for a=
n example
> > of how they can be used - pretty straightforward and avoids a lot of ks=
elftest
> > boilerplate.
>
> Thanks for the pointers. I need to figure out a way to pass
> command-line parameters to my test. Maybe I can use fixtures for
> that... Let me read more about it.

Ok, I think I'll use environment variables to set verbosity and test
duration. That seems like the cleanest approach.

>
> >
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >
> > >

