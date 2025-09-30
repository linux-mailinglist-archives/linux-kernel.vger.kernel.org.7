Return-Path: <linux-kernel+bounces-837286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76B5BABDDE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13EEB7A451E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217D729E116;
	Tue, 30 Sep 2025 07:41:43 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB31E3769
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218102; cv=none; b=cCWLIBkqaWgMZgdgJ8LukGe4j+gPznfYCr4zsfV+wDluYE3cVIHnC4x4RIAvVWOqKV29x034MrjhAuaNE02eHI8u2mixsNBJ0f2dPqBcVCMYfYk+oqT8hUcuAdmTIFN7ZAXaQj1zr3H4bqDU2NNy51fCD/kdBi3pGCxo0+byCho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218102; c=relaxed/simple;
	bh=fTwHavaF1SCVZfuafGtVN+0vomY8dJ9l2Z2f28ZmrAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AO9yOLxkRueHGiSyBilG+oPSjP/TGpQBYb3FZ6ZZCUbo0YombhlRSSXyU1fH087TG4nNpt4WpOXgnv9fXgnys0bvZ/o/Eh4UpMkK1giE8MvC6UsrUcXMs/p5Di/90S1IuJjtFX7mK7JeYutqfVcXUrqjEEgNX2SnwqtZLMb3dOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8e8163d94bbso3637130241.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218099; x=1759822899;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+5g3R4BFoKeU12X4z++S/cR17tgT9XO68T2ERc1SG0=;
        b=m19lvO6pQv5dJWy/7jwYrbaakcipCCBoRfqTfF16UqNKckotZ5mOpT6TDdx5w6oSqG
         iWvLTf2Hh0pnc+eCNfviYmePv2ZvDjBJP5rOaTRurliJvsIA2BSXmAcdBsXLpzif9Rl5
         rZmeVmMnLH+oyExrJ1TaBMvb2jaAQZHv3vd53tfFVT8G01vSruMvsoID+waWyXWNEXJN
         ldfHryD850dkvD6LJX9ARNRLrk8ykd2jpuaJuqmRPElIYwS/X5+he+KyW/A/3yZUSdgz
         dYKywQswWiyzIe8tEMllp44ylGUv6MlbG1kp7K6k11MJLTdnrZOyM+JbzO5UEWS5Ou6M
         67wA==
X-Forwarded-Encrypted: i=1; AJvYcCUMtEm2xVFgL928SZYrRASV/6E0nhKm1yutd2ynENgVrZaChC/+ImMEY++toD2jw9OrhDQC5rOd1FDSBao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX0n+bCyFsYg0/0q8hfdeuOBMCx5WTfXJcMIWbr14mp+t5nYr7
	XIHMV3GAYuriOF2W9JL7NApUjMon3b8eGXNfDPgvGr672hZVlXCsku3qHwa9yxdW
X-Gm-Gg: ASbGncuj1r71KeZmczbPvejHC8fND0QnGuNq9Q9nM6lY34JZx3O+MFaAxgDpvpJ6eIN
	5jvZWGawkoZtlCwNXumg6MuWa9vaDZUjlkdDsnmZRRVo9J4zBLDhLvnkw/AbaP0VR5m8lsH8feh
	cS/m2MYENjOxwsDWkDr2NKzHEFW3t6nNnVqb1dXsYTiILF86daPpGlYDk8bOs4zD+tE8cUUE+xE
	Tuu5OOr5QnUWMp/mPI9FwGx5jbjwX/IVLc/8m4KjUSzfS1y1hF+vuEAmgM1V3nbYhYaY3Ba2iRd
	NKu9tpsE6hoOkEObKevEI9iDk5MOff7Cge5ancB//279fu8TQbilxYMXTWeLjHgFK91FWUit5Gp
	AE9m+vhQSSI4h6XuNXLEpzQHfLo0sTYN3qI/RtTn/pmi0SnlMddPv86duUr4JZsZNAsicEqy3Yg
	dqa16hw88VH9OFLU0UaZc=
