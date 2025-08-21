Return-Path: <linux-kernel+bounces-779535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6341B2F54B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E101889111
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7908D2FB97B;
	Thu, 21 Aug 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWNDQnhX"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D252FABFF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772085; cv=none; b=S7qzj+PVbI9icfFZucFsHMd5Q0SJa4fqldECN0zyjWf7FYycAHRUhQ4QDf/lWfIsGhwX/wdQd3I3U8KEQmM2kxYpg8TKpTrK48cKgPHaEkdnGnVEDrkab/AdUQSSVbuvOEh++4V1scwAG6hDrsAnnojrYuSDy538WKE7bRW5fkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772085; c=relaxed/simple;
	bh=YjrblC3jYZGoPfPUFfs4Pv9S3MjUDxE5dS3PmqeJpDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOYWqWCAjduN1/2FkPaoepNQAsnP0JW/rV9rzSvK+NbFSixF0amzMKJldVhmwHTtG9IVjc0QEMafRbB6WumBV5AabTLFdLtl0nCegm5JFwy2ZM+i9SvLIXEC6sXlcjm26Q1Dy/AGJS9BYgRmpn1mau2I/+2ZGNUPVkDdMwUxnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWNDQnhX; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8902ee514deso591435241.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755772083; x=1756376883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELnpUP80gM/anqPaD6FJUI5nOkHoieYS5dIGUYiXjKs=;
        b=lWNDQnhXxVw62blO7IbpPVtz55emjIz4GR+CUgGXXfQI0EXUlqSJzCHOnkyEm63iRG
         XijokYbm8Czcb8MJ1meq39Lku0zTUixsiBOqCOq6b4e1OgZsWoRhc19kDkNBIwcFt/4P
         sWN7M0gvGNdYvLeJG4PIATIkssglRAuNZ1kxPmEbia9n2YHMtkIrl8ijhZmbSKhr48kC
         jSShH9PEY3fXZEp/MT5wQpr/gMKxRTRY7s8aNit07R6tpu1ASk3WyizQAvSkGmzMPzT7
         mwZqnIDtCRHrZ4cdnaatQZNw9Fd3H7slZAHKJnVgS6HXbFFwZov0hUo5OlYcALnnrg6m
         KQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755772083; x=1756376883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELnpUP80gM/anqPaD6FJUI5nOkHoieYS5dIGUYiXjKs=;
        b=SCB/Vv7v+1Pyg/272+UodTFv6LMUSQlJR7hio7vF38TBOuUEGKJVdycl+3GqyLft62
         X0gjhH0pPC8e5Gclyc6hfJ7IDHMLG6egTjQXcuGL/F8HQ4o0R0pJFKyl5Pdoo8sVAXI8
         sLn2FGLWdjc2PLDu28lTbVzdJ836ePySgOJQNCVxOfb87n5609Fu9eZ82b5YQ4lLW/TM
         ydqdG3CuyjQl3D4Y3M5PBCsn4q/gVMmhDVR+yrATXIWpPJCyicl0PBt3o9a5A+xZCULs
         wHqAx39pqLU6uVvBkxy+31Aue2jikj4oQDXLkCJ6ZSvqBdV+GfqHok2AApYElcPXMsNF
         Pjtg==
X-Forwarded-Encrypted: i=1; AJvYcCXLdX2CaKiu4j8Agqd0XWHKSs+2wflSN/bb5kuOlVa9rSp94XUpx1j717hjZdrb0Wo10cUwKURSRSR6Xyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgcI91/x4/C6QiQzUxsg89tY9EzSo2RWUawBNbYTb4gb6xjMEg
	ryv8hL99mGT+vxef6ZoYryckkf2pDD/ozb8a4LFRIk1/ap4kzzS4ixLWOttHfN3lhEtm3+Z/oGg
	QXrrP8ZUmaFJw00XETGh3EvuMX0n26oVi5pG5
X-Gm-Gg: ASbGncuKK8gIfEKqTa/NkklGTVUnF5ZgsU5mwIUN1UO3LvVI9fZK/FI0ExHQ3sgzgpg
	mbWJczHuxZU/XWpjRCG0XdCDBObACeALQ4Ru3rZK2PPxKWYETKHbiK5u+oTHxZ3bGU9X+AIbdWh
	GdXNn0GwSLLIlEOWB/zkbFQsDgkyPmHMxhUwVFWxe7JzMG8Vf6q+vnqZrrMcKED4FZmgB3oAoQd
	rEcWPJbkRkJnwI0GA==
X-Google-Smtp-Source: AGHT+IGhsHZhpGrX5u3RwtmYG2F9aPC/LyvWwHX9lVj48ZQXQI8Kte0gM2HpALra1byLLMV/IG1fu6eUGcDQRg787Jo=
X-Received: by 2002:a05:6102:54a8:b0:508:c145:4150 with SMTP id
 ada2fe7eead31-51be7c58738mr464375137.4.1755772083184; Thu, 21 Aug 2025
 03:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819193404.46680-1-sj@kernel.org> <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>
 <aKUi7hvcaK0h0oMg@gondor.apana.org.au> <CAGsJ_4z6YvQULrEmNjFjLNrJ4RK6w0+d9uF2-7v06gOYirrYRw@mail.gmail.com>
 <aKUmyl5gUFCdXGn-@gondor.apana.org.au> <CAKEwX=P9T315JcOBOBGK21Zk8XyDruMTv_XEPa0CuD=oAN2QYQ@mail.gmail.com>
In-Reply-To: <CAKEwX=P9T315JcOBOBGK21Zk8XyDruMTv_XEPa0CuD=oAN2QYQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 21 Aug 2025 18:27:52 +0800
X-Gm-Features: Ac12FXxHrOX-eRoJHXmtuhny6Df4zWfM_2k3KeDK1nAUUmvXOdnwHKvu18ASyck
Message-ID: <CAGsJ_4yLDLvOZ2=3iVcQhu2jnbWQ+iTQsqVefJsx4_YT4bnEZg@mail.gmail.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Nhat Pham <nphamcs@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>, David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 1:33=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Aug 19, 2025 at 6:37=E2=80=AFPM Herbert Xu <herbert@gondor.apana.=
org.au> wrote:
> >
> > On Wed, Aug 20, 2025 at 01:34:01PM +1200, Barry Song wrote:
> > >
> > > We might want to revisit the old thread to check whether it is now sa=
fe for us
> > > to move to PAGE_SIZE in zswap now.
> >
> > It's perfectly safe as LZO was fixed months ago.
>
> Perfect. Then I'll revive Chengming's patch (see [1]) to reduce the
> compression buffer :)

Nice!

But perhaps we should wait until SeongJae sends a new version that
addresses the counter issue? Also, I noticed the following code may
have problems with the patch:

        if (comp_ret =3D=3D -ENOSPC || alloc_ret =3D=3D -ENOSPC)
                zswap_reject_compress_poor++;

Can we still reach the code comp_ret =3D=3D -ENOSPC since we already
handled comp_ret by ...

+       if (comp_ret || !dlen) {
+               zswap_crypto_compress_fail++;
+               dlen =3D PAGE_SIZE;
+       }
+       if (dlen >=3D PAGE_SIZE) {
+               if (!mem_cgroup_zswap_writeback_enabled(
+                                       folio_memcg(page_folio(page)))) {
+                       comp_ret =3D -EINVAL;
+                       goto unlock;
+               }
+               comp_ret =3D 0;
+               dlen =3D PAGE_SIZE;
+               dst =3D kmap_local_page(page);
+       }

Thanks
Barry

