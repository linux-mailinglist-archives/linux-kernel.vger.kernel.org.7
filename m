Return-Path: <linux-kernel+bounces-826734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3676B8F37D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785F316E406
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3103B2F0C50;
	Mon, 22 Sep 2025 07:06:45 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D112F0690
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758524804; cv=none; b=hpstChXUnhDSnJPzUocBYJdJWoFZ+3gRfOI7nV4XRZWbdjB9rxq10uRJj9P5OPIm3A5F14bPOxqZqgH1wsIYYDtDTSSQ/gLBT0Z6NvZ6d4cZO7BnvJFMUEJIj6NN10euhzj2WYTTc8DjQq7HgN6as+vNAAi45pzLGfJYKw+9chw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758524804; c=relaxed/simple;
	bh=wMF9oky7UmEQJ4boi4TyOd7REJFcUI4wE8M3KLv+D7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moh1lBHAfE9XnHqQ89FKODdpioEZNOfrAYly5t6bCwN7PmeY91/poAhXsY9QMWgBaa4Dxf8CN9tcKcRbF/Kk07cvIYb7K1qPm8G7pAUBocTtS4+W7PfaGSn/sBt42vu+M18y6M0hv+RfTQiCGEvpHcUZX/DSchr/iqVZlCgZb/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-892196f0471so1543073241.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758524802; x=1759129602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otSOcFmqfS8pvi0Xz9Z+1wbPbvnTdFmAW97wMweoytQ=;
        b=xEbqfraG2xOP/4ANx2E6GawdMN69qYwF73uoEKhwBXxnCeF/KCsh3pmVzjqb4y/TC+
         ynYCgOjjDLz5vxHsMm4zEWEkh4JGuyAYIbGzY2dn6tmeAZDFHXGh7jUM3UnBEHFcjDGT
         qq9rnYUFxzW9+CqAD328rjkMEXqYzVasNn1gs+31AFRh4ei56Mq41FTMoYU74pK/XoTO
         +QMMCu/nyqIip+3MEzl38Mqbjmz264rClbRmqGQoW16eKswCrY2lRm/UFouPgNuqAcLw
         jhmQ4gfdvsIcC+KziJ7HwQW3d+hpi2sVfWUk9koHsDTmjk5mytd13ihBy7+wSghSddfu
         YEgw==
X-Forwarded-Encrypted: i=1; AJvYcCVzxkCxyicjqdbaKDaTRlGnofqX3GXB91SJqnyHFGTO6TWkC2MNGwrpYCXYNpNweUrnxBxLoYSNKTK8i5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3VqrsO/asXyta9WXnwr+aEo53lXRrZuMuAzbc72w/Zn1hCUoi
	XJpxJTDKhJS4TNseqIWwdOXyDHK7LG+AoF4Q5zr9ZS9wind/ftK1MOmQACgzrPQA
X-Gm-Gg: ASbGncuFVPkce/vWl8VEmMXHPONDcjYvLk0h/C09YIjDjhaBAjd/IdoZ+WZCa0A6Wt1
	JoPvjt/5mi+l5hgclC/zklKVdNim+aF3rsX2pbJBgQghve5ikmxixuZoiwO/+Ou6ONfbrSGsq5H
	Vs+m6GKNGV1wFSGh14B3zdmhr249tHe21ZkEI8Bk9qdCKaTNsWtde377cZLy8W9A4GqeNUOolDg
	7WqYjoXszm29XyieDC8SpomHsXZq2LQiSiBq6303YwuBhm8PNHORC+ZfHhqo8qQcmsnTk18CwyZ
	QECCYk4ShNbRblVjs8L491hpJ67jffN30eAyJl8KBEibCDFYXbgWQFdAu1VBjVaIFgZxce2xpfI
	rVukgRo9gBo4lPKFoBGV1kCOBWnPFA1prwb5wCnzYUgLnErbFBWSyIwMWle0N
