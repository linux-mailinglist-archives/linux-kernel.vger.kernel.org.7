Return-Path: <linux-kernel+bounces-760701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8FCB1EF0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5E75A0219
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C120E27877D;
	Fri,  8 Aug 2025 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv8UqQzF"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333B127F74C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682750; cv=none; b=CjIqRf4kWQBEfqe1BsGFIfQpXrvnjcoZK2Zyeatm01++Rv4envOgZyjWjkouD1W2EEa/+EplYVZw4gv86yWLWlmShosr2t1mtcaNg2vyE2FQr1WSsL23t2VmX5FHp975Hp75dPQxUOVphEbVbquuQc9Io4S02ouylgw6SQuuCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682750; c=relaxed/simple;
	bh=iQQz3sQSg8UQ0/9jJeDzuOFHFOzD5yfuSynI+5AzFro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhHBA2Mfw8FCPZoE4wuPCdA167irZBcoob6hcuQPFmGaXb5eBhi+0eL7X1BiMSN/+FnCJy5M5F7U3Pm0RLhgcozve4Duup+KNf1ujwzgPUSg1emDP3VzGQnzShcAAZmSqq700JyR2z5GJYMz0dK9jhlnT21NxIcPoyro2v1v/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv8UqQzF; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3338252b2e6so19843901fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754682746; x=1755287546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOksUUkmNUo1gJjXyzVJ9JNirYCmT1mcW6HEbUxRrvk=;
        b=Pv8UqQzF2s4XaAGVwNiZUQ5nWaA50WzpKuUv1uOgTod1TWwqHa1psvKQKW0TDP77nq
         R3MFFFd1DgYkdRBpf+4VxeBfdn9sXWh6eWkGHdwGTeGAlbiZl35NHLpzdfBOmYHrikm7
         4HAvWLYJ/UK1/VP0mehII7KNiciEzZjPeKbXwc3GEyu2RoCu22OX2VNfvEKI2JPIfz36
         XVG+nkL45gYcTUqAg0iAEqolkoW+vl50NimZyJQtD1Tk6eilXwIy67ULT9aiA2uBFrg7
         NrUOsXJT6c0m8oegMySzFA9Xo++UlQ71TnSvupdXU9drkfXgCdwWSao1Aj9i3nEyVYHB
         h55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754682746; x=1755287546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOksUUkmNUo1gJjXyzVJ9JNirYCmT1mcW6HEbUxRrvk=;
        b=ILGvYbvh7EsxVoJSuSVuX9tAL3uYGa+d74n7vYuRqY9oTssq29bqC7k2ci1djwQKlz
         tKBvpZEoCzxdBCFwiJuMXFGVtXOJO8r0/j7KylboIF+BI0tHPz5GbB/M5xwiHzM2gTmI
         S0uXf6iCUfkFF2kL2ksKCZNBh5tu/wNkZNitb6wO98xK4PHuMVj5Rlaevc0NLGJ9R0C3
         4V1ZynqQdwExSQXBvjHAl7Gb8qnSLYiFzDJmR9qOEoZqNLOGZjxbH3S/jwI935hs3LHV
         AmMkklWhOfPpFb+smdf+veIHXUGmE41CN2wlyYPTR/4TBvMxH7lKrOHLPi4lSeoO9P8R
         Ic/g==
X-Forwarded-Encrypted: i=1; AJvYcCV0jcfy9nQaF2rTPLLZh5M+FKRqAjL/3wKGCJxcuYk65wHZmMYIx3KPVSchzMh6/bNAfO3zUKkt4QjZGr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIcX1cssEa4EwdqEwDwzk33Y4Vhs4My07VVezGH8dFrx43FRvu
	fe7gUrOl/Yo+kzRsSowqPZRhLF2A/dychYFKtGcaxSMmbcEP516NEfXK99BT2/r7PD35T/fAZe9
	Dzm5LKOH0vmoh9QGmBXEA+u7Ub2vO/sI=
X-Gm-Gg: ASbGnctfrpjEmdIkZXLaB/KSn0g9eAm99nT6MoStO2Uoz52hW4RvT5nFHq/6T4s/YSq
	JB2mwFzZSZJeZRc72DzggKdtCuERF4qgKigkpAt8E2BGqxxrqy4OP5ucB+qYFwIAdSj+jfbvFsr
	pdFX8ZS3bGV5r3JdA9EQdUA9x+0JuC8OtwtEiBcWd1hoGhRwqMH4VzgZgesM/W67PTJafqZg5+r
	dsBuDI=
X-Google-Smtp-Source: AGHT+IHJmhdxrLLs3Pqi9sJOtvva6r1zJo7sfa30BJij0hWkFOlPr3jdMn4zGmXgBA8eCsIvOKwFBRQ4mJSUnJTY95E=
X-Received: by 2002:a2e:a99e:0:b0:332:3a1c:beca with SMTP id
 38308e7fff4ca-333a2144a1amr10160591fa.7.1754682745742; Fri, 08 Aug 2025
 12:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-swap-scan-list-v2-1-d50e4758ecee@kernel.org>
In-Reply-To: <20250808-swap-scan-list-v2-1-d50e4758ecee@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 9 Aug 2025 03:51:48 +0800
X-Gm-Features: Ac12FXyUrPb8BcGkWY_t-4KAtxH6S2b_tPnxlwBGo-VQL9EFvWOu6cwFLsZK38s
Message-ID: <CAMgjq7DnniGUdpQQA0YF+LuMuL9+FCLQJP2Q04G_Hsd1sztv9A@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swapfile.c: introduce function alloc_swap_scan_list()
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 3:48=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> This the alloc_swap_scan_list() will scan the whole list or the first
> cluster.

