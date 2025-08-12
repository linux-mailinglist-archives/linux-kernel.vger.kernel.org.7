Return-Path: <linux-kernel+bounces-765306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1196CB22E76
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F5A17F857
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662352C3749;
	Tue, 12 Aug 2025 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9hD6eWu"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186B280018
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017838; cv=none; b=CQj45vsZJxanpo73qAASzr+kap/ezlSQjDTKJqGsjLA0sqpJ/TB0qFR2RlJXsAhflXeIsYrsmK3NEXC/dTDjmOvwSoYZYDccehT5ccIZJRyEIFaXj8ZlfP+WLhd4ESfd0r83nFe37VhjNcgO+MasI3qAG2F8YQiG7lU+88jZuiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017838; c=relaxed/simple;
	bh=YmCo0pfH+3qlKdnkrhnnZOnaiI91D1lXK7i1wej6Lh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DApVM6wTxzHgYBUaHthAyCWJGiiCkc1+XrBQdE8Ce0LoewfK6T1Yw+hKy2f8Klx4h2GIuvuYCrhAa2UmzRp472QwzEKaWNO0nyYbG7Do+UvpGllH/qAls6ejNfDxysVxP1oGavuTozVVnf5CO6ngQHgAv96UPPqEr63Qn1nmi6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9hD6eWu; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3326163941dso691281fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755017834; x=1755622634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFHw6SHxzXcAfU/vsZyTPxWUIAjVGdLsdLAXBzbY+0o=;
        b=D9hD6eWuvU7Qj0vIFJ72UGeHYx9p53s2nRtXVi4kPcaPluS7svcvPpbeO4OSZGpWrx
         W0AelMck5elVW8dNYJ654sgenZu3Uscm6ZCZ4PqL9LR3aKmroFAAD8tuHiXwpP6/ZfVJ
         Sv2HPu95DP9HrKv8IMXCz2MeReApOoSq2/nsIdjJehsKeBh/jnqNpbSECUEE0a7Tn7Ia
         Eii6zus20n/U7Ozye1lEQEErGPmTOmrjtuchUU9CGefpFKar7OaOsWlra0aSRZ62NQho
         75ro/Jk3nI0joc3eeHCGLwYs2QZEV+QHBCyBrCARChG6CsN2inyuUcTUD1iW5ou0dNTD
         YuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017834; x=1755622634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFHw6SHxzXcAfU/vsZyTPxWUIAjVGdLsdLAXBzbY+0o=;
        b=seyqbswemJmIDr9Cbg8nnfkXo8l9OK631KI4/n99BVh8ja6ZcJ11EPNjD3dmZq8ATF
         LE+R0gji7C57luV1bMZMhFBKuLpcyqFGTH298lD8FVfzl8+rPdVEFgSFP2st35iDEhg3
         1PgfKrLl/DdoTgVMp2KALjCD7/+NgP13c0bJSBb0S/sS3PnQRfAXy50kx4Gtp6/LmB/0
         8C29ynZaZ3Vrxx89udYfyboZCQGnbU82SARS91hBYK9uj/YNsyZbNEVN3Sazk5LQft0h
         8Vo9wEvczQgzwibUeOEaVZEQ5GBTajdLAmRZT++nkChNRy2aWkkU+r72nNlxoOUuFB+F
         h1Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXKpzo3ABU2aVtYl7PstKhqxxuuatfIFyCXQ+nAbBfFnuKvxpBlogq8mqs2hLpN+FxA7jorxE99LmhEIKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzczpPOhL9bjE/cL9kqCrxEI/xW6D37eoyFPbMSvtcJRkZvMNCL
	wg/6+hZUK+xs2HJ6Y0tJumiSHzRQZfzgaN7mw+XYF8w0ruZBzB38hMwAwcuV2cpd/hGnumQmxfq
	5QEAN2pyZh4y9JTXMdj0csk00gBHRkcQ=
X-Gm-Gg: ASbGncuoX0UWTTbfxDtqOdtWm3LgF7r4PhvcVvB8SMT+1kRx7c+H8QTwR5LM6UUHPJ6
	cbytCBKiMmj3NbVKO/6PCDlby+IMcIi6+/eDlbY2rRpBryuFSRWrjQCIwdsewqnyEkCyoSlQCln
	cb8uelqAhj/Mf55ASJvhM6olqGSGgPKe7zFbcu2hwtVKTzCwEJIOlaXfDr2iCEvuR8HCRPRl+UB
	cyMJKM=
X-Google-Smtp-Source: AGHT+IGAXUSvPCUvMDI5+89UaP8N5N3O4+7t9/+gcbWizP3+ruBqRa1hZorGwzqmAZq+weI7GxvjOKbzFW/SRFp1TFg=
X-Received: by 2002:a2e:bc1c:0:b0:333:951f:6dd7 with SMTP id
 38308e7fff4ca-333e63fef8amr830251fa.3.1755017833531; Tue, 12 Aug 2025
 09:57:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-swap-scan-list-v3-0-6d73504d267b@kernel.org> <20250812-swap-scan-list-v3-1-6d73504d267b@kernel.org>
In-Reply-To: <20250812-swap-scan-list-v3-1-6d73504d267b@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 13 Aug 2025 00:56:35 +0800
X-Gm-Features: Ac12FXzo1AIPUJobDlH-XMCSbgV5hOCxYqeAZBXZCtl8HSzZUrmCxppKj48iRm0
Message-ID: <CAMgjq7CL1pUr25efhu+bT1PRdqw+TkAaCCsBi-1DRBfd28N4OQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/swapfile.c: introduce function alloc_swap_scan_list()
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 5:13=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> alloc_swap_scan_list() will scan the whole list or the first cluster.
>
> This reduces the repeat patterns of isolating a cluster then scanning tha=
t
> cluster. As a result, cluster_alloc_swap_entry() is shorter and shallower=
.
>
> No functional change.
>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
>  mm/swapfile.c | 86 ++++++++++++++++++++++++++++++++---------------------=
------
>  1 file changed, 47 insertions(+), 39 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4a0cf4fb348d..a7ffabbe65ef 100644
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
> +                                            order, usage, true);
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
> +                                            usage, false);
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
> --
> 2.43.0
>

I've been testing on top of a locally updated version of V2 for about
two days, and it's identical to this one. This looks great, thanks!

Reviewed-by: Kairui Song <kasong@tencent.com>

