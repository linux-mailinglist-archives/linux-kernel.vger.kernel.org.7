Return-Path: <linux-kernel+bounces-757101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93833B1BDAD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02651807CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CABD23CE;
	Wed,  6 Aug 2025 00:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkYCFh55"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A95317597
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754438627; cv=none; b=gK3BnkEAAwPQ98nUxHWbqLcDyvHrvg61VkURHlptLFl44t5PzvoBuqErd1iWJnNuA6v/wWMDVwjssayHh1nohkHohJ37VynZN7cSGFnLgKjifdC28TBZID9j4XOXgRF0DxsAH0uDH9m+k1reZmsJfuvoDhXe5sRoGaBh3z5Xt/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754438627; c=relaxed/simple;
	bh=Ve8lF3DXY/ji1mnycyosh+HSTR6f5GbuLW/besKl434=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myQKJko2/ctp7xW3nwlKIB1Xl0F27SrxYNDGQfcHQKsI3+Voouq8i/JyOEkzTrFvWFtiLecuCGxbitq30T5gOSG49TRwZ4J2uaS55CDTNq0bjlbSnEQ8h5agDtoSXn+/SNSfwQsZx//hFnbVnoJJw635NuouCoXxd/YNYWF21qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkYCFh55; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e40d006105so30222395ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 17:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754438624; x=1755043424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9Az5nMK8fbyPLQPVq6entSkBs9bBtBVFWXE9onhr3A=;
        b=MkYCFh55euLmlk9LTeukk7f7XWmHUhjrHMo8w2oJDNC4tmJYejcpQB/g/F1CAlsRMT
         ZFjZn//Byd6WiBR2Pdld9FJiojb0WLKKt2TK0fcb+0q+cIawgBK5ZJPuFeJj/5gT0PGf
         YFTSgl8Uftgzs5dAD/JoXgaB/YJllpVclmBI69tVaZSqt1HExu3UFceFVfKPMf2pgzf+
         jGnDJswZjwCXefSPeulvjhPfY9nDyFmV0bWJMuLGxbAl9jbvgbp9W8dLdxVctwNH2ALD
         TZNxSMA2j9IcMnA1Jnqtpi4prwZNXAKm3M6kz2h9jJjNsWwF5zbjRfs3B/F1/VqOP23g
         1Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754438624; x=1755043424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9Az5nMK8fbyPLQPVq6entSkBs9bBtBVFWXE9onhr3A=;
        b=nuDfcZngERwRvFeyHm5m6I0PfNxCCgrjWvDMnHq7kP66C9pF/QwFc6jAxPqh5HZvKS
         gQRGiNh/p66swcQRXDjBBl8aHdajAS7LT4GmD6g+hJiVQ3Er+Pnnc84bIT22fVESl62U
         /BEkDZVmoAo8s8GXnZld2TT6wH/Bx9EOdvOsPGMo5uxZnzF502aE2U2chd66rbyJlrMf
         7ODQwyKt3fA/zdudXIYXVy9Lzt/yvvMNKolSYX+QrlgZYc/Qvl8t/Rf4gTMmzVg669th
         H0mDHPSs4+ouBLEBxLyyHE0vohiNY2a8KtTtlOxxcmfIQ9dr8COiV2HmU3Sn1uG6Tf0u
         xoCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLcJnFKRhZaiGGLFYN+HpGmB6pyxladYfErhsgyos2BiHGwiceCe8u4keBy39e42XqAzjlqxzDWmVEyTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YylGbEvahWv4lF+XgOnVa7cXuCUO+v6nC8E6f8JeWGb+gcp1h1S
	pQ6eL6iEM0e1XCKAaRqI5Ki+ziJf2QQRsntfx9Jq4JTs2dNDc34e+qVChkbtEHLLAxdcIL3Dqd5
	Jgibqu+rIU0mg39CEN79+B0ye0PS1VnjoT9jy9tCUZg==
X-Gm-Gg: ASbGncv289f7XaBNuEiQN01u/nP6MVv3Q++PrLz870JoY0fgR0yUosEuoBSOI2JGm/1
	FGquX1JSx0bLhTLM7rUuWNSGSEZ5yFMyYE4hue+yhsTGMKtuiQMBacKwsfQ2Vc0Y7bCH0tEj2e2
	vsK3edvVa1XYiRrW3AkdqatvbSluLR26cP5rRaadduzNfY75Wu553NzQGRqbduj5jaB6P/MH+A1
	n1L2+1QzUW+REMDnEkGy84=
X-Google-Smtp-Source: AGHT+IH4/jj76l3ofQECGaPWCFATYwMGPMeaqkfQQVMXyZcr9rWEy+uXsODNIG0ouW7aTNjLVw3SAVzKrkpnpXdH5rY=
X-Received: by 2002:a05:6e02:3193:b0:3e2:c5de:5fb with SMTP id
 e9e14a558f8ab-3e51b91907fmr11548015ab.18.1754438624092; Tue, 05 Aug 2025
 17:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804172439.2331-1-ryncsn@gmail.com> <20250804172439.2331-3-ryncsn@gmail.com>
