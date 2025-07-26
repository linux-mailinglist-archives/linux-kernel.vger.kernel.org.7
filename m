Return-Path: <linux-kernel+bounces-746908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28FFB12CEA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 00:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692833B6A42
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 22:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0B521CA1D;
	Sat, 26 Jul 2025 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSbxEEub"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0B1F5842
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753567570; cv=none; b=iVWA+dB+ncStnmyFn5OGGeRDzn+YcURDqQ08IZmaLZ+i1HqyrEngpJCCNOqc0s2QydDHddNYrfRISJxITEV1ZL3Q/3Ybs2HtummUhL1e5xEiBOnnxDVLaAm6REG9BGgKWevWCV9ywgo31b8p4omW+rfcGpoVJxY+FL8XIJLi4fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753567570; c=relaxed/simple;
	bh=lhBQO60o4eptKPcot95hqn9CTdfkw915cdb1gLMemzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=do7Ds35JOp+yzVGekPtZjz9r54zOEWN2Je1kkjAZ5ZwPAUIwJhfSRHbTTdx1Ck431VMuDeL5steD6Gi2QGDIag3w8sDwn6RDLs2kh+tepCB2dV6380L7Zv62tw1WluXFsbBQNUuRlseMB+2c7HuLjlpMtr+g+vwK1nn/qR5X4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSbxEEub; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b773767fddso1561872f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 15:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753567567; x=1754172367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ0HbWh5wMU4zq+nDQgi0w5mYaeF8gFdCN3zESWgjG0=;
        b=BSbxEEubAb+IPawAryshkPzgrdhrN1Zw+FycJZxf8zNBEJAkFtD+WP90GZnO5TpZdg
         6UAUpIHSRVPP5bGtJL8iZGSD/Y6gZeL1T6YT9Lg0FrjXfIUyJ7XgQxKxQhYfzBa9asaj
         wWNIj1bnDzSV+FY609C3JJ31rNqM+e7dLihjZA5jrV7JxrFAOnnpUyVhskJ8OMy96qN3
         dwkF13O3eMT751oePa/1GxPehAmPG7NjH4Snbd6DnLDDwoAZB5P5QJIhj7RLz7+youZk
         9S3LkYT9iWyP73whWl76T9KYfKCubPGOidIgSbZANqopKCyeX3//NzraBBv591J7pY+X
         KCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753567567; x=1754172367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJ0HbWh5wMU4zq+nDQgi0w5mYaeF8gFdCN3zESWgjG0=;
        b=leuHSUJw2rnCKpsufb63Xy+6r7TkFK7Gsd7TBvmBDyk9F/kLHl61q4+s7AkTevi2Rj
         fkwaaO0af9ROwqRTN7ItJn4N5qjlmVtmPswn3fgRla2BKZTrAq51bKyOm3h/k37NOw57
         7SGFlNALflM1IM58AjUWI2wAGS6G/OJNMoon6Ma14GwUXVgCfdEb4oEsdVtmIUzpXrY4
         WDVmSvTnHY92/0EW+zpVFF7awSOnv0Or4C9vxMkx3TpqQUFpF/adlc4XkPcdK0hCkolh
         ehE1K1sZoi0xJcJ2QJBQfru3BMuJwohkGsF36EMBGMf7EgpmUa7th16OBsTIBXY7dR72
         za8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWTl3RbxGHnyxJ/DWMZZvMxgKczwDB4q+VVpcyBz7LLau23JdbswsNqTHxDddrih4QYTFpoDxc0ySv8Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF/iuuhtrTC+rKQSnkA3DbX89qWlChhQMl4hRqo1b560+g098L
	Ij13TnyyvtPvh/40JbxrzvPEyu6y0XKUBUsbsSAuBouoUelNqFcf7grMAikZJs7DOqZXNrq4Zpz
	wV0skjdQqcDhDklAyqjY+wOFCpSbm/sI=
X-Gm-Gg: ASbGncs80HnUcWBjCokD5j2kFD977fotJ8cTVxfn5lA4/sv5s77A/SIR2EPxJnC0WCE
	wqB00MmpqAMUwJTqw7gR5rP8PRV3lnuDPo7OxGEhobU93hEo91A0A3KPCS8J/cPGZHeBb3apwrX
	uR60Q8PFaCKHk28glJ5BsyUEUnb3WgtBde1fI70/2QdEeXyvaZORwdxDSctDwS/FD30MqN9vUek
	REkOC1n
