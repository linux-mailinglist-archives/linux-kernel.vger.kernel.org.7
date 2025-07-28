Return-Path: <linux-kernel+bounces-748237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00B2B13E49
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9564C7A7DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46831274B2A;
	Mon, 28 Jul 2025 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzHmTHko"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B280472621
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753716375; cv=none; b=e2vvK3ZVe2SmTCbc2GqXQ9A1G65WnmPvacejddVZHRIcc1yLWzLbb2CWJRbSngK8PQs1amQX5T+0sNEIEzT+tHB/duTInAJ5VY9z5h5UcGGc1FPQzmS4/k8DdFxno097KjLdhkebIFr8wvEOV92k6eQib8xzb06kb64Vv8yVzKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753716375; c=relaxed/simple;
	bh=RIVvnCA7JwviMfzVoJi9Vg5bbn0mEBMxjpMcNTaqKI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poBrxx1QSCJ5Sr9SNLSGA/jeNIjB4+lzj+7nAqRO/NdFkfEell4KrjrZGgifUl9enDf2HrR+QOmYdVign4Bi76SWFdfu2uFMQof3bR7DdTnPpovMfeJ1loeaoMOpsKTv8BD46UTaNpg/8bEw43hOD4k4XxnLnNazAEnMLuT4zhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzHmTHko; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6154c7b3ee7so9684a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753716372; x=1754321172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqOC4wRRGhe0Mg49hUc2tJcMbQEAuNNfAJDotAhUq+A=;
        b=fzHmTHkoc09zj83d3apFo15V6iFrYyOnB5bMPY58sqjSpTJaVnLfDjKwTYZ9LxOngf
         MowfdVTjK1bpSir8X2tdwfY1jFeeb/lWj3+qsZc1/4zUEhZ7VJ2nJtW9PvPgfr4vNQB2
         ATJq3ZEhtnR+pj9dhDFOxQNAkFutqZytQl5rkXCchEPOFuD43s0mJmBF+/TvJqKbOiMl
         sIlzSlEt1adlwRHzv0MLjrUBfjRRskLkoHsQbSszJZLolGMCpDf823nHet/Ugl17r6IT
         dTtbHS+6K9/kMK3lOM/xQgno10Y8JeuiQ22r3Fb05G8g0cAW7ERwzlIYgKg1OtwbYgrk
         FpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753716372; x=1754321172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqOC4wRRGhe0Mg49hUc2tJcMbQEAuNNfAJDotAhUq+A=;
        b=rZvdWePSF5ififIwOlG1vW/voG2uXn23AFSldd1jJo5rK9BV/E1kZ1AlY07UeJoCc6
         nArBGwMxP/SQ3dWqir2EQW4cCTZJ2P6p0CNZCVTtP+k7tzfpjGrogmDeThvazBPiQ/fb
         fWFRH75OEEKvLnRQJSASCtVzXda5Ik3omMoxavORPgkhGVgCwpgKQoQqe2HwgZAgBmYW
         eZisosGCYhs+2WKNDyqwMVGktANP84pyAKGTZez5dm//nh3ccYZeQkXcEa+Qgds445RA
         lm0T4thOvGroinMfTbdicjCzR5HI670J+cWaukxr727IE22SkHl/fARZtkUP1+NIliM5
         HteQ==
X-Forwarded-Encrypted: i=1; AJvYcCULRjd2hJHuUW5lOUWwz59NAT9ukPxXT3oM/dE2Su/g7Ud34zV8YK0l2OeqXjLYMn8LJ+oiVmzRj1Rj1h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YySjTxTthQQa5cnGkvubJLXvS7JfLjWCFaRGBRHRnqapl0z0l6P
	Qx3LgV8/etqjkdsAgYS+dIKapxNOxswiQkihuR96BQS6kJu15cxb6aGgGgnFKNAsTbHLkDAnAbE
	UC6WNSLmSrvRVyYflVihUu/e+VtMpnolGkA9T5EKl
X-Gm-Gg: ASbGnctvME3ptB8gYW1G8DHdW9+YJrGtzKKtmZWVi0cqM5kscjr5K6gDcyXvj1/2wH/
	DWImBwEytiux07xvoTqHgQGAuX5V1JUHdzVv1evo7lQiYrvAGxHf2nkY6yGZBOFsfOi1eCv4Kaw
	85w2BUMWClmMJuG/8V1BI3/ysS0h/yBbnETzki1eLb4QoQOs3h6T7Hj7mhM/qwxWby4PcHMxYFs
	bdxpARzGRnsZd9brYdvXr9DLP/mTbYIA1Jw2c+3uyEA
