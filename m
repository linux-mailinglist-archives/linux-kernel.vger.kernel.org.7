Return-Path: <linux-kernel+bounces-759385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC2AB1DCDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2F71AA0D4F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D2B225409;
	Thu,  7 Aug 2025 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXHAXTHj"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85E42222BA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754590019; cv=none; b=OpnwzA/N28+T8d2Xu8vZgaxcM8GJ+a3wSYeLG0miZ6VAJUfeHVIb/aQJ8pGmg80M6V/kVnEUydoYsUF061ZhWaSocYqR1P+kdQhpi5Qh10ffn5KtghBc6TiB7OLDhMG1LhA5SPy2KdnGsW78IAyk9W0bbN5UbbtYvmgkj1KQLrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754590019; c=relaxed/simple;
	bh=M2DyyZpg9lf814eDZlbtNpXMO8lrILUVSy/Ctx7M3JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIiorL0Yw/DDGRezhBxgVIsBQ/CC1UfFsxGSDcCPiai4P+Jx0lPhgMm3S2tlM+cfEKeqqwh0UKZ1pQ728N8EMvjJdSrIi3soqh79FLXp9zq2ur4nX8VfOlI/flZBB4Aod5FXaA+yWR28kn7I99B1xjha601sbhUSFziYz38pHiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXHAXTHj; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-87c0166df31so65398039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754590017; x=1755194817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp2kgjsHdQl1y9XZJ6AyOg36IvapsXoaw7KHvWhnVmY=;
        b=PXHAXTHjc20iAtnzn3H+hETNbO/OyDHsTYDy21fiL2x7EnrCskVTyxOSjh66Y8wQMq
         SgZKpkP/n7UQZZkmoqZtM9WUtSbrRPCxJNmR1DwEem+EI8dfOjbhbQJ4iNvzRsq3tPig
         veO05ZUehFkKTBX0XYKtgesAW4du77iey86r9XHVvOLf/C9sAiOZwBm5ZD1Jh3ijopUt
         r8AFpK9QH+qjlHNc9lxvmATp2cYpkz8xadu+lnNvIq1CerunOn6aEYkh2A3PcjwMDLCC
         tSIVqAFDfXtYEGJauo/6ucFrYf36+3vYXBTdUQMbkPTlrCggI+CNCf+SSEnzVy+9bcxP
         mmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754590017; x=1755194817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zp2kgjsHdQl1y9XZJ6AyOg36IvapsXoaw7KHvWhnVmY=;
        b=WlUGJJ8uRP6u1woixRfhGr3T6QlruDt7ninFe/gUGFMZpOXScFYtre8JkJ/yVlZUpC
         TEuDv7b9YLczNVDZg5TbR7KWXQLgtqGjCeWrmx2K49LRkqk3UBeo7zGYcTRNBF3up3y3
         0mkCypZpf5sHhmYiHcllddLwsQUhbKlg53tjCJGj17dRSkjDXgU6udE8CMbsNNCjrZq7
         2fRG2CyjdIUWeDya5gvvZPFTdOMNuJgwwp4KhkklfKB67AtzWbVciV8m+ZmFeyPUXZUq
         +6wwfe4oZg7GEyUlJ4h+pAwhdsMRuNYN3GJxlA4pJzI9yBbp8YjgNhpGw6hpdEFmS8/L
         rP3A==
X-Forwarded-Encrypted: i=1; AJvYcCWrkFie+eIWaCYx9aZM3fQZgprdV19bM8KjJb9a7U0ZphrR6uD3Sx/OGCzLe9osHDmMWXCm9YA6+HG19Io=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+GBRDVLLGncITVtYJy0b6FuiMGmDqGtD/4cIUkqzsrEKEOhTn
	ePx05hymAML0YdJZhvI3vHOd8+RR6BbDM68q38fIENhVfLZs7vRzu6+0rlxHWrREjTemWo/86Bj
	HKKtecokTfMlkcPmOULkyS4X0LkvsfIo=
X-Gm-Gg: ASbGncvgs7/d+axxytLGWs7VEx/8ijKkle/AJ5X/uIBEJWkWBvkRz5md86+khNZ1qNg
	NEHfH/xp5/L0rrzYP1ajShkVjpWSC002gvSxM7GJOzITEGvII2tldojZ7zSw+M81KcNZnb0OZmb
	ue/xXYRVqRgLzFzUcsaK6bJDozBbSmRH6lNKo9ZEqomsSpXOCYT6A+a/TzTrOxjStJHeZUgtDsW
	r3S7JsVz5SlnuwrMQ==
