Return-Path: <linux-kernel+bounces-863481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35464BF7EF3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16F354ED59A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378A034C14D;
	Tue, 21 Oct 2025 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCIirYTR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B006534C137
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068426; cv=none; b=CT+VY9s/6EikrISKVevO2KwjquVVAuBGfWCKMBVfRA0WQIX30vAA3s77MBM9hoOL1ldl9oN4mGzqkRCklZV44FeLD5yHHuVcAHwc7Zpl7dcLT+XRVmsK39sE+xKYJcCswrLsrGPGdgnMAKo8ALkBI4dsm+tCQQM0nAnlFtyLiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068426; c=relaxed/simple;
	bh=7JoHInQdApQkdHzAPD8FX7uRju0EXhTGG1SG4slxvvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kthvk8E2maCbo2494UZOSRg0Xfa0Z9U8Ch6DLueoqAXTsz0p0051wBZx7bQadR77f78srCG1mzerDcZul3J92UvUmv2cSrE7FxlsdLnZtgY4PUJptxcXJCuq01SPIKKN9AYbYuZaZLHCC0BU/A5doDV6JUWUBsJ7th+DdQDhprE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCIirYTR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761068422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6mtgo3pPCytVhVXZFHBeLsifkDHzSLEpkyjN1cf7zc=;
	b=QCIirYTRzvCGGFo2RCA8H+olyxPm3lwQcYZKtYA19oME3yq47w8aAiTtLt+WkDxAETqBmp
	jqGUE/2IbAMxuTba5kobrjEJn/YFxCln9Lrkw26ypOubbwsAihRryd326xElAiA1pxg5Jb
	6gwg634QFzrcwiX6+PQ+ZJFrKQ1Wr1A=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Dx2YEblCPs2T1KZWWpaE8A-1; Tue, 21 Oct 2025 13:40:21 -0400
X-MC-Unique: Dx2YEblCPs2T1KZWWpaE8A-1
X-Mimecast-MFC-AGG-ID: Dx2YEblCPs2T1KZWWpaE8A_1761068420
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26983c4d708so46961405ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761068420; x=1761673220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6mtgo3pPCytVhVXZFHBeLsifkDHzSLEpkyjN1cf7zc=;
        b=LZzR1BHxiGKp+tyQi8K+hLUw/0jwTMBZjfn60s7bQx1PGOPBc6VaMcbVjqZHgIcNzt
         cjbrxoBfOokcdKkSKLu0oUygyELsySa7WqK16LXtJ/7I9kQxxUj0Uz6x0odhdAElbZgw
         TnDdWoJXCq6dqL2T1ZgISZsNqot5HLJpYR98TkdbMOSrvHQVusj1AGGVn9T9O1WqN6Kq
         XcRjJo2UyrmExbywmlr2isGxfwqKWE9/fTc/+bUgsenkoxMGT+Fg8rhhorXN5nUvLjyy
         i7aE4DPuLia2Ixr4Zxygnftqt3sIGHaeDWVo2BUFRhqTOqZVms8lhwM/gP64kneoWpT+
         XszA==
X-Forwarded-Encrypted: i=1; AJvYcCV5Ge2UlK6cmCglncxdlGxiIcPPwDmi0faXR6QMthkyQezdWjZ8u1UBmZp9dciQGpztb+MUtx0ymFaLFBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSEYumt0ErnrDqdfxWEBQ/HT1DHckDluI2lKMuPdRo1v+RM3H5
	cXDxMZh6gozAHKTUldTbE7rw7XpHEeeWYZQ2bmgFFIhoUVgs+jVfBOnZFt9bYhwjd9ULLXQLmM3
	L8IO2lXc4BUUn2SapcmF/EWgBOlFPQcTB697c+Z4mseTSotYV2GKo2JvogInhDnOuNv0emzsJ6h
	4jY7fRH1MdWMpyGZ959u+f6QdwRkAU1ozFvAXfQ+rm
X-Gm-Gg: ASbGncvELSy7nHRoY/Aygh/yJuXiJfoLrSMhbpZ0I00d0OQjHOOwQv2mr5Ru3imSHNx
	4gxICFwb91hmnT614KqFlnc/LOP2gBCmSiMaadV7wCuCGRaCslyMpv0zdl9zHPvtp+FbiYJwrrH
	rG3G0V5N1+k915JDmtvAqT1YU3pGVoxkhJMIDpykBG6uFFbScSvOnNaw==
X-Received: by 2002:a17:903:2445:b0:25c:25f1:542d with SMTP id d9443c01a7336-290ca1219e1mr241861745ad.36.1761068419831;
        Tue, 21 Oct 2025 10:40:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNBRXbNnmPSpLYEnXFkENFI/1M+gqvKIYCVJm9fI2lS0fXYAVI+gy+WgMJVWOy3YBjG5e8is9uJ+k/OC1HrY0=
X-Received: by 2002:a17:903:2445:b0:25c:25f1:542d with SMTP id
 d9443c01a7336-290ca1219e1mr241861165ad.36.1761068419241; Tue, 21 Oct 2025
 10:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910170000.6475-1-gpaoloni@redhat.com> <20250910170000.6475-4-gpaoloni@redhat.com>
 <2025102151-distill-operate-a748@gregkh>