X-Google-Smtp-Source: AGHT+IFCoTgiMkG4zyb1dN1lLjGmK+W5Z95dZzG2OqP6BB8BASV/3pO2SP7BdCCxF+tbZ9PLcM55cUpWngS2TlYW05k=
X-Received: by 2002:a05:6402:1a39:b0:615:2899:a4e5 with SMTP id
 4fb4d7f45d1cf-6152899a78emr101033a12.5.1753716371615; Mon, 28 Jul 2025
 08:26:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-kasan-tsbrcu-noquarantine-v1-1-846c8645976c@google.com> <CA+fCnZcyh52CqY+XDMMjc6f5KQoaji=7KiFM-6+2NidjfyNVGQ@mail.gmail.com>
In-Reply-To: <CA+fCnZcyh52CqY+XDMMjc6f5KQoaji=7KiFM-6+2NidjfyNVGQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 28 Jul 2025 17:25:35 +0200
X-Gm-Features: Ac12FXzgMg6AU9sijci9qK5lKdc5wEfC84NjWQbqd2yCO609j_hdZiglhUudTRA
Message-ID: <CAG48ez3Z+7pBPTShMrxZObkShCR9rE0euE76i9ciQNKy5bhyPw@mail.gmail.com>
Subject: Re: [PATCH] kasan: skip quarantine if object is still accessible
 under RCU
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 12:06=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail=
.com> wrote:
> On Wed, Jul 23, 2025 at 4:59=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > Currently, enabling KASAN masks bugs where a lockless lookup path gets =
a
> > pointer to a SLAB_TYPESAFE_BY_RCU object that might concurrently be
> > recycled and is insufficiently careful about handling recycled objects:
> > KASAN puts freed objects in SLAB_TYPESAFE_BY_RCU slabs onto its quarant=
ine
> > queues, even when it can't actually detect UAF in these objects, and th=
e
> > quarantine prevents fast recycling.
> >
> > When I introduced CONFIG_SLUB_RCU_DEBUG, my intention was that enabling
> > CONFIG_SLUB_RCU_DEBUG should cause KASAN to mark such objects as freed
> > after an RCU grace period and put them on the quarantine, while disabli=
ng
> > CONFIG_SLUB_RCU_DEBUG should allow such objects to be reused immediatel=
y;
> > but that hasn't actually been working.
> >
> > I discovered such a UAF bug involving SLAB_TYPESAFE_BY_RCU yesterday; I
> > could only trigger this bug in a KASAN build by disabling
> > CONFIG_SLUB_RCU_DEBUG and applying this patch.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  mm/kasan/common.c | 25 ++++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index ed4873e18c75..9142964ab9c9 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -230,16 +230,12 @@ static bool check_slab_allocation(struct kmem_cac=
he *cache, void *object,
> >  }
> >
> >  static inline void poison_slab_object(struct kmem_cache *cache, void *=
object,
> > -                                     bool init, bool still_accessible)
> > +                                     bool init)
> >  {
> >         void *tagged_object =3D object;
> >
> >         object =3D kasan_reset_tag(object);
> >
> > -       /* RCU slabs could be legally used after free within the RCU pe=
riod. */
> > -       if (unlikely(still_accessible))
> > -               return;
> > -
> >         kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE=
_SIZE),
> >                         KASAN_SLAB_FREE, init);
> >
> > @@ -261,7 +257,22 @@ bool __kasan_slab_free(struct kmem_cache *cache, v=
oid *object, bool init,
> >         if (!kasan_arch_is_ready() || is_kfence_address(object))
> >                 return false;
> >
> > -       poison_slab_object(cache, object, init, still_accessible);
> > +       /*
> > +        * If this point is reached with an object that must still be
> > +        * accessible under RCU, we can't poison it; in that case, also=
 skip the
> > +        * quarantine. This should mostly only happen when CONFIG_SLUB_=
RCU_DEBUG
> > +        * has been disabled manually.
> > +        *
> > +        * Putting the object on the quarantine wouldn't help catch UAF=
s (since
> > +        * we can't poison it here), and it would mask bugs caused by
> > +        * SLAB_TYPESAFE_BY_RCU users not being careful enough about ob=
ject
> > +        * reuse; so overall, putting the object into the quarantine he=
re would
> > +        * be counterproductive.
> > +        */
> > +       if (still_accessible)
> > +               return false;
> > +
> > +       poison_slab_object(cache, object, init);
> >
> >         /*
> >          * If the object is put into quarantine, do not let slab put th=
e object
> > @@ -519,7 +530,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsig=
ned long ip)
> >         if (check_slab_allocation(slab->slab_cache, ptr, ip))
> >                 return false;
> >
> > -       poison_slab_object(slab->slab_cache, ptr, false, false);
> > +       poison_slab_object(slab->slab_cache, ptr, false);
> >         return true;
> >  }
> >
> >
> > ---
> > base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
> > change-id: 20250723-kasan-tsbrcu-noquarantine-e207bb990e24
> >
> > --
> > Jann Horn <jannh@google.com>
> >
>
> Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!

> Would it be hard to add KUnit test to check that KASAN detects such issue=
s?

Sent a separate patch with a kunit test.

