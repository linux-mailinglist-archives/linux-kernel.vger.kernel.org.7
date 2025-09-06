Return-Path: <linux-kernel+bounces-804324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56204B47213
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4ED37C6AAF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2968920F09C;
	Sat,  6 Sep 2025 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzPvyuK1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7DB1DE89A
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757172944; cv=none; b=u7xhFhFk4w10L9g2hhSMUVflEnvSzA8PqLsdpNDkGalmCPjuQHakhnkMvaDSbp93v0WBMqHyMsHI8I6c3WnfCIDYtvko+0occDzl9l3Y1xpH7Fl+2AF/7+7AmzkUmorYonhbmfMHD9PtN5u8Ig+fBJtukBBNSsIQeq85ezZCZ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757172944; c=relaxed/simple;
	bh=GBGyGZ83IzgHSiMHPRhSPDRnDEIaxEHa54IZeElVbxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPP30Gucr0o98ahSDZ69yz9+R39+sFfHOdNS9AO6jPJt8XyGuvpOcHOttJpEJYv0XOHj/6c5qigDFbyur8/Iaz4vztkg8REy3tPodnyqpPhZDK2tQO4mlxIraBC6vjirP5aR8GS1EUrIR3nyk8KeeZJo7+BJZrJF6EuVJyvbX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzPvyuK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2128DC4CEFB
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757172944;
	bh=GBGyGZ83IzgHSiMHPRhSPDRnDEIaxEHa54IZeElVbxw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WzPvyuK1fvu1OEkpppnrhXOtxkvEe5b6W+5YAJrXHpaOHZVGEcgSxgLo+n3DYqy5u
	 FTfIxs+58/27e8jsMqeiYWAi+0eqTive1X535G50Ox0awHQLPjt0SRpgiksAlK+0Yr
	 WWFvtkTTkXje0YEKkPXVXAR0JkyZGwpzfEmhOhcgZqc7doOvPFaiF357c+4ApgZMOV
	 jAdwYCHslgAjviFZPpWx3rjjFpTpeuBkWMzXn5Pb5k9lvzTcgcRNpsL5tJJJcS6+p7
	 ZvwR4r0ZpW2m7atXA9kC1IP3w6WrLEU/iUPkCH1vKLCBb32kbMPapdBnacGeYqvtYC
	 ebmMxI1Hka72Q==
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45de2856648so2325e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 08:35:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXznHN1jev71y5gVlNVJ+r5VvksZEK49uKjWVXZHS5b452XIiVBfJDhIhk6Wce0edZ+CyNVWgTcGWkzWcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw28EU1647uuHGCYFtDWKXvr66posaFCTnke0YMvDUnTZxIESLY
	lS2aRNofhNtkBq7udVHHI74xIJKtFd84zveLY7gv5HTw2yMqKUoyTHJZT4s5EeL6yMblF8WVvpQ
	oO7BgskkUiYISAiR3OMianesX32V7/1zHRxTSF+bi
X-Google-Smtp-Source: AGHT+IFGBgIATgkVR2bj8AG1tHGEdgxOuaKhDRAoAnJP89DZx+8H7BkDADRRZMhx6H30ttjtzwBupCLEPUlPDvohzNc=
X-Received: by 2002:a05:600c:3ba3:b0:45d:cfca:a92d with SMTP id
 5b1f17b1804b1-45ddda4e7e5mr1104625e9.2.1757172942634; Sat, 06 Sep 2025
 08:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-13-ryncsn@gmail.com>
In-Reply-To: <20250905191357.78298-13-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 6 Sep 2025 08:35:31 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPLVp6s0iYm24tLf-h+sTmD2m-NOcw6xMPcL4HtoDnxxw@mail.gmail.com>
X-Gm-Features: AS18NWATS45oj3V_s48PvNhNF43MTf4ynWGLQEQ_CC_ieg7uOOQRpzNNblI4-BI
Message-ID: <CAF8kJuPLVp6s0iYm24tLf-h+sTmD2m-NOcw6xMPcL4HtoDnxxw@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] mm, swap: mark swap address space ro and add
 context debug check
To: Kairui Song <kasong@tencent.com>
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

I think adding one more check is fine.

I don't think there are exceptions but I am not 100% sure either. If
there are any violations we can catch it now that is a good thing.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Fri, Sep 5, 2025 at 12:15=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Swap cache is now backed by swap table, and the address space is not
> holding any mutable data anymore. And swap cache is now protected by
> the swap cluster lock, instead of the XArray lock. All access to swap
> cache are wrapped by swap cache helpers. Locking is mostly handled
> internally by swap cache helpers, only a few __swap_cache_* helpers
> require the caller to lock the cluster by themselves.
>
> Worth noting that, unlike XArray, the cluster lock is not IRQ safe.
> The swap cache was very different compared to filemap, and now it's
> completely separated from filemap. Nothing wants to mark or change
> anything or do a writeback callback in IRQ.
>
> So explicitly document this and add a debug check to avoid further
> potential misuse. And mark the swap cache space as read-only to avoid
> any user wrongly mixing unexpected filemap helpers with swap cache.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap.h       | 12 +++++++++++-
>  mm/swap_state.c |  3 ++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index bf4e54f1f6b6..e48431a26f89 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -99,6 +99,16 @@ static __always_inline struct swap_cluster_info *__swa=
p_cluster_lock(
>  {
>         struct swap_cluster_info *ci =3D __swap_offset_to_cluster(si, off=
set);
>
> +       /*
> +        * Nothing modifies swap cache in an IRQ context. All access to
> +        * swap cache is wrapped by swap_cache_* helpers, and swap cache
> +        * writeback is handled outside of IRQs. Swapin or swapout never
> +        * occurs in IRQ, and neither does in-place split or replace.
> +        *
> +        * Besides, modifying swap cache requires synchronization with
> +        * swap_map, which was never IRQ safe.
> +        */
> +       VM_WARN_ON_ONCE(!in_task());
>         VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swa=
poff */
>         if (irq)
>                 spin_lock_irq(&ci->lock);
> @@ -191,7 +201,7 @@ void __swap_writepage(struct folio *folio, struct swa=
p_iocb **swap_plug);
>  #define SWAP_ADDRESS_SPACE_SHIFT       14
>  #define SWAP_ADDRESS_SPACE_PAGES       (1 << SWAP_ADDRESS_SPACE_SHIFT)
>  #define SWAP_ADDRESS_SPACE_MASK                (SWAP_ADDRESS_SPACE_PAGES=
 - 1)
> -extern struct address_space swap_space;
> +extern struct address_space swap_space __ro_after_init;
>  static inline struct address_space *swap_address_space(swp_entry_t entry=
)
>  {
>         return &swap_space;
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 7147b390745f..209d5e9e8d90 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -37,7 +37,8 @@ static const struct address_space_operations swap_aops =
=3D {
>  #endif
>  };
>
> -struct address_space swap_space __read_mostly =3D {
> +/* Set swap_space as read only as swap cache is handled by swap table */
> +struct address_space swap_space __ro_after_init =3D {
>         .a_ops =3D &swap_aops,
>  };
>
> --
> 2.51.0
>
>

