Return-Path: <linux-kernel+bounces-843987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A73BC0C67
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 10:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C563634D8B6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 08:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F78B2D5946;
	Tue,  7 Oct 2025 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gndoXDH7"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2332922A4F4
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826867; cv=none; b=KMRLSbfi9b0zCmqWdkQXEO3UtlwBrDUrjvUYjqUgYGKfMWNqa8uiHx29OKdSdAmFjTJrNkCW+XI4dfdivq2rSIpW8xGFwJTadKES9Xa83RRM0PZoTkFOuBKyEZ5JlVXOQFUzyDCMdyVpFARk6jm2EQQehdAt3JwMcGlUVVC4YZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826867; c=relaxed/simple;
	bh=vo73nD6X7GknqwKu4/t/n5UEit3SnnPN2ApB1mJISAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSwex2av3oj31shhTyHX8Ovz9rN5eJGi1xUNBA1Hw0+3SaTNslIGgjieEm21mKZEjEHf8mL006QZnw+J2ac0amqj8KvuTMR3LBQkCcHHJaDeLKcvUIvIM/d0wpC0xHnIkdmVOmy4UhUrlOurtwh3kfD+pE5blNXKDVojn4LBO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gndoXDH7; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-86be8a110f5so63323996d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 01:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759826865; x=1760431665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crh9HauYP95GJ4zrJ0uVPldJHjW/rsd9tWC0UjT3/hA=;
        b=gndoXDH7Ko6uxNr64bSMWEi4D0l18rZUChLuCdFObnGvYpLYFOjrslx0mRFT17PAlB
         eden4YMr1RK2piK7X0AYBnkX4sD2x83PbIXbcgiRJv47ojDDVeuyqLI8gnS4cPIA5LwY
         aNDbybBzHszSgy3Zp+NS9bHPqGQUZWHvQe+C6R3HLaBVC2oyWDTSx5FtjqXhRqUzLYEe
         j4DM6VT/7oPabqc4ZZ4oHuH/LwBEkoOvYrvkYnJ7S+QvGhZJENpEHQV8GGKIpdxjbXY6
         sOmndYRGircEq0491JAhNOb6tHfVihPRDn9JGwldHVZjfljRkCG67NbipUAc73V51+Mq
         2HTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826865; x=1760431665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crh9HauYP95GJ4zrJ0uVPldJHjW/rsd9tWC0UjT3/hA=;
        b=JN+XZLhnWRfG5xiqdn0i2ZtC4WlqEf8e75G8fv5fpydwfmaTFr3QbjW04LdEd9gxnF
         wcb3196hh4ncdcrJV3c7zNN8mUcLR63kM/bSqVfcZqSKQ99nafQGP98vUNmmH3dG6bfE
         W7AaLoMXo7oA46XwP4dgMQOs4GtbTe82v7lrvh4svH90Qit5zKPbpz/Eji1PNnl4Odma
         2iASOh8fO3dbuaRsKABLpKjVIlqWz7KZKZVwe9eShsTVyghnWnMMU3288edsg2Mm+IdY
         XmchABqImaJlWnldZHGsgy77DNn5jUlfwSJ0j+cMNTo81fMLyOtkp9o2IJDOFdnvSSpl
         3kFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIMQB0TDpO4mlZh/qFey8fkzDGKJoOxopgxuMdZtLRI8okrNVSmWRjY/yiF1edP3kI1KuJm8NNZYv57gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkB5vUQXSyeHahZOgNJFJzEBOHRfQJFd2fu/fD9/geplsegiPJ
	Z4UdVFeyGCfmvXQ1MMY9+WC+I3Tsp0kxRjPeasKu053f252yHy3N9XM2jZEvJFMJS9Bs0ewkBNx
	YwVBOm631Rk0zwSE/6Ox+wJc9zJB0M1A=
X-Gm-Gg: ASbGncuJNElLoCjludDBzbTHPyJkEUcgXUKBknq9p1x6PAfKzQHZ+Iy4/hfrIeBQeqN
	ZWHhP0vq/kBXg16Yjb2u91bc5AJcJVBoIwcSOH3iRpaFYhdOThPMSd1kYF++/t44U997r/qdy8r
	423Dmdt8gryjlutx6sywu+GfniWcjBfR+gEeFBT6ElAAEUBdsCQCON/CvpbzvUHbZ3dG95C9Ur+
	mWtT80utZT+yZTSnzWKH5BnZbEBt2DN33VpxUO5NgstiL+9y7vxLjR3rgrfIvTbcwxyyeBe
