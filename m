Return-Path: <linux-kernel+bounces-755832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26468B1AC52
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 04:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4A33BF2A1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 02:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8341C1F13;
	Tue,  5 Aug 2025 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dH4opRsT"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C201853
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 02:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754359220; cv=none; b=EBu8h4S3xr5ZCxUymosOzwt9Zt4wdvWj2UxZGXTNSxC7wG4SzU6wHQ/WwSLBsCg2tLa7lWWn4Sf/LZ7H1ZfLp1ZZxd+O/FZ3nD8zp0ShQdN5takD/4xIgHiWIPHzQUB8RXZ4689h38dNnMHJHqQrTAjJyDoQZf3N4quyPDYkSck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754359220; c=relaxed/simple;
	bh=NjinuHwmtuyYiVMs4H4gMTWeZnhWmSGhsiSyk2G4mjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=popupNF8cSZHqgcDYQA1ZEXe27ulxueDp1kUsvEtkoHqwlLVwfka9qi+PJwdLP2D4nwr9GojmE3wSQcO+eDFyTdbrw3fhhNpm5eXZoAFQnX09cyDk1oRB8majhOchIWLcBCp4eYOhKFcSNCQ3BdqOOtIHKgpXRONJC3wWMAyi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dH4opRsT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-459ddf83023so8490805e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 19:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754359217; x=1754964017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSG7opwXv5FWsH2EhXuTn8+OP17SmN7esmHU9ZRgkXc=;
        b=dH4opRsTRERRZSgagq8iOFfxo1MpmeLOLppNLrd3aUBj5r270aHxkMyfp6yddpjCko
         w/D6jEndCApLSQWaHqpa9sK8mBjlnfqJMGpCr2esYxXKQZlEpatQK1Nw3O2vrOCyoD5a
         SN3zrEACYQD9DBzEJdD5w3V1l9mFMD2QjjcnoqSTiLKTaECXmisHS6y8BkyQnJa+sAMW
         bp4S9pR5Fo98hvaqN0IuMPLiY8uUKBwwCnOFPgT3brisMIqrjYf9y9TvR6nt2qyWrjlj
         4owoOw6E8Dju8iCMVWeHi3L8FJgUHb+04Tu30It1vdd8wALCISawXVMwWOZiBfzLSufj
         R76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754359217; x=1754964017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSG7opwXv5FWsH2EhXuTn8+OP17SmN7esmHU9ZRgkXc=;
        b=fk2GSugCiYQuJOwSO97K64YpooLdEGOfCzHjZ5OX8T5Zy7yeRPMyLIjGDPJbO1O9wR
         HhonyaCpb/qfJ7XcRSa6OXyzCTtRbeRNTiCZ7i/I4DrpNTO96B5KPe1AaMh58jF+mmar
         v8QJ6kapS+05J6+Tqh1hj5Ax/0GmPLjjM8E2IsczWXnRkALVCrYHzOK9nKsAI1ztcrlp
         WVszgFsCoHS7iuxnhbMr35JlGExB+TX7R8XqTURrQf2LBFmBkFbGUfGKlub5166+Pwp3
         zjf85mxL0aiQzrbaLemXptaLA7CyHFJT27Spa4j/gH+aU8nlhM4rBftf0+3cl+ZLDRgC
         eJDg==
X-Forwarded-Encrypted: i=1; AJvYcCXyGfEnMy+fEo6WH4IBABdY7POMU/+ZQZK4Gm+YLxrJZWQVHIRZwEqJrWj7RDaGD/EX4oz8kRw5dhB9i4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx54LjdsvKuoUy6qX3wzrJDW6mDwPoYs21COsPJmwYfEpv+4keL
	rPo//DVlKgKUpwoZnmWSAtWvYRrhftkeoLzAKcWqISDsSOAgWYBIeU1A8iEjzMqCvGBFZ9vSzey
	UZBdvrKDSX/sAYAregZ2MB113ec2uheAnoC+XXvZO
X-Gm-Gg: ASbGnctSPTeNR93IoYFwHR5av3VZOEqwCwwyMGST4kCWH6PzsM5yMLReeobUyEO/suz
	6fGFjUq1XRjHaQ9Ugq849khHes2Apgb1VD3J+yRBKPu3P0yxIhObkdkVSbiLy3ydSm9j24ECp19
	Uk74DuscL8cXjdE1bid3Fp+2zrGvI19uVhUJ1jPsOZeuLvlZSsfIxglWUGFZ/GaRC03bSGZkN3J
	5u3XNSO