In-Reply-To: <2025102151-distill-operate-a748@gregkh>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Tue, 21 Oct 2025 19:40:07 +0200
X-Gm-Features: AS18NWBEOONK7dBiVq2lvIZx05dnm_RrfOSuk8LGx_c67bshALzcxq1srb2jgM8
Message-ID: <CAGegRW7qKAPre7EAh8JLkUuA4Wi0-cKs7q3_qxHAE0nJs6VHEw@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 3/3] selftests/devmem: initial testset
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, safety-architecture@lists.elisa.tech, 
	kstewart@linuxfoundation.org, chuckwolber@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, Oct 21, 2025 at 9:41=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Sep 10, 2025 at 07:00:00PM +0200, Gabriele Paoloni wrote:
> > From: Alessandro Carminati <acarmina@redhat.com>
> >
> > This patch introduces a new series of tests for devmem.
> > Test cases are mapped against the tested Function's expectations
> > defined in /drivers/char/mem.c.
>
> Cool, but:
>
> >
> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> > ---
> >  tools/testing/selftests/Makefile         |   1 +
> >  tools/testing/selftests/devmem/Makefile  |  13 +
> >  tools/testing/selftests/devmem/debug.c   |  25 +
> >  tools/testing/selftests/devmem/debug.h   |  14 +
> >  tools/testing/selftests/devmem/devmem.c  | 200 ++++++++
> >  tools/testing/selftests/devmem/ram_map.c | 250 ++++++++++
> >  tools/testing/selftests/devmem/ram_map.h |  38 ++
> >  tools/testing/selftests/devmem/secret.c  |  46 ++
> >  tools/testing/selftests/devmem/secret.h  |  13 +
> >  tools/testing/selftests/devmem/tests.c   | 569 +++++++++++++++++++++++
> >  tools/testing/selftests/devmem/tests.h   |  45 ++
> >  tools/testing/selftests/devmem/utils.c   | 379 +++++++++++++++
> >  tools/testing/selftests/devmem/utils.h   | 119 +++++
>
> That's a lot of files for a "simple" test.  Doesn't LTP have tests for
> this api already?  Why not use that here instead?
Indeed, at first glance the test may look simple.
However, despite the high-level concept being straightforward, there
are several corner cases and peculiar aspects that needed to be
covered, that=E2=80=99s why the test grew larger than expected.
For this RFC, my intent was mainly to share the full picture of what I
had in mind.
I fully agree that it can be refined and streamlined in the next iterations=
.
When I started working on this, I wasn=E2=80=99t aware of any existing LTP
tests for this interface.
After your comment, I double-checked, but I couldn=E2=80=99t find any relev=
ant coverage.
As far as I can tell, neither LTP nor the upstream kernel selftests
(kselftest or KUnit) currently include tests specifically targeting
/dev/mem.

>
> Also, this is userspace testing, not kunit testing, right, is that
> intentional?  You are documenting internal apis and then writing
> userspace tests for those apis, which feels a bit odd.
Yes, that=E2=80=99s intentional.
The main reason is that all the interactions happen from userspace,
and the internal helper functions aren=E2=80=99t meant to be consumed by ot=
her
kernel components.
So I chose a kselftest-style approach.
That said, this is still an RFC, I=E2=80=99m happy to adapt it based on
community feedback and direction.

>
> Also /dev/mem should not be used on "modern" systems, so how was this
> tested?
That=E2=80=99s indeed one of the nuances I mentioned earlier.
Access to /dev/mem is often restricted for security reasons, so the
test is designed to detect and adapt to the environment, only
performing operations that are actually allowed.
>
> > +// SPDX-License-Identifier: GPL-2.0+
>
> Are you _sure_ you want GPLv2+?  I have to ask, sorry.
Yes, I used GPLv2+ deliberately, but I=E2=80=99m open to changing it if the
consensus is that GPLv2-only is more appropriate here.

>
> > +/*
> > + * devmem test debug.c
> > + *
> > + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> > + * Written by Alessandro Carminati (acarmina@redhat.com)
> > + */
> > +
> > +#include <stdio.h>
> > +#include <stdarg.h>
> > +
> > +#define DEBUG_FLAG 0
> > +int pdebug =3D DEBUG_FLAG;
>
> That's a funny define that is never used elsewhere.  I'm guessing this
> was cut/pasted from some other userspace code somewhere?
It wasn=E2=80=99t copied, but I agree it looks unnecessary in its current f=
orm.
I can remove or rework it in the next version.
>
> > +
> > +void deb_printf(const char *fmt, ...)
>
> Who is "deb"?  You have more letters, always use them :)
>
> Also, why debugging for just this one set of tests?  Don't kselftests
> already have debugging logic?  if not, why is this unique to require it?
>
> And am I missing something, or does this new tool not tie into the
> kselftest framework properly?  I see lots of printing to output, but not
> in the proper test framework format, am I just missing that somewhere?
You=E2=80=99re right, this was a small custom debug I left in place, mainly
because I needed a way to include additional information that isn=E2=80=99t
normally part of the standard selftest output, such as references to
specific requirements in the code.
My intent was to make it easier to correlate test results with those
requirements.
That said, I fully agree that the implementation isn=E2=80=99t aligned with
the kselftest framework style, and I=E2=80=99ll look into integrating this
need in a more standardized and consistent way in the next iteration.

>
> thanks,
>
> greg k-h
>
Thanks a lot for the detailed feedback, it=E2=80=99s very helpful.
I=E2=80=99ll revise the test accordingly for the next round.

Best regards,
Alessandro


--
---
172


