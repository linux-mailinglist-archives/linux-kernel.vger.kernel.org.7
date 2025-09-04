Return-Path: <linux-kernel+bounces-801096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E31B43FCA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B77CA7BD0C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9424306D26;
	Thu,  4 Sep 2025 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miSOLtWN"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC53054CF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997933; cv=none; b=Iag/47zk4V5u/H+bmIIIPM/+jj7dAvNXeOHnkuNdnEOVyFo4r8BZAaKSlsbo4NTZxFT2bG8CIojGc4/A3rxAoHBYiIWrN4WGMIqXtRpmkXKAmq18txf6kcMw7Q1r84/mjtql+e1IqZ7L4dDGdAKLsLJbwnRB557awanWEtE9i9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997933; c=relaxed/simple;
	bh=jjoOxNGipBZMZSrHgnJO7zIqbW8l/mlQVhOAOi/XHNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fz6jrl+jmZF8Yhimaddm6rRzWml6PrXmCRp/9XjzdhQpCr5NLqjPhunpaw03R4XzyWEjGiJhsNpeahkZVLx2hqpoqBCD9ZRuz7hJb87MVv6eGWXoXzukkqSQpY/x81sBC7ofn6F2VRSKxZ9TbPzIbLfcnSGjTnvVHdiVVl9CYOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miSOLtWN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3d1bf79d758so917815f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756997930; x=1757602730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjoOxNGipBZMZSrHgnJO7zIqbW8l/mlQVhOAOi/XHNk=;
        b=miSOLtWN81jrXbAcOe96F97s3Q1R9X3KhdHGeFFJMP5WnsGxcsKJcIKNW5UMci1mEC
         dx+1qkJXFO7t4X5hGI35uuDE8yibqiVzn+W9vY1XVRlNJv3DztiFR5VP1uCtaP7yWfPj
         Iu6wOXhJb3cxXIep75tP1aJ08qHJ0rPPzxb9ry/3WdeX1nhHzRWhnZr02EipRAhtJbgP
         YxNGaGTPKePx2n+zRn6n2Ig9TjpQ3OHvh4r6kZ/Ig1WvWGMgTGYYtk1Dp/0vIy9dlOl0
         frv/+hj3wc3zpVcx5MFeQhJDm7Ye8sNXaLsdTn7ZZSKD+C6C4KLaR2hYBSAFp/4wFJX+
         iz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756997930; x=1757602730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjoOxNGipBZMZSrHgnJO7zIqbW8l/mlQVhOAOi/XHNk=;
        b=Bu65UObbyJHJ38dlQdVt3GBQWrmpdN33050dpbOhEIR9gsGp8QQLOnH+aVznawByt+
         h1o9j3Vth/bpL701EDCUoD3/ywEFQxQRqfF9/CGrrjCqAGTmDbO2YX43MNBbCyxVkkxV
         eo0qRUvvHihnDfJqinrBEgWWq2EslKRkF7rRUUfbsh4tFJeCJFCjLtGm+No8dbxASgBJ
         qZccayvhvGzGnQPyDEKBFw1+kP+mXEce/VGZFu6s/LxrJAatvQJPjqaup1rVjSgbpPxw
         055xtoEbIqvJ3gXALJl+b6RS72NkpCc2basd/D8dSFOrJuGCyoEdMprXM7yacbPRXELI
         7JHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTpbLSrnZ/RS/TJ4ySFhR0rAhjanguiTnjiURrr14vQRg+VwOg8I9DqlW020LB+c3r/ElyQui7hF7+QR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLnZdPtwhvBJCxJA6UZqn/UoOfkw5y3hLphBebI/7k6fqaki1T
	yFimkgEuHbYaixHCrcNBLiIHE95k/Ohu5nZTpbHq34ImQfZ/v8IYcopFzgnhXfktBDiKRmH6VPh
	pnVjYmvmpJiqj/LmUgnJRYiIsrg4q30Y=
X-Gm-Gg: ASbGncsi2UEZgU8/lpW0rMuFd6cojc0JDEyFY8sQt3i3C6tzr0SUZb8VShU8CjpaP5F
	ASn3ogQqQQPRmrCalfb3uWbNkusKKRjtfD1uq8W4vOorB5N0R0Bpxs03GmaZQo87c8teQBRM0ug
	Au6iMybeSqpGy4jrdVUx8qcnokxpEGaEBS7sR0g4Mw5XYaZ00iUPEErsD5fwEm5L1mUnSiUf35C
	yL4CqY=
X-Google-Smtp-Source: AGHT+IEOLYmXnNodyTdeKUcsNwKRu/qrjmwe1/I99spM8q/MVj2nsHb/yfnDKG0O9PUqtUVGjpAX+llHDS6iNPSghBc=
X-Received: by 2002:a05:6000:430c:b0:3e0:4d29:80be with SMTP id
 ffacd0b85a97d-3e04d29815cmr2637642f8f.49.1756997929274; Thu, 04 Sep 2025
 07:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
