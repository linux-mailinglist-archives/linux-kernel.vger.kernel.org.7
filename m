Return-Path: <linux-kernel+bounces-867957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76446C04029
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 251124E6FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE651A238F;
	Fri, 24 Oct 2025 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzfQ4ngq"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE401E552
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268809; cv=none; b=JjxYc7FTFN17g+xG8aZSr7fs/gIdm2l3n05N9IJb9FQjrfWLv1tWexmm0b7jNpIsVxxgh5BLk9qxQD/JY5x4CcXUCzEpFMp1hw080FYzi2G0UHzvBgfJrwle2POg5wN8ZVaYza0uhXpLjkvPLaeJNTqh1Pl1gNq+MmXYqbiHk8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268809; c=relaxed/simple;
	bh=w/x/IImtnZl+olRq5xGbe7gG7jFlg5y369cc+ZZN2ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kY3Ga/NMDs8CsCzFfvLRM6jQdHwakQwbBtDwZ4aUsUuWyZAoFr88gXzMLSCx098xDwhQM+41vfgpo0Naw1wd5AGYi/02ckdjd6djqYyFQcYxoNhbn7rMwvfDjdpyjefk/Xkbc3tmowmQe/oCC1ondaeP8tUdUy4iNT7sc7U45+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzfQ4ngq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-427015003eeso1395204f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761268806; x=1761873606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvyUZmMO8VPiZdlgVO/IJ2704hYsi6LPcWtQZ//HkFI=;
        b=hzfQ4ngqGpccWVp0Bis4fDpgr73SbhnGGbgEeBDJvQCmCayjQJEiIwxlKdl0/g2mvS
         FYABe8HevL0xwG2i84LB4x6EfC/UyZGSFlzBHKWucKyRQLvyUDQ7PfEru2Zoe0hXJ7Tw
         eTY9ltNff9U5/Jt2b0BFWm/uYlieuZivb6WRm4HjidOmOJmrY5NGnV4yrb/vCunI5bCu
         LYtXLkHrq2EoikxSvAirHqRzgnYrvPCrFcCZb72UxuqmZH0WVXE0E4bgwv0T0EyViRgt
         IuACt7AVSfmASmc5wrjEj1Y7IpnwfiF21FPQSOJTA0bwfO6tK9TMg1akPFQeeT2Jp/Pt
         /05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761268806; x=1761873606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvyUZmMO8VPiZdlgVO/IJ2704hYsi6LPcWtQZ//HkFI=;
        b=wJWdTWluZwNtFACe7IOLvrQBio8lzeinrtfOxFE2WYzBqYuqNu3u+gcWV6a0siM5je
         gVg+/cgd1VovJI7E8Id9kNTnpcW3GoUgpfIYBzOSXD7XRg1CYpdr3aJjZz/HtiDmj/6K
         lgnSowlOd6uHtEuvtyS/ClCpfmSJJy+JCl//Xoy6xvpyd0TTVXF3sjvbSb1HyR57Z1co
         vg2Ti5uy10PTheMRlTb/70Q//RIi4sqVQ1WrL32dOTDLVArzQ6s2YQsWYenUiLcE14RP
         l2ydww/g8GNmpjvSqbEmSg4a8xH8ldouFXYc/ECNtTFGLRP95Po3yycAvcCF/MMnz2Lo
         9djg==
X-Forwarded-Encrypted: i=1; AJvYcCXS3YpP2dySyJT0XqxymzQa2OiHe4zEH4YvxIJx0cnBtAxMOgdnWdh1FHW68C/wlIQY0Lgt7Gd4W0ko/q4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyheNO4H5mmTEnWq05XVLB4J382A6K3bp77GPaobP5vcHpJV8Ne
	FqUEpvjU01tEth/D5PAWAAI2Lc63j1zQXzzqZSHSRgNPkFL4FcCK1WJZ0UL0Tn7ISPxA6RyX94G
	rOMlc7ABYGOWntnI4G7za7aupCNjPNb4=
X-Gm-Gg: ASbGncsSLMfVHfxkFOWHos0LTAldhcnatJYowV33PYndlxqlNecA3SclOd6e7sifRP/
	QT7eKubLAFaOn/+DlyPC2OoqY2x3xonSyuuPJRPqVqhpcAZ7kTWcncopiUvtl5UJz6ExPeJK+sU
	jaOopacfPwm803lI7NPf24UP4tFgwNogLoZau7AGf0MWU30TNbQkGGtyCNgEAYMea5NrdKNRXDB
	Krwg/GW4mE90bzjwlMQNjLFnVi+W1RdUG92Q0JKLnhElhhVUv386aiw38hHzWPCB2W3xsqx9FLQ
	M/D0NvWvx7FJ0+gAqnVCjyMIH4dLXQ==