X-Google-Smtp-Source: AGHT+IG1I7RECVnbstsmech5BNVrV1vHBZZkYgfQ4f+HTfToOrbO1JdJICsVKttr18aEpd0I0bcIGQ==
X-Received: by 2002:a05:6122:caa:b0:544:9414:105f with SMTP id 71dfb90a1353d-54a837c5148mr3062241e0c.2.1758524801760;
        Mon, 22 Sep 2025 00:06:41 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a9d1cf721sm1005197e0c.7.2025.09.22.00.06.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 00:06:41 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-890190c7912so897133241.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:06:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAWpNCTK/E2H2XBvSCdrK3Et0zG9hGP5mVyGAwxrbajqFmVQe77UD+J8qC/TaOEjTBarDKYSRd2A/rUik=@vger.kernel.org
X-Received: by 2002:a05:6102:91c:b0:529:b446:1743 with SMTP id
 ada2fe7eead31-588e0e8a553mr3474082137.11.1758524801110; Mon, 22 Sep 2025
 00:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
In-Reply-To: <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Sep 2025 09:06:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
X-Gm-Features: AS18NWB31RoWEM5tCRYcbUAZXcSpEG_-VNOK-4sGk7R95MgJVOOdlhgttn5Zi70
Message-ID: <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
To: Finn Thain <fthain@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-m68k@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Finn,

On Sun, 14 Sept 2025 at 02:59, Finn Thain <fthain@linux-m68k.org> wrote:
> Some recent commits incorrectly assumed 4-byte alignment of locks.
> That assumption fails on Linux/m68k (and, interestingly, would have
> failed on Linux/cris also). Specify the minimum alignment of atomic
> variables for fewer surprises and (hopefully) better performance.
>
> Consistent with i386, atomic64_t is not given natural alignment here.
>
> Cc: Lance Yang <lance.yang@linux.dev>
> Link: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fx=
zr8_g58Rc1_0g@mail.gmail.com/

Thanks for your patch!

> --- a/include/asm-generic/atomic64.h
> +++ b/include/asm-generic/atomic64.h
> @@ -10,7 +10,7 @@
>  #include <linux/types.h>
>
>  typedef struct {
> -       s64 counter;
> +       s64 counter __aligned(sizeof(long));
>  } atomic64_t;
>
>  #define ATOMIC64_INIT(i)       { (i) }
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 6dfdb8e8e4c3..cd5b2b0f4b02 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -179,7 +179,7 @@ typedef phys_addr_t resource_size_t;
>  typedef unsigned long irq_hw_number_t;
>
>  typedef struct {
> -       int counter;
> +       int counter __aligned(sizeof(int));
>  } atomic_t;
>
>  #define ATOMIC_INIT(i) { (i) }

This triggers a failure in kernel/bpf/rqspinlock.c:

kernel/bpf/rqspinlock.c: In function =E2=80=98bpf_res_spin_lock=E2=80=99:
include/linux/compiler_types.h:572:45: error: call to
=E2=80=98__compiletime_assert_397=E2=80=99 declared with attribute error: B=
UILD_BUG_ON
failed: __alignof__(rqspinlock_t) !=3D __alignof__(struct
bpf_res_spin_lock)
  572 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |                                             ^
include/linux/compiler_types.h:553:25: note: in definition of macro
=E2=80=98__compiletime_assert=E2=80=99
  553 |                         prefix ## suffix();
         \
      |                         ^~~~~~
include/linux/compiler_types.h:572:9: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  572 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg=
)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:9: note: in expansion of macro =E2=80=98BUILD_=
BUG_ON_MSG=E2=80=99
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condit=
ion)
      |         ^~~~~~~~~~~~~~~~
kernel/bpf/rqspinlock.c:695:9: note: in expansion of macro =E2=80=98BUILD_B=
UG_ON=E2=80=99
  695 |         BUILD_BUG_ON(__alignof__(rqspinlock_t) !=3D
__alignof__(struct bpf_res_spin_lock));
      |         ^~~~~~~~~~~~

I haven't investigated it yet.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

