Return-Path: <linux-kernel+bounces-867385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC7BC02773
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC58818878BD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A2A311589;
	Thu, 23 Oct 2025 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqrL+9TB"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E0D515
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237219; cv=none; b=BIDlRcE0Bf3ce4B6yxgW7Wi3XDb9nKgoafEEHJSP0Y/MLHDJj1m7OAPVG3YBryygvOc19VuhKWlBGP8i2oc05tqVO6xoCaM+F879/RcyVVZlC7WmB/HSQ+TkIZ0sXILXy7srqJB2oePVHGYKRtRFZ1jQYDaBolaHijUcqLWT5Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237219; c=relaxed/simple;
	bh=w0G4caO2uw5by/0CKwM14mp9xe1gF0QuP3ifUKE73oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEgQYH7mLijyGTy+20zWkiFCMfycVY0NHwBp6re7gTJqATM+n2hxIc1OPoRAIC1K69s/rFJTn/KpsMQj4qaD0DnhzYFK3QTFqrTviRWz4fxfoPJA9ZAD1rWETl0sbVWmI04uQOdkrrZjQbxqvEDYl6m7KKOJJGg0PJneiBPejaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqrL+9TB; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4e89ae75aedso575131cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761237217; x=1761842017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34KjFJt3ZhAK/mtlYPQJkhdtTyQjAMQbPYFNiYB/dXs=;
        b=nqrL+9TBD/95cEWUiS4r61C/7MHchujm72JBL+LA3V89spnDGEiUHHqoZ54lEYK+oP
         yMdORcf2y4nHb0IAeFRmU9KfKW17jj5/vl8WlAz4hHNWkCXVL3s6ExkOwYsu6gHSedoP
         zVdUCd3q2F7Uq8JLVcm834UFOZ0VX2UoiGV5ZaxFtbocTOizoVIEk29dR15aGh4IzGbo
         A0cMbfBMjdOYeZ6o4T90DPL6EJyu42ZQvM24DrKc1S6WtOl1+iFv6J3MVYHOWKIXuinJ
         sT++3BgyFZAcoTj0g5dSSWZSIFdlB6j1qZbe97c9jlR246MPSIwYVQa36zVbtAyNbBGd
         0mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761237217; x=1761842017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34KjFJt3ZhAK/mtlYPQJkhdtTyQjAMQbPYFNiYB/dXs=;
        b=uSWRatCUYrecAowkj/TG+2sWxqLINzX+pw2gEgX49U7OMsEcINi6HNdQd1pqIM6bSE
         ZG8M1XBJTTGtuJy7PIv84ArOi8Z9H3Edabt3rN3LDyhCduIDLssHvWn2NKUp17D2YF1B
         ho2nqB0pHiYTLN5qO7DYDFyDp4Xnj9sXPr2EJ05ncxmDFsvNlhh+t/aPvep8d1qSc262
         noUA+sTXz6BUrqry4TGG8m83/HfiO8plygEkiXnF5BptUGYInkPdZznsVmGFnnZHxpcz
         Pqokbo/DXyeOjf1jjPN7cjwhQzv4lGj9G7nDy6QohLiMppxmRc7Gdc0iAnzmBK+yqo+S
         FhFA==
X-Forwarded-Encrypted: i=1; AJvYcCUsIbW5hub2AX3bKF9T47VTwXZzBcvpJfIVcl8u+VMItZk+uvI5hkgdKdKCd1CoI9xmVS52oS79ycciTwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTT6KSxBZeOZAAWbXfFDSsNXCIJAs/B3eoPL/ObhcQP3noRmm
	dO4q86lhePji0NGxhHf2ezwdZZZTI/Oc/FvjB/aln71bFiDnHxKvHBlZa44xrOwrcm+LZot+sxy
	HKaUYsDuiVjHT/GexHSXeD6vNZ0+gX1UvfbXuH4C3
