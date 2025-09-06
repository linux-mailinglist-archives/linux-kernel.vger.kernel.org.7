Return-Path: <linux-kernel+bounces-804246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1449B46E32
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A012A7C7085
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 13:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8F62F3628;
	Sat,  6 Sep 2025 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8MyhB+K"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4B2F291A
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 13:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757165528; cv=none; b=Mfn/QZmSEYj36FyUxd1+XKaIVGu4ZbKWuVZF6NX3O6ZcRd4WCsR42F+hbhRUq1k0zFQHAXKpq2Pjdst2/fCz3A6mMhvqehCa0Hs5zNHNMDmQ1SJqLDgP5mKbi3reOkM7cebf9/JQPzCyAeo/Gccou00s5a3Gt/3/ur3G5EigUpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757165528; c=relaxed/simple;
	bh=nTaTLwL902o3beij35jMmUsrVFPps0PVnHFZw6FN21E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnSElDS8MBFxy2VtQtZbOdXZDd6c+opv/kJvatSnb0kEPuNBfzD5ezTNcqLz1I+aUmVqSCQkgK5bOGac8/0+WQTQu2PoYnp00ejuwLVqmdTbDnzl0rAh9vZkpffWSJECYOvtMo2+ydcEcqKmyL2QLiwygmT/xKXJAHKa2jizuWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8MyhB+K; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6228de281baso1797176a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757165524; x=1757770324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOjr16z3iFFG0GZCJDInNOhhVNmobQ6kWnPwwzJcCqk=;
        b=G8MyhB+KX5iNsKwBWLOEmyINv5nq0u2gsFtaHCPzfz1NQBB3fErmOCnPETE7DuZGox
         Ejfa6c3fSqESj2SgVxDhm5XH0f+pUYx7DIh6Y0Ue9dXyezJvugh+oKX3oTFSifEAF35x
         +f9D6qtWritcfQ2tEX6x6kR2VkJXKzA/NKdLkI+fxa/4FoegIMZmErfIUGJ5tjssUZYz
         IP19F+Da0tAKe3r8hLQ+CGjy7Jvl6+FhHbKrrC/Gor1vWgUG3+R+bLOw1A3D6m8Fz6nm
         m+tn9cWjWgt+V3EM5ScRWDCo0hw5XXDH0XQMGZ92eAYdtgj3e8UJzGda0ZLbOL+blIU6
         3Bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757165524; x=1757770324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOjr16z3iFFG0GZCJDInNOhhVNmobQ6kWnPwwzJcCqk=;
        b=wIFYGgA4Kc9cADSIDpAX9yHKa6ATPenqq/9Qeua8yeICjq0CuJnTxCo6ThMG6r2aM1
         pJbodVUJGwGMItcBaa58/M6E+aDkYj3b37EJu9btw5HHDJYvwsPpj995dXDyuhkogcy9
         eL3i4xVKH7FLfUUHVPOcPcpaE0SdeKubFzs9aBjQ2Cm6TyuFTsXpMluNmyYzai3Xno8a
         lr2r2OPvCls+5kB1QCqogl5g4JvoIqZkKxwwZA1n00XY5tBwPicPH5VqytY9vj0sRkdv
         CWv700ToB519SLkMI12y3dCK5XU8hFs2GzNsR4PnFyxC9cuWcGhWe70k5SjLNm02InHt
         Bq/A==
X-Forwarded-Encrypted: i=1; AJvYcCWK2nXjYwcYODG5f73hQxteOz9O5BbslclSwfIxwAzo5iApDQCJhcuk/3uLVMr3tdOPlRi8BT2uvRNORkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGwATNNi0mGT7OKZxmsu+R7OjowR2pMuU2X0aJkai2zjWkmSrI
	3mkfKdOw3Tpo1Ma+GqeXkZrH/oXY7Eimo3U3sFwDyhedvd7da8sqnrTnbjG0IV7VRPibyk2DM5D
	3zYDIbFSusuKvpKsVayT5CoIFKiDX4CU=