X-Google-Smtp-Source: AGHT+IF6dPAP2S0TZkEDfoukOt+XI9zAHN72crWSd6WsyFuYT+/fEx1aYTk25IY/ExVBRYVry+Q6cZfvcPf1ZT8Wd0M=
X-Received: by 2002:a05:6602:26cb:b0:85b:3a51:2923 with SMTP id
 ca18e2360f4ac-8819f414119mr1653264139f.14.1754590016730; Thu, 07 Aug 2025
 11:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807152720.62032-1-ryncsn@gmail.com> <20250807152720.62032-2-ryncsn@gmail.com>
In-Reply-To: <20250807152720.62032-2-ryncsn@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 7 Aug 2025 11:06:44 -0700
X-Gm-Features: Ac12FXzvrnsqjPLSpRzyIBRnWh8E726wBNHUXhmVtmPyFOqC0JBtFx3WCFvljX4
Message-ID: <CAKEwX=P8Qh4mOdv68UfXv-YBSnuZJkhEeuRJezZucbX7sysWvg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mm/mincore, swap: consolidate swap cache checking
 for mincore
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Kemeng Shi <shikemeng@huaweicloud.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 8:27=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> The filemap_get_incore_folio (previously find_get_incore_page) helper
> was introduced by commit 61ef18655704 ("mm: factor find_get_incore_page
> out of mincore_page") to be used by later commit f5df8635c5a3 ("mm: use
> find_get_incore_page in memcontrol"), so memory cgroup charge move code
> can be simplified.
>
> But commit 6b611388b626 ("memcg-v1: remove charge move code") removed
> that user completely, it's only used by mincore now.
>
> So this commit basically reverts commit 61ef18655704 ("mm: factor
> find_get_incore_page out of mincore_page"). Move it back to mincore side
> to simplify the code.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Seems reasonable to me for the most part - just a couple of questions below=
.

> ---
>  mm/mincore.c    | 29 +++++++++++++++++++++++++++--
>  mm/swap.h       | 10 ----------
>  mm/swap_state.c | 38 --------------------------------------
>  3 files changed, 27 insertions(+), 50 deletions(-)
>
> diff --git a/mm/mincore.c b/mm/mincore.c
> index 10dabefc3acc..f0d3c9419e58 100644
> --- a/mm/mincore.c
> +++ b/mm/mincore.c
> @@ -64,8 +64,33 @@ static unsigned char mincore_page(struct address_space=
 *mapping, pgoff_t index)
>          * any other file mapping (ie. marked !present and faulted in wit=
h
>          * tmpfs's .fault). So swapped out tmpfs mappings are tested here=
.
>          */
> -       folio =3D filemap_get_incore_folio(mapping, index);
> -       if (!IS_ERR(folio)) {
> +       if (IS_ENABLED(CONFIG_SWAP) && shmem_mapping(mapping)) {

Do we need CONFIG_SWAP check here? I suppose if !CONFIG_SWAP we'll
never end up with an ordinary swap entry stored here right?

Saves a couple of cycles, I suppose. No strong opinions.

> +               folio =3D filemap_get_entry(mapping, index);
> +               /*
> +                * shmem/tmpfs may return swap: account for swapcache
> +                * page too.
> +                */
> +               if (xa_is_value(folio)) {
> +                       struct swap_info_struct *si;
> +                       swp_entry_t swp =3D radix_to_swp_entry(folio);
> +                       /* There might be swapin error entries in shmem m=
apping. */
> +                       if (non_swap_entry(swp))
> +                               return 0;
> +                       /* Prevent swap device to being swapoff under us =
*/
> +                       si =3D get_swap_device(swp);
> +                       if (si) {
> +                               folio =3D filemap_get_folio(swap_address_=
space(swp),
> +                                                         swap_cache_inde=
x(swp));
> +                               put_swap_device(si);
> +                       } else {
> +                               return 0;
> +                       }
> +               }
> +       } else {
> +               folio =3D filemap_get_folio(mapping, index);
> +       }
> +
> +       if (folio) {

Should this check be "if (!IS_ERR(folio))"? Seems like that's how we
inspect the output of filemap_get_folio() in other locations (for e.g,
in filemap_fault()).

>                 present =3D folio_test_uptodate(folio);
>                 folio_put(folio);
>         }

