Return-Path: <linux-kernel+bounces-795651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D806B3F5E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D3F1A86613
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A174A2E54A2;
	Tue,  2 Sep 2025 06:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7gFHxYF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A56B2AF1B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795942; cv=none; b=gNCwXZdouitgvWV4aUI77QK+MnPU2g4uiUaf6w9sfHj308pnRYgJNavmVvMUgLefKrDUM2jLVs1iMaB3+y7ntB5ZRoJ2Rzd69SwYw/lgkn3ySnq56Orfnwx/WDPdHFYH2d+bZPZl6HUuAjFdIt7QxIn0rx958odPRMOQnch7oXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795942; c=relaxed/simple;
	bh=6wl6cmFHceRAAEs+T1LUMeqQQEIvnM/lh5zH61vEsBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+alUvzsBJLo4mZn5m1F6vjXOKJiekBtk/n1CuZ6mvrqn7R52D2C+ATuKFmw53FQysF1Sz7Xrz8x5Aun7Mxy5Mh/dPINE16CgHrmiAnoeuOlRk5W+bwCoAjmQ5lw3YGBjTl7tagHmqtOxJryJbaOV60HF3WzTBOzPx0CQ8H/mQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7gFHxYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836E1C4CEFA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756795940;
	bh=6wl6cmFHceRAAEs+T1LUMeqQQEIvnM/lh5zH61vEsBM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R7gFHxYFb053AS32peRwBAjn8ZYeNhT0a6ZCC7OAfM+cQKJEvC8k8w4A/VNn8fnTr
	 hSudmvEhdmAJC37voINtF++4d2V38su0rlaC8xt5sPEdFDcgehI8xVTa8mTuR7XD2k
	 zweUMNMiN2TQq1GQUoI1cE/GhlzMzrjRWjaJTsJo/cQanGJyCZvyUPnmT0l+bYh6jd
	 LUzdNBDUy0cmWt3TiPfQjfVc77qazmEXKW0qZ5NqrprLpQ9ImUxyg52Luud+AB+3HW
	 uI4RjMXF4UWd9397WFoLug+cNDHO5AJwOUuv8dknyjqAG9Wff/NXIgxRJxeRj2bX+z
	 XERzxjlT05UbA==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d6051afbfso41927017b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 23:52:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBuLmtyDXjATNvMCN2jsJAhS8Glgh1iLqOpqOlzgtyfCOTzSRXcrK49i6E39RU3+RNqVcJewsQOev6K38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+vDdbXhQUycqEILM6ZspWTh0se4t4LuiutFnwZl2YZPUEFvYe
	IIpZIp+wJq7d4YEI2lz6Y7LSx0sp5cv7b+KyN/vjfk4IBSCAZuSMJkrsFe4HgiV1EXHav+eJ7Uf
	5vvwm5InAkYI8D0oaRbnn2CQzJ+qMEmVT+SIgmA7tuw==
X-Google-Smtp-Source: AGHT+IGzRpgkehqNIOLRAMXCcfmGGF3mxatyKy1pNHfvYlAI6JF4EfIHPF8w6zxyPs3mXt6v7TcBX64xqhBWpaUj9OU=
X-Received: by 2002:a05:690c:9c0f:b0:71f:b419:8f6a with SMTP id
 00721157ae682-723ae3b3444mr4530277b3.38.1756795939830; Mon, 01 Sep 2025
 23:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-2-ryncsn@gmail.com>
 <CAGsJ_4xoN35Av2H70o+dwGzhKrAnm7gppEseG0MgAUPQt2TygQ@mail.gmail.com> <CAMgjq7Au2n7PO6yb7wyCJbvFceGj6cpQCp+kVTewPjU=WhmXKQ@mail.gmail.com>
In-Reply-To: <CAMgjq7Au2n7PO6yb7wyCJbvFceGj6cpQCp+kVTewPjU=WhmXKQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 1 Sep 2025 23:52:08 -0700
X-Gmail-Original-Message-ID: <CACePvbXWSCm0M-c085ss=ys9XGePQTHocFGfUSm_ZUbemAZwOQ@mail.gmail.com>
X-Gm-Features: Ac12FXw1E3Nb8_UZtKM2TaG5JnD1427eK-n7xw8pepASNKmzu_t-q8VbeCXEYYM
Message-ID: <CACePvbXWSCm0M-c085ss=ys9XGePQTHocFGfUSm_ZUbemAZwOQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
To: Kairui Song <ryncsn@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 11:13=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Sep 2, 2025 at 9:14=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > On Sat, Aug 23, 2025 at 3:20=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Always use swap_cache_get_folio for swap cache folio look up. The rea=
son
> > > we are not using it in all places is that it also updates the readahe=
ad
> > > info, and some callsites want to avoid that.
> > >
> > > So decouple readahead update with swap cache lookup into a standalone
> > > helper, let the caller call the readahead update helper if that's
> > > needed. And convert all swap cache lookups to use swap_cache_get_foli=
o.
> > >
> > > After this commit, there are only three special cases for accessing s=
wap
> > > cache space now: huge memory splitting, migration and shmem replacing=
,
> > > because they need to lock the Xarray. Following commits will wrap the=
ir
> > > accesses to the swap cache too with special helpers.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> >
> > Nice! This has cleaned up the confusing mix of using
> > swap_cache_get_folio with VMA, filemap_get_entry,
> > swap_cache_get_folio without VMA, and filemap_get_folio.
> >
> > Reviewed-by: Barry Song <baohua@kernel.org>
>
> Thanks!
>
> >
> > Do we have any potential "dropbehind" cases for anonymous folios?
> > I guess not for now.
> >
>
> Right, dropbehind doesn't apply to anon yet.
>
> > __filemap_get_folio()
> > {
> >         if (folio_test_dropbehind(folio) && !(fgp_flags & FGP_DONTCACHE=
))
> >                 folio_clear_dropbehind(folio);
> > }
> >
> > Can we mention something about it in the changelog?
>
> I can add some words about it in the commit message. One can easily
> tell that if we want dropbehind for anon, swap_caceh_get_folio will be
> the right place to handle related logics.
>
> Now with swap_cache_get_folio being the only place for swap cache
> lookup, and in the next phase we'll make the swap cache layer the
> unified way to do swap synchronization and never bypass it, maybe
> dropbehind will be easier to do too.

Thanks for the cleaning up and unified swap cache synchronization.

Really appreciate it.

Chris