X-Gm-Gg: ASbGncv9fCSmulNJFi814CNqvNE/4K1vC60PVsL5t2RLUbUNdpjjB9z/MboaWAcvX+Z
	vWI7eI2ZvySaRu9zpcptR3pWY9kfkcqkepP1QjlvvGNA75QHrnLGS6n2s17MQeMIuKUsJ7+3hYq
	i6BRrzeF2CsnSnyuTL54em6x389o6X+CVbts+KdCXT2VX2MR5dIt7O/+liyHjZZHx1/WwFNay8d
	nCGBLn8/tPAyzdww0PJwbplar6mz1BiGQ3nP1fwK7XyRFx5fiDUI6F1VK6zvzbLhriWpbA=
X-Google-Smtp-Source: AGHT+IEM7mYZ78NXvK+x1sdv/m7JPuTp88A9Qp7hIVuS/TfDEeIRvkB+2+hEPKZ2FPvCDkqrRThCKLON6lZXa4xdsIc=
X-Received: by 2002:a05:622a:1f09:b0:4b7:8de4:52d6 with SMTP id
 d75a77b69052e-4eb8fbd2457mr1131001cf.2.1761237216338; Thu, 23 Oct 2025
 09:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023143313.1327968-1-hao.ge@linux.dev>
In-Reply-To: <20251023143313.1327968-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 23 Oct 2025 09:33:24 -0700
X-Gm-Features: AWmQ_bnMmmrbByZ0lhRBo_wxG12-GwaP-6BXTz9QtXdx3T-vv3b7D4iy4Y7T80w
Message-ID: <CAJuCfpFBmmP5_44mYkae=XDb41Z_PyjSJk5oh3F8urc=fELkgw@mail.gmail.com>
Subject: Re: [PATCH v2] slab: Fix obj_ext is mistakenly considered NULL due to
 race condition
To: Hao Ge <hao.ge@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:34=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> From: Hao Ge <gehao@kylinos.cn>
>
> If two competing threads enter alloc_slab_obj_exts(), if the process
> that allocates the vector wins cmpxchg(), and the other thread mistakenly
> assume slab->obj_ext is still empty due to its own allocation failure. Th=
is
> will then trigger warnings enforced by CONFIG_MEM_ALLOC_PROFILING_DEBUG
> checks in the subsequent free path.
>
> Therefore, let's add an additional check when the process that allocates
> the vector loses the cmpxchg()
>
> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
> v2: Revise the solution according to Harry's suggestion.
>     Add Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/slub.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index d4403341c9df..d7bfec6c0171 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2052,9 +2052,9 @@ static inline void mark_objexts_empty(struct slabob=
j_ext *obj_exts)
>         }
>  }
>
> -static inline void mark_failed_objexts_alloc(struct slab *slab)
> +static inline bool mark_failed_objexts_alloc(struct slab *slab)
>  {
> -       cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
> +       return cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL) =3D=3D 0;
>  }
>
>  static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
> @@ -2076,7 +2076,7 @@ static inline void handle_failed_objexts_alloc(unsi=
gned long obj_exts,
>  #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
>
>  static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
> -static inline void mark_failed_objexts_alloc(struct slab *slab) {}
> +static inline bool mark_failed_objexts_alloc(struct slab *slab) { return=
 false; }
>  static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
>                         struct slabobj_ext *vec, unsigned int objects) {}
>
> @@ -2124,8 +2124,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct =
kmem_cache *s,
>                                    slab_nid(slab));
>         }
>         if (!vec) {
> -               /* Mark vectors which failed to allocate */
> -               mark_failed_objexts_alloc(slab);
> +               /*
> +                * Try to mark vectors which failed to allocate
> +                * If this operation fails, there may be a racing process
> +                * that has already completed the allocation.
> +                */
> +               if (!mark_failed_objexts_alloc(slab) &&
> +                   slab_obj_exts(slab))
> +                       return 0;
>
>                 return -ENOMEM;
>         }
> --
> 2.25.1
>

