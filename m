Return-Path: <linux-kernel+bounces-861547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1CFBF308A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C414227BB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376F23A9AC;
	Mon, 20 Oct 2025 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QVzfROH"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211EF2C327D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760986351; cv=none; b=VWy8+IqDKomPN3AtSZlxtdpHyhX2Ivc/Dtd2gZ8iLpmS/kPm9uhDKFaGbsRCnMznBZ3DZ/lXXnE1kQtz6ogkoRZOJIjCsIDql+bzm67viwwjQVxpasrt1Q7KBJnosR78SlAiVwr+oAEU/UWnM9KLiZT4fBjrvRgKvpddfD0I07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760986351; c=relaxed/simple;
	bh=mfB8IYTbmlUhgeYg7FQCxn1LQh8GP71nF3j8tHVh+/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pECRlVHnA9fqzOUJyBKYGZwapnNoVqkfEWrUOxjWm/huKJLhnq2nuDuzdK4pIt5YCc2oJJruogyVLN3CotQ0aI8rvGVlocxRD2bg3nZshqhPfu83dZqntJxDoq5PWUKn9kpiTTJZr2cL0lsWeoVnvsayvOkxlugaG6wZlNnt9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QVzfROH; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430caa71278so89595ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760986348; x=1761591148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UH3L+M6Do8/IZzZOeL5IDLK/GCmbK/v9qK/+5ymQcBc=;
        b=2QVzfROHc7hZ7wjtOjxhi/HSCrKdIc9fpkxPBAMn+8rKgd0dO9uiUH1So997hXZxiq
         1nuYtKMENYQIZzlbObXiPWU4TV5kr/D8bchOEyVeYrEPLqdgHTu8GPD7nim5xMeEY3Lx
         DUbGL23PbHSsYC6rsqpkIS0smHIJ+4U0njQJYzxOzaa39sGphq04Q3I8n+FomQY9v0oe
         ZXw90GyRdkly63wCUnTCk2O6C8HdKvcX4ix+ody7gFd8N1Q6U/2GRsTOtRpz5nkgRHIT
         8dHeRqIjCC2UfenHMKHU0odJHn8stEjfTEwE/3c3949n0bR8L5kTQQMfy0lqGqxGDm57
         ImNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760986348; x=1761591148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UH3L+M6Do8/IZzZOeL5IDLK/GCmbK/v9qK/+5ymQcBc=;
        b=mjpnmROoaRmPEwKb6uc4sBMhNRGYCiqYdioluxQbLRU6MR+BJQ0+9VjqRanWEKnFe5
         obQ4VoJWQ+ybTmi0MZgQ+WnYB3LF/ooHDNMqWTH5+asZ2pgYAu2XnTuCZjF8Ymu8t/IF
         w/BkVq5Q5MhngPNtfOXwNWVZC6tMChNq2PLPPe6Zqq7VfIiSYgyN9waQmsjs+tfqEM3d
         ErreSNmD2H30zUywqPS/jTgyrAW0TMDj70M/5ZO9dn6PCXXCRSe54EZnIGuHB8HG8JRj
         Lxb/edkhikesfcVtbNjv3KghyHLQDJcBPtbUmgk4OgdhmnRAHr/rVuNsESd6iL/39592
         ryNw==
X-Forwarded-Encrypted: i=1; AJvYcCVz5Z7ArfeS2kYnAtfrGOPlx4LcbLhEic9ZTHd47jT9eCCy7R7jp4SdHkLnrAj3q9JhLoX6oZgQzwgfNbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJXH8IuS9Z/OYPxH2K3o8RCQvL28LbFyqCJfiR4mmK/Hm6ry1n
	56EPi4pRmDK+nGSc0SPF1QoQHYes2kkRnwcCMNIZ3ZPbqiCVnsK8+n+xKPzTRar+lgH2dRE0mkd
	9u54VH8FkOdKRZuyh/NSCpkWQtTKs5oFzSl60dGgh
X-Gm-Gg: ASbGncsC74Tojeu04BHynMODM0QBEVKtVbE1q0e6mjIUI4/lXtQ46/Z72ykU93XfWB7
	Grm3s+AOvoZjNb5qcVVG7oxjbGDflsY8Rl9QAX2GmtF2lLjAqJq5Dgteu2eAMJhZ+sE0qfJiIsQ
	VzJAxJXUwH50Dl0naJCvI0iyPGeFyBh5BFSsaDhUOs5gmRxRtqM07KorlxCqfEVay+iGAzh19cN
	M5D7o+8iLrWI2zIZW1gv76K40WpROTdsPN0+9AGWiWvqzN+bD0XLm96ffg=
X-Google-Smtp-Source: AGHT+IECMTuCbPUO2ugkDIL5dMsu9QmLMhJNLgKv48taGSx+9VT52z7nwDMkZPiViU21/WAOQTSQMPLooT+yBZUkja0=
X-Received: by 2002:a05:622a:1b06:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4ea12038bbfmr495711cf.5.1760986347737; Mon, 20 Oct 2025
 11:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020143011.377004-1-hao.ge@linux.dev>