X-Gm-Gg: ASbGncsVXN7BGKC/eb/ePkZQuFRX3EWdONTYivgY0KgvXmHOHUKaewTYY3lJc0JrGez
	OGCX+OpWIlGBnJGftouyxB+Wmb6z6KbXGrgoGbWTiBemSWhpYMhLRLtupfBy2YgChJj5vdBvHQh
	G9uLLaHCg2neOnGIwu5DjKAamjVzP6qjsYaUCOV64JaTEKRW65P3CZ/gC/WR5rgoJQC5EbDn2we
	smc2IWMS2g=
X-Google-Smtp-Source: AGHT+IHG6G4gWpwGqJxGHLfIICndYKim+2bE+CSRWqJCCNL3LoUe3y6m0/pSNCmqqsFFeG1iBJd4Ef2O5yds5STYhhQ=
X-Received: by 2002:a05:6402:348d:b0:625:aaae:c199 with SMTP id
 4fb4d7f45d1cf-625aaaec3a8mr1264054a12.1.1757165524254; Sat, 06 Sep 2025
 06:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-2-ryncsn@gmail.com>
 <CAF8kJuMsGGtOuPpDwFKq0sNhX7HKbQWWK31uWpqeqW-RGTo-0A@mail.gmail.com>
In-Reply-To: <CAF8kJuMsGGtOuPpDwFKq0sNhX7HKbQWWK31uWpqeqW-RGTo-0A@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 6 Sep 2025 21:31:27 +0800
X-Gm-Features: AS18NWDELQkUGhXFIMgs5YM77ANpVCaP_i9mrVBu93dI7V9Pvwt8b0jXtcdeeYk
Message-ID: <CAMgjq7CtEwBMVz67nA7wL6PryZuTmaOut4yPhUyhQV0xkuc=1Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] docs/mm: add document for swap table
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 8:05=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Fri, Sep 5, 2025 at 12:14=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > From: Chris Li <chrisl@kernel.org>
> >
> > Swap table is the new swap cache.
> >
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  Documentation/mm/swap-table.rst | 72 +++++++++++++++++++++++++++++++++
> >  MAINTAINERS                     |  1 +
> >  2 files changed, 73 insertions(+)
> >  create mode 100644 Documentation/mm/swap-table.rst
> >
> > diff --git a/Documentation/mm/swap-table.rst b/Documentation/mm/swap-ta=
ble.rst
> > new file mode 100644
> > index 000000000000..929cd91aa984
> > --- /dev/null
> > +++ b/Documentation/mm/swap-table.rst
> > @@ -0,0 +1,72 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +:Author: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com=
>
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Swap Table
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Swap table implements swap cache as a per-cluster swap cache value arr=
ay.
> > +
> > +Swap Entry
> > +----------
> > +
> > +A swap entry contains the information required to serve the anonymous =
page
> > +fault.
> > +
> > +Swap entry is encoded as two parts: swap type and swap offset.
> > +
> > +The swap type indicates which swap device to use.
> > +The swap offset is the offset of the swap file to read the page data f=
rom.
> > +
> > +Swap Cache
> > +----------
> > +
> > +Swap cache is a map to look up folios using swap entry as the key. The=
 result
> > +value can have three possible types depending on which stage of this s=
wap entry
> > +was in.
> > +
> > +1. NULL: This swap entry is not used.
> > +
> > +2. folio: A folio has been allocated and bound to this swap entry. Thi=
s is
> > +   the transient state of swap out or swap in. The folio data can be i=
n
> > +   the folio or swap file, or both.
> > +
> > +3. shadow: The shadow contains the working set information of the swap
>
> I just noticed a typo here, should be "swapped out page"
>
> > +   outed folio. This is the normal state for a swap outed page.
>
> Same here. "swap outed page" -> "swapped out page"

Thanks, I used some grammar check tools and it seems they are not
perfect with kernel terminologies.

>
> Chris
>