X-Google-Smtp-Source: AGHT+IERMWRconwwlICLYKuwfsAec6Ra2IUKJw6WcwmH1A2Pr9eQONsCFb0r5f8/2r7DCKhOVYQUXrXNn0q12SWzoEs=
X-Received: by 2002:a5d:5886:0:b0:3b6:18be:3fbc with SMTP id
 ffacd0b85a97d-3b77671d232mr4837781f8f.2.1753567566495; Sat, 26 Jul 2025
 15:06:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-kasan-tsbrcu-noquarantine-v1-1-846c8645976c@google.com>
In-Reply-To: <20250723-kasan-tsbrcu-noquarantine-v1-1-846c8645976c@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sun, 27 Jul 2025 00:05:55 +0200
X-Gm-Features: Ac12FXxVMLsmLFrJvmkI7l9TDJQ09BGxwghdFh3bJQfvTulVExlWwMj6B4rNIpk
Message-ID: <CA+fCnZcyh52CqY+XDMMjc6f5KQoaji=7KiFM-6+2NidjfyNVGQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: skip quarantine if object is still accessible
 under RCU
To: Jann Horn <jannh@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 4:59=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> Currently, enabling KASAN masks bugs where a lockless lookup path gets a
> pointer to a SLAB_TYPESAFE_BY_RCU object that might concurrently be
> recycled and is insufficiently careful about handling recycled objects:
> KASAN puts freed objects in SLAB_TYPESAFE_BY_RCU slabs onto its quarantin=
e
> queues, even when it can't actually detect UAF in these objects, and the
> quarantine prevents fast recycling.
>
> When I introduced CONFIG_SLUB_RCU_DEBUG, my intention was that enabling
> CONFIG_SLUB_RCU_DEBUG should cause KASAN to mark such objects as freed
> after an RCU grace period and put them on the quarantine, while disabling
> CONFIG_SLUB_RCU_DEBUG should allow such objects to be reused immediately;
> but that hasn't actually been working.
>
> I discovered such a UAF bug involving SLAB_TYPESAFE_BY_RCU yesterday; I
> could only trigger this bug in a KASAN build by disabling
> CONFIG_SLUB_RCU_DEBUG and applying this patch.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  mm/kasan/common.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index ed4873e18c75..9142964ab9c9 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -230,16 +230,12 @@ static bool check_slab_allocation(struct kmem_cache=
 *cache, void *object,
>  }
>
>  static inline void poison_slab_object(struct kmem_cache *cache, void *ob=
ject,
> -                                     bool init, bool still_accessible)
> +                                     bool init)
>  {
>         void *tagged_object =3D object;
>
>         object =3D kasan_reset_tag(object);
>
> -       /* RCU slabs could be legally used after free within the RCU peri=
od. */
> -       if (unlikely(still_accessible))
> -               return;
> -
>         kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_S=
IZE),
>                         KASAN_SLAB_FREE, init);
>
> @@ -261,7 +257,22 @@ bool __kasan_slab_free(struct kmem_cache *cache, voi=
d *object, bool init,
>         if (!kasan_arch_is_ready() || is_kfence_address(object))
>                 return false;
>
> -       poison_slab_object(cache, object, init, still_accessible);
> +       /*
> +        * If this point is reached with an object that must still be
> +        * accessible under RCU, we can't poison it; in that case, also s=
kip the
> +        * quarantine. This should mostly only happen when CONFIG_SLUB_RC=
U_DEBUG
> +        * has been disabled manually.
> +        *
> +        * Putting the object on the quarantine wouldn't help catch UAFs =
(since
> +        * we can't poison it here), and it would mask bugs caused by
> +        * SLAB_TYPESAFE_BY_RCU users not being careful enough about obje=
ct
> +        * reuse; so overall, putting the object into the quarantine here=
 would
> +        * be counterproductive.
> +        */
> +       if (still_accessible)
> +               return false;
> +
> +       poison_slab_object(cache, object, init);
>
>         /*
>          * If the object is put into quarantine, do not let slab put the =
object
> @@ -519,7 +530,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigne=
d long ip)
>         if (check_slab_allocation(slab->slab_cache, ptr, ip))
>                 return false;
>
> -       poison_slab_object(slab->slab_cache, ptr, false, false);
> +       poison_slab_object(slab->slab_cache, ptr, false);
>         return true;
>  }
>
>
> ---
> base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
> change-id: 20250723-kasan-tsbrcu-noquarantine-e207bb990e24
>
> --
> Jann Horn <jannh@google.com>
>

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

Would it be hard to add KUnit test to check that KASAN detects such issues?

