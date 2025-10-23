Return-Path: <linux-kernel+bounces-867889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DC5C03CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B1B3B668F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56A9284B2E;
	Thu, 23 Oct 2025 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdPeohTc"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE214386D
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761261232; cv=none; b=jai6RDXhuSWAYHr8zMx7KZr2lX1MCd4eKJurtH0IK76LJfSYZKfGWMDzzHjivUVHSAlmDFGrI4wrT3uvYXMHvmwiSkLhG5dtCQGnCab7zJRcfxCOgINjr2E3ICvsV8KzUeWFQYYJJLmOs/sM7H4G0rsE9iBLqrjIvpoS5kikwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761261232; c=relaxed/simple;
	bh=XFM9o0JIQI5aAuCfj9/wovNdyn3SRytIctY81JTpM/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8ta8en3ftPChrxKRvS/G1PFU1lM7EjJyL7BzMgZw120411skYe0Gfh8Lveg0Qo425qvfCmNvsv7oTPpomcMEJ7XxaJJXJOFCNM9+OXTq++jUYgEbhtO1CFvE0qVC4kkQwtVjZtl73HY4UPoc4dCesOU1t813W5mHHAxri65//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdPeohTc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so1331452f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761261229; x=1761866029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y/mL/4eaultc1EWojfIyo8PsJnaNID3tRHJJgL28LY=;
        b=OdPeohTcQYFfZYNfRlIuQlXt7FmMJD+nCCcM+y7XJ+8mx2lzMxabWDVxyYmg59Yp4C
         sJWMYngambGTDhELyL19sJR27h2YWl9ahfuSnm1DmNNmTiO7ueUF5rjOD1b3a9ylnpQI
         6clpjAdDYlwtlda92Zx8NYdmkbY3Kg5oqrRbXjf+txahfPUmrC+vC3Mi2+bIK8Cd5clb
         HbDqoMselrWTSGtc7lD1aTljIG5HxzTagP9fwuRqzrkgUQ9QT8yiyvS/613nYKCu1jSM
         4SqfZtejdC730TWchmalEPkb5LnbGfvERPPvIqkIP6uy/p2HERb/xJi1HfWUYPVUsVop
         RKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761261229; x=1761866029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y/mL/4eaultc1EWojfIyo8PsJnaNID3tRHJJgL28LY=;
        b=BzXahF6olYA9NGfCessvY4bmMef6jaoSLPr+KZOO2kjH6BaoD9B8A1GPmUmmwfS+8w
         +vkd+H8GZFFeEu7ZBe3luSU1LQZl77XqP763eafzXy91kfRF6IoTCA/hSi1MM6bKagDJ
         1PjC6LkCyQ6P+SNRm0FoHmJFaG9JkkiB9LVmfAe4aLpyEEDJlFdD0e3uQBEm5wJdBauk
         CMUQ5mWUWX7CeBitmcqMAnXF0ZFiOfZ45poCagBVOo+SHxxIlX/JvbTglAVRVoIkfoB2
         ++WWxvv5cGGirsb26jh8/nldhU4CFZWqVGacWsTdKeobwoQp8T9E86Q8sFWZG/CBOVll
         RlMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGh66d05TG14bVijsb0XdOqq9I3m3AGhXZSPIvOzq4g95mut3E0Xve1yVFXa1nLAG19IhgHkSGqrpN7UY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmydDIZ83AeZ+9C6itRL0j0elbvfrK82DKPxm4SswXDLzIK5Zm
	XaaaWAJuvMa+ZD53o27j2D/lX776i0X2ZJZEadSTbwBUBThkCUv/j8SCkftnD6Z0a1U89RgNLIZ
	5YUsr48OZS1reEeRvk5HqZXryjCfHDOs=
X-Gm-Gg: ASbGncu3+Jkd5tfktL8vOqmaPg4lieFMdkBv3jki415T/M+lHBKUkh01Pp/Cun8ncgM
	SOqldrbJUS8bgMtdGBzowvgKzI9ToHtZN3HKAnOTy36cAebOttOVpN3np1wa4xc48TkR0Dr6WNz
	uCO+//0voWIhG38OaRkphuGDrJgg+QMpso08JrF27lX0Q0OxztdYughdmS8p5gaqGeJVOZel4OF
	Apf0pYLwWjY/ZZjh46vXytbV8SKaM0hJ9e+WbVd/hkepoeOOY0lTB02Hxd1HXP49bic0f/4W4dK
	pxZlx5tXmMQ04Zp5Uzaad0s1ViBySFkO/1PPI6E=