X-Google-Smtp-Source: AGHT+IE0kCx/uqxAfqV2bOwZSICMDBVUoFj0t71GiPD3ZOtz/k069SnnR01KVwEtbQaFoOkSu9qAE8VcxY6KD+XN6HQ=
X-Received: by 2002:ad4:5ca5:0:b0:815:2c80:5538 with SMTP id
 6a1803df08f44-879dc82c417mr175681336d6.35.1759826864937; Tue, 07 Oct 2025
 01:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930055826.9810-1-laoar.shao@gmail.com> <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
In-Reply-To: <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 7 Oct 2025 16:47:07 +0800
X-Gm-Features: AS18NWAAW7GO0Nbda-yTtjdo7G3EzwEKMHmRebu2XNJhJXwwvRx2obOSyUBetgo
Message-ID: <CALOAHbATDURsi265PGQ7022vC9QsKUxxyiDUL9wLKGgVpaxJUw@mail.gmail.com>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>, 21cnbao@gmail.com, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, lance.yang@linux.dev, 
	Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 10:18=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 29, 2025 at 10:59=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> > +                                     enum tva_type type,
> > +                                     unsigned long orders)
> > +{
> > +       thp_order_fn_t *bpf_hook_thp_get_order;
> > +       int bpf_order;
> > +
> > +       /* No BPF program is attached */
> > +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> > +                     &transparent_hugepage_flags))
> > +               return orders;
> > +
> > +       rcu_read_lock();
> > +       bpf_hook_thp_get_order =3D rcu_dereference(bpf_thp.thp_get_orde=
r);
> > +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
> > +               goto out;
> > +
> > +       bpf_order =3D bpf_hook_thp_get_order(vma, type, orders);
> > +       orders &=3D BIT(bpf_order);
> > +
> > +out:
> > +       rcu_read_unlock();
> > +       return orders;
> > +}
>

Hello Alexei,

My apologies for the slow reply. I'm on a family vacation and am
checking email intermittently.

> I thought I explained it earlier.

I recall your earlier suggestion for a cgroup-based approach for
BPF-THP. However, as I mentioned, I believe cgroups might not be the
best fit[0]. My understanding was that we had agreed to move away from
that model. Could we realign on this?

[0].  https://lwn.net/ml/all/CALOAHbBvwT+6f_4gBHzPc9n_SukhAs_sa5yX=3DAjHYsW=
ic1MRuw@mail.gmail.com/

> Nack to a single global prog approach.

The design of BPF-THP as a global program is a direct consequence of
its purpose: to extend the existing global
/sys/kernel/mm/transparent_hugepage/ interface. This architectural
consistency simplifies both understanding and maintenance.

Crucially, this global nature does not limit policy control. The
program is designed with the flexibility to enforce policies at
multiple levels=E2=80=94globally, per-cgroup, or per-task=E2=80=94enabling =
all of our
target use cases through a unified mechanism.

>
> The logic must accommodate multiple programs per-container
> or any other way from the beginning.
> If cgroup based scoping doesn't fit use per process tree scoping.

During the initial design of BPF-THP, I evaluated whether a global
program or a per-process program would be more suitable. While a
per-process design would require embedding a struct_ops into
task_struct, this seemed like over-engineering to me. We can
efficiently implement both cgroup-tree-scoped and process-tree-scoped
THP policies using existing BPF helpers, such as:

  SCOPING                        BPF kfuncs
  cgroup tree   ->  bpf_task_under_cgroup()
  process tree -> bpf_task_is_ ancestors()

With these kfuncs, there is no need to attach individual BPF-THP
programs to every process or cgroup tree. I have not identified a
valid use case that necessitates embedding a struct_ops in task_struct
which can't be achieved more simply with these kfuncs. If such use
cases exist, please detail them. Consequently, I proceeded with a
global struct_ops implementation.

The desire to attach multiple BPF-THP programs simultaneously does not
appear to be a valid use case. Furthermore, our production experience
has shown that multiple attachments often introduce conflicts. This is
precisely why system administrators prefer to manage BPF programs with
a single manager=E2=80=94to avoid undefined behaviors from competing progra=
ms.

Focusing specifically on BPF-THP, the semantics of the program make
multiple attachments unsuitable. A BPF-THP program's outcome is its
return value (a suggested THP order), not the side effects of its
execution. In other words, it is functionally a variant of fmod_ret.

If we allow multiple attachments and they return different values, how
do we resolve the conflict?

If one program returns order-9 and another returns order-1, which
value should be chosen? Neither 1, 9, nor a combination (1 & 9) is
appropriate. The only logical solution is to reject subsequent
attachments and explicitly notify the user of the conflict. Our goal
should be to prevent conflicts from the outset, rather than forcing
developers to create another userspace manager to handle them.

A single global program is a natural and logical extension of the
existing global /sys/kernel/mm/transparent_hugepage/ interface. It is
a good fit for BPF-THP and avoids unnecessary complexity.

Please provide a detailed clarification if I have misunderstood your positi=
on.

--=20
Regards
Yafang

