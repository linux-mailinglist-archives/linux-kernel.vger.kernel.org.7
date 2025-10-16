Return-Path: <linux-kernel+bounces-855727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA1EBE21DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 086FE4EA7ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A64303A3F;
	Thu, 16 Oct 2025 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etUeZPzb"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE88302CC7
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760602727; cv=none; b=GrDKidyGoDNNl0RW1DASUH02M3bW2IrYjskjQtXG8aPPTsDobi7IXlZfZAJI14/jP0lXbi5Ak1PCU8dI9BSm8Z2MNiYA6T47T4By8xf0wH7J6BbEieRRHZWGckwzA2EaOMv20Q663ZT1Tvm5YWwcfvw/k87IDoKmq6HYjE6X3LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760602727; c=relaxed/simple;
	bh=YHky9NJmU5RI/PX1MdgC/LSD2GIkMokTbTvw2kfRtCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYmkbYZnrlUow5Bm6vefUKiTZPchkOJSdRCY4E1YZGpkoRnf164FcVyEWbqeA7dVRproJMX8d4l/CGMU29KW+wbOSgfE82Ikioy+SUCFzrwpA7YKXCKwHEQcb8H1uZ3zI6XvOc/UgjtxWHKJ32OFqXFAxP1XwZx4q2J62W55K/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etUeZPzb; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7815092cd22so5428877b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760602725; x=1761207525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgHYOgNqUKqEBxe2gRboRiYdQxE4NjF5ePcPPbuQMg4=;
        b=etUeZPzbCirYmFFDYVpbD0LLU5/8ZVfii3caD+IIcgeyXWgjk4jjZTJFk5WRs0R0Wv
         NTyTh6ZtlYw7CQGZ7SEAB2gwOHfu7QLOdBaWT7ueaH5xWq20IBtbgxRks4Y68Rski5iu
         n83ZTDc6PAhE7bMYuKVHJTEbn4qw60Ka2Dobmn5m5J7uEk5vWVnvWtvzzYm9TBNhyu6Y
         eGC+DlfPQUqVS8+8ou9P9J6ZqwNKUa2y9rBk5X4YNyw/bhetm4sgiaBxN163dM8TcUjg
         4835FLPHRdDTnNLBjA8OIx4oG5CMUoqLVi1mSijUyfaXTiA80IFaC/U3RCasCJ2SamMH
         FxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760602725; x=1761207525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgHYOgNqUKqEBxe2gRboRiYdQxE4NjF5ePcPPbuQMg4=;
        b=XmRtMrbmW11LU0Q3SMP4fOvgZ/8qmRw/9EoEuCS4Ar/TzwqynzXi4wULgeLNhSlYds
         9i9A5bfu3G8xjZyxFlt5X7jYcEIdZ1cCfkBLjPF8kHep8sRcyQoq2Pg0nJApkBcRU63F
         GKMGyis8rZgr/kW59w7W3Fliew6GZk5osZcdToIP0HmshIDUpUNrdGmFDGVPfl5QoeFY
         n3U8vfMgOtAXMfOggx5UMnA40j1JFnyIKjMc2GtqMbHJS3fLr7rh2RfZHtoYHmuZUmov
         IvLZb397njGLou6ImwwWLLtzUbpg++tlc2tDDccpDFy6Wx/S6xC+uGTugOcPpGKPCN/P
         mtbg==
X-Forwarded-Encrypted: i=1; AJvYcCXntT6taCFeTCr6FOOMVimpwUfDumvRQNczQCzmVkMeRF+GutJweaEYihxYSiQ3cDsj2aFNiMD+UebisXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybaDYtHWVU34Gn/9gVkfnrygB5Q/K74vS7ipiyIww75pJjtnQH
	hhOtWKj18r8+cYkPfqVhfJIezTiW15xzk2AriMpdXQbllG1td7P3Ibg7tWQlVwMFb3hx5k0dZea
	LSvsCeQFGnXZgtGtscmUx7S8LB1P5QJc=
