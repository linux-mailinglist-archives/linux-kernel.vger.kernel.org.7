Return-Path: <linux-kernel+bounces-788691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1893B388C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A785E4C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4662C3252;
	Wed, 27 Aug 2025 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5ue+xJU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA73B2C235E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316703; cv=none; b=CL5PhzHXBEYkpc16H/NJMfVab54uuRh+GRJJQCov1Uh8lPd2iTuFQ8N9SfGbVG8fB6SPnaeXuhD65a4qFULEBq5ogkoDYTLzb3dCVVgRuNzF31t5/T6CMBcZ0i0D9/kNtVyZ4sxDIe6BQ9jIYkyrUHmHQ/43Vxqe7bdSk2T38nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316703; c=relaxed/simple;
	bh=VljAt2p7DCm9K1DJ9W5ibhxr8MfRLAstnSf6W0A2afY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUpFCGCdA34qQ8dV/V884p0J+QqRg1mGgXJktY+g9KTAr4fimfIIw3hzE8pPZEyzt8TeUjlVqZV3eyFuJdjKNrpOZRJly+bCcG8Z+Chkaackb4et+lq0+DoNZteuQoRBeHL1pF6QQwajZG8R8XF4Y/lOBKzQVPGmckIuc4KkUYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5ue+xJU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F143C4CEFB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756316703;
	bh=VljAt2p7DCm9K1DJ9W5ibhxr8MfRLAstnSf6W0A2afY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M5ue+xJURTG/EgdBNYWtP+ifnWp2Ed2MP+Ov2D2UuseEPEzh5hV7UIHH8kqqMu3+j
	 wDZXcQe1260d/nBipOgJtyJ5jhjPkwhiyXVT6HhL39Z155SVa8+054WMphWyXnB3bI
	 znly89wf+mFgf9ElB4up40Bm522fdV8Jg0LVYIc7pz1/PqfAst6U72D+k0jDovOcRH
	 32JQJdrX7/04ejpWNKbT+3WYPbK+i4t+fXxVecwRVvNkzafItb7tjwlO7uUn5d9Fcb
	 DMRb1WSdr8+Jd4QYMdSfIQ5eCyUCRV6Y5EpYY2hgOwuhfbaUVnDl35aFiCqxOtKcVR
	 MwgyVwKnuZyKQ==
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e96e5a3b3b3so8786276.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:45:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRkqfUSPQSlNg+bdFzIaN+2Rc5wHYn9LAgZOk23A5FG3Je22/G8hqHGz4jTsMG/XBd+UgVHPvp4iA1IEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx34Mj7IGrkWYASmXl3w2bG4QGYqGJ3+y6xSHaUYG+RPK13XO6V
	WznjQ9Rh3S/sBsE3uBcVlND4xhCjj5eXW6RULGxPZ8ScDGCSF9SES//izaXpRz55l5nDaIR9tON
	vylslTmiReYDdMAxTiIroWhvZBYEwkPgipvmKOX7uPQ==
X-Google-Smtp-Source: AGHT+IH410Dh0xmyIvjcmTpUNdArM69ZBr6i/qkg9Xier1rDRpXe/jJcgUeuDZjb9l+R3aRee1wIqjnRi3hTBWoa+Qk=
X-Received: by 2002:a05:6902:1505:b0:e8c:b1d:22a7 with SMTP id
 3f1490d57ef6-e951c3c67a4mr21352497276.36.1756316702255; Wed, 27 Aug 2025
 10:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-5-ryncsn@gmail.com>
 <aK5/1so7a0i80+dz@MiWiFi-R3L-srv>
In-Reply-To: <aK5/1so7a0i80+dz@MiWiFi-R3L-srv>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 27 Aug 2025 10:44:50 -0700
X-Gmail-Original-Message-ID: <CACePvbU8pnjWCiWcSXRr4UdpuD_wdtrouLMz_fNB_=KRrdHLmQ@mail.gmail.com>
X-Gm-Features: Ac12FXxitBgRzLWlNc1poHTuU4JtqvULJx8hBNZ7d5PhlQeGIAkFrGOgwUutM1U
Message-ID: <CACePvbU8pnjWCiWcSXRr4UdpuD_wdtrouLMz_fNB_=KRrdHLmQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] mm, swap: tidy up swap device and cluster info helpers
To: Baoquan He <bhe@redhat.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 8:47=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
>
> On 08/23/25 at 03:20am, Kairui Song wrote:
> ......
> > diff --git a/mm/swap.h b/mm/swap.h
> > index 223b40f2d37e..7b3efaa51624 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -15,6 +15,8 @@ extern int page_cluster;
> >  #define swap_entry_order(order)      0
> >  #endif
> >
> > +extern struct swap_info_struct *swap_info[];
> > +
> >  /*
> >   * We use this to track usage of a cluster. A cluster is a block of sw=
ap disk
> >   * space with SWAPFILE_CLUSTER pages long and naturally aligns in disk=
. All
> > @@ -53,9 +55,28 @@ enum swap_cluster_flags {
> >  #include <linux/swapops.h> /* for swp_offset */
> >  #include <linux/blk_types.h> /* for bio_end_io_t */
> >
> > +/*
> > + * Callers of all swp_* helpers here must ensure the entry is valid, a=
nd
> > + * pin the swap device by reference or in other ways.
> > + */
> > +static inline struct swap_info_struct *swp_type_info(int type)
> > +{
> > +     struct swap_info_struct *si;
> > +
> > +     si =3D READ_ONCE(swap_info[type]); /* rcu_dereference() */
> > +     VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swa=
poff */
> > +     return si;
> > +}
> > +
> > +static inline struct swap_info_struct *swp_info(swp_entry_t entry)
> > +{
> > +     return swp_type_info(swp_type(entry));
> > +}
>
> swp_type_info() is only used by swp_info() in the whole series, can we
> open code it in swp_info()?

BTW, off topic here. I really don't like the "_info" suffix. Anything
you can put into a C struct by definition is some kind of information.
Same to the _struct. Anything defined by a struct is a struct. Don't
need to say that.
The "struct swap_info_struct" gets two of the unnecessary words. It
should be something like  "struct swap_file" or "struct swap_device".
Renaming it is too invasive to the code base and it will mess up the
git annotation history.

Oh well.

Chris

