Return-Path: <linux-kernel+bounces-819687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964DAB7D5B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DA43BCA71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2237A296BB8;
	Tue, 16 Sep 2025 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBibXGdN"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD57433C4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060964; cv=none; b=qL/ABtS4IR+FY1KZbTbfONbj7aLF//NCXjv9sSIO1GUp8l4nwSI1S0QcOa7zXBLoV7AqO8NsM/VfZnSs7qCxQULVaUAYGRDIrdVbv86zo9Kpft8E5kjZWzm/51izPH4VV5tn3xRl/T9uP5AO1UmdDcPLBril0/M3MbEFREqjMGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060964; c=relaxed/simple;
	bh=vEQkrCZoFVZ5UELyo023tUb6H8j5Ao0wikIS02ojfec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2Jut85zwh2eLYdEP4dDCjEPB3aAySiewEXDjvcVAUmjcXLTEvtPUCnoTjYU3k6OvEGWJJdpUv6nW8oZVz4/9ZiWITDzbM7DsRjetk56fUnsx01LkJzczij2Ge1Zy+HGc/advzSMI2RnECKvNyPfxqgufY414aWW1S8HW2AlKeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBibXGdN; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b78657a35aso92241cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758060961; x=1758665761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCBNi/ou5yRHx7+ah+D+ieL7ClLUcNgw9Fw0BKqDeFY=;
        b=YBibXGdNgTtc1u6OoVvC9fcA94g9btaf1eUYrdUVafhM0p7Y/6knzEVgmKt9r500nR
         fpq9EGK+Gm5aFMyhllvdVbMl+mHStf1OH6LPEMHXgZxn2jpAUONow1HtdqixamtXRGU2
         w7uGNhNW88l6/xOvTi5HURZNEg7aTZC0EZHeMqyscuSyjwjbPXvEksDjAhyH5S50woRz
         R5QPlycyvhEX28A774pjha3TCnR3XyjiEAkWJPVTdP2YtWRDHihqV4eP9vwWXsCm8hln
         f4kA4y1CsNAIjK3vr2uYfCgD+Yts3z/BSJRFSuGDOy4+GcMMd550W/Qav26lwazBCUMI
         ZOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060961; x=1758665761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCBNi/ou5yRHx7+ah+D+ieL7ClLUcNgw9Fw0BKqDeFY=;
        b=or/tXtlQJeBheyyiAxmQ3Ly7tntQeI0f8g/K5Fg6LQIlJRv4EIItQlh33qP4b5pgnU
         FaXBkMP/T7pKuc1yACKgu4H9A4fQbmp2jZXRwxrNlBNkCI8RDbhQ+pg9j/ofGDy1feY3
         eeRaozbC/TnTR/umJIFQVUrgS7ukNkKV1o4CAb+5PvsGcXPbNjxzWoZoPn+ahpV2zIkz
         oIrKfDQfnVfzCfLK3YBPMlrlGq8sgjENJ29N5UneaGq2eFjgdigQrBeNBQ4S7yuhzNdE
         9p5DXYLoNiENG24LAbVU78+K36WML+r6mLujELYmtEY/ReS23UrEauZ6Ox9PSMI3CR1E
         ZCnA==
X-Forwarded-Encrypted: i=1; AJvYcCVc4q3c/gAgY8GihLgPZiVF+T7G5b45Wn5zPDqc9xG36FZw3bBGoU41hgM+MbJS/1WWbCii4AcrAK9E9AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXNDfue9OlDnu2D/2BtheXkmqR1GymPB1MhWCpRy+f/x7iU0x9
	fzQJ+9Fom/mR+fbrZDQ2TJa90g/JvZw+7zGwm2nttl6FAA6y2dmUQzcyXNtDiJnrzqeibnOQK5o
	XNeg74GHAgu4Vgx0meisKGzufGKAIiwqLhhFW+fAA
X-Gm-Gg: ASbGncvCjlhiHkyIYOBWq3MOniUWzD9kvneUyQ2g8FE6Fn/CKiQTfi4tLWPy+kYPmli
	+zJmzToHrVpnAejZovN8DiXB1VbikLxhgSDDA0+vhfnRPDHU7Dd/YEXoXYViFjMfInWyRywn3TL
	HB9KNR+Qjpjo+/ZdaXmZRUu3ynAkMNq/9rAIYA7wurFVwYkJEt63Weqsfe0+yuEvD+C+4zDi5AN
	ytEk9YGtdDx8Ys8rLzveEvKOcxjQ71+OQMGUk0ZZNTadz4fBVJdc+TIloaE0Vw=
X-Google-Smtp-Source: AGHT+IFwZOxD9kLzPCB1lILJmI0xgkzuMmGn6adIQK8bdZ9yMIliCNXUh+Z4nqxF5q5gbdz8Rfginp11jxz6hV6K3Jo=
X-Received: by 2002:ac8:5d08:0:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-4ba2e66f6d0mr969151cf.7.1758060960355; Tue, 16 Sep 2025
 15:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160110.266190-1-surenb@google.com> <4c4e97c1-7f93-4c09-a235-ab169a998ef0@gmail.com>
In-Reply-To: <4c4e97c1-7f93-4c09-a235-ab169a998ef0@gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Sep 2025 22:15:49 +0000
X-Gm-Features: AS18NWCPPfExsO_fHti7iMCfKkGoQVQGtNzFsTAs87brLA4n_LMr0i3QIz8xI9Q
Message-ID: <CAJuCfpFc=qUAnS=-YuW_CRgF6GUz-7_ZEMFEL-n+XY6MAr7ytg@mail.gmail.com>
Subject: Re: [PATCH 1/1] fixup: alloc_tag: mark inaccurate allocation counters
 in /proc/allocinfo output
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	hannes@cmpxchg.org, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pyyjason@gmail.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 8:50=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 16/09/2025 17:01, Suren Baghdasaryan wrote:
> > Document new "accurate:no" marker.
> >
> > Fixes: 39d117e04d15 ("alloc_tag: mark inaccurate allocation counters in=
 /proc/allocinfo output")
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> > Based on mm-new
> >
> >  Documentation/filesystems/proc.rst | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesys=
tems/proc.rst
> > index 1776a06571c2..17668f82ff1c 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -1014,6 +1014,14 @@ If file version is 2.0 or higher then each line =
may contain additional
> >  For example if the counters are not accurate, the line will be appende=
d with
> >  "accurate:no" pair.
> >
> > +Supported markers in v2:
> > +accurate:no
> > +              Absolute values of the counters in this line are not
>
> s/values/value/ maybe? :)> +              accurate because of the failure=
 to allocate storage required

Maybe... English is not my first or second language, so I'm not really sure=
...

>
> s/storage required/memory/

I'm fine with the proposed changes. Andrew, if you agree with them,
could you please fold them in when you pick up this patch?

>
> > +              to track some of the allocations made at this location.
> > +              Deltas in these counters are accurate, therefore counter=
s
> > +              can be used to track allocation size and count changes.
> > +
>
> >  Example output.
> >
> >  ::
> >
> > base-commit: 199236646ffd82b5a5bcf2bca1579ea06cb0ae74
>