In-Reply-To: <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 4 Sep 2025 16:58:38 +0200
X-Gm-Features: Ac12FXyGDcz59ifSydw05MuQg_P1V6YF0m9gsQ5VWAu0_B8ZIjHvT6en0L_OHZQ
Message-ID: <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>, snovitoll@gmail.com
Cc: glider@google.com, dvyukov@google.com, elver@google.com, 
	linux-mm@kvack.org, ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com, 
	akpm@linux-foundation.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, sj@kernel.org, 
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 10:11=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> > If so, would it help if we make the kasan.vmalloc command-line
> > parameter work with the non-HW_TAGS modes (and make it do the same
> > thing as disabling CONFIG_KASAN_VMALLOC)?
> >
> > What I don't like about introducing kasan=3Doff for non-HW_TAGS modes i=
s
> > that this parameter does not actually disable KASAN. It just
> > suppresses KASAN code for mapping proper shadow memory. But the
> > compiler-added instrumentation is still executing (and I suspect this
> > might break the inline instrumentation mode).
>
> I may not follow your saying it doesn't disable KASAN. In this patchset,
> not only do I disable the code for mapping shadow memory, but also I
> skip any KASAN checking. Please see change of check_region_inline() in
> mm/kasan/generic.c and kasan_check_range() in mm/kasan/sw_tags.c. It
> will skip any KASAN checking when accessing memory.
>
> Yeah, the compiler added instrumentation will be called, but the if
> (!kasan_enabled()) checking will decide if going further into KASAN code
> or just return directly.

This all is true for the outline instrumentation mode.

However, with the inline instrumentation, check_region_inline() is not
called (in many cases, at least) and instead the compiler embeds the
instructions to calculate the shadow memory address and check its
value directly (this is why we have CONFIG_KASAN_SHADOW_OFFSET, whose
value has to be known at compile time).

> I tried inline mode on x86_64 and arm64, it
> works well when one reviewer said inline mode could cost much more
> memory, I don't see any breakage w or w/o kasan=3Doff when this patchset
> applied..

This is interesting. I guess what happens is that we still have the
early shadow memory mapped so the shadow memory accesses inserted by
the inline instrumentation do not crash.

But have you tried running kasan=3Doff + CONFIG_KASAN_STACK=3Dy +
CONFIG_VMAP_STACK=3Dy (+ CONFIG_KASAN_VMALLOC=3Dy)? I would expect this
should causes crashes, as the early shadow is mapped as read-only and
the inline stack instrumentation will try writing into it (or do the
writes into the early shadow somehow get ignored?..).

> > Perhaps, we could instead add a new kasan.shadow=3Don/off parameter to
> > make it more explicit that KASAN is not off, it's just that it stops
> > mapping shadow memory.
>
> Hmm, as I explained at above, kasan=3Doff will stop mapping shadow memory=
,
> and also stop executing KASAN code to poison/unpoison memory and check th=
e
> shadow. It may be inappropriate to say it only stops mapping shadow.

That's true, but we can only achieve this for the outline instrumentation m=
ode.

With the inline instrumentation mode, the (early) shadow memory would
still get accessed all the time even with kasan=3Doff. Which can be
considered inappropriate, as you pointed out (though this is what
happens for vmalloc allocations when CONFIG_KASAN_VMALLOC is disabled
and it does seem to work; but the inline stack instrumentation might
be a problem).

We could limit kasan=3Doff to only the outline instrumentation mode, but
I guess that defeats the purpose.

I'm not completely opposed to making kasan=3Doff work with all KASAN
modes (assuming it works with the inline instrumentation), but then we
will need to thoroughly document the behavior it creates.

And let's also wait for an opinion from the other KASAN maintainers on this=
.

> > Dmitry, Alexander, Marco, do you have any opinion on kasan=3Doff for
> > non-HW_TAGS modes?
> >
> > On a side note, this series will need to be rebased onto Sabyrzhan's
> > patches [1] - those are close to being ready. But perhaps let's wait
> > for v7 first.
>
> I replied to Sabyrzhan's patchset, on top of this patchset, it's much
> easier and cleaner to remove kasan_arch_is_ready(). We don't need
> introduce CONFIG_ARCH_DEFER_KASAN. Please see below patchset which is
> based on this patchset introducing 'kasan=3Doff|on' to genric|sw_tags
> mode.

Based on a brief look, both patch series seem to be doing similar
things (except yours also allows using kasan=3Doff for all modes).

But I like the Sabyrzhan's approach of hiding the explicit
static_branch_enable() calls under CONFIG_ARCH_DEFER_KASAN for the
architectures where they are actually required.

So I propose we moved forward with the Sabyrzhan's series and then
apply additional patches for supporting kasan=3Doff on top (but again,
assuming they work with the inline instrumentation).

Thank you!