X-Google-Smtp-Source: AGHT+IHcYKGRd4bWLykcRsWt3JGipu6QnZXYSUEvMKhBqZJGUVrkpfb+xY9h71be1NTcAIdFAFFeu9yDKWG6eVaN6Yo=
X-Received: by 2002:a5d:5d05:0:b0:428:3ea7:4473 with SMTP id
 ffacd0b85a97d-4283eb68979mr14692632f8f.39.1761261228527; Thu, 23 Oct 2025
 16:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-fix-slab-accounting-v2-1-0e62d50986ea@suse.cz>
In-Reply-To: <20251023-fix-slab-accounting-v2-1-0e62d50986ea@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 23 Oct 2025 16:13:37 -0700
X-Gm-Features: AWmQ_bmwCHOVy3eNr0hpo0ixT1MxbquvOBvpoyqeHClPdJfhgqBzqfF_YadwU_o
Message-ID: <CAADnVQJS_RUTnpCX5etS_qGD=jgHjtY_Mtc5GQqPwvyyTfghdg@mail.gmail.com>
Subject: Re: [PATCH v2] slab: fix slab accounting imbalance due to defer_deactivate_slab()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 5:01=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Since commit af92793e52c3 ("slab: Introduce kmalloc_nolock() and
> kfree_nolock().") there's a possibility in alloc_single_from_new_slab()
> that we discard the newly allocated slab if we can't spin and we fail to
> trylock. As a result we don't perform inc_slabs_node() later in the
> function. Instead we perform a deferred deactivate_slab() which can
> either put the unacounted slab on partial list, or discard it
> immediately while performing dec_slabs_node(). Either way will cause an
> accounting imbalance.
>
> Fix this by not marking the slab as frozen, and using free_slab()
> instead of deactivate_slab() for non-frozen slabs in
> free_deferred_objects(). For CONFIG_SLUB_TINY, that's the only possible
> case. By not using discard_slab() we avoid dec_slabs_node().
>
> Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock()=
.")
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Changes in v2:
> - Fix the problem differently. Harry pointed out that we can't move
>   inc_slabs_node() outside of list_lock protected regions as that would
>   reintroduce issues fixed by commit c7323a5ad078
> - Link to v1: https://patch.msgid.link/20251022-fix-slab-accounting-v1-1-=
27870ec363ce@suse.cz
> ---
>  mm/slub.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 23d8f54e9486..87a1d2f9de0d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3422,7 +3422,6 @@ static void *alloc_single_from_new_slab(struct kmem=
_cache *s, struct slab *slab,
>
>         if (!allow_spin && !spin_trylock_irqsave(&n->list_lock, flags)) {
>                 /* Unlucky, discard newly allocated slab */
> -               slab->frozen =3D 1;
>                 defer_deactivate_slab(slab, NULL);
>                 return NULL;
>         }
> @@ -6471,9 +6470,12 @@ static void free_deferred_objects(struct irq_work =
*work)
>                 struct slab *slab =3D container_of(pos, struct slab, llno=
de);
>
>  #ifdef CONFIG_SLUB_TINY
> -               discard_slab(slab->slab_cache, slab);
> +               free_slab(slab->slab_cache, slab);
>  #else
> -               deactivate_slab(slab->slab_cache, slab, slab->flush_freel=
ist);
> +               if (slab->frozen)
> +                       deactivate_slab(slab->slab_cache, slab, slab->flu=
sh_freelist);
> +               else
> +                       free_slab(slab->slab_cache, slab);

A bit odd to use 'frozen' flag as such a signal.
I guess I'm worried that truly !frozen slab can come here
via ___slab_alloc() -> retry_load_slab: -> defer_deactivate_slab().
And things will be much worse than just accounting.

Maybe add
  inc_slabs_node(s, nid, slab->objects);
right before
  defer_deactivate_slab(slab, NULL);
  return NULL;

I don't quite get why c7323a5ad078 is doing everything under n->list_lock.
It's been 3 years since.
We have an empty slab here that is going to be freed soon.
It's effectively frozen, so inc_slabs_node() on it seems like a safe fix.