X-Google-Smtp-Source: AGHT+IFneXM0xr4BTxmFteom5iOTrMBRm3KDcNn8ea5ZwZKTXCozstAADZ8mhAUFw9RZH5CCePq+VFJYDG3ckmafY1o=
X-Received: by 2002:a5d:5d0a:0:b0:426:ff46:93b8 with SMTP id
 ffacd0b85a97d-42704d8444amr14973841f8f.8.1761268805783; Thu, 23 Oct 2025
 18:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023131600.1103431-1-harry.yoo@oracle.com>
In-Reply-To: <20251023131600.1103431-1-harry.yoo@oracle.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 24 Oct 2025 03:19:54 +0200
X-Gm-Features: AWmQ_bn7k-8N3nBX8QuM-JrNgQDPCvNlJAZ7mTQNODGDz59t7Iwz4Fszp2T7gmY
Message-ID: <CA+fCnZfJjXez_bq-jnmPTP40tPuq9XUc3Z2MtSgU7TnPz0bWyQ@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: ensure all metadata in slab object are word-aligned
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, 
	Alexander Potapenko <glider@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Feng Tang <feng.79.tang@gmail.com>, 
	Christoph Lameter <cl@gentwo.org>, Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 3:16=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> When the SLAB_STORE_USER debug flag is used, any metadata placed after
> the original kmalloc request size (orig_size) is not properly aligned
> on 64-bit architectures because its type is unsigned int. When both KASAN
> and SLAB_STORE_USER are enabled, kasan_alloc_meta is misaligned.
>
> Because not all architectures support unaligned memory accesses,
> ensure that all metadata (track, orig_size, kasan_{alloc,free}_meta)
> in a slab object are word-aligned. struct track, kasan_{alloc,free}_meta
> are aligned by adding __aligned(sizeof(unsigned long)).
>
> For orig_size, use ALIGN(sizeof(unsigned int), sizeof(unsigned long)) to
> make clear that its size remains unsigned int but it must be aligned to
> a word boundary. On 64-bit architectures, this reserves 8 bytes for
> orig_size, which is acceptable since kmalloc's original request size
> tracking is intended for debugging rather than production use.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 6edf2576a6cc ("mm/slub: enable debugging memory wasting of kmalloc=
")
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/kasan/kasan.h |  4 ++--
>  mm/slub.c        | 16 +++++++++++-----
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 129178be5e64..d4ea7ecc20c3 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -265,7 +265,7 @@ struct kasan_alloc_meta {
>         struct kasan_track alloc_track;
>         /* Free track is stored in kasan_free_meta. */
>         depot_stack_handle_t aux_stack[2];
> -};
> +} __aligned(sizeof(unsigned long));
>
>  struct qlist_node {
>         struct qlist_node *next;
> @@ -289,7 +289,7 @@ struct qlist_node {
>  struct kasan_free_meta {
>         struct qlist_node quarantine_link;
>         struct kasan_track free_track;
> -};
> +} __aligned(sizeof(unsigned long));
>
>  #endif /* CONFIG_KASAN_GENERIC */
>
> diff --git a/mm/slub.c b/mm/slub.c
> index a585d0ac45d4..b921f91723c2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -344,7 +344,7 @@ struct track {
>         int cpu;                /* Was running on cpu */
>         int pid;                /* Pid context */
>         unsigned long when;     /* When did the operation occur */
> -};
> +} __aligned(sizeof(unsigned long));
>
>  enum track_item { TRACK_ALLOC, TRACK_FREE };
>
> @@ -1196,7 +1196,7 @@ static void print_trailer(struct kmem_cache *s, str=
uct slab *slab, u8 *p)
>                 off +=3D 2 * sizeof(struct track);
>
>         if (slub_debug_orig_size(s))
> -               off +=3D sizeof(unsigned int);
> +               off +=3D ALIGN(sizeof(unsigned int), sizeof(unsigned long=
));
>
>         off +=3D kasan_metadata_size(s, false);
>
> @@ -1392,7 +1392,8 @@ static int check_pad_bytes(struct kmem_cache *s, st=
ruct slab *slab, u8 *p)
>                 off +=3D 2 * sizeof(struct track);
>
>                 if (s->flags & SLAB_KMALLOC)
> -                       off +=3D sizeof(unsigned int);
> +                       off +=3D ALIGN(sizeof(unsigned int),
> +                                    sizeof(unsigned long));
>         }
>
>         off +=3D kasan_metadata_size(s, false);
> @@ -7820,9 +7821,14 @@ static int calculate_sizes(struct kmem_cache_args =
*args, struct kmem_cache *s)
>                  */
>                 size +=3D 2 * sizeof(struct track);
>
> -               /* Save the original kmalloc request size */
> +               /*
> +                * Save the original kmalloc request size.
> +                * Although the request size is an unsigned int,
> +                * make sure that is aligned to word boundary.
> +                */
>                 if (flags & SLAB_KMALLOC)
> -                       size +=3D sizeof(unsigned int);
> +                       size +=3D ALIGN(sizeof(unsigned int),
> +                                     sizeof(unsigned long));
>         }
>  #endif
>
> --
> 2.43.0
>

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