In-Reply-To: <20250804172439.2331-3-ryncsn@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 5 Aug 2025 17:03:33 -0700
X-Gm-Features: Ac12FXy864CCrnwXvvUn6b07bRzjYU7wFBiXElgxTmW8DadL4kPHfdqHucJZ40o
Message-ID: <CAKEwX=PkJdz3Um9j4m2bPahN9NbQpn7QnOvEAxDdWUHTqSvchg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm, swap: prefer nonfull over free clusters
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 10:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> We prefer a free cluster over a nonfull cluster whenever a CPU local
> cluster is drained to respect the SSD discard behavior [1]. It's not
> a best practice for non-discarding devices. And this is causing a
> chigher fragmentation rate.
>
> So for a non-discarding device, prefer nonfull over free clusters. This
> reduces the fragmentation issue by a lot.
>
> Testing with make -j96, defconfig, using 64k mTHP, 8G ZRAM:
>
> Before: sys time: 6121.0s  64kB/swpout: 1638155  64kB/swpout_fallback: 18=
9562
> After:  sys time: 6145.3s  64kB/swpout: 1761110  64kB/swpout_fallback: 66=
071
>
> Testing with make -j96, defconfig, using 64k mTHP, 10G ZRAM:
>
> Before: sys time 5527.9s  64kB/swpout: 1789358  64kB/swpout_fallback: 178=
13
> After:  sys time 5538.3s  64kB/swpout: 1813133  64kB/swpout_fallback: 0
>
> Performance is basically unchanged, and the large allocation failure rate
> is lower. Enabling all mTHP sizes showed a more significant result:
>
> Using the same test setup with 10G ZRAM and enabling all mTHP sizes:
>
> 128kB swap failure rate:
> Before: swpout:449548 swpout_fallback:55894
> After:  swpout:497519 swpout_fallback:3204
>
> 256kB swap failure rate:
> Before: swpout:63938  swpout_fallback:2154
> After:  swpout:65698  swpout_fallback:324
>
> 512kB swap failure rate:
> Before: swpout:11971  swpout_fallback:2218
> After:  swpout:14606  swpout_fallback:4
>
> 2M swap failure rate:
> Before: swpout:12     swpout_fallback:1578
> After:  swpout:1253   swpout_fallback:15
>
> The success rate of large allocations is much higher.
>
> Link: https://lore.kernel.org/linux-mm/87v8242vng.fsf@yhuang6-desk2.ccr.c=
orp.intel.com/ [1]
> Signed-off-by: Kairui Song <kasong@tencent.com>

Nice! I agree with Chris' analysis too. It's less of a problem for
vswap (because there's no physical/SSD implication over there), but
this patch makes sense in the context of swapfile allocator.

FWIW:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

> ---
>  mm/swapfile.c | 38 ++++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 5fdb3cb2b8b7..4a0cf4fb348d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -908,18 +908,20 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>         }
>
>  new_cluster:
> -       ci =3D isolate_lock_cluster(si, &si->free_clusters);
> -       if (ci) {
> -               found =3D alloc_swap_scan_cluster(si, ci, cluster_offset(=
si, ci),
> -                                               order, usage);
> -               if (found)
> -                       goto done;
> +       /*
> +        * If the device need discard, prefer new cluster over nonfull
> +        * to spread out the writes.
> +        */
> +       if (si->flags & SWP_PAGE_DISCARD) {
> +               ci =3D isolate_lock_cluster(si, &si->free_clusters);
> +               if (ci) {
> +                       found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> +                                                       order, usage);
> +                       if (found)
> +                               goto done;
> +               }
>         }
>
> -       /* Try reclaim from full clusters if free clusters list is draine=
d */
> -       if (vm_swap_full())
> -               swap_reclaim_full_clusters(si, false);
> -
>         if (order < PMD_ORDER) {
>                 while ((ci =3D isolate_lock_cluster(si, &si->nonfull_clus=
ters[order]))) {
>                         found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> @@ -927,7 +929,23 @@ static unsigned long cluster_alloc_swap_entry(struct=
 swap_info_struct *si, int o
>                         if (found)
>                                 goto done;
>                 }
> +       }
>
> +       if (!(si->flags & SWP_PAGE_DISCARD)) {
> +               ci =3D isolate_lock_cluster(si, &si->free_clusters);
> +               if (ci) {
> +                       found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> +                                                       order, usage);
> +                       if (found)
> +                               goto done;
> +               }
> +       }

Seems like this pattern is repeated a couple of places -
isolate_lock_cluster from one of the lists, and if successful, then
try to allocate (alloc_swap_scan_cluster) from it.

Might be refactorable in a future clean up patch.

