Return-Path: <linux-kernel+bounces-758453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F419BB1CF63
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9C4560FF8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F146126B0BE;
	Wed,  6 Aug 2025 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krrUPuu1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEAE21A424
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522717; cv=none; b=rfJ4NvYYlkYZa28w2TJSojXZC2MbasHEIh0WtWz2RzZNzyqe1Yp5cCVxPcTYitTWZNkLXSytJmEPVxv32Y3/yPqyMYX5CLizII0B7gXtR+W97hrxVu/5TZluW8dp/bZNjfmPPifMqAxkkb8vu7a8STrmE0nOtQjAmlkxtZw6hpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522717; c=relaxed/simple;
	bh=i7moJgUx/xSFj18d+Ij+O8XgpQh8iIyJg6xk2zbatgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7nj7hvZOz7nfRybE5WB8b2rBTwsiWpa2mxGXy5Pvpr5TFhSHLM3EZUXMedAoy9XTHMDmlY7jBoUJMChVEG3QthbcV/wN73o5PFYasco6vleH8wUQKQ+zjGgbE2uiT6d+F4suYyqeYltHm58PPS2eRxtpKmQdyK+ikqmtaqgV5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krrUPuu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DC1C4AF09
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 23:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754522716;
	bh=i7moJgUx/xSFj18d+Ij+O8XgpQh8iIyJg6xk2zbatgY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=krrUPuu1lBEhbNbv83U5eYBYHX+f4tM/rV/nhjMNi/Cki+nrqdMd3UUw89RV5hHtd
	 h31zUKdRjpSyvAJmsFrfa3+HF6oQb9eumCW+rWNA119EK5yyhWhUMQCyX+WLW9/PmU
	 ddHO4iiWpfvB1WZzgASwksMbh6MIScgvgnHgHHY/Q7ZSx5HcAChtWY++lzPILf++DM
	 tYapc+fSrh7t5GzEt/0yLHk/iU9nc24PNCGGcv3sWeLRzlfLgyrDYTbPuGCdLM9c1f
	 lpynCQeVNwbV7MloH/XSpftNKnp/F69yk1evNSA1IkKiPRi9y/0fo1l77T16fcgpMF
	 kgsvfDmMyL4fA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55b79ea50f8so414456e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 16:25:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVut4dbsFZRczhCl2wgP1frreSN01EwaZCvj5FhbZeIRRLaaL5/CWvq1IOS+nKiMdUgtBSUIcIY5RvBxDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybIJyZaMuNya2wZJ4WrZv/2EIVlo6R8zJlRbIOkStJ49KGQYQg
	lq4SCUtVA1JdDlRG7muKUGyEKqEbOGM6K78G7+aCnI3bhn6DhiyP2svxg5Fw0jVyHWneX9zPJIO
	no9RW60pv0kEQ84ALeebz+FLWmyzVTw==
X-Google-Smtp-Source: AGHT+IF6DYjTcp7hSvwBmqZfeirBCTH7sRLIv3f7sYHG2bcJmsjYkoek7c82LIHpLC5W4rMppUU5oJaohTRxwdSQpGM=
X-Received: by 2002:a05:6512:39c3:b0:55b:8827:b7c4 with SMTP id
 2adb3069b0e04-55caf357830mr1400649e87.40.1754522715597; Wed, 06 Aug 2025
 16:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806-swap-scan-list-v1-1-a5fe2d9340a2@kernel.org> <20250806153146.ee1ee22dc8f6381ff5a6d882@linux-foundation.org>
In-Reply-To: <20250806153146.ee1ee22dc8f6381ff5a6d882@linux-foundation.org>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 6 Aug 2025 16:25:03 -0700
X-Gmail-Original-Message-ID: <CANeU7QkxNfe5Ut8AnyJYV4eQOS4=aL6ni3EAcdfdgTTZ2vG41g@mail.gmail.com>
X-Gm-Features: Ac12FXxyUj4a1L_iBpo35V6Q_WzlHGvo7MstX2SyvqaYMO9ZWWJh3nSN8R54-Ss
Message-ID: <CANeU7QkxNfe5Ut8AnyJYV4eQOS4=aL6ni3EAcdfdgTTZ2vG41g@mail.gmail.com>
Subject: Re: [PATCH] mm/swapfile.c: introduce function alloc_swap_scan_list()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks for the feedback.

On Wed, Aug 6, 2025 at 3:31=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 06 Aug 2025 10:34:45 -0700 Chris Li <chrisl@kernel.org> wrote:
>
> > This the alloc_swap_scan_list() will scan the whole list or the first
> > cluster.
> >
> > This reduces the repeat patterns of isolating a cluster then scanning
> > that cluster. As a result, cluster_alloc_swap_entry() is shorter and sh=
allower.
> >
> > No functional change.
> > ...
> >
> > ---
> >  mm/swapfile.c | 86 ++++++++++++++++++++++++++++++++-------------------=
--------
> >  1 file changed, 47 insertions(+), 39 deletions(-)
>
> A nice little patch.
>
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 4a0cf4fb348d..fcb1e57d8108 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -820,6 +820,29 @@ static unsigned int alloc_swap_scan_cluster(struct=
 swap_info_struct *si,
> >       return found;
> >  }
> >
> > +static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
> > +                                      struct list_head *list,
> > +                                      unsigned int order,
> > +                                      unsigned char usage,
> > +                                      bool scan_all)
> > +{
> > +     int found =3D SWAP_ENTRY_INVALID;
>
> but this function returns an unsigned int

Will fix it in the next version.

>
> > +
> > +     do {
> > +             struct swap_cluster_info *ci =3D isolate_lock_cluster(si,=
 list);
> > +             unsigned long offset;
> > +
> > +             if (!ci)
> > +                     break;
> > +             offset =3D cluster_offset(si, ci);
> > +             found =3D alloc_swap_scan_cluster(si, ci, offset, order, =
usage);
>
> so does that one
>
> > +             if (found)
> > +                     return found;
>
> `break' here.  To avoid multiple return points and for consistency.

Will do.

Chris