Hi Chris,

This sentence reads strange to me, but English is not my native
language so I'm not very sure about it.

>
> This reduces the repeat patterns of isolating a cluster then scanning
> that cluster. As a result, cluster_alloc_swap_entry() is shorter and shal=
lower.
>
> No functional change.
>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
> This patch goes on top of Kairui's swap improve cluster scan series:
> https://lore.kernel.org/linux-mm/20250806161748.76651-1-ryncsn@gmail.com/
> ---
> Changes in v2:
> - Adjust change base on Andrew's feedback on int type and break out of
>   loop.
> - Link to v1: https://lore.kernel.org/r/20250806-swap-scan-list-v1-1-a5fe=
2d9340a2@kernel.org
> ---
>  mm/swapfile.c | 86 ++++++++++++++++++++++++++++++++---------------------=
------
>  1 file changed, 47 insertions(+), 39 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4a0cf4fb348d..f26678d68874 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -820,6 +820,29 @@ static unsigned int alloc_swap_scan_cluster(struct s=
wap_info_struct *si,
>         return found;
>  }
>
> +static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
> +                                        struct list_head *list,
> +                                        unsigned int order,
> +                                        unsigned char usage,
> +                                        bool scan_all)
> +{
> +       unsigned int found =3D SWAP_ENTRY_INVALID;
> +
> +       do {
> +               struct swap_cluster_info *ci =3D isolate_lock_cluster(si,=
 list);
> +               unsigned long offset;
> +
> +               if (!ci)
> +                       break;
> +               offset =3D cluster_offset(si, ci);
> +               found =3D alloc_swap_scan_cluster(si, ci, offset, order, =
usage);
> +               if (found)
> +                       break;
> +       } while (scan_all);
> +
> +       return found;
> +}
> +
>  static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool=
 force)
>  {
>         long to_scan =3D 1;
> @@ -913,32 +936,24 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>          * to spread out the writes.
>          */
>         if (si->flags & SWP_PAGE_DISCARD) {
> -               ci =3D isolate_lock_cluster(si, &si->free_clusters);
> -               if (ci) {
> -                       found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> -                                                       order, usage);
> -                       if (found)
> -                               goto done;
> -               }
> +               found =3D alloc_swap_scan_list(si, &si->free_clusters, or=
der, usage,
> +                                            false);
> +               if (found)
> +                       goto done;
>         }
>
>         if (order < PMD_ORDER) {
> -               while ((ci =3D isolate_lock_cluster(si, &si->nonfull_clus=
ters[order]))) {
> -                       found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> -                                                       order, usage);
> -                       if (found)
> -                               goto done;
> -               }
> +               found =3D alloc_swap_scan_list(si, &si->nonfull_clusters[=
order],
> +                                            order, usage, 0);

All other alloc_swap_scan_list calls use `false`/`true` but this one
uses `0` for `scan_all`.
And it should be `true`, right?

> +               if (found)
> +                       goto done;
>         }
>
>         if (!(si->flags & SWP_PAGE_DISCARD)) {
> -               ci =3D isolate_lock_cluster(si, &si->free_clusters);
> -               if (ci) {
> -                       found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> -                                                       order, usage);
> -                       if (found)
> -                               goto done;
> -               }
> +               found =3D alloc_swap_scan_list(si, &si->free_clusters, or=
der, usage,
> +                                            false);
> +               if (found)
> +                       goto done;
>         }
>
>         /* Try reclaim full clusters if free and nonfull lists are draine=
d */
> @@ -952,13 +967,10 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>                  * failure is not critical. Scanning one cluster still
>                  * keeps the list rotated and reclaimed (for HAS_CACHE).
>                  */
> -               ci =3D isolate_lock_cluster(si, &si->frag_clusters[order]=
);
> -               if (ci) {
> -                       found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> -                                                       order, usage);
> -                       if (found)
> -                               goto done;
> -               }
> +               found =3D alloc_swap_scan_list(si, &si->frag_clusters[ord=
er], order,
> +                                            usage, true);

And it should be `false` here.

> +               if (found)
> +                       goto done;
>         }
>
>         /*
> @@ -977,19 +989,15 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>                  * Clusters here have at least one usable slots and can't=
 fail order 0
>                  * allocation, but reclaim may drop si->lock and race wit=
h another user.
>                  */
> -               while ((ci =3D isolate_lock_cluster(si, &si->frag_cluster=
s[o]))) {
> -                       found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> -                                                       0, usage);
> -                       if (found)
> -                               goto done;
> -               }
> +               found =3D alloc_swap_scan_list(si, &si->frag_clusters[o],
> +                                            0, usage, true);
> +               if (found)
> +                       goto done;
>
> -               while ((ci =3D isolate_lock_cluster(si, &si->nonfull_clus=
ters[o]))) {
> -                       found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> -                                                       0, usage);
> -                       if (found)
> -                               goto done;
> -               }
> +               found =3D alloc_swap_scan_list(si, &si->nonfull_clusters[=
o],
> +                                            0, usage, true);
> +               if (found)
> +                       goto done;
>         }
>  done:
>         if (!(si->flags & SWP_SOLIDSTATE))
>
> ---
> base-commit: f89484324d5876ee10765fa61da0332899fa1a6a
> change-id: 20250806-swap-scan-list-2b89e3424b0a
>
> Best regards,
> --
> Chris Li <chrisl@kernel.org>
>

This makes the code much cleaner, thanks!