In-Reply-To: <20251020143011.377004-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 20 Oct 2025 11:52:16 -0700
X-Gm-Features: AS18NWDJReJvkcvY9a-Vg5Sxok_V9AisWyediqO9Nhy9j9lFCVqZjHumsBMEEYg
Message-ID: <CAJuCfpGhzzQwS8q0t3RWygT924uSFRJUxmb5pSMnLrjrRnPuSg@mail.gmail.com>
Subject: Re: [PATCH v2] slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts
To: Hao Ge <hao.ge@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 7:31=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> From: Hao Ge <gehao@kylinos.cn>
>
> In the alloc_slab_obj_exts function, there is a race condition
> between the successful allocation of slab->obj_exts and its
> setting to OBJEXTS_ALLOC_FAIL due to allocation failure.
>
> When two threads are both allocating objects from the same slab,
> they both end up entering the alloc_slab_obj_exts function because
> the slab has no obj_exts (allocated yet).
>
> And One call succeeds in allocation, but the racing one overwrites
> our obj_ext with OBJEXTS_ALLOC_FAIL. The threads that successfully
> allocated will have prepare_slab_obj_exts_hook() return
> slab_obj_exts(slab) + obj_to_index(s, slab, p), where slab_obj_exts(slab)
> already sees OBJEXTS_ALLOC_FAIL and thus it returns an offset based
> on the zero address.
>
> And then it will call alloc_tag_add, where the member codetag_ref *ref
> of obj_exts will be referenced.Thus, a NULL pointer dereference occurs,
> leading to a panic.
>
> In order to avoid that, for the case of allocation failure where
> OBJEXTS_ALLOC_FAIL is assigned, we use cmpxchg to handle this assignment.
>
> Conversely, in a race condition, if mark_failed_objexts_alloc wins the
> race, the other process (that previously succeeded in allocation) will
> lose the race. A null pointer dereference may occur in the following
> scenario:
>
> Thread1                                                 Thead2
>
> alloc_slab_obj_exts                               alloc_slab_obj_exts
>
> old_exts =3D READ_ONCE(slab->obj_exts) =3D 0
>
>                                                   mark_failed_objexts_all=
oc(slab);
>
> cmpxchg(&slab->obj_exts, old_exts, new_exts) !=3D old_exts
>
> kfree and return 0;
>
> alloc_tag_add -> a panic occurs.

I appreciate the time and effort you put in this description but it
sounds overly-complicated IMHO. IIUC in both cases the issue happens
when a valid slab->obj_exts pointer is overwritten by
OBJEXTS_ALLOC_FAIL. I would simply say:

If two competing threads enter alloc_slab_obj_exts() and one of them
fails to allocate the object extension vector, it might override the
valid slab->obj_exts allocated by the other thread with
OBJEXTS_ALLOC_FAIL. This will cause the thread that lost this race and
expects a valid pointer to dereference a NULL pointer later on.

>
> To fix this, introduce a retry mechanism for the cmpxchg() operation:
> 1. Add a 'retry' label at the point where READ_ONCE(slab->obj_exts) is
>    invoked, ensuring the latest value is fetched during subsequent retrie=
s.
> 2. if cmpxchg() fails (indicating a concurrent update), jump back to
>    "retry" to re-read old_exts and recheck the validity of the obj_exts
>    allocated in this operation.

The paragraph above explains "what" you do but we can use the code to
understand that. Changelog should describe "why" not "what" you do. I
would just say:

Update slab->obj_exts atomically using cmpxchg() to avoid
slab->obj_exts overrides by racing threads.

>
> Thanks for Vlastimil and Suren's help with debugging.
>
> Fixes: f7381b911640 ("slab: mark slab->obj_exts allocation failures uncon=
ditionally")
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
> v2: Incorporate handling for the scenario where, if mark_failed_objexts_a=
lloc wins the race,
>     the other process (that previously succeeded in allocation) will lose=
 the race, based on Suren's suggestion.
>     Add Suggested-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/slub.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 2e4340c75be2..fd1b5dda3863 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2054,7 +2054,7 @@ static inline void mark_objexts_empty(struct slabob=
j_ext *obj_exts)
>
>  static inline void mark_failed_objexts_alloc(struct slab *slab)
>  {
> -       slab->obj_exts =3D OBJEXTS_ALLOC_FAIL;
> +       cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
>  }
>
>  static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
> @@ -2136,6 +2136,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct k=
mem_cache *s,
>  #ifdef CONFIG_MEMCG
>         new_exts |=3D MEMCG_DATA_OBJEXTS;
>  #endif
> +retry:
>         old_exts =3D READ_ONCE(slab->obj_exts);
>         handle_failed_objexts_alloc(old_exts, vec, objects);
>         if (new_slab) {
> @@ -2145,8 +2146,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct k=
mem_cache *s,
>                  * be simply assigned.
>                  */
>                 slab->obj_exts =3D new_exts;
> -       } else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
> -                  cmpxchg(&slab->obj_exts, old_exts, new_exts) !=3D old_=
exts) {
> +       } else if (old_exts & ~OBJEXTS_FLAGS_MASK) {
>                 /*
>                  * If the slab is already in use, somebody can allocate a=
nd
>                  * assign slabobj_exts in parallel. In this case the exis=
ting
> @@ -2158,6 +2158,20 @@ int alloc_slab_obj_exts(struct slab *slab, struct =
kmem_cache *s,
>                 else
>                         kfree(vec);
>                 return 0;
> +       } else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) !=3D old_=
exts) {
> +               /*
> +                * There are some abnormal scenarios caused by race condi=
tions:
> +                *
> +                *      Thread1                         Thead2
> +                *   alloc_slab_obj_exts                alloc_slab_obj_ex=
ts
> +                *   old_exts =3D READ_ONCE(slab->obj_exts) =3D 0
> +                *                                      mark_failed_objex=
ts_alloc(slab);
> +                *   cmpxchg(&slab->obj_exts, old_exts, new_exts) !=3D ol=
d_exts
> +                *
> +                * We should retry to ensure the validity of the slab_ext
> +                * allocated in this operation.
> +                */

I don't think we need a diagram here. The race is quite trivial. Maybe
a simple comment like this?

/* Retry if a racing thread changed slab->obj_exts from under us. */

> +               goto retry;
>         }
>
>         if (allow_spin)
> --
> 2.25.1
>