X-Google-Smtp-Source: AGHT+IHU8mICIqYoxrBVexKLpAl1lfHIFd4RBPzxvH9x1QdKoshXo7HiGb8ekOlyGWshojjeuYWAqUhNU+zNS+nDRmI=
X-Received: by 2002:a05:600c:1548:b0:43e:bdf7:7975 with SMTP id
 5b1f17b1804b1-458b6b5ef11mr91572245e9.32.1754359217211; Mon, 04 Aug 2025
 19:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801234559.1178521-1-sudarsanm@google.com> <8c609741-c2b8-426c-8f83-8a79022b67d7@redhat.com>
In-Reply-To: <8c609741-c2b8-426c-8f83-8a79022b67d7@redhat.com>
From: Sudarsan Mahendran <sudarsanm@google.com>
Date: Mon, 4 Aug 2025 18:59:40 -0700
X-Gm-Features: Ac12FXz0fbRx1mvWhuQG3tGn2Pn1eTjXZ_7L8a0gEEdaxYWLXKdLSI_NNmxxtvM
Message-ID: <CAA9mObDx=oDeRAGJSdY3crMAYY=qn0-v2ZH9vsxkv3NcgUCL-Q@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/mm: pass filename as input param to
 VM_PFNMAP tests
To: David Hildenbrand <david@redhat.com>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 1:25=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 02.08.25 01:45, Sudarsan Mahendran wrote:
> > Enable these tests to be run on other pfnmap'ed memory like
> > NVIDIA's EGM.
> >
> > Add '--' as a separator to pass in file path. This allows
> > passing of cmd line arguments to kselftest_harness.
> > Use '/dev/mem' as default filename.
> >
> > Existing test passes:
> >       pfnmap
> >       TAP version 13
> >       1..6
> >       # Starting 6 tests from 1 test cases.
> >       # PASSED: 6 / 6 tests passed.
> >       # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> > Pass params to kselftest_harness:
> >       pfnmap -r pfnmap:mremap_fixed
> >       TAP version 13
> >       1..1
> >       # Starting 1 tests from 1 test cases.
> >       #  RUN           pfnmap.mremap_fixed ...
> >       #            OK  pfnmap.mremap_fixed
> >       ok 1 pfnmap.mremap_fixed
> >       # PASSED: 1 / 1 tests passed.
> >       # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> >
> > Pass non-existent file name as input:
> >       pfnmap -- /dev/blah
> >       TAP version 13
> >       1..6
> >       # Starting 6 tests from 1 test cases.
> >       #  RUN           pfnmap.madvise_disallowed ...
> >       #      SKIP      Cannot open '/dev/blah'
> >
> > Pass non pfnmap'ed file as input:
> >       pfnmap -r pfnmap.madvise_disallowed -- randfile
> >       TAP version 13
> >       1..1
> >       # Starting 1 tests from 1 test cases.
> >       #  RUN           pfnmap.madvise_disallowed ...
> >       #      SKIP      Invalid file: 'randfile'. Not pfnmap'ed
> >
> > Signed-off-by: Sudarsan Mahendran <sudarsanm@google.com>
> > ---
> >
> > v1 -> v2:
> > * Add verify_pfnmap func to sanity check the input param
> > * mmap with zero offset if filename !=3D '/dev/mem'
> >
> > ---
> >   tools/testing/selftests/mm/pfnmap.c | 62 ++++++++++++++++++++++++----=
-
> >   1 file changed, 53 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selfte=
sts/mm/pfnmap.c
> > index 866ac023baf5..e078b961c333 100644
> > --- a/tools/testing/selftests/mm/pfnmap.c
> > +++ b/tools/testing/selftests/mm/pfnmap.c
> > @@ -1,6 +1,7 @@
> >   // SPDX-License-Identifier: GPL-2.0-only
> >   /*
> > - * Basic VM_PFNMAP tests relying on mmap() of '/dev/mem'
> > + * Basic VM_PFNMAP tests relying on mmap() of input file provided.
> > + * Use '/dev/mem' as default.
> >    *
> >    * Copyright 2025, Red Hat, Inc.
> >    *
> > @@ -25,6 +26,7 @@
> >   #include "vm_util.h"
> >
> >   static sigjmp_buf sigjmp_buf_env;
> > +static char *file =3D "/dev/mem";
> >
> >   static void signal_handler(int sig)
> >   {
> > @@ -98,6 +100,30 @@ static int find_ram_target(off_t *phys_addr,
> >       return -ENOENT;
> >   }
> >
> > +static int verify_pfnmap(void)
>
> You really want to pass in the address, and verify that that very
> mapping is a PFNMAP. (not something unrelated, like the vdso or
> something odd like that)
>
> We have a helper in vm_util.c that might be useful: __get_smap_entry()
>
> We also have a check_vmflag_io() in there. So likely you want to add a
> helper check_vmflag_pfnmap().
>
Done. Sent v3 patch for review.
>
> Nothing else jumped at me, except that phys_addr might be better called
> something like "offset" now.
>
> --
> Cheers,
>
> David / dhildenb
>

