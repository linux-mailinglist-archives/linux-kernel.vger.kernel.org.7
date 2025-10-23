Return-Path: <linux-kernel+bounces-866248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C71BFF4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 408074F1307
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC43254876;
	Thu, 23 Oct 2025 06:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS8uJPow"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8715D26059D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761199523; cv=none; b=TzYbrvoO2UQVOTT7jVsZy2Sm0itYrJ1Aw5KnJsvx6W7x5opLNYdNbfmVvPWeYZnumZGkNIhrA4Ztl1/UBq+6wFsS996Nr5eAzay83kzwPk/NRZCS3Ov/wXpANCdvDwMotnxWYZc0+cU2xr5xyVQCUT2aUyIr/g5Qm7ajuWoLHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761199523; c=relaxed/simple;
	bh=EloHpRcKC3uze3cFMUqf9MMCZG+73LfdiARG2K5LQG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otnqblbOUOYspU4nYRCpLzgZA/fR8gvnKniVzdxCBKdgXRr8PUpNgDBnGSCcwhYzMJyM4uxDdFtC20/DoFf/ED4EHGNVdzYyKC6v1TxXPKOIn8UhyiQNON76/J27E0xu12vMkq5JoYZNEXY/uL6+qvbC+sD8//qoYqBbt6ISQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS8uJPow; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8906eb94264so50842785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 23:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761199520; x=1761804320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3IvAY1bPgzmMFy0d5igGjN36rYPGH8m3qPfHMEgRd4=;
        b=cS8uJPowT9F4/MW4ox32EJI+mbjgXBeFje74I4rdTSHog2sX8ssFvBhTDDDGd5qrOZ
         azNZn1TkN4d/nPc/kbM53u2ni/QFPf/eFjv5L2eP91VDYSlSQWtvwRgGzA2D2DqmjtjG
         89YyQakxOHReDeXvJvbvtMdHMGyjsFmqom7ahxIf8BmNGWbEIp7Swh8DaaGx5foq978A
         B0xYJOwp6MExz7/4nyjyLeIDnPkxEeSBoSlTScjj0Zc2dlyUj5PfheGfY6VzwDzhASs/
         ATbzF4MbXuyNku/I/ZfXsK//boCrA5uCCDpbQN0XgNRClKmgPEwWoWDhUEVlpL40P2XO
         1g5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761199520; x=1761804320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3IvAY1bPgzmMFy0d5igGjN36rYPGH8m3qPfHMEgRd4=;
        b=toJN4e4I3lLvwb2YVs1UJANK5s2dFTiDsRQ0okJZiK15+9G+7oTBKqp5Ev4uqhPt9b
         +HE4aF49QJVww1zxlj5l59N+G3r+XBCG+vkqBS36sVYk2EPwNvCNxZXexNDXIupjhux4
         Cx3y/YPU3f8Zbi+CTYZ113nbQSEGgj2A9w9aO/WTdLNaKMLr/J9f3NpR4brLcGiUORlG
         wD5Ku0Y/B67Qg+c3eBtWif12O220AlNKBKmQoiwq3ST3GQCxrWU7W9QJjiBzT9MeyT4G
         /pGx0QqGE8Cv5cyXthwbKsgMo+5nlg8e7ysOnl6Sad9Hyr9YvIggL5FfrvqxTbVAaWjL
         Z3sw==
X-Forwarded-Encrypted: i=1; AJvYcCVNIrUADjbfjwl7nXRAKufu2D+To3+ftmWg9rVhw8Ey91G0sX4lrz44FzTpVhOXZhrRmsXGqJAqyhDU3hY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvyY8cJzkgt6UidRVRlYkCNqWGkkZ3ON9+2SMTaBIuLJe4Fatk
	Son/T28ZYE21cb6e+XSYy+OPxf043ncdtIq7lnwcJb6qsflTVictVGAMBFwTpdolTpdwo4Cgntu
	Dbb8G372jReAqjxF2HA6wGZLmu482Oms=
X-Gm-Gg: ASbGncsvuBguQW3nbqfZNz4nNHdwDL8ualS68RXvQwtInxGvfu9vtotYn872V4REjtb
	rGTkTo9S21cHPy9d/OuwFaBRb4I5UGk8YyIpl6vHBaiBFO6IAsPLy7ZA7ZfzZhbKs93WB4Ohjuh
	tp5klDbuF1aWGqQWvDoYMZZeABSIOZ4V5ME1wLa2we5hn9m6r5px5Apckj0HHxrRYTxtmJnkau6
	QMzTr+Re2XpxHS29YSdsBz1lZF1yZOchXqlp6R1SISB/Q1p1QkPliaiyDL3ed5aMlWo3ujoybuU
	8u0gDS1r0X8dWRXHRm6AETwr+K4=
X-Google-Smtp-Source: AGHT+IGsEfu1WKq3O1sDXpXzxhRNtjQgAHS0IeqKxtmtdBTBKwbMP0JMEIOGBFyK/RlUYPuqFMLN0h8xpTTy4rHsfAA=
X-Received: by 2002:a05:620a:2911:b0:84b:e14f:18c9 with SMTP id
 af79cd13be357-89070114c39mr2580157285a.47.1761199520141; Wed, 22 Oct 2025
 23:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022105719.18321-1-ryncsn@gmail.com> <CAGsJ_4zKcxO-Tacy0jCZSs83+fGsgqQYNib9nCXoLTuL+hdLxQ@mail.gmail.com>
 <CAMgjq7CdQK_k_oGfOwCtMm18uAXrGwfwUz93pt7kaN-S64G0Cg@mail.gmail.com>
In-Reply-To: <CAMgjq7CdQK_k_oGfOwCtMm18uAXrGwfwUz93pt7kaN-S64G0Cg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 23 Oct 2025 19:05:09 +1300
X-Gm-Features: AS18NWAOFgLxB_h9QT8-CzNEtRzSIFKqRBnAEOGu-CloGyTvPo1b8C9gv-cX6nE
Message-ID: <CAGsJ_4yidWp9BqJbTa44uLWpJU-d5A+76r8QeErtL+Au+CEqZw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/shmem: fix THP allocation and fallback loop
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	Dev Jain <dev.jain@arm.com>, David Hildenbrand <david@redhat.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Mariano Pache <npache@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:58=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Thu, Oct 23, 2025 at 1:51=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index b50ce7dbc84a..7559773ebb30 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -1895,10 +1895,11 @@ static struct folio *shmem_alloc_and_add_foli=
o(struct vm_fault *vmf,
> > >                 order =3D highest_order(suitable_orders);
> > >                 while (suitable_orders) {
> > >                         pages =3D 1UL << order;
> > > -                       index =3D round_down(index, pages);
> > > -                       folio =3D shmem_alloc_folio(gfp, order, info,=
 index);
> > > -                       if (folio)
> > > +                       folio =3D shmem_alloc_folio(gfp, order, info,=
 round_down(index, pages));
> > > +                       if (folio) {
> > > +                               index =3D round_down(index, pages);
> > >                                 goto allocated;
> > > +                       }
> >
> > Could this be a temporary variable to store round_down(index, pages)?
>
> Right we can do that, but the generated code should be the same, the
> compiler is smart enough, I just checked the generated code with gcc /
> clang.
>
> Do you think the code will be cleaner with a temporary variable? I can
> send a V3 if anyone suggests, it's really a trivial change.

Personally, I think a temporary variable makes the code cleaner, but I don=
=E2=80=99t
have any strong preference.

The fix looks correct to me.

Thanks
Barry