X-Gm-Gg: ASbGncvwDBkIl/cRVnJdYmMuD3OxsASGTXYFG53JeIxIcZ5s41EJaOoFSaivInFIwlL
	0ihualB8YMgMc0lRKBd9KVUtO9zds29Ue3U+KcJKVdsOlczpLEB478iSVBdKQ6AQL0ICm+ejyM0
	jYDrhl3/0GGY/k9eRq/R6qSt3MC1MrHtQ8wgbCfYGGtI2CpVXX5smb+ffU7aLi3h1pWlVIQLvdC
	qVLIG8a7j+dEhlk1EKZXqmYd+kCOdHbJw4YbTInAReCDYMfHNv8tUF9JlKFYExdQPPRkRl1
X-Google-Smtp-Source: AGHT+IHVqXd5quXoFkL7TseeikvmflCG1zrHiGi4zY5UsuuarF4PtLzgSuWNSHW7MIFsJygYWpoqCYW0WFpL9IgIR0g=
X-Received: by 2002:a05:690e:4007:b0:63e:dbf:ab89 with SMTP id
 956f58d0204a3-63e0dbfaf6dmr985502d50.21.1760602724828; Thu, 16 Oct 2025
 01:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015141716.887-1-laoar.shao@gmail.com> <20251015141716.887-7-laoar.shao@gmail.com>
 <CAEf4BzZYk+LyR0WTQ+TinEqC0Av8MuO-tKxqhEFbOw=Gu+D_gQ@mail.gmail.com>
 <CALOAHbBFcn9fDr_OuT=_JU6ojMz-Rac0CPMYpPfUpF87EWy0kg@mail.gmail.com> <ebf60722-34e1-4607-b6a7-595fc2091998@lucifer.local>
In-Reply-To: <ebf60722-34e1-4607-b6a7-595fc2091998@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 16 Oct 2025 16:18:08 +0800
X-Gm-Features: AS18NWD2AXGKlmvFo5UH1F2cQyeA_L5yHcpBAgeZL4_sZgqmARGxyWqYqUTXbrc
Message-ID: <CALOAHbDnJyou=MUwPBCEwWeeK+9w2MiOXjpkkcCALExfnsj=_A@mail.gmail.com>
Subject: Re: [RFC PATCH v10 mm-new 6/9] bpf: mark mm->owner as __safe_rcu_or_null
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, akpm@linux-foundation.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev, 
	rdunlap@infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 3:21=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Oct 16, 2025 at 02:42:43PM +0800, Yafang Shao wrote:
> > On Thu, Oct 16, 2025 at 12:36=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Oct 15, 2025 at 7:18=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > When CONFIG_MEMCG is enabled, we can access mm->owner under RCU. Th=
e
> > > > owner can be NULL. With this change, BPF helpers can safely access
> > > > mm->owner to retrieve the associated task from the mm. We can then =
make
> > > > policy decision based on the task attribute.
> > > >
> > > > The typical use case is as follows,
> > > >
> > > >   bpf_rcu_read_lock(); // rcu lock must be held for rcu trusted fie=
ld
> > > >   @owner =3D @mm->owner; // mm_struct::owner is rcu trusted or null
> > > >   if (!@owner)
> > > >       goto out;
> > > >
> > > >   /* Do something based on the task attribute */
> > > >
> > > > out:
> > > >   bpf_rcu_read_unlock();
> > > >
> > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >  kernel/bpf/verifier.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > >
> > > I thought you were going to send this and next patches outside of you=
r
> > > thp patch set to land them sooner, as they don't have dependency on
> > > the rest of the patches and are useful on their own?
> >
> > Thanks for your reminder.
> > They have been sent separately:
> >
> >   https://lore.kernel.org/bpf/20251016063929.13830-1-laoar.shao@gmail.c=
om/
>
> Could we respin this as a v2 without them then please so we can sensibly =
keep
> the two separate?

Sure, I will send a v2.

>
> Thanks!
>
> >
> > --
> > Regards
> > Yafang
>
> I do intend to have a look through the various conversations on this, jus=
t
> catching up after 2 weeks vacation :) in the kernel this is an eternity, =
even
> during the merge window it seems :P

Huh, we've been refactoring a bit too fast and furious since your last
review ;-)

--=20
Regards
Yafang