X-Google-Smtp-Source: AGHT+IEpWqSO640lCUvyTOqFn+sP+xtuLTdGqMwCtOuKePZGFM9tr2oibk0NzhHs2OA2dNagu346Og==
X-Received: by 2002:a05:6122:17a9:b0:54b:bf4d:558b with SMTP id 71dfb90a1353d-54bea1d8178mr8022376e0c.10.1759218099430;
        Tue, 30 Sep 2025 00:41:39 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-916d2948cb7sm2880374241.9.2025.09.30.00.41.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 00:41:38 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8e8163d94bbso3637113241.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:41:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNMsvDc0cqewhxfoLCvqMuK5hWI4aZBAS8zb8AQgUksi8f1QWL7DtOkD6y0OqgS6vLF/aAbRsmHhnZow8=@vger.kernel.org
X-Received: by 2002:a05:6102:50a0:b0:59c:93df:4fe with SMTP id
 ada2fe7eead31-5acc8e96fdfmr7499750137.9.1759218097979; Tue, 30 Sep 2025
 00:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
 <CAMuHMdUgkVYyUvc85_P9TyTM5f-=mC=+X=vtCWN45EMPqF7iMg@mail.gmail.com>
 <6c295a4e-4d18-a004-5db8-db2e57afc957@linux-m68k.org> <57ac401b-222b-4c85-b719-9e671a4617cf@app.fastmail.com>
 <86be5cf0-065e-d55d-fdb6-b9cf6655165e@linux-m68k.org> <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org>
In-Reply-To: <ec2982e3-2996-918e-f406-32f67a0decfe@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Sep 2025 09:41:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV1eGkq_kOPTGbfDt4E2V5zCTdYc_BGJg-56-ZUS353YQ@mail.gmail.com>
X-Gm-Features: AS18NWAfx6HdJiP6HG3pvvDkgqXmfVsm3y8cTCSy1KPMOu0E9WrRTl3w7eUQ96A
Message-ID: <CAMuHMdV1eGkq_kOPTGbfDt4E2V5zCTdYc_BGJg-56-ZUS353YQ@mail.gmail.com>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
To: Finn Thain <fthain@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-m68k@vger.kernel.org, 
	Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

On Tue, 30 Sept 2025 at 04:18, Finn Thain <fthain@linux-m68k.org> wrote:
> On Tue, 23 Sep 2025, I wrote:
> > ... there's still some kmem cache or other allocator somewhere that has
> > produced some misaligned path and dentry structures. So we get
> > misaligned atomics somewhere in the VFS and TTY layers. I was unable to
> > find those allocations.
>
> It turned out that the problem wasn't dynamic allocations, it was a local
> variable in the core locking code (kernel/locking/rwsem.c): a misaligned
> long used with an atomic operation (cmpxchg). To get natural alignment for
> 64-bit quantities, I had to align other local variables as well, such as
> the one in ktime_get_real_ts64_mg() that's used with
> atomic64_try_cmpxchg(). The atomic_t branch in my github repo has the
> patches I wrote for that.

So cmpxchg() and friends should not take a volatile void *, but (new)
properly-aligned types, using the new _Generic()?

> To silence the misalignment WARN from CONFIG_DEBUG_ATOMIC, for 64-bit
> atomic operations, for my small m68k .config, it was also necesary to
> increase ARCH_SLAB_MINALIGN to 8. However, I'm not advocating a

Probably ARCH_SLAB_MINALIGN should be 4 on m68k.  Somehow I thought
that was already the case, but it is __alignof__(unsigned long long) = 2.

> ARCH_SLAB_MINALIGN increase, as that wastes memory. I think it might be
> more useful to limit the alignment test for CONFIG_DEBUG_ATOMIC, as
> follows.

Did you check what would be the actual impact of increasing it to 4 or 8?

> --- a/include/linux/instrumented.h
> +++ b/include/linux/instrumented.h
> @@ -68,7 +68,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
>  {
>         kasan_check_read(v, size);
>         kcsan_check_atomic_read(v, size);
> -       WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1)));
> +       WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & (size - 1) & 3));

I'd make that an arch-overridable define instead of hardcoded 3.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

