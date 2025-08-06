Return-Path: <linux-kernel+bounces-757114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E476B1BDE6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA087AF6F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FC43770B;
	Wed,  6 Aug 2025 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdHt3nra"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86DEA93D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754440270; cv=none; b=DFfsfy5f5iiMfoNS4UNfnTsKgNvda4Ot+bVEc/D0YgxfyGoP77W5qv3oei0n8bTNzbfksb53XIqfKZRrZgF8pqN+E3kFBmjBSbyIMXps65nq2C+pGBp6CvGcDyO00p2NJx8iKS2OnqI4fZkpi4o0uVopuaXU1Tqf2Vj40H2Vl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754440270; c=relaxed/simple;
	bh=NdVW8GEHxRFur7BG7bwD8zjVH3GXuWbAKImo+tKETyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebRsHnJHUt+znC/M0qffcgPKC2240PQirKVTuaDWUUIZhtFfwzsVx3f2gzsq6o824ZOSt4fLL40kJ6j8A4mO7LENYSUc+H4i0jkMipehENJtQ/5oLq8zCIoL5n+xZvyV6zbxtMIGGlvu9sTAlY0UyUxwXZJpeTFwBmtqtW9nV2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdHt3nra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7BBC4CEF4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 00:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754440270;
	bh=NdVW8GEHxRFur7BG7bwD8zjVH3GXuWbAKImo+tKETyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RdHt3nra0caLUfJ/Dg8MBBmTWuy9ILtKqZvwlQzadX0efVxPHSjxPX++aHiVcfsNw
	 v7E0npHz6lS3xDn+eRZHdz09Ryok031/aoQjq010VIsCQzTRvlpAIVyvuCJ6sAaCuW
	 NK3mHMRn+DnNZ3Ht7v9sUtPSbLunL44dBNyFHCDN7ARjBBikH5yOsLm+crVwTf/Ve2
	 y1Sf/n1eQlRSq/ok9P9Dn83PDfCaJZRQY3uP2/Se9v6Xf5CD/SjC42NyJyMKmXgOuv
	 gu0BSaQavShnfonE5onSMy6dUoJYVUAtZaY90IIeCqM0XWNpqPygD+x7FN1OZ7Dcrf
	 fqJPu5T/+Ad8w==
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-459e497776cso37925e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 17:31:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQMBTLjVJE72JSYbygTmo4hafxBDS3hcU7ryF6/tmmUamxZpTyj0B0pGn69lKzNhWNwcNH+F0RWnsTBzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFCzSUE6IEYO0nH9jzrY4NtDf55ns4wbjOXudqtAIQdn/oYdg
	QqQvumQEtpM08ZgeF5meXKqHoYXoxSjZpIATwy2V8VrtTHauP5TuLWLz43y5Ba21St9v65Lzxz5
	H/UNomSuu8d7f3f7jBz3Ol/yLDNt6ZcWTexaY9F3F
X-Google-Smtp-Source: AGHT+IFdNhN5Gwax9QOBme7ZeWIPzBmP0VCTW8jj4gPJTs+CB/Aq8Lj1enCzcQdPRvQ2uGvSsfhLA9AxQScdbXBhpFI=
X-Received: by 2002:a05:600c:8885:b0:439:8f59:2c56 with SMTP id
 5b1f17b1804b1-459e6be6779mr427105e9.2.1754440268999; Tue, 05 Aug 2025
 17:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804172439.2331-1-ryncsn@gmail.com> <20250804172439.2331-3-ryncsn@gmail.com>
 <CAKEwX=PkJdz3Um9j4m2bPahN9NbQpn7QnOvEAxDdWUHTqSvchg@mail.gmail.com>
In-Reply-To: <CAKEwX=PkJdz3Um9j4m2bPahN9NbQpn7QnOvEAxDdWUHTqSvchg@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 5 Aug 2025 17:30:57 -0700
X-Gmail-Original-Message-ID: <CAF8kJuObbE+X3WKiO_Nviya129jeAuSXv7tCJ=4tb9SLf1pD7g@mail.gmail.com>
X-Gm-Features: Ac12FXwPeth1NcHjzl03MctXY7Aq-5aHjZOS12oEzmEfEPunQW-fKexX_ir8Z2c
Message-ID: <CAF8kJuObbE+X3WKiO_Nviya129jeAuSXv7tCJ=4tb9SLf1pD7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm, swap: prefer nonfull over free clusters
To: Nhat Pham <nphamcs@gmail.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 5:03=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>

> >
> > +       if (!(si->flags & SWP_PAGE_DISCARD)) {
> > +               ci =3D isolate_lock_cluster(si, &si->free_clusters);
> > +               if (ci) {
> > +                       found =3D alloc_swap_scan_cluster(si, ci, clust=
er_offset(si, ci),
> > +                                                       order, usage);
> > +                       if (found)
> > +                               goto done;
> > +               }
> > +       }
>
> Seems like this pattern is repeated a couple of places -
> isolate_lock_cluster from one of the lists, and if successful, then
> try to allocate (alloc_swap_scan_cluster) from it.
>
> Might be refactorable in a future clean up patch.
>
Yes, agree. I noticed that as well. Incidentally I am writing a RFC
patch to clean it up when I saw your email coming in. Another reason
to clean it up is that, isolate_lock_cluster() must be paired with
relocate_cluster(), otherwise we have a dangling cluster not in the
list. We'd better pair the isolate() and relocate() in the same
function for better visibility.

Chris

